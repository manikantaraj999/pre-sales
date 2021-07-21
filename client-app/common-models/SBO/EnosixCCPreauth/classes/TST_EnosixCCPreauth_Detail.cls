/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
public with sharing class TST_EnosixCCPreauth_Detail
{
    public class MockSBO_EnosixCCPreauth_Detail implements
        ensxsdk.EnosixFramework.DetailSBOInitMock,
        ensxsdk.EnosixFramework.DetailSBOCommandMock,
        ensxsdk.EnosixFramework.DetailSBOGetMock,
        ensxsdk.EnosixFramework.DetailSBOSaveMock
    {
        public ensxsdk.EnosixFramework.DetailObject executeInitialize(ensxsdk.EnosixFramework.DetailObject initialState) { return null; }
        public ensxsdk.EnosixFramework.DetailObject executeCommand(String command, ensxsdk.EnosixFramework.DetailObject obj) { return null; }
        public ensxsdk.EnosixFramework.DetailObject executeGetDetail(object key) { return null; }
        public ensxsdk.EnosixFramework.DetailObject executeSave(ensxsdk.EnosixFramework.DetailObject obj) { return null; }
    }

    @isTest
    static void testSBO()
    {
        SBO_EnosixCCPreauth_Detail sbo = new SBO_EnosixCCPreauth_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCCPreauth_Detail.class, new MockSBO_EnosixCCPreauth_Detail());
        System.assertEquals(null, sbo.initialize(null));
        System.assertEquals(null, sbo.command(null, null));
        System.assertEquals(null, sbo.getDetail(null));
        System.assertEquals(null, sbo.save(null));
    }

    @isTest
    static void testEnosixCCPreauth()
    {
        SBO_EnosixCCPreauth_Detail.EnosixCCPreauth result = new SBO_EnosixCCPreauth_Detail.EnosixCCPreauth();
        System.assertEquals(SBO_EnosixCCPreauth_Detail.EnosixCCPreauth.class, result.getType(), 'getType() does not match object type.');

        result.registerReflectionForClass();

        result.CreditCardNumber = 'X';
        System.assertEquals('X', result.CreditCardNumber);

        result.CardVerificationValue = 'X';
        System.assertEquals('X', result.CardVerificationValue);

        result.AmountToBeAuthorized = 1.5;
        System.assertEquals(1.5, result.AmountToBeAuthorized);

        result.FieldCurrency = 'X';
        System.assertEquals('X', result.FieldCurrency);

        result.CardType = 'X';
        System.assertEquals('X', result.CardType);

        result.CadholderName = 'X';
        System.assertEquals('X', result.CadholderName);

        result.ValidToDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), result.ValidToDate);

        //Test child collections
        System.assertNotEquals(null,result.RESPONSE);
    }

    @isTest
    static void testRESPONSE()
    {
        SBO_EnosixCCPreauth_Detail.RESPONSE childObj = new SBO_EnosixCCPreauth_Detail.RESPONSE();
        System.assertEquals(SBO_EnosixCCPreauth_Detail.RESPONSE.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.AuthorizationResponse = 'X';
        System.assertEquals('X', childObj.AuthorizationResponse);

        childObj.AuthorizedAmount = 1.5;
        System.assertEquals(1.5, childObj.AuthorizedAmount);

        childObj.AuthorizationNumber = 'X';
        System.assertEquals('X', childObj.AuthorizationNumber);

        childObj.AuthorizationReferenceCode = 'X';
        System.assertEquals('X', childObj.AuthorizationReferenceCode);

        childObj.ResultCode = 'X';
        System.assertEquals('X', childObj.ResultCode);

        childObj.ResultCodeText = 'X';
        System.assertEquals('X', childObj.ResultCodeText);

        childObj.CVVResultCode = 'X';
        System.assertEquals('X', childObj.CVVResultCode);

        List<string> keyFields = new List<string>{ 'EnosixObjKey' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
}
