@isTest
public with sharing class TSTC_NavButtons
{
    @isTest 
    static void test_properties()
    {
        Account acct = TSTU_SFTestObject.createTestAccount();
        UTIL_SFAccount.setAccountCustomerNumber(acct, 'C1');
        TSTU_SFTestObject.upsertWithRetry(acct);

        Opportunity opp = TSTU_SFTestObject.createTestOpportunity();
        opp.AccountId = acct.Id;
        opp.StageName = 'Prospecting';
        opp.CloseDate = Date.today();

        TSTU_SFTestObject.upsertWithRetry(opp);

        Case sfCase = TSTU_SFTestObject.createTestCase();
        sfCase.AccountId = acct.Id;
        TSTU_SFTestObject.upsertWithRetry(sfCase);


        Test.startTest();
        // Get account from customer
        CTRL_NavButtons controller1 = new CTRL_NavButtons();
        UTIL_PageState.current.sapCustomerId = 'C1';
        System.assert(controller1.accountId == acct.Id);

        // Get account from opp
        CTRL_NavButtons controller2 = new CTRL_NavButtons();
        UTIL_PageState.current = null;
        UTIL_PageState.current.sfOpportunityId = opp.Id;
        System.assert(controller2.opportunityId == opp.Id);
        System.assert(controller2.accountId == opp.AccountId);

        // Get account from case
        CTRL_NavButtons controller3 = new CTRL_NavButtons();
        UTIL_PageState.current = null;
        UTIL_PageState.current.sfCaseId = sfCase.Id;
        System.assert(controller3.caseId == sfCase.Id);
        System.assert(controller3.accountId == sfCase.AccountId);

        // Get account from current state
        CTRL_NavButtons controller4 = new CTRL_NavButtons();
        UTIL_PageState.current = null;
        UTIL_PageState.current.sfAccountId = acct.Id;
        System.assert(controller4.accountId == acct.Id);

        // Same controller keeps it's value after state is cleared
        UTIL_PageState.current = null;
        System.assert(controller4.accountId == acct.Id);

        Test.stopTest();
    }

    @isTest 
    static void test_actionGotoDoc()
    {
        Test.setCurrentPageReference(new PageReference('Page.VFP_DocFlowSearch'));
        System.currentPageReference().getParameters().put('docNum', 'docnum');

        CTRL_NavButtons controller = new CTRL_NavButtons();
        Test.startTest();
        PageReference result = controller.actionGotoDoc();
        Test.stopTest();

        System.assert(result.getUrl() == '/docnum');
    }

    @isTest 
    static void test_actionGotoDocFlow()
    {
        Test.setCurrentPageReference(new PageReference('Page.VFP_OrderDetail'));
        CTRL_NavButtons controller = new CTRL_NavButtons();
        Test.startTest();
        controller.docflowDocNum = 'test';
        PageReference result = controller.actionGotoDocFlow();
        Test.stopTest();

        System.assert(result.getUrl() == '/apex/VFP_DocFlowSearch?c__SAP_DocNum=test');
    }
}
