public with sharing class CTRL_OpportunityQuotePricing implements CB_ShipToSearchReceiver, CB_MaterialSearchReceiver
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_QuoteCreateUpdate.class);
    public static final String calledFrom = 'CTRL_OpportunityQuotePricing';

    public void logCallouts(String location)
    {
        if ((Boolean)UTIL_AppSettings.getValue('CTRL_OpportunityQuotePricing.Logging', false))
        {
            logger.debug(location);
        }
    }

    public Boolean isClassic
    {
        get {return (UserInfo.getUiThemeDisplayed() == 'Theme3');}
    }

    public String previousScreen
    {
        get
        {
            return UTIL_PageState.SAP_PreviousScreenOpp;
        }
    }

    @testVisible
    public SObject sfSObject { get; private set; }

    private Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap = new Map<String, UTIL_SFSObjectDoc.SfSObjectItem>();

    public Opportunity opp 
    { 
        get 
        {
            return UTIL_SFSObjectDoc.getOpportunity(sfSObject);
        }
    }

    @testVisible
    private SBO_EnosixMaterial_Detail.EnosixMaterial selectedMaterialDetail;

    public List<string> opportunityMaterialTypes
    {
        get
        {
            return (List<String>)UTIL_AppSettings.getList(
                'Quote.MaterialTypes', String.class, new List<String>{ 'FERT' });
        }
    }

    public List<string> defaultOpportunityMaterialTypes
    {
        get
        {
            return (List<String>)UTIL_AppSettings.getList(
                'Quote.DefaultMaterialTypes', String.class, opportunityMaterialTypes);
        }
    }

    public boolean isOpportunityMaterialAutoSearchEnabled
    {
        get
        {
            return (Boolean)UTIL_AppSettings.getValue('Quote.IsMaterialAutoSearchEnabled', true);
        }
    }

    public boolean isOpportunitySalesInfoEnabled
    {
        get
        {
            return (Boolean)UTIL_AppSettings.getValue('Quote.IsSalesInfoEnabled', true);
        }
    }

    public boolean isOpportunityATPEnabled
    {
        get
        {
            return (Boolean)UTIL_AppSettings.getValue('Quote.IsAtpEnabled', true);
        }
    }

    public Boolean isRequestedShipEnabled
    {
        get
        {
            return UTIL_Quote.isRequestedShipEnabled;
        }
    }

    public Boolean isShipToAutoSearchEnabled
    {
        get
        {
            return (Boolean)UTIL_AppSettings.getValue('Quote.IsShipToAutoSearchEnabled', true);
        }
    }

    /*
    * On Receive from ShipTo Search
    */
    public CB_ShipToSearchReceiver shipToReceiver { get { return this; } }

    public void onReceiveShipToSearch(CTRL_ShipToSearch.ShipToSearchResult result)
    {
        logCallouts('onReceiveShipToSearch');

        this.ShipToPartner.CustomerNumber = result.shipToNumber;
        UpdateShipToPartner();
        List<SBO_EnosixQuote_Detail.ITEMS> itemList = this.quoteDetail.ITEMS.getAsList();
        Integer itemTot = itemList.size();
        List<SBO_EnosixQuote_Detail.ITEMS_ACTION> actionList = this.quoteDetail.ITEMS_ACTION.getAsList();
        Integer actionTot = actionList.size();
        for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
        {
            SBO_EnosixQuote_Detail.ITEMS item = itemList[itemCnt];
            item.Plant = '';
            item.ShippingPoint = '';
            item.ItemCategory = '';

            SBO_EnosixQuote_Detail.ITEMS_ACTION itemAction = new SBO_EnosixQuote_Detail.ITEMS_ACTION();
            itemAction.ItemNumber = item.ItemNumber;
            itemAction.ItemChanged = true;

            //Check if there's an Item Action already available for the item, mainly for order create
            for (Integer actionCnt = 0 ; actionCnt < actionTot ; actionCnt++)
            {
                SBO_EnosixQuote_Detail.ITEMS_ACTION action = actionList[actionCnt];
                if (item.ItemNumber == action.ItemNumber)
                {
                    itemAction = null;
                    break;
                }
            }
            if (itemAction != null)
            {
                this.quoteDetail.ITEMS_ACTION.add(itemAction);
            }
        }
        this.updateSalesAreas();
    }

    /*
    * On Receive from Material Search
    */
    public CB_MaterialSearchReceiver msReceiver { get {return this;} }

    public void onReceiveMaterialSearchResults(string id, List<CTRL_MaterialSearch.MaterialSearchResult> results)
    {
        logCallouts('onReceiveMaterialSearchResults');
        addSelectedMaterialsAsItems(results);
    }

    public void addSelectedMaterialsAsItems(List<CTRL_MaterialSearch.MaterialSearchResult> materials)
    {
        List<SBO_EnosixQuote_Detail.ITEMS> items = new List<SBO_EnosixQuote_Detail.ITEMS>();
        // Validate all items first
        Integer matTot = materials.size();
        for (Integer matCnt = 0 ; matCnt < matTot ; matCnt++)
        {
            CTRL_MaterialSearch.MaterialSearchResult material = materials[matCnt];
            SBO_EnosixQuote_Detail.ITEMS item = new SBO_EnosixQuote_Detail.ITEMS();
            item.Material = material.material.Material;
            item.ItemDescription = material.material.MaterialDescription;
            item.ScheduleLineDate = material.scheduleDate;
            if (item.ScheduleLineDate == null)
            {
                item.ScheduleLineDate = this.quoteDetail.SALES.RequestedDeliveryDate;
            }
            item.OrderQuantity = material.quantity;
            items.add(item);
        }
        this.addItemsToQuote(items);

        List<SBO_EnosixQuote_Detail.ITEMS> itemList = this.quoteDetail.ITEMS.getAsList();
        Integer itemTot = itemList.size();
        List<SBO_EnosixQuote_Detail.ITEMS_ACTION> actionList = this.quoteDetail.ITEMS_ACTION.getAsList();
        Integer actionTot = actionList.size();
        for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
        {
            SBO_EnosixQuote_Detail.ITEMS item = itemList[itemCnt];
            SBO_EnosixQuote_Detail.ITEMS_ACTION itemAction = new SBO_EnosixQuote_Detail.ITEMS_ACTION();
            itemAction.ItemNumber = item.ItemNumber;
            itemAction.ItemChanged= true;
            for (Integer actionCnt = 0 ; actionCnt < actionTot ; actionCnt++)
            {
                SBO_EnosixQuote_Detail.ITEMS_ACTION action = actionList[actionCnt];
                if (action.ItemNumber == item.ItemNumber)
                {
                    itemAction = null;
                    break;
                }
            }
            if (itemAction != null)
            {
                this.quoteDetail.ITEMS_ACTION.add(itemAction);
            }
        }

        this.SimulateQuote();
    }

    public String sapCustomerNumber { private get; set; }

    private transient SBO_EnosixCustomer_Detail.EnosixCustomer t_soldToCustomer;
    public SBO_EnosixCustomer_Detail.EnosixCustomer soldToCustomer
    {
        get
        {
            if (null == t_soldToCustomer)
            {
                if (string.isNotEmpty(sapCustomerNumber))
                {
                    t_soldToCustomer = UTIL_Customer.getCustomerByNumber(sapCustomerNumber);
                }
            }
            return t_soldToCustomer;
        }
        set
        {
            t_soldToCustomer = value;
        }
    }

    private transient SBO_EnosixCustomer_Detail.EnosixCustomer t_shipToCustomer;
    public SBO_EnosixCustomer_Detail.EnosixCustomer shipToCustomer
    {
        get
        {
            if (null == t_shipToCustomer)
            {
                t_shipToCustomer = UTIL_Customer.getCustomerByNumber(ShipToPartner.CustomerNumber);
            }
            return t_shipToCustomer;
        }
        set
        {
            t_shipToCustomer = value;
        }
    }

    private transient SBO_EnosixCustomer_Detail.EnosixCustomer t_contactCustomer;
    public SBO_EnosixCustomer_Detail.EnosixCustomer contactCustomer
    {
        get
        {
            if (null == t_contactCustomer)
            {
                t_contactCustomer = UTIL_Customer.getCustomerByNumber(ContactPartner.CustomerNumber);
            }
            return t_contactCustomer;
        }
        set
        {
            t_contactCustomer = value;
        }
    }

    @testVisible
    private Map<String, UTIL_Quote.QuoteLineValue> quoteLineValueMap = new Map<String, UTIL_Quote.QuoteLineValue>();

    private boolean isValidMaterials = true;
    private boolean isNeedSboReset = true;

    @testVisible
    public Boolean canSaveQuote { get; private set; }

    public boolean canQuotePrices
    {
        get
        {
            return null != this.soldToCustomer && isValidMaterials;
        }
    }

    public string pathMaterialDetail
    {
        get
        {
            return UTIL_PageFlow.getPageURL(UTIL_PageFlow.VFP_MaterialDetail);
        }
    }

    // ctor()
    public CTRL_OpportunityQuotePricing()
    {
        logCallouts('CTRL_OpportunityQuotePricing');

        isNeedSboReset = true;
        this.canSaveQuote = true;
        UTIL_SFSObjectDoc.initObjects(calledFrom);
        this.sfsObject = UTIL_SFSObjectDoc.sfsObject;
        this.sapCustomerNumber = UTIL_SFSObjectDoc.sapCustomerNumber;
        this.initConditions = new List<SBO_EnosixQuote_Detail.CONDITIONS>();

        if (this.opp == null)
        {
            ApexPages.addMessage(new Apexpages.Message(
                ApexPages.Severity.ERROR, 'Unable to create an Opportunity for this Account.'));
        }
        else
        {
            this.quoteDetail = new SBO_EnosixQuote_Detail.EnosixQuote();

            if ((this.salesData.SalesDocumentType == null || this.salesData.SalesDocumentType == '') && OrderTypes.size() > 0)
            {
                this.salesData.SalesDocumentType = OrderTypes.get(0).getValue();
            }

            if (null == this.soldToCustomer)
            {
                ApexPages.addMessage(new Apexpages.Message(
                    ApexPages.Severity.ERROR, 'Opportunity account not configured as SAP Customer.'));
                return;
            }

            setIncrement();
            UpdateShipToPartner();
            UTIL_Quote.initializeQuoteFromSfSObject(calledFrom, this.sfSObject, this.quoteDetail, this.sfSObjectLineIdMap, this.quoteLineValueMap, this.itemIncrement);
            this.initConditions = this.quoteDetail.CONDITIONS.getAsList();

            if (!String.isEmpty(UTIL_PageState.current.sapAddPartnerTo) && !String.isEmpty(UTIL_PageState.current.sapShipToNum))
            {
                this.shipToCustomer = null;
                this.soldToCustomer = null;
                this.SoldToPartner.CustomerNumber = UTIL_PageState.current.sapAddPartnerTo;
                this.ShipToPartner.CustomerNumber = UTIL_PageState.current.sapShipToNum;
                this.quoteDetail.Sales.SalesOrganization = '';
                this.quoteDetail.Sales.DistributionChannel = '';
                this.quoteDetail.Sales.Division = '';
                if (!String.isEmpty(UTIL_PageState.current.sapSalesArea))
                {
                    this.quoteDetail.Sales.SalesOrganization = UTIL_PageState.current.sapSalesArea.split(',')[0];
                    this.quoteDetail.Sales.DistributionChannel = UTIL_PageState.current.sapSalesArea.split(',')[1];
                    this.quoteDetail.Sales.Division = UTIL_PageState.current.sapSalesArea.split(',')[2];
                }
            }
            this.updateSalesAreas();
        }
    }

    /* List of line items displayed */
    public List<UTIL_Quote.QuoteItem> displayedMaterialItems
    {
        get
        {
           if (displayedMaterialItems== null)
            {
                displayedMaterialItems = UTIL_Quote.convertQuoteDetailToQuoteItem(this.quoteDetail, this.quoteLineValueMap, this.itemIncrement);
            }
            return displayedMaterialItems;
        }

        private set;
    }

    /* Quote Total */
    public Decimal netOpportunityPrice
    {
        get
        {
            Decimal result = 0.0;

            if (null != this.quoteDetail)
            {
                result = this.quoteDetail.NetOrderValue;
            }
            return result;
        }
    }

    public SBO_EnosixQuote_Detail.EnosixQuote quoteDetail { get; set; }

    @testVisible
    private List<SBO_EnosixQuote_Detail.CONDITIONS> initConditions { get; set; }

    public SBO_EnosixQuote_Detail.SALES salesData
    {
        get
        {
            if (quoteDetail == null) return null;
            return quoteDetail.SALES;
        }
    }

    @testVisible
    private static List<string> master_DocumentCategoryTypes
    {
        get
        {
            return new string[]
            {
                'B'
                , '*'
            };
        }
    }

    @testVisible
    private static List<string> master_DocumentTypes
    {
        get
        {
            return (List<String>)UTIL_AppSettings.getList(
                'Opportunity.DocumentTypes', String.class, new List<String>{ 'QT' });
        }
    }

    private transient RFC_SD_GET_CURRENCY_LIST.RESULT t_rfcCurrencyList;
    @testVisible
    private RFC_SD_GET_CURRENCY_LIST.RESULT rfcCurrencyList
    {
        get
        {
            if (null == t_rfcCurrencyList)
            {
                RFC_SD_GET_CURRENCY_LIST rfc = new RFC_SD_GET_CURRENCY_LIST();
                t_rfcCurrencyList = rfc.execute();
                if (!t_rfcCurrencyList.isSuccess())
                {
                    UTIL_ViewHelper.displayResultMessages(t_rfcCurrencyList.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
                }
            }
            return t_rfcCurrencyList;
        }
    }

    public String customerCurrency
    {
        get
        {
            if (this.soldToCustomer != null && this.soldToCustomer.SALES_DATA.getAsList().size() > 0) 
            {
                return this.soldToCustomer.SALES_DATA.getAsList().get(0).CurrencyKey;
            }
            return '';
        }
    }

    public List<SelectOption> CurrencyOptions
    {
        get
        {
            List<String> currencyList = (List<String>)UTIL_AppSettings.getList(
                'SalesOrganization.CurrencyKey.' + quoteDetail.Sales.SalesOrganization, String.class, null);

            List<SelectOption> result = new List<SelectOption>();

            List<RFC_SD_GET_CURRENCY_LIST.ET_CURRENCY> currList = this.rfcCurrencyList.ET_CURRENCY_List;
            Integer currTot = currList.size();
            Integer currTot2 = currencyList == null ? 0 : currencyList.size();
            for (Integer currCnt = 0 ; currCnt < currTot ; currCnt++)
            {
                RFC_SD_GET_CURRENCY_LIST.ET_CURRENCY rfcItem = currList[currCnt];
                Boolean isValid = currencyList == null;
                if (!isValid)
                {
                    for (Integer currCnt2 = 0 ; currCnt2 < currTot2 ; currCnt++)
                    {
                        String currencyItem = currencyList[currCnt2];
                        if (currencyItem == rfcItem.FieldCurrency)
                        {
                            isValid = true;
                            break;
                        }
                    }
                }
                if (isValid)
                {
                    SelectOption currencyOption =
                        new SelectOption(rfcItem.FieldCurrency,
                            String.format(UTIL_SelectOption.dropDownDescriptionFormat,
                                new String[]{rfcItem.FieldCurrency, rfcItem.LTEXT}));

                    result.add(currencyOption);
                }
            }

            return result;
        }
    }

    public Boolean isCurrencyDisabled
    {
        get
        {
            return (CurrencyOptions.size() < 2);
        }
    }

    @testVisible
    private String defaultSalesOrg
    {
        get
        {
            return (String)UTIL_AppSettings.getValue('Opportunity.DefaultSalesOrg','');
        }
    }

    public List<SelectOption> OrderTypes
    {
        get
        {
            List<SelectOption> result = new List<SelectOption>();
            if (null != UTIL_Quote.docTypeMaster)
            {
                UTIL_RFC.AddDocTypesOfCategory(
                    result, 
                    UTIL_Quote.docTypeMaster.ET_OUTPUT_List, 
                    master_DocumentCategoryTypes, 
                    master_DocumentTypes);
            }
            result.sort();
            return result;
        }
    }

    public List<SelectOption> SalesOrganizations
    {
        get
        {
            List<SelectOption> result = new List<SelectOption>();
            if (null != this.soldToCustomer)
            {
                UTIL_Customer.AddSalesOrganizations(
                    result, 
                    UTIL_Customer.getSalesDataListFromCustomer(this.soldToCustomer));
            }
            result.sort();
            return result;
        }
    }

    public List<SelectOption> DistributionChannels
    {
        get
        {
            List<SelectOption> result = new List<SelectOption>();
            if (null != this.soldToCustomer && null != this.quoteDetail)
            {
                UTIL_Customer.AddDistributionChannels(
                    result, 
                    UTIL_Customer.getSalesDataListFromCustomer(this.soldToCustomer), 
                    this.salesData.SalesOrganization);
            }

            return result;
        }
    }

    public List<SelectOption> Divisions
    {
        get
        {
            List<SelectOption> result = new List<SelectOption>();

            if (null != this.soldToCustomer && null != this.quoteDetail)
            {
                UTIL_Customer.AddDistributionDivisions(
                    result, 
                    UTIL_Customer.getSalesDataListFromCustomer(this.soldToCustomer), 
                    this.salesData.SalesOrganization, 
                    this.salesData.DistributionChannel);
            }

            return result;
        }
    }

    public List<SelectOption> SoldToPartners
    {
        get
        {
            List<SelectOption> result = new List<SelectOption>();
            if (null != this.soldToCustomer && null != this.quoteDetail)
            {
                UTIL_Customer.AddPartners(
                    result, 
                    UTIL_Customer.getCustomerPartners(this.soldToCustomer, UTIL_Customer.SOLD_TO_PARTNER_CODE),
                    this.quoteDetail.Sales.SalesOrganization, 
                    this.quoteDetail.Sales.DistributionChannel, 
                    this.quoteDetail.Sales.Division);
            }
            return result;
        }
    }

    public List<SelectOption> ShipToPartners
    {
        get
        {
            List<SelectOption> result = new List<SelectOption>();

            if (null != this.soldToCustomer && null != this.quoteDetail)
            {
                UTIL_Customer.AddPartners(
                    result, 
                    UTIL_Customer.getCustomerPartners(this.soldToCustomer, UTIL_Customer.SHIP_TO_PARTNER_CODE),
                    this.quoteDetail.Sales.SalesOrganization, 
                    this.quoteDetail.Sales.DistributionChannel, 
                    this.quoteDetail.Sales.Division);
            }
            return result;
        }
    }

    public Boolean isShipToPartnerAddressDisplayed
    {
        get
        {
            return UTIL_Order.isShipToPartnerAddressDisplayed;
        }
    }

    public SBO_EnosixQuote_Detail.PARTNERS SoldToPartner
    {
        get
        {
            return UTIL_Quote.getPartnerFromQuote(this.quoteDetail, UTIL_Customer.SOLD_TO_PARTNER_CODE, true);
        }
    }

    public SBO_EnosixQuote_Detail.PARTNERS ShipToPartner
    {
        get
        {
            return UTIL_Quote.getPartnerFromQuote(this.quoteDetail, UTIL_Customer.SHIP_TO_PARTNER_CODE, true);
        }
    }

    public SBO_EnosixQuote_Detail.PARTNERS ContactPartner
    {
        get
        {
            return UTIL_Quote.getPartnerFromQuote(this.quoteDetail, UTIL_Customer.CONTACT_PARTNER_CODE, true);
        }
    }

    public void UpdateShipToPartner()
    {
        this.shipToCustomer = null;
    }

    public void UpdateContactPartner()
    {
        this.contactCustomer = null;
    }

    // Set the default salesOrg
    @testVisible
    private void setDefaultSalesOrg(List<SelectOption> salesOrgs)
    {
        Integer soTot = salesOrgs.size();
        for (Integer soCnt = 0 ; soCnt < soTot ; soCnt++)
        {
            SelectOption option = salesOrgs[soCnt];
            if (option.getValue() == this.defaultSalesOrg)
            {
                this.salesData.SalesOrganization = option.getValue();
            }
        }
    }

    public List<SelectOption> PlantSelections
    {
        get
        {
            List<SelectOption> result = new List<SelectOption>();

            if (null != this.selectedMaterialDetail && null != this.quoteDetail)
            {
                AddPlantsFromMaterialDetail(result,
                    this.selectedMaterialDetail,
                    this.quoteDetail.Sales.SalesOrganization,
                    this.quoteDetail.Sales.DistributionChannel,
                    this.editItemNumber);
            }

            return result;
        }
    }

    public String itemPlant
    {
        get
        {
            List<SBO_EnosixQuote_Detail.ITEMS> itemList = this.quoteDetail.ITEMS.getAsList();
            Integer itemTot = itemList.size();
            for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
            {
                SBO_EnosixQuote_Detail.ITEMS item = itemList[itemCnt];
                if (item.ItemNumber == editItemNumber)
                {
                    return item.Plant;
                }
            }
            return null;
        }
        set
        {
            List<SBO_EnosixQuote_Detail.ITEMS> itemList = this.quoteDetail.ITEMS.getAsList();
            Integer itemTot = itemList.size();
            for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
            {
                SBO_EnosixQuote_Detail.ITEMS item = itemList[itemCnt];
                if (item.ItemNumber == editItemNumber)
                {
                    item.Plant = value;
                    break;
                }
            }
        }
    }

    public void SimulateQuote()
    {
        isValidMaterials = true;
        if (this.quoteDetail.ITEMS.size() > 0 || isNeedSboReset)
        {
            isNeedSboReset = this.quoteDetail.ITEMS.size() > 0;
            SBO_EnosixQuote_Detail sbo = new SBO_EnosixQuote_Detail();

            if (null != this.soldToCustomer)
            {
                quoteDetail.SoldToParty = this.soldToCustomer.CustomerNumber;
            }

            this.SoldToPartner.CustomerNumber = quoteDetail.SoldToParty;

            clearAllConditions(this.quoteDetail, this.initConditions);
            this.quoteDetail.SalesDocumentCurrency = this.quoteDetail.SALES.SalesDocumentCurrency;

            List<SBO_EnosixQuote_Detail.PARTNERS> partnerList = this.quoteDetail.PARTNERS.getAsList();
            Integer partnerTot = partnerList.size();
            for (Integer partnerCnt = 0 ; partnerCnt < partnerTot ; partnerCnt++)
            {
                SBO_EnosixQuote_Detail.PARTNERS partner = partnerList[partnerCnt];
                if (String.isEmpty(partner.CustomerNumber))
                {
                    this.quoteDetail.PARTNERS.remove(partner);
                }
            }

            DateTime startSimulate = System.now();
            System.debug('Start Simulate '+ startSimulate);

            SBO_EnosixQuote_Detail.EnosixQuote result = sbo.command('CMD_SIMULATE_QUOTE', quoteDetail);

            DateTime endSimulate = System.now();
            System.debug('End Simulate '+ endSimulate);
            System.debug('MilliSecond Simulate ' + (endSimulate.getTime() - startSimulate.getTime()));

            if (result.isSuccess())
            {
                String saveSalesDocument = quoteDetail.SalesDocument;

                this.quoteDetail.SalesDocument = saveSalesDocument;
            }

            this.quoteDetail = result;
            UTIL_ViewHelper.displayResultMessages(result.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);

            isValidMaterials = true;
            List<SBO_EnosixQuote_Detail.ITEMS> itemList = this.quoteDetail.ITEMS.getAsList();
            Integer itemTot = itemList.size();
            for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
            {
                SBO_EnosixQuote_Detail.ITEMS item = itemList[itemCnt];
                if (null == item.NetItemPrice)
                {
                    isValidMaterials = false;
                    ApexPages.addMessage(new Apexpages.Message(
                        ApexPages.Severity.ERROR, '"' + item.ItemDescription + '" material missing Item Price in SAP'));
                    break;
                }
            }
        }
        
        displayedMaterialItems = null;
    }

    // clearAllCondition()
    //
    // Clear all conditions in the collection before quote creation
    @testVisible
    private static void clearAllConditions(SBO_EnosixQuote_Detail.EnosixQuote quote, List<SBO_EnosixQuote_Detail.CONDITIONS> initConditions)
    {
        quote.CONDITIONS.clear();
        if (initConditions.size() > 0)
        {
            quote.CONDITIONS.addAll(initConditions);
        }
    }

    @testVisible
    private static void AddPlantsFromMaterialDetail(List<SelectOption> result,
        SBO_EnosixMaterial_Detail.EnosixMaterial material,
        string salesOrganization, string distributionChannel, string editItemNumber)
    {
        Set<string> values = new Set<string>();

        List<SBO_EnosixMaterial_Detail.PLANT_DATA> plantList = material.PLANT_DATA.getAsList();
        Integer plantTot = plantList.size();
        for (Integer plantCnt = 0 ; plantCnt < plantTot ; plantCnt++)
        {
            SBO_EnosixMaterial_Detail.PLANT_DATA plant = plantList[plantCnt];
            if (!values.contains(plant.Plant) && 
                plant.SalesOrganization.equalsIgnoreCase(salesOrganization) && 
                plant.DistributionChannel.equalsIgnoreCase(distributionChannel))
            {
                result.add(new SelectOption(plant.Plant,
                    String.format(UTIL_SelectOption.dropDownDescriptionFormat,
                    new String[]{plant.Plant, plant.Name})));
                values.add(plant.Plant);
            }
        }

        if (!values.contains('') && editItemNumber != null && result.size() > 0)
        {
            result.add(0, new SelectOption('',''));
        }
    }

    public boolean isValid()
    {
        boolean valid = true;
        if (this.quoteDetail.ITEMS.size() == 0)
        {
            ApexPages.addMessage(new Apexpages.Message(
                ApexPages.Severity.ERROR, 'There must be at least one Material added to the Opportunity'));
            valid = false;
        }
        return valid;
    }

    public void updateSalesAreas()
    {
        logCallouts('updateSalesAreas');

        if (null != this.quoteDetail)
        {
            validateSalesAreas();
            this.SimulateQuote();
        }
    }

    private void validateSalesAreas()
    {
        if (!isValidSalesData(this.quoteDetail.Sales.SalesOrganization, SalesOrganizations))
        {
            this.quoteDetail.Sales.SalesOrganization = UTIL_ViewHelper.pickFirst(SalesOrganizations);
            if (this.SalesOrganizations.size() > 1)
            {
                setDefaultSalesOrg(this.SalesOrganizations);
            }
        }

        if (!isValidSalesData(this.quoteDetail.Sales.DistributionChannel, DistributionChannels))
        {
            this.quoteDetail.SALES.DistributionChannel = UTIL_ViewHelper.pickFirst(DistributionChannels);
        }

        if (!isValidSalesData(this.quoteDetail.Sales.Division, Divisions))
        {
            this.quoteDetail.SALES.Division = UTIL_ViewHelper.pickFirst(Divisions);
        }

        if (!isValidSalesData(this.quoteDetail.Sales.SalesDocumentCurrency, CurrencyOptions))
        {
            this.quoteDetail.SALES.SalesDocumentCurrency = customerCurrency;

            if (!isValidSalesData(this.quoteDetail.Sales.SalesDocumentCurrency, CurrencyOptions))
            {
                this.quoteDetail.Sales.SalesDocumentCurrency = UTIL_ViewHelper.pickFirst(CurrencyOptions);
            }
        }

        if (!isValidSalesData(this.SoldToPartner.CustomerNumber, SoldToPartners))
        {
            this.SoldToPartner.CustomerNumber = UTIL_ViewHelper.pickFirst(SoldToPartners);
        }

        if (!isValidSalesData(this.ShipToPartner.CustomerNumber, ShipToPartners))
        {
            this.ShipToPartner.CustomerNumber = UTIL_ViewHelper.pickFirst(ShipToPartners);
            UpdateShipToPartner();
        }

        if (!isValidSalesData(this.ContactPartner.CustomerNumber, ContactPartners))
        {
            this.ContactPartner.CustomerNumber = UTIL_ViewHelper.pickFirst(ContactPartners);
            UpdateContactPartner();
        }
    }

    @testVisible
    private Boolean isValidSalesData(String salesId, List<SelectOption> selectOptions)
    {
        Boolean isValid = false;
        if (!String.isEmpty(salesId))
        {
            Integer soTot = selectOptions.size();
            for (Integer soCnt = 0 ; soCnt < soTot ; soCnt++)
            {
                SelectOption option = selectOptions[soCnt];
                if (option.getValue() == salesId)
                {
                    isValid = true;
                }
            }
        }
        return isValid;
    }

    public PageReference updateOpportunity()
    {
        logCallouts('updateOpportunity');

        if (!this.canSaveQuote)
        {
            return null;
        }

        if (!isValid())
        {
            return null;
        }

        if (!UTIL_Quote.finalizeQuoteAndUpdateSfSobject(calledFrom, this.opp, this.quoteDetail, this.sfSObjectLineIdMap))
        {
            return null;
        }
        return UTIL_PageFlow.redirectTo('/' + this.opp.Id, null);
    }

    private transient Integer t_itemIncrement;
    public Integer itemIncrement 
    { 
        get
        {
            if (t_itemIncrement == null)
            {
                setIncrement();
            }
            return itemIncrement;
        }

        private set; 
    }

    public void setIncrement()
    {
        //Default increment if nothing has been configured.
        itemIncrement = 10;

        RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT quoteMasterData = UTIL_Quote.getQuoteMasterData(this.quoteDetail.Sales.SalesDocumentType);

        if (null != quoteMasterData && string.isNotBlank(quoteMasterData.INCPO))
        {
            itemIncrement = Integer.valueOf(quoteMasterData.INCPO);
        }
    }

    public void removeItem()
    {
        logCallouts('removeItem');
        String itemNumber = System.currentPageReference().getParameters().get('removeItemNumber');

        UTIL_Quote.removeItemFromQuote(this.quoteDetail, itemNumber, this.initConditions, this.sfSObjectLineIdMap);

        this.SimulateQuote();
    }

    public void addItemsToQuote(List<SBO_EnosixQuote_Detail.ITEMS> items)
    {
        // Now that all the data is validated, we can actually add the items
        Integer itemTot = items.size();
        for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
        {
            SBO_EnosixQuote_Detail.ITEMS item = items[itemCnt];
            UTIL_Quote.addItemToQuote(this.quoteDetail, item, itemIncrement);
        }

        List<UTIL_Quote.QuoteItem> currentQuoteItems = this.displayedMaterialItems;
    }

    public String editActionElementId { get; set ; }
    public String editItemNumber { get; set; }
    public UTIL_Quote.QuoteItem editQuoteItem
    {
        get
        {
            Integer dmiTot = this.displayedMaterialItems.size();
            for (Integer dmiCnt = 0 ; dmiCnt < dmiTot ; dmiCnt++)
            {
                UTIL_Quote.QuoteItem quoteItem = this.displayedMaterialItems[dmiCnt];
                if (quoteItem.item.ItemNumber == this.editItemNumber)
                {
                    return quoteItem;
                }
            }
            return null;
        }
        set
        {
            Integer dmiTot = this.displayedMaterialItems.size();
            for (Integer dmiCnt = 0 ; dmiCnt < dmiTot ; dmiCnt++)
            {
                UTIL_Quote.QuoteItem quoteItem = this.displayedMaterialItems[dmiCnt];
                if (quoteItem.item.ItemNumber == this.editItemNumber)
                {
                    quoteItem = value;
                    break;
                }
            }
        }
    }

    @testVisible
    private SBO_EnosixQuote_Detail.ITEMS saveQuoteItem;

    public void editItem()
    {
        logCallouts('editItem');

        this.saveQuoteItem = null;
        this.editItemNumber = System.currentPageReference().getParameters().get('editItemNumber');
        this.editActionElementId = System.currentPageReference().getParameters().get('editActionElementId');
        if (editQuoteItem != null)
        {
            this.saveQuoteItem = new SBO_EnosixQuote_Detail.ITEMS();
            this.saveQuoteItem.ItemDescription = editQuoteItem.item.ItemDescription;
            this.saveQuoteItem.OrderQuantity = editQuoteItem.item.OrderQuantity;
            this.saveQuoteItem.NetItemPrice = editQuoteItem.item.NetItemPrice;
            this.saveQuoteItem.Plant = editQuoteItem.item.Plant;
            this.saveQuoteItem.ScheduleLineDate = editQuoteItem.item.ScheduleLineDate;
            this.selectedMaterialDetail = UTIL_Material.getMaterialFromMaterialNumber(editQuoteItem.item.Material);
        }
    }

    public void saveEditItem()
    {
        logCallouts('saveEditItem');

        SBO_EnosixQuote_Detail.ITEMS_ACTION itemAction = new SBO_EnosixQuote_Detail.ITEMS_ACTION();
        itemAction.ItemNumber = this.editItemNumber;
        itemAction.ItemChanged= true;

        List<SBO_EnosixQuote_Detail.ITEMS_ACTION> actionList = this.quoteDetail.ITEMS_ACTION.getAsList();
        Integer actionTot = actionList.size();
        for (Integer actionCnt = 0 ; actionCnt < actionTot ; actionCnt++)
        {
            SBO_EnosixQuote_Detail.ITEMS_ACTION action = actionList[actionCnt];
            if (action.ItemNumber == this.editItemNumber)
            {
                itemAction = null;
                if (!action.ItemAdded && !action.ItemDeleted)
                {
                    action.ItemAdded = false;
                    action.ItemChanged= true;
                    action.ItemDeleted = false;
                }
                break;
            }
        }
        if (itemAction != null)
        {
            this.quoteDetail.ITEMS_ACTION.add(itemAction);
        }
        if (String.isEmpty(editQuoteItem.item.Plant))
        {
            editQuoteItem.item.Plant = '';
            editQuoteItem.item.PlantName = '';
            editQuoteItem.item.ShippingPoint = '';
            editQuoteItem.item.ShippingPointDescription = '';
            editQuoteItem.item.Route = '';
            editQuoteItem.item.RouteDescription = '';
        }

        this.editItemNumber = null;
        this.saveQuoteItem = null;
        this.SimulateQuote();
    }

    public void cancelEditItem()
    {
        logCallouts('cancelEditItem');

        if (this.saveQuoteItem != null)
        {
            editQuoteItem.item.ItemDescription = this.saveQuoteItem.ItemDescription;
            editQuoteItem.item.OrderQuantity = this.saveQuoteItem.OrderQuantity;
            editQuoteItem.item.NetItemPrice = this.saveQuoteItem.NetItemPrice;
            editQuoteItem.item.Plant = this.saveQuoteItem.Plant;
            editQuoteItem.item.ScheduleLineDate = this.saveQuoteItem.ScheduleLineDate;
        }
        this.editItemNumber = null;
        this.saveQuoteItem = null;
    }
}