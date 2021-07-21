public with sharing class CTRL_OrderCreateUpdate implements CB_CMPCustomerSearchReceiver, CB_CMPPartnerSearchReceiver, CB_MaterialSearchReceiver
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_OrderCreateUpdate.class);
    public static final String calledFrom = 'CTRL_OrderCreateUpdate';

    public void logCallouts(String location)
    {
        if ((Boolean)UTIL_AppSettings.getValue('CTRL_OrderCreateUpdate.Logging', false))
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
    public Boolean isOrderMode { get; private set; }

    @testVisible
    public Boolean isReferenceMode { get; private set; }

    public Boolean isAddMaterial { get { return UTIL_Order.isAddMaterial; } }
    public Boolean isRemoveMaterial { get { return UTIL_Order.isRemoveMaterial; } }
    public Boolean isEditMaterial { get { return UTIL_Order.isEditMaterial; } }
    public Boolean isCloneMaterial { get { return UTIL_Order.isCloneMaterial; } }
    public Boolean isMoveMaterial { get { return UTIL_Order.isMoveMaterial; } }
    public Boolean isSelectMaterial { get { return UTIL_Order.isSelectMaterial; } }

    public String opportunityId { get { return UTIL_PageState.current.sfOpportunityId; } }
    public String quoteRequestId { get { return UTIL_PageState.current.sfQuoteId; } }

    public String previousScreen
    {
        get
        {
            return UTIL_PageState.SAP_PreviousScreenOrder;
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

    public Opportunity orderOpportunity 
    { 
        get 
        {
            return UTIL_SFSObjectDoc.getOpportunity(sfSObject);
        }
    }

    public Boolean canSaveOrder { get; private set; }
    @testVisible
    public String orderNumber { get; private set; }
    public String quoteNumber { get; private set; }

    private transient SBO_EnosixCustomer_Detail.EnosixCustomer t_soldToCustomer;
    public SBO_EnosixCustomer_Detail.EnosixCustomer soldToCustomer
    {
        get
        {
            if (null == t_soldToCustomer)
            {
                if (null != this.orderAccount)
                {
                    string customerId = UTIL_SFAccount.getCustomerNumberFromAccount(this.orderAccount);
                    if (!string.isBlank(customerId))
                    {
                        SoldToPartner.CustomerNumber = customerId;
                        t_soldToCustomer = UTIL_Customer.getCustomerByNumber(customerId);
                    }
                    if (string.isBlank(customerId) || (t_soldToCustomer != null && t_soldToCustomer.SALES_DATA.size() == 0))
                    {
                        ApexPages.addMessage(new Apexpages.Message(
                            ApexPages.Severity.WARNING, 'This Account/SAP customer is not configured for order creation'));
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

    public SBO_EnosixSO_Detail.EnosixSO orderDetail { get; set; }

    @testVisible
    private List<SBO_EnosixSO_Detail.CONDITIONS> initConditions { get; set; }
    @testVisible
    private Map<String, UTIL_Order.OrderLineValue> orderLineValueMap = new Map<String, UTIL_Order.OrderLineValue>();

    @testVisible
    public Account orderAccount { get; private set; }

    public boolean opportunityClosed
    {
        get
        {
            return this.orderOpportunity != null && !isUpdateMode && this.orderOpportunity.StageName.contains('Closed');
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

    public static string pickDefaultOrderType(List<SelectOption> selectOptions)
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
    public List<UTIL_Order.OrderItem> displayedMaterialItems
    {
        get
        {
            if (displayedMaterialItems== null)
            {
                displayedMaterialItems = UTIL_Order.convertOrderDetailToOrderItem(this.orderDetail, this.orderLineValueMap, this.itemIncrement);
            }
            return displayedMaterialItems;
        }

        private set;
    }

    public String sapCustomerNumber { private get; set; }

    public string pathMaterialDetail
    {
        get
        {
            return UTIL_PageFlow.getPageURL(UTIL_PageFlow.VFP_MaterialDetail);
        }
    }

    public Boolean isOrderTypeDisabled
    {
        get
        {
            return this.orderDetail.ITEMS.size() > 0;
        }
    }

    public String returnToId {
        get {
            if (null == returnToId)
            {
                if (null != this.sfsObject) returnToId = this.sfsObject.Id;
                else if (null != this.orderAccount) returnToId = this.orderAccount.Id;
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
                else if (null != this.orderAccount) returnToName = this.orderAccount.Name;
                
            }
            return returnToName;
        }
        private set;
    }

    public String returnToAccountName {
        get {
            if (null == returnToAccountName && null != this.orderAccount)
            {
                returnToAccountName = this.orderAccount.Name;
            }
            return returnToAccountName;
        }
        private set;
    }

    public CTRL_OrderCreateUpdate()
    {
        logCallouts('CTRL_OrderCreateUpdate');
        this.orderDetail = new SBO_EnosixSO_Detail.EnosixSO();
        this.initConditions = new List<SBO_EnosixSO_Detail.CONDITIONS>();
        this.orderNumber = UTIL_PageState.current.sapOrderNum;
        this.quoteNumber = UTIL_PageState.current.sapQuoteId;
        this.isCreateMode = (UTIL_PageState.current.sapMode == UTIL_PageState.SAP_ModeCreate);
        this.isUpdateMode = (UTIL_PageState.current.sapMode == UTIL_PageState.SAP_ModeUpdate);
        this.isCloneMode = (UTIL_PageState.current.sapMode == UTIL_PageState.SAP_ModeClone);
        this.isOrderMode = (UTIL_PageState.current.sapMode == UTIL_PageState.SAP_ModeOrder);
        this.isReferenceMode = (UTIL_PageState.current.sapMode == UTIL_PageState.SAP_ModeReference);

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
            this.orderDetail.Sales.SalesOrganization = '';
            this.orderDetail.Sales.DistributionChannel = '';
            this.orderDetail.Sales.Division = '';
            if (!String.isEmpty(UTIL_PageState.current.sapSalesArea))
            {
                this.orderDetail.Sales.SalesOrganization = UTIL_PageState.current.sapSalesArea.split(',')[0];
                this.orderDetail.Sales.DistributionChannel = UTIL_PageState.current.sapSalesArea.split(',')[1];
                this.orderDetail.Sales.Division = UTIL_PageState.current.sapSalesArea.split(',')[2];
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
        this.orderAccount = UTIL_SFSObjectDoc.sfAccount;
        this.canSaveOrder = true;

        if (isOrderMode)
        {
            this.quoteNumber = !String.isEmpty(this.quoteNumber) ? this.quoteNumber : UTIL_SFSObjectDoc.getQuoteNumber(this.sfsObject);
            this.orderNumber = !String.isEmpty(this.orderNumber) ? this.orderNumber : UTIL_SFSObjectDoc.getOrderNumber(this.sfsObject);
            if (!String.isEmpty(this.orderNumber))
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
        if (isReferenceMode)
        {
            if (String.isEmpty(this.quoteNumber))
            {
                ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'No SAP Quote Id to Clone'));
                canSaveOrder = false;
                this.orderAccount = null;
                this.sfSObject = null;
                return;
            }
            initReferenceFromQuote();
        }
        else if (isUpdateMode || isCloneMode)
        {
            if (String.isEmpty(this.orderNumber))
            {
                if (isUpdateMode)
                {
                    ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'No SAP Order Id to Update'));
                }
                else if (isCloneMode)
                {
                    ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'No SAP Order Id to Clone'));
                }
                canSaveOrder = false;
                this.orderAccount = null;
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

    // initReferenceFromQuote()
    //
    // Initialize order reference from quote
    public void initReferenceFromQuote()
    {
        System.debug('init reference');
        this.orderDetail = new SBO_EnosixSO_Detail.EnosixSO();
        this.orderDetail.ORDER_ACTION.CreateOrderFromQuote = true;
        this.orderDetail.ORDER_ACTION.ReferenceDocumentType = UTIL_PageState.current.sapDocType;
        this.orderDetail.ORDER_ACTION.ReferenceDocumentNumber = this.quoteNumber;
        SBO_EnosixSO_Detail sbo = new SBO_EnosixSO_Detail();
        this.orderDetail = sbo.command('CMD_FILL_REF_DOC_DETAILS', this.orderDetail);

        if (this.orderDetail.isSuccess())
        {
            System.debug('Order init reference from quote successfull');
        }
        UTIL_Order.loadSfsObjectLineIdMapFromOrder(calledFrom, this.sfSObject, this.orderDetail, this.sfSObjectLineIdMap);

        // Add the item action for all the items, mark as ItemAdded
        List<SBO_EnosixSO_Detail.ITEMS> itemList = this.orderDetail.ITEMS.getAsList();
        Integer itemTot = itemList.size();
        for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
        {
            SBO_EnosixSO_Detail.ITEMS item = itemList[itemCnt];
            SBO_EnosixSO_Detail.ITEMS_ACTION action = new SBO_EnosixSO_Detail.ITEMS_ACTION();
            action.ItemNumber = item.ItemNumber;
            action.ItemAdded = true;
            this.orderDetail.ITEMS_ACTION.add(action);
        }

        this.SoldToPartner.CustomerNumber = this.orderDetail.SoldToParty;
        this.orderDetail.SALES.SalesDocumentType = pickDefaultOrderType(OrderTypes);

        this.soldToCustomer = null;
        this.shipToCustomer = null;
        this.billToCustomer = null;
        this.PayerCustomer = null;
        setIncrement();
        updateSalesAreas();

        UTIL_PageMessages.displayOnVfp();
    }

    // initUpdate
    //
    // Initialize for order edit screen
    public void initUpdate()
    {
        this.orderDetail = null;
        this.SimulateOrder();
        List<SBO_EnosixSO_Detail.ITEMS> itemList = this.orderDetail.ITEMS.getAsList();
        Integer itemTot = itemList.size();
        for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
        {
            SBO_EnosixSO_Detail.ITEMS item = itemList[itemCnt];
            SBO_EnosixSO_Detail.ITEMS_ACTION itemAction = new SBO_EnosixSO_Detail.ITEMS_ACTION();
            itemAction.ItemNumber = item.ItemNumber;
            itemAction.ItemChanged = true;
            this.orderDetail.ITEMS_ACTION.add(itemAction);
        }

        UTIL_Order.loadSfsObjectLineIdMapFromOrder(calledFrom, this.sfSObject, this.orderDetail, this.sfSObjectLineIdMap);
        setIncrement();
        this.SoldToPartner.CustomerNumber = this.orderDetail.SoldToParty;

        UpdateShipToPartner();
        this.billToCustomer = null;
        this.payerCustomer = null;

        List<SBO_EnosixSO_Detail.PARTNERS> partnerList = this.orderDetail.PARTNERS.getAsList();
        Integer partnerTot = partnerList.size();
        for (Integer partnerCnt = 0 ; partnerCnt < partnerTot ; partnerCnt++)
        {
            SBO_EnosixSO_Detail.PARTNERS partner = partnerList[partnerCnt];
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
        if (String.isNotEmpty(this.orderNumber))
        {
            List<SBO_EnosixSO_Detail.PARTNERS> partnerList = this.orderDetail.PARTNERS.getAsList();
            Integer partnerTot = partnerList.size();
            for (Integer partnerCnt = 0 ; partnerCnt < partnerTot ; partnerCnt++)
            {
                SBO_EnosixSO_Detail.PARTNERS partner = partnerList[partnerCnt];
                if (String.isEmpty(partner.CustomerNumber) && String.isEmpty(partner.Vendor)
                    && (partner.PersonnelNumber == null
                    || String.isEmpty(partner.PersonnelNumber.replaceFirst('^0+(?!$)', '')))
                    && (partner.ContactPersonNumber == null
                    || String.isEmpty(partner.ContactPersonNumber.replaceFirst('^0+(?!$)', ''))))
                {
                    this.orderDetail.PARTNERS.remove(partner);
                }
            }

            SBO_EnosixSO_Detail sbo = new SBO_EnosixSO_Detail();
            this.orderDetail.ORDER_ACTION.CreateOrderFromQuote = true;
            this.orderDetail.ORDER_ACTION.ReferenceDocumentNumber = this.orderNumber;
            this.orderDetail.ORDER_ACTION.ReferenceDocumentType = this.orderDetail.SALES.SalesDocumentType;
            SBO_EnosixSO_Detail.EnosixSO result = sbo.command('CMD_FILL_REF_DOC_DETAILS', this.orderDetail);
            if (result.isSuccess())
            {
                System.debug('Clone order was a success');
            }
            result.SALES.SalesDocumentType = this.orderDetail.SALES.SalesDocumentType;
            this.orderDetail = result;
            UTIL_Order.loadSfsObjectLineIdMapFromOrder(calledFrom, this.sfSObject, this.orderDetail, this.sfSObjectLineIdMap);
            List<SBO_EnosixSO_Detail.ITEMS> itemList = this.orderDetail.ITEMS.getAsList();
            Integer itemTot = itemList.size();
            for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
            {
                SBO_EnosixSO_Detail.ITEMS item = itemList[itemCnt];
                SBO_EnosixSO_Detail.ITEMS_ACTION action = new SBO_EnosixSO_Detail.ITEMS_ACTION();
                action.ItemNumber = item.ItemNumber;
                action.ItemAdded = true;
                this.orderDetail.ITEMS_ACTION.add(action);
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
    // Initialize for order create screen
    public void initCreate()
    {
        //Init the order from SAP and populate defaults.
        this.orderDetail = (new SBO_EnosixSO_Detail()).initialize(new SBO_EnosixSO_Detail.EnosixSO());

        // Copy over the customer Info
        if (null != this.soldToCustomer)
        {
            UTIL_Order.CopyCustomerInfoToOrder(this.orderDetail, this.soldToCustomer);
        }

        this.orderDetail.Sales.SalesDocumentType = pickDefaultOrderType(OrderTypes);
        setIncrement();
        UpdateShipToPartner();
        this.billToCustomer = null;
        this.payerCustomer = null;

        UTIL_Order.initializeOrderFromSfSObject(calledFrom, this.sfSObject, this.orderDetail, this.sfSObjectLineIdMap, this.orderLineValueMap, this.itemIncrement);

        this.initConditions = this.orderDetail.CONDITIONS.getAsList();

        validateSalesAreas();

        checkRequestedDate();

        Boolean isChanged = UTIL_Order.updateOrderPricingFromSfsObject(calledFrom, this.sfsObject, this.orderDetail, this.sfSObjectLineIdMap);

        if (isChanged) SimulateOrder();
    }

    public void updateSalesAreas()
    {
        logCallouts('updateSalesAreas');
        if (null != this.orderDetail)
        {
            if (this.checkForClone && !this.isInit)
            {
                this.checkForClone = false;
                this.loadClonedRecord();
            }
            else
            {
                validateSalesAreas();
                this.SimulateOrder();
            }
        }
    }

    Private String lastSalesOrganization = '';
    Private String lastDistributionChannel = '';
    Private String lastDivision = '';

    @testVisible
    private void validateSalesAreas()
    {
        if (!isValidSalesData(this.orderDetail.Sales.SalesOrganization, SalesOrganizations))
        {
            this.orderDetail.Sales.SalesOrganization = UTIL_ViewHelper.pickFirst(SalesOrganizations);
        }

        if (!isValidSalesData(this.orderDetail.Sales.DistributionChannel, DistributionChannels))
        {
            this.orderDetail.SALES.DistributionChannel = UTIL_ViewHelper.pickFirst(DistributionChannels);
        }

        if (!isValidSalesData(this.orderDetail.Sales.Division, Divisions))
        {
            this.orderDetail.SALES.Division = UTIL_ViewHelper.pickFirst(Divisions);
        }

        if (lastSalesOrganization != this.orderDetail.Sales.SalesOrganization ||
            lastDistributionChannel != this.orderDetail.Sales.DistributionChannel ||
            lastDivision != this.orderDetail.Sales.Division)
        {
            List<SBO_EnosixCustomer_Detail.SALES_DATA> salesList = this.soldToCustomer.SALES_DATA.getAsList();
            Integer salesTot = salesList.size();
            for (Integer salesCnt = 0 ; salesCnt < salesTot ; salesCnt++)
            {
                SBO_EnosixCustomer_Detail.SALES_DATA salesData = salesList[salesCnt];
                if (salesData.SalesOrganization == this.orderDetail.Sales.SalesOrganization &&
                    salesData.DistributionChannel == this.orderDetail.Sales.DistributionChannel &&
                    salesData.Division == this.orderDetail.Sales.Division)
                {
                    this.orderDetail.Sales.SalesOffice = salesData.SalesOffice;
                    this.orderDetail.Sales.PriceListType = salesData.PriceListType;
                    this.orderDetail.Sales.SalesDocumentCurrency = salesData.CurrencyKey;
                    break;
                }
            }

            if (lastSalesOrganization != this.orderDetail.Sales.SalesOrganization ||
                lastDistributionChannel != this.orderDetail.Sales.DistributionChannel)
            {
                resetItemPlantAndShipping();
            }

            lastSalesOrganization = this.orderDetail.Sales.SalesOrganization;
            lastDistributionChannel = this.orderDetail.Sales.DistributionChannel;
            lastDivision = this.orderDetail.Sales.Division;
        }

        if (orderAccount != null && !isValidSalesData(this.SoldToPartner.CustomerNumber, SoldToPartners))
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
        List<SBO_EnosixSO_Detail.ITEMS> itemList = this.orderDetail.ITEMS.getAsList();
        Integer itemTot = itemList.size();
        List<SBO_EnosixSO_Detail.ITEMS_ACTION> actionList = this.orderDetail.ITEMS_ACTION.getAsList();
        Integer actionTot = actionList.size();
        for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
        {
            SBO_EnosixSO_Detail.ITEMS item = itemList[itemCnt];
            item.Plant = '';
            item.StorageLocation = '';
            item.ShippingPoint = '';
            item.ItemCategory = '';

            SBO_EnosixSO_Detail.ITEMS_ACTION itemAction = new SBO_EnosixSO_Detail.ITEMS_ACTION();
            itemAction.ItemNumber = item.ItemNumber;
            itemAction.ItemChanged = true;

            //Check if there's an Item Action already available for the item, mainly for order create
            for (Integer actionCnt = 0 ; actionCnt < actionTot ; actionCnt++)
            {
                SBO_EnosixSO_Detail.ITEMS_ACTION action = actionList[actionCnt];
                if (item.ItemNumber == action.ItemNumber)
                {
                    itemAction = null;
                    break;
                }
            }
            if (itemAction != null)
            {
                this.orderDetail.ITEMS_ACTION.add(itemAction);
            }
        }

        if (this.editItemNumber != null)
        {
            this.saveOrderItem.Plant = '';
            this.saveOrderItem.ItemCategory = '';
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

   	/*
   	* Pick Lists
   	*/
    private static List<string> master_DocumentCategoryTypes
    {
        get
        {
            return (List<String>)UTIL_AppSettings.getList(
                'Order.DocumentCategoryTypes', String.class, new List<String>{ '*' });
        }
    }

    private static List<string> master_DocumentTypes
    {
        get
        {
            return (List<String>)UTIL_AppSettings.getList(
                'Order.DocumentTypes', String.class, new List<String>{ 'OR' });
        }
    }

    public List<SelectOption> OrderTypes
    {
        get
        {
            List<SelectOption> result = new List<SelectOption>();
            if (null != UTIL_Order.docTypeMaster)
            {
                UTIL_RFC.AddDocTypesOfCategory(result, 
                    UTIL_Order.docTypeMaster.ET_OUTPUT_List, 
                    master_DocumentCategoryTypes, master_DocumentTypes);
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
            if (null != this.soldToCustomer && null != this.orderDetail)
            {
                UTIL_Customer.AddDistributionChannels(result, 
                    UTIL_Customer.getSalesDataListFromCustomer(this.soldToCustomer), 
                    this.orderDetail.Sales.SalesOrganization);
            }

            return result;
        }
    }

    public List<SelectOption> Divisions
    {
        get
        {
            List<SelectOption> result = new List<SelectOption>();

            if (null != this.soldToCustomer && null != this.orderDetail)
            {
                UTIL_Customer.AddDistributionDivisions(result, 
                    UTIL_Customer.getSalesDataListFromCustomer(this.soldToCustomer), 
                    this.orderDetail.Sales.SalesOrganization, 
                    this.orderDetail.Sales.DistributionChannel);
            }

            return result;
        }
    }

    public List<SelectOption> SoldToPartners
    {
        get
        {
            List<SelectOption> result = new List<SelectOption>();
            if (null != this.soldToCustomer && null != this.orderDetail)
            {
                UTIL_Customer.AddPartners(
                    result, 
                    UTIL_Customer.getCustomerPartners(this.soldToCustomer, UTIL_Customer.SOLD_TO_PARTNER_CODE),
                    this.orderDetail.Sales.SalesOrganization, 
                    this.orderDetail.Sales.DistributionChannel, 
                    this.orderDetail.Sales.Division);
            }
            return result;
        }
    }

    public List<SelectOption> ShipToPartners
    {
        get
        {
            List<SelectOption> result = new List<SelectOption>();

            if (null != this.soldToCustomer && null != this.orderDetail)
            {
                UTIL_Customer.AddPartners(
                    result, 
                    UTIL_Customer.getCustomerPartners(this.soldToCustomer, UTIL_Customer.SHIP_TO_PARTNER_CODE),
                    this.orderDetail.Sales.SalesOrganization, 
                    this.orderDetail.Sales.DistributionChannel, 
                    this.orderDetail.Sales.Division);
            }
            return result;
        }
    }

    public List<SelectOption> BillToPartners
    {
        get
        {
            List<SelectOption> result = new List<SelectOption>();

            if (null != this.soldToCustomer && null != this.orderDetail)
            {
                UTIL_Customer.AddPartners(
                    result, 
                    UTIL_Customer.getCustomerPartners(this.soldToCustomer, UTIL_Customer.BILL_TO_PARTNER_CODE),
                    this.orderDetail.Sales.SalesOrganization, 
                    this.orderDetail.Sales.DistributionChannel, 
                    this.orderDetail.Sales.Division);
            }
            return result;
        }
    }

    public List<SelectOption> PayerPartners
    {
        get
        {
            List<SelectOption> result = new List<SelectOption>();

            if (null != this.soldToCustomer && null != this.orderDetail)
            {
                UTIL_Customer.AddPartners(
                    result, 
                    UTIL_Customer.getCustomerPartners(this.soldToCustomer, UTIL_Customer.PAYER_PARTNER_CODE),
                    this.orderDetail.Sales.SalesOrganization, 
                    this.orderDetail.Sales.DistributionChannel, 
                    this.orderDetail.Sales.Division);
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

    //Built List of shipping conditions
    private transient List<SelectOption> t_ItemCategories;
    public List<SelectOption> ItemCategories
    {
        get
        {
            if (null == t_ItemCategories && this.editOrderItem != null)
            {
                t_ItemCategories = new List<SelectOption>();
                RFC_SD_GET_ITEMCAT_VALUES rfc = new RFC_SD_GET_ITEMCAT_VALUES();
                rfc.PARAMS.IV_AUART = this.orderDetail.Sales.SalesDocumentType;
                rfc.PARAMS.IV_VKORG = this.orderDetail.Sales.SalesOrganization;
                rfc.PARAMS.IV_VTWEG = this.orderDetail.Sales.DistributionChannel;
                rfc.PARAMS.IV_MATNR = this.editOrderItem.item.Material;
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

    public SBO_EnosixSO_Detail.PARTNERS SoldToPartner
    {
        get
        {
            return UTIL_Order.getPartnerFromOrder(this.orderDetail, UTIL_Customer.SOLD_TO_PARTNER_CODE, true);
        }
    }

    public SBO_EnosixSO_Detail.PARTNERS ShipToPartner
    {
        get
        {
            return UTIL_Order.getPartnerFromOrder(this.orderDetail, UTIL_Customer.SHIP_TO_PARTNER_CODE, true);
        }
    }

    public SBO_EnosixSO_Detail.PARTNERS BillToPartner
    {
        get
        {
            return UTIL_Order.getPartnerFromOrder(this.orderDetail, UTIL_Customer.BILL_TO_PARTNER_CODE, true);
        }
    }

    public SBO_EnosixSO_Detail.PARTNERS PayerPartner
    {
        get
        {
            return UTIL_Order.getPartnerFromOrder(this.orderDetail, UTIL_Customer.PAYER_PARTNER_CODE, true);
        }
    }

    public SBO_EnosixSO_Detail.PARTNERS Carrier
    {
        get
        {
            return UTIL_Order.getPartnerFromOrder(this.orderDetail, UTIL_Customer.CARRIER_PARTNER_CODE, true);
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

            if (null != this.selectedMaterialDetail && null != this.orderDetail)
            {
                AddPlantsFromMaterialDetail(result,
                    this.selectedMaterialDetail,
                    this.orderDetail.Sales.SalesOrganization,
                    this.orderDetail.Sales.DistributionChannel,
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
            List<SBO_EnosixSO_Detail.ITEMS> itemList = this.orderDetail.ITEMS.getAsList();
            Integer itemTot = itemList.size();
            for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
            {
                SBO_EnosixSO_Detail.ITEMS item = itemList[itemCnt];
                if (item.ItemNumber == editItemNumber)
                {
                    return item.Plant;
                }
            }
            return null;
        }
        set
        {
            List<SBO_EnosixSO_Detail.ITEMS> itemList = this.orderDetail.ITEMS.getAsList();
            Integer itemTot = itemList.size();
            for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
            {
                SBO_EnosixSO_Detail.ITEMS item = itemList[itemCnt];
                if (item.ItemNumber == editItemNumber)
                {
                    item.Plant = value;
                    break;
                }
            }
        }
    }

    private transient RFC_SD_GET_SHIP_INFO.RESULT t_shippingMaster;
    @testVisible
    private RFC_SD_GET_SHIP_INFO.RESULT shippingMaster
    {
        get
        {
            if (null == t_shippingMaster)
            {
                t_shippingMaster = UTIL_ShippingInfo.getShippingMaster();
            }
            return t_shippingMaster;
        }
    }

    //Built List of shipping conditions
    public List<SelectOption> ShippingConditions
    {
        get
        {
            List<SelectOption> result = Util_SelectOption.buildOptionsFromList(
                new UTIL_ShippingInfo.ShippingConditionOptionBuilder(),
                UTIL_ShippingInfo.filterShippingConditions(this.shippingMaster)
            );

            return result;
        }
    }

    public void SimulateOrder()
    {
        logCallouts('SimulateOrder');
        displayedMaterialItems = null;
        SBO_EnosixSO_Detail sbo = new SBO_EnosixSO_Detail();
        if (isUpdateMode)
        {
            if (this.orderDetail == null)
            {
                this.orderDetail = sbo.getDetail(this.orderNumber);
                lastSalesOrganization = this.orderDetail.Sales.SalesOrganization;
                lastDistributionChannel = this.orderDetail.Sales.DistributionChannel;
                lastDivision = this.orderDetail.Sales.Division;
                return;
            }
        }

        this.orderDetail.SalesDocumentCurrency = this.orderDetail.SALES.SalesDocumentCurrency;

        List<SBO_EnosixSO_Detail.PARTNERS> partnerList = this.orderDetail.PARTNERS.getAsList();
        Integer partnerTot = partnerList.size();
        for (Integer partnerCnt = 0 ; partnerCnt < partnerTot ; partnerCnt++)
        {
            SBO_EnosixSO_Detail.PARTNERS partner = partnerList[partnerCnt];
            if (String.isEmpty(partner.CustomerNumber) && String.isEmpty(partner.Vendor)
                && (partner.PersonnelNumber == null
                || String.isEmpty(partner.PersonnelNumber.replaceFirst('^0+(?!$)', '')))
                && (partner.ContactPersonNumber == null
                || String.isEmpty(partner.ContactPersonNumber.replaceFirst('^0+(?!$)', ''))))
            {
                this.orderDetail.PARTNERS.remove(partner);
            }
        }

        DateTime startSimulate = System.now();
        System.debug('Start Simulate '+ startSimulate);

        SBO_EnosixSO_Detail.EnosixSO simulatedOrder = sbo.command('CMD_SIMULATE_ORDER', this.orderDetail);

        DateTime endSimulate = System.now();
        System.debug('End Simulate '+ endSimulate);
        System.debug('MilliSecond Simulate ' + (endSimulate.getTime() - startSimulate.getTime()));

        if (simulatedOrder.isSuccess())
        {
            System.debug('simulated order was a success');
            this.orderDetail = simulatedOrder;
        }

        this.orderDetail.SHIPPING.ShipToParty = ShipToPartner.CustomerNumber;

        UTIL_ViewHelper.displayResultMessages(simulatedOrder.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
    }

    public List<string> orderMaterialTypes
    {
        get
        {
            return (List<String>)UTIL_AppSettings.getList(
                'Order.MaterialTypes', String.class, new List<String>{ 'FERT' });
        }
    }

    public List<string> defaultOrderMaterialTypes
    {
        get
        {
            return (List<String>)UTIL_AppSettings.getList(
                'Order.DefaultMaterialTypes', String.class, orderMaterialTypes);
        }
    }

    public boolean isOrderMaterialAutoSearchEnabled
    {
        get
        {
            return (Boolean)UTIL_AppSettings.getValue('Order.IsMaterialAutoSearchEnabled', true);
        }
    }

    public Boolean isShipToAutoSearchEnabled
    {
        get
        {
            return (Boolean)UTIL_AppSettings.getValue('Order.IsShipToAutoSearchEnabled', true);
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
            this.orderDetail.Shipping.ShippingConditions = this.customerSalesData.ShippingConditions;
            this.orderDetail.Sales.TermsofPaymentKey = this.customerSalesData.TermsofPaymentKey;
            this.orderDetail.Sales.PriceGroup = this.customerSalesData.PriceGroup;
            this.orderDetail.Sales.PriceListType = this.customerSalesData.PriceListType;
            this.orderDetail.Shipping.CompleteDeliveryDefined = this.customerSalesData.CompleteDeliveryDefined;
            this.orderDetail.Sales.IncotermsPart1 = this.customerSalesData.IncotermsPart1;
            this.orderDetail.Sales.IncotermsPart2 = this.customerSalesData.IncotermsPart2;
    
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

    public PageReference displayOrder()
    {
        logCallouts('displayOrder');
        if (String.isNotBlank(this.orderDetail.SalesDocument))
        {
            UTIL_PageState.current.sapOrderNum = this.orderDetail.SalesDocument;
        }
        if (null != this.orderOpportunity)
        {
            UTIL_PageState.current.sfOpportunityId = this.orderOpportunity.Id;
        }
        if (sfsObject != null) UTIL_PageState.current.sfRecordId = sfsObject.Id;
        UTIL_PageState.current.sapDocNum = this.orderDetail.SalesDocument;
        UTIL_PageState.current.sapDocType = UTIL_PageState.SAP_DocTypeOrder;
        UTIL_PageState.current.sfDocDetailFlowName = (String)UTIL_AppSettings.getValue('Order.SalesDocDetailFlowName');
        PageReference returnPage = UTIL_PageFlow.redirectTo(UTIL_PageFlow.CMP_Sales_Doc_Flow_Wrapper, UTIL_PageState.current);
        if (isClassic)
        {
            returnPage = UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_OrderDetail, UTIL_PageState.current);
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
	 * methods for creating a whole new order
	 */
    public PageReference createNewOrder()
    {
        logCallouts('createNewOrder');

        if (!validateOrder())
        {
            return null;
        }

        this.orderDetail.ITEMS_SCHEDULE.clear();

        SBO_EnosixSO_Detail sbo = new SBO_EnosixSO_Detail();
        this.orderDetail.ITEMS_ACTION.clear();
        SBO_EnosixSO_Detail.EnosixSO result = sbo.save(orderDetail);
        if (!result.isSuccess())
        {
            UTIL_ViewHelper.displayResultMessages(result.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
            return null;
        }

        system.debug('createNewOrder isSuccess');
        this.orderDetail = result;

        if (!UTIL_Order.finalizeOrderAndUpdateSfSobject(calledFrom, this.sfSObject, this.orderDetail, this.sfSObjectLineIdMap))
        {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.WARNING, 'Update of Sales Force ' + sfSObject.getSObjectType().getDescribe().getName() + ' failed'));
            return null;
        }

        ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO, 'Order was Successfully Saved.'));

        return displayOrder();
    }

    // updateOrder()
    //
    // Method to update the order
    public PageReference updateOrder()
    {
        logCallouts('updateOrder');
        if (!validateOrder())
        {
            return null;
        }

        SBO_EnosixSO_Detail sbo = new SBO_EnosixSO_Detail();

        SBO_EnosixSO_Detail.EnosixSO result = sbo.save(this.orderDetail);

        if (!result.isSuccess())
        {
            UTIL_ViewHelper.displayResultMessages(result.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
            return null;
        }

        System.debug('updateOrder isSuccess');
        this.orderDetail = result;

        if (!UTIL_Order.finalizeOrderAndUpdateSfSobject(calledFrom, this.sfSObject, this.orderDetail, this.sfSObjectLineIdMap))
        {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.WARNING, 'Update of Sales Force ' + sfSObject.getSObjectType().getDescribe().getName() + ' failed'));
            return null;
        }

        ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO, 'Order was Successfully updated.'));

        return displayOrder();
    }

    @testVisible
    private boolean validateOrder()
    {
        boolean poNumRequired = isPONumberRequired(this.orderDetail.Sales.SalesDocumentType);
        boolean validated = true;

        validated &= UTIL_ViewHelper.validateStringPropertyIsNotBlank(this.orderDetail.Sales.SalesOrganization, 'Sales Organization');
        validated &= UTIL_ViewHelper.validateStringPropertyIsNotBlank(this.orderDetail.Sales.DistributionChannel, 'DistributionChannel');
        validated &= UTIL_ViewHelper.validateStringPropertyIsNotBlank(this.orderDetail.Sales.Division, 'Division');
        validated &= UTIL_ViewHelper.validateStringPropertyIsNotBlank(this.soldToPartner.CustomerNumber, 'Sold To');
        validated &= UTIL_ViewHelper.validateStringPropertyIsNotBlank(this.shipToPartner.CustomerNumber, 'Ship To');
        if (string.isEmpty(this.orderDetail.CustomerPurchaseOrderNumber) && poNumRequired)
        {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'A PO Number is required'));
            validated = false;
        }

        if (string.isNotBlank(this.orderDetail.CustomerPurchaseOrderNumber)
                && this.orderDetail.ORDERDATA.CustomerPurchaseOrderDate == null)
        {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'A PO Date is required'));
            validated = false;
        }

        return validated;
    }

    public void checkRequestedDate()
    {
        logCallouts('checkRequestedDate');
        List<SBO_EnosixSO_Detail.ITEMS> itemList = this.orderDetail.ITEMS.getAsList();
        Integer itemTot = itemList.size();
        List<SBO_EnosixSO_Detail.ITEMS_ACTION> actionList = this.orderDetail.ITEMS_ACTION.getAsList();
        Integer actionTot = actionList.size();
        for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
        {
            SBO_EnosixSO_Detail.ITEMS item = itemList[itemCnt];
            item.ScheduleLineDate = this.orderDetail.SALES.RequestedDeliveryDate;
            SBO_EnosixSO_Detail.ITEMS_ACTION itemAction = new SBO_EnosixSO_Detail.ITEMS_ACTION();
            itemAction.ItemNumber = item.ItemNumber;
            itemAction.ItemChanged = true;

            //Check if there's an Item Action already available for the item, mainly for order create
            for (Integer actionCnt = 0 ; actionCnt < actionTot ; actionCnt++)
            {
                SBO_EnosixSO_Detail.ITEMS_ACTION action = actionList[actionCnt];
                if (item.ItemNumber == action.ItemNumber)
                {
                    itemAction = null;
                    break;
                }
            }
            if (itemAction != null)
            {
                this.orderDetail.ITEMS_ACTION.add(itemAction);
            }
        }
        this.SimulateOrder();
    }

    private boolean isPONumberRequired(string salesOrderType)
    {
        RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT orderMasterData = UTIL_Order.getOrderMasterData(salesOrderType);
        return orderMasterData == null ? false : orderMasterData.X_PONUM_REQUIRED;
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

        RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT orderMasterData = UTIL_Order.getOrderMasterData(this.orderDetail.Sales.SalesDocumentType);

        if (null != orderMasterData && string.isNotBlank(orderMasterData.INCPO))
        {
            itemIncrement = Integer.valueOf(orderMasterData.INCPO);
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
        List<SBO_EnosixSO_Detail.ITEMS> items = new List<SBO_EnosixSO_Detail.ITEMS>();

        // Validate all items first
        Integer matTot = materials.size();
        for (Integer matCnt = 0 ; matCnt < matTot ; matCnt++)
        {
            CTRL_MaterialSearch.MaterialSearchResult material = materials[matCnt];
            SBO_EnosixSO_Detail.ITEMS item = new SBO_EnosixSO_Detail.ITEMS();
            item.Material = material.material.Material;
            item.OrderQuantity = material.quantity;
            item.ScheduleLineDate = material.scheduleDate;
            if (item.ScheduleLineDate == null)
            {
                item.ScheduleLineDate = this.orderDetail.SALES.RequestedDeliveryDate;
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
            SBO_EnosixSO_Detail.ITEMS item = items[itemCnt];
            UTIL_Order.addItemToOrder(orderDetail, item, itemIncrement);
        }

        List<SBO_EnosixSO_Detail.ITEMS> itemList = this.orderDetail.ITEMS.getAsList();
        itemTot = itemList.size();
        List<SBO_EnosixSO_Detail.ITEMS_ACTION> actionList = this.orderDetail.ITEMS_ACTION.getAsList();
        Integer actionTot = actionList.size();
        for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
        {
            SBO_EnosixSO_Detail.ITEMS item = itemList[itemCnt];
            SBO_EnosixSO_Detail.ITEMS_ACTION itemAction = new SBO_EnosixSO_Detail.ITEMS_ACTION();
            itemAction.ItemNumber = item.ItemNumber;
            itemAction.ItemChanged= true;
            for (Integer actionCnt = 0 ; actionCnt < actionTot ; actionCnt++)
            {
                SBO_EnosixSO_Detail.ITEMS_ACTION action = actionList[actionCnt];
                if (action.ItemNumber == item.ItemNumber)
                {
                    itemAction = null;
                    break;
                }
            }
            if (itemAction != null)
            {
                this.orderDetail.ITEMS_ACTION.add(itemAction);
            }
        }

        this.SimulateOrder();
    }

    @testVisible
    private static boolean validateNewLineItem(SBO_EnosixSO_Detail.ITEMS item)
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
    public UTIL_Order.OrderItem editOrderItem
    {
        get
        {
            if (this.editItemNumber != null)
            {
                Integer dmiTot = this.displayedMaterialItems.size();
                for (Integer dmiCnt = 0 ; dmiCnt < dmiTot ; dmiCnt++)
                {
                    UTIL_Order.OrderItem orderItem = this.displayedMaterialItems[dmiCnt];
                    if (orderItem.item.ItemNumber == this.editItemNumber)
                    {
                        return orderItem;
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
                    UTIL_Order.OrderItem orderItem = this.displayedMaterialItems[dmiCnt];
                    if (orderItem.item.ItemNumber == this.editItemNumber)
                    {
                        orderItem = value;
                        break;
                    }
                }
            }
        }
    }

    @testVisible
    private SBO_EnosixSO_Detail.ITEMS saveOrderItem;

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
            UTIL_Order.OrderItem orderItem = this.displayedMaterialItems[dmiCnt];
            if (orderItem.isSelected) 
            {
                selectedItemsMap.put(++currentItemCnt, orderItem.item.ItemNumber);
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
        this.saveOrderItem = null;
        ItemCategories = null;
        if (editOrderItem != null)
        {
            this.saveOrderItem = new SBO_EnosixSO_Detail.ITEMS();
            this.saveOrderItem.ItemDescription = editOrderItem.item.ItemDescription;
            this.saveOrderItem.OrderQuantity = editOrderItem.item.OrderQuantity;
            this.saveOrderItem.NetItemPrice = editOrderItem.item.NetItemPrice;
            this.saveOrderItem.Plant = editOrderItem.item.Plant;
            this.saveOrderItem.ScheduleLineDate = editOrderItem.item.ScheduleLineDate;
            this.selectedMaterialDetail = UTIL_Material.getMaterialFromMaterialNumber(editOrderItem.item.Material);
        }
    }

    public void saveEditItem()
    {
        logCallouts('saveEditItem');
        SBO_EnosixSO_Detail.ITEMS_ACTION itemAction = new SBO_EnosixSO_Detail.ITEMS_ACTION();
        itemAction.ItemNumber = this.editItemNumber;
        itemAction.ItemChanged= true;

        List<SBO_EnosixSO_Detail.ITEMS_ACTION> actionList = this.orderDetail.ITEMS_ACTION.getAsList();
        Integer actionTot = actionList.size();
        for (Integer actionCnt = 0 ; actionCnt < actionTot ; actionCnt++)
        {
            SBO_EnosixSO_Detail.ITEMS_ACTION action = actionList[actionCnt];
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
            this.orderDetail.ITEMS_ACTION.add(itemAction);
        }
        if (String.isEmpty(editOrderItem.item.Plant))
        {
            editOrderItem.item.Plant = '';
            editOrderItem.item.PlantName = '';
            editOrderItem.item.ShippingPoint = '';
            editOrderItem.item.ShippingPointDescription = '';
            editOrderItem.item.Route = '';
            editOrderItem.item.RouteDescription = '';
        }
        else if (editOrderItem.item.Plant != saveOrderItem.Plant)
        {
            editOrderItem.item.ShippingPoint = '';
            editOrderItem.item.ShippingPointDescription = '';
            editOrderItem.item.Route = '';
            editOrderItem.item.RouteDescription = '';
        }

        this.saveOrderItem = null;
        setEditItemNumber();
        if (this.editItemNumber == null) this.SimulateOrder();
    }

    public void backEditItem()
    {
        itemCntIncrement = -1;
        saveEditItem();
    }

    public void cancelEditItem()
    {
        logCallouts('cancelEditItem');
        if (this.saveOrderItem != null)
        {
            editOrderItem.item.ItemDescription = this.saveOrderItem.ItemDescription;
            editOrderItem.item.OrderQuantity = this.saveOrderItem.OrderQuantity;
            editOrderItem.item.NetItemPrice = this.saveOrderItem.NetItemPrice;
            editOrderItem.item.Plant = this.saveOrderItem.Plant;
            editOrderItem.item.ScheduleLineDate = this.saveOrderItem.ScheduleLineDate;
        }
        this.saveOrderItem = null;
        setEditItemNumber();
        if (this.editItemNumber == null) this.SimulateOrder();
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
            UTIL_Order.OrderItem orderItem = this.displayedMaterialItems[dmiCnt];
            if (orderItem.isSelected && (String.isEmpty(orderItem.Item.HigherLevelItemNumber) || orderItem.Item.HigherLevelItemNumber.replaceFirst('^0+(?!$)', '') == '0')) selectedItemNumberList.add(orderItem.item.itemNumber);
        }

        Integer selectTot = selectedItemNumberList.size();
        for (Integer selectCnt = 0 ; selectCnt < selectTot ; selectCnt++)
        {
            String itemNumber = selectedItemNumberList[selectCnt];
            UTIL_Order.removeItemFromOrder(this.orderDetail, itemNumber, this.initConditions, this.sfSObjectLineIdMap);
        }

        if (selectTot > 0) this.SimulateOrder();
    }

    public void removeItemClick()
    {
        logCallouts('removeItemClick');
        String itemNumber = System.currentPageReference().getParameters().get('removeItemNumber');
        UTIL_Order.removeItemFromOrder(this.orderDetail, itemNumber, this.initConditions, this.sfSObjectLineIdMap);
        this.SimulateOrder();
    }

    public void cloneItems()
    {
        logCallouts('cloneItems');
        List<String> selectedItemNumberList = new List<String>();
        Integer dmiTot = this.displayedMaterialItems.size();
        for (Integer dmiCnt = 0 ; dmiCnt < dmiTot ; dmiCnt++)
        {
            UTIL_Order.OrderItem orderItem = this.displayedMaterialItems[dmiCnt];
            if (orderItem.isSelected && (String.isEmpty(orderItem.Item.HigherLevelItemNumber) || orderItem.Item.HigherLevelItemNumber.replaceFirst('^0+(?!$)', '') == '0')) selectedItemNumberList.add(orderItem.item.itemNumber);
        }

        Integer selectTot = selectedItemNumberList.size();
        for (Integer selectCnt = 0 ; selectCnt < selectTot ; selectCnt++)
        {
            String itemNumber = selectedItemNumberList[selectCnt];
            UTIL_Order.cloneItemToOrder(this.orderDetail, itemNumber, itemIncrement);
        }

        if (selectTot > 0) this.SimulateOrder();
    }

    public void cloneItemClick()
    {
        logCallouts('cloneItem');
        String cloneItemNumber = System.currentPageReference().getParameters().get('cloneItemNumber');
        this.editActionElementId = System.currentPageReference().getParameters().get('editActionElementId');
        UTIL_Order.cloneItemToOrder(this.orderDetail, cloneItemNumber, itemIncrement);
        this.SimulateOrder();
    }

    public void moveItemsUp()
    {
        logCallouts('moveItemsUp');
        Boolean isChanged = false;
        changeItemNumberMap.clear();
        Integer dmiTot = this.displayedMaterialItems.size();
        for (Integer dmiCnt = 0 ; dmiCnt < dmiTot ; dmiCnt++)
        {
            UTIL_Order.OrderItem orderItem = this.displayedMaterialItems[dmiCnt];
            Integer oldItemNumber = integer.valueOf(orderItem.item.ItemNumber);
            changeItemNumberMap.put(oldItemNumber, oldItemNumber);
            if (orderItem.isSelected) 
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
            moveItemsUpOrDown(this.orderDetail, changeItemNumberMap, sfSObjectLineIdMap);
            this.SimulateOrder();
        }
    }

    public void moveItemsDown()
    {
        logCallouts('moveItemsDown');
        Boolean isChanged = false;
        changeItemNumberMap.clear();
        for (Integer itemCnt = this.displayedMaterialItems.size() - 1 ; itemCnt >= 0 ; --itemCnt)
        {
            UTIL_Order.OrderItem orderItem = this.displayedMaterialItems[itemCnt];
            Integer oldItemNumber = integer.valueOf(orderItem.item.ItemNumber);
            changeItemNumberMap.put(oldItemNumber, oldItemNumber);
            if (orderItem.isSelected) 
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
            moveItemsUpOrDown(this.orderDetail, changeItemNumberMap, sfSObjectLineIdMap);
            this.SimulateOrder();
        }
    }

    @testVisible
    private static void moveItemsUpOrDown(
        SBO_EnosixSO_Detail.EnosixSO orderDetail, 
        Map<Integer, Integer> changeItemNumberMap,
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap)
    {
        UTIL_EnsxObject.moveValueObjectList(orderDetail.ITEMS, 'POSNR', changeItemNumberMap);
        UTIL_EnsxObject.moveValueObjectList(orderDetail.ITEMS_TEXT, 'POSNR', changeItemNumberMap);
        UTIL_EnsxObject.moveValueObjectList(orderDetail.ITEMS_SCHEDULE, 'POSNR', changeItemNumberMap);
        UTIL_EnsxObject.moveValueObjectList(orderDetail.ITEMS_CONFIG, 'POSNR', changeItemNumberMap);
        UTIL_EnsxObject.moveValueObjectList(orderDetail.ITEMS_ACTION, 'POSNR', changeItemNumberMap);
        UTIL_EnsxObject.moveValueObjectList(orderDetail.CONDITIONS, 'KPOSN', changeItemNumberMap);
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