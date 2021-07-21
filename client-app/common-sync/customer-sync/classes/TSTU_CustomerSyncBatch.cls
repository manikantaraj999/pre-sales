@isTest
public with sharing class TSTU_CustomerSyncBatch
{
    static final string TEST_JSON = '{"AccountGroups":["0001","0002"], "Logging": true}';

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

            SBO_EnosixCustSync_Search.EnosixCustSync_SR searchResult =
                new SBO_EnosixCustSync_Search.EnosixCustSync_SR();

            SBO_EnosixCustSync_Search.SEARCHRESULT result1 =
                new SBO_EnosixCustSync_Search.SEARCHRESULT();

            result1.CustomerNumber = '1';
            result1.AccountGroup = 'AccountGroup';
            result1.Name = 'Name';
            result1.Name2 = 'Name2';
            result1.Street = 'Street';
            result1.Street2 = 'Street2';
            result1.Street3 = 'Street3';
            result1.Street4 = 'Street4';
            result1.AssetLocation = 'AssetLocation';
            result1.HouseNumber = 'HouseNumber';
            result1.PostalCode = 'PostalCode';
            result1.City = 'City';
            result1.Country = 'Country';
            result1.Region = 'Region';
            result1.POBox = 'POBox';
            result1.POBoxPostalCode = 'POBoxPostalCode';
            result1.TelephoneNumber = 'TelephoneNumber';
            result1.EMailAddress = 'EMailAddress';

            searchResult.SearchResults.add(result1);

            SBO_EnosixCustSync_Search.SEARCHRESULT result2 =
                new SBO_EnosixCustSync_Search.SEARCHRESULT();

            result2.CustomerNumber = '2';
            result2.AccountGroup = 'AccountGroup';
            result2.Name = 'Name';
            result2.Name2 = 'Name2';
            result2.Street = 'Street';
            result2.Street2 = 'Street2';
            result2.Street3 = 'Street3';
            result2.Street4 = 'Street4';
            result2.AssetLocation = 'AssetLocation';
            result2.HouseNumber = 'HouseNumber';
            result2.PostalCode = 'PostalCode';
            result2.City = 'City';
            result2.Country = 'Country';
            result2.Region = 'Region';
            result2.POBox = 'POBox';
            result2.POBoxPostalCode = 'POBoxPostalCode';
            result2.TelephoneNumber = 'TelephoneNumber';
            result2.EMailAddress = 'valid@valid.com';

            searchResult.SearchResults.add(result2);

            SBO_EnosixCustSync_Search.SEARCHRESULT result3 =
                new SBO_EnosixCustSync_Search.SEARCHRESULT();

            result3.CustomerNumber = '3';
            result3.AccountGroup = 'AccountGroup';
            result3.Name = 'Name';
            result3.Name2 = 'Name2';
            result3.Street = 'Street';
            result3.Street2 = 'Street2';
            result3.Street3 = 'Street3';
            result3.Street4 = 'Street4';
            result3.AssetLocation = 'AssetLocation';
            result3.HouseNumber = 'HouseNumber';
            result3.PostalCode = 'PostalCode';
            result3.City = 'City';
            result3.Country = 'Country';
            result3.Region = 'Region';
            result3.POBox = 'POBox';
            result3.POBoxPostalCode = 'POBoxPostalCode';
            result3.TelephoneNumber = 'TelephoneNumber';
            result3.EMailAddress = 'valid@valid.com';
            result3.DeleteIndicator = 'X';

            searchResult.SearchResults.add(result3);

            SBO_EnosixCustSync_Search.SEARCHRESULT result4 =
                new SBO_EnosixCustSync_Search.SEARCHRESULT();

            result4.CustomerNumber = '4';

            searchResult.SearchResults.add(result4);

            searchResult.setSuccess(this.success);
            searchContext.baseResult = searchResult;
            return searchContext;
        }
    }

    public static testMethod void test_CustomerSync()
    {
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustSync_Search.class, new MockSyncSearch());
        
        UTIL_AppSettings.settingsMap.put(UTIL_AppSettings.Prefix + UTIL_AppSettings.CustomerSyncBatch + UTIL_AppSettings.Suffix, (Map<String, Object>)JSON.deserializeUntyped(TEST_JSON));
        createExistingObject();
        Test.startTest();
        UTIL_CustomerSyncBatch controller = new UTIL_CustomerSyncBatch();
        UTIL_SyncHelper.LastSync lastSync = new UTIL_SyncHelper.LastSync();
        lastSync.retryCnt = 1;
        controller.setBatchParam(lastSync);
        Database.executeBatch(controller);
        Test.stopTest();
    }

    public static testMethod void test_CustomerSyncInitialLoad()
    {
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustSync_Search.class, new MockSyncSearch());
        
        UTIL_AppSettings.settingsMap.put(UTIL_AppSettings.Prefix + UTIL_AppSettings.CustomerSyncBatch + UTIL_AppSettings.Suffix, (Map<String, Object>)JSON.deserializeUntyped(TEST_JSON));
        Test.startTest();
        UTIL_CustomerSyncBatch controller = new UTIL_CustomerSyncBatch();
        UTIL_SyncHelper.LastSync lastSync = new UTIL_SyncHelper.LastSync();
        lastSync.retryCnt = 1;
        controller.setBatchParam(lastSync);
        Database.executeBatch(controller);
        Test.stopTest();
    }

    public static testMethod void test_CustomerSyncFailure()
    {
        MockSyncSearch mockSyncSearch = new MockSyncSearch();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustSync_Search.class, mockSyncSearch);
        mockSyncSearch.setSuccess(false);

        createExistingObject();
        Test.startTest();
        UTIL_CustomerSyncBatch controller = new UTIL_CustomerSyncBatch();
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

    public static testMethod void test_CustomerSyncException()
    {
        MockSyncSearch mockSyncSearch = new MockSyncSearch();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustSync_Search.class, mockSyncSearch);
        mockSyncSearch.setThrowException(true);

        createExistingObject();
        Test.startTest();
        UTIL_CustomerSyncBatch controller = new UTIL_CustomerSyncBatch();
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
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustSync_Search.class, new MockSyncSearch());

        Test.startTest();
        UTIL_CustomerSyncBatch.getTotalRecordCount();
        UTIL_CustomerSyncBatch.getNextIncrementalRecordCount();
        Test.stopTest();
    }

    private static void createExistingObject()
    {
        Account currentObject = TSTU_SFTestObject.createTestAccount();
        currentObject.Name = 'account1';
        currentObject.put(UTIL_CustomerSyncBatch.SFSyncKeyField,'1');
        TSTU_SFTestObject.upsertWithRetry(currentObject);

        OBJ_SAP_Sync__c sapSync = new OBJ_SAP_Sync__c();
        sapSync.Name = 'UTIL_CustomerSyncSchedule';
        sapSync.FLD_Sync_DateTime__c = System.today().addDays(-1);
        sapSync.FLD_Page_Number__c = 0;
        TSTU_SFTestObject.upsertWithRetry(sapSync);
    }
}