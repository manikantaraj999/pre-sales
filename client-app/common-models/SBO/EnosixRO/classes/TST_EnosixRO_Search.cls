/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
private class TST_EnosixRO_Search
{

    public class MockSBO_EnosixRO_Search implements ensxsdk.EnosixFramework.SearchSBOInitMock, ensxsdk.EnosixFramework.SearchSBOSearchMock
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
        ensxsdk.EnosixFramework.setMock(SBO_EnosixRO_Search.class, new MockSBO_EnosixRO_Search());
        SBO_EnosixRO_Search sbo = new SBO_EnosixRO_Search();
        System.assertEquals(SBO_EnosixRO_Search.class, sbo.getType(), 'getType() does not match object type.');

        System.assertEquals(null, sbo.initialize(null));
        System.assertEquals(null, sbo.search(null));

        SBO_EnosixRO_Search.EnosixRO_SC sc = new SBO_EnosixRO_Search.EnosixRO_SC();
        System.assertEquals(SBO_EnosixRO_Search.EnosixRO_SC.class, sc.getType(), 'getType() does not match object type.');

        sc.registerReflectionForClass();
        System.assertEquals(null, sc.result);

        System.assertNotEquals(null, sc.SEARCHPARAMS);

    }
    
    
    @isTest
    static void testSEARCHPARAMS()
    {
        SBO_EnosixRO_Search.SEARCHPARAMS childObj = new SBO_EnosixRO_Search.SEARCHPARAMS();
        System.assertEquals(SBO_EnosixRO_Search.SEARCHPARAMS.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.FromSalesDocumentNumber = 'X';
        System.assertEquals('X', childObj.FromSalesDocumentNumber);

        childObj.ToSalesDocumentNumber = 'X';
        System.assertEquals('X', childObj.ToSalesDocumentNumber);

        childObj.SoldToParty = 'X';
        System.assertEquals('X', childObj.SoldToParty);

        childObj.ShipToParty = 'X';
        System.assertEquals('X', childObj.ShipToParty);

        childObj.CustomerPONumber = 'X';
        System.assertEquals('X', childObj.CustomerPONumber);

        childObj.Material = 'X';
        System.assertEquals('X', childObj.Material);

        childObj.SalesDocumentType = 'X';
        System.assertEquals('X', childObj.SalesDocumentType);

        childObj.FromCreateDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.FromCreateDate);

        childObj.ToCreateDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.ToCreateDate);

        childObj.OpenOnly = true;
        System.assertEquals(true, childObj.OpenOnly);

        childObj.CompletedOnly = true;
        System.assertEquals(true, childObj.CompletedOnly);

        childObj.Username = 'X';
        System.assertEquals('X', childObj.Username);

        childObj.SalesDocumentVersionNumber = 'X';
        System.assertEquals('X', childObj.SalesDocumentVersionNumber);

        childObj.YourReference = 'X';
        System.assertEquals('X', childObj.YourReference);

        childObj.ShipToPurchaseOrderNumber = 'X';
        System.assertEquals('X', childObj.ShipToPurchaseOrderNumber);

        childObj.ShipToName = 'X';
        System.assertEquals('X', childObj.ShipToName);

        childObj.SoldToName = 'X';
        System.assertEquals('X', childObj.SoldToName);


    }

    @isTest
    static void testEnosixRO_SR()
    {
        SBO_EnosixRO_Search.EnosixRO_SR sr = new SBO_EnosixRO_Search.EnosixRO_SR();

        sr.registerReflectionForClass();

        System.assertEquals(SBO_EnosixRO_Search.EnosixRO_SR.class, sr.getType(), 'getType() does not match object type.');

        System.assertNotEquals(null, sr.getResults());
    }


    @isTest
    static void testSEARCHRESULT()
    {
        SBO_EnosixRO_Search.SEARCHRESULT childObj = new SBO_EnosixRO_Search.SEARCHRESULT();
        System.assertEquals(SBO_EnosixRO_Search.SEARCHRESULT.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        SBO_EnosixRO_Search.SEARCHRESULT_COLLECTION childObjCollection = new SBO_EnosixRO_Search.SEARCHRESULT_COLLECTION();
        System.assertNotEquals(null, childObjCollection.getAsList());

        childObj.SalesDocument = 'X';
        System.assertEquals('X', childObj.SalesDocument);

        childObj.CustomerPONumber = 'X';
        System.assertEquals('X', childObj.CustomerPONumber);

        childObj.CreateDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.CreateDate);

        childObj.SalesDocumentType = 'X';
        System.assertEquals('X', childObj.SalesDocumentType);

        childObj.SalesDocumentTypeDescription = 'X';
        System.assertEquals('X', childObj.SalesDocumentTypeDescription);

        childObj.SoldToParty = 'X';
        System.assertEquals('X', childObj.SoldToParty);

        childObj.SoldToName = 'X';
        System.assertEquals('X', childObj.SoldToName);

        childObj.SoldToCity = 'X';
        System.assertEquals('X', childObj.SoldToCity);

        childObj.SoldToRegion = 'X';
        System.assertEquals('X', childObj.SoldToRegion);

        childObj.ShipToParty = 'X';
        System.assertEquals('X', childObj.ShipToParty);

        childObj.ShipToName = 'X';
        System.assertEquals('X', childObj.ShipToName);

        childObj.ShipToCity = 'X';
        System.assertEquals('X', childObj.ShipToCity);

        childObj.ShipToRegion = 'X';
        System.assertEquals('X', childObj.ShipToRegion);

        childObj.NetTotalValue = 1.5;
        System.assertEquals(1.5, childObj.NetTotalValue);

        childObj.NetTotalTax = 1.5;
        System.assertEquals(1.5, childObj.NetTotalTax);

        childObj.SalesDocumentCurrency = 'X';
        System.assertEquals('X', childObj.SalesDocumentCurrency);

        childObj.OrderStatus = 'X';
        System.assertEquals('X', childObj.OrderStatus);

        childObj.SalesDocumentVersionNumber = 'X';
        System.assertEquals('X', childObj.SalesDocumentVersionNumber);

        childObj.YourReference = 'X';
        System.assertEquals('X', childObj.YourReference);

        childObj.ShipToPurchaseOrderNumber = 'X';
        System.assertEquals('X', childObj.ShipToPurchaseOrderNumber);


    }

}