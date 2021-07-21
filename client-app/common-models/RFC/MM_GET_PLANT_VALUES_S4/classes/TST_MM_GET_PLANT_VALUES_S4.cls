/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:50:36 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
public with sharing class TST_MM_GET_PLANT_VALUES_S4
{
    public class MockRFC_MM_GET_PLANT_VALUES_S4 implements ensxsdk.EnosixFramework.RFCMock
    {
        public ensxsdk.EnosixFramework.FunctionObject executeFunction() 
        {
            return null;
        }
    }

    @isTest
    static void testExecute()
    {
        ensxsdk.EnosixFramework.setMock(RFC_MM_GET_PLANT_VALUES_S4.class, new MockRFC_MM_GET_PLANT_VALUES_S4());
        RFC_MM_GET_PLANT_VALUES_S4 rfc = new RFC_MM_GET_PLANT_VALUES_S4();
        RFC_MM_GET_PLANT_VALUES_S4.RESULT params = rfc.PARAMS;
        System.assertEquals(null, rfc.execute());
    }

    @isTest
    static void testRESULT()
    {
        RFC_MM_GET_PLANT_VALUES_S4.RESULT funcObj = new RFC_MM_GET_PLANT_VALUES_S4.RESULT();

        funcObj.registerReflectionForClass();

        System.assertEquals(RFC_MM_GET_PLANT_VALUES_S4.RESULT.class, funcObj.getType(), 'getType() does not match object type.');

        //Check all the collections
        funcObj.getCollection(RFC_MM_GET_PLANT_VALUES_S4.ET_OUTPUT.class).add(new RFC_MM_GET_PLANT_VALUES_S4.ET_OUTPUT());
        System.assertEquals(1,funcObj.ET_OUTPUT_List.size());

    }

    @isTest
    static void testET_OUTPUT()
    {
        RFC_MM_GET_PLANT_VALUES_S4.ET_OUTPUT funcObj = new RFC_MM_GET_PLANT_VALUES_S4.ET_OUTPUT();

        funcObj.registerReflectionForClass();

        System.assertEquals(RFC_MM_GET_PLANT_VALUES_S4.ET_OUTPUT.class, funcObj.getType(), 'getType() does not match object type.');
        funcObj.Plant = 'X';
        System.assertEquals('X', funcObj.Plant);

        funcObj.PlantName = 'X';
        System.assertEquals('X', funcObj.PlantName);

    }
}