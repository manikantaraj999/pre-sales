/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:50:36 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
public with sharing class TST_MM_GET_PROD_HIERARCHY
{
    public class MockRFC_MM_GET_PROD_HIERARCHY implements ensxsdk.EnosixFramework.RFCMock
    {
        public ensxsdk.EnosixFramework.FunctionObject executeFunction() 
        {
            return null;
        }
    }

    @isTest
    static void testExecute()
    {
        ensxsdk.EnosixFramework.setMock(RFC_MM_GET_PROD_HIERARCHY.class, new MockRFC_MM_GET_PROD_HIERARCHY());
        RFC_MM_GET_PROD_HIERARCHY rfc = new RFC_MM_GET_PROD_HIERARCHY();
        RFC_MM_GET_PROD_HIERARCHY.RESULT params = rfc.PARAMS;
        System.assertEquals(null, rfc.execute());
    }

    @isTest
    static void testRESULT()
    {
        RFC_MM_GET_PROD_HIERARCHY.RESULT funcObj = new RFC_MM_GET_PROD_HIERARCHY.RESULT();

        funcObj.registerReflectionForClass();

        System.assertEquals(RFC_MM_GET_PROD_HIERARCHY.RESULT.class, funcObj.getType(), 'getType() does not match object type.');

        funcObj.IV_LEVEL_NUMBER = 'X';
        System.assertEquals('X', funcObj.IV_LEVEL_NUMBER);

        //Check all the collections
        funcObj.getCollection(RFC_MM_GET_PROD_HIERARCHY.ET_MATERIAL_TYPE.class).add(new RFC_MM_GET_PROD_HIERARCHY.ET_MATERIAL_TYPE());
        System.assertEquals(1,funcObj.ET_MATERIAL_TYPE_List.size());

        funcObj.getCollection(RFC_MM_GET_PROD_HIERARCHY.ET_PRODUCT_ATTRIB.class).add(new RFC_MM_GET_PROD_HIERARCHY.ET_PRODUCT_ATTRIB());
        System.assertEquals(1,funcObj.ET_PRODUCT_ATTRIB_List.size());

        funcObj.getCollection(RFC_MM_GET_PROD_HIERARCHY.ET_PROD_HIERARCHY.class).add(new RFC_MM_GET_PROD_HIERARCHY.ET_PROD_HIERARCHY());
        System.assertEquals(1,funcObj.ET_PROD_HIERARCHY_List.size());

    }

    @isTest
    static void testET_MATERIAL_TYPE()
    {
        RFC_MM_GET_PROD_HIERARCHY.ET_MATERIAL_TYPE funcObj = new RFC_MM_GET_PROD_HIERARCHY.ET_MATERIAL_TYPE();

        funcObj.registerReflectionForClass();

        System.assertEquals(RFC_MM_GET_PROD_HIERARCHY.ET_MATERIAL_TYPE.class, funcObj.getType(), 'getType() does not match object type.');
        funcObj.MTART = 'X';
        System.assertEquals('X', funcObj.MTART);

        funcObj.MTBEZ = 'X';
        System.assertEquals('X', funcObj.MTBEZ);

    }
    @isTest
    static void testET_PRODUCT_ATTRIB()
    {
        RFC_MM_GET_PROD_HIERARCHY.ET_PRODUCT_ATTRIB funcObj = new RFC_MM_GET_PROD_HIERARCHY.ET_PRODUCT_ATTRIB();

        funcObj.registerReflectionForClass();

        System.assertEquals(RFC_MM_GET_PROD_HIERARCHY.ET_PRODUCT_ATTRIB.class, funcObj.getType(), 'getType() does not match object type.');
        funcObj.PRODUCT_ATTRIB = 'X';
        System.assertEquals('X', funcObj.PRODUCT_ATTRIB);

    }
    @isTest
    static void testET_PROD_HIERARCHY()
    {
        RFC_MM_GET_PROD_HIERARCHY.ET_PROD_HIERARCHY funcObj = new RFC_MM_GET_PROD_HIERARCHY.ET_PROD_HIERARCHY();

        funcObj.registerReflectionForClass();

        System.assertEquals(RFC_MM_GET_PROD_HIERARCHY.ET_PROD_HIERARCHY.class, funcObj.getType(), 'getType() does not match object type.');
        funcObj.PRODH = 'X';
        System.assertEquals('X', funcObj.PRODH);

        funcObj.STUFE = 'X';
        System.assertEquals('X', funcObj.STUFE);

        funcObj.VTEXT = 'X';
        System.assertEquals('X', funcObj.VTEXT);

    }
}