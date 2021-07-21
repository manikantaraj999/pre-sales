@isTest
private class TSTC_OpportunityQuotePricingRedirect
{
    static testMethod void test_ConstructorAndRedirect()
    {
        Test.startTest();
        Opportunity opp = createOpportunity();
        Test.setCurrentPageReference(new PageReference('Page.VFP_Return_Order_Create'));
        string idParam = 'addTo';
        System.currentPageReference().getParameters().put(idParam, opp.Id);
        ApexPages.StandardController std =new ApexPages.StandardController(opp);
        CTRL_OpportunityQuotePricingRedirect controller = new CTRL_OpportunityQuotePricingRedirect(std);
        System.assert(controller != null);
        controller.RedirectToCustomOpportunityPage();
        Test.stopTest();
    }

    static testMethod void test_ConstructorAndRedirect2()
    {
        Test.startTest();
        Opportunity opp = createOpportunity();
        Test.setCurrentPageReference(new PageReference('Page.VFP_Return_Order_Create'));
        string idParam = 'retURL';
        System.currentPageReference().getParameters().put(idParam, opp.Id);
        ApexPages.StandardController std =new ApexPages.StandardController(opp);
        CTRL_OpportunityQuotePricingRedirect controller = new CTRL_OpportunityQuotePricingRedirect(std);
        System.assert(controller != null);
        controller.RedirectToCustomOpportunityPage();
        Test.stopTest();
    }

    private static Opportunity createOpportunity()
    {
        Opportunity opp = TSTU_SFTestObject.createTestOpportunity();
        opp.Name = 'TEST OPP';
        opp.StageName = 'Closed';
        opp.CloseDate = Date.today();
        TSTU_SFTestObject.upsertWithRetry(opp);
        return opp;
    }
}
