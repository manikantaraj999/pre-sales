public with sharing class UTIL_ContactSyncBatch
    implements Database.Batchable<Object>,
    Database.AllowsCallouts,
    Database.Stateful,
    I_ParameterizedSync
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_ContactSyncBatch.class);
    public void logCallouts(String location)
    {
        if ((Boolean)UTIL_AppSettings.getValue(BatchClassName.subString(5), 'Logging', false))
        {
            logger.enterVfpConstructor(location, null);
        }
    }

    // jobInfo contains debug information persisted across contexts since start(),
    // execute(), and finish() all run in separate contexts with separate debug logs
    private List<String> jobInfo = new List<String>();
    
    // In this case, we will store the largest change date/time as the param
    private UTIL_SyncHelper.LastSync fromLastSync = new UTIL_SyncHelper.LastSync();
    private static String ObjectType = 'Contact';

    @TestVisible
    private static String SFSyncKeyField = UTIL_SFContact.ContactFieldName;
    @TestVisible
    private static String BatchClassName = 'UTIL_ContactSyncBatch';
    private static String ScheduleClassName = 'UTIL_ContactSyncSchedule';

    /* I_ParameterizedSync methods - setBatchParam() */
    public void setBatchParam(Object value)
    {
        this.fromLastSync = (UTIL_SyncHelper.LastSync) value;
    }
    /* end I_ParameterizedSync methods */

    /* Database.Batchable methods start(), execute(), and finish() */
    // start()
    //
    // Calls SBO and returns search results of update customers
    public List<Object> start(Database.BatchableContext context)
    {
        logCallouts(BatchClassName + '.start');
        System.debug(context.getJobId() + ' started');

        SBO_EnosixContactSync_Search sbo = new SBO_EnosixContactSync_Search();

        this.fromLastSync = UTIL_SyncHelper.getLastSyncFromTable(
            ScheduleClassName,
            this.fromLastSync);

        this.fromLastSync.pageNumber = this.fromLastSync.pageNumber + 1;

        if (this.fromLastSync.retryCnt == -1)
        {
            UTIL_SyncHelper.resetPage(this.fromLastSync, (Integer) UTIL_AppSettings.getValue(
                BatchClassName.subString(5), 'SAPPageSize',
                9999));
        }

        SBO_EnosixContactSync_Search.EnosixContactSync_SC searchContext = buildSearchContext(this.fromLastSync);

        this.jobInfo.add('fromLastSync:' + this.fromLastSync.toString());
        System.debug('fromLastSync:' + this.fromLastSync.toString());

        // Execute the search
        SBO_EnosixContactSync_Search.EnosixContactSync_SR result;
        try
        {
            sbo.search(searchContext);
            result = searchContext.result;
        }
        catch (Exception ex)
        {
            return UTIL_SyncHelper.checkRetry(this.fromLastSync, ex, this.jobInfo);
        }

        // Write any response messages to the debug log
        String errorMessage = UTIL_SyncHelper.buildErrorMessage(BatchClassName, result.getMessages());

        if (!result.isSuccess())
        {
            return UTIL_SyncHelper.checkRetry(this.fromLastSync, new UTIL_SyncHelper.SyncException(errorMessage), this.jobInfo);
        }

        List<Object> searchResults = result.getResults();
        System.debug('Result size: ' + searchResults.size());

        // let finish() know to queue up another instance
        this.fromLastSync.isAnotherBatchNeeded = searchResults.size() > 0;
        this.fromLastSync.retryCnt = -1;

        this.jobInfo.add('searchResultsSize:' + searchResults.size());
        this.jobInfo.add('fromLastSync:' + this.fromLastSync.toString());

        return searchResults;
    }

    private static SBO_EnosixContactSync_Search.EnosixContactSync_SC buildSearchContext (UTIL_SyncHelper.LastSync fromLastSync)
    {
        SBO_EnosixContactSync_Search.EnosixContactSync_SC searchContext = new SBO_EnosixContactSync_Search.EnosixContactSync_SC();
        if (fromLastSync.lastSyncDate != null)
        {
            searchContext.SEARCHPARAMS.DateFrom = fromLastSync.lastSyncDate;
        }
        else searchContext.SEARCHPARAMS.InitialLoad = true;

        searchContext.pagingOptions.pageSize = fromLastSync.pageSize;
        searchContext.pagingOptions.pageNumber = fromLastSync.pageNumber;

        return searchContext;
    }

    // execute()
    //
    // Given the updated search results, does the work of updating the object table.
    public void execute(
        Database.BatchableContext context,
        List<Object> searchResults)
    {
        logCallouts(BatchClassName + '.execute');
        System.debug(context.getJobId() + ' executing');

        if (null == searchResults || 0 == searchResults.size()) return;

        List<SObject> errors = new List<SObject>();
        Map<String, Object> searchResultMap = createObjectKeyMap(searchResults);

        // First, update matching existing objects
        List<SObject> currentObjectList = UTIL_SyncHelper.getCurrentObjects(
            ObjectType,
            SFSyncKeyField,
            searchResultMap.keySet());
        Map<String, SObject> currentObjectMap = new Map<String, SObject>();
        Integer coTot = currentObjectList.size();
        for (Integer coCnt = 0 ; coCnt < coTot ; coCnt++)
        {
            SObject currentObject = currentObjectList[coCnt];
            currentObjectMap.put((String) currentObject.get(SFSyncKeyField),currentObject);
        }

        Map<String, SObject> updateObjectMap = updateExistingObjects(
            searchResultMap,
            currentObjectMap,
            errors);

        Map<String, SObject> insertObjectMap = createNewObjects(
            searchResultMap,
            currentObjectMap,
            errors);

        Set<String> savedIdSet = new Set<String>();

        UTIL_SyncHelper.insertUpdateResults(ObjectType, 'Update', errors, savedIdSet, updateObjectMap.values(), BatchClassName, SFSyncKeyField);
        UTIL_SyncHelper.insertUpdateResults(ObjectType, 'Insert', errors, savedIdSet, insertObjectMap.values(), BatchClassName, SFSyncKeyField);
        UTIL_SyncHelper.insertUpdateResults('Error', 'Insert', errors, savedIdSet, errors, BatchClassName, null);
    }

    // finish()
    //
    // queues up another batch when isAnotherBatchNeeded is true
    public void finish(Database.BatchableContext context)
    {
        logCallouts(BatchClassName + '.finish');
        System.debug(context.getJobId() + ' finished');
        UTIL_SyncHelper.printJobInfo(this.jobInfo);
        if (this.fromLastSync.retryCnt >= 0)
        {
            System.debug('Retry=' + this.fromLastSync.retryCnt + ' ' + System.Now());
        }

        UTIL_SyncHelper.launchAnotherBatchIfNeeded(
            this.fromLastSync.isAnotherBatchNeeded, ScheduleClassName, this.fromLastSync);

        if (!this.fromLastSync.isAnotherBatchNeeded) Database.executeBatch(new UTIL_ContactsBatchCleanup());
    }

    // getSboResult()
    //
    // Get the SBO SearchResult
    private SBO_EnosixContactSync_Search.SEARCHRESULT getSboResult(Object searchResult)
    {
        return (SBO_EnosixContactSync_Search.SEARCHRESULT) searchResult;
    }

    // createObjectKeyMap()
    //
    // create map of objecy key / search result.
    private Map<String, Object> createObjectKeyMap(
        List<Object> searchResults)
    {
        Map<String, Object> result =
            new Map<String, Object>();

        Integer srTot = searchResults.size();
        for (Integer srCnt = 0 ; srCnt < srTot ; srCnt++)
        {
            Object searchResult = searchResults[srCnt];
            String key = getSboKey(searchResult);
            if (String.isNotEmpty(key))
            {
                result.put(key, searchResult);
            }
        }

        return result;
    }

    private Map<String, SObject> updateExistingObjects(
        Map<String, Object> searchResultMap,
        Map<String, SObject> currentObjectMap,
        List<SObject> errors)
    {
        Map<String, SObject> updateObjectMap = new Map<String, SObject>();

        List<Object> srList = searchResultMap.values();
        Integer srTot = srList.size();
        for (Integer srCnt = 0 ; srCnt < srTot ; srCnt++)
        {
            Object searchResult = srList[srCnt];
            String currentSboKey = getSboKey(searchResult);
            if (currentObjectMap.containsKey(currentSboKey))
            {
                SObject currentObject = currentObjectMap.get(currentSboKey);

                // Updates fields and adds to objectList list for later commit
                syncObject(
                    currentObject,
                    searchResult,
                    updateObjectMap,
                    errors);
            }
        }

        System.debug('Existing Object Size: ' + updateObjectMap.size());

        return updateObjectMap;
    }

    private Map<String, SObject> createNewObjects(
        Map<String, Object> searchResultMap,
        Map<String, SObject> currentObjectMap,
        List<SObject> errors)
    {
        Map<String, SObject> insertObjectMap = new Map<String, SObject>();

        List<Object> srList = searchResultMap.values();
        Integer srTot = srList.size();
        for (Integer srCnt = 0 ; srCnt < srTot ; srCnt++)
        {
            Object searchResult = srList[srCnt];
            if (!currentObjectMap.containsKey(getSboKey(searchResult)))
            {
                syncObject(
                    null,
                    searchResult,
                    insertObjectMap,
                    errors);
            }
        }

        System.debug('New Object Size: ' + insertObjectMap.size());

        return insertObjectMap;
    }

    private void syncObject(
        SObject currentObject,
        Object searchResult,
        Map<String, SObject> objectMap,
        List<SObject> errors)
    {
        SBO_EnosixContactSync_Search.SEARCHRESULT sboResult = getSboResult(searchResult);
        if (currentObject == null)
        {
            currentObject = new Contact();
        }
        Contact obj = (Contact) currentObject;
        String key = getSboKey(searchResult);
        obj.put(SFSyncKeyField, key);
        obj.LastName = sboResult.Name2;
        if (String.isEmpty(obj.LastName))
        {
            System.debug(BatchClassName + ' ' + ObjectType + ' Last Name missing from Key ' + key);
            UTIL_SyncHelper.addLog(errors, 'ERROR', key, Json.serialize(obj), BatchClassName + ' ' + ObjectType + ' Last Name missing from Key ' + key);
            return;
        }
        obj.FirstName = sboResult.Name;
        obj.Phone = sboResult.TelephoneNumber;
        obj.Fax = sboResult.FaxNumber;
        obj.Email = sboResult.Email;
        obj.Department = sboResult.Department;
        obj.MobilePhone = sboResult.MobileNumber;
        obj.Title = sboResult.Title;
        obj.Salutation = sboResult.Salutation;
        if (String.isNotEmpty(sboResult.CustomerNumber))
        {
            obj.put(UTIL_SFContact.ContactCustomerFieldName, sboResult.CustomerNumber.replaceFirst('^0+(?!$)', ''));
        }
        objectMap.put(key, obj);
    }

    private String getSboKey(Object searchResult)
    {
        SBO_EnosixContactSync_Search.SEARCHRESULT sboResult = getSboResult(searchResult);
        return sboResult == null ? '' : sboResult.ContactPersonNumber.replaceFirst('^0+(?!$)', '');
    }

    public static Integer getTotalRecordCount () 
    {
        return getRecordCount(true);
    }

    public static Integer getNextIncrementalRecordCount () 
    {
        return getRecordCount(false);
    }

    private static Integer getRecordCount(Boolean totalRecCount) 
    {
        new ensxsdk.Logger(null);
        UTIL_SyncHelper.LastSync fromLastSync = new UTIL_SyncHelper.LastSync();
        if (!totalRecCount)
        {
            fromLastSync = UTIL_SyncHelper.getLastSyncFromTable(ScheduleClassName, fromLastSync);
        }
        fromLastSync.pageSize = 1;
        fromLastSync.pageNumber = 1;

        SBO_EnosixContactSync_Search.EnosixContactSync_SC searchContext = buildSearchContext(fromLastSync);
        SBO_EnosixContactSync_Search sbo = new SBO_EnosixContactSync_Search();
        sbo.search(searchContext);
        System.debug(searchContext.result.isSuccess());
        System.debug(searchContext.pagingOptions.totalRecords);

        return searchContext.pagingOptions.totalRecords;
    }
}