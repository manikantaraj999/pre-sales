public with sharing class CTRL_ContactList
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_ContactList.class);

    // Account refrenced from url parameter acctId
    public Account account { get; set; }
    public String customerId { get; private set; }
    public String accountId { get; private set; }
    public SBO_EnosixCustomer_Detail.EnosixCustomer cDetail { get; set; }

    public Boolean hasAccount { get { return String.isNotBlank(accountid); } }
    public Boolean isClassic
    {
        get {return (UserInfo.getUiThemeDisplayed() == 'Theme3');}
    }

    public List<SBO_EnosixCustomer_Detail.CONTACTS> contacts
    {
        get
        {
            List<SBO_EnosixCustomer_Detail.CONTACTS> contactList =
                    new List<SBO_EnosixCustomer_Detail.CONTACTS>();

            if (null != this.cDetail)
            {
                this.cDetail.CONTACTS.copyTo(contactList);
            }

            return contactList;
        }
    }

    public CTRL_ContactList()
    {
        this.accountId = UTIL_PageState.current.sfAccountId;
        this.account = UTIL_SFAccount.getAccountById(this.accountid);
        if (null != this.account && null == this.customerid)
        {
            this.customerId = UTIL_SFAccount.getCustomerNumberFromAccount(this.account);
            UTIL_PageState.current.sapCustomerId = this.customerId;
        }
        if (null == this.customerId)
        {
            ApexPages.addMessage(new Apexpages.Message(
                ApexPages.Severity.ERROR, 'Account not configured as SAP Customer.'));
            return;
        }

        init();
    }

    private void init()
    {
        if (null != this.customerId)
        {
            this.cDetail = UTIL_Customer.getCustomerByNumber(this.customerId);
        }
    }

    public PageReference actionAddNewContact()
    {
        UTIL_PageState.current.sfAccountId = this.accountId;
        UTIL_PageState.current.sapCustomerId = this.customerId;
        return UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_ContactCreate, UTIL_PageState.current);
    }
}