@isTest
public with sharing class TSTC_OpportunityInfo
{
    @isTest 
    static void test_properties()
    {
        Account account = TSTU_SFTestObject.createTestAccount();
        account.Name = 'acct 1';
        TSTU_SFTestObject.upsertWithRetry(account);

        Opportunity opp = createOpportunity();

        CTRL_OpportunityInfo controller = new CTRL_OpportunityInfo();

        Test.startTest();
        controller.sfOpportunityId = opp.Id;
        String quoteNumber = controller.QuoteNumber;
        String orderNumber = controller.OrderNumber;

        System.assert(controller.sfOpportunityId == opp.Id);
        Test.stopTest();

        System.assert(controller.sfOpportunity.Name == opp.Name);
    }

    @isTest 
    static void test_redirectToQuoteDetail()
    {
        Opportunity opp = createOpportunity();

        CTRL_OpportunityInfo controller = new CTRL_OpportunityInfo();
        controller.sfOpportunityId = opp.Id;

        Test.startTest();
        PageReference result = controller.redirectToQuoteDetail();
        PageReference result2 = controller.redirectToOrderDetail();
        Test.stopTest();

        System.assert(result.getUrl().startsWith(UTIL_PageFlow.getPageURL(UTIL_PageFlow.VFP_QuoteDetail)));
        System.assert(result2.getUrl().startsWith(UTIL_PageFlow.getPageURL(UTIL_PageFlow.VFP_OrderDetail)));
    }

    private static Opportunity createOpportunity()
    {
        Opportunity opp = TSTU_SFTestObject.createTestOpportunity();
        opp.Name = 'opp 1';
        opp.StageName = 'New';
        opp.CloseDate = Date.today();
        opp.put(UTIL_SFOpportunity.QuoteFieldName, 'TEST-QUOTE');
        TSTU_SFTestObject.upsertWithRetry(opp);
        return opp;
    }
}