@isTest
public with sharing class TSTU_InvoiceSyncBatch
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

            SBO_EnosixInvoiceSync_Search.EnosixInvoiceSync_SR searchResult =
                new SBO_EnosixInvoiceSync_Search.EnosixInvoiceSync_SR();

            // New Account
            SBO_EnosixInvoiceSync_Search.SEARCHRESULT result1 =
                new SBO_EnosixInvoiceSync_Search.SEARCHRESULT();

            result1.BillingDocument = '0001';

            searchResult.SearchResults.add(result1);

            // Existing Account
            SBO_EnosixInvoiceSync_Search.SEARCHRESULT result2 =
                new SBO_EnosixInvoiceSync_Search.SEARCHRESULT();

            result2.BillingDocument = '0002';

            searchResult.SearchResults.add(result2);

            SBO_EnosixInvoiceSync_Search.SEARCHRESULT result3 =
                new SBO_EnosixInvoiceSync_Search.SEARCHRESULT();

            result3.BillingDocument = '';

            searchResult.SearchResults.add(result3);

            searchResult.setSuccess(this.success);
            searchContext.baseResult = searchResult;
            return searchContext;
        }
    }

    public static testMethod void test_InvoiceSync()
    {
        ensxsdk.EnosixFramework.setMock(SBO_EnosixInvoiceSync_Search.class, new MockSyncSearch());
        
        UTIL_AppSettings.settingsMap.put(UTIL_AppSettings.Prefix + UTIL_AppSettings.InvoiceSyncBatch + UTIL_AppSettings.Suffix, (Map<String, Object>)JSON.deserializeUntyped(TEST_JSON));
        createExistingObject();
        Test.startTest();
        UTIL_InvoiceSyncBatch controller = new UTIL_InvoiceSyncBatch();
        UTIL_SyncHelper.LastSync lastSync = new UTIL_SyncHelper.LastSync();
        lastSync.retryCnt = 1;
        controller.setBatchParam(lastSync);
        Database.executeBatch(controller);
        Test.stopTest();
    }

    public static testMethod void test_InvoiceSyncInitialLoad()
    {
        ensxsdk.EnosixFramework.setMock(SBO_EnosixInvoiceSync_Search.class, new MockSyncSearch());
        
        UTIL_AppSettings.settingsMap.put(UTIL_AppSettings.Prefix + UTIL_AppSettings.InvoiceSyncBatch + UTIL_AppSettings.Suffix, (Map<String, Object>)JSON.deserializeUntyped(TEST_JSON));
        Test.startTest();
        UTIL_InvoiceSyncBatch controller = new UTIL_InvoiceSyncBatch();
        UTIL_SyncHelper.LastSync lastSync = new UTIL_SyncHelper.LastSync();
        lastSync.retryCnt = 1;
        controller.setBatchParam(lastSync);
        Database.executeBatch(controller);
        Test.stopTest();
    }

    public static testMethod void test_InvoiceSyncFailure()
    {
        MockSyncSearch mockSyncSearch = new MockSyncSearch();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixInvoiceSync_Search.class, mockSyncSearch);
        mockSyncSearch.setSuccess(false);

        createExistingObject();
        Test.startTest();
        UTIL_InvoiceSyncBatch controller = new UTIL_InvoiceSyncBatch();
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

    public static testMethod void test_InvoiceSyncException()
    {
        MockSyncSearch mockSyncSearch = new MockSyncSearch();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixInvoiceSync_Search.class, mockSyncSearch);
        mockSyncSearch.setThrowException(true);

        createExistingObject();
        Test.startTest();
        UTIL_InvoiceSyncBatch controller = new UTIL_InvoiceSyncBatch();
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
        ensxsdk.EnosixFramework.setMock(SBO_EnosixInvoiceSync_Search.class, new MockSyncSearch());

        Test.startTest();
        UTIL_InvoiceSyncBatch.getTotalRecordCount();
        UTIL_InvoiceSyncBatch.getNextIncrementalRecordCount();
        Test.stopTest();
    }

    private static void createExistingObject()
    {
        OBJ_Invoice__c invoice = new OBJ_Invoice__c();
        invoice.Name = '0001';
        TSTU_SFTestObject.upsertWithRetry(invoice);

        OBJ_Invoice_Item__c invoiceItem = new OBJ_Invoice_Item__c();
        invoiceItem.Name = '0001';
        invoiceItem.FLD_OBJ_Invoice__c = invoice.Id;
        TSTU_SFTestObject.upsertWithRetry(invoiceItem);

        OBJ_SAP_Sync__c sapSync = new OBJ_SAP_Sync__c();
        sapSync.Name = 'UTIL_InvoiceSyncSchedule';
        sapSync.FLD_Sync_DateTime__c = System.today().addDays(-1);
        sapSync.FLD_Page_Number__c = 0;
        TSTU_SFTestObject.upsertWithRetry(sapSync);
    }
}