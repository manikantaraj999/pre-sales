/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
public with sharing class TST_EnosixInvoice_Detail
{
    public class MockSBO_EnosixInvoice_Detail implements
        ensxsdk.EnosixFramework.DetailSBOInitMock,
        ensxsdk.EnosixFramework.DetailSBOCommandMock,
        ensxsdk.EnosixFramework.DetailSBOGetMock,
        ensxsdk.EnosixFramework.DetailSBOSaveMock
    {
        public ensxsdk.EnosixFramework.DetailObject executeInitialize(ensxsdk.EnosixFramework.DetailObject initialState) { return null; }
        public ensxsdk.EnosixFramework.DetailObject executeCommand(String command, ensxsdk.EnosixFramework.DetailObject obj) { return null; }
        public ensxsdk.EnosixFramework.DetailObject executeGetDetail(object key) { return null; }
        public ensxsdk.EnosixFramework.DetailObject executeSave(ensxsdk.EnosixFramework.DetailObject obj) { return null; }
    }

    @isTest
    static void testSBO()
    {
        SBO_EnosixInvoice_Detail sbo = new SBO_EnosixInvoice_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixInvoice_Detail.class, new MockSBO_EnosixInvoice_Detail());
        System.assertEquals(null, sbo.initialize(null));
        System.assertEquals(null, sbo.command(null, null));
        System.assertEquals(null, sbo.getDetail(null));
        System.assertEquals(null, sbo.save(null));
    }

    @isTest
    static void testEnosixInvoice()
    {
        SBO_EnosixInvoice_Detail.EnosixInvoice result = new SBO_EnosixInvoice_Detail.EnosixInvoice();
        System.assertEquals(SBO_EnosixInvoice_Detail.EnosixInvoice.class, result.getType(), 'getType() does not match object type.');

        result.registerReflectionForClass();

        result.BillingDocument = 'X';
        System.assertEquals('X', result.BillingDocument);

        result.BillingType = 'X';
        System.assertEquals('X', result.BillingType);

        result.BillingTypeDescription = 'X';
        System.assertEquals('X', result.BillingTypeDescription);

        result.CompanyCode = 'X';
        System.assertEquals('X', result.CompanyCode);

        result.CompanyCodeName = 'X';
        System.assertEquals('X', result.CompanyCodeName);

        result.SalesOrganization = 'X';
        System.assertEquals('X', result.SalesOrganization);

        result.SalesOrgDescription = 'X';
        System.assertEquals('X', result.SalesOrgDescription);

        result.BillingDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), result.BillingDate);

        result.ShipDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), result.ShipDate);

        result.SalesOrderNumber = 'X';
        System.assertEquals('X', result.SalesOrderNumber);

        result.Payer = 'X';
        System.assertEquals('X', result.Payer);

        result.PayerName = 'X';
        System.assertEquals('X', result.PayerName);

        result.SoldToParty = 'X';
        System.assertEquals('X', result.SoldToParty);

        result.SoldToName = 'X';
        System.assertEquals('X', result.SoldToName);

        result.ShipToParty = 'X';
        System.assertEquals('X', result.ShipToParty);

        result.ShipToName = 'X';
        System.assertEquals('X', result.ShipToName);

        result.TrackingNumber = 'X';
        System.assertEquals('X', result.TrackingNumber);

        result.PaymentMethod = 'X';
        System.assertEquals('X', result.PaymentMethod);

        result.PaymentMethodDescription = 'X';
        System.assertEquals('X', result.PaymentMethodDescription);

        result.TermsofPaymentKey = 'X';
        System.assertEquals('X', result.TermsofPaymentKey);

        result.TermsOfPaymentKeyDesc = 'X';
        System.assertEquals('X', result.TermsOfPaymentKeyDesc);

        result.NetOrderValue = 1.5;
        System.assertEquals(1.5, result.NetOrderValue);

        result.TaxAmount = 1.5;
        System.assertEquals(1.5, result.TaxAmount);

        result.SalesDocumentCurrency = 'X';
        System.assertEquals('X', result.SalesDocumentCurrency);

        result.CreatedBy = 'X';
        System.assertEquals('X', result.CreatedBy);

        result.CreateDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), result.CreateDate);

        result.BillingStatus = 'X';
        System.assertEquals('X', result.BillingStatus);

        result.BillingStatusDescription = 'X';
        System.assertEquals('X', result.BillingStatusDescription);

        //Test child collections
        System.assertNotEquals(null,result.ITEMS.getAsList());
        System.assertNotEquals(null,result.CONDITIONS.getAsList());
    }

    @isTest
    static void testITEMS()
    {
        SBO_EnosixInvoice_Detail.ITEMS childObj = new SBO_EnosixInvoice_Detail.ITEMS();
        System.assertEquals(SBO_EnosixInvoice_Detail.ITEMS.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.ItemNumber = 'X';
        System.assertEquals('X', childObj.ItemNumber);

        childObj.Material = 'X';
        System.assertEquals('X', childObj.Material);

        childObj.ItemDescription = 'X';
        System.assertEquals('X', childObj.ItemDescription);

        childObj.BillingQuantity = 1.5;
        System.assertEquals(1.5, childObj.BillingQuantity);

        childObj.SalesUnit = 'X';
        System.assertEquals('X', childObj.SalesUnit);

        childObj.Plant = 'X';
        System.assertEquals('X', childObj.Plant);

        childObj.PlantDescription = 'X';
        System.assertEquals('X', childObj.PlantDescription);

        childObj.NetItemValue = 1.5;
        System.assertEquals(1.5, childObj.NetItemValue);

        childObj.TaxAmount = 1.5;
        System.assertEquals(1.5, childObj.TaxAmount);

        childObj.SalesDocumentCurrency = 'X';
        System.assertEquals('X', childObj.SalesDocumentCurrency);

        List<string> keyFields = new List<string>{ 'POSNR' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testCONDITIONS()
    {
        SBO_EnosixInvoice_Detail.CONDITIONS childObj = new SBO_EnosixInvoice_Detail.CONDITIONS();
        System.assertEquals(SBO_EnosixInvoice_Detail.CONDITIONS.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.ConditionItemNumber = 'X';
        System.assertEquals('X', childObj.ConditionItemNumber);

        childObj.ConditionType = 'X';
        System.assertEquals('X', childObj.ConditionType);

        childObj.ConditionPricingDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.ConditionPricingDate);

        childObj.ConditionBaseValue = 1.5;
        System.assertEquals(1.5, childObj.ConditionBaseValue);

        childObj.Rate = 1.5;
        System.assertEquals(1.5, childObj.Rate);

        childObj.CurrencyKey = 'X';
        System.assertEquals('X', childObj.CurrencyKey);

        childObj.ConditionExchangeRate = 1.5;
        System.assertEquals(1.5, childObj.ConditionExchangeRate);

        List<string> keyFields = new List<string>{ 'KPOSN','KSCHL' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
}
