/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
public with sharing class TST_EnosixXiIntercept_Detail
{
    public class MockSBO_EnosixXiIntercept_Detail implements
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
        SBO_EnosixXiIntercept_Detail sbo = new SBO_EnosixXiIntercept_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixXiIntercept_Detail.class, new MockSBO_EnosixXiIntercept_Detail());
        System.assertEquals(null, sbo.initialize(null));
        System.assertEquals(null, sbo.command(null, null));
        System.assertEquals(null, sbo.getDetail(null));
        System.assertEquals(null, sbo.save(null));
    }

    @isTest
    static void testEnosixXiIntercept()
    {
        SBO_EnosixXiIntercept_Detail.EnosixXiIntercept result = new SBO_EnosixXiIntercept_Detail.EnosixXiIntercept();
        System.assertEquals(SBO_EnosixXiIntercept_Detail.EnosixXiIntercept.class, result.getType(), 'getType() does not match object type.');

        result.registerReflectionForClass();

        result.MerchantGUID = 'X';
        System.assertEquals('X', result.MerchantGUID);

        result.AccessToken = 'X';
        System.assertEquals('X', result.AccessToken);

        result.Signature = 'X';
        System.assertEquals('X', result.Signature);

        result.StatusCode = 'X';
        System.assertEquals('X', result.StatusCode);

        result.Message = 'X';
        System.assertEquals('X', result.Message);

        result.XiInterceptURL = 'X';
        System.assertEquals('X', result.XiInterceptURL);

        result.Key = 'X';
        System.assertEquals('X', result.Key);

        result.CreditCardNumber = 'X';
        System.assertEquals('X', result.CreditCardNumber);

        result.CreditCardHolder = 'X';
        System.assertEquals('X', result.CreditCardHolder);

        result.ValidToMonth = 'X';
        System.assertEquals('X', result.ValidToMonth);

        result.ValidToYear = 'X';
        System.assertEquals('X', result.ValidToYear);

        result.CardVerificationValue = true;
        System.assertEquals(true, result.CardVerificationValue);

        result.HostUri = 'X';
        System.assertEquals('X', result.HostUri);

        result.CSSUri = 'X';
        System.assertEquals('X', result.CSSUri);

        //Test child collections
        System.assertNotEquals(null,result.RESPONSE);
        System.assertNotEquals(null,result.CMPI_LOOKUP);
        System.assertNotEquals(null,result.CMPI_AUTHENTICATE);
        System.assertNotEquals(null,result.FIELDS.getAsList());
        System.assertNotEquals(null,result.PAYMENT_TYPES.getAsList());
    }

    @isTest
    static void testRESPONSE()
    {
        SBO_EnosixXiIntercept_Detail.RESPONSE childObj = new SBO_EnosixXiIntercept_Detail.RESPONSE();
        System.assertEquals(SBO_EnosixXiIntercept_Detail.RESPONSE.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.StatusCode = 'X';
        System.assertEquals('X', childObj.StatusCode);

        childObj.Message = 'X';
        System.assertEquals('X', childObj.Message);

        childObj.CreditCardNumber = 'X';
        System.assertEquals('X', childObj.CreditCardNumber);

        childObj.PaymetricCardType = 'X';
        System.assertEquals('X', childObj.PaymetricCardType);

        childObj.CreditCardHolder = 'X';
        System.assertEquals('X', childObj.CreditCardHolder);

        childObj.ValidToMonth = 'X';
        System.assertEquals('X', childObj.ValidToMonth);

        childObj.ValidToYear = 'X';
        System.assertEquals('X', childObj.ValidToYear);

        childObj.CardVerificationValue = 'X';
        System.assertEquals('X', childObj.CardVerificationValue);

        childObj.SAPCardType = 'X';
        System.assertEquals('X', childObj.SAPCardType);

        List<string> keyFields = new List<string>{ 'EnosixObjKey' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testCMPI_LOOKUP()
    {
        SBO_EnosixXiIntercept_Detail.CMPI_LOOKUP childObj = new SBO_EnosixXiIntercept_Detail.CMPI_LOOKUP();
        System.assertEquals(SBO_EnosixXiIntercept_Detail.CMPI_LOOKUP.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.ErrorNo = 'X';
        System.assertEquals('X', childObj.ErrorNo);

        childObj.ErrorDescription = 'X';
        System.assertEquals('X', childObj.ErrorDescription);

        childObj.Secure3DECIFlag = 'X';
        System.assertEquals('X', childObj.Secure3DECIFlag);

        childObj.AvailabilityStatus = 'X';
        System.assertEquals('X', childObj.AvailabilityStatus);

        childObj.CentinelTransactionID = 'X';
        System.assertEquals('X', childObj.CentinelTransactionID);

        childObj.CentinelOrderID = 'X';
        System.assertEquals('X', childObj.CentinelOrderID);

        childObj.EncodedPaymentRequest = 'X';
        System.assertEquals('X', childObj.EncodedPaymentRequest);

        childObj.RedirectURL = 'X';
        System.assertEquals('X', childObj.RedirectURL);

        List<string> keyFields = new List<string>{ 'EnosixObjKey' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testCMPI_AUTHENTICATE()
    {
        SBO_EnosixXiIntercept_Detail.CMPI_AUTHENTICATE childObj = new SBO_EnosixXiIntercept_Detail.CMPI_AUTHENTICATE();
        System.assertEquals(SBO_EnosixXiIntercept_Detail.CMPI_AUTHENTICATE.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.Secure3DECIFlag = 'X';
        System.assertEquals('X', childObj.Secure3DECIFlag);

        childObj.ParesStatus = 'X';
        System.assertEquals('X', childObj.ParesStatus);

        childObj.SignatureVerification = 'X';
        System.assertEquals('X', childObj.SignatureVerification);

        childObj.CardinallXID = 'X';
        System.assertEquals('X', childObj.CardinallXID);

        childObj.ErrorNo = 'X';
        System.assertEquals('X', childObj.ErrorNo);

        childObj.ErrorDescription = 'X';
        System.assertEquals('X', childObj.ErrorDescription);

        childObj.Secure3DCAVV = 'X';
        System.assertEquals('X', childObj.Secure3DCAVV);

        List<string> keyFields = new List<string>{ 'EnosixObjKey' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testFIELDS()
    {
        SBO_EnosixXiIntercept_Detail.FIELDS childObj = new SBO_EnosixXiIntercept_Detail.FIELDS();
        System.assertEquals(SBO_EnosixXiIntercept_Detail.FIELDS.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.Name = 'X';
        System.assertEquals('X', childObj.Name);

        childObj.Value = 'X';
        System.assertEquals('X', childObj.Value);

        List<string> keyFields = new List<string>{ 'NAME' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testPAYMENT_TYPES()
    {
        SBO_EnosixXiIntercept_Detail.PAYMENT_TYPES childObj = new SBO_EnosixXiIntercept_Detail.PAYMENT_TYPES();
        System.assertEquals(SBO_EnosixXiIntercept_Detail.PAYMENT_TYPES.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.PaymentType = 'X';
        System.assertEquals('X', childObj.PaymentType);

        childObj.Value = 'X';
        System.assertEquals('X', childObj.Value);

        childObj.Text = 'X';
        System.assertEquals('X', childObj.Text);

        List<string> keyFields = new List<string>{ 'TYPE','VALUE' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
}
