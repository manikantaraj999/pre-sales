/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
private class TST_EnosixDL_Search
{

    public class MockSBO_EnosixDL_Search implements ensxsdk.EnosixFramework.SearchSBOInitMock, ensxsdk.EnosixFramework.SearchSBOSearchMock
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
        ensxsdk.EnosixFramework.setMock(SBO_EnosixDL_Search.class, new MockSBO_EnosixDL_Search());
        SBO_EnosixDL_Search sbo = new SBO_EnosixDL_Search();
        System.assertEquals(SBO_EnosixDL_Search.class, sbo.getType(), 'getType() does not match object type.');

        System.assertEquals(null, sbo.initialize(null));
        System.assertEquals(null, sbo.search(null));

        SBO_EnosixDL_Search.EnosixDL_SC sc = new SBO_EnosixDL_Search.EnosixDL_SC();
        System.assertEquals(SBO_EnosixDL_Search.EnosixDL_SC.class, sc.getType(), 'getType() does not match object type.');

        sc.registerReflectionForClass();
        System.assertEquals(null, sc.result);

        System.assertNotEquals(null, sc.SEARCHPARAMS);

    }
    
    
    @isTest
    static void testSEARCHPARAMS()
    {
        SBO_EnosixDL_Search.SEARCHPARAMS childObj = new SBO_EnosixDL_Search.SEARCHPARAMS();
        System.assertEquals(SBO_EnosixDL_Search.SEARCHPARAMS.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.Route = 'X';
        System.assertEquals('X', childObj.Route);

        childObj.Truck = 'X';
        System.assertEquals('X', childObj.Truck);

        childObj.FromCreateDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.FromCreateDate);

        childObj.ToCreateDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.ToCreateDate);

        childObj.DeliveryDateFrom = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.DeliveryDateFrom);

        childObj.DeliveryDateTo = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.DeliveryDateTo);

        childObj.DeliveryFrom = 'X';
        System.assertEquals('X', childObj.DeliveryFrom);

        childObj.DeliveryTo = 'X';
        System.assertEquals('X', childObj.DeliveryTo);

        childObj.SoldToParty = 'X';
        System.assertEquals('X', childObj.SoldToParty);

        childObj.ShipToParty = 'X';
        System.assertEquals('X', childObj.ShipToParty);

        childObj.DeliveryType = 'X';
        System.assertEquals('X', childObj.DeliveryType);

        childObj.ShippingPoint = 'X';
        System.assertEquals('X', childObj.ShippingPoint);

        childObj.ShippingConditions = 'X';
        System.assertEquals('X', childObj.ShippingConditions);

        childObj.DeliveryPriority = 'X';
        System.assertEquals('X', childObj.DeliveryPriority);

        childObj.BillofLading = 'X';
        System.assertEquals('X', childObj.BillofLading);

        childObj.PGIDateFrom = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.PGIDateFrom);

        childObj.PGIDateTo = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.PGIDateTo);

        childObj.Username = 'X';
        System.assertEquals('X', childObj.Username);

        childObj.Open = true;
        System.assertEquals(true, childObj.Open);

        childObj.Picked = true;
        System.assertEquals(true, childObj.Picked);

        childObj.Packed = true;
        System.assertEquals(true, childObj.Packed);

        childObj.PGIed = true;
        System.assertEquals(true, childObj.PGIed);


    }

    @isTest
    static void testEnosixDL_SR()
    {
        SBO_EnosixDL_Search.EnosixDL_SR sr = new SBO_EnosixDL_Search.EnosixDL_SR();

        sr.registerReflectionForClass();

        System.assertEquals(SBO_EnosixDL_Search.EnosixDL_SR.class, sr.getType(), 'getType() does not match object type.');

        System.assertNotEquals(null, sr.getResults());
    }


    @isTest
    static void testSEARCHRESULT()
    {
        SBO_EnosixDL_Search.SEARCHRESULT childObj = new SBO_EnosixDL_Search.SEARCHRESULT();
        System.assertEquals(SBO_EnosixDL_Search.SEARCHRESULT.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        SBO_EnosixDL_Search.SEARCHRESULT_COLLECTION childObjCollection = new SBO_EnosixDL_Search.SEARCHRESULT_COLLECTION();
        System.assertNotEquals(null, childObjCollection.getAsList());

        childObj.Delivery = 'X';
        System.assertEquals('X', childObj.Delivery);

        childObj.Route = 'X';
        System.assertEquals('X', childObj.Route);

        childObj.Truck = 'X';
        System.assertEquals('X', childObj.Truck);

        childObj.BillofLading = 'X';
        System.assertEquals('X', childObj.BillofLading);

        childObj.CreateDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.CreateDate);

        childObj.DeliveryDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.DeliveryDate);

        childObj.PGIDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.PGIDate);

        childObj.DeliveryType = 'X';
        System.assertEquals('X', childObj.DeliveryType);

        childObj.DeliveryTypeText = 'X';
        System.assertEquals('X', childObj.DeliveryTypeText);

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

        childObj.ShippingPoint = 'X';
        System.assertEquals('X', childObj.ShippingPoint);

        childObj.ShippingConditions = 'X';
        System.assertEquals('X', childObj.ShippingConditions);

        childObj.DeliveryPriority = 'X';
        System.assertEquals('X', childObj.DeliveryPriority);

        childObj.NetOrderValue = 1.5;
        System.assertEquals(1.5, childObj.NetOrderValue);

        childObj.SalesDocumentCurrency = 'X';
        System.assertEquals('X', childObj.SalesDocumentCurrency);

        childObj.DeliveryStatus = 'X';
        System.assertEquals('X', childObj.DeliveryStatus);


    }

}