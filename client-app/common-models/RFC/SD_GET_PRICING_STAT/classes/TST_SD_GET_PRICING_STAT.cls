/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:50:36 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
public with sharing class TST_SD_GET_PRICING_STAT
{
    public class MockRFC_SD_GET_PRICING_STAT implements ensxsdk.EnosixFramework.RFCMock
    {
        public ensxsdk.EnosixFramework.FunctionObject executeFunction() 
        {
            return null;
        }
    }

    @isTest
    static void testExecute()
    {
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_PRICING_STAT.class, new MockRFC_SD_GET_PRICING_STAT());
        RFC_SD_GET_PRICING_STAT rfc = new RFC_SD_GET_PRICING_STAT();
        RFC_SD_GET_PRICING_STAT.RESULT params = rfc.PARAMS;
        System.assertEquals(null, rfc.execute());
    }

    @isTest
    static void testRESULT()
    {
        RFC_SD_GET_PRICING_STAT.RESULT funcObj = new RFC_SD_GET_PRICING_STAT.RESULT();

        funcObj.registerReflectionForClass();

        System.assertEquals(RFC_SD_GET_PRICING_STAT.RESULT.class, funcObj.getType(), 'getType() does not match object type.');

        funcObj.PRICE_GRP = true;
        System.assertEquals(true, funcObj.PRICE_GRP);

        funcObj.PRICE_LIST = true;
        System.assertEquals(true, funcObj.PRICE_LIST);

        funcObj.PRICE_PROC = true;
        System.assertEquals(true, funcObj.PRICE_PROC);

        funcObj.STAT_GRP = true;
        System.assertEquals(true, funcObj.STAT_GRP);

        //Check all the collections
        funcObj.getCollection(RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_GRP.class).add(new RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_GRP());
        System.assertEquals(1,funcObj.ET_CUST_PRICE_GRP_List.size());

        funcObj.getCollection(RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_LIST.class).add(new RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_LIST());
        System.assertEquals(1,funcObj.ET_CUST_PRICE_LIST_List.size());

        funcObj.getCollection(RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_PROC.class).add(new RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_PROC());
        System.assertEquals(1,funcObj.ET_CUST_PRICE_PROC_List.size());

        funcObj.getCollection(RFC_SD_GET_PRICING_STAT.ET_CUST_STAT_GROUP.class).add(new RFC_SD_GET_PRICING_STAT.ET_CUST_STAT_GROUP());
        System.assertEquals(1,funcObj.ET_CUST_STAT_GROUP_List.size());

    }

    @isTest
    static void testET_CUST_PRICE_GRP()
    {
        RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_GRP funcObj = new RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_GRP();

        funcObj.registerReflectionForClass();

        System.assertEquals(RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_GRP.class, funcObj.getType(), 'getType() does not match object type.');
        funcObj.KONDA = 'X';
        System.assertEquals('X', funcObj.KONDA);

        funcObj.VTEXT = 'X';
        System.assertEquals('X', funcObj.VTEXT);

    }
    @isTest
    static void testET_CUST_PRICE_LIST()
    {
        RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_LIST funcObj = new RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_LIST();

        funcObj.registerReflectionForClass();

        System.assertEquals(RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_LIST.class, funcObj.getType(), 'getType() does not match object type.');
        funcObj.PLTYP = 'X';
        System.assertEquals('X', funcObj.PLTYP);

        funcObj.PTEXT = 'X';
        System.assertEquals('X', funcObj.PTEXT);

    }
    @isTest
    static void testET_CUST_PRICE_PROC()
    {
        RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_PROC funcObj = new RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_PROC();

        funcObj.registerReflectionForClass();

        System.assertEquals(RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_PROC.class, funcObj.getType(), 'getType() does not match object type.');
        funcObj.KALKS = 'X';
        System.assertEquals('X', funcObj.KALKS);

        funcObj.VTEXT = 'X';
        System.assertEquals('X', funcObj.VTEXT);

    }
    @isTest
    static void testET_CUST_STAT_GROUP()
    {
        RFC_SD_GET_PRICING_STAT.ET_CUST_STAT_GROUP funcObj = new RFC_SD_GET_PRICING_STAT.ET_CUST_STAT_GROUP();

        funcObj.registerReflectionForClass();

        System.assertEquals(RFC_SD_GET_PRICING_STAT.ET_CUST_STAT_GROUP.class, funcObj.getType(), 'getType() does not match object type.');
        funcObj.STGKU = 'X';
        System.assertEquals('X', funcObj.STGKU);

        funcObj.BEZEI20 = 'X';
        System.assertEquals('X', funcObj.BEZEI20);

    }
}