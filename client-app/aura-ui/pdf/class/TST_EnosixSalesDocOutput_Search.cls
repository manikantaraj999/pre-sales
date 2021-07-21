/// enosiX Inc. Generated Apex Model
/// Generated On: 3/12/2020 1:37:06 PM
/// SAP Host: From REST Service On: https://data-efficiency-235-dev-ed.cs26.my.salesforce.com
/// CID: From REST Service On: https://data-efficiency-235-dev-ed.cs26.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
private class TST_EnosixSalesDocOutput_Search
{

    public class MockSBO_EnosixSalesDocOutput_Search implements ensxsdk.EnosixFramework.SearchSBOInitMock, ensxsdk.EnosixFramework.SearchSBOSearchMock
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
        ensxsdk.EnosixFramework.setMock(SBO_EnosixSalesDocOutput_Search.class, new MockSBO_EnosixSalesDocOutput_Search());
        SBO_EnosixSalesDocOutput_Search sbo = new SBO_EnosixSalesDocOutput_Search();
        System.assertEquals(SBO_EnosixSalesDocOutput_Search.class, sbo.getType(), 'getType() does not match object type.');

        System.assertEquals(null, sbo.initialize(null));
        System.assertEquals(null, sbo.search(null));

        SBO_EnosixSalesDocOutput_Search.EnosixSalesDocOutput_SC sc = new SBO_EnosixSalesDocOutput_Search.EnosixSalesDocOutput_SC();
        System.assertEquals(SBO_EnosixSalesDocOutput_Search.EnosixSalesDocOutput_SC.class, sc.getType(), 'getType() does not match object type.');

        sc.registerReflectionForClass();
        System.assertEquals(null, sc.result);

        System.assertNotEquals(null, sc.SEARCHPARAMS);
        System.assertNotEquals(null, sc.OUTPUT_TYPE);

    }
    
    
    @isTest
    static void testSEARCHPARAMS()
    {
        SBO_EnosixSalesDocOutput_Search.SEARCHPARAMS childObj = new SBO_EnosixSalesDocOutput_Search.SEARCHPARAMS();
        System.assertEquals(SBO_EnosixSalesDocOutput_Search.SEARCHPARAMS.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.SalesDocument = 'X';
        System.assertEquals('X', childObj.SalesDocument);

        childObj.OutputApplication = 'X';
        System.assertEquals('X', childObj.OutputApplication);


    }

    @isTest
    static void testOUTPUT_TYPE()
    {
        SBO_EnosixSalesDocOutput_Search.OUTPUT_TYPE childObj = new SBO_EnosixSalesDocOutput_Search.OUTPUT_TYPE();
        System.assertEquals(SBO_EnosixSalesDocOutput_Search.OUTPUT_TYPE.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        SBO_EnosixSalesDocOutput_Search.OUTPUT_TYPE_COLLECTION childObjCollection = new SBO_EnosixSalesDocOutput_Search.OUTPUT_TYPE_COLLECTION();
        System.assertNotEquals(null, childObjCollection.getAsList());

        childObj.ConditionType = 'X';
        System.assertEquals('X', childObj.ConditionType);

        childObj.X_GetPDF = true;
        System.assertEquals(true, childObj.X_GetPDF);


    }

    @isTest
    static void testEnosixSalesDocOutput_SR()
    {
        SBO_EnosixSalesDocOutput_Search.EnosixSalesDocOutput_SR sr = new SBO_EnosixSalesDocOutput_Search.EnosixSalesDocOutput_SR();

        sr.registerReflectionForClass();

        System.assertEquals(SBO_EnosixSalesDocOutput_Search.EnosixSalesDocOutput_SR.class, sr.getType(), 'getType() does not match object type.');

        System.assertNotEquals(null, sr.getResults());
    }


    @isTest
    static void testSEARCHRESULT()
    {
        SBO_EnosixSalesDocOutput_Search.SEARCHRESULT childObj = new SBO_EnosixSalesDocOutput_Search.SEARCHRESULT();
        System.assertEquals(SBO_EnosixSalesDocOutput_Search.SEARCHRESULT.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        SBO_EnosixSalesDocOutput_Search.SEARCHRESULT_COLLECTION childObjCollection = new SBO_EnosixSalesDocOutput_Search.SEARCHRESULT_COLLECTION();
        System.assertNotEquals(null, childObjCollection.getAsList());

        childObj.SalesDocument = 'X';
        System.assertEquals('X', childObj.SalesDocument);

        childObj.ConditionType = 'X';
        System.assertEquals('X', childObj.ConditionType);

        childObj.ConditionTypeDescription = 'X';
        System.assertEquals('X', childObj.ConditionTypeDescription);

        childObj.Language = 'X';
        System.assertEquals('X', childObj.Language);

        childObj.PDFB64String = 'X';
        System.assertEquals('X', childObj.PDFB64String);


    }

}