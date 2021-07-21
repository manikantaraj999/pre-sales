/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
private class TST_EnosixWarehouseStock_Search
{

    public class MockSBO_EnosixWarehouseStock_Search implements ensxsdk.EnosixFramework.SearchSBOInitMock, ensxsdk.EnosixFramework.SearchSBOSearchMock
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
        ensxsdk.EnosixFramework.setMock(SBO_EnosixWarehouseStock_Search.class, new MockSBO_EnosixWarehouseStock_Search());
        SBO_EnosixWarehouseStock_Search sbo = new SBO_EnosixWarehouseStock_Search();
        System.assertEquals(SBO_EnosixWarehouseStock_Search.class, sbo.getType(), 'getType() does not match object type.');

        System.assertEquals(null, sbo.initialize(null));
        System.assertEquals(null, sbo.search(null));

        SBO_EnosixWarehouseStock_Search.EnosixWarehouseStock_SC sc = new SBO_EnosixWarehouseStock_Search.EnosixWarehouseStock_SC();
        System.assertEquals(SBO_EnosixWarehouseStock_Search.EnosixWarehouseStock_SC.class, sc.getType(), 'getType() does not match object type.');

        sc.registerReflectionForClass();
        System.assertEquals(null, sc.result);

        System.assertNotEquals(null, sc.SEARCHPARAMS);
        System.assertNotEquals(null, sc.MATERIALSEARCH);
        System.assertNotEquals(null, sc.MATDESCSEARCH);
        System.assertNotEquals(null, sc.PLANTSEARCH);
        System.assertNotEquals(null, sc.STORAGELOCSEARCH);
        System.assertNotEquals(null, sc.BATCHSEARCH);
        System.assertNotEquals(null, sc.MATERIALTYSEARCH);
        System.assertNotEquals(null, sc.MATERIALGRPSEARCH);
        System.assertNotEquals(null, sc.SPECIALSTKTYSEARCH);
        System.assertNotEquals(null, sc.POSTINGDTSEARCH);
        System.assertNotEquals(null, sc.MOVEMENTTYSEARCH);

    }
    
    
    @isTest
    static void testSEARCHPARAMS()
    {
        SBO_EnosixWarehouseStock_Search.SEARCHPARAMS childObj = new SBO_EnosixWarehouseStock_Search.SEARCHPARAMS();
        System.assertEquals(SBO_EnosixWarehouseStock_Search.SEARCHPARAMS.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.X_SpecialStock = true;
        System.assertEquals(true, childObj.X_SpecialStock);

        childObj.X_DisplayBatchStock = true;
        System.assertEquals(true, childObj.X_DisplayBatchStock);

        childObj.X_DisplayNoZeroStockLines = true;
        System.assertEquals(true, childObj.X_DisplayNoZeroStockLines);

        childObj.MAXROWS = 0;
        System.assertEquals(0, childObj.MAXROWS);


    }

    @isTest
    static void testMATERIALSEARCH()
    {
        SBO_EnosixWarehouseStock_Search.MATERIALSEARCH childObj = new SBO_EnosixWarehouseStock_Search.MATERIALSEARCH();
        System.assertEquals(SBO_EnosixWarehouseStock_Search.MATERIALSEARCH.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        SBO_EnosixWarehouseStock_Search.MATERIALSEARCH_COLLECTION childObjCollection = new SBO_EnosixWarehouseStock_Search.MATERIALSEARCH_COLLECTION();
        System.assertNotEquals(null, childObjCollection.getAsList());

        childObj.Sign = 'X';
        System.assertEquals('X', childObj.Sign);

        childObj.Option = 'X';
        System.assertEquals('X', childObj.Option);

        childObj.Low = 'X';
        System.assertEquals('X', childObj.Low);

        childObj.High = 'X';
        System.assertEquals('X', childObj.High);


    }

    @isTest
    static void testMATDESCSEARCH()
    {
        SBO_EnosixWarehouseStock_Search.MATDESCSEARCH childObj = new SBO_EnosixWarehouseStock_Search.MATDESCSEARCH();
        System.assertEquals(SBO_EnosixWarehouseStock_Search.MATDESCSEARCH.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        SBO_EnosixWarehouseStock_Search.MATDESCSEARCH_COLLECTION childObjCollection = new SBO_EnosixWarehouseStock_Search.MATDESCSEARCH_COLLECTION();
        System.assertNotEquals(null, childObjCollection.getAsList());

        childObj.Sign = 'X';
        System.assertEquals('X', childObj.Sign);

        childObj.Option = 'X';
        System.assertEquals('X', childObj.Option);

        childObj.Low = 'X';
        System.assertEquals('X', childObj.Low);


    }

    @isTest
    static void testPLANTSEARCH()
    {
        SBO_EnosixWarehouseStock_Search.PLANTSEARCH childObj = new SBO_EnosixWarehouseStock_Search.PLANTSEARCH();
        System.assertEquals(SBO_EnosixWarehouseStock_Search.PLANTSEARCH.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        SBO_EnosixWarehouseStock_Search.PLANTSEARCH_COLLECTION childObjCollection = new SBO_EnosixWarehouseStock_Search.PLANTSEARCH_COLLECTION();
        System.assertNotEquals(null, childObjCollection.getAsList());

        childObj.Sign = 'X';
        System.assertEquals('X', childObj.Sign);

        childObj.Option = 'X';
        System.assertEquals('X', childObj.Option);

        childObj.Low = 'X';
        System.assertEquals('X', childObj.Low);

        childObj.High = 'X';
        System.assertEquals('X', childObj.High);


    }

    @isTest
    static void testSTORAGELOCSEARCH()
    {
        SBO_EnosixWarehouseStock_Search.STORAGELOCSEARCH childObj = new SBO_EnosixWarehouseStock_Search.STORAGELOCSEARCH();
        System.assertEquals(SBO_EnosixWarehouseStock_Search.STORAGELOCSEARCH.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        SBO_EnosixWarehouseStock_Search.STORAGELOCSEARCH_COLLECTION childObjCollection = new SBO_EnosixWarehouseStock_Search.STORAGELOCSEARCH_COLLECTION();
        System.assertNotEquals(null, childObjCollection.getAsList());

        childObj.Sign = 'X';
        System.assertEquals('X', childObj.Sign);

        childObj.Option = 'X';
        System.assertEquals('X', childObj.Option);

        childObj.Low = 'X';
        System.assertEquals('X', childObj.Low);

        childObj.High = 'X';
        System.assertEquals('X', childObj.High);


    }

    @isTest
    static void testBATCHSEARCH()
    {
        SBO_EnosixWarehouseStock_Search.BATCHSEARCH childObj = new SBO_EnosixWarehouseStock_Search.BATCHSEARCH();
        System.assertEquals(SBO_EnosixWarehouseStock_Search.BATCHSEARCH.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        SBO_EnosixWarehouseStock_Search.BATCHSEARCH_COLLECTION childObjCollection = new SBO_EnosixWarehouseStock_Search.BATCHSEARCH_COLLECTION();
        System.assertNotEquals(null, childObjCollection.getAsList());

        childObj.Sign = 'X';
        System.assertEquals('X', childObj.Sign);

        childObj.Option = 'X';
        System.assertEquals('X', childObj.Option);

        childObj.Low = 'X';
        System.assertEquals('X', childObj.Low);

        childObj.High = 'X';
        System.assertEquals('X', childObj.High);


    }

    @isTest
    static void testMATERIALTYSEARCH()
    {
        SBO_EnosixWarehouseStock_Search.MATERIALTYSEARCH childObj = new SBO_EnosixWarehouseStock_Search.MATERIALTYSEARCH();
        System.assertEquals(SBO_EnosixWarehouseStock_Search.MATERIALTYSEARCH.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        SBO_EnosixWarehouseStock_Search.MATERIALTYSEARCH_COLLECTION childObjCollection = new SBO_EnosixWarehouseStock_Search.MATERIALTYSEARCH_COLLECTION();
        System.assertNotEquals(null, childObjCollection.getAsList());

        childObj.Sign = 'X';
        System.assertEquals('X', childObj.Sign);

        childObj.Option = 'X';
        System.assertEquals('X', childObj.Option);

        childObj.Low = 'X';
        System.assertEquals('X', childObj.Low);

        childObj.High = 'X';
        System.assertEquals('X', childObj.High);


    }

    @isTest
    static void testMATERIALGRPSEARCH()
    {
        SBO_EnosixWarehouseStock_Search.MATERIALGRPSEARCH childObj = new SBO_EnosixWarehouseStock_Search.MATERIALGRPSEARCH();
        System.assertEquals(SBO_EnosixWarehouseStock_Search.MATERIALGRPSEARCH.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        SBO_EnosixWarehouseStock_Search.MATERIALGRPSEARCH_COLLECTION childObjCollection = new SBO_EnosixWarehouseStock_Search.MATERIALGRPSEARCH_COLLECTION();
        System.assertNotEquals(null, childObjCollection.getAsList());

        childObj.Sign = 'X';
        System.assertEquals('X', childObj.Sign);

        childObj.Option = 'X';
        System.assertEquals('X', childObj.Option);

        childObj.Low = 'X';
        System.assertEquals('X', childObj.Low);

        childObj.High = 'X';
        System.assertEquals('X', childObj.High);


    }

    @isTest
    static void testSPECIALSTKTYSEARCH()
    {
        SBO_EnosixWarehouseStock_Search.SPECIALSTKTYSEARCH childObj = new SBO_EnosixWarehouseStock_Search.SPECIALSTKTYSEARCH();
        System.assertEquals(SBO_EnosixWarehouseStock_Search.SPECIALSTKTYSEARCH.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        SBO_EnosixWarehouseStock_Search.SPECIALSTKTYSEARCH_COLLECTION childObjCollection = new SBO_EnosixWarehouseStock_Search.SPECIALSTKTYSEARCH_COLLECTION();
        System.assertNotEquals(null, childObjCollection.getAsList());

        childObj.Sign = 'X';
        System.assertEquals('X', childObj.Sign);

        childObj.Option = 'X';
        System.assertEquals('X', childObj.Option);

        childObj.Low = 'X';
        System.assertEquals('X', childObj.Low);

        childObj.High = 'X';
        System.assertEquals('X', childObj.High);


    }

    @isTest
    static void testPOSTINGDTSEARCH()
    {
        SBO_EnosixWarehouseStock_Search.POSTINGDTSEARCH childObj = new SBO_EnosixWarehouseStock_Search.POSTINGDTSEARCH();
        System.assertEquals(SBO_EnosixWarehouseStock_Search.POSTINGDTSEARCH.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        SBO_EnosixWarehouseStock_Search.POSTINGDTSEARCH_COLLECTION childObjCollection = new SBO_EnosixWarehouseStock_Search.POSTINGDTSEARCH_COLLECTION();
        System.assertNotEquals(null, childObjCollection.getAsList());

        childObj.Sign = 'X';
        System.assertEquals('X', childObj.Sign);

        childObj.Option = 'X';
        System.assertEquals('X', childObj.Option);

        childObj.Low = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.Low);

        childObj.High = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.High);


    }

    @isTest
    static void testMOVEMENTTYSEARCH()
    {
        SBO_EnosixWarehouseStock_Search.MOVEMENTTYSEARCH childObj = new SBO_EnosixWarehouseStock_Search.MOVEMENTTYSEARCH();
        System.assertEquals(SBO_EnosixWarehouseStock_Search.MOVEMENTTYSEARCH.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        SBO_EnosixWarehouseStock_Search.MOVEMENTTYSEARCH_COLLECTION childObjCollection = new SBO_EnosixWarehouseStock_Search.MOVEMENTTYSEARCH_COLLECTION();
        System.assertNotEquals(null, childObjCollection.getAsList());

        childObj.Sign = 'X';
        System.assertEquals('X', childObj.Sign);

        childObj.Option = 'X';
        System.assertEquals('X', childObj.Option);

        childObj.Low = 'X';
        System.assertEquals('X', childObj.Low);

        childObj.High = 'X';
        System.assertEquals('X', childObj.High);


    }

    @isTest
    static void testEnosixWarehouseStock_SR()
    {
        SBO_EnosixWarehouseStock_Search.EnosixWarehouseStock_SR sr = new SBO_EnosixWarehouseStock_Search.EnosixWarehouseStock_SR();

        sr.registerReflectionForClass();

        System.assertEquals(SBO_EnosixWarehouseStock_Search.EnosixWarehouseStock_SR.class, sr.getType(), 'getType() does not match object type.');

        System.assertNotEquals(null, sr.getResults());
    }


    @isTest
    static void testSEARCHRESULT()
    {
        SBO_EnosixWarehouseStock_Search.SEARCHRESULT childObj = new SBO_EnosixWarehouseStock_Search.SEARCHRESULT();
        System.assertEquals(SBO_EnosixWarehouseStock_Search.SEARCHRESULT.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        SBO_EnosixWarehouseStock_Search.SEARCHRESULT_COLLECTION childObjCollection = new SBO_EnosixWarehouseStock_Search.SEARCHRESULT_COLLECTION();
        System.assertNotEquals(null, childObjCollection.getAsList());

        childObj.Material = 'X';
        System.assertEquals('X', childObj.Material);

        childObj.MaterialDescription = 'X';
        System.assertEquals('X', childObj.MaterialDescription);

        childObj.Plant = 'X';
        System.assertEquals('X', childObj.Plant);

        childObj.StorageLocation = 'X';
        System.assertEquals('X', childObj.StorageLocation);

        childObj.StorageLocationDescription = 'X';
        System.assertEquals('X', childObj.StorageLocationDescription);

        childObj.MaterialType = 'X';
        System.assertEquals('X', childObj.MaterialType);

        childObj.MaterialGroup = 'X';
        System.assertEquals('X', childObj.MaterialGroup);

        childObj.SpecialStockInd = 'X';
        System.assertEquals('X', childObj.SpecialStockInd);

        childObj.ValuationofSpecialStock = 'X';
        System.assertEquals('X', childObj.ValuationofSpecialStock);

        childObj.SpecialStockNumber = 'X';
        System.assertEquals('X', childObj.SpecialStockNumber);

        childObj.DeletionFLag = 'X';
        System.assertEquals('X', childObj.DeletionFLag);

        childObj.BatchNumber = 'X';
        System.assertEquals('X', childObj.BatchNumber);

        childObj.BaseUnitOfMeasure = 'X';
        System.assertEquals('X', childObj.BaseUnitOfMeasure);

        childObj.FieldCurrency = 'X';
        System.assertEquals('X', childObj.FieldCurrency);

        childObj.UnrestrictedStock = 1.5;
        System.assertEquals(1.5, childObj.UnrestrictedStock);

        childObj.UnrestrictedValue = 1.5;
        System.assertEquals(1.5, childObj.UnrestrictedValue);

        childObj.TransitTransferStock = 1.5;
        System.assertEquals(1.5, childObj.TransitTransferStock);

        childObj.TransitTransferValue = 1.5;
        System.assertEquals(1.5, childObj.TransitTransferValue);

        childObj.QualityInspectionStock = 1.5;
        System.assertEquals(1.5, childObj.QualityInspectionStock);

        childObj.QualityInspectionValue = 1.5;
        System.assertEquals(1.5, childObj.QualityInspectionValue);

        childObj.RestrictedStock = 1.5;
        System.assertEquals(1.5, childObj.RestrictedStock);

        childObj.RestrictedValue = 1.5;
        System.assertEquals(1.5, childObj.RestrictedValue);

        childObj.BlockedStock = 1.5;
        System.assertEquals(1.5, childObj.BlockedStock);

        childObj.BlockedValue = 1.5;
        System.assertEquals(1.5, childObj.BlockedValue);

        childObj.ReturnsStock = 1.5;
        System.assertEquals(1.5, childObj.ReturnsStock);

        childObj.ReturnsValue = 1.5;
        System.assertEquals(1.5, childObj.ReturnsValue);

        childObj.SystemID = 'X';
        System.assertEquals('X', childObj.SystemID);


    }

}