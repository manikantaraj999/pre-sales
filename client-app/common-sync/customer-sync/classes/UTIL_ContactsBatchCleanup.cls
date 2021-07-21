public with sharing class UTIL_ContactsBatchCleanup
    implements Database.Batchable<SObject>, Database.Stateful
{
    // Cleanup process for UTIL_ContactsSync_Batch();

    // jobInfo contains debug information persisted across contexts since start(),
    //   execute(), and finish() all run in separate contexts with separate debug logs
    private List<String> jobInfo = new List<String>();
    private List<SObject> errors = new List<SObject>();

    private static String ObjectType = 'Contact';
    private static String BatchClassName = 'UTIL_ContactsBatchCleanup';

    @testVisible
    private static List<UTIL_SyncHelper.CleanupObject> CleanupObjectList = new List<UTIL_SyncHelper.CleanupObject> {
        new UTIL_SyncHelper.CleanupObject('Account', UTIL_SFAccount.CustomerFieldName, null,
            new List<UTIL_SyncHelper.CleanupField> {
                new UTIL_SyncHelper.CleanupField(UTIL_SFContact.ContactCustomerFieldName, 'AccountId')
            }
        )
    };

    // start()
    //
    // Start the batch job
    public Database.QueryLocator start(Database.BatchableContext context)
    {
        System.debug(BatchClassName + ' ' + context.getJobId() + ' start');

        try
        {
            String query = buildQueryString();
            System.debug(BatchClassName + ' query='+query);
            return Database.getQueryLocator(query);
        }
        catch(Exception ex)
        {
            System.debug('Failed querying ' + ObjectType + 's: ' + ex.getMessage());
        }

        // Returning null causes "System.UnexpectedException: Start did not return a valid iterable object."
        // So to NOOP we must return a query that will always give 0 results. Id should never be
        // null in any table so we can arbitrarily pick Contact.
        return Database.getQueryLocator('SELECT Id FROM '+ ObjectType + ' WHERE Id = null');
    }

    // execute()
    //
    // Execute the batch job
    public void execute(Database.BatchableContext context, List<SObject> sObjectList)
    {
        System.debug(BatchClassName + ' ' + context.getJobId() + ' execute');
        UTIL_SyncHelper.printJobInfo(this.jobInfo);

        Map<String, SObject> updatedSObjectsMap = new Map<String, SObject>();

        Integer soTot = sObjectList.size();
        if (soTot > 0)
        {
            Integer coTot = CleanupObjectList.size();
            for (Integer coCnt = 0 ; coCnt < coTot ; coCnt++)
            {
                UTIL_SyncHelper.CleanupObject cleanupObject = CleanupObjectList[coCnt];
                Integer cfTot = cleanupObject.cleanupFieldList.size();
                for (Integer cfCnt = 0 ; cfCnt < cfTot ; cfCnt++)
                {
                    UTIL_SyncHelper.CleanupField cleanupField = cleanupObject.cleanupFieldList[cfCnt];
                    for (Integer soCnt = 0 ; soCnt < soTot ; soCnt++)
                    {
                        SObject sObj = sObjectList[soCnt];
                        String objectId = (String) sObj.get(cleanupField.objectId);
                        Boolean isLinkMissing = objectId == null || objectId == cleanupObject.notFoundId;
                        String key = (String) sObj.get(cleanupField.key);
                        key = key != null ? key.replaceFirst('^0+(?!$)', '') : '';
                        if (String.isNotBlank(key) && isLinkMissing)
                        {
                            cleanupObject.sapKeyNumbers.add(key);
                        }
                    }
                }
            }

            for (Integer coCnt = 0 ; coCnt < coTot ; coCnt++)
            {
                UTIL_SyncHelper.CleanupObject cleanupObject = CleanupObjectList[coCnt];
                if (cleanupObject.sapKeyNumbers.size() > 0)
                {
                    Map<String, SObject> cleanupSObjectMap = 
                        UTIL_SyncHelper.createSObjectMap(cleanupObject);

                    Integer cfTot = cleanupObject.cleanupFieldList.size();
                    for (Integer cfCnt = 0 ; cfCnt < cfTot ; cfCnt++)
                    {
                        UTIL_SyncHelper.CleanupField cleanupField = cleanupObject.cleanupFieldList[cfCnt];
                        for (Integer soCnt = 0 ; soCnt < soTot ; soCnt++)
                        {
                            SObject sObj = sObjectList[soCnt];
                            String objectId = (String) sObj.get(cleanupField.objectId);
                            Boolean isLinkMissing = objectId == null || objectId == cleanupObject.notFoundId;
                            String key = (String) sObj.get(cleanupField.key);
                            key = key != null ? key.replaceFirst('^0+(?!$)', '') : '';
                            if (String.isNotBlank(key) && isLinkMissing)
                            {
                                if (cleanupSObjectMap.containsKey(key))
                                {
                                    SObject cleanupObj = cleanupSObjectMap.get(key);
                                    sObj.put(cleanupField.objectId, cleanupObj.Id);
                                    updatedSObjectsMap.put(sObj.Id, sObj);
                                }
                            }
                        }
                    }
                }
            }

            UTIL_SyncHelper.insertUpdateResults(ObjectType, 'Update', null, null, updatedSObjectsMap.values(), BatchClassName, null);
        }
    }

    // finish()
    //
    // Finish the batch job
    public void finish(Database.BatchableContext context)
    {
        System.debug(BatchClassName + ' ' + context.getJobId() + ' finish');
        UTIL_SyncHelper.printJobInfo(this.jobInfo);
    }

    // buildQueryString
    //
    // Build the query String
    private static String buildQueryString()
    {
        String query = 'SELECT Id';
        String whereQuery = null;
        Integer coTot = CleanupObjectList.size();
        for (Integer coCnt = 0 ; coCnt < coTot ; coCnt++)
        {
            UTIL_SyncHelper.CleanupObject cleanupObject = CleanupObjectList[coCnt];
            Integer cfTot = cleanupObject.cleanupFieldList.size();
            for (Integer cfCnt = 0 ; cfCnt < cfTot ; cfCnt++)
            {
                UTIL_SyncHelper.CleanupField cleanupField = cleanupObject.cleanupFieldList[cfCnt];
                query += ', ' + cleanupField.key + ', ' + cleanupField.objectId;
                whereQuery = whereQuery == null ? '' : whereQuery + ' OR ';
                whereQuery += '(' + cleanupField.key + ' != null AND (' + cleanupField.objectId + ' = null';
                if (String.isNotEmpty(cleanupObject.notFoundId))
                {
                    whereQuery += ' OR ' + cleanupField.objectId + ' = \'' + cleanupObject.notFoundId + '\'';
                }
                whereQuery += '))';
            }
        }
        return query + ' FROM ' + ObjectType + ' WHERE ' + whereQuery;
    }

    public static Integer getTotalRecordCount () 
    {
        return getRecordCount();
    }

    private static Integer getRecordCount() 
    {
        new ensxsdk.Logger(null);
        String query = buildQueryString();
        List<SObject> objectList = Database.query(query);

        System.debug(objectList.size());

        return objectList.size();
    }
}