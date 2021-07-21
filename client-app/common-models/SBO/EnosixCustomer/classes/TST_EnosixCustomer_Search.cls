/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
private class TST_EnosixCustomer_Search
{

    public class MockSBO_EnosixCustomer_Search implements ensxsdk.EnosixFramework.SearchSBOInitMock, ensxsdk.EnosixFramework.SearchSBOSearchMock
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
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustomer_Search.class, new MockSBO_EnosixCustomer_Search());
        SBO_EnosixCustomer_Search sbo = new SBO_EnosixCustomer_Search();
        System.assertEquals(SBO_EnosixCustomer_Search.class, sbo.getType(), 'getType() does not match object type.');

        System.assertEquals(null, sbo.initialize(null));
        System.assertEquals(null, sbo.search(null));

        SBO_EnosixCustomer_Search.EnosixCustomer_SC sc = new SBO_EnosixCustomer_Search.EnosixCustomer_SC();
        System.assertEquals(SBO_EnosixCustomer_Search.EnosixCustomer_SC.class, sc.getType(), 'getType() does not match object type.');

        sc.registerReflectionForClass();
        System.assertEquals(null, sc.result);

        System.assertNotEquals(null, sc.SEARCHPARAMS);
        System.assertNotEquals(null, sc.CONTACT_PERSON);

    }
    
    
    @isTest
    static void testSEARCHPARAMS()
    {
        SBO_EnosixCustomer_Search.SEARCHPARAMS childObj = new SBO_EnosixCustomer_Search.SEARCHPARAMS();
        System.assertEquals(SBO_EnosixCustomer_Search.SEARCHPARAMS.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.CustomerNumberFrom = 'X';
        System.assertEquals('X', childObj.CustomerNumberFrom);

        childObj.CustomerNumberTo = 'X';
        System.assertEquals('X', childObj.CustomerNumberTo);

        childObj.CustomerName = 'X';
        System.assertEquals('X', childObj.CustomerName);

        childObj.PostalCode = 'X';
        System.assertEquals('X', childObj.PostalCode);

        childObj.City = 'X';
        System.assertEquals('X', childObj.City);

        childObj.Region = 'X';
        System.assertEquals('X', childObj.Region);

        childObj.CountryKey = 'X';
        System.assertEquals('X', childObj.CountryKey);

        childObj.TelephoneNO = 'X';
        System.assertEquals('X', childObj.TelephoneNO);

        childObj.EMailAddress = 'X';
        System.assertEquals('X', childObj.EMailAddress);


    }

    @isTest
    static void testCONTACT_PERSON()
    {
        SBO_EnosixCustomer_Search.CONTACT_PERSON childObj = new SBO_EnosixCustomer_Search.CONTACT_PERSON();
        System.assertEquals(SBO_EnosixCustomer_Search.CONTACT_PERSON.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.BusinessPartnerFrom = 'X';
        System.assertEquals('X', childObj.BusinessPartnerFrom);

        childObj.BusinessPartnerTo = 'X';
        System.assertEquals('X', childObj.BusinessPartnerTo);

        childObj.LastName = 'X';
        System.assertEquals('X', childObj.LastName);

        childObj.FirstName = 'X';
        System.assertEquals('X', childObj.FirstName);

        childObj.ContactPersonFlag = 'X';
        System.assertEquals('X', childObj.ContactPersonFlag);

        childObj.SalesEmployeeFlag = 'X';
        System.assertEquals('X', childObj.SalesEmployeeFlag);

        childObj.CustomerNumber = 'X';
        System.assertEquals('X', childObj.CustomerNumber);


    }

    @isTest
    static void testEnosixCustomer_SR()
    {
        SBO_EnosixCustomer_Search.EnosixCustomer_SR sr = new SBO_EnosixCustomer_Search.EnosixCustomer_SR();

        sr.registerReflectionForClass();

        System.assertEquals(SBO_EnosixCustomer_Search.EnosixCustomer_SR.class, sr.getType(), 'getType() does not match object type.');

        System.assertNotEquals(null, sr.getResults());
    }


    @isTest
    static void testSEARCHRESULT()
    {
        SBO_EnosixCustomer_Search.SEARCHRESULT childObj = new SBO_EnosixCustomer_Search.SEARCHRESULT();
        System.assertEquals(SBO_EnosixCustomer_Search.SEARCHRESULT.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        SBO_EnosixCustomer_Search.SEARCHRESULT_COLLECTION childObjCollection = new SBO_EnosixCustomer_Search.SEARCHRESULT_COLLECTION();
        System.assertNotEquals(null, childObjCollection.getAsList());

        childObj.CustomerNumber = 'X';
        System.assertEquals('X', childObj.CustomerNumber);

        childObj.Name = 'X';
        System.assertEquals('X', childObj.Name);

        childObj.Name2 = 'X';
        System.assertEquals('X', childObj.Name2);

        childObj.Street = 'X';
        System.assertEquals('X', childObj.Street);

        childObj.City = 'X';
        System.assertEquals('X', childObj.City);

        childObj.PostalCode = 'X';
        System.assertEquals('X', childObj.PostalCode);

        childObj.Region = 'X';
        System.assertEquals('X', childObj.Region);

        childObj.CountryKey = 'X';
        System.assertEquals('X', childObj.CountryKey);

        childObj.POBox = 'X';
        System.assertEquals('X', childObj.POBox);

        childObj.TelephoneNO = 'X';
        System.assertEquals('X', childObj.TelephoneNO);

        childObj.Language = 'X';
        System.assertEquals('X', childObj.Language);

        childObj.CreditLimit = 1.5;
        System.assertEquals(1.5, childObj.CreditLimit);

        childObj.CreditAvailable = 1.5;
        System.assertEquals(1.5, childObj.CreditAvailable);

        childObj.CurrencyKey = 'X';
        System.assertEquals('X', childObj.CurrencyKey);

        childObj.EMailAddress = 'X';
        System.assertEquals('X', childObj.EMailAddress);


    }

}