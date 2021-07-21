@isTest
public with sharing class TSTC_CreditCardEntryTest
{

    @isTest
    static void test_constructorAndProperties()
    {
        Test.startTest();
        CTRL_CreditCardEntryTest controller = new CTRL_CreditCardEntryTest();
        controller.onReceiveCardDetails(new SBO_EnosixXiIntercept_Detail.EnosixXiIntercept());
        controller.onInitCardDetails(new SBO_EnosixXiIntercept_Detail.EnosixXiIntercept());
        Test.stopTest();
    }
}
