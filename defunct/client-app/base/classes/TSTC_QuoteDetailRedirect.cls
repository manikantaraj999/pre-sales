@isTest
private class TSTC_QuoteDetailRedirect
{
    @isTest
    static void test_ConstructorAndRedirect()
    {
        Test.startTest();
        Opportunity opp = TSTU_SFTestObject.createTestOpportunity();
        opp.Name = 'TEST OPP';
        opp.StageName = 'Closed';
        opp.CloseDate = Date.today();
        opp.put(UTIL_SFOpportunity.QuoteFieldName, '12345');
        TSTU_SFTestObject.upsertWithRetry(opp);
        Test.setCurrentPageReference(new PageReference('Page.VFP_QuoteCreateUpdate'));
        Test.stopTest();
    }
}