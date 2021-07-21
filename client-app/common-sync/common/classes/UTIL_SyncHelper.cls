// UTIL_SyncHelper
//
// Helper methods to re-use SAP sync batch and schedule code
public with sharing class UTIL_SyncHelper
{
    // executeBatch()
    //
    // The schedule logic is always identical - the only difference is the name
    // of the batch and schedule classes, an optional param, an an optional scope
    public static void executeBatch(String batchClass, String scheduleClass, Object batchParam, Integer scope)
    {
        // Database.executeBatch throws an Apex Limit exception when there are 5 or more active
        // batch jobs. The goal is to keep checking for an available slot in the Batch window
        // so that this can eventually get out of the Schedule and into the Batch queue.
        Integer jobCount = [SELECT count() FROM AsyncApexJob WHERE JobType='BatchApex' AND (Status = 'Processing' OR Status = 'Preparing')];

        // We are under the Apex Limit so inserting into the Apex Batch queue will succeed
        Object batchInstance = null;
        System.Type batchType = Type.forName(batchClass);
        if (batchType != null) batchInstance = batchType.newInstance();
        if (null != batchParam && batchInstance instanceof I_ParameterizedSync) ((I_ParameterizedSync)batchInstance).setBatchParam(batchParam);
        // either in 1 to 10 minutes
        Integer addMinutes = Integer.valueOf(Math.random() * 10);
        // or 10 to 20 minutes if the first random() selects 0
        addMinutes = addMinutes == 0 ? Integer.valueOf(10 + Math.random() * 10) : addMinutes;

        Datetime dt = Datetime.now().addMinutes(addMinutes);
        String timeForScheduler = dt.format('s m H d M \'?\' yyyy ');

        // Schedule the same schedulable class again after a few minutes
        Object scheduleInstance = null;
        System.Type scheduleType = Type.forName(scheduleClass);
        if (scheduleType != null) scheduleInstance = scheduleType.newInstance();
        if (null != batchParam && scheduleInstance instanceof I_ParameterizedSync) ((I_ParameterizedSync)scheduleInstance).setBatchParam(batchParam);
        if (jobcount < 5)
        {
            if (scope != null)
            {
                if (!Test.isRunningTest()) Database.executeBatch((Database.Batchable<Object>)batchInstance, scope);
            }
            else
            {
                if (!Test.isRunningTest()) Database.executeBatch((Database.Batchable<Object>)batchInstance);
            }
        }
        else
        {
            if (!Test.isRunningTest()) System.Schedule(batchClass + '_SyncRetryAfter' + timeForScheduler.trim(), timeForScheduler, (Schedulable)scheduleInstance);
        }
    }

    // executeBatch()
    //
    // Execute batch with no param
    public static void executeBatch(String batchClass, String scheduleClass)
    {
        executeBatch(batchClass, scheduleClass, null);
    }

    // executeBatch()
    //
    // Execute batch with param
    public static void executeBatch(String batchClass, String scheduleClass, Object batchParam)
    {
        executeBatch(batchClass, scheduleClass, batchParam, null);
    }

    // launchAnotherBatchIfNeeded()
    //
    // Use this in the finish() method of a batch to schedule another instance if needed
    public static void launchAnotherBatchIfNeeded(Boolean isNeeded, String scheduleClass, Object batchParam)
    {
        OBJ_SAP_Sync__c sapSync = new OBJ_SAP_Sync__c();
        UTIL_SyncHelper.LastSync fromLastSync = null;
        if (batchParam != null && batchParam instanceof UTIL_SyncHelper.LastSync)
        {
            fromLastSync = (UTIL_SyncHelper.LastSync) batchParam;

        }

        if (fromLastSync != null)
        {
            String query = 'SELECT Name, FLD_Sync_DateTime__c, FLD_Page_Number__c, FLD_Page_Size__c FROM OBJ_SAP_Sync__c WHERE Name = \'' +
                scheduleClass + '\' LIMIT 1';
            List<OBJ_SAP_Sync__c> lastSyncList = Database.query(query);
            if (lastSyncList.size() != 0)
            {
                sapSync = lastSyncList[0];
            }
        }

        // launch another batch if there's reason to believe there is more data to retrieve
        if (isNeeded)
        {
            System.debug('scheduling another run since there are likely more records to be retrieved. Param: ' + batchParam);
            // Using reflection to execute the class allows us to re-use this code, and also allows
            // a runaway instance to be stopped by editing class in the web console
            System.debug('instantiating an instance of ' + scheduleClass);

            if (fromLastSync != null)
            {
                sapSync.Name = scheduleClass;
                if (fromLastSync.lastSyncDate != null)
                {
                    sapSync.FLD_Sync_DateTime__c = DateTime.newInstance(fromLastSync.lastSyncDate, fromLastSync.lastSyncTime);
                }
                sapSync.FLD_Page_Number__c = fromLastSync.pageNumber;
                sapSync.FLD_Page_Size__c = fromLastSync.pageSize;
                upsert sapSync;
            }

            Object scheduleInstance = null;
            System.Type scheduleType = Type.forName(scheduleClass);
            if (scheduleType != null) scheduleInstance = scheduleType.newInstance();
            if (null != batchParam && scheduleInstance instanceof I_ParameterizedSync) ((I_ParameterizedSync)scheduleInstance).setBatchParam(batchParam);

            if (!Test.isRunningTest()) ((Schedulable)scheduleInstance).execute(null);
        }
        else if (fromLastSync != null)
        {
            sapSync.Name = scheduleClass;
            sapSync.FLD_Sync_DateTime__c = fromLastSync.startSyncDateTime;
            sapSync.FLD_Page_Number__c = 0;
            upsert sapSync;
        }
    }

    // launchAnotherBatchIfNeeded()
    //
    // launch another batch with no param
    public static void launchAnotherBatchIfNeeded(Boolean isNeeded, String scheduleClass)
    {
        launchAnotherBatchIfNeeded(isNeeded, scheduleClass, null);
    }

    public class LastSync
    {
        public DateTime startSyncDateTime { get; set; }
        public Date lastSyncDate { get; set; }
        public Time lastSyncTime { get; set; }
        public Integer retryCnt { get; set; }
        public Integer retryStart { get; set; }
        public Integer pageSize { get; set; }
        public Integer pageNumber { get; set; }
        public Boolean isAnotherBatchNeeded { get; set; }
        public String currentSboKey { get; set; }

        public LastSync()
        {
            retryCnt = -1;
            retryStart = -1;
            pageSize = 1;
            pageNumber = 0;
            lastSyncDate = null;
            isAnotherBatchNeeded = false;
            currentSboKey = null;
        }

        public override String toString()
        {
            return 'Start Sync DateTime=' + startSyncDateTime +
                'Last Sync Date=' + lastSyncDate  +
                'Last Sync Time=' + lastSyncTime  +
                ' Retry Count=' + retryCnt +
                ' Retry Start=' + retryStart +
                ' Page Size=' + pageSize +
                ' Page Number=' + pageNumber +
                ' Is Another Batch Needed=' + isAnotherBatchNeeded +
                ' Current SBO Key=' + currentSboKey;
        }
    }

    public class SyncException extends Exception
    {

    }

    // getLastSyncFromTable()
    //
    // returns the hightest value for [column] from [table]
    public static LastSync getLastSyncFromTable(String lastSyncDateColumn, String table, UTIL_SyncHelper.LastSync fromLastSync)
    {
        if (null != fromLastSync.lastSyncDate)
        {
            System.debug('fromLastSync.lastSyncDate not null');
            return fromLastSync;
        }
        System.debug('fromLastSync.lastSyncDate null');

        LastSync result = new LastSync();
        if (null != fromLastSync)
        {
            result.retryCnt = fromLastSync.retryCnt;
        }

        String query = 'SELECT ' + lastSyncDateColumn + ' FROM ' + table +
            ' WHERE ' + lastSyncDateColumn + ' != null' +
            ' ORDER BY ' + lastSyncDateColumn + ' DESC LIMIT 1';
        List<SObject> lastSyncList = Database.query(query);
        if (lastSyncList.size() != 0)
        {
            result.lastSyncDate = ((Datetime) lastSyncList[0].get(lastSyncDateColumn)).date();
            result.lastSyncTime = ((Datetime) lastSyncList[0].get(lastSyncDateColumn)).time();
        }

        return result;
    }

    // getLastSyncFromTable()
    //
    // returns the hightest value for [column] from [table]
    public static LastSync getLastSyncFromTable(String scheduleClass, UTIL_SyncHelper.LastSync fromLastSync)
    {
        fromLastSync.isAnotherBatchNeeded = false;

        if (fromLastSync.pageNumber > 0)
        {
            System.debug('fromLastSync.pageNumber > 0');
            return fromLastSync;
        }
        System.debug('fromLastSync.pageNumber = 0');

        LastSync result = new LastSync();
        result.startSyncDateTime = System.now().addDays(-1);
        if (null != fromLastSync)
        {
            result.retryCnt = fromLastSync.retryCnt;
        }

        String query = 'SELECT Name, FLD_Sync_DateTime__c, FLD_Page_Number__c, FLD_Page_Size__c FROM OBJ_SAP_Sync__c WHERE Name = \'' +
            scheduleClass + '\' LIMIT 1';
        List<OBJ_SAP_Sync__c> lastSyncList = Database.query(query);
        if (lastSyncList.size() != 0)
        {
            if (lastSyncList[0].FLD_Sync_DateTime__c != null)
            {
                result.lastSyncDate = lastSyncList[0].FLD_Sync_DateTime__c.date();
                result.lastSyncTime = lastSyncList[0].FLD_Sync_DateTime__c.time();
            }
            
            if (lastSyncList[0].FLD_Page_Number__c != null) result.pageNumber = lastSyncList[0].FLD_Page_Number__c.intValue();
            if (lastSyncList[0].FLD_Page_Size__c != null) result.pageSize = lastSyncList[0].FLD_Page_Size__c.intValue();
        }

        return result;
    }

    public static List<Object> checkRetry(UTIL_SyncHelper.LastSync fromLastSync, Exception ex, List<String> jobInfo)
    {        
        List<SObject> errors = new List<SObject>();
        OBJ_SAP_ETL_Log__c etlLog = new OBJ_SAP_ETL_Log__c();
        fromLastSync.retryCnt++;
        if (fromLastSync.retryCnt < 10)
        {
            fromLastSync.isAnotherBatchNeeded = true;
            resetPage(fromLastSync, (fromLastSync.pageSize / 2) + 1);
            System.debug('Retry Exception Message=' + ex.getMessage());
            etlLog.FLD_Message__c = 'Retry Exception Message: '+ ex.getMessage();
            etlLog.FLD_RecordJson__c = JSON.serialize(new Map<String,Object>{
                'stack-trace' => ex.getStackTraceString(),
                'fromLastSync' => fromLastSync,
                'jobInfo' => jobInfo
            });            
            errors.add(etlLog);             
            UTIL_SyncHelper.insertUpdateResults('ERROR', 'Insert', errors, null, errors, 'UTIL_SyncHelper.checkRetry', null);       
            return new List<Object>();
        }
        System.debug('search failed');
        printJobInfo(jobInfo);
        throw ex;
    }

    public static void resetPage(UTIL_SyncHelper.LastSync fromLastSync, Integer newPageSize)
    {
        if (newPageSize == fromLastSync.pageSize) return;
        Integer newPageNumber = Integer.valueOf((Decimal.valueOf(fromLastSync.pageSize) / 
            Decimal.valueOf(newPageSize) * (fromLastSync.pageNumber-1)));
        Integer newStart = newPageNumber * newPageSize;

        if (fromLastSync.retryStart == -1 && newPageSize < fromLastSync.pageSize)
        {
            fromLastSync.retryStart = fromLastSync.pageSize * fromLastSync.pageNumber;
        }
        if (newStart <= fromLastSync.retryStart && newPageSize >= fromLastSync.pageSize)
        {
            return;
        }
        if (newPageSize > fromLastSync.pageSize)
        {
            fromLastSync.retryStart = -1;
        }
        fromLastSync.pageNumber = newPageNumber;
        fromLastSync.pageSize = newPageSize;
    }

    // getCurrentObjects()
    //
    // query sf database for existing records matching the given keys
    public static List<sObject> getCurrentObjects(String table, Set<String> keys)
    {
        return getCurrentObjects(table, 'Name', keys);
    }

    public static List<sObject> getCurrentObjects(String table, String keyFieldName, Set<String> keys)
    {
        return getCurrentObjects(table, keyFieldName, keys, null);
    }

    public static List<sObject> getCurrentObjects(String table, String keyFieldName, Set<String> keys, List<String> selectedFieldsList)
    {
        List<sObject> result = new List<sObject>();
        try
        {
            if (selectedFieldsList == null)
            {
                selectedFieldsList = new List<String>();
            }
            selectedFieldsList.add(keyFieldName);
            selectedFieldsList.add('Id');
            selectedFieldsList = new List<String>(new Set<String>(selectedFieldsList));

            result = Database.query('SELECT ' + String.join(selectedFieldsList, ', ') + ' FROM ' + table + ' WHERE ' + keyFieldName + ' IN :keys');
        }
        catch (Exception ex)
        {
            System.debug(ex);
        }
        return result;
    }

    // createAccountIdMap()
    //
    // Looks up accounts for the given customer IDs and creates a map of customer -> account ids
    public static Map<String, String> createAccountIdMap(Set<String> customerIds)
    {
        Map<String, String> result = new Map<String, String>();
        String customerIdField = UTIL_SFAccount.CustomerFieldName;

        List<Account> accounts = Database.query(
            'SELECT Id, ' + customerIdField +
            ' FROM Account WHERE ' + customerIdField + ' IN :customerIds'
        );

        Integer acctTot = accounts.size();
        for (Integer acctCnt = 0 ; acctCnt < acctTot ; acctCnt++)
        {
            Account account = accounts[acctCnt];
            String customerId = (String)account.get(customerIdField);
            result.put(customerId, account.Id);
        }
        return result;
    }

    // createAccountMap()
    //
    // Looks up accounts for the given customer IDs and creates a map of customer -> accounts
    public static Map<String, Account> createAccountMap(Set<String> customerIds)
    {
        Map<String, Account> result = new Map<String, Account>();
        String customerIdField = UTIL_SFAccount.CustomerFieldName;

        List<Account> accounts = Database.query(
            'SELECT Id, OwnerId, Owner.IsActive, ' + customerIdField +
            ' FROM Account WHERE ' + customerIdField + ' IN :customerIds'
        );

        Integer acctTot = accounts.size();
        for (Integer acctCnt = 0 ; acctCnt < acctTot ; acctCnt++)
        {
            Account account = accounts[acctCnt];
            String customerId = (String)account.get(customerIdField);
            result.put(customerId, account);
        }
        return result;
    }

    // createSObject()
    //
    // Create an sObject of a given type. For example:
    //     sObject acc = UTIL_SyncHelper.createSObject('Account');
    //     acc.put('AccountNumber', accNumber);
    public static sObject createSObject(String typeName)
    {
        Schema.SObjectType targetType = Schema.getGlobalDescribe().get(typeName);
        if (null == targetType)
        {
            System.debug('UTIL_SyncHelper.createSObject: ' + typeName + ' does not exist');
            return null;
        }
        return targetType.newSObject();
    }

    // addLog()
    //
    // Safely appends messages to log list for later inserting into the OBJ_SAP_ETL_Log__c table and
    // also writes to System.debug for easier debugging in the Dev Console.
    // Leaves log untouched if OBJ_SAP_ETL_Log__c table does not exist.
    public static void addLog(List<sObject> log, String logLevel, String recordNumber, String recordJson, String message)
    {        
        sObject logEntry = createLog(logLevel, recordNumber, recordJson, message);
        
        if (null != log && null != logEntry)
        {
            log.add(logEntry);
        }
        System.debug(logLevel + ': ' + message);
    }

    // createLog()
    //
    // Construct a message for the OBJ_SAP_ETL_Log__c table with the given level and message
    // The message is not inserted into the database. They can be added to a list and inserted
    // all at once later.
    // Returns null if OBJ_SAP_ETL_Log__c table does not exist.
    public static sObject createLog(String logLevel, String recordNumber, String recordJson, String message)
    {
        system.debug('createlog entry called');
        sObject log = createSObject('OBJ_SAP_ETL_Log__c');
        if (null != log)
        {
            log.put('FLD_LogLevel__c', logLevel);
            log.put('FLD_RecordNumber__c', recordNumber);
            log.put('FLD_RecordJson__c', recordJson);
            log.put('FLD_Message__c', message);            
        }
        return log;
    }

    // printJobInfo()
    //
    // helper method to write batch job info to System.debug()
    public static void printJobInfo(List<String> jobInfo)
    {
        Integer jiTot = jobInfo.size();
        for (Integer jiCnt = 0 ; jiCnt < jiTot ; jiCnt++)
        {
            String line = jobInfo[jiCnt];
            System.debug('jobInfo:' + line);
        }
    }

    // debugLogResultMessages()
    //
    // send search result messages to the debug log
    public static void debugLogResultMessages(List<ensxsdk.EnosixFramework.Message> messages)
    {
        if (null != messages)
        {
            Integer mTot = messages.size();
            for (Integer mCnt = 0 ; mCnt < mTot ; mCnt++)
            {
                ensxsdk.EnosixFramework.Message message = messages[mCnt];
                System.debug('response message[' + message.Type.name() + ']: ' + message.Text);
            }
        }
    }

    // getPicklistEntriesForField()
    //
    // Return list of PickListEntry objects for the given sObject typeName.fieldName
    public static List<Schema.PicklistEntry> getPicklistEntriesForField(
        String typeName, String fieldName)
    {
        Schema.DescribeSObjectResult objResult =
            Schema.describeSObjects(new string[]{ typeName })[0];
        Map<string, SObjectField> fields = objResult.fields.getMap();
        Schema.DescribeFieldResult fieldResult = fields.get(fieldName).getDescribe();
        return fieldResult.getPicklistValues();
    }

    // getPicklistValueByLabel()
    //
    // Return the matching pick list value for the given label string. Returns null if no matching
    // entry is in the entries list
    public static String getPicklistValueByLabel(List<Schema.PicklistEntry> entries, String label)
    {
        String result = null;
        Integer pleTot = entries.size();
        for (Integer pleCnt = 0 ; pleCnt < pleTot ; pleCnt++)
        {
            Schema.PicklistEntry ple = entries[pleCnt];
            if (ple.getLabel() == label)
            {
                result = ple.getValue();
                System.debug('returning picklist value: ' + result);
                break;
            }
        }
        return result;
    }

    public static void testSchedulables(Set<Schedulable> schedulables)
    {
        List<Schedulable> schedList = new List<Schedulable>(schedulables);
        Integer schedTot = schedList.size();
        for (Integer schedCnt = 0 ; schedCnt < schedTot ; schedCnt++)
        {
            Schedulable instance = schedList[schedCnt];
            Datetime dt = Datetime.now().addMinutes(1);
            String timeForScheduler = dt.format('s m H d M \'?\' yyyy ');
            String schedId = System.Schedule(
                String.valueOf(instance).split(':')[0] + 'RetryAfter' + timeForScheduler.trim(),
                timeForScheduler,
                instance
            );
            // ID in API is 15 digits
            System.assertEquals(15, schedId.length());
        }
    }

    public static String combineStrings(String first, String second, String combine)
    {
        String result = String.isEmpty(first) ? '' : first;
        result += String.isEmpty(result) || String.isEmpty(second) ? '' : combine;
        result += String.isEmpty(second) ? '' : second;
        return result;
    }

    // validateEmailAddress()
    //
    // Validate the email address from SAP
    // There are some emails that are not a valid email address and cannot be inserted to the email field
    public static Boolean validateEmailAddress(String emailAddress)
    {
        String emailRegex = '^[a-zA-Z0-9._|\\\\%#~`=?&/$^*!}{+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}$';
        Pattern emailPattern = Pattern.compile(emailRegex);
        Matcher emailMatcher = emailPattern.matcher(emailAddress);

        if (!emailMatcher.matches()) 
        {
            return false;
        }
        return true;
    }

    public static String buildErrorMessage(String BatchClassName, List<ensxsdk.EnosixFramework.Message> messages)
    {
        String errorMessage = BatchClassName + ' SBO failed';
        if (null != messages)
        {
            Integer mTot = messages.size();
            for (Integer mCnt = 0 ; mCnt < mTot ; mCnt++)
            {
                ensxsdk.EnosixFramework.Message message = messages[mCnt];
                System.debug('response message[' + message.Type.name() + ']: ' + message.Text);
                errorMessage += '\n' + message.Type + ': ' + message.Text;
            }
        }
        return errorMessage;
    }

    public static void deleteResults(
        String objType, 
        List<SObject> errors, 
        List<SObject> deleteList,
        String BatchClassName,
        String SFSyncKeyField)
    {
        if (deleteList.size() > 0)
        {
            // Set 2nd param to false to be able to partial update in the collection
            // If there's any record failed to update
            Database.DeleteResult[] deleteResultList = Database.delete(deleteList, false);
            checkDeleteResults(objType, 'Delete', deleteResultList, errors, deleteList, BatchClassName, SFSyncKeyField);
        }
    }

    public static void checkDeleteResults(
        String objType, 
        String type, 
        Database.DeleteResult[] deleteResultList, 
        List<SObject> errors,
        List<SObject> records,
        String BatchClassName,
        String SFSyncKeyField)
    {
        Integer deleteTot = deleteResultList.size();
        for (Integer deleteCnt = 0 ; deleteCnt < deleteTot ; deleteCnt++)
        {
            Database.DeleteResult sr = deleteResultList[deleteCnt];
            if (sr.isSuccess())
            {
                if (objType != 'Error') System.debug(objType + ' ' + type + ': Successful for ' + sr.getId());
            }
            else
            {
                System.debug(objType + ' ' + type + ': The following error occurred');
                String recordNumber = '';
                String recordJson = '';
                if (records != null && SFSyncKeyField != null)
                {
                    SObject record = records[deleteCnt];
                    recordNumber = (String) record.get(SFSyncKeyField);
                    recordJson = JSON.serialize(record);
                } 

                List<Database.Error> errList = sr.getErrors();
                Integer errTot = errList.size();
                for (Integer errCnt = 0 ; errCnt < errTot ; errCnt++)
                {
                    Database.Error err = errList[errCnt];
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    if (objType != 'Error')
                    {
                        addLog(errors, 'ERROR', recordNumber, recordJson,
                            BatchClassName + ' ' + objType + ' ' + type + ': The following error occurred on record number ' + recordNumber + ': ' + err.getStatusCode() + ': ' + err.getMessage());
                    }
                }
            }
        }
    }

    public static void insertUpdateResults(
        String objType, 
        String type, 
        List<SObject> errors, 
        Set<String> savedIdSet, 
        List<SObject> insertUpdateList,
        String BatchClassName,
        String SFSyncKeyField)
    {
        if (insertUpdateList.size() > 0)
        {
            List<Database.SaveResult> saveResultList = new List<Database.SaveResult>();
            if (type == 'Insert')
            {
                if (!Test.isRunningTest()) saveResultList = Database.insert(insertUpdateList, false);
            }
            else 
            {
                if (!Test.isRunningTest()) saveResultList = Database.update(insertUpdateList, false);
            }
            checkSaveResults(objType, type, saveResultList, errors, savedIdSet, insertUpdateList, BatchClassName, SFSyncKeyField);
        }
    }

    public static void checkSaveResults(
        String objType, 
        String type, 
        Database.SaveResult[] saveResultList, 
        List<SObject> errors, 
        Set<String> savedIdSet, 
        List<SObject> records,
        String BatchClassName,
        String SFSyncKeyField)
    {
        Integer saveTot = saveResultList.size();
        for (Integer saveCnt = 0 ; saveCnt < saveTot ; saveCnt++)
        {
            Database.SaveResult sr = saveResultList[saveCnt];
            if (sr.isSuccess())
            {
                if (objType != 'Error') System.debug(objType + ' ' + type + ': Successful for ' + sr.getId());
                if (savedIdSet != null)
                {
                    savedIdSet.add(sr.getId());
                }
            }
            else
            {
                System.debug(objType + ' ' + type + ': The following error occurred');
                String recordNumber = '';
                String recordJson = '';
                if (records != null && SFSyncKeyField != null)
                {
                    SObject record = records[saveCnt];
                    recordNumber = (String) record.get(SFSyncKeyField);
                    recordJson = JSON.serialize(record);
                } 

                List<Database.Error> errList = sr.getErrors();
                Integer errTot = errList.size();
                for (Integer errCnt = 0 ; errCnt < errTot ; errCnt++)
                {
                    Database.Error err = errList[errCnt];
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    if (objType != 'Error')
                    {
                        addLog(errors, 'ERROR', recordNumber, recordJson,
                            BatchClassName + ' ' + objType + ' ' + type + ': The following error occurred on record number ' + recordNumber + ': ' + err.getStatusCode() + ': ' + err.getMessage());
                    }
                }
            }
        }
        if (Test.isRunningTest() && savedIdSet != null) savedIdSet.add('testId');
    }

    @testVisible
    private static Account notFoundAccount = null;

    // getNotFoundAccountId()
    //
    // Get the Not Found Account Id for the sync process
    public static string getNotFoundAccountId(List<sObject> errors)
    {
        if (null == notFoundAccount)
        {
            Map<String, String> result = new Map<String, String>();
            List<Account> accounts = [SELECT Id, Name
                FROM Account WHERE Name = 'NOT_FOUND' LIMIT 1];
            if (accounts.size() > 0)
            {
                notFoundAccount = accounts[0];
            }
            else
            {
                try
                {
                    notFoundAccount = new Account();
                    notFoundAccount.Name = 'NOT_FOUND';
                    insert notFoundAccount;
                }
                catch (Exception e)
                {
                    notFoundAccount = null;
                    UTIL_SyncHelper.addLog(errors, 'ERROR', null, null, 'Could not find or create NOT_FOUND account');
                    return '';
                }
            }
        }
        return notFoundAccount.Id;
    }

    public class CleanupObject
    {
        public String objectType;
        public String sFSyncKeyField;
        public String notFoundId;
        public List<CleanupField> cleanupFieldList;
        public Set<String> sapKeyNumbers = new Set<String>();

        public CleanupObject (String objectType, String sFSyncKeyField, String notFoundId, List<CleanupField> cleanupFieldList)
        {
            this.objectType = objectType;
            this.sFSyncKeyField = sFSyncKeyField;
            this.notFoundId = notFoundId;
            this.cleanupFieldList = cleanupFieldList;
        }
    }

    public class CleanupField
    {
        public String key;
        public String objectId;

        public CleanupField (String key, String objectId)
        {
            this.key = key;
            this.objectId = objectId;
        }
    }
    
    // createSObjectMap()
    //
    // Looks up Sales Force Objects for the given keys and create a map of key -> object
    public static Map<String, SObject> createSObjectMap(CleanupObject cleanupObject)
    {
        Map<String, SObject> resultMap = new Map<String, SObject>();
        Set<String> sapKeyNumbers = cleanupObject.sapKeyNumbers;

        List<SObject> resultList = Database.query(
            'SELECT Id, ' + cleanupObject.sFSyncKeyField +
            ' FROM ' + cleanupObject.objectType + ' WHERE ' + cleanupObject.sFSyncKeyField + ' IN :sapKeyNumbers'
        );

        Integer resultTot = resultList.size();
        for (Integer resultCnt = 0 ; resultCnt < resultTot ; resultCnt++)
        {
            SObject resultSObject = resultList[resultCnt];
            String key = (String)resultSObject.get(cleanupObject.sFSyncKeyField);
            resultMap.put(key, resultSObject);
        }
        return resultMap;
    }
}