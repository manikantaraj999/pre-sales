public with sharing class CTRL_StockSearch implements I_SearchController
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_StockSearch.class);
    public Boolean isClassic
    {
        get {return (UserInfo.getUiThemeDisplayed() == 'Theme3');}
    }

    public Boolean hasRecords { get; private set; }
    public SBO_EnosixStockList_Search stockListSearch { get; set; }
    public SBO_EnosixStockList_Search.EnosixStockList_SC searchContext {get; set;}
    public List<SBO_EnosixStockList_Search.SEARCHRESULT> sls { get; private set; }  // paginated

    public UTIL_PagingOptionsWrapper pagingOptionsWrapper { get; private set; } // pagination use
    public I_SearchController searchController { get { return this; } }

    public String OpportunityId { get; set; }

    // Plants picklist
    public List<SelectOption> plants
    {
        get
        {
            List<SelectOption> plntLSelectOptions = new List<SelectOption>();
            plntLSelectOptions.add(new SelectOption('*', 'All'));
            RFC_MM_GET_PLANT_VALUES_S4 pl = new RFC_MM_GET_PLANT_VALUES_S4();
            RFC_MM_GET_PLANT_VALUES_S4.RESULT pl_result = pl.execute();
            List<RFC_MM_GET_PLANT_VALUES_S4.ET_OUTPUT> plantList = pl_result.ET_OUTPUT_List;
            Integer plantTot = plantList.size();
            for (Integer plantCnt = 0 ; plantCnt < plantTot ; plantCnt++)
            {
                RFC_MM_GET_PLANT_VALUES_S4.ET_OUTPUT ev = plantList[plantCnt];
                if (ev.Plant != null && ev.PlantName != null)
                    plntLSelectOptions.add(new SelectOption(ev.Plant, ev.PlantName));
            }
            return plntLSelectOptions;
        }
    }

    public CTRL_StockSearch()
    {
        this.sls = new List<SBO_EnosixStockList_Search.SEARCHRESULT>();
        this.stockListSearch = new SBO_EnosixStockList_Search();
        this.searchContext = new SBO_EnosixStockList_Search.EnosixStockList_SC();
        this.pagingOptionsWrapper = new UTIL_PagingOptionsWrapper(searchContext.pagingOptions);
        this.hasRecords = false;
        initFromParameters();
    }

    public void initFromParameters()
    {
        this.searchContext.SEARCHPARAMS.Material = UTIL_PageState.current.sfMaterialId;
        OpportunityId = UTIL_PageState.current.sfOpportunityId;
        this.searchContext.SEARCHPARAMS.Plant = UTIL_PageState.current.sfPlantId;

        if (String.isBlank(this.searchContext.SEARCHPARAMS.Plant))
        {
            this.searchContext.SEARCHPARAMS.Plant = '*';
        }

        searchSL();
    }

    public PageReference backInventory()
    {
        return UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_InventorySearch, UTIL_PageState.current);
    }

    public void searchSL()
    {
        this.searchContext.pagingOptions.pageSize = UTIL_ViewHelper.SearchDefaultPageSize;
        this.searchContext.pagingOptions.pageNumber = 1;

        runSearch();
    }

    public void runSearch()
    {
        this.searchContext = this.stockListSearch.search(this.searchContext);
        SBO_EnosixStockList_Search.EnosixStockList_SR searchResult = this.searchContext.result;
        System.debug('searchResult: ' + searchResult);

        if (searchResult.isSuccess())
        {
            this.sls = searchResult.getResults();
            this.hasRecords = true;
        }
        else
        {
            this.hasRecords = false;
            this.sls = null;
            UTIL_ViewHelper.displayResultMessages(searchResult.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
        }
    }
}