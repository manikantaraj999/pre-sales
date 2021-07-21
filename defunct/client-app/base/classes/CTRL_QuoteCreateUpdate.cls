public with sharing class CTRL_QuoteCreateUpdate implements CB_CMPCustomerSearchReceiver, CB_CMPPartnerSearchReceiver, CB_MaterialSearchReceiver 
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_QuoteCreateUpdate.class);
    public static final String calledFrom = 'CTRL_QuoteCreateUpdate';

    public void logCallouts(String location)
    {
        if ((Boolean)UTIL_AppSettings.getValue('CTRL_QuoteCreateUpdate.Logging', false))
        {
            logger.debug(location);
        }
    }

    @testVisible
    private Boolean isInit;
    public Boolean checkForClone { get; set; }

    @testVisible
    public Boolean isCreateMode { get; private set; }

    @testVisible
    public Boolean isUpdateMode { get; private set; }

    @testVisible
    public Boolean isCloneMode { get; private set; }

    @testVisible
    public Boolean isQuoteMode { get; private set; }

    public Boolean isAddMaterial { get { return UTIL_Quote.isAddMaterial; } }
    public Boolean isRemoveMaterial { get { return UTIL_Quote.isRemoveMaterial; } }
    public Boolean isEditMaterial { get { return UTIL_Quote.isEditMaterial; } }
    public Boolean isCloneMaterial { get { return UTIL_Quote.isCloneMaterial; } }
    public Boolean isMoveMaterial { get { return UTIL_Quote.isMoveMaterial; } }
    public Boolean isSelectMaterial { get { return UTIL_Quote.isSelectMaterial; } }

    public String opportunityId { get { return UTIL_PageState.current.sfOpportunityId; } }
    public String quoteRequestId { get { return UTIL_PageState.current.sfQuoteId; } }

    public String previousScreen
    {
        get
        {
            return UTIL_PageState.SAP_PreviousScreenQuote;
        }
    }

    public Boolean isClassic
    {
        get {return (UserInfo.getUiThemeDisplayed() == 'Theme3');}
    }

    @testVisible
    private SBO_EnosixMaterial_Detail.EnosixMaterial selectedMaterialDetail;
    @testVisible
    public SObject sfSObject { get; private set; }

    private Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap = new Map<String, UTIL_SFSObjectDoc.SfSObjectItem>();

    public Opportunity quoteOpportunity 
    { 
        get 
        {
            return UTIL_SFSObjectDoc.getOpportunity(sfSObject);
        }
    }

    public Boolean canSaveQuote { get; private set; }
    @testVisible
    public String quoteNumber { get; private set; }

    private transient SBO_EnosixCustomer_Detail.EnosixCustomer t_soldToCustomer;
    public SBO_EnosixCustomer_Detail.EnosixCustomer soldToCustomer
    {
        get
        {
            if (null == t_soldToCustomer)
            {
                if (null != this.quoteAccount)
                {
                    string customerId = UTIL_SFAccount.getCustomerNumberFromAccount(this.quoteAccount);
                    if (!string.isBlank(customerId))
                    {
                        SoldToPartner.CustomerNumber = customerId;
                        t_soldToCustomer = UTIL_Customer.getCustomerByNumber(customerId);
                    }
                    if (string.isBlank(customerId) || (t_soldToCustomer != null && t_soldToCustomer.SALES_DATA.size() == 0))
                    {
                        ApexPages.addMessage(new Apexpages.Message(
                            ApexPages.Severity.WARNING, 'This Account/SAP customer is not configured for quote creation'));
                    }
                }
                else
                {
                    t_soldToCustomer = UTIL_Customer.getCustomerByNumber(SoldToPartner.CustomerNumber);
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
            if (null == t_shipToCustomer && String.isNotEmpty(ShipToPartner.CustomerNumber))
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

    private transient SBO_EnosixCustomer_Detail.EnosixCustomer t_billToCustomer;
    public SBO_EnosixCustomer_Detail.EnosixCustomer billToCustomer
    {
        get
        {
            if (null == t_billToCustomer && String.isNotEmpty(BillToPartner.CustomerNumber))
            {
                t_billToCustomer = UTIL_Customer.getCustomerByNumber(BillToPartner.CustomerNumber);
            }
            return t_billToCustomer;
        }
        set
        {
            t_billToCustomer = value;
        }
    }

    private transient SBO_EnosixCustomer_Detail.EnosixCustomer t_payerCustomer;
    public SBO_EnosixCustomer_Detail.EnosixCustomer payerCustomer
    {
        get
        {
            if (null == t_payerCustomer && String.isNotEmpty(PayerPartner.CustomerNumber))
            {
                t_payerCustomer = UTIL_Customer.getCustomerByNumber(PayerPartner.CustomerNumber);
            }
            return t_payerCustomer;
        }
        set
        {
            t_payerCustomer = value;
        }
    }

    private transient SBO_EnosixCustomer_Detail.EnosixCustomer t_contactCustomer;
    public SBO_EnosixCustomer_Detail.EnosixCustomer contactCustomer
    {
        get
        {
            if (null == t_contactCustomer && String.isNotEmpty(ContactPartner.CustomerNumber))
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

    public SBO_EnosixQuote_Detail.EnosixQuote quoteDetail { get; set; }

    @testVisible
    private List<SBO_EnosixQuote_Detail.CONDITIONS> initConditions { get; set; }
    @testVisible
    private Map<String, UTIL_Quote.QuoteLineValue> quoteLineValueMap = new Map<String, UTIL_Quote.QuoteLineValue>();

    @testVisible
    public Account quoteAccount { get; private set; }

	public boolean opportunityClosed
    {
        get
        {
            return this.quoteOpportunity != null && !isUpdateMode && this.quoteOpportunity.StageName.contains('Closed');
        }
    }

    public SBO_EnosixCustomer_Detail.SALES_DATA customerSalesData
    {
        get
        {
            return this.soldToCustomer == null || this.soldToCustomer.SALES_DATA.getAsList().size() == 0 ? new SBO_EnosixCustomer_Detail.SALES_DATA() : (SBO_EnosixCustomer_Detail.SALES_DATA) this.soldToCustomer.SALES_DATA.get(0);
        }
        set
        {
            SBO_EnosixCustomer_Detail.SALES_DATA salesData = 
                (SBO_EnosixCustomer_Detail.SALES_DATA) this.soldToCustomer.SALES_DATA.get(0);
            salesData = value;
        }
    }

    public SBO_EnosixCustomer_Detail.COMPANY_DATA companyData
    {
        get
        {
            return this.soldToCustomer == null || this.soldToCustomer.COMPANY_DATA.getAsList().size() == 0 ? new SBO_EnosixCustomer_Detail.COMPANY_DATA() : (SBO_EnosixCustomer_Detail.COMPANY_DATA) this.soldToCustomer.COMPANY_DATA.get(0);
        }
        set
        {
            SBO_EnosixCustomer_Detail.COMPANY_DATA codata = 
                (SBO_EnosixCustomer_Detail.COMPANY_DATA) this.soldToCustomer.COMPANY_DATA.get(0);
            codata = value;
        }
    }

    public static string pickDefaultQuoteType(List<SelectOption> selectOptions)
    {
        Integer soTot = selectOptions.size();
        for (Integer soCnt = 0 ; soCnt < soTot ; soCnt++)
        {
            SelectOption option = selectOptions[soCnt];
            if (option.getValue() == master_DocumentTypes.get(0))
            {
                return option.getValue();
            }
        }
        return '';
    }

    @testVisible
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

    public string sapCustomerNumber { private get; set; }

    public string pathMaterialDetail
    {
        get
        {
            return UTIL_PageFlow.getPageURL(UTIL_PageFlow.VFP_MaterialDetail);
        }
    }

    public Boolean isRequestedShipEnabled
    {
        get
        {
            return UTIL_Quote.isRequestedShipEnabled;
        }
    }

    public String returnToId {
        get {
            if (null == returnToId)
            {
                if (null != this.sfsObject) returnToId = this.sfsObject.Id;
                else if (null != this.quoteAccount) returnToId = this.quoteAccount.Id;
            }
            return returnToId;
        }
        private set;
    }

    public String returnToName {
        get {
            if (null == returnToName)
            {
                if (null != this.sfsObject) returnToName = (String) this.sfsObject.get('Name');
                else if (null != this.quoteAccount) returnToName = this.quoteAccount.Name;
                
            }
            return returnToName;
        }
        private set;
    }

    public String returnToAccountName {
        get {
            if (null == returnToAccountName && null != this.quoteAccount)
            {
                returnToAccountName = this.quoteAccount.Name;
            }
            return returnToAccountName;
        }
        private set;
    }

    public CTRL_QuoteCreateUpdate()
    {
        logCallouts('CTRL_QuoteCreateUpdate');
        this.quoteDetail = new SBO_EnosixQuote_Detail.EnosixQuote();
        this.initConditions = new List<SBO_EnosixQuote_Detail.CONDITIONS>();
        this.quoteNumber = UTIL_PageState.current.sapQuoteId;
        this.isCreateMode = (UTIL_PageState.current.sapMode == UTIL_PageState.SAP_ModeCreate);
        this.isUpdateMode = (UTIL_PageState.current.sapMode == UTIL_PageState.SAP_ModeUpdate);
        this.isCloneMode = (UTIL_PageState.current.sapMode == UTIL_PageState.SAP_ModeClone);
        this.isQuoteMode = (UTIL_PageState.current.sapMode == UTIL_PageState.SAP_ModeQuote);

        this.checkForClone = false;
        this.isInit = true;

        init();

        if (!String.isEmpty(UTIL_PageState.current.sapAddPartnerTo) || !String.isEmpty(UTIL_PageState.current.sapShipToNum))
        {
            if (!String.isEmpty(UTIL_PageState.current.sapAddPartnerTo))
            {
                this.soldToCustomer = null;
                this.SoldToPartner.CustomerNumber = UTIL_PageState.current.sapAddPartnerTo;
            }
            if (!String.isEmpty(UTIL_PageState.current.sapShipToNum))
            {
                this.shipToCustomer = null;
                this.ShipToPartner.CustomerNumber = UTIL_PageState.current.sapShipToNum;
            }
            this.quoteDetail.Sales.SalesOrganization = '';
            this.quoteDetail.Sales.DistributionChannel = '';
            this.quoteDetail.Sales.Division = '';
            if (!String.isEmpty(UTIL_PageState.current.sapSalesArea))
            {
                this.quoteDetail.Sales.SalesOrganization = UTIL_PageState.current.sapSalesArea.split(',')[0];
                this.quoteDetail.Sales.DistributionChannel = UTIL_PageState.current.sapSalesArea.split(',')[1];
                this.quoteDetail.Sales.Division = UTIL_PageState.current.sapSalesArea.split(',')[2];
            }
            updateSalesAreas();
        }

        this.isInit = false;
    }

    @testVisible
    private void init()
    {
        UTIL_SFSObjectDoc.initObjects(calledFrom);
        this.sapCustomerNumber = UTIL_SFSObjectDoc.sapCustomerNumber;
        this.sfsObject = UTIL_SFSObjectDoc.sfsObject;
        this.quoteAccount = UTIL_SFSObjectDoc.sfAccount;

        this.canSaveQuote = true;

        if (isQuoteMode)
        {
            this.quoteNumber = !String.isEmpty(this.quoteNumber) ? this.quoteNumber : UTIL_SFSObjectDoc.getQuoteNumber(this.sfsObject);
            if (!String.isEmpty(this.quoteNumber))
            {
                this.isUpdateMode = true;
            }
            else
            {
                this.isCreateMode = true;
            }
        }

        initMode();
    }

    public void initMode()
    {
        logCallouts('initMode');
        if (isUpdateMode || isCloneMode)
        {
            if (String.isEmpty(this.quoteNumber))
            {
                if (isUpdateMode)
                {
                    ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'No SAP Quote Id to Update'));
                }
                else if (isCloneMode)
                {
                    ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'No SAP Quote Id to Clone'));
                }
                canSaveQuote = false;
                this.quoteAccount = null;
                this.sfSObject = null;
                return;
            }

            if (isUpdateMode)
            {
                initUpdate();
            }
            else if (isCloneMode)
            {
                initClone();
            }
        }
        else
        {
           initCreate();
        }
    }

    // initUpdate
    //
    // Initialize for quote edit screen
    public void initUpdate()
    {
        this.quoteDetail = null;
        this.SimulateQuote();
        List<SBO_EnosixQuote_Detail.ITEMS> itemList = this.quoteDetail.ITEMS.getAsList();
        Integer itemTot = itemList.size();
        for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
        {
            SBO_EnosixQuote_Detail.ITEMS item = itemList[itemCnt];
            SBO_EnosixQuote_Detail.ITEMS_ACTION itemAction = new SBO_EnosixQuote_Detail.ITEMS_ACTION();
            itemAction.ItemNumber = item.ItemNumber;
            itemAction.ItemChanged = true;
            this.quoteDetail.ITEMS_ACTION.add(itemAction);
        }

        UTIL_Quote.loadSfsObjectLineIdMapFromQuote(calledFrom, this.sfSObject, this.quoteDetail, this.sfSObjectLineIdMap);
        setIncrement();
        this.SoldToPartner.CustomerNumber = this.quoteDetail.SoldToParty;

        UpdateShipToPartner();
        this.billToCustomer = null;
        this.payerCustomer = null;

        List<SBO_EnosixQuote_Detail.PARTNERS> partnerList = this.quoteDetail.PARTNERS.getAsList();
        Integer partnerTot = partnerList.size();
        for (Integer partnerCnt = 0 ; partnerCnt < partnerTot ; partnerCnt++)
        {
            SBO_EnosixQuote_Detail.PARTNERS partner = partnerList[partnerCnt];
            if (partner.PartnerFunction == UTIL_Customer.SHIP_TO_PARTNER_CODE)
            {
                this.ShipToPartner.CustomerNumber = partner.CustomerNumber;
            }
        }

        UTIL_PageMessages.displayOnVfp();
    }

    // initClone
    //
    // Initialize for quote clone screen
    public void initClone()
    {
        this.checkForClone = true;
    }

    public void loadClonedRecord()
    {
        if (String.isNotEmpty(this.quoteNumber))
        {
            List<SBO_EnosixQuote_Detail.PARTNERS> partnerList = this.quoteDetail.PARTNERS.getAsList();
            Integer partnerTot = partnerList.size();
            for (Integer partnerCnt = 0 ; partnerCnt < partnerTot ; partnerCnt++)
            {
                SBO_EnosixQuote_Detail.PARTNERS partner = partnerList[partnerCnt];
                if (String.isEmpty(partner.CustomerNumber) && String.isEmpty(partner.Vendor)
                    && (partner.PersonnelNumber == null
                    || String.isEmpty(partner.PersonnelNumber.replaceFirst('^0+(?!$)', '')))
                    && (partner.ContactPersonNumber == null
                    || String.isEmpty(partner.ContactPersonNumber.replaceFirst('^0+(?!$)', ''))))
                {
                    this.quoteDetail.PARTNERS.remove(partner);
                }
            }

            SBO_EnosixQuote_Detail sbo = new SBO_EnosixQuote_Detail();
            this.quoteDetail.QUOTE_ACTION.CreateQuoteWithReference = true;
            this.quoteDetail.QUOTE_ACTION.ReferenceDocumentNumber = this.quoteNumber;
            this.quoteDetail.QUOTE_ACTION.ReferenceDocumentType = this.quoteDetail.SALES.SalesDocumentType;
            SBO_EnosixQuote_Detail.EnosixQuote result = sbo.command('CMD_FILL_REF_DOC_DETAILS', this.quoteDetail);
            if (result.isSuccess())
            {
                System.debug('Clone quote was a success');
            }
            result.SALES.SalesDocumentType = this.quoteDetail.SALES.SalesDocumentType;
            this.quoteDetail = result;
            UTIL_Quote.loadSfsObjectLineIdMapFromQuote(calledFrom, this.sfSObject, this.quoteDetail, this.sfSObjectLineIdMap);
            List<SBO_EnosixQuote_Detail.ITEMS> itemList = this.quoteDetail.ITEMS.getAsList();
            Integer itemTot = itemList.size();
            for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
            {
                SBO_EnosixQuote_Detail.ITEMS item = itemList[itemCnt];
                SBO_EnosixQuote_Detail.ITEMS_ACTION action = new SBO_EnosixQuote_Detail.ITEMS_ACTION();
                action.ItemNumber = item.ItemNumber;
                action.ItemAdded = true;
                this.quoteDetail.ITEMS_ACTION.add(action);
            }
            this.soldToCustomer = null;
            this.shipToCustomer = null;
            this.billToCustomer = null;
            this.payerCustomer = null;
            setIncrement();
            updateSalesAreas();
        }

        UTIL_PageMessages.displayOnVfp();
    }

    // initCreate
    //
    // Initialize for quote create screen
    public void initCreate()
    {
        // Copy over the customer Info
        if (null != this.soldToCustomer)
        {
            UTIL_Quote.CopyCustomerInfoToQuote(this.quoteDetail, this.soldToCustomer);
        }

        this.quoteDetail.SALES.SalesDocumentType = pickDefaultQuoteType(QuoteTypes);
        setIncrement();
        UpdateShipToPartner();
        this.billToCustomer = null;
        this.payerCustomer = null;

        UTIL_Quote.initializeQuoteFromSfSObject(calledFrom, this.sfSObject, this.quoteDetail, this.sfSObjectLineIdMap, this.quoteLineValueMap, itemIncrement);

        this.initConditions = this.quoteDetail.CONDITIONS.getAsList();

        validateSalesAreas();

        checkRequestedDate();

        Boolean isChanged = UTIL_Quote.updateQuotePricingFromSfsObject(calledFrom, this.sfsObject, this.quoteDetail, this.sfSObjectLineIdMap);

        if (isChanged) SimulateQuote();
    }

    public void updateSalesAreas()
    {
        logCallouts('updateSalesAreas');
        if (null != this.quoteDetail)
        {
            if (this.checkForClone && !this.isInit)
            {
                this.checkForClone = false;
                this.loadClonedRecord();
            }
            else
            {
                validateSalesAreas();
                this.SimulateQuote();
            }
        }
    }

    Private String lastSalesOrganization = '';
    Private String lastDistributionChannel = '';
    Private String lastDivision = '';

    @testVisible
    private void validateSalesAreas()
    {
        if (!isValidSalesData(this.quoteDetail.Sales.SalesOrganization, SalesOrganizations))
        {
            this.quoteDetail.Sales.SalesOrganization = UTIL_ViewHelper.pickFirst(SalesOrganizations);
        }

        if (!isValidSalesData(this.quoteDetail.Sales.DistributionChannel, DistributionChannels))
        {
            this.quoteDetail.SALES.DistributionChannel = UTIL_ViewHelper.pickFirst(DistributionChannels);
        }

        if (!isValidSalesData(this.quoteDetail.Sales.Division, Divisions))
        {
            this.quoteDetail.SALES.Division = UTIL_ViewHelper.pickFirst(Divisions);
        }

        if (lastSalesOrganization != this.quoteDetail.Sales.SalesOrganization ||
            lastDistributionChannel != this.quoteDetail.Sales.DistributionChannel ||
            lastDivision != this.quoteDetail.Sales.Division)
        {
            List<SBO_EnosixCustomer_Detail.SALES_DATA> salesList = this.soldToCustomer.SALES_DATA.getAsList();
            Integer salesTot = salesList.size();
            for (Integer salesCnt = 0 ; salesCnt < salesTot ; salesCnt++)
            {
                SBO_EnosixCustomer_Detail.SALES_DATA salesData = salesList[salesCnt];
                if (salesData.SalesOrganization == this.quoteDetail.Sales.SalesOrganization &&
                    salesData.DistributionChannel == this.quoteDetail.Sales.DistributionChannel &&
                    salesData.Division == this.quoteDetail.Sales.Division)
                {
                    this.quoteDetail.Sales.SalesOffice = salesData.SalesOffice;
                    this.quoteDetail.Sales.PriceListType = salesData.PriceListType;
                    this.quoteDetail.Sales.SalesDocumentCurrency = salesData.CurrencyKey;
                    break;
                }
            }

            if (lastSalesOrganization != this.quoteDetail.Sales.SalesOrganization ||
                lastDistributionChannel != this.quoteDetail.Sales.DistributionChannel)
            {
                resetItemPlantAndShipping();
            }

            lastSalesOrganization = this.quoteDetail.Sales.SalesOrganization;
            lastDistributionChannel = this.quoteDetail.Sales.DistributionChannel;
            lastDivision = this.quoteDetail.Sales.Division;
        }

        if (!isValidSalesData(this.quoteDetail.Sales.SalesDocumentCurrency, CurrencyOptions))
        {
            this.quoteDetail.SALES.SalesDocumentCurrency = customerCurrency;

            if (!isValidSalesData(this.quoteDetail.Sales.SalesDocumentCurrency, CurrencyOptions))
            {
                this.quoteDetail.Sales.SalesDocumentCurrency = UTIL_ViewHelper.pickFirst(CurrencyOptions);
            }
        }

        if (quoteAccount != null && !isValidSalesData(this.SoldToPartner.CustomerNumber, SoldToPartners))
        {
            this.SoldToPartner.CustomerNumber = UTIL_ViewHelper.pickFirst(SoldToPartners);
        }

        if (!isValidSalesData(this.ShipToPartner.CustomerNumber, ShipToPartners))
        {
            this.ShipToPartner.CustomerNumber = UTIL_ViewHelper.pickFirst(ShipToPartners);
            UpdateShipToPartner();
        }

        if (!isValidSalesData(this.BillToPartner.CustomerNumber, BillToPartners))
        {
            this.BillToPartner.CustomerNumber = UTIL_ViewHelper.pickFirst(BillToPartners);
            this.billToCustomer = null;
        }

        if (!isValidSalesData(this.PayerPartner.CustomerNumber, PayerPartners))
        {
            this.PayerPartner.CustomerNumber = UTIL_ViewHelper.pickFirst(PayerPartners);
            this.payerCustomer = null;
        }
    }

    private void resetItemPlantAndShipping()
    {
        List<SBO_EnosixQuote_Detail.ITEMS> itemList = this.quoteDetail.ITEMS.getAsList();
        Integer itemTot = itemList.size();
        List<SBO_EnosixQuote_Detail.ITEMS_ACTION> actionList = this.quoteDetail.ITEMS_ACTION.getAsList();
        Integer actionTot = actionList.size();
        for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
        {
            SBO_EnosixQuote_Detail.ITEMS item = itemList[itemCnt];
            item.Plant = '';
            item.StorageLocation = '';
            item.ShippingPoint = '';
            item.ItemCategory = '';

            SBO_EnosixQuote_Detail.ITEMS_ACTION itemAction = new SBO_EnosixQuote_Detail.ITEMS_ACTION();
            itemAction.ItemNumber = item.ItemNumber;
            itemAction.ItemChanged = true;

            //Check if there's an Item Action already available for the item, mainly for quote create
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

        if (this.editItemNumber != null)
        {
            this.saveQuoteItem.Plant = '';
            this.saveQuoteItem.ItemCategory = '';
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

    private static List<string> master_DocumentCategoryTypes
    {
        get
        {
            return new string[]{'B', '*'};
        }
    }

    private static List<string> master_DocumentTypes
    {
        get
        {
            return (List<String>)UTIL_AppSettings.getList(
                'Quote.DocumentTypes', String.class, new List<String>{ 'QT' });
        }
    }

    public List<SelectOption> QuoteTypes
    {
        get
        {
            List<SelectOption> result = new List<SelectOption>();
            if (null != UTIL_Quote.docTypeMaster)
            {
                UTIL_RFC.AddDocTypesOfCategory(result,
                    UTIL_Quote.docTypeMaster.ET_OUTPUT_List,
                    master_DocumentCategoryTypes,
                    master_DocumentTypes);
            }
            result.sort();
            if (result.size() > 0 && checkForClone)
            {
                result.add(0,new SelectOption('',''));
            }
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
                UTIL_Customer.AddSalesOrganizations(result, 
                    UTIL_Customer.getSalesDataListFromCustomer(this.soldToCustomer));
            }

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
                UTIL_Customer.AddDistributionChannels(result,
                    UTIL_Customer.getSalesDataListFromCustomer(this.soldToCustomer),
                    this.quoteDetail.Sales.SalesOrganization);
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
                UTIL_Customer.AddDistributionDivisions(result,
                    UTIL_Customer.getSalesDataListFromCustomer(this.soldToCustomer),
                    this.quoteDetail.Sales.SalesOrganization,
                    this.quoteDetail.Sales.DistributionChannel);
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

    public List<SelectOption> BillToPartners
    {
        get
        {
            List<SelectOption> result = new List<SelectOption>();

            if (null != this.soldToCustomer && null != this.quoteDetail)
            {
                UTIL_Customer.AddPartners(
                    result, 
                    UTIL_Customer.getCustomerPartners(this.soldToCustomer, UTIL_Customer.BILL_TO_PARTNER_CODE),
                    this.quoteDetail.Sales.SalesOrganization, 
                    this.quoteDetail.Sales.DistributionChannel, 
                    this.quoteDetail.Sales.Division);
            }
            return result;
        }
    }

    public List<SelectOption> PayerPartners
    {
        get
        {
            List<SelectOption> result = new List<SelectOption>();

            if (null != this.soldToCustomer && null != this.quoteDetail)
            {
                UTIL_Customer.AddPartners(
                    result, 
                    UTIL_Customer.getCustomerPartners(this.soldToCustomer, UTIL_Customer.PAYER_PARTNER_CODE),
                    this.quoteDetail.Sales.SalesOrganization, 
                    this.quoteDetail.Sales.DistributionChannel, 
                    this.quoteDetail.Sales.Division);
            }
            return result;
        }
    }

    private transient RFC_SD_GET_COUNTRIES.RESULT t_countries;
    RFC_SD_GET_COUNTRIES.RESULT countries
    {
        get
        {
            if (null == t_countries)
            {
                RFC_SD_GET_COUNTRIES rfc = new RFC_SD_GET_COUNTRIES();
                t_countries = rfc.execute();
                if (!t_countries.isSuccess())
                {
                    UTIL_ViewHelper.displayResultMessages(t_countries.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
                }
            }
            return t_countries;
        }
    }

    public List<SelectOption> CountryOptions
    {
        get
        {
            List<SelectOption> result = new List<SelectOption>();
            AddCountries(result, this.countries.ET_OUTPUT_List);
            UTIL_ViewHelper.sortOptionsByLabel(result);
            return result;
        }
    }

    public List<SelectOption> RegionOptions
    {
        get
        {
            return getRegionOptionsForCountry(ShipToPartner.Country);
        }
    }

    private List<SelectOption> getRegionOptionsForCountry(String country)
    {
        List<SelectOption> result = new List<SelectOption>();
        AddRegionsForCountry(result, this.countries.ET_REGIONS_List, country);
        UTIL_ViewHelper.sortOptionsByLabel(result);
        if (result != null && result.size() > 0)
        {
            result.add(0, new SelectOption('', 'Select One'));
        }
        return result;
    }

    @TestVisible
    private static void AddCountries(List<SelectOption> result, List<RFC_SD_GET_COUNTRIES.ET_OUTPUT> countries)
    {
        Integer countryTot = countries.size();
        for (Integer countryCnt = 0 ; countryCnt < countryTot ; countryCnt++)
        {
            RFC_SD_GET_COUNTRIES.ET_OUTPUT country = countries[countryCnt];
            String description = String.format(UTIL_SelectOption.dropDownDescriptionFormat, new String[]{country.LAND1, country.LANDX});
            result.add(new SelectOption(country.LAND1, country.LANDX == null ? country.LAND1 : description));
        }
    }

    @TestVisible
    private static void AddRegionsForCountry(
            List<SelectOption> result, List<RFC_SD_GET_COUNTRIES.ET_REGIONS> regions, String selectedCountry)
    {
        Integer regionTot = regions.size();
        for (Integer regionCnt = 0 ; regionCnt < regionTot ; regionCnt++)
        {
            RFC_SD_GET_COUNTRIES.ET_REGIONS region = regions[regionCnt];
            if (selectedCountry == region.LAND1 && string.isNotBlank(region.REGIO))
            {
                String description = String.format(UTIL_SelectOption.dropDownDescriptionFormat, new String[]{region.REGIO, region.BEZEI});
                result.add(new SelectOption(region.REGIO, region.BEZEI == null ? region.REGIO : description));
            }
        }
    }

    // Built List of shipping conditions
    private transient List<SelectOption> t_ItemCategories;
    public List<SelectOption> ItemCategories
    {
        get
        {
            if (null == t_ItemCategories && this.editQuoteItem != null)
            {
                t_ItemCategories = new List<SelectOption>();
                RFC_SD_GET_ITEMCAT_VALUES rfc = new RFC_SD_GET_ITEMCAT_VALUES();
                rfc.PARAMS.IV_AUART = this.quoteDetail.Sales.SalesDocumentType;
                rfc.PARAMS.IV_VKORG = this.quoteDetail.Sales.SalesOrganization;
                rfc.PARAMS.IV_VTWEG = this.quoteDetail.Sales.DistributionChannel;
                rfc.PARAMS.IV_MATNR = this.editQuoteItem.item.Material;
                RFC_SD_GET_ITEMCAT_VALUES.RESULT itemCatMaster = rfc.execute();
                if (itemCatMaster.isSuccess())
                {
                    List<SelectOption> tmpList = Util_SelectOption.buildOptionsFromList(
                        new UTIL_RFC.ItemCategoryOptionBuilder(),
                        itemCatMaster.ET_VALUES_List, false);
                    t_ItemCategories.addAll(UTIL_SelectOption.getOptionsByUniqueValue(tmpList));

                }
                else
                {
                    UTIL_ViewHelper.displayResultMessages(itemCatMaster.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
                }
            }
            return t_ItemCategories;
        }
        set
        {
            t_ItemCategories = value;
        }
    }

    public Boolean isShipToPartnerAddressDisplayed
    {
        get
        {
            return UTIL_Order.isShipToPartnerAddressDisplayed;
        }
    }

    public static final String SOLD_TO_PARTNER_CODE { get {return UTIL_Customer.SOLD_TO_PARTNER_CODE;} }
    public static final String SHIP_TO_PARTNER_CODE { get {return UTIL_Customer.SHIP_TO_PARTNER_CODE;} }
    public static final String BILL_TO_PARTNER_CODE { get {return UTIL_Customer.BILL_TO_PARTNER_CODE;} }
    public static final String PAYER_PARTNER_CODE { get {return UTIL_Customer.PAYER_PARTNER_CODE;} }
    public static final String CARRIER_PARTNER_CODE { get {return UTIL_Customer.CARRIER_PARTNER_CODE;} }

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

    public SBO_EnosixQuote_Detail.PARTNERS BillToPartner
    {
        get
        {
            return UTIL_Quote.getPartnerFromQuote(this.quoteDetail, UTIL_Customer.BILL_TO_PARTNER_CODE, true);
        }
    }

    public SBO_EnosixQuote_Detail.PARTNERS PayerPartner
    {
        get
        {
            return UTIL_Quote.getPartnerFromQuote(this.quoteDetail, UTIL_Customer.PAYER_PARTNER_CODE, true);
        }
    }

    public void UpdateShipToPartner()
    {
        this.shipToCustomer = null;
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

    private transient RFC_SD_GET_CURRENCY_LIST.RESULT t_rfcCurrencyList;
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
            if (null != this.soldToCustomer &&
                null != this.soldToCustomer.SALES_DATA &&
                this.soldToCustomer.SALES_DATA.getAsList().size() > 0)
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

    public String paymentTerm
    {
        get
        {
            return this.soldToCustomer.SALES_DATA.getAsList().get(0).TermsofPaymentKey + ' - ' + 
                this.soldToCustomer.SALES_DATA.getAsList().get(0).TermsofPaymentDescription;
        }
    }

    public void SimulateQuote()
    {
        logCallouts('SimulateQuote');
        displayedMaterialItems = null;
        SBO_EnosixQuote_Detail sbo = new SBO_EnosixQuote_Detail();
        if (isUpdateMode)
        {
            if (this.quoteDetail == null)
            {
                this.quoteDetail = UTIL_Quote.getQuoteDetail(sbo, this.quoteNumber);
                lastSalesOrganization = this.quoteDetail.Sales.SalesOrganization;
                lastDistributionChannel = this.quoteDetail.Sales.DistributionChannel;
                lastDivision = this.quoteDetail.Sales.Division;
                return;
            }
        }

        clearAllConditions(this.quoteDetail, this.initConditions);
        this.quoteDetail.SalesDocumentCurrency = this.quoteDetail.SALES.SalesDocumentCurrency;

        List<SBO_EnosixQuote_Detail.PARTNERS> partnerList = this.quoteDetail.PARTNERS.getAsList();
        Integer partnerTot = partnerList.size();
        for (Integer partnerCnt = 0 ; partnerCnt < partnerTot ; partnerCnt++)
        {
            SBO_EnosixQuote_Detail.PARTNERS partner = partnerList[partnerCnt];
            if (String.isEmpty(partner.CustomerNumber) && String.isEmpty(partner.Vendor)
                && (partner.PersonnelNumber == null
                || String.isEmpty(partner.PersonnelNumber.replaceFirst('^0+(?!$)', '')))
                && (partner.ContactPersonNumber == null
                || String.isEmpty(partner.ContactPersonNumber.replaceFirst('^0+(?!$)', ''))))
            {
                this.quoteDetail.PARTNERS.remove(partner);
            }
        }

        DateTime startSimulate = System.now();
        System.debug('Start Simulate '+ startSimulate);

        SBO_EnosixQuote_Detail.EnosixQuote simulatedQuote = sbo.command('CMD_SIMULATE_QUOTE', this.quoteDetail);

        DateTime endSimulate = System.now();
        System.debug('End Simulate '+ endSimulate);
        System.debug('MilliSecond Simulate ' + (endSimulate.getTime() - startSimulate.getTime()));

        if (simulatedQuote.isSuccess())
        {
            System.debug('simulated quote was a success');
            this.quoteDetail = simulatedQuote;
        }

        if (isCloneMode)
        {
            this.quoteDetail.TEXTS.clear();
        }

        this.quoteDetail.SHIPPING.ShipToParty = ShipToPartner.CustomerNumber;

        UTIL_ViewHelper.displayResultMessages(simulatedQuote.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
    }

    public List<string> quoteMaterialTypes
    {
        get
        {
            return (List<String>)UTIL_AppSettings.getList(
                'Quote.MaterialTypes', String.class, new List<String>{ 'FERT' });
        }
    }

    public List<string> defaultQuoteMaterialTypes
    {
        get
        {
            return (List<String>)UTIL_AppSettings.getList(
                'Quote.DefaultMaterialTypes', String.class, quoteMaterialTypes);
        }
    }

    public Boolean isQuoteMaterialAutoSearchEnabled
    {
        get
        {
            return (Boolean)UTIL_AppSettings.getValue('Quote.IsMaterialAutoSearchEnabled', true);
        }
    }

    public Boolean isShipToAutoSearchEnabled
    {
        get
        {
            return (Boolean)UTIL_AppSettings.getValue('Quote.IsShipToAutoSearchEnabled', true);
        }
    }

    public CB_CMPCustomerSearchReceiver customerReceiver { get {return this; }}
    public void onReceiveCustomerSearch(CTRL_CMPCustomerSearch.CustomerSearchResult result)
    {        
        logCallouts('onReceiveCustomerSearch');
        if (result.partnerFunction == SOLD_TO_PARTNER_CODE)
        {
            this.SoldToPartner.CustomerNumber = result.customerNumber;
            this.SoldToPartner.PartnerName = result.name;
            this.soldToCustomer = null;
            UpdateShipToPartner();
            this.billToCustomer = null;
            this.payerCustomer = null;
            this.quoteDetail.Shipping.ShippingConditions = this.customerSalesData.ShippingConditions;
            this.quoteDetail.Sales.TermsofPaymentKey = this.customerSalesData.TermsofPaymentKey;
            this.quoteDetail.Sales.PriceGroup = this.customerSalesData.PriceGroup;
            this.quoteDetail.Sales.PriceListType = this.customerSalesData.PriceListType;
            this.quoteDetail.Shipping.CompleteDeliveryDefined = this.customerSalesData.CompleteDeliveryDefined;
            this.quoteDetail.Sales.IncotermsPart1 = this.customerSalesData.IncotermsPart1;
            this.quoteDetail.Sales.IncotermsPart2 = this.customerSalesData.IncotermsPart2;
    
            this.updateSalesAreas();
        }
    }

    public CB_CMPPartnerSearchReceiver partnerReceiver { get {return this; }}
    public void onReceivePartnerSearch(CTRL_CMPPartnerSearch.PartnerSearchResult result)
    {        
        logCallouts('onReceivePartnerSearch');
        if (result.partnerFunction == SHIP_TO_PARTNER_CODE)
        {
            this.ShipToPartner.CustomerNumber = result.partnerNumber;
            UpdateShipToPartner();
            resetItemPlantAndShipping();
        }
        else if (result.partnerFunction == BILL_TO_PARTNER_CODE)
        {
            this.BillToPartner.CustomerNumber = result.partnerNumber;
            this.billToCustomer = null;
        }
        else if (result.partnerFunction == PAYER_PARTNER_CODE)
        {
            this.PayerPartner.CustomerNumber = result.partnerNumber;
            this.payerCustomer = null;
        }
        this.updateSalesAreas();
    }

    public PageReference displayQuote()
    {
        logCallouts('displayQuote');
        if (String.isNotBlank(this.quoteDetail.SalesDocument))
        {
            UTIL_PageState.current.sapQuoteId = this.quoteDetail.SalesDocument;
        }
        if (null != this.quoteOpportunity)
        {
            UTIL_PageState.current.sfOpportunityId = this.quoteOpportunity.Id;
        }
        if (sfsObject != null) UTIL_PageState.current.sfRecordId = sfsObject.Id;
        UTIL_PageState.current.sapDocNum = this.quoteDetail.SalesDocument;
        UTIL_PageState.current.sapDocType = UTIL_PageState.SAP_DocTypeQuote;
        UTIL_PageState.current.sfDocDetailFlowName = (String)UTIL_AppSettings.getValue('Quote.SalesDocDetailFlowName');
        PageReference returnPage = UTIL_PageFlow.redirectTo(UTIL_PageFlow.CMP_Sales_Doc_Flow_Wrapper, UTIL_PageState.current);
        if (isClassic)
        {
            returnPage = UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_QuoteDetail, UTIL_PageState.current);
        }
        return returnPage;
    }

    public PageReference goToSFSObjectPage()
    {
        logCallouts('goToSFSObjectPage');
        return UTIL_PageFlow.redirectTo('/' + this.sfSObject.Id, null);
    }

    public PageReference redirectToCreateCustomer()
    {
        logCallouts('redirectToCreateCustomer');
        return UTIL_Customer.redirectToCreateCustomer();
    }

	/**
	 * methods for creating a whole new quote
	 */
    public PageReference createNewQuote()
    {
        logCallouts('createNewQuote');

        if (!validateQuote())
        {
            return null;
        }

        clearAllConditions(this.quoteDetail, this.initConditions);
        this.quoteDetail.ITEMS_SCHEDULE.clear();

        SBO_EnosixQuote_Detail sbo = new SBO_EnosixQuote_Detail();
        this.quoteDetail.ITEMS_ACTION.clear();
        SBO_EnosixQuote_Detail.EnosixQuote result = sbo.save(this.quoteDetail);
        if (!result.isSuccess())
        {
            UTIL_ViewHelper.displayResultMessages(result.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
            return null;
        }

        system.debug('createNewQuote isSuccess');
        this.quoteDetail = result;

        if (!UTIL_Quote.finalizeQuoteAndUpdateSfSobject(calledFrom, this.sfSObject, this.quoteDetail, this.sfSObjectLineIdMap))
        {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.WARNING, 'Update of Sales Force ' + sfSObject.getSObjectType().getDescribe().getName() + ' failed'));
            return null;
        }

        ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO, 'Quote was Successfully Saved.'));

        return displayQuote();
    }

    // updateQuote()
    //
    // Method to update the quote
    public PageReference updateQuote()
    {
        logCallouts('updateQuote');
        if (!validateQuote())
        {
            return null;
        }

        SBO_EnosixQuote_Detail sbo = new SBO_EnosixQuote_Detail();

        SBO_EnosixQuote_Detail.EnosixQuote result = sbo.save(this.quoteDetail);

        if (!result.isSuccess())
        {
            UTIL_ViewHelper.displayResultMessages(result.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
            return null;
        }

        System.debug('updateQuote isSuccess');
        this.quoteDetail = result;

        if (!UTIL_Quote.finalizeQuoteAndUpdateSfSobject(calledFrom, this.sfSObject, this.quoteDetail, this.sfSObjectLineIdMap))
        {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.WARNING, 'Update of Sales Force ' + sfSObject.getSObjectType().getDescribe().getName() + ' failed'));
            return null;
        }

        ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO, 'Quote was Successfully updated.'));

        return displayQuote();
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
    private boolean validateQuote()
    {
        boolean poNumRequired = isPONumberRequired(this.quoteDetail.Sales.SalesDocumentType);
        boolean validated = true;

        validated &= UTIL_ViewHelper.validateStringPropertyIsNotBlank(this.quoteDetail.Sales.SalesOrganization, 'Sales Organization');
        validated &= UTIL_ViewHelper.validateStringPropertyIsNotBlank(this.quoteDetail.Sales.DistributionChannel, 'DistributionChannel');
        validated &= UTIL_ViewHelper.validateStringPropertyIsNotBlank(this.quoteDetail.Sales.Division, 'Division');
        validated &= UTIL_ViewHelper.validateStringPropertyIsNotBlank(this.soldToPartner.CustomerNumber, 'Sold To');
        validated &= UTIL_ViewHelper.validateStringPropertyIsNotBlank(this.shipToPartner.CustomerNumber, 'Ship To');
        validated &= UTIL_ViewHelper.validateStringPropertyIsNotBlank(String.valueOf(this.quoteDetail.Sales.ValidFrom), 'Valid From');
        validated &= UTIL_ViewHelper.validateStringPropertyIsNotBlank(String.valueOf(this.quoteDetail.Sales.ValidTo), 'Valid To');

        if ((this.quoteDetail.Sales.SalesDocumentType == null || 
            this.quoteDetail.Sales.SalesDocumentType == '' || 
            this.quoteDetail.SALES.SalesDocumentType == 'QT') && QuoteTypes.size() > 0)
        {
            this.quoteDetail.Sales.SalesDocumentType = QuoteTypes.get(0).getValue();
        }

        if (string.isEmpty(this.quoteDetail.CustomerPurchaseOrderNumber) && poNumRequired)
        {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'A PO Number is required'));
            validated = false;
        }

        if (string.isNotBlank(this.quoteDetail.CustomerPurchaseOrderNumber) && this.quoteDetail.ORDERDATA.CustomerPurchaseOrderDate == null)
        {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'A PO Date is required'));
            validated = false;
        }

        validated &= validateValidToAndFromDate(this.quoteDetail);

        return validated;
    }

    public void checkValidToAndFromDate()
    {
        logCallouts('checkValidToAndFromDate');
        validateValidToAndFromDate(this.quoteDetail);
    }

    public void checkRequestedDate()
    {
        logCallouts('checkRequestedDate');
        List<SBO_EnosixQuote_Detail.ITEMS> itemList = this.quoteDetail.ITEMS.getAsList();
        Integer itemTot = itemList.size();
        List<SBO_EnosixQuote_Detail.ITEMS_ACTION> actionList = this.quoteDetail.ITEMS_ACTION.getAsList();
        Integer actionTot = actionList.size();
        for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
        {
            SBO_EnosixQuote_Detail.ITEMS item = itemList[itemCnt];
            item.ScheduleLineDate = this.quoteDetail.SALES.RequestedDeliveryDate;
            SBO_EnosixQuote_Detail.ITEMS_ACTION itemAction = new SBO_EnosixQuote_Detail.ITEMS_ACTION();
            itemAction.ItemNumber = item.ItemNumber;
            itemAction.ItemChanged = true;

            //Check if there's an Item Action already available for the item, mainly for quote create
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
        this.SimulateQuote();
    }

    @testVisible
    private static Boolean validateValidToAndFromDate(SBO_EnosixQuote_Detail.EnosixQuote quote)
    {
        if (null == quote.SALES.ValidTo || null == quote.SALES.ValidFrom)
        {
            return false;
        }

        Date todaysDate = Date.today();
        if (quote.SALES.ValidFrom < todaysDate)
        {
            quote.SALES.ValidFrom = todaysDate;
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO, 'Valid From Date change to today\'s date'));
        }

        if (quote.SALES.ValidTo < quote.Sales.ValidFrom.addDays(30))
        {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO, 'Valid To Date must be at least 30 days from Valid From Date'));
            return false;
        }

        if (quote.SALES.ValidTo > quote.SALES.ValidFrom.addDays(90))
        {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO, 'Valid To Date Cannot be more than 90 days from Valid From Date'));
            return false;
        }

        return true;
    }

    private boolean isPONumberRequired(string quoteType)
    {
        RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT quoteMasterData = UTIL_Quote.getQuoteMasterData(quoteType);
        return quoteMasterData == null ? false : quoteMasterData.X_PONUM_REQUIRED;
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

    /*
    * On Receive from Material Search
    */
    public CB_MaterialSearchReceiver msReceiver { get { return this; } }

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
            item.OrderQuantity = material.quantity;
            item.ScheduleLineDate = material.scheduleDate;
            if (item.ScheduleLineDate == null)
            {
                item.ScheduleLineDate = this.quoteDetail.SALES.RequestedDeliveryDate;
            }

            if (!validateNewLineItem(item))
            {
                return;
            }

            items.add(item);
        }

        // Now that all the data is validated, we can actually add the items
        Integer itemTot = items.size();
        for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
        {
            SBO_EnosixQuote_Detail.ITEMS item = items[itemCnt];
            UTIL_Quote.addItemToQuote(this.quoteDetail, item, itemIncrement);
        }

        List<SBO_EnosixQuote_Detail.ITEMS> itemList = this.quoteDetail.ITEMS.getAsList();
        itemTot = itemList.size();
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

    @testVisible
    private static boolean validateNewLineItem(SBO_EnosixQuote_Detail.ITEMS item)
    {
        boolean result = true;

        if (string.isBlank(item.Material))
        {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Material is required'));
            result = false;
        }

        if (0 > item.OrderQuantity)
        {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Quantity is invalid'));
            result = false;
        }

        return result;
    }

    public String editActionElementId { get; set ; }
    public String editItemNumber { get; set; }
    public UTIL_Quote.QuoteItem editQuoteItem
    {
        get
        {
            if (this.editItemNumber != null)
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
            }
            return null;
        }
        set
        {
            if (this.editItemNumber != null)
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
    }

    @testVisible
    private SBO_EnosixQuote_Detail.ITEMS saveQuoteItem;

    @testVisible
    private Map<Integer,String> selectedItemsMap = new Map<Integer,String>();
    private Integer currentItemCnt = -1;
    private Integer itemCntIncrement = 1;

    public Boolean isNext
    {
        get
        {
            return selectedItemsMap.size() != currentItemCnt + 1;
        }
    }

    public Boolean isBack
    {
        get
        {
            return currentItemCnt > 0;
        }
    }

    public void editItems()
    {
        logCallouts('editItems');
        selectedItemsMap.clear();
        currentItemCnt = -1;
        Integer dmiTot = this.displayedMaterialItems.size();
        for (Integer dmiCnt = 0 ; dmiCnt < dmiTot ; dmiCnt++)
        {
            UTIL_Quote.QuoteItem quoteItem = this.displayedMaterialItems[dmiCnt];
            if (quoteItem.isSelected) 
            {
                selectedItemsMap.put(++currentItemCnt, quoteItem.item.ItemNumber);
            }
        }

        currentItemCnt = -1;
        setEditItemNumber();
    }

    private void setEditItemNumber()
    {
        this.editItemNumber = null;
        if (this.selectedItemsMap.size() > 0)
        {
            currentItemCnt += itemCntIncrement;
            itemCntIncrement = 1;
            if (selectedItemsMap.containsKey(currentItemCnt))
            {
                this.editItemNumber = selectedItemsMap.get(currentItemCnt);
                editItem();
                return;
            }
            selectedItemsMap.clear();
        }
        currentItemCnt = -1;
    }

    public void editItemClick()
    {
        logCallouts('editItemClick');
        this.editItemNumber = System.currentPageReference().getParameters().get('editItemNumber');
        this.editActionElementId = System.currentPageReference().getParameters().get('editActionElementId');
        editItem();
    }

    private void editItem()
    {
        this.saveQuoteItem = null;
        ItemCategories = null;
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
        else if (editQuoteItem.item.Plant != saveQuoteItem.Plant)
        {
            editQuoteItem.item.ShippingPoint = '';
            editQuoteItem.item.ShippingPointDescription = '';
            editQuoteItem.item.Route = '';
            editQuoteItem.item.RouteDescription = '';
        }

        this.saveQuoteItem = null;
        setEditItemNumber();
        if (this.editItemNumber == null) this.SimulateQuote();
    }

    public void backEditItem()
    {
        itemCntIncrement = -1;
        saveEditItem();
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
        this.saveQuoteItem = null;
        setEditItemNumber();
        if (this.editItemNumber == null) this.SimulateQuote();
    }

    public void exitEdits()
    {
        logCallouts('exitEdits');
        selectedItemsMap.clear();
        cancelEditItem();
    }

    Map<Integer, Integer> changeItemNumberMap = new Map<Integer, Integer>();

    public void removeItems()
    {
        logCallouts('removeItems');
        List<String> selectedItemNumberList = new List<String>();
        Integer dmiTot = this.displayedMaterialItems.size();
        for (Integer dmiCnt = 0 ; dmiCnt < dmiTot ; dmiCnt++)
        {
            UTIL_Quote.QuoteItem quoteItem = this.displayedMaterialItems[dmiCnt];
            if (quoteItem.isSelected && (String.isEmpty(quoteItem.Item.HigherLevelItemNumber) || quoteItem.Item.HigherLevelItemNumber.replaceFirst('^0+(?!$)', '') == '0')) selectedItemNumberList.add(quoteItem.item.itemNumber);
        }

        Integer selectTot = selectedItemNumberList.size();
        for (Integer selectCnt = 0 ; selectCnt < selectTot ; selectCnt++)
        {
            String itemNumber = selectedItemNumberList[selectCnt];
            UTIL_Quote.removeItemFromQuote(this.quoteDetail, itemNumber, this.initConditions, this.sfSObjectLineIdMap);
        }

        if (selectTot > 0) this.SimulateQuote();
    }

    public void removeItemClick()
    {
        logCallouts('removeItemClick');
        String itemNumber = System.currentPageReference().getParameters().get('removeItemNumber');
        UTIL_Quote.removeItemFromQuote(this.quoteDetail, itemNumber, this.initConditions, this.sfSObjectLineIdMap);
        this.SimulateQuote();
    }

    public void cloneItems()
    {
        logCallouts('cloneItems');
        List<String> selectedItemNumberList = new List<String>();
        Integer dmiTot = this.displayedMaterialItems.size();
        for (Integer dmiCnt = 0 ; dmiCnt < dmiTot ; dmiCnt++)
        {
            UTIL_Quote.QuoteItem quoteItem = this.displayedMaterialItems[dmiCnt];
            if (quoteItem.isSelected && (String.isEmpty(quoteItem.Item.HigherLevelItemNumber) || quoteItem.Item.HigherLevelItemNumber.replaceFirst('^0+(?!$)', '') == '0')) selectedItemNumberList.add(quoteItem.item.itemNumber);
        }

        Integer selectTot = selectedItemNumberList.size();
        for (Integer selectCnt = 0 ; selectCnt < selectTot ; selectCnt++)
        {
            String itemNumber = selectedItemNumberList[selectCnt];
            UTIL_Quote.cloneItemToQuote(this.quoteDetail, itemNumber, itemIncrement);
        }

        if (selectTot > 0) this.SimulateQuote();
    }

    public void cloneItemClick()
    {
        logCallouts('cloneItem');
        String cloneItemNumber = System.currentPageReference().getParameters().get('cloneItemNumber');
        this.editActionElementId = System.currentPageReference().getParameters().get('editActionElementId');
        UTIL_Quote.cloneItemToQuote(this.quoteDetail, cloneItemNumber, itemIncrement);
        this.SimulateQuote();
    }

    public void moveItemsUp()
    {
        logCallouts('moveItemsUp');
        Boolean isChanged = false;
        changeItemNumberMap.clear();
        Integer dmiTot = this.displayedMaterialItems.size();
        for (Integer dmiCnt = 0 ; dmiCnt < dmiTot ; dmiCnt++)
        {
            UTIL_Quote.QuoteItem quoteItem = this.displayedMaterialItems[dmiCnt];
            Integer oldItemNumber = integer.valueOf(quoteItem.item.ItemNumber);
            changeItemNumberMap.put(oldItemNumber, oldItemNumber);
            if (quoteItem.isSelected) 
            {
                isChanged = true;
                Integer newItemNumber = oldItemNumber - itemIncrement;
                List<Integer> chgItmNumList = new List<Integer>(changeItemNumberMap.keySet());
                Integer chgItmNumTot = chgItmNumList.size();
                for (Integer chgItmNumCnt = 0 ; chgItmNumCnt < chgItmNumTot ; chgItmNumCnt++)
                {
                    Integer oldMapItemNumber = chgItmNumList[chgItmNumCnt];
                    Integer newMapItemNumber = changeItemNumberMap.get(oldMapItemNumber);
                    if (newMapItemNumber == newItemNumber)
                    {
                        changeItemNumberMap.put(oldMapItemNumber,newMapItemNumber + itemIncrement);
                    }
                }
                changeItemNumberMap.put(oldItemNumber, newItemNumber);
            }
        }

        if (isChanged)
        {
            moveItemsUpOrDown(this.quoteDetail, changeItemNumberMap, sfSObjectLineIdMap);
            this.SimulateQuote();
        }
    }

    public void moveItemsDown()
    {
        logCallouts('moveItemsDown');
        Boolean isChanged = false;
        changeItemNumberMap.clear();
        for (Integer itemCnt = this.displayedMaterialItems.size() - 1 ; itemCnt >= 0 ; --itemCnt)
        {
            UTIL_Quote.QuoteItem quoteItem = this.displayedMaterialItems[itemCnt];
            Integer oldItemNumber = integer.valueOf(quoteItem.item.ItemNumber);
            changeItemNumberMap.put(oldItemNumber, oldItemNumber);
            if (quoteItem.isSelected) 
            {
                isChanged = true;
                Integer newItemNumber = oldItemNumber + itemIncrement;
                List<Integer> chgItmNumList = new List<Integer>(changeItemNumberMap.keySet());
                Integer chgItmNumTot = chgItmNumList.size();
                for (Integer chgItmNumCnt = 0 ; chgItmNumCnt < chgItmNumTot ; chgItmNumCnt++)
                {
                    Integer oldMapItemNumber = chgItmNumList[chgItmNumCnt];
                    Integer newMapItemNumber = changeItemNumberMap.get(oldMapItemNumber);
                    if (newMapItemNumber == newItemNumber)
                    {
                        changeItemNumberMap.put(oldMapItemNumber,newMapItemNumber - itemIncrement);
                    }
                }
                changeItemNumberMap.put(oldItemNumber, newItemNumber);
            }
        }

        if (isChanged)
        {
            moveItemsUpOrDown(this.quoteDetail, changeItemNumberMap, sfSObjectLineIdMap);
            this.SimulateQuote();
        }
    }

    @testVisible
    private static void moveItemsUpOrDown(
        SBO_EnosixQuote_Detail.EnosixQuote quoteDetail, 
        Map<Integer, Integer> changeItemNumberMap,
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap)
    {
        UTIL_EnsxObject.moveValueObjectList(quoteDetail.ITEMS, 'POSNR', changeItemNumberMap);
        UTIL_EnsxObject.moveValueObjectList(quoteDetail.ITEMS_TEXT, 'POSNR', changeItemNumberMap);
        UTIL_EnsxObject.moveValueObjectList(quoteDetail.ITEMS_SCHEDULE, 'POSNR', changeItemNumberMap);
        UTIL_EnsxObject.moveValueObjectList(quoteDetail.ITEMS_CONFIG, 'POSNR', changeItemNumberMap);
        UTIL_EnsxObject.moveValueObjectList(quoteDetail.ITEMS_ACTION, 'POSNR', changeItemNumberMap);
        UTIL_EnsxObject.moveValueObjectList(quoteDetail.CONDITIONS, 'KPOSN', changeItemNumberMap);
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> newSfSObjectLineIdMap = new Map<String, UTIL_SFSObjectDoc.SfSObjectItem>();
        List<Integer> chgItmNumList = new List<Integer>(changeItemNumberMap.keySet());
        Integer chgItmNumTot = chgItmNumList.size();
        for (Integer chgItmNumCnt = 0 ; chgItmNumCnt < chgItmNumTot ; chgItmNumCnt++)
        {
            Integer oldItemNumber = chgItmNumList[chgItmNumCnt];
            UTIL_SFSObjectDoc.SfSObjectItem sfsObjectItem = sfSObjectLineIdMap.get(String.valueOf(oldItemNumber));
            if (sfsObjectItem != null)
            {
                Integer newItemNumber = changeItemNumberMap.get(oldItemNumber);
                newSfSObjectLineIdMap.put(String.valueOf(newItemNumber), sfsObjectItem);
            }
        }
        List<String> keyList = new List<String>(sfSObjectLineIdMap.keySet());
        Integer keyTot = keyList.size();
        for (Integer keyCnt = 0 ; keyCnt < keyTot ; keyCnt++)
        {
            String key = keyList[keyCnt];
            if (key.startsWith('NotFound'))
            {
                UTIL_SFSObjectDoc.SfSObjectItem sfsObjectItem = sfSObjectLineIdMap.get(key);
                newSfSObjectLineIdMap.put(key, sfsObjectItem);
            }
        }
        sfSObjectLineIdMap.clear();
        sfSObjectLineIdMap.putAll(newSfSObjectLineIdMap);
        changeItemNumberMap.clear();
    }
}