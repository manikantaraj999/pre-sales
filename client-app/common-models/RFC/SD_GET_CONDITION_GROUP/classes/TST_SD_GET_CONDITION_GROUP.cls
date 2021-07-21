/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:50:36 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
public with sharing class TST_SD_GET_CONDITION_GROUP
{
    public class MockRFC_SD_GET_CONDITION_GROUP implements ensxsdk.EnosixFramework.RFCMock
    {
        public ensxsdk.EnosixFramework.FunctionObject executeFunction() 
        {
            return null;
        }
    }

    @isTest
    static void testExecute()
    {
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_CONDITION_GROUP.class, new MockRFC_SD_GET_CONDITION_GROUP());
        RFC_SD_GET_CONDITION_GROUP rfc = new RFC_SD_GET_CONDITION_GROUP();
        RFC_SD_GET_CONDITION_GROUP.RESULT params = rfc.PARAMS;
        System.assertEquals(null, rfc.execute());
    }

    @isTest
    static void testRESULT()
    {
        RFC_SD_GET_CONDITION_GROUP.RESULT funcObj = new RFC_SD_GET_CONDITION_GROUP.RESULT();

        funcObj.registerReflectionForClass();

        System.assertEquals(RFC_SD_GET_CONDITION_GROUP.RESULT.class, funcObj.getType(), 'getType() does not match object type.');

        //Check all the collections
        funcObj.getCollection(RFC_SD_GET_CONDITION_GROUP.ET_COND_GROUP.class).add(new RFC_SD_GET_CONDITION_GROUP.ET_COND_GROUP());
        System.assertEquals(1,funcObj.ET_COND_GROUP_List.size());

    }

    @isTest
    static void testET_COND_GROUP()
    {
        RFC_SD_GET_CONDITION_GROUP.ET_COND_GROUP funcObj = new RFC_SD_GET_CONDITION_GROUP.ET_COND_GROUP();

        funcObj.registerReflectionForClass();

        System.assertEquals(RFC_SD_GET_CONDITION_GROUP.ET_COND_GROUP.class, funcObj.getType(), 'getType() does not match object type.');
        funcObj.KDKGR = 'X';
        System.assertEquals('X', funcObj.KDKGR);

        funcObj.VTEXT = 'X';
        System.assertEquals('X', funcObj.VTEXT);

    }
}