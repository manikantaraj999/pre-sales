public with sharing class CTRL_InvoiceSearch implements I_SearchController
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_InvoiceSearch.class);

    // if this request come from the customer account page, hide search fields
    public Boolean showSearch {get; private set;}
    
    // if this is true, then show the Back to Account button
    public String fromAccount {get; private set;}   
    public Boolean hasRecords { get; private set; }
    public Boolean isClassic 
    {
        get {return (UserInfo.getUiThemeDisplayed() == 'Theme3');}
    }

    public SBO_EnosixInvoice_Search invoiceSearch {get; set;}
    public SBO_EnosixInvoice_Search.EnosixInvoice_SC searchContext {get; set;}
    public I_SearchController searchController { get { return this; } }

    // paginated
    public List<SBO_EnosixInvoice_Search.SEARCHRESULT> invoiceSearchList {get; private set;}  

    // pagination use
    public UTIL_PagingOptionsWrapper pagingOptionsWrapper { get; private set; } 

    public RFC_SD_GET_SALES_AREAS.RESULT salesAreaMaster;

    public List<SelectOption> SalesOrganizations
    {
        get
        {
            List<SelectOption> result = UTIL_SelectOption.buildOptionsFromList(
    				new UTIL_SalesArea.SalesOrganization_OptionBuilder(false),
    				this.salesAreaMaster.SalesAreas_List, true);
            result = UTIL_SelectOption.getOptionsByUniqueValue(result);

            return result;
        }
    }

    public CTRL_InvoiceSearch()
    {
        // first check to see if coming from customer page
        // if coming in from account page, lookup the accountid in the cross reference object: account_to_sap
        // add the button on account page: Sales Orders, SAP Information
        String accountId = UTIL_PageState.current.sfAccountId;
        this.salesAreaMaster = UTIL_SalesArea.getSalesAreaMaster();
        this.invoiceSearch = new SBO_EnosixInvoice_Search();
        this.searchContext = new SBO_EnosixInvoice_Search.EnosixInvoice_SC();
        this.pagingOptionsWrapper = new UTIL_PagingOptionsWrapper(searchContext.pagingOptions);
        this.showsearch = true;  // for now still show the search page

        if (accountId != null)
        {
            this.fromaccount = accountId;
            Account account = UTIL_SFAccount.getAccountById(accountId);

            // run search
            this.searchContext.SEARCHPARAMS.SoldToParty = UTIL_SFAccount.getCustomerNumberFromAccount(account);
            searchInvoice();
        }
    }

    // Is called by the search button; resets pageNumbers,pageSize calls runSearch
    public void searchInvoice()
    {
        this.searchContext.pagingOptions.pageSize = UTIL_ViewHelper.SearchDefaultPageSize;
        this.searchContext.pagingOptions.pageNumber = 1;
        runSearch();
    }

    public void runSearch()
    {
        this.searchContext = this.invoiceSearch.search(this.searchContext);
        SBO_EnosixInvoice_Search.EnosixInvoice_SR searchResult = this.searchContext.result;

        if (searchResult.isSuccess()) {
            this.hasRecords = true;
            this.invoiceSearchList = searchResult.getResults();
        }
        else
        {
            this.invoiceSearchList = null;
            UTIL_ViewHelper.displayResultMessages(searchResult.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
        }
    }

    public Pagereference goToInvoiceDetail()
    {
        String invoiceNum = System.currentPageReference().getParameters().get('invoiceNumber');
        UTIL_PageState.current.sapInvoiceNum = invoiceNum;
        return UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_InvoiceDetail, UTIL_PageState.current);
    }
}