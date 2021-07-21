@isTest
public with sharing class TSTU_MaterialSyncBatch
{
    static final string TEST_JSON =
        '{"MaterialTypes":["FERT","ZERT"],' + 
        '"MaterialGroups":["A","*"],' + 
        '"Divisions":["01","02"],' +
        '"Logging": true}';

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

            SBO_EnosixMatSync_Search.EnosixMatSync_SR searchResult =
                new SBO_EnosixMatSync_Search.EnosixMatSync_SR();

            // New Account
            SBO_EnosixMatSync_Search.SEARCHRESULT result1 =
                new SBO_EnosixMatSync_Search.SEARCHRESULT();

            result1.DeleteIndicator = 'X';
            result1.ConfigurableMaterial = 'X';
            result1.MaterialType = 'MaterialType';
            result1.MaterialTypeDescription = 'MaterialTypeDescription';
            result1.Division = 'Division';
            result1.DivisionDescription = 'DivisionDescription';
            result1.MaterialGroup = 'MaterialGroup';
            result1.MaterialGroupDescription = 'MaterialGroupDescription';
            result1.Material = 'Material1';
            result1.MaterialDescription = 'MaterialDescription';
            result1.BaseUnitOfMeasure = 'BaseUnitOfMeasure';
            result1.SalesUnit = 'SalesUnit';
            result1.SalesOrganization = 'SalesOrganization';
            result1.DistributionChannel = 'DistributionChannel';
            result1.DistChainStatus = 'DistChainStatus';
            result1.WeightUnit = 'WeightUnit';
            result1.DistChainStatusDate = System.today();

            searchResult.SearchResults.add(result1);

            // Existing Account
            SBO_EnosixMatSync_Search.SEARCHRESULT result2 =
                new SBO_EnosixMatSync_Search.SEARCHRESULT();

            result2.ConfigurableMaterial = 'X';
            result2.MaterialType = 'MaterialType';
            result2.MaterialTypeDescription = 'MaterialTypeDescription';
            result2.Division = 'Division';
            result2.DivisionDescription = 'DivisionDescription';
            result2.MaterialGroup = 'MaterialGroup';
            result2.MaterialGroupDescription = 'MaterialGroupDescription';
            result2.Material = 'Material2';
            result2.MaterialDescription = 'MaterialDescription';
            result2.BaseUnitOfMeasure = 'BaseUnitOfMeasure';
            result2.SalesUnit = 'SalesUnit';
            result2.SalesOrganization = 'SalesOrganization';
            result2.DistributionChannel = 'DistributionChannel';
            result2.DistChainStatus = 'DistChainStatus';
            result2.WeightUnit = 'WeightUnit';
            result2.DistChainStatusDate = System.today();

            searchResult.SearchResults.add(result2);

            SBO_EnosixMatSync_Search.SEARCHRESULT result3 =
                new SBO_EnosixMatSync_Search.SEARCHRESULT();

            result3.DeleteIndicator = 'X';
            result3.ConfigurableMaterial = 'X';
            result3.MaterialType = 'MaterialType';
            result3.MaterialTypeDescription = 'MaterialTypeDescription';
            result3.Division = 'Division';
            result3.DivisionDescription = 'DivisionDescription';
            result3.MaterialGroup = 'MaterialGroup';
            result3.MaterialGroupDescription = 'MaterialGroupDescription';
            result3.Material = 'Material3';
            result3.MaterialDescription = 'MaterialDescription';
            result3.BaseUnitOfMeasure = 'BaseUnitOfMeasure';
            result3.SalesUnit = 'SalesUnit';
            result3.SalesOrganization = 'SalesOrganization';
            result3.DistributionChannel = 'DistributionChannel';
            result3.DistChainStatus = 'DistChainStatus';
            result3.WeightUnit = 'WeightUnit';
            result3.DistChainStatusDate = System.today();

            searchResult.SearchResults.add(result3);

            SBO_EnosixMatSync_Search.SEARCHRESULT result4 =
                new SBO_EnosixMatSync_Search.SEARCHRESULT();

            result4.MaterialType = 'MaterialType';
            result4.MaterialTypeDescription = 'MaterialTypeDescription';
            result4.Division = 'Division';
            result4.DivisionDescription = 'DivisionDescription';
            result4.MaterialGroup = 'MaterialGroup';
            result4.MaterialGroupDescription = 'MaterialGroupDescription';
            result4.Material = 'Material4';
            result4.MaterialDescription = 'MaterialDescription';
            result4.BaseUnitOfMeasure = 'BaseUnitOfMeasure';
            result4.SalesUnit = 'SalesUnit';
            result4.SalesOrganization = 'SalesOrganization';
            result4.DistributionChannel = 'DistributionChannel';
            result4.DistChainStatus = 'DistChainStatus';
            result4.WeightUnit = 'WeightUnit';
            result4.DistChainStatusDate = System.today();

            searchResult.SearchResults.add(result4);

            searchResult.setSuccess(this.success);
            searchContext.baseResult = searchResult;
            return searchContext;
        }
    }

    public static testMethod void test_MaterialSync()
    {
        ensxsdk.EnosixFramework.setMock(SBO_EnosixMatSync_Search.class, new MockSyncSearch());

        UTIL_AppSettings.settingsMap.put(UTIL_AppSettings.Prefix + UTIL_AppSettings.MaterialSyncBatch + UTIL_AppSettings.Suffix, (Map<String, Object>)JSON.deserializeUntyped(TEST_JSON));
        createExistingObject();
        Test.startTest();
        UTIL_MaterialSyncBatch controller = new UTIL_MaterialSyncBatch();
        UTIL_SyncHelper.LastSync lastSync = new UTIL_SyncHelper.LastSync();
        lastSync.retryCnt = 1;
        controller.setBatchParam(lastSync);
        Database.executeBatch(controller);
        Test.stopTest();
    }

    public static testMethod void test_MaterialSyncFailure()
    {
        MockSyncSearch mockSyncSearch = new MockSyncSearch();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixMatSync_Search.class, mockSyncSearch);
        mockSyncSearch.setSuccess(false);

        createExistingObject();
        Test.startTest();
        UTIL_MaterialSyncBatch controller = new UTIL_MaterialSyncBatch();
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

    public static testMethod void test_MaterialSyncException()
    {
        MockSyncSearch mockSyncSearch = new MockSyncSearch();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixMatSync_Search.class, mockSyncSearch);
        mockSyncSearch.setThrowException(true);

        createExistingObject();
        Test.startTest();
        UTIL_MaterialSyncBatch controller = new UTIL_MaterialSyncBatch();
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
        ensxsdk.EnosixFramework.setMock(SBO_EnosixMatSync_Search.class, new MockSyncSearch());

        Test.startTest();
        UTIL_MaterialSyncBatch.getTotalRecordCount();
        UTIL_MaterialSyncBatch.getNextIncrementalRecordCount();
        Test.stopTest();
    }

    private static void createExistingObject()
    {
        Product2 currentObject = TSTU_SFTestObject.createTestProduct2();
        currentObject.put(UTIL_MaterialSyncBatch.SFSyncKeyField,'Material1');
        TSTU_SFTestObject.upsertWithRetry(currentObject);

        OBJ_SAP_Sync__c sapSync = new OBJ_SAP_Sync__c();
        sapSync.Name = 'UTIL_MaterialSyncSchedule';
        sapSync.FLD_Sync_DateTime__c = System.today().addDays(-1);
        sapSync.FLD_Page_Number__c = 0;
        TSTU_SFTestObject.upsertWithRetry(sapSync);
    }
}