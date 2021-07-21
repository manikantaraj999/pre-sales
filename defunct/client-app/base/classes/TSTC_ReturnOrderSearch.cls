@isTest
private class TSTC_ReturnOrderSearch
{
    public class Mock_SBO_EnosixRO_Search implements ensxsdk.EnosixFramework.SearchSBOSearchMock
    {
        private boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }
        
        public ensxsdk.EnosixFramework.SearchContext executeSearch(ensxsdk.EnosixFramework.SearchContext searchContext)
        {
            SBO_EnosixRO_Search.EnosixRO_SR sr = new SBO_EnosixRO_Search.EnosixRO_SR();
            SBO_EnosixRO_Search.SEARCHRESULT result1 = new SBO_EnosixRO_Search.SEARCHRESULT();
            result1.SalesDocument = 'SalesDocument1';
            result1.CustomerPONumber  = '4500000071';
            sr.SearchResults.add(result1);
            SBO_EnosixRO_Search.SEARCHRESULT result2 = new SBO_EnosixRO_Search.SEARCHRESULT();
            result2.SalesDocument = 'SalesDocument2';
            result2.CustomerPONumber  = '4500000071';
            sr.SearchResults.add(result2);
            SBO_EnosixRO_Search.SEARCHRESULT result3 = new SBO_EnosixRO_Search.SEARCHRESULT();
            result3.SalesDocument = 'SalesDocument3';
            result3.CustomerPONumber  = '4500000071';
            sr.SearchResults.add(result3);
            sr.SetSuccess(success);

            searchContext.baseResult = sr;
			return searchContext;
        }

        public integer size()
        {
            return 1;
        }
    }

    public class MOC_EnosixCustomer_Detail implements ensxsdk.EnosixFramework.DetailSBOGetMock
    {
        public ensxsdk.EnosixFramework.DetailObject executeGetDetail(object key)
        {
            SBO_EnosixCustomer_Detail.EnosixCustomer result = new SBO_EnosixCustomer_Detail.EnosixCustomer();
            result.CustomerNumber = 'CustomerNumber';
            result.setSuccess(true);
            return result;
        }
    }

    @isTest
    static void test_createControllerAndTouchProperties()
    {
        Mock_SBO_EnosixRO_Search mockSboEnosixRoSearch = new Mock_SBO_EnosixRO_Search();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixRO_Search.class, mockSboEnosixRoSearch);
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustomer_Detail.class, new MOC_EnosixCustomer_Detail());
        Test.startTest();
        Account testAccount = TSTU_SFTestObject.createTestAccount();
        testAccount.Name = 'Name';
        testAccount.put(UTIL_SFAccount.CustomerFieldName,'CustomerFieldName');
        TSTU_SFTestObject.upsertWithRetry(testAccount);
        Case testCase = TSTU_SFTestObject.createTestCase();
        testCase.AccountId = testAccount.Id;
        TSTU_SFTestObject.upsertWithRetry(testCase);
        UTIL_PageState.current.sfCaseId = testCase.Id;
        CTRL_ReturnOrderSearch controller = new CTRL_ReturnOrderSearch();
        List<SBO_EnosixRO_Search.SEARCHRESULT> searchResults  = controller.searchResults;
        string soldToParty = controller.soldToParty;
        I_SearchController searchController = controller.searchController;
        Boolean hasRecords = controller.hasRecords;
        controller.init();
        controller.searchForReturnOrders();
        controller.soldToParty = 'soldToParty';
        controller.runSearch();
        mockSboEnosixRoSearch.setSuccess(false);
        controller.runSearch();
        Boolean isClassic = controller.isClassic;
        Test.stopTest();
        System.assert(controller != null);
    }

    @isTest
    static void test_navigateToRMADetail()
    {
        Test.setCurrentPageReference(new PageReference('Page.VFP_ReturnOrderDetail'));
        UTIL_PageState.current.sapRmaId = 'TESTID';
        Test.startTest();
        CTRL_ReturnOrderSearch controller = new CTRL_ReturnOrderSearch();
        controller.navigateToRMADetail();
        Test.stopTest();
        System.assert(controller != null);
    }
}