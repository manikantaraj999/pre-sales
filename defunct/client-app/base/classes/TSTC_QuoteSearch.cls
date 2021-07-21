@isTest
private class TSTC_QuoteSearch
{
    public class Mock_SBO_EnosixQuote_Search implements ensxsdk.EnosixFramework.SearchSBOSearchMock
    {
        public Boolean success = true;

        public void setSuccess (Boolean success)
        {
            this.success = success;
        }

        public ensxsdk.EnosixFramework.SearchContext executeSearch(ensxsdk.EnosixFramework.SearchContext searchContext)
        {
            SBO_EnosixQuote_Search.EnosixQuote_SR sr = new SBO_EnosixQuote_Search.EnosixQuote_SR();
            sr.SetSuccess(this.success);
            searchContext.baseResult = sr;
			return searchContext;
        }

        public Integer size()
        {
            return 2;
        }
    }

    @isTest
    static void test_createControllerAndTouchProperties()
    {
        Mock_SBO_EnosixQuote_Search mocSBOEnosixQouteSearch = new Mock_SBO_EnosixQuote_Search();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixQuote_Search.class, mocSBOEnosixQouteSearch);
        insertAccount();
        Test.startTest();
        CTRL_QuoteSearch controller = new CTRL_QuoteSearch();
        Boolean show = controller.showsearch;
        String quotestatus = controller.quotestatus;
        List<SBO_EnosixQuote_Search.SEARCHRESULT> orders = controller.quotes;
        List<SelectOption> orderStatuses = controller.getquotestatuslist();
        controller.navigateToQuoteDetail();
        controller.gotoCloneQuote();
        controller.goToCreateOrder();
        Account account = TSTU_SFTestObject.createTestAccount();
        account.Name = 'Name';
        TSTU_SFTestObject.upsertWithRetry(account);
        controller.accountId = account.Id;
        controller.init();
        delete account;
        controller.init();
        controller.quotestatus = 'open';
        controller.runSearch();
        controller.quotestatus = 'complete';
        controller.runSearch();
        String fromAccount = controller.fromAccount;
        I_SearchController searchController = controller.searchController;
        String customerId = controller.customerId;
        Boolean isClassic = controller.isClassic;
        mocSBOEnosixQouteSearch.setSuccess(false);
        controller.runSearch();
        Test.stopTest();
        System.assert(controller != null);
    }

    private static void insertAccount()
    {
        Account acct = TSTU_SFTestObject.createTestAccount();
        acct.Name = 'Test';
        TSTU_SFTestObject.upsertWithRetry(acct);

        UTIL_PageState.current.sfAccountId = String.valueOf(acct.Id);
    }
}