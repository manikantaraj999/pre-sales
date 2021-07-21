public with sharing class CTRL_InventorySearch implements  CB_MaterialSearchReceiver, I_SearchController
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_InventorySearch.class);

    public Boolean hasRecords { get; private set; }
    public SBO_EnosixWarehouseStock_Search warehouseSearch { get; set; }
    public SBO_EnosixWarehouseStock_Search.EnosixWarehouseStock_SC searchContext { get; set; }

    public List<SBO_EnosixWarehouseStock_Search.SEARCHRESULT> ewsList { get; private set; }  // paginated
    public UTIL_PagingOptionsWrapper pagingOptionsWrapper { get; private set; } // pagination use
    public I_SearchController searchController { get { return this; } }

    public Boolean isClassic
    {
        get {return (UserInfo.getUiThemeDisplayed() == 'Theme3');}
    }

    private transient RFC_MM_GET_PLANT_VALUES_S4.RESULT t_plantValues;
    private RFC_MM_GET_PLANT_VALUES_S4.RESULT plantValues
    {
        get
        {
            if (null == this.t_plantValues)
            {
                RFC_MM_GET_PLANT_VALUES_S4 pl = new RFC_MM_GET_PLANT_VALUES_S4();
                this.t_plantValues = pl.execute();
            }
            return this.t_plantValues;
        }
    }

    public List<SelectOption> plants
    {
        get
        {
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('All', 'All'));
            if (this.plantValues != null)
            {
                List<RFC_MM_GET_PLANT_VALUES_S4.ET_OUTPUT> plantList = this.plantValues.ET_OUTPUT_List;
                Integer plantTot = plantList.size();
                for (Integer plantCnt = 0 ; plantCnt < plantTot ; plantCnt++)
                {
                    RFC_MM_GET_PLANT_VALUES_S4.ET_OUTPUT ev = plantList[plantCnt];
                    if (ev.Plant != null && ev.PlantName != null)
                    {
                        options.add(new SelectOption(ev.Plant, ev.PlantName));
                    }
                }
            }
            UTIL_ViewHelper.sortOptionsByLabel(options);
            return options;
        }
    }

    public String plantName { get; set; }
    public Opportunity opportunity { get; set; }
    public String opportunityProductId { get; set; }
    public String materialSearchQuery { get; set; }
    public String materialSearchParam { get; set; }

    public CTRL_InventorySearch()
    {
        this.warehouseSearch = new SBO_EnosixWarehouseStock_Search();
        this.searchContext = new SBO_EnosixWarehouseStock_Search.EnosixWarehouseStock_SC();
        this.ewsList = new List<SBO_EnosixWarehouseStock_Search.SEARCHRESULT>();
        this.pagingOptionsWrapper = new UTIL_PagingOptionsWrapper(searchContext.pagingOptions);
        this.hasRecords = false;
        this.initFromParameters();
    }

    public void initFromParameters()
    {
        this.plantName = 'All';
        if (null != UTIL_PageState.current.sfOpportunityId)
        {
            this.opportunity = (Opportunity) UTIL_SFSObjectDoc.getSObject(UTIL_PageState.current.sfOpportunityId);
        }
        this.opportunityProductId = UTIL_PageState.current.sfOpportunityProductId;
        this.materialSearchQuery = MaterialSearchParam = UTIL_PageState.current.sfMaterialId;

        if (null != this.materialSearchQuery)
        {
            searchEWS();
        }
        UTIL_PageMessages.displayOnVfp();
    }

    public PageReference backOpportunity()
    {
        if (null !=  this.opportunity)
        {
            return UTIL_PageFlow.redirectTo('/' + this.opportunity.Id, null);
        }
        //return to Opportunities landing if there isnt an id available
        return UTIL_PageFlow.redirectTo('/006', null);
    }

    public PageReference backMaterial()
    {
        if (this.opportunityProductId != null)
        {
            return UTIL_PageFlow.redirectTo('/' + this.opportunityProductId, null);
        }
        return null;
    }

    public PageReference goToStockListPage()
    {
        UTIL_PageState.current.sfMaterialId =
            System.currentPageReference().getParameters().get('material');
        UTIL_PageState.current.sfPlantId =
            System.currentPageReference().getParameters().get('plant');

        return UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_StockSearch, UTIL_PageState.current);
    }

    public List<String> inventoryMaterialTypes
    {
        get
        {
            return (List<String>)UTIL_AppSettings.getList(
                'Inventory.MaterialTypes', String.class, new List<String>{ 'FERT' });
        }
    }

    public List<String> defaultInventoryMaterialTypes
    {
        get
        {
            return (List<String>)UTIL_AppSettings.getList(
                'Inventory.DefaultMaterialTypes', String.class, InventoryMaterialTypes);
        }
    }

    public Boolean isInventoryMaterialAutoSearchEnabled
    {
        get
        {
            return (Boolean)UTIL_AppSettings.getValue('Inventory.IsMaterialAutoSearchEnabled', true);
        }
    }

    public CB_MaterialSearchReceiver msReceiver { get { return this; } }

    public void onReceiveMaterialSearchResults(string id, List<CTRL_MaterialSearch.MaterialSearchResult> results)
    {
        CTRL_MaterialSearch.MaterialSearchResult result = results.get(0);
        this.materialSearchQuery = result.material.Material;
        this.searchEWS();
    }

    public String sendSalesOrganizationToMaterialSearch(String id)
    {
        return  '';
    }

    public String sendDistributionChannelToMaterialSearch(String id)
    {
        return '';
    }

    public void searchEWS()
    {
        if (this.warehouseSearch == null)
        {
            this.warehouseSearch = new SBO_EnosixWarehouseStock_Search();
        }
        if (this.searchContext == null)
        {
            this.searchContext = new SBO_EnosixWarehouseStock_Search.EnosixWarehouseStock_SC();
        }

        SBO_EnosixWarehouseStock_Search.MATERIALSEARCH ms = new SBO_EnosixWarehouseStock_Search.MATERIALSEARCH();
        ms.Sign = 'I';
        ms.Option = 'EQ';
        if (this.materialSearchQuery != null || String.isNotEmpty(this.materialSearchQuery))
        {
            ms.Low = this.materialSearchQuery;
        }

        this.searchContext.MATERIALSEARCH.add(ms);

        if (this.plantName != null && this.plantName != 'All')
        {
            SBO_EnosixWarehouseStock_Search.PLANTSEARCH ps = new SBO_EnosixWarehouseStock_Search.PLANTSEARCH();

            ps.Sign = 'I';
            ps.Option = 'EQ';
            ps.Low = this.plantName;

            this.searchContext.PLANTSEARCH.add(ps);
        }

        runSearch();
    }

    public void runSearch()
    {
        this.searchContext = this.warehouseSearch.search(this.searchContext);
        SBO_EnosixWarehouseStock_Search.EnosixWarehouseStock_SR searchResult = this.searchContext.result;

        if (searchResult.isSuccess())
        {
            this.ewsList = searchResult.getResults();
            this.hasRecords = true;
        }
        else
        {
            this.ewsList = null;
            this.hasRecords = false;
        }
    }
}