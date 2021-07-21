public with sharing class CTRL_CaseInfo
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_CaseInfo.class);

    public Case sfCase { get; set; }

    public string sfCaseId
    {
        get
        {
            return this.sfCase.id;
        }
        set
        {
            this.sfCase = UTIL_ObjectLookups.getCaseById(value);
        }
    }

    public PageReference redirectToOrderDetail()
    {
        UTIL_PageState.current.sapRmaId = sfCase.FLD_SAP_Return_Order_Number__c;
        return UTIL_PageFlow.redirectTo(
            UTIL_PageFlow.VFP_ReturnOrderDetail, UTIL_PageState.current);
    }
}