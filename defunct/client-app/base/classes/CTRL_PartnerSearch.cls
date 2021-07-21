public virtual with sharing class CTRL_PartnerSearch implements I_SearchController
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_PartnerSearch.class);

    public Boolean showSearch { get; private set; }
    public String accountId { get; private set; }
    public Account account { get; set; }
    public String customerid { get; private set; }
    public Boolean hasRecords { get; private set; }

    public SBO_SFCIPartner_Search partnerSearch { get; set; }
    public SBO_SFCIPartner_Search.SFCIPartner_SC searchContext {get; private set;}
    public UTIL_PagingOptionsWrapper pagingOptionsWrapper { get; private set; } // pagination component use
    public List<SBO_SFCIPartner_Search.SEARCHRESULT> partners { get; private set; } //Partners List
    public I_SearchController searchController { get { return this; } }

    public boolean hasAccount { get { return String.isNotBlank(accountid); } }
    public Boolean isClassic
    {
        get {return (UserInfo.getUiThemeDisplayed() == 'Theme3');}
    }

    @testVisible
    private transient SBO_EnosixCustomer_Detail.EnosixCustomer t_cDetail;
    public SBO_EnosixCustomer_Detail.EnosixCustomer cDetail
    {
        get
        {
            if (null == t_cDetail && String.isNotEmpty(this.customerid))
            {
                t_CDetail = UTIL_Customer.getCustomerByNumber(this.customerId);
            }
            return t_CDetail;
        }
    }

    public List<SelectOption> SalesOrganizations
    {
        get
        {
            List<SelectOption> result = new List<SelectOption>();
            if (null != this.cDetail)
            {
                result.add(new SelectOption('', ''));
                UTIL_Customer.AddSalesOrganizations(result, UTIL_Customer.getSalesDataListFromCustomer(this.cDetail));
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
            if (null != this.cDetail)
            {
                result.add(new SelectOption('', ''));
                UTIL_Customer.AddDistributionChannels(result, UTIL_Customer.getSalesDataListFromCustomer(this.cDetail),
                    this.searchContext.SEARCHPARAMS.SalesOrganization);
            }

            return result;
        }
    }

    public List<SelectOption> Divisions
    {
        get
        {
            List<SelectOption> result = new List<SelectOption>();

            if (null != this.cDetail)
            {
                result.add(new SelectOption('', ''));
                UTIL_Customer.AddDistributionDivisions(result, UTIL_Customer.getSalesDataListFromCustomer(this.cDetail),
                    this.searchContext.SEARCHPARAMS.SalesOrganization, this.searchContext.SEARCHPARAMS.DistributionChannel);
            }

            return result;
        }
    }

    private Set<String> shipToParentPartnerTypes
    {
        get
        {
            return (Set<String>)UTIL_AppSettings.getSet(
                'Customer.ShipToParentPartnerTypes', String.class, new Set<String>{'*'});
        }
    }

    public Boolean showShipToCreate
    {
        get
        {
            Boolean result = false;
            if (shipToParentPartnerTypes.contains('*') || shipToParentPartnerTypes.contains(this.cDetail.BusinessPartnerType))
            {
                result = true;
            }
            return result;
        }
    }

    public CTRL_PartnerSearch()
    {
        this.accountId = UTIL_PageState.current.sfAccountId;
        this.partnerSearch = new SBO_SFCIPartner_Search();
        this.partners = new List<SBO_SFCIPartner_Search.SEARCHRESULT>();
        this.searchContext = new SBO_SFCIPartner_Search.SFCIPartner_SC();
        this.showSearch = true;
        this.pagingOptionsWrapper = new UTIL_PagingOptionsWrapper(searchContext.pagingOptions);
        this.Init();
    }

    @testVisible
    void Init()
    {
        if (this.accountId != null)
        {
            account = UTIL_SFAccount.getAccountById(this.accountId);
            if (null != account)
            {
                this.customerid = UTIL_SFAccount.getCustomerNumberFromAccount(account);
            }

            if (null == this.customerid)
            {
                ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.Error, 'SAP Customer Number not set on account.'));
                return;
            }

            UTIL_PageState.current.sapCustomerId = this.customerid;
            this.searchContext.SEARCHPARAMS.CustomerNumber = this.customerid;

            searchSO();
        }
    }

    public void searchSO()
    {
        this.searchContext.pagingOptions.pageSize = UTIL_ViewHelper.SearchDefaultPageSize;
        this.searchContext.pagingOptions.pageNumber = 1;
        runSearch();
    }

    @testVisible
    public void runSearch()
    {
        this.partnerSearch.search(this.searchContext);
        SBO_SFCIPartner_Search.SFCIPartner_SR searchResult = this.searchContext.result;

        if (searchResult.isSuccess())
        {
            this.hasRecords = true;
            this.partners = searchResult.getResults();
        }
        else
        {
            this.partners = null;
            UTIL_ViewHelper.displayResultMessages(searchResult.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
        }
    }

    public PageReference actionAddShipTo()
    {
        UTIL_PageState state = new UTIL_PageState();
        state.sapPartnerType = UTIL_Customer.SHIP_TO_PARTNER_CODE;
        if (null != this.customerid) state.sapAddPartnerTo = this.customerid;
        if (null != this.accountid) state.sfAccountId = this.accountid;
        return UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_CustomerCreateUpdate, state);
    }

    public PageReference gotoCustomerPage()
    {
        String selectedCustomerId = System.currentPageReference().getParameters().get('selectedCustomerId');

        UTIL_PageState.current.sapCustomerId = selectedCustomerId;
        UTIL_PageState.current.sfAccountId = this.accountId;
        return UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_CustomerDetail, UTIL_PageState.current);
    }
}