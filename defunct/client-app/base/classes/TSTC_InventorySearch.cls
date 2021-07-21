@isTest
private class TSTC_InventorySearch
{
    public class MOC_RFC_MM_GET_PLANT_VALUES_S4 implements ensxsdk.EnosixFramework.RFCMock
    {
        public boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            RFC_MM_GET_PLANT_VALUES_S4.RESULT result = new RFC_MM_GET_PLANT_VALUES_S4.RESULT();

            RFC_MM_GET_PLANT_VALUES_S4.ET_OUTPUT etOutput = new RFC_MM_GET_PLANT_VALUES_S4.ET_OUTPUT();
            etOutput.Plant = 'Plant';
            etOutput.PlantName = 'PlantName';
            result.getCollection(RFC_MM_GET_PLANT_VALUES_S4.ET_OUTPUT.class).add(etOutput);
            result.setSuccess(this.success);
            return result;
        }
    }

    static testMethod void testConstructionSuccess()
    {
        ensxsdk.EnosixFramework.setMock(SBO_EnosixWarehouseStock_Search.class, new MOC_EnosixWarehouseStock_Search.MockEnosixWarehouseStockSuccess());
        ensxsdk.EnosixFramework.setMock(RFC_MM_GET_PLANT_VALUES_S4.class, new MOC_RFC_MM_GET_PLANT_VALUES_S4());
        UTIL_PageState.current.sfOpportunityId = 'opportunityId';
        UTIL_PageState.current.sfMaterialId = 'materialId';
        Test.startTest();
        CTRL_InventorySearch inventoryList = new CTRL_InventorySearch();
        inventoryList.warehouseSearch = null;
        inventoryList.searchEWS();
        inventoryList.warehouseSearch = new SBO_EnosixWarehouseStock_Search();
        string plantName = inventoryList.PlantName;
        Opportunity oppInst = inventoryList.Opportunity;
        string oppProdId = inventoryList.OpportunityProductId;
        string matSearch = inventoryList.MaterialSearchQuery;
        string matSearchParam = inventoryList.MaterialSearchParam;
        List<SelectOption> selectOpts  = inventoryList.plants;
        inventoryList.PlantName = 'PlantName';
        inventoryList.searchEWS();
        Boolean isClassic = inventoryList.isClassic;
        I_SearchController searchController = inventoryList.searchController;
        inventoryList.SearchContext = null;
        inventoryList.searchEWS();
        Test.stopTest();
    }

    static testMethod void testConstructionFailure()
    {
        ensxsdk.EnosixFramework.setMock(SBO_EnosixWarehouseStock_Search.class, new MOC_EnosixWarehouseStock_Search.MockEnosixWarehouseStockFailure());
        ensxsdk.EnosixFramework.setMock(RFC_MM_GET_PLANT_VALUES_S4.class, new MOC_RFC_MM_GET_PLANT_VALUES_S4());
        Test.startTest();
        CTRL_InventorySearch inventoryList = new CTRL_InventorySearch();
        inventoryList.warehouseSearch = new SBO_EnosixWarehouseStock_Search();
        string plantName = inventoryList.PlantName;
        Opportunity oppInst = inventoryList.Opportunity;
        string oppProdId = inventoryList.OpportunityProductId;
        string matSearch = inventoryList.MaterialSearchQuery;
        string matSearchParam = inventoryList.MaterialSearchParam;
        List<SelectOption> selectOpts  = inventoryList.plants;
        inventoryList.searchEWS();
        Test.stopTest();
    }

    static testMethod void testGoToStockListPage()
    {
        ensxsdk.EnosixFramework.setMock(SBO_EnosixWarehouseStock_Search.class, new MOC_EnosixWarehouseStock_Search.MockEnosixWarehouseStockSuccess());
        ensxsdk.EnosixFramework.setMock(RFC_MM_GET_PLANT_VALUES_S4.class, new MOC_RFC_MM_GET_PLANT_VALUES_S4());
        Test.startTest();
        CTRL_InventorySearch inventoryList = new CTRL_InventorySearch();
        Test.setCurrentPageReference(new PageReference('Page.VFP_InventorySearch'));
        System.currentPageReference().getParameters().put('material', 'testMaterialId');
        System.currentPageReference().getParameters().put('plant', 'testPlantId');
        inventoryList.goToStockListPage();
        Test.stopTest();
    }

    static testMethod void testBackOpportunity()
    {
        ensxsdk.EnosixFramework.setMock(SBO_EnosixWarehouseStock_Search.class, new MOC_EnosixWarehouseStock_Search.MockEnosixWarehouseStockSuccess());
        ensxsdk.EnosixFramework.setMock(RFC_MM_GET_PLANT_VALUES_S4.class, new MOC_RFC_MM_GET_PLANT_VALUES_S4());
        Test.startTest();
        Opportunity opportunity = TSTU_SFTestObject.createTestOpportunity();
        opportunity.Name = 'testName';
        opportunity.StageName = 'asdf';
        opportunity.CloseDate = Date.today();
        TSTU_SFTestObject.upsertWithRetry(opportunity);
        Test.setCurrentPageReference(new PageReference('Page.VFP_InventorySearch'));
        CTRL_InventorySearch inventoryList = new CTRL_InventorySearch();
        inventoryList.backOpportunity();
        inventoryList.Opportunity = opportunity;
        inventoryList.backOpportunity();
        Test.stopTest();
    }

    static testMethod void testbackMaterial()
    {
        ensxsdk.EnosixFramework.setMock(SBO_EnosixWarehouseStock_Search.class, new MOC_EnosixWarehouseStock_Search.MockEnosixWarehouseStockSuccess());
        ensxsdk.EnosixFramework.setMock(RFC_MM_GET_PLANT_VALUES_S4.class, new MOC_RFC_MM_GET_PLANT_VALUES_S4());
        Test.startTest();
        Test.setCurrentPageReference(new PageReference('Page.VFP_InventorySearch'));
        CTRL_InventorySearch inventoryList = new CTRL_InventorySearch();
        inventoryList.backMaterial();
        inventoryList.OpportunityProductId = 'testOpportunityProductId';
        inventoryList.backMaterial();
        Test.stopTest();
    }

    static testMethod void testScreenVariables()
    {
        ensxsdk.EnosixFramework.setMock(SBO_EnosixWarehouseStock_Search.class, new MOC_EnosixWarehouseStock_Search.MockEnosixWarehouseStockSuccess());
        ensxsdk.EnosixFramework.setMock(RFC_MM_GET_PLANT_VALUES_S4.class, new MOC_RFC_MM_GET_PLANT_VALUES_S4());
        Test.startTest();
        CTRL_InventorySearch inventoryList = new CTRL_InventorySearch();
        List<String> inventoryMaterialTypes = inventoryList.inventoryMaterialTypes;
        List<String> defaultInventoryMaterialTypes = inventoryList.defaultInventoryMaterialTypes;
        Boolean isInventoryMaterialAutoSearchEnabled = inventoryList.isInventoryMaterialAutoSearchEnabled;
        CTRL_MaterialSearch.MaterialSearchResult mat = new CTRL_MaterialSearch.MaterialSearchResult();
        mat.material = new SBO_SFCIMaterial_Search.SEARCHRESULT();
        List<CTRL_MaterialSearch.MaterialSearchResult> matList = new List<CTRL_MaterialSearch.MaterialSearchResult>{mat};
        inventoryList.onReceiveMaterialSearchResults(null,matList);
        String sendSalesOrganizationToMaterialSearch = inventoryList.sendSalesOrganizationToMaterialSearch(null);
        String sendDistributionChannelToMaterialSearch = inventoryList.sendDistributionChannelToMaterialSearch(null);
        CB_MaterialSearchReceiver msReceiver = inventoryList.msReceiver;
        Test.stopTest();
    }
}