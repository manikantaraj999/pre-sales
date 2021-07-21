public with sharing class CTRL_CustomerLink implements I_SearchController
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_CustomerLink.class);

    public Boolean isClassic
    {
        get {return (UserInfo.getUiThemeDisplayed() == 'Theme3');}
    }

    // Account refrenced from url parameter acctId
    public Account account {get; set;}
    public String accountid {get; private set;}

    public List<SBO_SFCICustomer_Search.SEARCHRESULT> matching_customers {get; private set;}

    public final SBO_SFCICustomer_Search search {get; private set;}
    public SBO_SFCICustomer_Search.SFCICustomer_SC searchContext {get; private set;}

    //Search parameter bindings
    public string customerName { get; set; }
    public string postalCode { get; set; }
    public string phoneNumber { get; set; }
    public string email { get; set; }

    // Pagination
    public Boolean showPaginationBar {
        get {
            return matching_customers.size() > 0;
        }
    }

    public UTIL_PagingOptionsWrapper pagingOptionsWrapper { get; private set; }
    public I_SearchController searchController { get { return this; } }

    //Maximum length of a field in the Search SBO
    private final integer MAX_LENGTH_CUSTOMERNAME = 25;
    private final integer MAX_LENGTH_PHONENUMBER = 30;
    private final integer MAX_LENGTH_EMAIL = 241;

    @testVisible
    private Account getAccount()
    {
        Account result = null;

        result = UTIL_SFAccount.getAccountById(this.accountid);
        return result;
    }

    //ctor
    public CTRL_CustomerLink()
    {
        this.accountid = UTIL_PageState.current.sfAccountId;
        account = getAccount();

        this.matching_customers = new List<SBO_SFCICustomer_Search.SEARCHRESULT>();
        this.search = new SBO_SFCICustomer_Search();
        this.searchContext = new SBO_SFCICustomer_Search.SFCICustomer_SC();
        this.pagingOptionsWrapper = new UTIL_PagingOptionsWrapper(searchContext.pagingOptions);

        init();
    }

    private void init()
    {
        //By default we're going to perform a lookup based upon a provided account ID
        customerName = account.Name;
        postalCode = account.BillingPostalCode;
        phoneNumber = account.Phone;
        runSearch();
    }

    //Wraps a string in wildcard characters for passing back to SAP
    @testVisible
    private string wildCardSearch(string fieldValue, integer maxLength)
    {
        //If the field value is too long, pre-pending the search
        //term with * will actually cause the search to fail due to the way
        //SAP truncates the search term.
        //In the case where the value is too long, SAP automatically switches to
        //a wildcard search making these unnecessary.
        if (!fieldValue.startsWith('*') && fieldValue.length() < maxLength)
            fieldValue = '*' + fieldValue;
        //No need to trim the trailing *, as it will automatically be trimmed.
        if (!fieldValue.endsWith('*'))
            fieldValue += '*';
        return fieldValue;
    }

    public void actionCustomerSearch()
    {
        this.searchContext.pagingOptions.pageSize = UTIL_ViewHelper.SearchDefaultPageSize;
        this.searchContext.pagingOptions.pageNumber = 1;
        runSearch();
    }

    public void runSearch()
    {
        matching_customers = new List<SBO_SFCICustomer_Search.SEARCHRESULT>();

        this.searchContext.SEARCHPARAMS.CustomerName =
            String.isNotBlank(customerName) ? wildCardSearch(customerName, MAX_LENGTH_CUSTOMERNAME) : customerName;

        // Phone Number does not support wild card search from the front-end.
        // It does it's own wildcarding on the backend.
        this.searchContext.SEARCHPARAMS.TelephoneNumber = phoneNumber;

        this.searchContext.SEARCHPARAMS.EmailAddress =
            String.isNotBlank(email) ? wildCardSearch(email, MAX_LENGTH_EMAIL) : email;

        // Postal code does not support wild card search
        this.searchContext.SEARCHPARAMS.PostalCode = postalCode;

        this.searchContext = search.search(this.searchContext);
        SBO_SFCICustomer_Search.SFCICustomer_SR searchResult = this.searchContext.result;

        if (!searchResult.isSuccess())
        {
            UTIL_ViewHelper.displayResultMessages(searchResult.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
        }
        else
        {
            matching_customers = searchResult.getResults();
        }
    }

    public PageReference actionLinkAccount()
    {
        String linkedCustomerNumber = System.currentPageReference().getParameters().get('linkedCustomerNumber');

        //If there was a customer to link to, redirect to the customer details
        if (null == linkedCustomerNumber)
        {
            return null;
        }

        UTIL_SFAccount.setAccountCustomerNumber(this.account, linkedCustomerNumber);
        upsert(this.account);

        UTIL_PageState.current.sfAccountId = account.id;
        return UTIL_PageFlow.redirectTo(
            UTIL_PageFlow.VFP_CustomerDetail, UTIL_PageState.current);
    }

    public PageReference GoToCreateCustomer()
    {
        return UTIL_Customer.redirectToCreateCustomer();
    }
}