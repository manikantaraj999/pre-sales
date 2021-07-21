@isTest
private class TSTC_StockSearch
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
        ensxsdk.EnosixFramework.setMock(RFC_MM_GET_PLANT_VALUES_S4.class, new MOC_RFC_MM_GET_PLANT_VALUES_S4());
        ensxsdk.EnosixFramework.setMock(SBO_EnosixStockList_Search.class, new MOC_EnosixStockList_Search.MockEnosixStockListSuccess());
        Test.startTest();
        CTRL_StockSearch stockList = new CTRL_StockSearch();
        String oppId = stockList.OpportunityId;
        stockList.stockListSearch = new SBO_EnosixStockList_Search();
        List<SelectOption> plants = stockList.plants;
        stockList.stockListSearch = new SBO_EnosixStockList_Search();
        I_SearchController searchController = stockList.searchController;
        Boolean isClassic = stockList.isClassic;
        Test.stopTest();
    }

    static testMethod void testConstructionFailure()
    {
        ensxsdk.EnosixFramework.setMock(RFC_MM_GET_PLANT_VALUES_S4.class, new MOC_RFC_MM_GET_PLANT_VALUES_S4());
        ensxsdk.EnosixFramework.setMock(SBO_EnosixStockList_Search.class, new MOC_EnosixStockList_Search.MockEnosixStockListFailure());
        Test.startTest();
        CTRL_StockSearch stockList = new CTRL_StockSearch();
        string oppId = stockList.OpportunityId;
        stockList.stockListSearch = new SBO_EnosixStockList_Search();
        Test.stopTest();
    }

    static testMethod void testBackInventory()
    {
        ensxsdk.EnosixFramework.setMock(SBO_EnosixStockList_Search.class, new MOC_EnosixStockList_Search.MockEnosixStockListSuccess());
        Test.startTest();
        Test.setCurrentPageReference(new PageReference('Page.VFP_StockSearch'));
        CTRL_StockSearch stockList = new CTRL_StockSearch();
        stockList.OpportunityId = 'testOpportunity';
        stockList.backInventory();
        Test.stopTest();
    }
}