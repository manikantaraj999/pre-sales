public virtual with sharing class CTRL_CustomerDetail
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_CustomerDetail.class);

    public Boolean isClassic 
    {
        get {return (UserInfo.getUiThemeDisplayed() == 'Theme3');}
    }

    public Boolean isFromOrder 
    {
        get
        {
            return UTIL_PageState.current.sapPreviousScreen == UTIL_PageState.SAP_PreviousScreenOrder;
        }
    }

    public Boolean isFromQuote 
    {
        get
        {
            return UTIL_PageState.current.sapPreviousScreen == UTIL_PageState.SAP_PreviousScreenQuote;
        }
    }

    public Boolean isFromOpp 
    {
        get
        {
            return UTIL_PageState.current.sapPreviousScreen == UTIL_PageState.SAP_PreviousScreenOpp;
        }
    }

    // Account refrenced from url parameter acctId
    public Account account { get; set; }

    public String customerid { get; private set; }
    public String accountid { get; private set; }
    public String caseid { get; private set; }
    public String opportunityid { get; private set; }

    @testVisible
    private transient SBO_EnosixCustomer_Detail.EnosixCustomer t_cDetail;
    public SBO_EnosixCustomer_Detail.EnosixCustomer cDetail
    {
        get
        {
            if (null == t_cDetail && String.isNotEmpty(this.customerid))
            {
                t_cDetail = UTIL_Customer.getCustomerByNumber(this.customerId);
            }
            return t_cDetail;
        }
        set
        {
            t_cDetail = value;
        }
    }

    public boolean showCompanyInfo { get { return CompanyList.size() > 0; } }
    public boolean showSalesAreas { get { return SalesAreaList.size() > 0; } }
    public boolean hasAccount { get { return String.isNotBlank(accountid); } }

    @testVisible
    private Set<String> shipToParentPartnerTypes
    {
        get
        {
            return (Set<String>)UTIL_AppSettings.getSet(
                'Customer.ShipToParentPartnerTypes', String.class, new Set<String>{'*'});
        }
    }

    public List<SBO_EnosixCustomer_Detail.COMPANY_DATA> CompanyList
    {
        get
        {
            List<SBO_EnosixCustomer_Detail.COMPANY_DATA> result =
                new List<SBO_EnosixCustomer_Detail.COMPANY_DATA>();

            if (null != this.cDetail)
            {
                this.cDetail.COMPANY_DATA.copyTo(result);
            }
            return result;
        }
    }

    public List<SBO_EnosixCustomer_Detail.SALES_DATA> SalesAreaList
    {
        get
        {
            List<SBO_EnosixCustomer_Detail.SALES_DATA> result =
                new List<SBO_EnosixCustomer_Detail.SALES_DATA>();

            if (null != this.cDetail)
            {
                this.cDetail.SALES_DATA.copyTo(result);
            }
            return result;
        }
    }

    public List<SBO_EnosixCustomer_Detail.CREDIT> CreditList
    {
        get
        {
            List<SBO_EnosixCustomer_Detail.CREDIT> result =
                new List<SBO_EnosixCustomer_Detail.CREDIT>();

            if (null != this.cDetail)
            {
                // this.cDetail.CREDIT used to be a collection, but is now just one row (a struct),
                // but treating this as a list is easier than refactoring the view
                result.add(this.cDetail.CREDIT);
            }
            return result;
        }
    }

    @testVisible
    private Account getAccount()
    {
        Account result = null;

        // Lookup by page params caseId, then customerId, then accountId
        if (this.caseid != null)
        {
            Case sfCase = UTIL_ObjectLookups.getCaseById(this.caseid);
            result = UTIL_SFAccount.getAccountById(sfCase.AccountId);
        }
        else if (this.accountid != null && this.customerid != null)
        {
            result = UTIL_SFAccount.getAccountById(this.accountid);
        }
        else if (this.customerid != null)
        {
            result = UTIL_SFAccount.getAccountByCustomerNumber(this.customerid);
        }
        else
        {
            result = UTIL_SFAccount.getAccountById(this.accountid);
        }
        return result;
    }

    @testVisible
    public string FormattedPhone
    {
        get
        {
            return UTIL_ViewHelper.formatPhoneForDisplay(
                this.cDetail.TelephoneNumber, this.cDetail.TelephoneNumberExtension);
        }
    }

    @testVisible
    public string FormattedFax
    {
        get
        {
            return UTIL_ViewHelper.formatPhoneForDisplay(
                this.cDetail.FaxNumber, this.cDetail.FaxNumberExtension);
        }
    }

    @testVisible
    private void refreshIdsFromAccount(Account account)
    {
        if (null != account)
        {
            this.accountid = account.id;
            UTIL_PageState.current.sfAccountId = this.accountid;

            if (null == this.customerid)
            {
                this.customerid = UTIL_SFAccount.getCustomerNumberFromAccount(account);
                UTIL_PageState.current.sapCustomerId = this.customerid;
            }
        }
    }

    //constuctor
    public CTRL_CustomerDetail()
    {
        this.accountid = UTIL_PageState.current.sfAccountId;
        this.caseid = UTIL_PageState.current.sfCaseId;
        this.customerid = UTIL_PageState.current.sapCustomerId;
        this.opportunityid = UTIL_PageState.current.sfOpportunityId;
        this.account = getAccount();
        if ((this.accountid == null || this.accountid == '') && this.account != null)
        {
            this.accountid = account.Id;
        }
        refreshIdsFromAccount(this.account);
    }

    public PageReference GoToCreateCustomer()
    {
        return UTIL_Customer.redirectToCreateCustomer();
    }

    public PageReference actionAddShipTo()
    {
        UTIL_PageState state = new UTIL_PageState();
        state.sapPartnerType = UTIL_Customer.SHIP_TO_PARTNER_CODE;
        if (null != this.cDetail) state.sapAddPartnerTo = this.cDetail.CustomerNumber;
        if (null != account) state.sfAccountId = account.Id;
        return UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_CustomerCreateUpdate, state);
    }

    public PageReference updateSAPCustomer()
    {
        UTIL_PageState.current.sapMode = UTIL_PageState.SAP_ModeUpdate;
        return UTIL_Customer.redirectToEditCustomer();
    }

    public PageReference gotoCustomerPage()
    {
        String selectedCustomerId = System.currentPageReference().getParameters().get('selectedCustomerId');

        UTIL_PageState.current.sapCustomerId = selectedCustomerId;
        UTIL_PageState.current.sfAccountId = this.accountId;

        return UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_CustomerDetail, UTIL_PageState.current);
    }

    public PageReference GoToCustomerLinkPage()
    {
        UTIL_PageState.current.sfAccountId = this.accountId;
        return UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_CustomerLink, UTIL_PageState.current);
    }

    public PageReference redirectToOrderPage()
    {
        return UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_OrderCreateUpdate, UTIL_PageState.current);
    }

    public PageReference redirectToQuotePage()
    {
        return UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_QuoteCreateUpdate, UTIL_PageState.current);
    }

    public PageReference redirectToOppPage()
    {
        return UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_OpportunityQuotePricing, UTIL_PageState.current);
    }
}