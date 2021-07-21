/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
private class TST_EnosixInvoice_Search
{

    public class MockSBO_EnosixInvoice_Search implements ensxsdk.EnosixFramework.SearchSBOInitMock, ensxsdk.EnosixFramework.SearchSBOSearchMock
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
        ensxsdk.EnosixFramework.setMock(SBO_EnosixInvoice_Search.class, new MockSBO_EnosixInvoice_Search());
        SBO_EnosixInvoice_Search sbo = new SBO_EnosixInvoice_Search();
        System.assertEquals(SBO_EnosixInvoice_Search.class, sbo.getType(), 'getType() does not match object type.');

        System.assertEquals(null, sbo.initialize(null));
        System.assertEquals(null, sbo.search(null));

        SBO_EnosixInvoice_Search.EnosixInvoice_SC sc = new SBO_EnosixInvoice_Search.EnosixInvoice_SC();
        System.assertEquals(SBO_EnosixInvoice_Search.EnosixInvoice_SC.class, sc.getType(), 'getType() does not match object type.');

        sc.registerReflectionForClass();
        System.assertEquals(null, sc.result);

        System.assertNotEquals(null, sc.SEARCHPARAMS);

    }
    
    
    @isTest
    static void testSEARCHPARAMS()
    {
        SBO_EnosixInvoice_Search.SEARCHPARAMS childObj = new SBO_EnosixInvoice_Search.SEARCHPARAMS();
        System.assertEquals(SBO_EnosixInvoice_Search.SEARCHPARAMS.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.FromBillingDocumentNumber = 'X';
        System.assertEquals('X', childObj.FromBillingDocumentNumber);

        childObj.ToBillingDocumentNumber = 'X';
        System.assertEquals('X', childObj.ToBillingDocumentNumber);

        childObj.SalesOrganization = 'X';
        System.assertEquals('X', childObj.SalesOrganization);

        childObj.Payer = 'X';
        System.assertEquals('X', childObj.Payer);

        childObj.SoldToParty = 'X';
        System.assertEquals('X', childObj.SoldToParty);

        childObj.BillingType = 'X';
        System.assertEquals('X', childObj.BillingType);

        childObj.FromBillingDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.FromBillingDate);

        childObj.ToBillingDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.ToBillingDate);

        childObj.FromCreateDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.FromCreateDate);

        childObj.ToCreateDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.ToCreateDate);

        childObj.CreatedBy = 'X';
        System.assertEquals('X', childObj.CreatedBy);


    }

    @isTest
    static void testEnosixInvoice_SR()
    {
        SBO_EnosixInvoice_Search.EnosixInvoice_SR sr = new SBO_EnosixInvoice_Search.EnosixInvoice_SR();

        sr.registerReflectionForClass();

        System.assertEquals(SBO_EnosixInvoice_Search.EnosixInvoice_SR.class, sr.getType(), 'getType() does not match object type.');

        System.assertNotEquals(null, sr.getResults());
    }


    @isTest
    static void testSEARCHRESULT()
    {
        SBO_EnosixInvoice_Search.SEARCHRESULT childObj = new SBO_EnosixInvoice_Search.SEARCHRESULT();
        System.assertEquals(SBO_EnosixInvoice_Search.SEARCHRESULT.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        SBO_EnosixInvoice_Search.SEARCHRESULT_COLLECTION childObjCollection = new SBO_EnosixInvoice_Search.SEARCHRESULT_COLLECTION();
        System.assertNotEquals(null, childObjCollection.getAsList());

        childObj.BillingDocument = 'X';
        System.assertEquals('X', childObj.BillingDocument);

        childObj.BillingType = 'X';
        System.assertEquals('X', childObj.BillingType);

        childObj.BillingTypeDescription = 'X';
        System.assertEquals('X', childObj.BillingTypeDescription);

        childObj.CompanyCode = 'X';
        System.assertEquals('X', childObj.CompanyCode);

        childObj.CompanyCodeName = 'X';
        System.assertEquals('X', childObj.CompanyCodeName);

        childObj.SalesOrganization = 'X';
        System.assertEquals('X', childObj.SalesOrganization);

        childObj.SalesOrgDescription = 'X';
        System.assertEquals('X', childObj.SalesOrgDescription);

        childObj.BillingDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.BillingDate);

        childObj.ShipDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.ShipDate);

        childObj.SalesOrderNumber = 'X';
        System.assertEquals('X', childObj.SalesOrderNumber);

        childObj.Payer = 'X';
        System.assertEquals('X', childObj.Payer);

        childObj.PayerName = 'X';
        System.assertEquals('X', childObj.PayerName);

        childObj.SoldToParty = 'X';
        System.assertEquals('X', childObj.SoldToParty);

        childObj.SoldToName = 'X';
        System.assertEquals('X', childObj.SoldToName);

        childObj.ShipToParty = 'X';
        System.assertEquals('X', childObj.ShipToParty);

        childObj.ShipToName = 'X';
        System.assertEquals('X', childObj.ShipToName);

        childObj.TrackingNumber = 'X';
        System.assertEquals('X', childObj.TrackingNumber);

        childObj.NetOrderValue = 1.5;
        System.assertEquals(1.5, childObj.NetOrderValue);

        childObj.TaxAmount = 1.5;
        System.assertEquals(1.5, childObj.TaxAmount);

        childObj.SalesDocumentCurrency = 'X';
        System.assertEquals('X', childObj.SalesDocumentCurrency);

        childObj.CreatedBy = 'X';
        System.assertEquals('X', childObj.CreatedBy);

        childObj.CreateDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.CreateDate);

        childObj.BillingStatus = 'X';
        System.assertEquals('X', childObj.BillingStatus);

        childObj.BillingStatusDescription = 'X';
        System.assertEquals('X', childObj.BillingStatusDescription);


    }

}