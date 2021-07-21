public with sharing class CTRL_CustomerMissing
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_CustomerMissing.class);

    public String accountId { get; private set; }

    public CTRL_CustomerMissing()
    {
        this.accountId = UTIL_PageState.current.lookupAccountId();
    }

    public PageReference actionCreateCustomer()
    {
        UTIL_PageState.current.sfAccountId = this.accountId;
        return UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_CustomerCreateUpdate, UTIL_PageState.current);
    }

    public PageReference actionLinkCustomer()
    {
        UTIL_PageState.current.sfAccountId = this.accountId;
        return UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_CustomerLink, UTIL_PageState.current);
    }
}