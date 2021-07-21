@isTest
public with sharing class TSTU_SalesDocSyncBatch
{
    static final string TEST_JSON =
        '{"DocTypes":["TEST"],' +
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

            SBO_EnosixSalesDocSync_Search.EnosixSalesDocSync_SR searchResult =
                new SBO_EnosixSalesDocSync_Search.EnosixSalesDocSync_SR();

            // New Account
            SBO_EnosixSalesDocSync_Search.SEARCHRESULT result1 =
                new SBO_EnosixSalesDocSync_Search.SEARCHRESULT();

            result1.SalesDocument = '0001';
            result1.SalesOrganization = '1000';
            result1.DistributionChannel = '100';

            searchResult.SearchResults.add(result1);

            // Existing Account
            SBO_EnosixSalesDocSync_Search.SEARCHRESULT result2 =
                new SBO_EnosixSalesDocSync_Search.SEARCHRESULT();

            result2.SalesDocument = '0002';
            result2.SalesOrganization = '2000';
            result2.DistributionChannel = '200';

            searchResult.SearchResults.add(result2);

            SBO_EnosixSalesDocSync_Search.SEARCHRESULT result3 =
                new SBO_EnosixSalesDocSync_Search.SEARCHRESULT();

            result3.SalesDocument = '';

            searchResult.SearchResults.add(result3);

            searchResult.setSuccess(this.success);
            searchContext.baseResult = searchResult;
            return searchContext;
        }
    }

    @isTest
    public static void test_OrderSync()
    {
        ensxsdk.EnosixFramework.setMock(SBO_EnosixSalesDocSync_Search.class, new MockSyncSearch());
        UTIL_AppSettings.settingsMap.put(UTIL_AppSettings.Prefix + UTIL_AppSettings.OrderSyncBatch + UTIL_AppSettings.Suffix, (Map<String, Object>)JSON.deserializeUntyped(TEST_JSON));
        OBJ_Order__c order = new OBJ_Order__c();
        order.Name = '1';
        TSTU_SFTestObject.upsertWithRetry(order);

        OBJ_Order_Item__c orderItem = new OBJ_Order_Item__c();
        orderItem.Name = '1';
        orderItem.FLD_OBJ_Order__c = order.Id;
        TSTU_SFTestObject.upsertWithRetry(orderItem);

        UTIL_OrderSyncBatch controller = new UTIL_OrderSyncBatch();
        UTIL_SyncHelper.LastSync lastSync = new UTIL_SyncHelper.LastSync();
        lastSync.retryCnt = 1;
        controller.setBatchParam(lastSync);

        Test.startTest();
        Database.executeBatch(controller);
        Test.stopTest();

        List<OBJ_Order__c> orders = [SELECT Id, Name, FLD_SalesOrganization__c, FLD_DistributionChannel__c FROM OBJ_Order__c];
        System.assertEquals(1, orders.size());
        
        Integer orderTot = orders.size();
        for (Integer orderCnt = 0 ; orderCnt < orderTot ; orderCnt++)
        {
            OBJ_Order__c obj = orders[orderCnt];
            switch on obj.Name {
                when '0001' {
                    System.assertEquals('1000', obj.FLD_SalesOrganization__c);
                    System.assertEquals('100', obj.FLD_DistributionChannel__c);
                }
                when '0002' {
                    System.assertEquals('2000', obj.FLD_SalesOrganization__c);
                    System.assertEquals('200', obj.FLD_DistributionChannel__c);
                }
            }
        }        

        UTIL_OrderSyncBatch.getTotalRecordCount();
        UTIL_OrderSyncBatch.getNextIncrementalRecordCount();
    }

    @isTest
    public static void test_QuoteSync()
    {
        ensxsdk.EnosixFramework.setMock(SBO_EnosixSalesDocSync_Search.class, new MockSyncSearch());
        UTIL_AppSettings.settingsMap.put(UTIL_AppSettings.Prefix + UTIL_AppSettings.QuoteSyncBatch + UTIL_AppSettings.Suffix, (Map<String, Object>)JSON.deserializeUntyped(TEST_JSON));

        OBJ_Quote__c quote = new OBJ_Quote__c();
        quote.Name = '1';
        TSTU_SFTestObject.upsertWithRetry(quote);

        OBJ_Quote_Item__c quoteItem = new OBJ_Quote_Item__c();
        quoteItem.Name = '1';
        quoteItem.FLD_OBJ_Quote__c = quote.Id;
        TSTU_SFTestObject.upsertWithRetry(quoteItem);

        OBJ_SAP_Sync__c sapSync = new OBJ_SAP_Sync__c();
        sapSync.Name = 'UTIL_QuoteSyncSchedule';
        sapSync.FLD_Sync_DateTime__c = System.today().addDays(-1);
        sapSync.FLD_Page_Number__c = 0;
        TSTU_SFTestObject.upsertWithRetry(sapSync);

        UTIL_QuoteSyncBatch controller = new UTIL_QuoteSyncBatch();
        UTIL_SyncHelper.LastSync lastSync = new UTIL_SyncHelper.LastSync();
        lastSync.retryCnt = 1;
        controller.setBatchParam(lastSync);
        
        Test.startTest();
        Database.executeBatch(controller);
        Test.stopTest();

        List<OBJ_Quote__c> quotes = [SELECT Id, Name, FLD_SalesOrganization__c, FLD_DistributionChannel__c FROM OBJ_Quote__c];
        System.assertEquals(1, quotes.size());
        
        Integer quoteTot = quotes.size();
        for (Integer quoteCnt = 0 ; quoteCnt < quoteTot ; quoteCnt++)
        {
            OBJ_Quote__c obj = quotes[quoteCnt];
            switch on obj.Name {
                when '0001' {
                    System.assertEquals('1000', obj.FLD_SalesOrganization__c);
                    System.assertEquals('100', obj.FLD_DistributionChannel__c);
                }
                when '0002' {
                    System.assertEquals('2000', obj.FLD_SalesOrganization__c);
                    System.assertEquals('200', obj.FLD_DistributionChannel__c);
                }
            }
        }        

        UTIL_QuoteSyncBatch.getTotalRecordCount();
        UTIL_QuoteSyncBatch.getNextIncrementalRecordCount();
    }

    @isTest
    public static void test_MissingTransactionGroupSync()
    {
        ensxsdk.EnosixFramework.setMock(SBO_EnosixSalesDocSync_Search.class, new MockSyncSearch());
        UTIL_AppSettings.settingsMap.put(UTIL_AppSettings.Prefix + UTIL_AppSettings.QuoteSyncBatch + UTIL_AppSettings.Suffix, (Map<String, Object>)JSON.deserializeUntyped(TEST_JSON));

        UTIL_QuoteSyncBatch controller = new UTIL_QuoteSyncBatch();
        UTIL_SyncHelper.LastSync lastSync = new UTIL_SyncHelper.LastSync();
        lastSync.retryCnt = 1;
        controller.setBatchParam(lastSync);
        controller.transactionGroup = '';
        
        Test.startTest();
        Database.executeBatch(controller);
        Test.stopTest();
    }

    @isTest
    public static void test_SalesDocSyncFailure()
    {
        MockSyncSearch mocSyncSearch = new MockSyncSearch();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixSalesDocSync_Search.class, mocSyncSearch);
        mocSyncSearch.setSuccess(false);

        UTIL_QuoteSyncBatch controller = new UTIL_QuoteSyncBatch();
        Test.startTest();
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

    @isTest
    public static void test_SalesDocSyncException()
    {
        MockSyncSearch mocSyncSearch = new MockSyncSearch();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixSalesDocSync_Search.class, mocSyncSearch);
        mocSyncSearch.setThrowException(true);

        UTIL_QuoteSyncBatch controller = new UTIL_QuoteSyncBatch();
        Test.startTest();
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
}