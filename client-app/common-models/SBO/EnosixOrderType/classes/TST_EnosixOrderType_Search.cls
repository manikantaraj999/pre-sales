/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
private class TST_EnosixOrderType_Search
{

    public class MockSBO_EnosixOrderType_Search implements ensxsdk.EnosixFramework.SearchSBOInitMock, ensxsdk.EnosixFramework.SearchSBOSearchMock
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
        ensxsdk.EnosixFramework.setMock(SBO_EnosixOrderType_Search.class, new MockSBO_EnosixOrderType_Search());
        SBO_EnosixOrderType_Search sbo = new SBO_EnosixOrderType_Search();
        System.assertEquals(SBO_EnosixOrderType_Search.class, sbo.getType(), 'getType() does not match object type.');

        System.assertEquals(null, sbo.initialize(null));
        System.assertEquals(null, sbo.search(null));

        SBO_EnosixOrderType_Search.EnosixOrderType_SC sc = new SBO_EnosixOrderType_Search.EnosixOrderType_SC();
        System.assertEquals(SBO_EnosixOrderType_Search.EnosixOrderType_SC.class, sc.getType(), 'getType() does not match object type.');

        sc.registerReflectionForClass();
        System.assertEquals(null, sc.result);

        System.assertNotEquals(null, sc.SEARCHPARAMS);

    }
    
    
    @isTest
    static void testSEARCHPARAMS()
    {
        SBO_EnosixOrderType_Search.SEARCHPARAMS childObj = new SBO_EnosixOrderType_Search.SEARCHPARAMS();
        System.assertEquals(SBO_EnosixOrderType_Search.SEARCHPARAMS.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.SalesDocumentType = 'X';
        System.assertEquals('X', childObj.SalesDocumentType);

        childObj.SO = true;
        System.assertEquals(true, childObj.SO);

        childObj.QT = true;
        System.assertEquals(true, childObj.QT);

        childObj.ARM = true;
        System.assertEquals(true, childObj.ARM);


    }

    @isTest
    static void testEnosixOrderType_SR()
    {
        SBO_EnosixOrderType_Search.EnosixOrderType_SR sr = new SBO_EnosixOrderType_Search.EnosixOrderType_SR();

        sr.registerReflectionForClass();

        System.assertEquals(SBO_EnosixOrderType_Search.EnosixOrderType_SR.class, sr.getType(), 'getType() does not match object type.');

        System.assertNotEquals(null, sr.getResults());
    }


    @isTest
    static void testSEARCHRESULT()
    {
        SBO_EnosixOrderType_Search.SEARCHRESULT childObj = new SBO_EnosixOrderType_Search.SEARCHRESULT();
        System.assertEquals(SBO_EnosixOrderType_Search.SEARCHRESULT.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        SBO_EnosixOrderType_Search.SEARCHRESULT_COLLECTION childObjCollection = new SBO_EnosixOrderType_Search.SEARCHRESULT_COLLECTION();
        System.assertNotEquals(null, childObjCollection.getAsList());

        childObj.SalesDocumentType = 'X';
        System.assertEquals('X', childObj.SalesDocumentType);

        childObj.SalesDocumentTypeDescription = 'X';
        System.assertEquals('X', childObj.SalesDocumentTypeDescription);


    }

}