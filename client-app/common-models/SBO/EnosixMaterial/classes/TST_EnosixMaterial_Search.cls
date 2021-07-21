/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
private class TST_EnosixMaterial_Search
{

    public class MockSBO_EnosixMaterial_Search implements ensxsdk.EnosixFramework.SearchSBOInitMock, ensxsdk.EnosixFramework.SearchSBOSearchMock
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
        ensxsdk.EnosixFramework.setMock(SBO_EnosixMaterial_Search.class, new MockSBO_EnosixMaterial_Search());
        SBO_EnosixMaterial_Search sbo = new SBO_EnosixMaterial_Search();
        System.assertEquals(SBO_EnosixMaterial_Search.class, sbo.getType(), 'getType() does not match object type.');

        System.assertEquals(null, sbo.initialize(null));
        System.assertEquals(null, sbo.search(null));

        SBO_EnosixMaterial_Search.EnosixMaterial_SC sc = new SBO_EnosixMaterial_Search.EnosixMaterial_SC();
        System.assertEquals(SBO_EnosixMaterial_Search.EnosixMaterial_SC.class, sc.getType(), 'getType() does not match object type.');

        sc.registerReflectionForClass();
        System.assertEquals(null, sc.result);

        System.assertNotEquals(null, sc.SEARCHPARAMS);
        System.assertNotEquals(null, sc.MATERIAL_TYPE);
        System.assertNotEquals(null, sc.PRODUCT_ATTRIB);

    }
    
    
    @isTest
    static void testSEARCHPARAMS()
    {
        SBO_EnosixMaterial_Search.SEARCHPARAMS childObj = new SBO_EnosixMaterial_Search.SEARCHPARAMS();
        System.assertEquals(SBO_EnosixMaterial_Search.SEARCHPARAMS.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.MaterialNumberFrom = 'X';
        System.assertEquals('X', childObj.MaterialNumberFrom);

        childObj.MaterialNumberTo = 'X';
        System.assertEquals('X', childObj.MaterialNumberTo);

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

        childObj.FromCreateDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.FromCreateDate);

        childObj.ToCreateDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.ToCreateDate);

        childObj.FromChangeDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.FromChangeDate);

        childObj.ToChangeDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.ToChangeDate);


    }

    @isTest
    static void testMATERIAL_TYPE()
    {
        SBO_EnosixMaterial_Search.MATERIAL_TYPE childObj = new SBO_EnosixMaterial_Search.MATERIAL_TYPE();
        System.assertEquals(SBO_EnosixMaterial_Search.MATERIAL_TYPE.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        SBO_EnosixMaterial_Search.MATERIAL_TYPE_COLLECTION childObjCollection = new SBO_EnosixMaterial_Search.MATERIAL_TYPE_COLLECTION();
        System.assertNotEquals(null, childObjCollection.getAsList());

        childObj.MaterialType = 'X';
        System.assertEquals('X', childObj.MaterialType);


    }

    @isTest
    static void testPRODUCT_ATTRIB()
    {
        SBO_EnosixMaterial_Search.PRODUCT_ATTRIB childObj = new SBO_EnosixMaterial_Search.PRODUCT_ATTRIB();
        System.assertEquals(SBO_EnosixMaterial_Search.PRODUCT_ATTRIB.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        SBO_EnosixMaterial_Search.PRODUCT_ATTRIB_COLLECTION childObjCollection = new SBO_EnosixMaterial_Search.PRODUCT_ATTRIB_COLLECTION();
        System.assertNotEquals(null, childObjCollection.getAsList());

        childObj.ProductAttribute = 'X';
        System.assertEquals('X', childObj.ProductAttribute);


    }

    @isTest
    static void testEnosixMaterial_SR()
    {
        SBO_EnosixMaterial_Search.EnosixMaterial_SR sr = new SBO_EnosixMaterial_Search.EnosixMaterial_SR();

        sr.registerReflectionForClass();

        System.assertEquals(SBO_EnosixMaterial_Search.EnosixMaterial_SR.class, sr.getType(), 'getType() does not match object type.');

        System.assertNotEquals(null, sr.getResults());
    }


    @isTest
    static void testSEARCHRESULT()
    {
        SBO_EnosixMaterial_Search.SEARCHRESULT childObj = new SBO_EnosixMaterial_Search.SEARCHRESULT();
        System.assertEquals(SBO_EnosixMaterial_Search.SEARCHRESULT.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        SBO_EnosixMaterial_Search.SEARCHRESULT_COLLECTION childObjCollection = new SBO_EnosixMaterial_Search.SEARCHRESULT_COLLECTION();
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

        childObj.CreationDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.CreationDate);

        childObj.ChangeDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.ChangeDate);

        childObj.AlternateUnitOfMeasure = 'X';
        System.assertEquals('X', childObj.AlternateUnitOfMeasure);

        childObj.NumeratorForConversion = 1.5;
        System.assertEquals(1.5, childObj.NumeratorForConversion);

        childObj.DenominatorForConversion = 1.5;
        System.assertEquals(1.5, childObj.DenominatorForConversion);

        childObj.Quotient = 1.5;
        System.assertEquals(1.5, childObj.Quotient);

        childObj.BaseUnitOfMeasure = 'X';
        System.assertEquals('X', childObj.BaseUnitOfMeasure);

        childObj.BaseUoMDescription = 'X';
        System.assertEquals('X', childObj.BaseUoMDescription);

        childObj.ConfigurableMaterial = true;
        System.assertEquals(true, childObj.ConfigurableMaterial);


    }

}