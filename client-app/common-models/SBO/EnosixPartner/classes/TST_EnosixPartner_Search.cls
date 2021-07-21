/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
private class TST_EnosixPartner_Search
{

    public class MockSBO_EnosixPartner_Search implements ensxsdk.EnosixFramework.SearchSBOInitMock, ensxsdk.EnosixFramework.SearchSBOSearchMock
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
        ensxsdk.EnosixFramework.setMock(SBO_EnosixPartner_Search.class, new MockSBO_EnosixPartner_Search());
        SBO_EnosixPartner_Search sbo = new SBO_EnosixPartner_Search();
        System.assertEquals(SBO_EnosixPartner_Search.class, sbo.getType(), 'getType() does not match object type.');

        System.assertEquals(null, sbo.initialize(null));
        System.assertEquals(null, sbo.search(null));

        SBO_EnosixPartner_Search.EnosixPartner_SC sc = new SBO_EnosixPartner_Search.EnosixPartner_SC();
        System.assertEquals(SBO_EnosixPartner_Search.EnosixPartner_SC.class, sc.getType(), 'getType() does not match object type.');

        sc.registerReflectionForClass();
        System.assertEquals(null, sc.result);

        System.assertNotEquals(null, sc.SEARCHPARAMS);

    }
    
    
    @isTest
    static void testSEARCHPARAMS()
    {
        SBO_EnosixPartner_Search.SEARCHPARAMS childObj = new SBO_EnosixPartner_Search.SEARCHPARAMS();
        System.assertEquals(SBO_EnosixPartner_Search.SEARCHPARAMS.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.CustomerNumber = 'X';
        System.assertEquals('X', childObj.CustomerNumber);

        childObj.SalesOrganization = 'X';
        System.assertEquals('X', childObj.SalesOrganization);

        childObj.DistributionChannel = 'X';
        System.assertEquals('X', childObj.DistributionChannel);

        childObj.Division = 'X';
        System.assertEquals('X', childObj.Division);

        childObj.PartnerFunction = 'X';
        System.assertEquals('X', childObj.PartnerFunction);


    }

    @isTest
    static void testEnosixPartner_SR()
    {
        SBO_EnosixPartner_Search.EnosixPartner_SR sr = new SBO_EnosixPartner_Search.EnosixPartner_SR();

        sr.registerReflectionForClass();

        System.assertEquals(SBO_EnosixPartner_Search.EnosixPartner_SR.class, sr.getType(), 'getType() does not match object type.');

        System.assertNotEquals(null, sr.getResults());
    }


    @isTest
    static void testSEARCHRESULT()
    {
        SBO_EnosixPartner_Search.SEARCHRESULT childObj = new SBO_EnosixPartner_Search.SEARCHRESULT();
        System.assertEquals(SBO_EnosixPartner_Search.SEARCHRESULT.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        SBO_EnosixPartner_Search.SEARCHRESULT_COLLECTION childObjCollection = new SBO_EnosixPartner_Search.SEARCHRESULT_COLLECTION();
        System.assertNotEquals(null, childObjCollection.getAsList());

        childObj.SalesOrganization = 'X';
        System.assertEquals('X', childObj.SalesOrganization);

        childObj.SalesOrganizationName = 'X';
        System.assertEquals('X', childObj.SalesOrganizationName);

        childObj.DistributionChannel = 'X';
        System.assertEquals('X', childObj.DistributionChannel);

        childObj.DistributionChannelName = 'X';
        System.assertEquals('X', childObj.DistributionChannelName);

        childObj.Division = 'X';
        System.assertEquals('X', childObj.Division);

        childObj.DivisionName = 'X';
        System.assertEquals('X', childObj.DivisionName);

        childObj.PartnerFunction = 'X';
        System.assertEquals('X', childObj.PartnerFunction);

        childObj.PartnerFunctionName = 'X';
        System.assertEquals('X', childObj.PartnerFunctionName);

        childObj.PartnerNumber = 'X';
        System.assertEquals('X', childObj.PartnerNumber);

        childObj.PartnerName = 'X';
        System.assertEquals('X', childObj.PartnerName);

        childObj.VendorNumber = 'X';
        System.assertEquals('X', childObj.VendorNumber);

        childObj.VendorName = 'X';
        System.assertEquals('X', childObj.VendorName);

        childObj.ContactNumber = 'X';
        System.assertEquals('X', childObj.ContactNumber);

        childObj.ContactFirstName = 'X';
        System.assertEquals('X', childObj.ContactFirstName);

        childObj.ContactLastName = 'X';
        System.assertEquals('X', childObj.ContactLastName);

        childObj.PersonnelNumber = 'X';
        System.assertEquals('X', childObj.PersonnelNumber);

        childObj.PersonnelFirstName = 'X';
        System.assertEquals('X', childObj.PersonnelFirstName);

        childObj.PersonnelLastName = 'X';
        System.assertEquals('X', childObj.PersonnelLastName);

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

        childObj.Country = 'X';
        System.assertEquals('X', childObj.Country);

        childObj.DefaultPartner = true;
        System.assertEquals(true, childObj.DefaultPartner);


    }

}