/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:50:36 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
public with sharing class TST_SD_GET_DOC_CATEG_VALUES
{
    public class MockRFC_SD_GET_DOC_CATEG_VALUES implements ensxsdk.EnosixFramework.RFCMock
    {
        public ensxsdk.EnosixFramework.FunctionObject executeFunction() 
        {
            return null;
        }
    }

    @isTest
    static void testExecute()
    {
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_DOC_CATEG_VALUES.class, new MockRFC_SD_GET_DOC_CATEG_VALUES());
        RFC_SD_GET_DOC_CATEG_VALUES rfc = new RFC_SD_GET_DOC_CATEG_VALUES();
        RFC_SD_GET_DOC_CATEG_VALUES.RESULT params = rfc.PARAMS;
        System.assertEquals(null, rfc.execute());
    }

    @isTest
    static void testRESULT()
    {
        RFC_SD_GET_DOC_CATEG_VALUES.RESULT funcObj = new RFC_SD_GET_DOC_CATEG_VALUES.RESULT();

        funcObj.registerReflectionForClass();

        System.assertEquals(RFC_SD_GET_DOC_CATEG_VALUES.RESULT.class, funcObj.getType(), 'getType() does not match object type.');

        funcObj.IV_DOMAIN_NAME = 'X';
        System.assertEquals('X', funcObj.IV_DOMAIN_NAME);

        //Check all the collections
        funcObj.getCollection(RFC_SD_GET_DOC_CATEG_VALUES.ET_VALUES.class).add(new RFC_SD_GET_DOC_CATEG_VALUES.ET_VALUES());
        System.assertEquals(1,funcObj.ET_VALUES_List.size());

    }

    @isTest
    static void testET_VALUES()
    {
        RFC_SD_GET_DOC_CATEG_VALUES.ET_VALUES funcObj = new RFC_SD_GET_DOC_CATEG_VALUES.ET_VALUES();

        funcObj.registerReflectionForClass();

        System.assertEquals(RFC_SD_GET_DOC_CATEG_VALUES.ET_VALUES.class, funcObj.getType(), 'getType() does not match object type.');
        funcObj.VBTYP = 'X';
        System.assertEquals('X', funcObj.VBTYP);

        funcObj.VBTYP_TEXT = 'X';
        System.assertEquals('X', funcObj.VBTYP_TEXT);

    }
}