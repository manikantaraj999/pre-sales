/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
private class TST_SFCICustomer_Search
{

    public class MockSBO_SFCICustomer_Search implements ensxsdk.EnosixFramework.SearchSBOInitMock, ensxsdk.EnosixFramework.SearchSBOSearchMock
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
        ensxsdk.EnosixFramework.setMock(SBO_SFCICustomer_Search.class, new MockSBO_SFCICustomer_Search());
        SBO_SFCICustomer_Search sbo = new SBO_SFCICustomer_Search();
        System.assertEquals(SBO_SFCICustomer_Search.class, sbo.getType(), 'getType() does not match object type.');

        System.assertEquals(null, sbo.initialize(null));
        System.assertEquals(null, sbo.search(null));

        SBO_SFCICustomer_Search.SFCICustomer_SC sc = new SBO_SFCICustomer_Search.SFCICustomer_SC();
        System.assertEquals(SBO_SFCICustomer_Search.SFCICustomer_SC.class, sc.getType(), 'getType() does not match object type.');

        sc.registerReflectionForClass();
        System.assertEquals(null, sc.result);

        System.assertNotEquals(null, sc.SEARCHPARAMS);
        System.assertNotEquals(null, sc.CONTACT_PERSON);
        System.assertNotEquals(null, sc.CUSTOM);

    }
    
    
    @isTest
    static void testSEARCHPARAMS()
    {
        SBO_SFCICustomer_Search.SEARCHPARAMS childObj = new SBO_SFCICustomer_Search.SEARCHPARAMS();
        System.assertEquals(SBO_SFCICustomer_Search.SEARCHPARAMS.class, childObj.getType(),'getType() does not match object type.');

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

        childObj.Country = 'X';
        System.assertEquals('X', childObj.Country);

        childObj.TelephoneNumber = 'X';
        System.assertEquals('X', childObj.TelephoneNumber);

        childObj.EmailAddress = 'X';
        System.assertEquals('X', childObj.EmailAddress);

        childObj.CustomerAccountGroup = 'X';
        System.assertEquals('X', childObj.CustomerAccountGroup);


    }

    @isTest
    static void testCONTACT_PERSON()
    {
        SBO_SFCICustomer_Search.CONTACT_PERSON childObj = new SBO_SFCICustomer_Search.CONTACT_PERSON();
        System.assertEquals(SBO_SFCICustomer_Search.CONTACT_PERSON.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.PARNR_FROM = 'X';
        System.assertEquals('X', childObj.PARNR_FROM);

        childObj.PARNR_TO = 'X';
        System.assertEquals('X', childObj.PARNR_TO);

        childObj.MC_NAME1 = 'X';
        System.assertEquals('X', childObj.MC_NAME1);

        childObj.MC_NAME2 = 'X';
        System.assertEquals('X', childObj.MC_NAME2);


    }

    @isTest
    static void testCUSTOM()
    {
        SBO_SFCICustomer_Search.CUSTOM childObj = new SBO_SFCICustomer_Search.CUSTOM();
        System.assertEquals(SBO_SFCICustomer_Search.CUSTOM.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        SBO_SFCICustomer_Search.CUSTOM_COLLECTION childObjCollection = new SBO_SFCICustomer_Search.CUSTOM_COLLECTION();
        System.assertNotEquals(null, childObjCollection.getAsList());

        childObj.FIELD = 'X';
        System.assertEquals('X', childObj.FIELD);

        childObj.VALUE = 'X';
        System.assertEquals('X', childObj.VALUE);


    }

    @isTest
    static void testSFCICustomer_SR()
    {
        SBO_SFCICustomer_Search.SFCICustomer_SR sr = new SBO_SFCICustomer_Search.SFCICustomer_SR();

        sr.registerReflectionForClass();

        System.assertEquals(SBO_SFCICustomer_Search.SFCICustomer_SR.class, sr.getType(), 'getType() does not match object type.');

        System.assertNotEquals(null, sr.getResults());
    }


    @isTest
    static void testSEARCHRESULT()
    {
        SBO_SFCICustomer_Search.SEARCHRESULT childObj = new SBO_SFCICustomer_Search.SEARCHRESULT();
        System.assertEquals(SBO_SFCICustomer_Search.SEARCHRESULT.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        SBO_SFCICustomer_Search.SEARCHRESULT_COLLECTION childObjCollection = new SBO_SFCICustomer_Search.SEARCHRESULT_COLLECTION();
        System.assertNotEquals(null, childObjCollection.getAsList());

        childObj.CustomerNumber = 'X';
        System.assertEquals('X', childObj.CustomerNumber);

        childObj.Name = 'X';
        System.assertEquals('X', childObj.Name);

        childObj.Name2 = 'X';
        System.assertEquals('X', childObj.Name2);

        childObj.HouseNumber = 'X';
        System.assertEquals('X', childObj.HouseNumber);

        childObj.Street = 'X';
        System.assertEquals('X', childObj.Street);

        childObj.City = 'X';
        System.assertEquals('X', childObj.City);

        childObj.PostalCode = 'X';
        System.assertEquals('X', childObj.PostalCode);

        childObj.Region = 'X';
        System.assertEquals('X', childObj.Region);

        childObj.RegionDescription = 'X';
        System.assertEquals('X', childObj.RegionDescription);

        childObj.Country = 'X';
        System.assertEquals('X', childObj.Country);

        childObj.CountryName = 'X';
        System.assertEquals('X', childObj.CountryName);

        childObj.POBox = 'X';
        System.assertEquals('X', childObj.POBox);

        childObj.TelephoneNumber = 'X';
        System.assertEquals('X', childObj.TelephoneNumber);

        childObj.Language = 'X';
        System.assertEquals('X', childObj.Language);

        childObj.CreditLimit = 1.5;
        System.assertEquals(1.5, childObj.CreditLimit);

        childObj.CreditAvailable = 1.5;
        System.assertEquals(1.5, childObj.CreditAvailable);

        childObj.CurrencyKey = 'X';
        System.assertEquals('X', childObj.CurrencyKey);

        childObj.EmailAddress = 'X';
        System.assertEquals('X', childObj.EmailAddress);

        childObj.CustomerAccountGroup = 'X';
        System.assertEquals('X', childObj.CustomerAccountGroup);

        childObj.AccountGroupName = 'X';
        System.assertEquals('X', childObj.AccountGroupName);

        childObj.CUSTOM01 = 'X';
        System.assertEquals('X', childObj.CUSTOM01);

        childObj.CUSTOM02 = 'X';
        System.assertEquals('X', childObj.CUSTOM02);

        childObj.CUSTOM03 = 'X';
        System.assertEquals('X', childObj.CUSTOM03);

        childObj.CUSTOM04 = 'X';
        System.assertEquals('X', childObj.CUSTOM04);

        childObj.CUSTOM05 = 'X';
        System.assertEquals('X', childObj.CUSTOM05);

        childObj.CUSTOM06 = 'X';
        System.assertEquals('X', childObj.CUSTOM06);

        childObj.CUSTOM07 = 'X';
        System.assertEquals('X', childObj.CUSTOM07);

        childObj.CUSTOM08 = 'X';
        System.assertEquals('X', childObj.CUSTOM08);

        childObj.CUSTOM09 = 'X';
        System.assertEquals('X', childObj.CUSTOM09);

        childObj.CUSTOM10 = 'X';
        System.assertEquals('X', childObj.CUSTOM10);


    }

}