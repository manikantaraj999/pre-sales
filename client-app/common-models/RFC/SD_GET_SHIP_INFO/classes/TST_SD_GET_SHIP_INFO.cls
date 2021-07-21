/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:50:36 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
public with sharing class TST_SD_GET_SHIP_INFO
{
    public class MockRFC_SD_GET_SHIP_INFO implements ensxsdk.EnosixFramework.RFCMock
    {
        public ensxsdk.EnosixFramework.FunctionObject executeFunction() 
        {
            return null;
        }
    }

    @isTest
    static void testExecute()
    {
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_SHIP_INFO.class, new MockRFC_SD_GET_SHIP_INFO());
        RFC_SD_GET_SHIP_INFO rfc = new RFC_SD_GET_SHIP_INFO();
        RFC_SD_GET_SHIP_INFO.RESULT params = rfc.PARAMS;
        System.assertEquals(null, rfc.execute());
    }

    @isTest
    static void testRESULT()
    {
        RFC_SD_GET_SHIP_INFO.RESULT funcObj = new RFC_SD_GET_SHIP_INFO.RESULT();

        funcObj.registerReflectionForClass();

        System.assertEquals(RFC_SD_GET_SHIP_INFO.RESULT.class, funcObj.getType(), 'getType() does not match object type.');

        funcObj.FREIGHT_TERMS = true;
        System.assertEquals(true, funcObj.FREIGHT_TERMS);

        funcObj.PAY_TERMS = true;
        System.assertEquals(true, funcObj.PAY_TERMS);

        funcObj.SHIP_COND = true;
        System.assertEquals(true, funcObj.SHIP_COND);

        //Check all the collections
        funcObj.getCollection(RFC_SD_GET_SHIP_INFO.ET_FREIGHT_TERMS.class).add(new RFC_SD_GET_SHIP_INFO.ET_FREIGHT_TERMS());
        System.assertEquals(1,funcObj.ET_FREIGHT_TERMS_List.size());

        funcObj.getCollection(RFC_SD_GET_SHIP_INFO.ET_PAY_TERMS.class).add(new RFC_SD_GET_SHIP_INFO.ET_PAY_TERMS());
        System.assertEquals(1,funcObj.ET_PAY_TERMS_List.size());

        funcObj.getCollection(RFC_SD_GET_SHIP_INFO.ET_SHIP_COND.class).add(new RFC_SD_GET_SHIP_INFO.ET_SHIP_COND());
        System.assertEquals(1,funcObj.ET_SHIP_COND_List.size());

    }

    @isTest
    static void testET_FREIGHT_TERMS()
    {
        RFC_SD_GET_SHIP_INFO.ET_FREIGHT_TERMS funcObj = new RFC_SD_GET_SHIP_INFO.ET_FREIGHT_TERMS();

        funcObj.registerReflectionForClass();

        System.assertEquals(RFC_SD_GET_SHIP_INFO.ET_FREIGHT_TERMS.class, funcObj.getType(), 'getType() does not match object type.');
        funcObj.INCO1 = 'X';
        System.assertEquals('X', funcObj.INCO1);

        funcObj.BEZEI = 'X';
        System.assertEquals('X', funcObj.BEZEI);

    }
    @isTest
    static void testET_PAY_TERMS()
    {
        RFC_SD_GET_SHIP_INFO.ET_PAY_TERMS funcObj = new RFC_SD_GET_SHIP_INFO.ET_PAY_TERMS();

        funcObj.registerReflectionForClass();

        System.assertEquals(RFC_SD_GET_SHIP_INFO.ET_PAY_TERMS.class, funcObj.getType(), 'getType() does not match object type.');
        funcObj.ZTERM = 'X';
        System.assertEquals('X', funcObj.ZTERM);

        funcObj.VTEXT = 'X';
        System.assertEquals('X', funcObj.VTEXT);

    }
    @isTest
    static void testET_SHIP_COND()
    {
        RFC_SD_GET_SHIP_INFO.ET_SHIP_COND funcObj = new RFC_SD_GET_SHIP_INFO.ET_SHIP_COND();

        funcObj.registerReflectionForClass();

        System.assertEquals(RFC_SD_GET_SHIP_INFO.ET_SHIP_COND.class, funcObj.getType(), 'getType() does not match object type.');
        funcObj.ShippingConditions = 'X';
        System.assertEquals('X', funcObj.ShippingConditions);

        funcObj.VTEXT = 'X';
        System.assertEquals('X', funcObj.VTEXT);

    }
}