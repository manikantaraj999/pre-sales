@isTest
public with sharing class TSTU_ContactSyncBatch
{
    static final string TEST_JSON =
        '{"Logging": true}';

    public class MockSyncSearch implements ensxsdk.EnosixFramework.SearchSBOSearchMock
    {
        private boolean success = true;

        public void setSuccess(boolean success)
        {
            this.success = success;
        }

        private boolean throwException = false;

        public void setThrowException(boolean throwException)
        {
            this.throwException = throwException;
        }

        public ensxsdk.EnosixFramework.SearchContext executeSearch(ensxsdk.EnosixFramework.SearchContext searchContext)
        {
            if (this.throwException)
            {
                throw new UTIL_SyncHelper.SyncException('');
            }

            SBO_EnosixContactSync_Search.EnosixContactSync_SR searchResult =
                new SBO_EnosixContactSync_Search.EnosixContactSync_SR();

            // New Account
            SBO_EnosixContactSync_Search.SEARCHRESULT result1 =
                new SBO_EnosixContactSync_Search.SEARCHRESULT();

            result1.ContactPersonNumber = '0001';
            result1.Name2 = 'LastName';
            result1.CustomerNumber = '0001';

            searchResult.SearchResults.add(result1);

            // Existing Account
            SBO_EnosixContactSync_Search.SEARCHRESULT result2 =
                new SBO_EnosixContactSync_Search.SEARCHRESULT();

            result2.ContactPersonNumber = '0002';
            result2.CustomerNumber = '0002';

            searchResult.SearchResults.add(result2);

            SBO_EnosixContactSync_Search.SEARCHRESULT result3 =
                new SBO_EnosixContactSync_Search.SEARCHRESULT();

            result3.ContactPersonNumber = '';

            searchResult.SearchResults.add(result3);

            searchResult.setSuccess(this.success);
            searchContext.baseResult = searchResult;
            return searchContext;
        }
    }

    public static testMethod void test_ContactSync()
    {
        ensxsdk.EnosixFramework.setMock(SBO_EnosixContactSync_Search.class, new MockSyncSearch());
        
        UTIL_AppSettings.settingsMap.put(UTIL_AppSettings.Prefix + UTIL_AppSettings.ContactSyncBatch + UTIL_AppSettings.Suffix, (Map<String, Object>)JSON.deserializeUntyped(TEST_JSON));
        createExistingObject();
        Test.startTest();
        UTIL_ContactSyncBatch controller = new UTIL_ContactSyncBatch();
        UTIL_SyncHelper.LastSync lastSync = new UTIL_SyncHelper.LastSync();
        lastSync.retryCnt = 1;
        controller.setBatchParam(lastSync);
        Database.executeBatch(controller);
        Test.stopTest();
    }

    public static testMethod void test_ContactSyncInitialLoad()
    {
        ensxsdk.EnosixFramework.setMock(SBO_EnosixContactSync_Search.class, new MockSyncSearch());
        
        UTIL_AppSettings.settingsMap.put(UTIL_AppSettings.Prefix + UTIL_AppSettings.ContactSyncBatch + UTIL_AppSettings.Suffix, (Map<String, Object>)JSON.deserializeUntyped(TEST_JSON));
        Test.startTest();
        UTIL_ContactSyncBatch controller = new UTIL_ContactSyncBatch();
        UTIL_SyncHelper.LastSync lastSync = new UTIL_SyncHelper.LastSync();
        lastSync.retryCnt = 1;
        controller.setBatchParam(lastSync);
        Database.executeBatch(controller);
        Test.stopTest();
    }

    public static testMethod void test_ContactSyncFailure()
    {
        MockSyncSearch mockSyncSearch = new MockSyncSearch();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixContactSync_Search.class, mockSyncSearch);
        mockSyncSearch.setSuccess(false);

        createExistingObject();
        Test.startTest();
        UTIL_ContactSyncBatch controller = new UTIL_ContactSyncBatch();
        Database.executeBatch(controller);
        try
        {
            UTIL_SyncHelper.LastSync lastSync = new UTIL_SyncHelper.LastSync();
            lastSync.retryCnt = 11;
            controller.setBatchParam(lastSync);
        }
        catch (Exception e) {}
        Test.stopTest();
    }

    public static testMethod void test_ContactSyncException()
    {
        MockSyncSearch mockSyncSearch = new MockSyncSearch();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixContactSync_Search.class, mockSyncSearch);
        mockSyncSearch.setThrowException(true);

        createExistingObject();
        Test.startTest();
        UTIL_ContactSyncBatch controller = new UTIL_ContactSyncBatch();
        Database.executeBatch(controller);
        try
        {
            UTIL_SyncHelper.LastSync lastSync = new UTIL_SyncHelper.LastSync();
            lastSync.retryCnt = 11;
            controller.setBatchParam(lastSync);
            controller.start(null);
        }
        catch (Exception e) {}
        Test.stopTest();
    }

    public static testMethod void test_getRecordCount()
    {
        ensxsdk.EnosixFramework.setMock(SBO_EnosixContactSync_Search.class, new MockSyncSearch());

        Test.startTest();
        UTIL_ContactSyncBatch.getTotalRecordCount();
        UTIL_ContactSyncBatch.getNextIncrementalRecordCount();
        Test.stopTest();
    }

    private static void createExistingObject()
    {
        Contact contact = TSTU_SFTestObject.createTestContact(null);
        contact.LastName = 'LastName';
        contact.put(UTIL_SFContact.ContactFieldName,'1');
        TSTU_SFTestObject.upsertWithRetry(contact);

        OBJ_SAP_Sync__c sapSync = new OBJ_SAP_Sync__c();
        sapSync.Name = 'UTIL_ContactSyncSchedule';
        sapSync.FLD_Sync_DateTime__c = System.today().addDays(-1);
        sapSync.FLD_Page_Number__c = 0;
        TSTU_SFTestObject.upsertWithRetry(sapSync);
    }
}