public with sharing class CTRL_OpportunityInfo
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_OpportunityInfo.class);

    public Opportunity sfOpportunity { get; set; }
    public Account sfAccount { get; set; }

    public string sfOpportunityId
    {
        get
        {
            return this.sfOpportunity.Id;
        }
        set
        {
            if (!String.isBlank(value)) this.sfOpportunity = (Opportunity) UTIL_SFSObjectDoc.getSObject(value);
        }
    }

    public string QuoteNumber
    {
        get
        {
            return (String) this.sfOpportunity.get(UTIL_SFOpportunity.QuoteFieldName);
        }
    }

    public string OrderNumber
    {
        get
        {
            return (String) this.sfOpportunity.get(UTIL_SFOpportunity.OrderFieldName);
        }
    }

    public PageReference redirectToQuoteDetail()
    {
        UTIL_PageState.current.sapQuoteId = UTIL_SFSObjectDoc.getQuoteNumber(sfOpportunity);
        return UTIL_PageFlow.redirectTo(
            UTIL_PageFlow.VFP_QuoteDetail, UTIL_PageState.current);
    }

    public PageReference redirectToOrderDetail()
    {
        UTIL_PageState.current.sapOrderNum = UTIL_SFSObjectDoc.getOrderNumber(sfOpportunity);
        return UTIL_PageFlow.redirectTo(
            UTIL_PageFlow.VFP_OrderDetail, UTIL_PageState.current);
    }
}