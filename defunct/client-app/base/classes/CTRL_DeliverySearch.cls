/**
 * controller to display sales order listings and quote listings 
 * (NOTE: QUOTE AND SO share the same search controller!!!)
 *
 * if account id is passed in, from account = true, then do not show the search section
 *
 * if coming from a salesforce tab, show search section
 */
public with sharing class CTRL_DeliverySearch implements I_SearchController
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_DeliverySearch.class);

    // if this request come from the customer account page, hide search fields
    public Boolean showSearch {get; private set;}  
     
    // if this is true, then show the Back to Account button
    public String fromAccount {get; private set;}   
    public Boolean hasRecords { get; private set; }

    public SBO_EnosixDL_Search deliveryListSearch {get; set;}
    public SBO_EnosixDL_Search.EnosixDL_SC searchContext {get; set;}
    public List<SBO_EnosixDL_Search.SEARCHRESULT> dls {get; private set;}  // paginated

    public UTIL_PagingOptionsWrapper pagingOptionsWrapper { get; private set; } // pagination use
    public I_SearchController searchController { get { return this; } }

    public Boolean isClassic
	{
		get {return (UserInfo.getUiThemeDisplayed() == 'Theme3');}
	}

    public CTRL_DeliverySearch()
    {
        this.dls = new List<SBO_EnosixDL_Search.SEARCHRESULT>();
        // first check to see if coming from customer page
        // if coming in from account page, lookup the accountid in the cross reference object: account_to_sap
        // add the button on account page: Sales Orders, SAP Information
        String accountId = UTIL_PageState.current.sfAccountId;
        this.deliveryListSearch = new SBO_EnosixDL_Search();
        this.searchContext = new SBO_EnosixDL_Search.EnosixDL_SC();
        this.pagingOptionsWrapper = new UTIL_PagingOptionsWrapper(searchContext.pagingOptions);
        this.showSearch = true;  // for now still show the search page
        this.hasRecords = false;

        if (accountId != null)
        {
            this.fromAccount = accountId;
            Account account = UTIL_SFAccount.getAccountById(accountId);

            // run search
            this.searchContext.SEARCHPARAMS.SoldToParty = UTIL_SFAccount.getCustomerNumberFromAccount(account);

            searchDL();
        }
    }

    public void searchDL()
    {
        this.searchContext.pagingOptions.pageSize = UTIL_ViewHelper.SearchDefaultPageSize;		
        this.searchContext.pagingOptions.pageNumber = 1;
        runSearch();
    }

    public void runSearch()
    {
        this.deliveryListSearch.search(this.searchContext);
        SBO_EnosixDL_Search.EnosixDL_SR searchResult = this.searchContext.result;

        if (searchResult.isSuccess())
        {
            this.dls = searchResult.getResults();
            this.hasRecords = true;
        }
        else 
        {
            this.hasRecords = false;
            this.dls = null;
            UTIL_ViewHelper.displayResultMessages(searchResult.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
        }
    }

    public PageReference gotoDeliveryDetail()
    {
        String deliveryId = System.currentPageReference().getParameters().get('deliveryID');
        UTIL_PageState.current.sapDeliveryNum = deliveryId;
        return UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_DeliveryDetail, UTIL_PageState.current);
    }
}