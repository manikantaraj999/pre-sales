@isTest
private class TSTC_Pager
{
    public class Mock_SBO_EnosixQuote_Search implements ensxsdk.EnosixFramework.SearchSBOSearchMock
    {
        public Boolean success = true;
        public ensxsdk.EnosixFramework.SearchContext executeSearch(ensxsdk.EnosixFramework.SearchContext searchContext)
        {
            SBO_EnosixQuote_Search.EnosixQuote_SR sr = new SBO_EnosixQuote_Search.EnosixQuote_SR();
            sr.SetSuccess(true);
            searchContext.baseResult = sr;
			return searchContext;
        }

        public Integer size()
        {
            return 2;
        }
    }

    @isTest
    static void test_CTRL_Pager()
    {
        ensxsdk.EnosixFramework.setMock(SBO_EnosixQuote_Search.class, new Mock_SBO_EnosixQuote_Search());
        Test.startTest();
        System.currentPageReference().getParameters().put('pageNumber', '1');
        System.currentPageReference().getParameters().put('pageSize', '1');
        CTRL_Pager controller = new CTRL_Pager();
        controller.parentController = new CTRL_QuoteSearch();
        ensxsdk.EnosixFramework.SearchPaging pagingOptions = new ensxsdk.EnosixFramework.SearchPaging();
        controller.pagingOptionsWrapper = new UTIL_PagingOptionsWrapper(pagingOptions);
        ApexPages.Action actionOnPaging = controller.actionOnPaging;
        pagingOptions = controller.pagingOptions;
        List<SelectOption> pageSizeOptions = controller.pageSizeOptions;
        controller.actionGoToPage();
        controller.actionUpdatePageSize();
        Boolean disablePrev = controller.disablePrev;
        Boolean disableNext = controller.disableNext;
        pagingOptions = new ensxsdk.EnosixFramework.SearchPaging();
        controller.pagingOptionsWrapper = new UTIL_PagingOptionsWrapper(pagingOptions);
        Integer totalPages = controller.totalPages;
        Test.stopTest();
        System.assert(controller != null);
    }
}