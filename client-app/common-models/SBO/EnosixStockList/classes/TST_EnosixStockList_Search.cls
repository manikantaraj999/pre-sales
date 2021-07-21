/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
private class TST_EnosixStockList_Search
{

    public class MockSBO_EnosixStockList_Search implements ensxsdk.EnosixFramework.SearchSBOInitMock, ensxsdk.EnosixFramework.SearchSBOSearchMock
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
        ensxsdk.EnosixFramework.setMock(SBO_EnosixStockList_Search.class, new MockSBO_EnosixStockList_Search());
        SBO_EnosixStockList_Search sbo = new SBO_EnosixStockList_Search();
        System.assertEquals(SBO_EnosixStockList_Search.class, sbo.getType(), 'getType() does not match object type.');

        System.assertEquals(null, sbo.initialize(null));
        System.assertEquals(null, sbo.search(null));

        SBO_EnosixStockList_Search.EnosixStockList_SC sc = new SBO_EnosixStockList_Search.EnosixStockList_SC();
        System.assertEquals(SBO_EnosixStockList_Search.EnosixStockList_SC.class, sc.getType(), 'getType() does not match object type.');

        sc.registerReflectionForClass();
        System.assertEquals(null, sc.result);

        System.assertNotEquals(null, sc.SEARCHPARAMS);

    }
    
    
    @isTest
    static void testSEARCHPARAMS()
    {
        SBO_EnosixStockList_Search.SEARCHPARAMS childObj = new SBO_EnosixStockList_Search.SEARCHPARAMS();
        System.assertEquals(SBO_EnosixStockList_Search.SEARCHPARAMS.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.Material = 'X';
        System.assertEquals('X', childObj.Material);

        childObj.Plant = 'X';
        System.assertEquals('X', childObj.Plant);

        childObj.FromDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.FromDate);

        childObj.ToDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.ToDate);


    }

    @isTest
    static void testEnosixStockList_SR()
    {
        SBO_EnosixStockList_Search.EnosixStockList_SR sr = new SBO_EnosixStockList_Search.EnosixStockList_SR();

        sr.registerReflectionForClass();

        System.assertEquals(SBO_EnosixStockList_Search.EnosixStockList_SR.class, sr.getType(), 'getType() does not match object type.');

        System.assertNotEquals(null, sr.getResults());
    }


    @isTest
    static void testSEARCHRESULT()
    {
        SBO_EnosixStockList_Search.SEARCHRESULT childObj = new SBO_EnosixStockList_Search.SEARCHRESULT();
        System.assertEquals(SBO_EnosixStockList_Search.SEARCHRESULT.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        SBO_EnosixStockList_Search.SEARCHRESULT_COLLECTION childObjCollection = new SBO_EnosixStockList_Search.SEARCHRESULT_COLLECTION();
        System.assertNotEquals(null, childObjCollection.getAsList());

        childObj.Material = 'X';
        System.assertEquals('X', childObj.Material);

        childObj.Plant = 'X';
        System.assertEquals('X', childObj.Plant);

        childObj.ReceiptRequirementDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.ReceiptRequirementDate);

        childObj.MRPElement = 'X';
        System.assertEquals('X', childObj.MRPElement);

        childObj.MRPElementData = 'X';
        System.assertEquals('X', childObj.MRPElementData);

        childObj.ReschedulingDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.ReschedulingDate);

        childObj.QtyReceivedReserved = 1.5;
        System.assertEquals(1.5, childObj.QtyReceivedReserved);

        childObj.AvailableQty = 1.5;
        System.assertEquals(1.5, childObj.AvailableQty);

        childObj.AvailableQtyAfterAssignment = 1.5;
        System.assertEquals(1.5, childObj.AvailableQtyAfterAssignment);

        childObj.StorageLocation = 'X';
        System.assertEquals('X', childObj.StorageLocation);


    }

}