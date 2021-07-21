/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
private class TST_SFCIMaterial_Search
{

    public class MockSBO_SFCIMaterial_Search implements ensxsdk.EnosixFramework.SearchSBOInitMock, ensxsdk.EnosixFramework.SearchSBOSearchMock
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
        ensxsdk.EnosixFramework.setMock(SBO_SFCIMaterial_Search.class, new MockSBO_SFCIMaterial_Search());
        SBO_SFCIMaterial_Search sbo = new SBO_SFCIMaterial_Search();
        System.assertEquals(SBO_SFCIMaterial_Search.class, sbo.getType(), 'getType() does not match object type.');

        System.assertEquals(null, sbo.initialize(null));
        System.assertEquals(null, sbo.search(null));

        SBO_SFCIMaterial_Search.SFCIMaterial_SC sc = new SBO_SFCIMaterial_Search.SFCIMaterial_SC();
        System.assertEquals(SBO_SFCIMaterial_Search.SFCIMaterial_SC.class, sc.getType(), 'getType() does not match object type.');

        sc.registerReflectionForClass();
        System.assertEquals(null, sc.result);

        System.assertNotEquals(null, sc.SEARCHPARAMS);
        System.assertNotEquals(null, sc.MATERIAL_TYPE);
        System.assertNotEquals(null, sc.CUSTOM);

    }
    
    
    @isTest
    static void testSEARCHPARAMS()
    {
        SBO_SFCIMaterial_Search.SEARCHPARAMS childObj = new SBO_SFCIMaterial_Search.SEARCHPARAMS();
        System.assertEquals(SBO_SFCIMaterial_Search.SEARCHPARAMS.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.Material = 'X';
        System.assertEquals('X', childObj.Material);

        childObj.MaterialDescription = 'X';
        System.assertEquals('X', childObj.MaterialDescription);

        childObj.SalesOrganization = 'X';
        System.assertEquals('X', childObj.SalesOrganization);

        childObj.DistributionChannel = 'X';
        System.assertEquals('X', childObj.DistributionChannel);

        childObj.MaterialGroup = 'X';
        System.assertEquals('X', childObj.MaterialGroup);

        childObj.ProductHierarchy = 'X';
        System.assertEquals('X', childObj.ProductHierarchy);

        childObj.CrossPlantMaterialStatus = 'X';
        System.assertEquals('X', childObj.CrossPlantMaterialStatus);

        childObj.FromCreatedDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.FromCreatedDate);

        childObj.ToCreatedDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.ToCreatedDate);

        childObj.FromLastChangeDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.FromLastChangeDate);

        childObj.ToLastChangeDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.ToLastChangeDate);

        childObj.NoSalesDataFlag = true;
        System.assertEquals(true, childObj.NoSalesDataFlag);


    }

    @isTest
    static void testMATERIAL_TYPE()
    {
        SBO_SFCIMaterial_Search.MATERIAL_TYPE childObj = new SBO_SFCIMaterial_Search.MATERIAL_TYPE();
        System.assertEquals(SBO_SFCIMaterial_Search.MATERIAL_TYPE.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        SBO_SFCIMaterial_Search.MATERIAL_TYPE_COLLECTION childObjCollection = new SBO_SFCIMaterial_Search.MATERIAL_TYPE_COLLECTION();
        System.assertNotEquals(null, childObjCollection.getAsList());

        childObj.MaterialType = 'X';
        System.assertEquals('X', childObj.MaterialType);


    }

    @isTest
    static void testCUSTOM()
    {
        SBO_SFCIMaterial_Search.CUSTOM childObj = new SBO_SFCIMaterial_Search.CUSTOM();
        System.assertEquals(SBO_SFCIMaterial_Search.CUSTOM.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        SBO_SFCIMaterial_Search.CUSTOM_COLLECTION childObjCollection = new SBO_SFCIMaterial_Search.CUSTOM_COLLECTION();
        System.assertNotEquals(null, childObjCollection.getAsList());

        childObj.FIELD = 'X';
        System.assertEquals('X', childObj.FIELD);

        childObj.VALUE = 'X';
        System.assertEquals('X', childObj.VALUE);


    }

    @isTest
    static void testSFCIMaterial_SR()
    {
        SBO_SFCIMaterial_Search.SFCIMaterial_SR sr = new SBO_SFCIMaterial_Search.SFCIMaterial_SR();

        sr.registerReflectionForClass();

        System.assertEquals(SBO_SFCIMaterial_Search.SFCIMaterial_SR.class, sr.getType(), 'getType() does not match object type.');

        System.assertNotEquals(null, sr.getResults());
    }


    @isTest
    static void testSEARCHRESULT()
    {
        SBO_SFCIMaterial_Search.SEARCHRESULT childObj = new SBO_SFCIMaterial_Search.SEARCHRESULT();
        System.assertEquals(SBO_SFCIMaterial_Search.SEARCHRESULT.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        SBO_SFCIMaterial_Search.SEARCHRESULT_COLLECTION childObjCollection = new SBO_SFCIMaterial_Search.SEARCHRESULT_COLLECTION();
        System.assertNotEquals(null, childObjCollection.getAsList());

        childObj.Material = 'X';
        System.assertEquals('X', childObj.Material);

        childObj.MaterialDescription = 'X';
        System.assertEquals('X', childObj.MaterialDescription);

        childObj.MaterialType = 'X';
        System.assertEquals('X', childObj.MaterialType);

        childObj.MaterialTypeDescription = 'X';
        System.assertEquals('X', childObj.MaterialTypeDescription);

        childObj.MaterialGroup = 'X';
        System.assertEquals('X', childObj.MaterialGroup);

        childObj.MaterialGroupDescription = 'X';
        System.assertEquals('X', childObj.MaterialGroupDescription);

        childObj.SalesOrganization = 'X';
        System.assertEquals('X', childObj.SalesOrganization);

        childObj.DistributionChannel = 'X';
        System.assertEquals('X', childObj.DistributionChannel);

        childObj.ProductHierarchy = 'X';
        System.assertEquals('X', childObj.ProductHierarchy);

        childObj.ProductHierarchyDescription = 'X';
        System.assertEquals('X', childObj.ProductHierarchyDescription);

        childObj.CrossPlantMaterialStatus = 'X';
        System.assertEquals('X', childObj.CrossPlantMaterialStatus);

        childObj.MaterialStatusDescription = 'X';
        System.assertEquals('X', childObj.MaterialStatusDescription);

        childObj.CreatedDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.CreatedDate);

        childObj.LastChangeDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.LastChangeDate);

        childObj.BaseUnitOfMeasure = 'X';
        System.assertEquals('X', childObj.BaseUnitOfMeasure);

        childObj.BaseUoMDescription = 'X';
        System.assertEquals('X', childObj.BaseUoMDescription);

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