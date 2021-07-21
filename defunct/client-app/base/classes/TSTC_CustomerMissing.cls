@isTest
public with sharing class TSTC_CustomerMissing
{
    @isTest 
    static void test_actionCreateCustomer()
    {
        UTIL_PageState.current.sfAccountId = 'ACCOUNT';
        CTRL_CustomerMissing controller = new CTRL_CustomerMissing();

        Test.startTest();
        PageReference result = controller.actionCreateCustomer();
        Test.stopTest();

        System.assert(result.getUrl().contains(UTIL_PageFlow.getPageURL(UTIL_PageFlow.VFP_CustomerCreateUpdate)));
    }

    @isTest 
    static void test_actionLinkCustomer()
    {
        UTIL_PageState.current.sfAccountId = 'ACCOUNT';
        CTRL_CustomerMissing controller = new CTRL_CustomerMissing();

        Test.startTest();
        PageReference result = controller.actionLinkCustomer();
        Test.stopTest();

        System.debug('result='+result);
        System.assert(result.getUrl().contains(UTIL_PageFlow.getPageURL(UTIL_PageFlow.VFP_CustomerLink)));
    }
}
