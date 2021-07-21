@isTest
public class TSTU_SyncHelper
{
    private static Account createTestAccount()
    {
        Account testAccount = TSTU_SFTestObject.createTestAccount();
        testAccount.Name = 'test';
        testAccount.put(UTIL_SFAccount.CustomerFieldName, 'testId');
        TSTU_SFTestObject.upsertWithRetry(testAccount);

        OBJ_SAP_Sync__c sapSync = new OBJ_SAP_Sync__c();
        sapSync.Name = 'scheduleClass';
        sapSync.FLD_Sync_DateTime__c = System.today().addDays(-1);
        sapSync.FLD_Page_Number__c = 0;
        sapSync.FLD_Page_Size__c = 1;
        TSTU_SFTestObject.upsertWithRetry(sapSync);
        return testAccount;
    }

    @isTest
    public static void testExecuteBatch()
    {
        Account acct = createTestAccount();

        Test.startTest();
        UTIL_SyncHelper.executeBatch('batchClass', 'scheduleClass');
        UTIL_SyncHelper.executeBatch('batchClass', 'scheduleClass', null, 1);
        Test.stopTest();
    }

    @isTest
    public static void testLaunchAnotherBatchIfNeeded()
    {
        Account acct = createTestAccount();

        Test.startTest();
        UTIL_SyncHelper.launchAnotherBatchIfNeeded(true, 'scheduleClass');
        UTIL_SyncHelper.LastSync lastSync = new UTIL_SyncHelper.LastSync();
        lastSync.lastSyncDate = System.now().addDays(-1).date();
        lastSync.lastSyncTime = System.now().addDays(-1).time();
        UTIL_SyncHelper.launchAnotherBatchIfNeeded(false, 'scheduleClass', lastSync);
        UTIL_SyncHelper.launchAnotherBatchIfNeeded(true, 'scheduleClass', lastSync);
        Test.stopTest();
    }

    @isTest
    public static void testGetLastSyncFromTable()
    {
        Account acct = createTestAccount();

        Test.startTest();
        UTIL_SyncHelper.LastSync tst2 = UTIL_SyncHelper.getLastSyncFromTable('CreatedDate', 'Account', new UTIL_SyncHelper.LastSync());
        tst2.lastSyncDate = System.now().date();
        tst2.lastSyncTime = System.now().time();
        tst2.pageNumber = 1;
        String lastDateAndId = tst2.toString();
        tst2 = UTIL_SyncHelper.getLastSyncFromTable('CreatedDate', 'Account', tst2);
        tst2 = UTIL_SyncHelper.getLastSyncFromTable('CloseDate', 'Opportunity', tst2);
        tst2 = UTIL_SyncHelper.getLastSyncFromTable('CloseDate', 'Opportunity', new UTIL_SyncHelper.LastSync());
        tst2.lastSyncDate = System.now().date();
        tst2.lastSyncTime = System.now().time();
        tst2.pageNumber = 1;
        tst2 = UTIL_SyncHelper.getLastSyncFromTable('scheduleClass', tst2);
        tst2 = UTIL_SyncHelper.getLastSyncFromTable('scheduleClass', new UTIL_SyncHelper.LastSync());
        Test.stopTest();
    }

    @isTest
    public static void testCheckRetry()
    {
        Test.startTest();
        UTIL_SyncHelper.LastSync lastSync = new UTIL_SyncHelper.LastSync();
        UTIL_SyncHelper.checkRetry(lastSync, new UTIL_SyncHelper.SyncException(''), new List<String>());
        try {
            lastSync.retryCnt = 10;
            UTIL_SyncHelper.checkRetry(lastSync, new UTIL_SyncHelper.SyncException(''), new List<String>());
        } catch (Exception e) {}
        Test.stopTest();
    }

    @isTest
    public static void testResetPage()
    {
        Test.startTest();
        UTIL_SyncHelper.LastSync lastSync = new UTIL_SyncHelper.LastSync();
        lastSync.pageNumber = 100;
        UTIL_SyncHelper.resetPage(lastSync, 5);
        UTIL_SyncHelper.resetPage(lastSync, 200);
        lastSync.retryStart = 999999999;
        UTIL_SyncHelper.resetPage(lastSync, 201);
        lastSync.retryStart = -1;
        UTIL_SyncHelper.resetPage(lastSync, 100);
        Test.stopTest();
    }

    @isTest
    public static void testgetCurrentObjects()
    {
        Account acct = createTestAccount();

        Test.startTest();
        List<SObject> recs = UTIL_SyncHelper.getCurrentObjects('invalid table', new Set<String>());
        recs = UTIL_SyncHelper.getCurrentObjects('Account', new Set<String>{acct.Id});
        Test.stopTest();
    }

    @isTest
    public static void testCreateAccountIdMap()
    {
        Account acct = createTestAccount();

        Test.startTest();
        Map<String, String> mp = UTIL_SyncHelper.createAccountIdMap(new Set<String>{(String) acct.get(UTIL_SFAccount.CustomerFieldName)});
        Test.stopTest();
    }

    @isTest
    public static void testCreateAccountMap()
    {
        Account acct = createTestAccount();

        Test.startTest();
        Map<String, Account> mp = UTIL_SyncHelper.createAccountMap(new Set<String>{(String) acct.get(UTIL_SFAccount.CustomerFieldName)});
        Test.stopTest();
    }

    @isTest
    public static void testCreateSObject()
    {
        Test.startTest();
        SObject obj = UTIL_SyncHelper.createSObject('Bad Object');
        obj = UTIL_SyncHelper.createSObject('Account');
        Test.stopTest();
    }

    @isTest
    public static void testAddLog()
    {
        Test.startTest();
        UTIL_SyncHelper.addLog(new List<sObject>(), 'Error', 'Test', 'json', 'Hello');
        Test.stopTest();
    }

    @isTest
    public static void testPrintJobInfo()
    {
        Test.startTest();
        UTIL_SyncHelper.printJobInfo(new List<String>{'Error', 'Test'});
        Test.stopTest();
    }

    @isTest
    public static void testDebugLogResultMessages()
    {
        Test.startTest();
        ensxsdk.EnosixFramework.Message message = new ensxsdk.EnosixFramework.Message(ensxsdk.EnosixFramework.MessageType.Error, 'Test');
        UTIL_SyncHelper.debugLogResultMessages(new List<ensxsdk.EnosixFramework.Message> {message});
        Test.stopTest();
    }

    @isTest
    public static void testGetPickListEntriesForFieldAndValueByLabel()
    {
        Test.startTest();
        List<Schema.PicklistEntry> pickListEntries = UTIL_SyncHelper.getPicklistEntriesForField('Account', 'Type');
        String val = UTIL_SyncHelper.getPicklistValueByLabel(pickListEntries, pickListEntries[0].getLabel());
        Test.stopTest();
    }

    @isTest
    public static void testTestSchedulables()
    {
        Test.startTest();
        UTIL_SyncHelper.testSchedulables(new Set<Schedulable> {new MockSchedulable()});
        Test.stopTest();
    }

    public class MockSchedulable implements Schedulable
    {
        public void execute(SchedulableContext sc) {}
    }

    @isTest
    public static void testCombineStrings()
    {
        Test.startTest();
        UTIL_SyncHelper.combineStrings('first','second','combine');
        Test.stopTest();
    }

    @isTest
    public static void testValidateEmailAddress()
    {
        Test.startTest();
        UTIL_SyncHelper.validateEmailAddress('bad email');
        UTIL_SyncHelper.validateEmailAddress('goodEmail@good.com');
        Test.stopTest();
    }

    @isTest
    public static void testBuildErrorMessage()
    {
        Test.startTest();
        List<ensxsdk.EnosixFramework.Message> messages = new List<ensxsdk.EnosixFramework.Message>();
        ensxsdk.EnosixFramework.Message message = new ensxsdk.EnosixFramework.Message(ensxsdk.EnosixFramework.MessageType.Error, 'Test');
        messages.add(message);
        UTIL_SyncHelper.buildErrorMessage('BatchClassName', messages);
        Test.stopTest();
    }

    @isTest
    public static void testDeleteResults()
    {
        Test.startTest();
        List<SObject> records = new List<SObject>();
        records.add(TSTU_SFTestObject.createTestAccount());
        records.add(TSTU_SFTestObject.createTestAccount());
        TSTU_SFTestObject.upsertWithRetry(records);
        UTIL_SyncHelper.deleteResults('objType', new List<SObject>(), records, 'BatchClassName', 'id');
        UTIL_SyncHelper.deleteResults('objType', new List<SObject>(), records, 'BatchClassName', 'id');
        Test.stopTest();
    }

    @isTest
    public static void testCheckDeleteResults()
    {
        Test.startTest();
        Database.DeleteResult[] deleteResultList = new Database.DeleteResult[2];
        deleteResultList[0] = (Database.DeleteResult) JSON.deserialize('{"success":true,"id":"0013000000abcde"}', Database.DeleteResult.class);
        deleteResultList[1] = (Database.DeleteResult) JSON.deserialize('{"success":false,"errors":[{"message":"Error Message","statusCode":"FIELD_CUSTOM_VALIDATION_EXCEPTION"}]}', Database.DeleteResult.class);
        List<SObject> records = new List<SObject>();
        records.add(TSTU_SFTestObject.createTestAccount());
        records.add(TSTU_SFTestObject.createTestAccount());
        UTIL_SyncHelper.checkDeleteResults('objType', 'type', deleteResultList, new List<SObject>(), records, 'BatchClassName', 'id');
        Test.stopTest();
    }

    @isTest
    public static void testInsertUpdateResults()
    {
        Test.startTest();
        List<SObject> records = new List<SObject>();
        records.add(TSTU_SFTestObject.createTestAccount());
        records.add(TSTU_SFTestObject.createTestAccount());
        UTIL_SyncHelper.insertUpdateResults('objType', 'Insert', new List<SObject>(), new Set<String>(), records, 'BatchClassName', 'id');
        UTIL_SyncHelper.insertUpdateResults('objType', 'Update', new List<SObject>(), new Set<String>(), records, 'BatchClassName', 'id');
        Test.stopTest();
    }

    @isTest
    public static void testCheckSaveResults()
    {
        Test.startTest();
        Database.SaveResult[] saveResultList = new Database.SaveResult[2];
        saveResultList[0] = (Database.SaveResult) JSON.deserialize('{"success":true,"id":"0013000000abcde"}', Database.SaveResult.class);
        saveResultList[1] = (Database.SaveResult) JSON.deserialize('{"success":false,"errors":[{"message":"Error Message","statusCode":"FIELD_CUSTOM_VALIDATION_EXCEPTION"}]}', Database.SaveResult.class);
        List<SObject> records = new List<SObject>();
        records.add(TSTU_SFTestObject.createTestAccount());
        records.add(TSTU_SFTestObject.createTestAccount());
        UTIL_SyncHelper.checkSaveResults('objType', 'type', saveResultList, new List<SObject>(), new Set<String>(), records, 'BatchClassName', 'id');
        Test.stopTest();
    }

    @isTest
    public static void testGetNotFoundAccountId()
    {
        Test.startTest();
        String accountId = UTIL_SyncHelper.getNotFoundAccountId(new List<sObject>());
        UTIL_SyncHelper.notFoundAccount = null;
        accountId = UTIL_SyncHelper.getNotFoundAccountId(new List<sObject>());
        Test.stopTest();
    }

    @isTest
    public static void testCreateSObjectMap()
    {
        Test.startTest();
        UTIL_SyncHelper.CleanupObject cleanupObject = new UTIL_SyncHelper.CleanupObject(
            'Account', UTIL_SFAccount.CustomerFieldName, UTIL_SyncHelper.getNotFoundAccountId(new List<sObject>()),
            new List<UTIL_SyncHelper.CleanupField> {
                new UTIL_SyncHelper.CleanupField(UTIL_SFAccount.CustomerFieldName, 'AccountId')
            }
        );
        cleanupObject.sapKeyNumbers.add('1');
        Account testAccount = TSTU_SFTestObject.createTestAccount();
        testAccount.put(UTIL_SFAccount.CustomerFieldName, '1');
        TSTU_SFTestObject.upsertWithRetry(testAccount);
        UTIL_SyncHelper.createSObjectMap(cleanupObject);
        Test.stopTest();
    }
}