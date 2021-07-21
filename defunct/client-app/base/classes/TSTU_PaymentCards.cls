@isTest
public with sharing class TSTU_PaymentCards
{
    @isTest
    static void test_addCardToOrder()
    {
        SBO_EnosixXiIntercept_Detail.RESPONSE response = new SBO_EnosixXiIntercept_Detail.RESPONSE();
        response.CreditCardNumber = '123456789012';
        response.ValidToYear = '2017';
        response.ValidToMonth = '12';

        SBO_EnosixSO_Detail.EnosixSO order = new SBO_EnosixSO_Detail.EnosixSO();

        Test.startTest();
        UTIL_AppSettings.resourceJson = '{"Order.IsCardLimitEnabled":true}';
        UTIL_PaymentCards.addCardToOrder(response, order, 1);
        Test.stopTest();

        System.assert(1 == order.CCARD.size());
    }

    @isTest
    static void test_removeCardFromOrder()
    {

        SBO_EnosixSO_Detail.CCARD card = new SBO_EnosixSO_Detail.CCARD();
        card.CreditCardNumber = '123456789012';

        SBO_EnosixSO_Detail.EnosixSO order = new SBO_EnosixSO_Detail.EnosixSO();
        order.CCARD.add(card);

        Test.startTest();
        boolean result = UTIL_PaymentCards.removeCardFromOrder(order, '123456789012');
        boolean result2 = UTIL_PaymentCards.removeCardFromOrder(order, 'bad number');
        Test.stopTest();

        System.assert(true == result);
        System.assert(0 == order.CCARD.size());
    }

    @isTest
    static void test_addCustomerCardToOrder()
    {
        SBO_EnosixCustomer_Detail.PAYMENT_DATA payment = new SBO_EnosixCustomer_Detail.PAYMENT_DATA();
        payment.CardNumber = '1234567890123456';
        payment.PaymentCardID = 'Id';
        payment.CreditCardName = 'X';
        payment.PaymentCardTypeDesc = 'Desc';

        SBO_EnosixSO_Detail.EnosixSO order = new SBO_EnosixSO_Detail.EnosixSO();

        Test.startTest();
        UTIL_AppSettings.resourceJson = '{"Order.IsCardLimitEnabled":true}';
        UTIL_PaymentCards.addCustomerCardToOrder(payment, order, 1);
        Test.stopTest();
    }

    @isTest
    static void test_addCardToQuote()
    {
        SBO_EnosixXiIntercept_Detail.RESPONSE response = new SBO_EnosixXiIntercept_Detail.RESPONSE();
        response.CreditCardNumber = '123456789012';
        response.ValidToYear = '2017';
        response.ValidToMonth = '12';

        SBO_EnosixQuote_Detail.EnosixQuote quote = new SBO_EnosixQuote_Detail.EnosixQuote();

        Test.startTest();
        UTIL_AppSettings.resourceJson = '{"Order.IsCardLimitEnabled":true}';
        UTIL_PaymentCards.addCardToQuote(response, quote, 1);
        Test.stopTest();

        System.assert(1 == quote.CCARD.size());
    }

    @isTest
    static void test_removeCardFromQuote()
    {

        SBO_EnosixQuote_Detail.CCARD card = new SBO_EnosixQuote_Detail.CCARD();
        card.CreditCardNumber = '123456789012';

        SBO_EnosixQuote_Detail.EnosixQuote quote = new SBO_EnosixQuote_Detail.EnosixQuote();
        quote.CCARD.add(card);

        Test.startTest();
        boolean result = UTIL_PaymentCards.removeCardFromQuote(quote, '123456789012');
        boolean result2 = UTIL_PaymentCards.removeCardFromQuote(quote, 'bad number');
        Test.stopTest();

        System.assert(true == result);
        System.assert(0 == quote.CCARD.size());
    }

    @isTest
    static void test_addCustomerCardToQuote()
    {
        SBO_EnosixCustomer_Detail.PAYMENT_DATA payment = new SBO_EnosixCustomer_Detail.PAYMENT_DATA();
        payment.CardNumber = '1234567890123456';
        payment.PaymentCardID = 'Id';
        payment.CreditCardName = 'X';
        payment.PaymentCardTypeDesc = 'Desc';

        SBO_EnosixQuote_Detail.EnosixQuote quote = new SBO_EnosixQuote_Detail.EnosixQuote();

        Test.startTest();
        UTIL_AppSettings.resourceJson = '{"Order.IsCardLimitEnabled":true}';
        UTIL_PaymentCards.addCustomerCardToQuote(payment, quote, 1);
        Test.stopTest();
    }

    @isTest
    static void test_addCardToReturnOrder()
    {
        SBO_EnosixXiIntercept_Detail.RESPONSE response = new SBO_EnosixXiIntercept_Detail.RESPONSE();
        response.CreditCardNumber = '123456789012';
        response.ValidToYear = '2017';
        response.ValidToMonth = '12';

        SBO_EnosixRO_Detail.EnosixRO order = new SBO_EnosixRO_Detail.EnosixRO();

        Test.startTest();
        UTIL_AppSettings.resourceJson = '{"Order.IsCardLimitEnabled":true}';
        UTIL_PaymentCards.addCardToReturnOrder(response, order, 1);
        Test.stopTest();

        System.assert(1 == order.CCARD.size());
    }

    @isTest
    static void test_removeCardFromReturnOrder()
    {
        SBO_EnosixRO_Detail.CCARD card = new SBO_EnosixRO_Detail.CCARD();
        card.CreditCardNumber = '123456789012';

        SBO_EnosixRO_Detail.EnosixRO order = new SBO_EnosixRO_Detail.EnosixRO();
        order.CCARD.add(card);

        Test.startTest();
        boolean result = UTIL_PaymentCards.removeCardFromReturnOrder(order, '123456789012');
        boolean result2 = UTIL_PaymentCards.removeCardFromReturnOrder(order, 'bad number');
        Test.stopTest();

        System.assert(true == result);
        System.assert(0 == order.CCARD.size());
    }

    @isTest
    static void test_addCustomerCardToReturnOrder()
    {
        SBO_EnosixCustomer_Detail.PAYMENT_DATA payment = new SBO_EnosixCustomer_Detail.PAYMENT_DATA();
        payment.CardNumber = '1234567890123456';
        payment.PaymentCardID = 'Id';
        payment.CreditCardName = 'X';
        payment.PaymentCardTypeDesc = 'Desc';

        SBO_EnosixRO_Detail.EnosixRO order = new SBO_EnosixRO_Detail.EnosixRO();

        Test.startTest();
        UTIL_AppSettings.resourceJson = '{"Order.IsCardLimitEnabled":true}';
        UTIL_PaymentCards.addCustomerCardToReturnOrder(payment, order, 1);
        Test.stopTest();
    }

    @isTest
    static void test_addCardToCustomer()
    {
        SBO_EnosixXiIntercept_Detail.RESPONSE response = new SBO_EnosixXiIntercept_Detail.RESPONSE();
        response.CreditCardNumber = '123456789012';
        response.ValidToYear = '2017';
        response.ValidToMonth = '12';

        Test.startTest();
        UTIL_AppSettings.resourceJson = '{"Order.IsCardLimitEnabled":true}';
        UTIL_PaymentCards.addCardToCustomer(response, new SBO_EnosixCustomer_Detail.EnosixCustomer());
        Test.stopTest();
    }

    @isTest
    static void test_removeCardFromCustomer()
    {
        SBO_EnosixCustomer_Detail.EnosixCustomer customer = new SBO_EnosixCustomer_Detail.EnosixCustomer();
        SBO_EnosixCustomer_Detail.PAYMENT_DATA payment = new SBO_EnosixCustomer_Detail.PAYMENT_DATA();
        payment.CardNumber = '1234567890123456';
        payment.PaymentCardID = 'Id';
        payment.CreditCardName = 'X';
        payment.PaymentCardTypeDesc = 'Desc';
        customer.PAYMENT_DATA.add(payment);

        Test.startTest();
        UTIL_PaymentCards.removeCardFromCustomer(customer, '1234567890123456');
        UTIL_PaymentCards.removeCardFromCustomer(customer, 'bad number');
        Test.stopTest();
    }

    @isTest
    static void test_getPaymentCardSelectOptionsForCustomer()
    {
        SBO_EnosixCustomer_Detail.EnosixCustomer customer = new SBO_EnosixCustomer_Detail.EnosixCustomer();
        SBO_EnosixCustomer_Detail.PAYMENT_DATA payment = new SBO_EnosixCustomer_Detail.PAYMENT_DATA();
        payment.CardNumber = '1234567890123456';
        payment.PaymentCardID = 'Id';
        payment.CreditCardName = 'X';
        payment.PaymentCardTypeDesc = 'Desc';
        customer.PAYMENT_DATA.add(payment);

        Test.startTest();
        UTIL_PaymentCards.getPaymentCardSelectOptionsForCustomer(customer);
        Test.stopTest();
    }

    @isTest
    static void test_getPaymetricTargetUrl()
    {
        SBO_EnosixXiIntercept_Detail.EnosixXiIntercept intercept = new SBO_EnosixXiIntercept_Detail.EnosixXiIntercept();
        intercept.XiInterceptURL = '0';
        intercept.MerchantGUID = '1';
        intercept.AccessToken = '2';

        Test.startTest();
        string result = UTIL_PaymentCards.getPaymetricTargetUrl(intercept);
        string result2 = UTIL_PaymentCards.getPaymetricTargetUrl(null);
        Test.stopTest();

        System.assertEquals('0/view/iframe/1/2/True', result);
    }

    class MOC_getCardInfo implements ensxsdk.EnosixFramework.DetailSBOCommandMock
    {
        public ensxsdk.EnosixFramework.DetailObject executeCommand(string command, ensxsdk.EnosixFramework.DetailObject obj)
        {
            System.assertEquals('CMD_ENCRYPT_CCARD', command);

            SBO_EnosixXiIntercept_Detail.EnosixXiIntercept result = new SBO_EnosixXiIntercept_Detail.EnosixXiIntercept();
            result.setSuccess(false);
            return result;
        }
    }

    @isTest
    static void test_getCardInfo()
    {
        SBO_EnosixXiIntercept_Detail.EnosixXiIntercept intercept = new SBO_EnosixXiIntercept_Detail.EnosixXiIntercept();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixXiIntercept_Detail.class, new MOC_getCardInfo());

        Test.startTest();
        SBO_EnosixXiIntercept_Detail.EnosixXiIntercept result = UTIL_PaymentCards.getCardInfo(intercept);
        Test.stopTest();

        System.assertNotEquals(null, result);
    }

    class MOC_getAccessToken implements ensxsdk.EnosixFramework.DetailSBOCommandMock 
    {
        public ensxsdk.EnosixFramework.DetailObject executeCommand(string command, ensxsdk.EnosixFramework.DetailObject obj)
        {
            System.assertEquals('CMD_ACCESS_TOKEN', command);

            SBO_EnosixXiIntercept_Detail.EnosixXiIntercept result = new SBO_EnosixXiIntercept_Detail.EnosixXiIntercept();
            result.setSuccess(false);
            return result;
        }
    }

    @isTest
    static void test_getAccessToken()
    {
        SBO_EnosixXiIntercept_Detail.EnosixXiIntercept intercept = new SBO_EnosixXiIntercept_Detail.EnosixXiIntercept();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixXiIntercept_Detail.class, new MOC_getAccessToken());

        Test.startTest();
        SBO_EnosixXiIntercept_Detail.EnosixXiIntercept result = UTIL_PaymentCards.getAccessToken(intercept);
        Test.stopTest();

        System.assertNotEquals(null, result);
    }

    class MOC_initEnosixXiIntercept implements ensxsdk.EnosixFramework.DetailSBOInitMock
    {
        public ensxsdk.EnosixFramework.DetailObject executeInitialize(ensxsdk.EnosixFramework.DetailObject obj)
        {
            SBO_EnosixXiIntercept_Detail.EnosixXiIntercept result = new SBO_EnosixXiIntercept_Detail.EnosixXiIntercept();
            result.setSuccess(false);
            return result;
        }
    }

    @isTest
    static void test_initEnosixXiIntercept()
    {
        SBO_EnosixXiIntercept_Detail.EnosixXiIntercept intercept = new SBO_EnosixXiIntercept_Detail.EnosixXiIntercept();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixXiIntercept_Detail.class, new MOC_initEnosixXiIntercept());

        Test.startTest();
        SBO_EnosixXiIntercept_Detail.EnosixXiIntercept result = UTIL_PaymentCards.initEnosixXiIntercept();
        Test.stopTest();

        System.assertNotEquals(null, result);
    }
}