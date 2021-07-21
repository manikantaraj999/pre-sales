public with sharing class CTRL_ReturnOrderSearch implements I_SearchController
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_ReturnOrderSearch.class);
    public Boolean isClassic
    {
        get {return (UserInfo.getUiThemeDisplayed() == 'Theme3');}
    }

    SBO_EnosixRO_Search returnOrderSearch = new SBO_EnosixRO_Search();
    SBO_EnosixRO_Search.EnosixRO_SC searchContext = new SBO_EnosixRO_Search.EnosixRO_SC();

    public List<SBO_EnosixRO_Search.SEARCHRESULT> searchResults { get; set; }
    public string soldToParty { get; set; }

    // Paging Search; Interface, Wrapper, Flag
    public UTIL_PagingOptionsWrapper pagingOptionsWrapper { get; private set; }
    public I_SearchController searchController { get { return this; } }
    public Boolean hasRecords { get; private set; }

    public CTRL_ReturnOrderSearch()
    {
        searchResults = new List<SBO_EnosixRO_Search.SEARCHRESULT>();
        searchResults = new List<SBO_EnosixRO_Search.SEARCHRESULT>();
        this.pagingOptionsWrapper = new UTIL_PagingOptionsWrapper(searchContext.pagingOptions);
    }

    //ToDo: Test call? No reference
    public void init()
    {
        String casID = UTIL_PageState.current.sfCaseId;
        if (string.isNotBlank(casID))
        {
            Case cas = UTIL_ObjectLookups.getCaseById(casID);
            if (null != cas)
            {
                SBO_EnosixCustomer_Detail.EnosixCustomer customerDetail =
                    UTIL_ObjectLookups.GetCustomerForCase(cas);
                if (null != customerDetail && null != customerDetail.CustomerNumber)
                {
                    soldToParty = customerDetail.CustomerNumber;
                    this.searchForReturnOrders();
                    return;
                }
            }
            else
            {
                System.debug('case was null');
            }
        }
    }

    // Is called by the search button; resets pageNumbers,pageSize calls runSearch.
    public void searchForReturnOrders()
    {
        searchContext.pagingOptions.pageSize = UTIL_ViewHelper.SearchDefaultPageSize;
        searchContext.pagingOptions.pageNumber = 1;
        hasRecords = false;
        this.runSearch();
    }

    public void runSearch()
    {
        if (this.soldToParty != null & this.soldToParty != '')
        {
            searchContext.SEARCHPARAMS.SoldToParty = this.soldToParty;
        }

        searchContext = returnOrderSearch.search(searchContext);
        SBO_EnosixRO_Search.EnosixRO_SR sr = searchContext.result;

        if (sr.isSuccess())
        {
            this.searchResults = sr.getResults();
            hasRecords = true;
        }
        else
        {
            searchResults = null;
            UTIL_ViewHelper.displayResultMessages(sr.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
        }
    }

    public PageReference navigateToRMADetail()
    {
        UTIL_PageState.current.sapRmaId = System.currentPageReference().getParameters().get('rmaId');
        return UTIL_PageFlow.redirectTo(
            UTIL_PageFlow.VFP_ReturnOrderDetail, UTIL_PageState.current);
    }
}