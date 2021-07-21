public with sharing class CTRL_OpportunityQuotePricingRedirect
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_OpportunityQuotePricingRedirect.class);

    string oppId { get; set; }

    public CTRL_OpportunityQuotePricingRedirect(ApexPages.StandardController controller)
    {
        // NOTE: Since this maybe should use UTIL_PageState, but it's kinda weird,
        // so I'm leaving it for now
        Map<String, String> params = System.currentPageReference().getParameters();
        if (params.containsKey('addTo'))
        {
            this.oppId = params.get('addTo');

        }
        else
        {
            string ret = params.get('retURL');
            this.oppId = ret.replace('/','');
        }
    }

    public PageReference RedirectToCustomOpportunityPage()
    {
        UTIL_PageState.current.sfOpportunityId = this.oppId;
        return UTIL_PageFlow.redirectTo(
            UTIL_PageFlow.VFP_OpportunityQuotePricing, UTIL_PageState.current);
    }
}