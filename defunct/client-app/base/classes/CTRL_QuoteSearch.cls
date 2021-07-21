/**
 * controller to display sales quote listings and quote listings
 *
 * if account id is passed in, from account = true, then do not show the search section
 *
 * if coming from a salesforce tab, show search section
 */
public with sharing class CTRL_QuoteSearch implements I_SearchController
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_QuoteSearch.class);

    public Boolean showSearch { get; private set; }   // if this request come from the customer account page, hide search fields
    public String fromAccount { get; private set; }   // if this is true, then show the Back to Account button
    public Boolean hasRecords { get; private set; }

    public SBO_EnosixQuote_Search quoteSearch { get; set; }
    public SBO_EnosixQuote_Search.EnosixQuote_SC searchContext { get; set; }
    public UTIL_PagingOptionsWrapper pagingOptionsWrapper { get; private set; } // pagination use
    public I_SearchController searchController { get { return this; } }

    public List<SBO_EnosixQuote_Search.SEARCHRESULT> quotes { get; private set; } // dataSet

    @testVisible
    private String accountId { get; set; }
    @testVisible
    private String customerId { get; set; }
    public String quoteStatus { get; set; }
    public Boolean isClassic
    {
        get {return (UserInfo.getUiThemeDisplayed() == 'Theme3');}
    }

    public CTRL_QuoteSearch()
    {
        // first check to see if coming from customer page
        // if coming in from account page, lookup the accountid in the cross reference object: account_to_sap
        // add the button on account page: Quotes, SAP Information
        this.accountId = UTIL_PageState.current.sfAccountId;

        quoteSearch = new SBO_EnosixQuote_Search();
        searchContext = new SBO_EnosixQuote_Search.EnosixQuote_SC();
        showSearch = true;  // for now still show the search page
        this.pagingOptionsWrapper = new UTIL_PagingOptionsWrapper(searchContext.pagingOptions);

        Init();
    }

    @testVisible
    void Init()
    {
        if (accountId != null)
        {
            Account account = UTIL_SFAccount.getAccountById(accountId);
            if (null == account)
            {
                ApexPages.addMessage(new Apexpages.Message(
                    ApexPages.Severity.Error, 'SAP Customer Number not set on account.'));
                return;
            }
            else
            {
                searchContext.SEARCHPARAMS.SoldToParty = UTIL_SFAccount.getCustomerNumberFromAccount(account);
            }

            searchQuote();
        }
    }

    /**
     * handles the searching of quote and display data in the grid
     * @return [description]
     */
    public void searchQuote()
    {
        searchContext.pagingOptions.pageSize = UTIL_ViewHelper.SearchDefaultPageSize;
        searchContext.pagingOptions.pageNumber = 1;
        hasrecords = false;
        runSearch();
    }

    public void runSearch()
    {
        searchContext.SEARCHPARAMS.OpenOnly = false;
        searchContext.SEARCHPARAMS.CompletedOnly = false;
        if (quoteStatus != null && quoteStatus == 'open')
        {
            searchContext.SEARCHPARAMS.OpenOnly = true;
        }
        else if (quoteStatus != null && quoteStatus == 'complete')
        {
            searchContext.SEARCHPARAMS.CompletedOnly = true;
        }

        quoteSearch.search(searchContext);
        SBO_EnosixQuote_Search.EnosixQuote_SR searchResult = searchContext.result;

        if (searchResult.isSuccess())
        {
            quotes = searchResult.getResults();
            hasRecords = true;
        }
        else
        {
            quotes = null;
            UTIL_ViewHelper.displayResultMessages(searchResult.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
        }
    }

    /**
     * helper method to populate order status picklist, it is static for now
    */
    public List<SelectOption> getquotestatuslist()
    {
        List<SelectOption> quoteStatusList = new List<SelectOption>();
        quoteStatusList.add(new SelectOption('', 'All'));
        quoteStatusList.add(new SelectOption('open', 'Open Quotes Only'));
        quoteStatusList.add(new SelectOption('complete', 'Completed Quotes Only'));
        return quoteStatusList;
    }

    public PageReference navigateToQuoteDetail()
    {
        UTIL_PageState.current.sapQuoteId = System.currentPageReference().getParameters().get('quoteId');
        return UTIL_PageFlow.redirectTo(
                UTIL_PageFlow.VFP_QuoteDetail, UTIL_PageState.current);
    }

    public PageReference goToCloneQuote()
    {
        UTIL_PageState.current.sapMode = UTIL_PageState.SAP_ModeClone;
        UTIL_PageState.current.sapQuoteId = System.currentPageReference().getParameters().get('quoteId');
        return UTIL_PageFlow.redirectTo(
                UTIL_PageFlow.VFP_QuoteCreateUpdate, UTIL_PageState.current);
    }

    public PageReference goToCreateOrder()
    {
        UTIL_PageState.current.sapMode = UTIL_PageState.SAP_ModeReference;
        UTIL_PageState.current.sapQuoteId = System.currentPageReference().getParameters().get('quoteId');
        UTIL_PageState.current.sapDocType = System.currentPageReference().getParameters().get('SalesDocumentType');
        return UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_OrderCreateUpdate, UTIL_PageState.current);
    }
}