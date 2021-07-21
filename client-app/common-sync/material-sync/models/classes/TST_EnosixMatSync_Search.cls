/// enosiX Inc. Generated Apex Model
/// Generated On: 8/13/2018 9:51:30 AM
/// SAP Host: From REST Service On: https://saas-platform-3158-dev-ed.cs24.my.salesforce.com
/// CID: From REST Service On: https://saas-platform-3158-dev-ed.cs24.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
private class TST_EnosixMatSync_Search
{

    public class MockSBO_EnosixMatSync_Search implements ensxsdk.EnosixFramework.SearchSBOInitMock, ensxsdk.EnosixFramework.SearchSBOSearchMock
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
        ensxsdk.EnosixFramework.setMock(SBO_EnosixMatSync_Search.class, new MockSBO_EnosixMatSync_Search());
        SBO_EnosixMatSync_Search sbo = new SBO_EnosixMatSync_Search();
        System.assertEquals(SBO_EnosixMatSync_Search.class, sbo.getType(), 'getType() does not match object type.');

        System.assertEquals(null, sbo.initialize(null));
        System.assertEquals(null, sbo.search(null));

        SBO_EnosixMatSync_Search.EnosixMatSync_SC sc = new SBO_EnosixMatSync_Search.EnosixMatSync_SC();
        System.assertEquals(SBO_EnosixMatSync_Search.EnosixMatSync_SC.class, sc.getType(), 'getType() does not match object type.');

        sc.registerReflectionForClass();
        System.assertEquals(null, sc.result);

        System.assertNotEquals(null, sc.SEARCHPARAMS);
        System.assertNotEquals(null, sc.MATERIAL_TYPE);
        System.assertNotEquals(null, sc.MATERIAL_GROUP);
        System.assertNotEquals(null, sc.DIVISION);

    }
    
    
    @isTest
    static void testSEARCHPARAMS()
    {
        SBO_EnosixMatSync_Search.SEARCHPARAMS childObj = new SBO_EnosixMatSync_Search.SEARCHPARAMS();
        System.assertEquals(SBO_EnosixMatSync_Search.SEARCHPARAMS.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.DateFrom = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.DateFrom);

        childObj.SalesOrganization = 'X';
        System.assertEquals('X', childObj.SalesOrganization);

        childObj.DistributionChannel = 'X';
        System.assertEquals('X', childObj.DistributionChannel);


    }

    @isTest
    static void testMATERIAL_TYPE()
    {
        SBO_EnosixMatSync_Search.MATERIAL_TYPE childObj = new SBO_EnosixMatSync_Search.MATERIAL_TYPE();
        System.assertEquals(SBO_EnosixMatSync_Search.MATERIAL_TYPE.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        SBO_EnosixMatSync_Search.MATERIAL_TYPE_COLLECTION childObjCollection = new SBO_EnosixMatSync_Search.MATERIAL_TYPE_COLLECTION();
        System.assertNotEquals(null, childObjCollection.getAsList());

        childObj.MaterialType = 'X';
        System.assertEquals('X', childObj.MaterialType);


    }

    @isTest
    static void testMATERIAL_GROUP()
    {
        SBO_EnosixMatSync_Search.MATERIAL_GROUP childObj = new SBO_EnosixMatSync_Search.MATERIAL_GROUP();
        System.assertEquals(SBO_EnosixMatSync_Search.MATERIAL_GROUP.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        SBO_EnosixMatSync_Search.MATERIAL_GROUP_COLLECTION childObjCollection = new SBO_EnosixMatSync_Search.MATERIAL_GROUP_COLLECTION();
        System.assertNotEquals(null, childObjCollection.getAsList());

        childObj.MaterialGroup = 'X';
        System.assertEquals('X', childObj.MaterialGroup);


    }

    @isTest
    static void testDIVISION()
    {
        SBO_EnosixMatSync_Search.DIVISION childObj = new SBO_EnosixMatSync_Search.DIVISION();
        System.assertEquals(SBO_EnosixMatSync_Search.DIVISION.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        SBO_EnosixMatSync_Search.DIVISION_COLLECTION childObjCollection = new SBO_EnosixMatSync_Search.DIVISION_COLLECTION();
        System.assertNotEquals(null, childObjCollection.getAsList());

        childObj.Division = 'X';
        System.assertEquals('X', childObj.Division);


    }

    @isTest
    static void testEnosixMatSync_SR()
    {
        SBO_EnosixMatSync_Search.EnosixMatSync_SR sr = new SBO_EnosixMatSync_Search.EnosixMatSync_SR();

        sr.registerReflectionForClass();

        System.assertEquals(SBO_EnosixMatSync_Search.EnosixMatSync_SR.class, sr.getType(), 'getType() does not match object type.');

        System.assertNotEquals(null, sr.getResults());
    }


    @isTest
    static void testSEARCHRESULT()
    {
        SBO_EnosixMatSync_Search.SEARCHRESULT childObj = new SBO_EnosixMatSync_Search.SEARCHRESULT();
        System.assertEquals(SBO_EnosixMatSync_Search.SEARCHRESULT.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        SBO_EnosixMatSync_Search.SEARCHRESULT_COLLECTION childObjCollection = new SBO_EnosixMatSync_Search.SEARCHRESULT_COLLECTION();
        System.assertNotEquals(null, childObjCollection.getAsList());

        childObj.DeleteIndicator = 'X';
        System.assertEquals('X', childObj.DeleteIndicator);

        childObj.ConfigurableMaterial = 'X';
        System.assertEquals('X', childObj.ConfigurableMaterial);

        childObj.MaterialType = 'X';
        System.assertEquals('X', childObj.MaterialType);

        childObj.MaterialTypeDescription = 'X';
        System.assertEquals('X', childObj.MaterialTypeDescription);

        childObj.Division = 'X';
        System.assertEquals('X', childObj.Division);

        childObj.DivisionDescription = 'X';
        System.assertEquals('X', childObj.DivisionDescription);

        childObj.MaterialGroup = 'X';
        System.assertEquals('X', childObj.MaterialGroup);

        childObj.MaterialGroupDescription = 'X';
        System.assertEquals('X', childObj.MaterialGroupDescription);

        childObj.Material = 'X';
        System.assertEquals('X', childObj.Material);

        childObj.MaterialDescription = 'X';
        System.assertEquals('X', childObj.MaterialDescription);

        childObj.BaseUnitOfMeasure = 'X';
        System.assertEquals('X', childObj.BaseUnitOfMeasure);

        childObj.SalesUnit = 'X';
        System.assertEquals('X', childObj.SalesUnit);

        childObj.SalesOrganization = 'X';
        System.assertEquals('X', childObj.SalesOrganization);

        childObj.DistributionChannel = 'X';
        System.assertEquals('X', childObj.DistributionChannel);

        childObj.DistChainStatus = 'X';
        System.assertEquals('X', childObj.DistChainStatus);

        childObj.DistChainStatusDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.DistChainStatusDate);

        childObj.WeightUnit = 'X';
        System.assertEquals('X', childObj.WeightUnit);


    }

}