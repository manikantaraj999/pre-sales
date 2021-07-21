// Use current page state to render a number of buttons that can take user
// to where they want to be
public with sharing class CTRL_NavButtons
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_NavButtons.class);

    public String caseId { get { return UTIL_PageState.current.sfCaseId; } }
    public String docflowDocNum { get; set; }
    public String opportunityId { get { return UTIL_PageState.current.sfOpportunityId; } }

    // actionGotoDoc()
    //
    // send user to SF doc with the given docNum
    public PageReference actionGotoDoc()
    {
        String docNum = System.currentPageReference().getParameters().get('docNum');
        return UTIL_PageFlow.redirectTo('/' + docNum, null);
    }

    // actionGotoDocFlow()
    //
    // Navigate to SD DocFlow with the current docflowDocNum selected
    public PageReference actionGotoDocFlow()
    {
        UTIL_PageState.current.sapDocNum = this.docflowDocNum;
        return UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_DocFlowSearch, UTIL_PageState.current);
    }

    public String accountId
    {
        get
        {
            // If we don't have the accountId, try to get it from the current state
            if (null == this.accountId)
            {
                this.accountId = UTIL_PageState.current.lookupAccountId();
            }
            return this.accountId;
        }
        private set;
    }
}