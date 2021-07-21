@isTest
public with sharing class TSTU_PageFlow
{
    @isTest 
    static void test_redirectTo()
    {
        Test.startTest();
        UTIL_AppSettings.resourceJson = '{"Routes.ClientRoutes":{"' + UTIL_PageFlow.VFP_OrderCreateUpdate + '":"ZERT"}}';
        PageReference page1 = UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_OrderCreateUpdate, null);

        UTIL_PageState state = new UTIL_PageState();
        state.sfAccountId = 'a1';
        state.sapCustomerId = 'c1';

        PageReference page2 = UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_OrderCreateUpdate, state);

        PageReference page3 = UTIL_PageFlow.redirectTo(null, state);
        string badUrl = UTIL_PageFlow.getPageURL('Bad URL');
        Test.stopTest();

        System.assert(page1.getParameters().size() == 0);
        System.assert(page1.getUrl() == UTIL_PageFlow.getPageURL(UTIL_PageFlow.VFP_OrderCreateUpdate));
        System.assert(page1.getUrl() == UTIL_PageFlow.getPageURL(UTIL_PageFlow.VFP_OrderCreateUpdate));

        System.assert(page2.getUrl().contains(UTIL_PageFlow.getPageURL(UTIL_PageFlow.VFP_OrderCreateUpdate) + '?'));


        System.assert(page3 == null);
    }

    @isTest 
    static void test_returnToSavedPageOrDefault()
    {
        Test.startTest();
        // null args return null
        PageReference page1 = UTIL_PageFlow.returnToSavedPageOrDefault(null, null);

        // no return url in state, still null
        UTIL_PageState state = new UTIL_PageState();
        PageReference page2 = UTIL_PageFlow.returnToSavedPageOrDefault(state, null);

        // use default when no return url in state
        PageReference page3 = UTIL_PageFlow.returnToSavedPageOrDefault(state, UTIL_PageFlow.VFP_OrderCreateUpdate);

        // use return url when it's set
        state.sfAccountId = 'a1';
        state.saveCustomReturnState(UTIL_PageFlow.VFP_CustomerLink, state);
        PageReference page4 = UTIL_PageFlow.returnToSavedPageOrDefault(state, UTIL_PageFlow.VFP_OrderCreateUpdate);
        Test.stopTest();

        System.assert(page1 == null);
        System.assert(page2 == null);
        System.assert(page3.getUrl() == UTIL_PageFlow.getPageURL(UTIL_PageFlow.VFP_OrderCreateUpdate));
    }

    @isTest 
    static void test_lightningNamespacePrefix()
    {
        UTIL_PageState state = new UTIL_PageState();
        state.sapDocNum = 'c1';
        state.values.put('test', 'test');

        Test.startTest();

        PageReference page = UTIL_PageFlow.redirectTo( '/lightning/n/c__SAP_Quote_Detail', state );

        Test.stopTest();

        System.assert(page.getParameters().size() != 0);
        System.assertEquals('c1',page.getParameters().get('c__SAP_DocNum'));
    }
}
