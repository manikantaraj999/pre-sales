/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:50:36 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
public with sharing class TST_SD_GET_BP_ROLE_TYPE
{
    public class MockRFC_SD_GET_BP_ROLE_TYPE implements ensxsdk.EnosixFramework.RFCMock
    {
        public ensxsdk.EnosixFramework.FunctionObject executeFunction() 
        {
            return null;
        }
    }

    @isTest
    static void testExecute()
    {
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_BP_ROLE_TYPE.class, new MockRFC_SD_GET_BP_ROLE_TYPE());
        RFC_SD_GET_BP_ROLE_TYPE rfc = new RFC_SD_GET_BP_ROLE_TYPE();
        RFC_SD_GET_BP_ROLE_TYPE.RESULT params = rfc.PARAMS;
        System.assertEquals(null, rfc.execute());
    }

    @isTest
    static void testRESULT()
    {
        RFC_SD_GET_BP_ROLE_TYPE.RESULT funcObj = new RFC_SD_GET_BP_ROLE_TYPE.RESULT();

        funcObj.registerReflectionForClass();

        System.assertEquals(RFC_SD_GET_BP_ROLE_TYPE.RESULT.class, funcObj.getType(), 'getType() does not match object type.');

        funcObj.IV_CID = 'X';
        System.assertEquals('X', funcObj.IV_CID);

        //Check all the collections
        funcObj.getCollection(RFC_SD_GET_BP_ROLE_TYPE.ET_BP_CATEGORY.class).add(new RFC_SD_GET_BP_ROLE_TYPE.ET_BP_CATEGORY());
        System.assertEquals(1,funcObj.ET_BP_CATEGORY_List.size());

        funcObj.getCollection(RFC_SD_GET_BP_ROLE_TYPE.ET_BP_ROLE.class).add(new RFC_SD_GET_BP_ROLE_TYPE.ET_BP_ROLE());
        System.assertEquals(1,funcObj.ET_BP_ROLE_List.size());

        funcObj.getCollection(RFC_SD_GET_BP_ROLE_TYPE.ET_BP_ROLE_GROUP.class).add(new RFC_SD_GET_BP_ROLE_TYPE.ET_BP_ROLE_GROUP());
        System.assertEquals(1,funcObj.ET_BP_ROLE_GROUP_List.size());

        funcObj.getCollection(RFC_SD_GET_BP_ROLE_TYPE.ET_BP_TYPE.class).add(new RFC_SD_GET_BP_ROLE_TYPE.ET_BP_TYPE());
        System.assertEquals(1,funcObj.ET_BP_TYPE_List.size());

    }

    @isTest
    static void testET_BP_CATEGORY()
    {
        RFC_SD_GET_BP_ROLE_TYPE.ET_BP_CATEGORY funcObj = new RFC_SD_GET_BP_ROLE_TYPE.ET_BP_CATEGORY();

        funcObj.registerReflectionForClass();

        System.assertEquals(RFC_SD_GET_BP_ROLE_TYPE.ET_BP_CATEGORY.class, funcObj.getType(), 'getType() does not match object type.');
        funcObj.Category = 'X';
        System.assertEquals('X', funcObj.Category);

        funcObj.Description = 'X';
        System.assertEquals('X', funcObj.Description);

    }
    @isTest
    static void testET_BP_ROLE()
    {
        RFC_SD_GET_BP_ROLE_TYPE.ET_BP_ROLE funcObj = new RFC_SD_GET_BP_ROLE_TYPE.ET_BP_ROLE();

        funcObj.registerReflectionForClass();

        System.assertEquals(RFC_SD_GET_BP_ROLE_TYPE.ET_BP_ROLE.class, funcObj.getType(), 'getType() does not match object type.');
        funcObj.Role = 'X';
        System.assertEquals('X', funcObj.Role);

        funcObj.ForPerson = true;
        System.assertEquals(true, funcObj.ForPerson);

        funcObj.ForOrg = true;
        System.assertEquals(true, funcObj.ForOrg);

        funcObj.ForGroup = true;
        System.assertEquals(true, funcObj.ForGroup);

        funcObj.Description = 'X';
        System.assertEquals('X', funcObj.Description);

    }
    @isTest
    static void testET_BP_ROLE_GROUP()
    {
        RFC_SD_GET_BP_ROLE_TYPE.ET_BP_ROLE_GROUP funcObj = new RFC_SD_GET_BP_ROLE_TYPE.ET_BP_ROLE_GROUP();

        funcObj.registerReflectionForClass();

        System.assertEquals(RFC_SD_GET_BP_ROLE_TYPE.ET_BP_ROLE_GROUP.class, funcObj.getType(), 'getType() does not match object type.');
        funcObj.RLTGR = 'X';
        System.assertEquals('X', funcObj.RLTGR);

        funcObj.RLTGRTXT = 'X';
        System.assertEquals('X', funcObj.RLTGRTXT);

    }
    @isTest
    static void testET_BP_TYPE()
    {
        RFC_SD_GET_BP_ROLE_TYPE.ET_BP_TYPE funcObj = new RFC_SD_GET_BP_ROLE_TYPE.ET_BP_TYPE();

        funcObj.registerReflectionForClass();

        System.assertEquals(RFC_SD_GET_BP_ROLE_TYPE.ET_BP_TYPE.class, funcObj.getType(), 'getType() does not match object type.');
        funcObj.FieldType = 'X';
        System.assertEquals('X', funcObj.FieldType);

        funcObj.Description = 'X';
        System.assertEquals('X', funcObj.Description);

    }
}