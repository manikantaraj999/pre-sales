/// enosiX Inc. Generated Apex Model
/// Generated On: 2/18/2019 5:30:54 PM
/// SAP Host: From REST Service On: https://app-speed-4607-dev-ed.cs11.my.salesforce.com
/// CID: From REST Service On: https://app-speed-4607-dev-ed.cs11.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
private class TST_EnosixInvoiceSync_Search
{

    public class MockSBO_EnosixInvoiceSync_Search implements ensxsdk.EnosixFramework.SearchSBOInitMock, ensxsdk.EnosixFramework.SearchSBOSearchMock
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
        ensxsdk.EnosixFramework.setMock(SBO_EnosixInvoiceSync_Search.class, new MockSBO_EnosixInvoiceSync_Search());
        SBO_EnosixInvoiceSync_Search sbo = new SBO_EnosixInvoiceSync_Search();
        System.assertEquals(SBO_EnosixInvoiceSync_Search.class, sbo.getType(), 'getType() does not match object type.');

        System.assertEquals(null, sbo.initialize(null));
        System.assertEquals(null, sbo.search(null));

        SBO_EnosixInvoiceSync_Search.EnosixInvoiceSync_SC sc = new SBO_EnosixInvoiceSync_Search.EnosixInvoiceSync_SC();
        System.assertEquals(SBO_EnosixInvoiceSync_Search.EnosixInvoiceSync_SC.class, sc.getType(), 'getType() does not match object type.');

        sc.registerReflectionForClass();
        System.assertEquals(null, sc.result);

        System.assertNotEquals(null, sc.SEARCHPARAMS);

    }
    
    
    @isTest
    static void testSEARCHPARAMS()
    {
        SBO_EnosixInvoiceSync_Search.SEARCHPARAMS childObj = new SBO_EnosixInvoiceSync_Search.SEARCHPARAMS();
        System.assertEquals(SBO_EnosixInvoiceSync_Search.SEARCHPARAMS.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.DateFrom = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.DateFrom);

        childObj.X_INITIALLOAD = true;
        System.assertEquals(true, childObj.X_INITIALLOAD);

        childObj.DateTo = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.DateTo);


    }

    @isTest
    static void testEnosixInvoiceSync_SR()
    {
        SBO_EnosixInvoiceSync_Search.EnosixInvoiceSync_SR sr = new SBO_EnosixInvoiceSync_Search.EnosixInvoiceSync_SR();

        sr.registerReflectionForClass();

        System.assertEquals(SBO_EnosixInvoiceSync_Search.EnosixInvoiceSync_SR.class, sr.getType(), 'getType() does not match object type.');

        System.assertNotEquals(null, sr.getResults());
    }


    @isTest
    static void testSEARCHRESULT()
    {
        SBO_EnosixInvoiceSync_Search.SEARCHRESULT childObj = new SBO_EnosixInvoiceSync_Search.SEARCHRESULT();
        System.assertEquals(SBO_EnosixInvoiceSync_Search.SEARCHRESULT.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        SBO_EnosixInvoiceSync_Search.SEARCHRESULT_COLLECTION childObjCollection = new SBO_EnosixInvoiceSync_Search.SEARCHRESULT_COLLECTION();
        System.assertNotEquals(null, childObjCollection.getAsList());

        childObj.BillingDocument = 'X';
        System.assertEquals('X', childObj.BillingDocument);

        childObj.BillingType = 'X';
        System.assertEquals('X', childObj.BillingType);

        childObj.BillingCategory = 'X';
        System.assertEquals('X', childObj.BillingCategory);

        childObj.CompanyCode = 'X';
        System.assertEquals('X', childObj.CompanyCode);

        childObj.SalesOrganization = 'X';
        System.assertEquals('X', childObj.SalesOrganization);

        childObj.DistributionChannel = 'X';
        System.assertEquals('X', childObj.DistributionChannel);

        childObj.Division = 'X';
        System.assertEquals('X', childObj.Division);

        childObj.AccountingDocumentNumber = 'X';
        System.assertEquals('X', childObj.AccountingDocumentNumber);

        childObj.BillingDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.BillingDate);

        childObj.Payer = 'X';
        System.assertEquals('X', childObj.Payer);

        childObj.PayerName = 'X';
        System.assertEquals('X', childObj.PayerName);

        childObj.SoldToParty = 'X';
        System.assertEquals('X', childObj.SoldToParty);

        childObj.SoldToName = 'X';
        System.assertEquals('X', childObj.SoldToName);

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

        childObj.ReferenceDocumentNumber = 'X';
        System.assertEquals('X', childObj.ReferenceDocumentNumber);

        childObj.ShippingConditions = 'X';
        System.assertEquals('X', childObj.ShippingConditions);

        childObj.Country = 'X';
        System.assertEquals('X', childObj.Country);

        childObj.Region = 'X';
        System.assertEquals('X', childObj.Region);

        childObj.FiscalYear = 'X';
        System.assertEquals('X', childObj.FiscalYear);


    }

}