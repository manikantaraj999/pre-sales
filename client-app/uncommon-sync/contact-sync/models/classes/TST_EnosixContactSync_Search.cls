/// enosiX Inc. Generated Apex Model
/// Generated On: 2/18/2019 5:30:54 PM
/// SAP Host: From REST Service On: https://app-speed-4607-dev-ed.cs11.my.salesforce.com
/// CID: From REST Service On: https://app-speed-4607-dev-ed.cs11.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
private class TST_EnosixContactSync_Search
{

    public class MockSBO_EnosixContactSync_Search implements ensxsdk.EnosixFramework.SearchSBOInitMock, ensxsdk.EnosixFramework.SearchSBOSearchMock
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
        ensxsdk.EnosixFramework.setMock(SBO_EnosixContactSync_Search.class, new MockSBO_EnosixContactSync_Search());
        SBO_EnosixContactSync_Search sbo = new SBO_EnosixContactSync_Search();
        System.assertEquals(SBO_EnosixContactSync_Search.class, sbo.getType(), 'getType() does not match object type.');

        System.assertEquals(null, sbo.initialize(null));
        System.assertEquals(null, sbo.search(null));

        SBO_EnosixContactSync_Search.EnosixContactSync_SC sc = new SBO_EnosixContactSync_Search.EnosixContactSync_SC();
        System.assertEquals(SBO_EnosixContactSync_Search.EnosixContactSync_SC.class, sc.getType(), 'getType() does not match object type.');

        sc.registerReflectionForClass();
        System.assertEquals(null, sc.result);

        System.assertNotEquals(null, sc.SEARCHPARAMS);

    }
    
    
    @isTest
    static void testSEARCHPARAMS()
    {
        SBO_EnosixContactSync_Search.SEARCHPARAMS childObj = new SBO_EnosixContactSync_Search.SEARCHPARAMS();
        System.assertEquals(SBO_EnosixContactSync_Search.SEARCHPARAMS.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.DateFrom = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.DateFrom);

        childObj.InitialLoad = true;
        System.assertEquals(true, childObj.InitialLoad);


    }

    @isTest
    static void testEnosixContactSync_SR()
    {
        SBO_EnosixContactSync_Search.EnosixContactSync_SR sr = new SBO_EnosixContactSync_Search.EnosixContactSync_SR();

        sr.registerReflectionForClass();

        System.assertEquals(SBO_EnosixContactSync_Search.EnosixContactSync_SR.class, sr.getType(), 'getType() does not match object type.');

        System.assertNotEquals(null, sr.getResults());
    }


    @isTest
    static void testSEARCHRESULT()
    {
        SBO_EnosixContactSync_Search.SEARCHRESULT childObj = new SBO_EnosixContactSync_Search.SEARCHRESULT();
        System.assertEquals(SBO_EnosixContactSync_Search.SEARCHRESULT.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        SBO_EnosixContactSync_Search.SEARCHRESULT_COLLECTION childObjCollection = new SBO_EnosixContactSync_Search.SEARCHRESULT_COLLECTION();
        System.assertNotEquals(null, childObjCollection.getAsList());

        childObj.ContactPersonNumber = 'X';
        System.assertEquals('X', childObj.ContactPersonNumber);

        childObj.CustomerNumber = 'X';
        System.assertEquals('X', childObj.CustomerNumber);

        childObj.Name = 'X';
        System.assertEquals('X', childObj.Name);

        childObj.Name2 = 'X';
        System.assertEquals('X', childObj.Name2);

        childObj.TelephoneNumber = 'X';
        System.assertEquals('X', childObj.TelephoneNumber);

        childObj.FaxNumber = 'X';
        System.assertEquals('X', childObj.FaxNumber);

        childObj.Email = 'X';
        System.assertEquals('X', childObj.Email);

        childObj.Department = 'X';
        System.assertEquals('X', childObj.Department);

        childObj.MobileNumber = 'X';
        System.assertEquals('X', childObj.MobileNumber);

        childObj.Title = 'X';
        System.assertEquals('X', childObj.Title);

        childObj.Salutation = 'X';
        System.assertEquals('X', childObj.Salutation);

        childObj.ChangeDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.ChangeDate);

        childObj.ChangeTime = Time.newInstance(1,1,1,0);
        System.assertEquals(Time.newInstance(1,1,1,0), childObj.ChangeTime);


    }

}