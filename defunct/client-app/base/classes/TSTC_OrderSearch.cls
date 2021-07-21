@isTest
private class TSTC_OrderSearch
{
    public class Mock_SBO_EnosixSO_Search implements ensxsdk.EnosixFramework.SearchSBOSearchMock
    {
        private boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }
        public ensxsdk.EnosixFramework.SearchContext executeSearch(ensxsdk.EnosixFramework.SearchContext searchContext)
        {
            SBO_EnosixSO_Search.EnosixSO_SR sr = new SBO_EnosixSO_Search.EnosixSO_SR();
            SBO_EnosixSO_Search.SEARCHRESULT result1 = new SBO_EnosixSO_Search.SEARCHRESULT();
            result1.SalesDocument = 'SalesDocument1';
            result1.CustomerPONumber  = '4500000071';
            sr.SearchResults.add(result1);
            SBO_EnosixSO_Search.SEARCHRESULT result2 = new SBO_EnosixSO_Search.SEARCHRESULT();
            result2.SalesDocument = 'SalesDocument2';
            result2.CustomerPONumber  = '4500000071';
            sr.SearchResults.add(result2);
            SBO_EnosixSO_Search.SEARCHRESULT result3 = new SBO_EnosixSO_Search.SEARCHRESULT();
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

    public class Mock_SBO_EnosixOrderType_Search implements ensxsdk.EnosixFramework.SearchSBOSearchMock
    {
        private boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }
        public ensxsdk.EnosixFramework.SearchContext executeSearch(ensxsdk.EnosixFramework.SearchContext searchContext)
        {
            SBO_EnosixOrderType_Search.EnosixOrderType_SR sr = new SBO_EnosixOrderType_Search.EnosixOrderType_SR();
            SBO_EnosixOrderType_Search.SEARCHRESULT result1 = new SBO_EnosixOrderType_Search.SEARCHRESULT();
            result1.SalesDocumentType = 'SalesDocument1';
            result1.SalesDocumentTypeDescription = 'SalesDescription';
            sr.SetSuccess(success);

            searchContext.baseResult = sr;
			return searchContext;
        }

        public integer size()
        {
            return 1;
        }
    }

    public class MOC_RFC_SD_GET_ORDER_TYPES implements ensxsdk.EnosixFramework.RFCMock
    {
        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            RFC_SD_GET_ORDER_TYPES.RESULT result = new RFC_SD_GET_ORDER_TYPES.RESULT();
            RFC_SD_GET_ORDER_TYPES.ET_VALUES orderType = new RFC_SD_GET_ORDER_TYPES.ET_VALUES();

            orderType.VALUE = 'VALUE';
            orderType.DESCRIPTION = 'DESCRIPTION';

            result.getCollection(RFC_SD_GET_ORDER_TYPES.ET_VALUES.class).add(orderType);

            result.setSuccess(true);
            return result;
        }
    }

    public class MOC_RFC_SD_GET_SALES_AREAS implements ensxsdk.EnosixFramework.RFCMock
    {
        public boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            RFC_SD_GET_SALES_AREAS.RESULT result = new RFC_SD_GET_SALES_AREAS.RESULT();
            result.setSuccess(this.success);
            return result;
        }
    }

    public class MOC_RFC_SD_GET_DOC_TYPE_VALUES implements ensxsdk.EnosixFramework.RFCMock
    {
        public boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            RFC_SD_GET_DOC_TYPE_VALUES.RESULT result = new RFC_SD_GET_DOC_TYPE_VALUES.RESULT();
            result.setSuccess(this.success);
            return result;
        }
    }

    @isTest
    static void test_createControllerAndTouchProperties()
    {
        Mock_SBO_EnosixSO_Search mockSboEnosixSoSearch = new Mock_SBO_EnosixSO_Search();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixSO_Search.class, mockSboEnosixSoSearch);
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_SALES_AREAS.class, new MOC_RFC_SD_GET_SALES_AREAS());
        ensxsdk.EnosixFramework.setMock(SBO_EnosixOrderType_Search.class, new Mock_SBO_EnosixOrderType_Search());
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_ORDER_TYPES.class, new MOC_RFC_SD_GET_ORDER_TYPES());
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_DOC_TYPE_VALUES.class, new MOC_RFC_SD_GET_DOC_TYPE_VALUES());
        Test.startTest();
        Account account = TSTU_SFTestObject.createTestAccount();
        account.name = 'test account';
        TSTU_SFTestObject.upsertWithRetry(account);
        System.currentPageReference().getParameters().put('action', 'first');
        UTIL_PageState.current.sfAccountId = account.Id;
        CTRL_OrderSearch controller = new CTRL_OrderSearch();
        mockSboEnosixSoSearch.setSuccess(false);
        controller.orderstatus = 'open';
        controller.runSearch();
        controller.orderstatus = 'complete';
        controller.runSearch();
        mockSboEnosixSoSearch.setSuccess(true);
        String fromaccount = controller.fromaccount;
        Boolean hasrecords = controller.hasrecords;
        String orderstatus = controller.orderstatus;
        List<SBO_EnosixSO_Search.SEARCHRESULT> orders = controller.orders;
        List<SelectOption> orderTypes = controller.OrderTypes;
        controller.navigateToOrderDetail();
        controller.gotoCloneOrder();
        delete account;
        controller.init();
        List<SelectOption> orderStatusList = controller.getOrderstatuslist;
        I_SearchController searchController = controller.searchController;
        string accountId = controller.accountId;
        Boolean isClassic = controller.isClassic;

        Test.stopTest();
        System.assert(controller != null);
    }
}