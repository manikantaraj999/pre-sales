/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:50:36 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
public with sharing class TST_SD_GET_DOC_TYPE_VALUES
{
    public class MockRFC_SD_GET_DOC_TYPE_VALUES implements ensxsdk.EnosixFramework.RFCMock
    {
        public ensxsdk.EnosixFramework.FunctionObject executeFunction() 
        {
            return null;
        }
    }

    @isTest
    static void testExecute()
    {
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_DOC_TYPE_VALUES.class, new MockRFC_SD_GET_DOC_TYPE_VALUES());
        RFC_SD_GET_DOC_TYPE_VALUES rfc = new RFC_SD_GET_DOC_TYPE_VALUES();
        RFC_SD_GET_DOC_TYPE_VALUES.RESULT params = rfc.PARAMS;
        System.assertEquals(null, rfc.execute());
    }

    @isTest
    static void testRESULT()
    {
        RFC_SD_GET_DOC_TYPE_VALUES.RESULT funcObj = new RFC_SD_GET_DOC_TYPE_VALUES.RESULT();

        funcObj.registerReflectionForClass();

        System.assertEquals(RFC_SD_GET_DOC_TYPE_VALUES.RESULT.class, funcObj.getType(), 'getType() does not match object type.');

        //Check all the collections
        funcObj.getCollection(RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT.class).add(new RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT());
        System.assertEquals(1,funcObj.ET_OUTPUT_List.size());

    }

    @isTest
    static void testET_OUTPUT()
    {
        RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT funcObj = new RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT();

        funcObj.registerReflectionForClass();

        System.assertEquals(RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT.class, funcObj.getType(), 'getType() does not match object type.');
        funcObj.DocumentType = 'X';
        System.assertEquals('X', funcObj.DocumentType);

        funcObj.BEZEI = 'X';
        System.assertEquals('X', funcObj.BEZEI);

        funcObj.VBTYP = 'X';
        System.assertEquals('X', funcObj.VBTYP);

        funcObj.VBTYP_TEXT = 'X';
        System.assertEquals('X', funcObj.VBTYP_TEXT);

        funcObj.INCPO = 'X';
        System.assertEquals('X', funcObj.INCPO);

        funcObj.X_PONUM_REQUIRED = true;
        System.assertEquals(true, funcObj.X_PONUM_REQUIRED);

    }
}