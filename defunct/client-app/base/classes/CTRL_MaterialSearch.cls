public with sharing class CTRL_MaterialSearch implements I_SearchController
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_MaterialSearch.class);

    public boolean isOnLoadComplete { get; set; }
    public string material { get; set; }
    public string productHierarchy { get; set; }
    public string searchDescription { get; set; }
    public string userMessage{get; set;}

    SBO_SFCIMaterial_Search.SFCIMaterial_SC searchContext { get; set; }
    public UTIL_PagingOptionsWrapper pagingOptionsWrapper { get; private set; }
    public I_SearchController searchController { get { return this; } }
    public Boolean hasRecords { get; private set; }

    @testVisible
    public List<MaterialSearchResult> searchResults { get; private set; }

    // These booleans track if all assignTo props are set so we can trigger
    // the initial default save and auto-search when it's ready. This prevents
    // search and other onload settings from happening multiple times which
    // prevents slow loads and checkbox flicker
    private boolean isComponentIdSet = false;
    private boolean isSearchReceiverSet = false;
    private boolean isMultiSelectEnabledSet = false;
    private boolean isScheduleDateEnabledSet = false;
    private boolean isAutoSearchEnabledSet = false;
    private boolean isSearchOnClearEnabledSet = false;
    private boolean isQuantityEnabledSet = false;
    private boolean isSalesOrgSet = false;
    private boolean isDistChannelSet = false;
    private boolean isDefaultMaterialSet = false;
    private boolean isDefaultHierarchySet = false;
    private boolean isDefaultDescriptionSet = false;
    private boolean isAllowedMaterialTypesSet = false;
    private boolean isDefaultTypesSet = false;
    private boolean isListHeightSet = false;
    private string componentIdSave = null;
    private string salesOrgSave = null;
    private string distChannelSave = null;
    private string defaultMaterialNumberSave = null;
    private string defaultHierarchySave = null;
    private string defaultDescriptionSave = null;

    public CTRL_MaterialSearch()
    {
        this.resetSearchContext();
        this.isOnLoadComplete = false;
        userMessage = '';
    }

    public string componentId
    {
        get;
        set
        {
            this.componentId = value;
            this.isComponentIdSet = true;
            if (value != this.componentIdSave)
            {
                this.isOnLoadComplete = false;
                this.componentIdSave = value;
            }
            loadIfReady();
        }
    }

    public CB_MaterialSearchReceiver searchReceiver
    {
        get;
        set
        {
            this.searchReceiver = value;
            this.isSearchReceiverSet = true;
            loadIfReady();
        }
    }

    public boolean isMultiSelectEnabled
    {
        get;
        set
        {
            this.isMultiSelectEnabled = value;
            this.isMultiSelectEnabledSet = true;
            loadIfReady();
        }
    }

    public boolean isScheduleDateEnabled
    {
        get;
        set
        {
            this.isScheduleDateEnabled = value;
            this.isScheduleDateEnabledSet = true;
            loadIfReady();
        }
    }

    public boolean isAutoSearchEnabled
    {
        get;
        set
        {
            this.isAutoSearchEnabled = value;
            this.isAutoSearchEnabledSet = true;
            loadIfReady();
        }
    }

    public boolean isSearchOnClearEnabled
    {
        get;
        set
        {
            this.isSearchOnClearEnabled = value;
            this.isSearchOnClearEnabledSet = true;
            loadIfReady();
        }
    }

    public boolean isQuantityEnabled
    {
        get;
        set
        {
            this.isQuantityEnabled = value;
            this.isQuantityEnabledSet = true;
            loadIfReady();
        }
    }

    public boolean isCartonEnabled
    {
        get;
        set
        {
            this.isCartonEnabled = value;
            // Carton is not part of the current SBOs so disabling but leaving the code incase it is 
            // needed for a future customer
            this.isCartonEnabled = false;
            loadIfReady();
        }
    }

    public string salesOrg
    {
        get;
        set
        {
            this.salesOrg = value;
            this.isSalesOrgSet = true;
            if (value != this.salesOrgSave)
            {
                this.isOnLoadComplete = false;
                this.salesOrgSave = value;
            }
            loadIfReady();
        }
    }

    public string distChannel
    {
        get;
        set
        {
            this.distChannel = value;
            this.isDistChannelSet = true;
            if (value != this.distChannelSave)
            {
                this.isOnLoadComplete = false;
                this.distChannelSave = value;
            }
            loadIfReady();
        }
    }

    public string defaultMaterialNumber
    {
        get;
        set
        {
            this.defaultMaterialNumber = value;
            this.isDefaultMaterialSet = true;
            if (value != this.defaultMaterialNumberSave)
            {
                this.isOnLoadComplete = false;
                this.defaultMaterialNumberSave = value;
            }
            loadIfReady();
        }
    }

    public string defaultHierarchy
    {
        get;
        set
        {
            this.defaultHierarchy = value;
            this.isDefaultHierarchySet = true;
            if (value != this.defaultHierarchySave)
            {
                this.isOnLoadComplete = false;
                this.defaultHierarchySave = value;
            }
            loadIfReady();
        }
    }

    public string defaultDescription
    {
        get;
        set
        {
            this.defaultDescription = value;
            this.isDefaultDescriptionSet = true;
            if (value != this.defaultDescriptionSave)
            {
                this.isOnLoadComplete = false;
                this.defaultDescriptionSave = value;
            }
            loadIfReady();
        }
    }

    public List<string> allowedMaterialTypes
    {
        get;
        set
        {
            this.allowedMaterialTypes = value;
            this.isAllowedMaterialTypesSet = true;
            loadIfReady();
        }
    }

    public List<string> defaultTypes
    {
        get;
        set
        {
            this.defaultTypes = value;
            this.isDefaultTypesSet = true;
            loadIfReady();
        }
    }

    public List<string> materialTypesSelected
    {
        get;
        set
        {
            // If you don't do this, then Salesforce will get angry when you
            // check the checkboxes
            this.materialTypesSelected = value;
            if (null == value)
            {
                this.materialTypesSelected = new List<string>();
            }
        }
    }

    public string listHeight
    {
        get;
        set
        {
            this.listHeight = value;
            this.isListHeightSet = true;
            loadIfReady();
        }
    }

    private void loadIfReady()
    {
        if (!this.isOnLoadComplete &&
                this.isComponentIdSet &&
                this.isSearchReceiverSet &&
                this.isMultiSelectEnabledSet &&
                this.isScheduleDateEnabledSet &&
                this.isAutoSearchEnabledSet &&
                this.isSearchOnClearEnabledSet &&
                this.isQuantityEnabledSet &&
                this.isSalesOrgSet &&
                this.isDistChannelSet &&
                this.isDefaultMaterialSet &&
                this.isDefaultHierarchySet &&
                this.isDefaultDescriptionSet &&
                this.isAllowedMaterialTypesSet &&
                this.isDefaultTypesSet &&
                this.isListHeightSet )
        {
            loadDefaults();
        }
    }

    public void loadDefaults()
    {
        System.debug('loadDefaults: ' + this.componentId);
        this.material = this.defaultMaterialNumber;
        this.productHierarchy = this.defaultHierarchy;
        this.searchDescription = this.defaultDescription;
        this.materialTypesSelected = this.defaultTypes;
        this.resetSearchContext();

        // If we have never auto-searched, do it
        if (!this.isOnLoadComplete && this.isAutoSearchEnabled)
            runSearch();
        // If we have auto-searched, but isSearchOnClearEnabled, do it anyway
        else if (this.isOnLoadComplete && this.isAutoSearchEnabled && this.isSearchOnClearEnabled)
            runSearch();

        this.isOnLoadComplete = true;
    }

    public void actionSearch()
    {
        this.resetSearchContext();
        this.runSearch();
    }

    public void runSearch()
    {
        String description = this.searchDescription;
        if (null == description) description = '';
        if (!description.startsWith('*')) description = '*' + description;
        if (!description.endsWith('*')) description += '*';
        System.debug('searching for: ' + this.productHierarchy + ' - ' + description);

        this.searchContext.SEARCHPARAMS.MaterialDescription = description;

        if (String.isNotBlank(this.material))
        {
            this.searchContext.SEARCHPARAMS.Material = this.material;
        }
        if (String.isNotBlank(this.productHierarchy))
        {
            this.searchContext.SEARCHPARAMS.ProductHierarchy = this.productHierarchy;
        }
        if (String.isNotBlank(this.salesOrg))
        {
            this.searchContext.SEARCHPARAMS.SalesOrganization = this.salesOrg;
        }
        if (String.isNotBlank(this.distChannel))
        {
            this.searchContext.SEARCHPARAMS.DistributionChannel = this.distChannel;
        }

        this.searchContext.MATERIAL_TYPE.clear();

        if (null != materialTypesSelected)
        {
            Integer matTot = materialTypesSelected.size();
            for (Integer matCnt = 0 ; matCnt < matTot ; matCnt++)
            {
                String materialType = materialTypesSelected[matCnt];
                SBO_SFCIMaterial_Search.MATERIAL_TYPE type =
                        new SBO_SFCIMaterial_Search.MATERIAL_TYPE();
                type.MaterialType = materialType;
                this.searchContext.MATERIAL_TYPE.add(type);
            }
        }

        SBO_SFCIMaterial_Search sbo = new SBO_SFCIMaterial_Search();
        this.searchContext = sbo.search(this.searchContext);
        SBO_SFCIMaterial_Search.SFCIMaterial_SR result = this.searchContext.result;

        if (!result.isSuccess())
        {
            this.hasRecords = false;
            searchResults = null;
            UTIL_ViewHelper.displayResultMessages(result.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
            userMessage = 'No Results Found';
            System.debug('Search failed');
        }
        else
        {
            searchResults = new List<MaterialSearchResult>();
            List<SBO_SFCIMaterial_Search.SEARCHRESULT> srList = result.getResults();
            Integer srTot = srList.size();
            for (Integer srCnt = 0 ; srCnt < srTot ; srCnt++)
            {
                SBO_SFCIMaterial_Search.SEARCHRESULT sr = srList[srCnt];
                searchResults.add(materialSearchResultFromSR(
                    sr, this.isQuantityEnabled, this.isScheduleDateEnabled));
            }
            this.hasRecords = true;
            if (searchResults.size() < 1)
            {
                userMessage = 'No Results Found';
            }
            else
            {
                userMessage = '';
            }
            System.debug('Search success - materials found: ' + searchResults.size());
        }
    }

    public void actionSendResultsToReceiver()
    {
        this.isOnLoadComplete = false;
        List<MaterialSearchResult> result = new List<MaterialSearchResult>();
        Integer matTot = searchResults.size();
        for (Integer matCnt = 0 ; matCnt < matTot ; matCnt++)
        {
            MaterialSearchResult material = searchResults[matCnt];
            if (material.isSelected)
            {
                if (this.isQuantityEnabled && material.quantity != Math.floor(material.quantity))
                {
                    ApexPages.addMessage(
                            new Apexpages.Message(
                                    ApexPages.Severity.ERROR,
                                    'Quantity ' + material.quantity.format() + ' must be a whole number'
                            ));
                    return;
                }

                result.add(material);
            }
        }
        searchReceiver.onReceiveMaterialSearchResults(componentId, result);
        clearSearch();
    }

    public void actionSendSingleResultToReceiver()
    {
        this.isOnLoadComplete = false;
        String selectedMaterial = System.currentPageReference().getParameters().get('selectedMaterial');

        Integer matTot = searchResults.size();
        for (Integer matCnt = 0 ; matCnt < matTot ; matCnt++)
        {
            MaterialSearchResult material = searchResults[matCnt];
            if (material.materialId == selectedMaterial)
            {
                if (this.isQuantityEnabled && material.quantity != Math.floor(material.quantity))
                {
                    ApexPages.addMessage(
                        new Apexpages.Message(
                            ApexPages.Severity.ERROR,
                            'Quantity ' + material.quantity.format() + ' must be a whole number'
                        ));
                    return;
                }

                List<MaterialSearchResult> result = new List<MaterialSearchResult>();
                result.add(material);
                searchReceiver.onReceiveMaterialSearchResults(componentId, result);
                clearSearch();
                return;
            }
        }
    }

    public string tableWrapperStyle
    {
        get
        {
            if (this.isListHeightSet && string.isNotBlank(this.listHeight))
            {
                return 'overflow: scroll; max-height: ' + this.listHeight + ';';
            }
            return '';
        }
    }

    public Integer footerColSpan
    {
        get
        {
            Integer result = 5;
            if (this.isScheduleDateEnabled) result += 1;
            if (this.isQuantityEnabled) result += 2;
            if (this.isQuantityEnabled && this.isCartonEnabled) result += 1;
            return result;
        }
    }

    @testVisible
    private void clearSearch()
    {
        searchResults = null;
        loadDefaults();
    }

    private void resetSearchContext()
    {
        Integer pageSize = UTIL_ViewHelper.SearchDefaultPageSize;
        if (this.searchContext != null)
        {
            // page size is the only thing not reset
            pageSize = this.searchContext.pagingOptions.pageSize;
        }
        this.searchContext = new SBO_SFCIMaterial_Search.SFCIMaterial_SC();
        this.pagingOptionsWrapper = new UTIL_PagingOptionsWrapper(searchContext.pagingOptions);
        this.searchContext.pagingOptions.pageSize = pageSize;
        this.searchContext.pagingOptions.pageNumber = 1;
        this.hasRecords = false;
    }

    // init product hierarchy and other search option values
    @testVisible
    private static RFC_MM_GET_PROD_HIERARCHY.RESULT getSearchOptions()
    {
        RFC_MM_GET_PROD_HIERARCHY rfc = new RFC_MM_GET_PROD_HIERARCHY();
        // Only get 3 levels of product hierarchy
        rfc.Params.IV_LEVEL_NUMBER = '3';
        RFC_MM_GET_PROD_HIERARCHY.RESULT result = rfc.execute();
        System.debug('RFC Results:');
        System.debug(result);

        if (!result.isSuccess())
        {
            UTIL_ViewHelper.displayResultMessages(result.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
        }

        return result;
    }

    private static RFC_MM_GET_PROD_HIERARCHY.RESULT cache_rfcSearchOptions;
    RFC_MM_GET_PROD_HIERARCHY.RESULT rfcSearchOptions
    {
        get
        {
            if (null == cache_rfcSearchOptions)
            {
                cache_rfcSearchOptions = getSearchOptions();
            }
            return cache_rfcSearchOptions;
        }
    }

    // product hierarchy dropdown
    public List<SelectOption> productHierarchiesList
    {
        get
        {
            ProductHierarchyOptionBuilder optionBulder = new ProductHierarchyOptionBuilder();
            return UTIL_SelectOption.buildOptionsFromList(
                    optionBulder, this.rfcSearchOptions.ET_PROD_HIERARCHY_List);
        }
    }

    // material type checkboxes
    public List<SelectOption> materialTypesList
    {
        get
        {
            MaterialTypeOptionBuilder optionBulder = new MaterialTypeOptionBuilder();
            return UTIL_SelectOption.buildOptionsFromList(
                    optionBulder, this.rfcSearchOptions.ET_MATERIAL_TYPE_List);
        }
    }

    public List<SelectOption> displayedMaterialTypesList
    {
        get
        {
            List<SelectOption> result = new List<SelectOption>();
            List<SelectOption> matTypes = this.materialTypesList;
            Set<String> defTypesSet = new Set<String>(this.allowedMaterialTypes);
            Integer matTot = matTypes.size();
            for (Integer matCnt = 0 ; matCnt < matTot ; matCnt++)
            {
                SelectOption so = matTypes[matCnt];
                if (defTypesSet.contains(so.getValue()))
                {
                    result.add(so);
                }
            }

            return result;
        }
    }

    // This helps build select options for product hierarchy dropdown
    class ProductHierarchyOptionBuilder extends UTIL_SelectOption.OptionBuilder
    {
        public override string getItemValue(object item)
        {
            return ((RFC_MM_GET_PROD_HIERARCHY.ET_PROD_HIERARCHY) item).PRODH;
        }

        // item label indented by STUFE spaces
        public override string getItemDescription(object item)
        {
            string result = '';
            integer spaces = integer.valueOf(((RFC_MM_GET_PROD_HIERARCHY.ET_PROD_HIERARCHY) item).STUFE) - 1;
            for (integer cnt = 0; cnt < spaces; cnt++)
            {
                result += '- ';
            }
            result += ((RFC_MM_GET_PROD_HIERARCHY.ET_PROD_HIERARCHY) item).VTEXT;
            return result;
        }

        // don't allow base classes to display KEY - Desc. We need only Des. for the formatting
        // to appear correct
        public override string getItemLabel(object item)
        {
            return getItemDescription(item);
        }
    }

    // This helps build select options for the material type checkboxes
    class MaterialTypeOptionBuilder extends UTIL_SelectOption.OptionBuilder
    {
        public override string getItemValue(object item)
        {
            return ((RFC_MM_GET_PROD_HIERARCHY.ET_MATERIAL_TYPE) item).MTART;
        }

        public override string getItemDescription(object item)
        {
            return ((RFC_MM_GET_PROD_HIERARCHY.ET_MATERIAL_TYPE) item).MTBEZ;
        }

        // We don't want KEY - Desc on this one either
        public override string getItemLabel(object item)
        {
            return getItemDescription(item);
        }
    }

    // This "subclass" adds fields to the search result object which are needed
    // to facilate selecting list items and adjusting their quantities
    private static Integer currentMaterialId = 0;
    public class MaterialSearchResult
    {
        public SBO_SFCIMaterial_Search.SEARCHRESULT material { get; set; }
        public Decimal quantity { get; set; }
        public Date scheduleDate { get; set; }
        public Boolean isSelected { get; set; }
        public String materialId { get; set; }
    }

    public static MaterialSearchResult materialSearchResultFromSR(
        SBO_SFCIMaterial_Search.SEARCHRESULT sr,
        Boolean isQuantityEnabled,
        Boolean isScheduleDateEnabled)
    {
        MaterialSearchResult material = new MaterialSearchResult();
        material.material = sr;
        material.scheduleDate = null;
        material.isSelected = false;
        if (isQuantityEnabled)
        {
            material.quantity = 1;
        }
        material.materialId = String.valueOf(currentMaterialId++);

        return material;
    }
}