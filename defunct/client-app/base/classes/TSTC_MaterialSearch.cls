@isTest
public with sharing class TSTC_MaterialSearch
{
    @isTest 
    static void test_properties()
    {
        // add coverage, not really testing anything
        MockProductHierarchyRfc mock = new MockProductHierarchyRfc();
        ensxsdk.EnosixFramework.setMock(RFC_MM_GET_PROD_HIERARCHY.class, mock);
        MockSearch mockSBO = new MockSearch();
        ensxsdk.EnosixFramework.setMock(SBO_SFCIMaterial_Search.class, mockSBO);

        CTRL_MaterialSearch controller = new CTRL_MaterialSearch();
        Test.startTest();
        controller.componentId = '1';
        controller.defaultMaterialNumber = '1';
        controller.material = '1';
        controller.defaultHierarchy = '1';
        controller.productHierarchy = '1';
        controller.defaultDescription = 'desc';
        controller.searchDescription = 'desc';
        controller.defaultTypes = new List<string> { '1', '2' };
        controller.allowedMaterialTypes = new List<string> { '1', '2' };
        controller.materialTypesSelected = new List<string> { '1', '2' };
        controller.salesOrg = 'SALES';
        controller.distChannel = 'DIST';
        controller.isMultiSelectEnabled = true;
        controller.isScheduleDateEnabled = true;
        controller.isAutoSearchEnabled = true;
        controller.isSearchOnClearEnabled = true;
        controller.isQuantityEnabled = true;
        controller.isCartonEnabled = true;
        I_SearchController searchController = controller.searchController;
        controller.actionSearch();
        Integer footerColSpan = controller.footerColSpan;
        Test.stopTest();
    }

    @isTest 
    static void test_loadDefaults()
    {
        // Verify auto search
        MockProductHierarchyRfc mock = new MockProductHierarchyRfc();
        MockSearch mockSBO = new MockSearch();
        ensxsdk.EnosixFramework.setMock(RFC_MM_GET_PROD_HIERARCHY.class, mock);
        ensxsdk.EnosixFramework.setMock(SBO_SFCIMaterial_Search.class, mockSBO);

        CTRL_MaterialSearch controller = new CTRL_MaterialSearch();

        MockReceiver receiver = new MockReceiver();
        controller.searchReceiver = receiver;

        Test.startTest();

        controller.defaultMaterialNumber = 'material';
        controller.defaultHierarchy = 'hierarchy';
        controller.defaultDescription = 'description';
        controller.defaultTypes = new List<string> { '1', '2' };
        controller.allowedMaterialTypes = new List<string> { '1', '2' };
        controller.isScheduleDateEnabled = false;
        controller.isAutoSearchEnabled = false;
        controller.isSearchOnClearEnabled = false;
        controller.isQuantityEnabled = true;
        controller.loadDefaults();
        System.assert(null == controller.searchResults);
        System.assert('material' == controller.material);
        System.assert('hierarchy' == controller.productHierarchy);
        System.assert('description' == controller.searchDescription);

        controller.isAutoSearchEnabled = true;
        controller.isSearchOnClearEnabled = true;
        controller.loadDefaults();
        System.assert(controller.searchResults.size() == 1);
        System.assert(controller.searchResults.get(0).material.Material == 'MOCK');

        controller.isOnLoadComplete = false;
        controller.isAutoSearchEnabled = true;
        controller.loadDefaults();

        Test.stopTest();
    }

    @isTest 
    static void test_loadIfReady()
    {
        MockProductHierarchyRfc mock = new MockProductHierarchyRfc();
        ensxsdk.EnosixFramework.setMock(RFC_MM_GET_PROD_HIERARCHY.class, mock);

        CTRL_MaterialSearch controller = new CTRL_MaterialSearch();

        MockReceiver receiver = new MockReceiver();

        Test.startTest();

        // loadDefaults() should be called only after all attr properties are set
        controller.componentId = '1';
        controller.searchReceiver = receiver;
        controller.isMultiSelectEnabled = true;
        controller.isScheduleDateEnabled = true;
        controller.isAutoSearchEnabled = false;
        controller.isSearchOnClearEnabled = false;
        controller.isQuantityEnabled = false;
        controller.salesOrg = 'org';
        controller.distChannel = 'dist';
        controller.defaultMaterialNumber = 'material';
        controller.defaultHierarchy = 'hierarchy';
        controller.defaultDescription = 'desc';
        controller.defaultTypes = new List<string> { '1', '2' };
        controller.allowedMaterialTypes = new List<string> { '1', '2' };
        controller.listHeight = '';
        controller.defaultHierarchy = controller.productHierarchy;
        boolean isOnLoadComplete = controller.isOnLoadComplete;
        System.assert(isOnLoadComplete != null);

        Test.stopTest();
    }

    @isTest 
    static void test_actionSearch()
    {
        MockProductHierarchyRfc mock = new MockProductHierarchyRfc();
        ensxsdk.EnosixFramework.setMock(RFC_MM_GET_PROD_HIERARCHY.class, mock);

        CTRL_MaterialSearch controller = new CTRL_MaterialSearch();
        controller.isScheduleDateEnabled = false;
        controller.isQuantityEnabled = false;

        MockReceiver receiver = new MockReceiver();
        controller.searchReceiver = receiver;

        MockSearch mockSBO = new MockSearch();
        ensxsdk.EnosixFramework.setMock(SBO_SFCIMaterial_Search.class, mockSBO);

        Test.startTest();
        // Search without hierarchy first
        controller.searchDescription = 'desc';
        controller.salesOrg = 'salesOrg';
        controller.distChannel = 'distChannel';
        controller.runSearch();

        System.assert(controller.searchResults.size() == 1);
        System.assert(controller.searchResults.get(0).material.Material == 'MOCK');

        // Search again with hierarchy just to add coverage
        controller.productHierarchy = '1';
        controller.runSearch();
        System.assert(controller.searchResults.size() == 1);
        System.assert(controller.searchResults.get(0).material.Material == 'MOCK');
        mockSBO.setReturnResults(false);
        controller.runSearch();
        mockSBO.setSuccess(false);
        controller.runSearch();
        Test.stopTest();
    }

    @isTest 
    static void test_actionSendResultsToReceiver()
    {
        MockProductHierarchyRfc mock = new MockProductHierarchyRfc();
        ensxsdk.EnosixFramework.setMock(RFC_MM_GET_PROD_HIERARCHY.class, mock);
        MockSearch mockSBO = new MockSearch();
        ensxsdk.EnosixFramework.setMock(SBO_SFCIMaterial_Search.class, mockSBO);

        PageReference pageReference = new PageReference('Page.VFP_MaterialSearchTest');
        pageReference.getParameters().put('selectedMaterial', 'MOCK');
        Test.setCurrentPageReference(pageReference);

        CTRL_MaterialSearch controller = new CTRL_MaterialSearch();
        controller.searchResults = new List<CTRL_MaterialSearch.MaterialSearchResult>();
        controller.isScheduleDateEnabled = true;
        controller.isMultiSelectEnabled = true;
        controller.isQuantityEnabled = true;
        controller.isAutoSearchEnabled = false;
        controller.isSearchOnClearEnabled = false;

        SBO_SFCIMaterial_Search.SEARCHRESULT material = new SBO_SFCIMaterial_Search.SEARCHRESULT();
        material.Material = 'MOCK';
        CTRL_MaterialSearch.MaterialSearchResult m1 = new CTRL_MaterialSearch.MaterialSearchResult();
        m1.materialId = 'MOCK';
        m1.material = material;
        m1.quantity = 1.0;
        m1.isSelected = false;
        controller.searchResults.add(m1);

        CTRL_MaterialSearch.MaterialSearchResult m2 = new CTRL_MaterialSearch.MaterialSearchResult();
        m2.material = material;
        m2.quantity = 2.0;
        m2.isSelected = true;
        controller.searchResults.add(m2);

        MockReceiver receiver = new MockReceiver();
        controller.searchReceiver = receiver;
        String tableWrapperStyle = controller.tableWrapperStyle;
        controller.listHeight = '10';
        tableWrapperStyle = controller.tableWrapperStyle;
        controller.allowedMaterialTypes = new List<string> { '1', '2' };
        List<SelectOption> displayedMaterialTypesList = controller.displayedMaterialTypesList;

        Test.startTest();
        controller.actionSendResultsToReceiver();
        System.assert(receiver.searchResults.get(0).quantity == 2.0);
        System.assert(receiver.searchResults.size() == 1);
        controller.searchResults = new List<CTRL_MaterialSearch.MaterialSearchResult>();
        controller.searchResults.add(m1);
        controller.searchResults.add(m2);
        controller.actionSendSingleResultToReceiver();

        CTRL_MaterialSearch.MaterialSearchResult m3 = new CTRL_MaterialSearch.MaterialSearchResult();
        m3.material = material;
        m3.materialId = 'MOCK';
        m3.quantity = 2.5;
        m3.isSelected = true;
        controller.searchResults = new List<CTRL_MaterialSearch.MaterialSearchResult>();
        controller.searchResults.add(m3);

        controller.isQuantityEnabled = true;
        controller.actionSendResultsToReceiver();

        controller.searchResults = new List<CTRL_MaterialSearch.MaterialSearchResult>();
        controller.searchResults.add(m3);

        controller.actionSendSingleResultToReceiver();
        Test.stopTest();

    }

    @isTest 
    static void test_clearSearch()
    {
        MockProductHierarchyRfc mock = new MockProductHierarchyRfc();
        ensxsdk.EnosixFramework.setMock(RFC_MM_GET_PROD_HIERARCHY.class, mock);
        MockSearch mockSBO = new MockSearch();
        ensxsdk.EnosixFramework.setMock(SBO_SFCIMaterial_Search.class, mockSBO);

        CTRL_MaterialSearch controller = new CTRL_MaterialSearch();
        controller.searchResults = new List<CTRL_MaterialSearch.MaterialSearchResult>();
        controller.isAutoSearchEnabled = false;
        controller.isSearchOnClearEnabled = false;

        CTRL_MaterialSearch.MaterialSearchResult m1 = new CTRL_MaterialSearch.MaterialSearchResult();
        m1.quantity = 1.0;
        m1.isSelected = false;
        controller.searchResults.add(m1);

        controller.defaultMaterialNumber = 'blank';
        controller.defaultHierarchy = 'blank';
        controller.defaultDescription = 'blank';
        controller.defaultTypes = new List<string>();
        controller.allowedMaterialTypes = new List<string> { '1', '2' };
        controller.materialTypesSelected = new List<string> { '1', '2' };
        controller.productHierarchy = 'not empty';
        controller.searchDescription = 'not empty';

        Test.startTest();
        controller.clearSearch();
        Test.stopTest();

        System.assert(controller.searchResults == null);
        System.assert(controller.material == controller.defaultMaterialNumber);
        System.assert(controller.productHierarchy == controller.defaultHierarchy);
        System.assert(controller.searchDescription == controller.defaultDescription);
        System.assert(controller.materialTypesSelected.size() == 0);
    }

    @isTest 
    static void test_productHierarchiesList()
    {
        MockProductHierarchyRfc mock = new MockProductHierarchyRfc();
        ensxsdk.EnosixFramework.setMock(RFC_MM_GET_PROD_HIERARCHY.class, mock);
        MockSearch mockSBO = new MockSearch();
        ensxsdk.EnosixFramework.setMock(SBO_SFCIMaterial_Search.class, mockSBO);

        Test.startTest();
        CTRL_MaterialSearch controller = new CTRL_MaterialSearch();
        List<SelectOption> options = controller.productHierarchiesList;
        mock.setSuccess(false);
        RFC_MM_GET_PROD_HIERARCHY.RESULT searchOptions = CTRL_MaterialSearch.getSearchOptions();
        Test.stopTest();

        System.assert(options.size() == 2);
        System.assert(options.get(0).getLabel() == 'Hierarchy 1');
        System.assert(options.get(1).getLabel() == '- Hierarchy 2');
    }

    @isTest 
    static void test_materialTypesList()
    {
        MockProductHierarchyRfc mock = new MockProductHierarchyRfc();
        ensxsdk.EnosixFramework.setMock(RFC_MM_GET_PROD_HIERARCHY.class, mock);
        MockSearch mockSBO = new MockSearch();
        ensxsdk.EnosixFramework.setMock(SBO_SFCIMaterial_Search.class, mockSBO);

        Test.startTest();
        CTRL_MaterialSearch controller = new CTRL_MaterialSearch();
        List<SelectOption> options = controller.materialTypesList;
        Test.stopTest();

        System.assert(options.size() == 2);
        System.assert(options.get(0).getLabel() == 'Material Type 1');
        System.assert(options.get(1).getLabel() == 'Material Type 2');
    }

    public class MockSearch implements ensxsdk.EnosixFramework.SearchSBOSearchMock
    {
        private boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        private boolean throwException = false;

        public void setThrowException(boolean throwException)
        {
            this.throwException = throwException;
        }

        private boolean returnResults = true;

        public void setReturnResults(boolean returnResults)
        {
            this.returnResults = returnResults;
        }

        public ensxsdk.EnosixFramework.SearchContext executeSearch(ensxsdk.EnosixFramework.SearchContext searchContext)
        {
            if (throwException)
            {
                throw new CalloutException();
            }
            SBO_SFCIMaterial_Search.SFCIMaterial_SR searchResult = new SBO_SFCIMaterial_Search.SFCIMaterial_SR();

            SBO_SFCIMaterial_Search.SEARCHRESULT result = new SBO_SFCIMaterial_Search.SEARCHRESULT();
            result.Material = 'MOCK';
            if (this.returnResults)
            {
                searchResult.SearchResults.add(result);
            }

            searchResult.setSuccess(this.success);
            searchContext.baseResult = searchResult;
			return searchContext;
        }
    }

    public class MockProductHierarchyRfc implements ensxsdk.EnosixFramework.RFCMock
    {
        private boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            RFC_MM_GET_PROD_HIERARCHY.RESULT funcObj =
                new RFC_MM_GET_PROD_HIERARCHY.RESULT();

            RFC_MM_GET_PROD_HIERARCHY.ET_PROD_HIERARCHY ph1 =
                new RFC_MM_GET_PROD_HIERARCHY.ET_PROD_HIERARCHY();
            ph1.PRODH = 'PH1';
            ph1.VTEXT = 'Hierarchy 1';
            ph1.STUFE = '1';

            RFC_MM_GET_PROD_HIERARCHY.ET_PROD_HIERARCHY ph2 =
                new RFC_MM_GET_PROD_HIERARCHY.ET_PROD_HIERARCHY();
            ph2.PRODH = 'PH2';
            ph2.VTEXT = 'Hierarchy 2';
            ph2.STUFE = '2';

            RFC_MM_GET_PROD_HIERARCHY.ET_MATERIAL_TYPE mt1 =
                new RFC_MM_GET_PROD_HIERARCHY.ET_MATERIAL_TYPE();
            mt1.MTART = '1';
            mt1.MTBEZ = 'Material Type 1';

            RFC_MM_GET_PROD_HIERARCHY.ET_MATERIAL_TYPE mt2 =
                new RFC_MM_GET_PROD_HIERARCHY.ET_MATERIAL_TYPE();
            mt2.MTART = '2';
            mt2.MTBEZ = 'Material Type 2';

            RFC_MM_GET_PROD_HIERARCHY.ET_PRODUCT_ATTRIB pa1 =
                new RFC_MM_GET_PROD_HIERARCHY.ET_PRODUCT_ATTRIB();
            pa1.PRODUCT_ATTRIB = 'PA1';

            RFC_MM_GET_PROD_HIERARCHY.ET_PRODUCT_ATTRIB pa2 =
                new RFC_MM_GET_PROD_HIERARCHY.ET_PRODUCT_ATTRIB();
            pa2.PRODUCT_ATTRIB = 'PA2';

            funcObj.getCollection(RFC_MM_GET_PROD_HIERARCHY.ET_PROD_HIERARCHY.class).add(ph1);
            funcObj.getCollection(RFC_MM_GET_PROD_HIERARCHY.ET_PROD_HIERARCHY.class).add(ph2);
            funcObj.getCollection(RFC_MM_GET_PROD_HIERARCHY.ET_MATERIAL_TYPE.class).add(mt1);
            funcObj.getCollection(RFC_MM_GET_PROD_HIERARCHY.ET_MATERIAL_TYPE.class).add(mt2);
            funcObj.getCollection(RFC_MM_GET_PROD_HIERARCHY.ET_PRODUCT_ATTRIB.class).add(pa1);
            funcObj.getCollection(RFC_MM_GET_PROD_HIERARCHY.ET_PRODUCT_ATTRIB.class).add(pa2);
            funcObj.setSuccess(this.success);

            return funcObj;
        }
    }

    public class MockReceiver implements CB_MaterialSearchReceiver
    {
        public List<CTRL_MaterialSearch.MaterialSearchResult> searchResults { get; set; }
        public void onReceiveMaterialSearchResults(string id, List<CTRL_MaterialSearch.MaterialSearchResult> results)
        {
            this.searchResults = results;
        }
    }
}