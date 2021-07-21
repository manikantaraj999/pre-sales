@isTest
public with sharing class TSTC_CreditCardEntry
{

    class MOC_initEnosixXiIntercept implements ensxsdk.EnosixFramework.DetailSBOInitMock, ensxsdk.EnosixFramework.DetailSBOCommandMock
    {
        public ensxsdk.EnosixFramework.DetailObject executeInitialize(ensxsdk.EnosixFramework.DetailObject obj)
        {
            SBO_EnosixXiIntercept_Detail.EnosixXiIntercept result = new SBO_EnosixXiIntercept_Detail.EnosixXiIntercept();
            result.setSuccess(true);
            return result;
        }

        public ensxsdk.EnosixFramework.DetailObject executeCommand(String command, ensxsdk.EnosixFramework.DetailObject obj)
        {
            System.assertEquals('CMD_ACCESS_TOKEN', command);
            SBO_EnosixXiIntercept_Detail.EnosixXiIntercept result = new SBO_EnosixXiIntercept_Detail.EnosixXiIntercept();
            result.setSuccess(true);
            return result;
        }
    }

    class MOC_getCardInfo implements ensxsdk.EnosixFramework.DetailSBOCommandMock
    {
        public ensxsdk.EnosixFramework.DetailObject executeCommand(String command, ensxsdk.EnosixFramework.DetailObject obj)
        {
            System.assertEquals('CMD_ENCRYPT_CCARD', command);
            SBO_EnosixXiIntercept_Detail.EnosixXiIntercept result = new SBO_EnosixXiIntercept_Detail.EnosixXiIntercept();
            result.setSuccess(true);
            return result;
        }
    }

    @isTest
    static void test_getHostUrl()
    {
        Test.startTest();
        String result = CTRL_CreditCardEntry.getHostUrl();
        Test.stopTest();
        System.assert(String.isNotBlank(result));
    }

    @isTest
    static void test_constructorAndProperties()
    {
        ensxsdk.EnosixFramework.setMock(SBO_EnosixXiIntercept_Detail.class, new MOC_initEnosixXiIntercept());
        Test.startTest();
        CTRL_CreditCardEntry controller = new CTRL_CreditCardEntry();
        CB_CardDetailsReceiver cardDetailsReceiver = controller.cardDetailsReceiver;
        controller.cardDetailsReceiver = new CTRL_CustomerPaymentEntry();
        SBO_EnosixXiIntercept_Detail.EnosixXiIntercept intercept = controller.intercept;
        String parent = controller.parentRerender;
        String jssub = controller.jsSubmitMethodName;
        String js = controller.jsInitMethodName;
        String targetUrl = controller.targetUrl;
        controller.actionInitAccessToken();
        Test.stopTest();
    }

    @isTest
    static void test_getCardInfo()
    {
        ensxsdk.EnosixFramework.setMock(SBO_EnosixXiIntercept_Detail.class, new MOC_getCardInfo());
        Test.startTest();
        CTRL_CreditCardEntry controller = new CTRL_CreditCardEntry();
        CB_CardDetailsReceiver cardDetailsReceiver = controller.cardDetailsReceiver;
        controller.cardDetailsReceiver = new CTRL_CustomerPaymentEntry();
        SBO_EnosixXiIntercept_Detail.EnosixXiIntercept intercept = controller.intercept;
        controller.actionGetCardDetails();
        Test.stopTest();
    }
}