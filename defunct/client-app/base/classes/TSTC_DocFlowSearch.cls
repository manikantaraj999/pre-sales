@isTest
public with sharing class TSTC_DocFlowSearch
{
    class MockSearch implements ensxsdk.EnosixFramework.SearchSBOSearchMock
    {
        Boolean isSuccess;
        public MockSearch(Boolean isSuccess)
        {
            this.isSuccess = isSuccess;
        }

        public ensxsdk.EnosixFramework.SearchContext executeSearch(ensxsdk.EnosixFramework.SearchContext searchContext)
        {
            SBO_EnosixSalesDocFlow_Search.EnosixSalesDocFlow_SR searchResult =
                new SBO_EnosixSalesDocFlow_Search.EnosixSalesDocFlow_SR();

            if (isSuccess)
            {
                SBO_EnosixSalesDocFlow_Search.SEARCHRESULT result = new SBO_EnosixSalesDocFlow_Search.SEARCHRESULT();
                result.SalesDocument = 'MOCK';
                searchResult.SearchResults.add(result);
            }

            searchResult.setSuccess(isSuccess);
            searchContext.baseResult = searchResult;
			return searchContext;
        }
    }

    @isTest
    static void test_CreateController()
    {
        MOC_SD_GET_DOC_CATEG_VALUES.MockSuccess mockRfc = new MOC_SD_GET_DOC_CATEG_VALUES.MockSuccess();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixSalesDocFlow_Search.class, new MockSearch(true));
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_DOC_CATEG_VALUES.class, mockRfc);

        Test.setCurrentPageReference(new PageReference('Page.VFP_DocFlowSearch'));

        Test.startTest();

        // no query
        CTRL_DocFlowSearch controller1 = new CTRL_DocFlowSearch();

        // reset page state
        UTIL_PageState.current = null;

        // with query
        UTIL_PageState.current.sapDocNum = '1';
        CTRL_DocFlowSearch controller2 = new CTRL_DocFlowSearch();

        Test.stopTest();

        System.assert(controller1 != null);
        System.assert(controller1.salesDocNum == null);

        System.assert(controller2 != null);
        System.assert(controller2.salesDocNum == '1');

        String validLinkCategories = controller2.validLinkCategories;
    }

    @isTest
    static void test_SearchParamProperties()
    {
        MOC_SD_GET_DOC_CATEG_VALUES.MockSuccess mockRfc = new MOC_SD_GET_DOC_CATEG_VALUES.MockSuccess();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_DOC_CATEG_VALUES.class, mockRfc);
        Test.startTest();
        CTRL_DocFlowSearch controller = new CTRL_DocFlowSearch();
        controller.salesDocNum = '1';
        controller.customerPoNum = '1';
        controller.docCategory = 'C';
        Boolean isClassic = controller.isClassic;
        Test.stopTest();
    }

    @isTest
    static void test_DocCategoryOptions()
    {
        MOC_SD_GET_DOC_CATEG_VALUES.MockSuccess mockRfc = new MOC_SD_GET_DOC_CATEG_VALUES.MockSuccess();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_DOC_CATEG_VALUES.class, mockRfc);

        Test.startTest();

        CTRL_DocFlowSearch controller = new CTRL_DocFlowSearch();
        List<SelectOption> options = controller.docCategoryOptions;
        CTRL_DocFlowSearch controller2 = new CTRL_DocFlowSearch();
        MOC_SD_GET_DOC_CATEG_VALUES.MockRFC_SD_GET_DOC_CATEG_VALUESFailure mockRfcFailure = new MOC_SD_GET_DOC_CATEG_VALUES.MockRFC_SD_GET_DOC_CATEG_VALUESFailure();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_DOC_CATEG_VALUES.class, mockRfcFailure);
        options = controller2.docCategoryOptions;

        Test.stopTest();
    }

    @isTest
    static void test_SearchSuccess()
    {
        MockSearch mockSearch = new MockSearch(true);
        MOC_SD_GET_DOC_CATEG_VALUES.MockSuccess mockRfc = new MOC_SD_GET_DOC_CATEG_VALUES.MockSuccess();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixSalesDocFlow_Search.class, mockSearch);
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_DOC_CATEG_VALUES.class, mockRfc);

        Test.startTest();

        CTRL_DocFlowSearch controller = new CTRL_DocFlowSearch();
        controller.customerPoNum = '1';
        controller.search();
        Test.stopTest();

        System.assert(1 == controller.searchResults.size());
        System.assert('MOCK' == controller.searchResults[0].SalesDocument);
    }

    @isTest
    static void test_SearchFailure()
    {
        MockSearch mockSearch = new MockSearch(false);
        MOC_SD_GET_DOC_CATEG_VALUES.MockSuccess mockRfc = new MOC_SD_GET_DOC_CATEG_VALUES.MockSuccess();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixSalesDocFlow_Search.class, mockSearch);
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_DOC_CATEG_VALUES.class, mockRfc);

        Test.startTest();

        CTRL_DocFlowSearch controller = new CTRL_DocFlowSearch();
        controller.search();
        Test.stopTest();

        System.assert(0 == controller.searchResults.size());
    }

    @isTest
    static void test_gotoDetailPage()
    {
        MOC_SD_GET_DOC_CATEG_VALUES.MockSuccess mockRfc = new MOC_SD_GET_DOC_CATEG_VALUES.MockSuccess();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_DOC_CATEG_VALUES.class, mockRfc);
        Test.setCurrentPageReference(new PageReference('Pag.VFP_DocFlowSearch'));

        Test.startTest();

        CTRL_DocFlowSearch controller = new CTRL_DocFlowSearch();

        System.currentPageReference().getParameters().put('selectedDocCategory', 'C');
        System.currentPageReference().getParameters().put('selectedDocNum', '1');
        PageReference result1 = controller.gotoDetailPage();

        // reset page state
        UTIL_PageState.current = null;

        System.currentPageReference().getParameters().put('selectedDocCategory', 'H');
        System.currentPageReference().getParameters().put('selectedDocNum', '2');
        PageReference result2 = controller.gotoDetailPage();

        UTIL_PageState.current = null;

        System.currentPageReference().getParameters().put('selectedDocCategory', 'M');
        System.currentPageReference().getParameters().put('selectedDocNum', '3');
        PageReference result3 = controller.gotoDetailPage();

        UTIL_PageState.current = null;

        System.currentPageReference().getParameters().put('selectedDocCategory', 'J');
        System.currentPageReference().getParameters().put('selectedDocNum', '4');
        PageReference result4 = controller.gotoDetailPage();

        UTIL_PageState.current = null;

        System.currentPageReference().getParameters().put('selectedDocCategory', 'X');
        System.currentPageReference().getParameters().put('selectedDocNum', '5');
        PageReference result5 = controller.gotoDetailPage();

        UTIL_PageState.current = null;

        System.currentPageReference().getParameters().put('selectedDocCategory', 'B');
        System.currentPageReference().getParameters().put('selectedDocNum', '6');
        PageReference result6 = controller.gotoDetailPage();

        Test.stopTest();

        System.assert(result1.getUrl() == '/apex/VFP_OrderDetail?c__SAP_OrderNum=1');
        System.assert(result2.getUrl() == '/apex/VFP_ReturnOrderDetail?c__SAP_RMAId=2');
        System.assert(result3.getUrl() == '/apex/VFP_InvoiceDetail?c__SAP_InvoiceNum=3');
        System.assert(result4.getUrl() == '/apex/VFP_DeliveryDetail?c__SAP_DeliveryNum=4');
        System.assert(result5 == null);
    }
}