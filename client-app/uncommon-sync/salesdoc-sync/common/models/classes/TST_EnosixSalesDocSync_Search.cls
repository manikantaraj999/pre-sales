/// enosiX Inc. Generated Apex Model
/// Generated On: 2/14/2019 12:08:50 PM
/// SAP Host: From REST Service On: https://customer-speed-3702-dev-ed.cs1.my.salesforce.com
/// CID: From REST Service On: https://customer-speed-3702-dev-ed.cs1.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
private class TST_EnosixSalesDocSync_Search
{

    public class MockSBO_EnosixSalesDocSync_Search implements ensxsdk.EnosixFramework.SearchSBOInitMock, ensxsdk.EnosixFramework.SearchSBOSearchMock
    {
        public ensxsdk.EnosixFramework.SearchContext executeInitialize(ensxsdk.EnosixFramework.SearchContext sc)
        {
            return null;
        }
        public ensxsdk.EnosixFramework.SearchContext executeSearch(ensxsdk.EnosixFramework.SearchContext sc)
        {
            return null;
        }
    }

    @isTest
    static void testSBO()
    {
        ensxsdk.EnosixFramework.setMock(SBO_EnosixSalesDocSync_Search.class, new MockSBO_EnosixSalesDocSync_Search());
        SBO_EnosixSalesDocSync_Search sbo = new SBO_EnosixSalesDocSync_Search();
        System.assertEquals(SBO_EnosixSalesDocSync_Search.class, sbo.getType(), 'getType() does not match object type.');

        System.assertEquals(null, sbo.initialize(null));
        System.assertEquals(null, sbo.search(null));

        SBO_EnosixSalesDocSync_Search.EnosixSalesDocSync_SC sc = new SBO_EnosixSalesDocSync_Search.EnosixSalesDocSync_SC();
        System.assertEquals(SBO_EnosixSalesDocSync_Search.EnosixSalesDocSync_SC.class, sc.getType(), 'getType() does not match object type.');

        sc.registerReflectionForClass();
        System.assertEquals(null, sc.result);

        System.assertNotEquals(null, sc.SEARCHPARAMS);
        System.assertNotEquals(null, sc.DOC_TYPE);

    }
    
    
    @isTest
    static void testSEARCHPARAMS()
    {
        SBO_EnosixSalesDocSync_Search.SEARCHPARAMS childObj = new SBO_EnosixSalesDocSync_Search.SEARCHPARAMS();
        System.assertEquals(SBO_EnosixSalesDocSync_Search.SEARCHPARAMS.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.DateFrom = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.DateFrom);

        childObj.InitialLoad = true;
        System.assertEquals(true, childObj.InitialLoad);

        childObj.TransactionGroup = 'X';
        System.assertEquals('X', childObj.TransactionGroup);


    }

    @isTest
    static void testDOC_TYPE()
    {
        SBO_EnosixSalesDocSync_Search.DOC_TYPE childObj = new SBO_EnosixSalesDocSync_Search.DOC_TYPE();
        System.assertEquals(SBO_EnosixSalesDocSync_Search.DOC_TYPE.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        SBO_EnosixSalesDocSync_Search.DOC_TYPE_COLLECTION childObjCollection = new SBO_EnosixSalesDocSync_Search.DOC_TYPE_COLLECTION();
        System.assertNotEquals(null, childObjCollection.getAsList());

        childObj.SalesDocumentType = 'X';
        System.assertEquals('X', childObj.SalesDocumentType);


    }

    @isTest
    static void testEnosixSalesDocSync_SR()
    {
        SBO_EnosixSalesDocSync_Search.EnosixSalesDocSync_SR sr = new SBO_EnosixSalesDocSync_Search.EnosixSalesDocSync_SR();

        sr.registerReflectionForClass();

        System.assertEquals(SBO_EnosixSalesDocSync_Search.EnosixSalesDocSync_SR.class, sr.getType(), 'getType() does not match object type.');

        System.assertNotEquals(null, sr.getResults());
    }


    @isTest
    static void testSEARCHRESULT()
    {
        SBO_EnosixSalesDocSync_Search.SEARCHRESULT childObj = new SBO_EnosixSalesDocSync_Search.SEARCHRESULT();
        System.assertEquals(SBO_EnosixSalesDocSync_Search.SEARCHRESULT.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        SBO_EnosixSalesDocSync_Search.SEARCHRESULT_COLLECTION childObjCollection = new SBO_EnosixSalesDocSync_Search.SEARCHRESULT_COLLECTION();
        System.assertNotEquals(null, childObjCollection.getAsList());

        childObj.SalesDocument = 'X';
        System.assertEquals('X', childObj.SalesDocument);

        childObj.CustomerNumber = 'X';
        System.assertEquals('X', childObj.CustomerNumber);

        childObj.CustomerName = 'X';
        System.assertEquals('X', childObj.CustomerName);

        childObj.ShipToParty = 'X';
        System.assertEquals('X', childObj.ShipToParty);

        childObj.ShipToName = 'X';
        System.assertEquals('X', childObj.ShipToName);

        childObj.RequestedDeliveryDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.RequestedDeliveryDate);

        childObj.CreateDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.CreateDate);

        childObj.CreatedBy = 'X';
        System.assertEquals('X', childObj.CreatedBy);

        childObj.CustomerPurchaseOrderNumber = 'X';
        System.assertEquals('X', childObj.CustomerPurchaseOrderNumber);

        childObj.CustomerPurchaseOrderDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.CustomerPurchaseOrderDate);

        childObj.NetOrderValue = 1.5;
        System.assertEquals(1.5, childObj.NetOrderValue);

        childObj.TaxAmount = 1.5;
        System.assertEquals(1.5, childObj.TaxAmount);

        childObj.SalesDocumentType = 'X';
        System.assertEquals('X', childObj.SalesDocumentType);

        childObj.SalesOrganization = 'X';
        System.assertEquals('X', childObj.SalesOrganization);

        childObj.DistributionChannel = 'X';
        System.assertEquals('X', childObj.DistributionChannel);

        childObj.Division = 'X';
        System.assertEquals('X', childObj.Division);

        childObj.TransactionGroup = 'X';
        System.assertEquals('X', childObj.TransactionGroup);

        childObj.DeliveryBlock = 'X';
        System.assertEquals('X', childObj.DeliveryBlock);

        childObj.BillingBlock = 'X';
        System.assertEquals('X', childObj.BillingBlock);

        childObj.TermsofPaymentKey = 'X';
        System.assertEquals('X', childObj.TermsofPaymentKey);

        childObj.IncotermsPart1 = 'X';
        System.assertEquals('X', childObj.IncotermsPart1);

        childObj.IncotermsPart2 = 'X';
        System.assertEquals('X', childObj.IncotermsPart2);


    }

}