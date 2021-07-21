public with sharing class CTRL_OrderSearch implements I_SearchController
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_OrderSearch.class);

    public Boolean showSearch { get; private set; }   // if this request come from the customer account page, hide search fields
    public String fromAccount { get; private set; }   // if this is true, then show the Back to Account button
    public Boolean hasRecords { get; private set; }   // if this is true, we have records in the grid
    public Boolean isClassic
    {
        get {return (UserInfo.getUiThemeDisplayed() == 'Theme3');}
    }

    public SBO_EnosixSO_Search orderSearch { get; set; }
    public SBO_EnosixSO_Search.EnosixSO_SC searchContext {get; private set;}
    public UTIL_PagingOptionsWrapper pagingOptionsWrapper { get; private set; } // pagination component use
    public List<SBO_EnosixSO_Search.SEARCHRESULT> orders { get; private set; } // Orders List
    public I_SearchController searchController { get { return this; } }
    @testVisible
    private string accountId { get; set; }
    private string customerId { get; set; }
    public String orderStatus { get; set; }

    public CTRL_OrderSearch()
    {
        this.orders = new List<SBO_EnosixSO_Search.SEARCHRESULT>();
        // first check to see if coming from customer page
        // if coming in from account page, lookup the accountid in the cross reference object: account_to_sap
        // add the button on account page: Sales Orders, SAP Information
        this.customerId = UTIL_PageState.current.sfAccountId;
        this.orderSearch = new SBO_EnosixSO_Search();
        this.searchContext = new SBO_EnosixSO_Search.EnosixSO_SC();
        this.showSearch = true;
        this.pagingOptionsWrapper = new UTIL_PagingOptionsWrapper(searchContext.pagingOptions);
        this.Init();
    }

    @testVisible
    void Init()
    {
        if (this.customerid != null)
        {
            this.fromAccount = this.customerid;
            Account account = UTIL_SFAccount.getAccountById(this.customerid);

            if (null == account)
            {
                ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.Error, 'SAP Customer Number not set on account.'));
                return;
            }
            else
            {
                this.searchContext.SEARCHPARAMS.SoldToParty = UTIL_SFAccount.getCustomerNumberFromAccount(account);
            }
            if (this.ordertypes != null && !this.ordertypes.isEmpty())
            {
                this.searchContext.SEARCHPARAMS.SalesDocumentType = this.ordertypes[0].getValue();
            }

            searchSO();
        }
    }

    public void searchSO()
    {
        this.searchContext.pagingOptions.pageSize = UTIL_ViewHelper.SearchDefaultPageSize;
        this.searchContext.pagingOptions.pageNumber = 1;
        runSearch();
    }

    public void runSearch()
    {
        this.searchContext.SEARCHPARAMS.OpenOnly = false;
        this.searchContext.SEARCHPARAMS.CompletedOnly = false;
        if (this.orderStatus != null && this.orderStatus == 'open')
        {
            this.searchContext.SEARCHPARAMS.OpenOnly = true;
        }
        else if (this.orderStatus != null && this.orderStatus == 'complete')
        {
            this.searchContext.SEARCHPARAMS.CompletedOnly = true;
        }

        this.orderSearch.search(this.searchContext);
        SBO_EnosixSO_Search.EnosixSO_SR searchResult = this.searchContext.result;

        if (searchResult.isSuccess())
        {
            this.hasRecords = true;
            this.orders = searchResult.getResults();
        }
        else
        {
            this.orders = null;
            UTIL_ViewHelper.displayResultMessages(searchResult.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
        }
    }

    private transient RFC_SD_GET_DOC_TYPE_VALUES.RESULT t_docTypeMaster;
    @testVisible
    private RFC_SD_GET_DOC_TYPE_VALUES.RESULT docTypeMaster
    {
        get
        {
            if (null == t_docTypeMaster)
            {
                t_docTypeMaster = UTIL_RFC.getDocTypeMaster();
            }
            return t_docTypeMaster;
        }
    }

    private static List<String> master_DocumentCategoryTypes
    {
        get
        {
            return (List<String>)UTIL_AppSettings.getList(
                'Order.DocumentCategoryTypes', String.class, new List<String>{ '*' });
        }
    }

    private static List<String> master_DocumentTypes
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
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('', 'All'));
            if (null != this.docTypeMaster)
            {
                UTIL_RFC.AddDocTypesOfCategory(options, 
                    this.docTypeMaster.ET_OUTPUT_List, 
                    master_DocumentCategoryTypes, master_DocumentTypes);
            }
            options.sort();
            return options;
        }
    }

    /**
     * helper method to populate order status picklist, it is static for now
    */
    public List<SelectOption> getOrderStatusList
    {
        get
        {
            List<SelectOption> orderstatuslist = new List<SelectOption>();
            orderstatuslist.add(new SelectOption('', 'All'));
            orderstatuslist.add(new SelectOption('open', 'Open Orders Only'));
            orderstatuslist.add(new SelectOption('complete', 'Completed Orders Only'));
            return orderstatuslist;
        }
    }

    public PageReference navigateToOrderDetail()
    {
        UTIL_PageState.current.sapOrderNum = System.currentPageReference().getParameters().get('orderId');
        return UTIL_PageFlow.redirectTo(
                UTIL_PageFlow.VFP_OrderDetail, UTIL_PageState.current);
    }

    public PageReference goToCloneOrder()
    {
        UTIL_PageState.current.sapMode = UTIL_PageState.SAP_ModeClone;
        UTIL_PageState.current.sapOrderNum = System.currentPageReference().getParameters().get('orderId');
        return UTIL_PageFlow.redirectTo(
                UTIL_PageFlow.VFP_OrderCreateUpdate, UTIL_PageState.current);
    }
}