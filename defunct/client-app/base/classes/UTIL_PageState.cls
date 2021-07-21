// This class manages all interaction with the query string and keeps track of
// which IDs are available for the current page such as customer, account, case,
// etc.
//
// If you need to add a new query string param:
//  1) Add a strongly typed param name at the top
//     (i.e. private static final String SF_AcctId)
//  2) Add the new name to the allParams list
//
//  3) Add a property with a developer-friendly name
//     (i.e. public String sfAccountId)
public class UTIL_PageState
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_PageState.class);

    private static final String SAP_AddPartnerTo = 'c__SAP_AddPartnerTo';
    private static final String SAP_CustId = 'c__SAP_CustId';
    private static final String SAP_DeliveryItem = 'c__SAP_DeliveryItem';
    private static final String SAP_DeliveryNum = 'c__SAP_DeliveryNum';
    private static final String SAP_DocNum = 'c__SAP_DocNum';
    private static final String SAP_DocType = 'c__SAP_DocType';
    public static final String SAP_DocTypeQuote = 'Quote';
    public static final String SAP_DocTypeOrder = 'Order';
    private static final String SAP_InvoiceNum = 'c__SAP_InvoiceNum';
    private static final String SAP_ItemNum = 'c__SAP_ItemNum';
    public static final String SAP_Mode = 'c__SAP_Mode';
    public static final String SAP_ModeCreate = 'c__SAP_ModeCreate';
    public static final String SAP_ModeUpdate = 'c__SAP_ModeUpdate';
    public static final String SAP_ModeClone = 'c__SAP_ModeClone';
    public static final String SAP_ModeOrder = 'c__SAP_ModeOrder';
    public static final String SAP_ModeQuote = 'c__SAP_ModeQuote';
    public static final String SAP_ModeReference = 'c__SAP_ModeReference';
    private static final String SAP_NoteType = 'c__SAP_NoteType';
    public static final String SAP_OrderNum = 'c__SAP_OrderNum';
    private static final String SAP_PartnerType = 'c__SAP_PartnerType';
    private static final String SAP_PreviousScreen = 'c__SAP_PreviousScreen';
    public static final String SAP_PreviousScreenOrder = 'c__SAP_PreviousScreenOrder';
    public static final String SAP_PreviousScreenQuote = 'c__SAP_PreviousScreenQuote';
    public static final String SAP_PreviousScreenOpp = 'c__SAP_PreviousScreenOpp';
    public static final String SAP_QuoteId = 'c__SAP_QuoteId';
    private static final String SAP_RmaId = 'c__SAP_RmaId';
    private static final String SAP_SalesArea = 'c__SAP_SalesArea';
    private static final String SAP_ShipToNum = 'c__SAP_ShipToNum';

    public static final String SF_AcctId = 'c__SF_AcctId';
    private static final String SF_CaseId = 'c__SF_CaseId';
    private static final String SF_ContactId = 'c__SF_ContactId';
    private static final String SF_CPQQuoteId = 'c__SF_CPQQuoteId';
    private static final String SF_MatId = 'c__SF_MatId';
    private static final String SF_OppId = 'c__SF_OppId';
    private static final String SF_OppProdId = 'c__SF_OppProdId';
    private static final String SF_PlantId = 'c__SF_PlantId';
    private static final String SF_ProductId = 'c__SF_ProductId';
    private static final String SF_QuoteId = 'c__SF_QuoteId';
    private static final String SF_Record_Id = 'c__SF_Record_Id';
    private static final String SF_SAP_DocNum = 'c__SF_SAP_DocNum';
    private static final String SF_DocDetailFlowName = 'c__SF_DocDetailFlowName';

    private static final string ENSX_Page = 'c__ENSX_Page';
    private static final String ENSX_ReturnTo = 'c__ENSX_ReturnTo';

    // This stores the actual query params
    @testVisible
    private Map<String, String> values;

    private static final List<String> allParams = new List<String> {
        SAP_AddPartnerTo,
        SAP_CustId,
        SAP_DeliveryItem,
        SAP_DeliveryNum,
        SAP_DocNum,
        SAP_DocType,
        SAP_InvoiceNum,
        SAP_ItemNum,
        SAP_Mode,
        SAP_NoteType,
        SAP_OrderNum,
        SAP_PartnerType,
        SAP_PreviousScreen,
        SAP_QuoteId,
        SAP_RmaId,
        SAP_SalesArea,
        SAP_ShipToNum,
        SF_AcctId,
        SF_CaseId,
        SF_ContactId,
        SF_CPQQuoteId,
        SF_MatId,
        SF_OppId,
        SF_OppProdId,
        SF_PlantId,
        SF_ProductId,
        SF_QuoteId,
        SF_Record_Id,
        SF_SAP_DocNum,
        SF_DocDetailFlowName,
        ENSX_ReturnTo,
        ENSX_Page
    };

    // ctor()
    public UTIL_PageState()
    {
        this.values = new Map<String, String>();
    }

    // UTIL_PageState.current
    //
    // Returns page state with the current url params set
    // This can be overridden by calling UTIL_PageState.setCurrentState()
    public static UTIL_PageState current
    {
        get
        {
            if (null == UTIL_PageState.current)
            {
                Map<String, String> unfilteredParams = ApexPages.currentPage().getParameters();
                UTIL_PageState.current = new UTIL_PageState();
                Integer paramTot = UTIL_PageState.allParams.size();
                for (Integer paramCnt = 0 ; paramCnt < paramTot ; paramCnt++)
                {
                    String param = UTIL_PageState.allParams[paramCnt];
                    UTIL_PageState.current.propSet(param, unfilteredParams.get(param));
                }
            }
            return UTIL_PageState.current;
        }
    }

    // UTIL_PageState.setCurrentState()
    //
    // Override the UTIL_PageState.current
    public static void setCurrentState(UTIL_PageState state)
    {
        UTIL_PageState.current = state;
    }

    // lookupAccountId()
    //
    // Calculate the SF account ID by doing lookups of state query values
    public String lookupAccountId()
    {
        String result = this.sfAccountId;

        if (null == result && null != this.sfCaseId)
        {
            Case caseObject = UTIL_ObjectLookups.getCaseById(this.sfCaseId);
            if (null != caseObject) result = caseObject.AccountId;
        }

        if (null == result && null != this.sfQuoteId)
        {
            result = UTIL_SFSObjectDoc.getAccountId(this.sfQuoteId);
        }

        if (null == result && null != this.sfOpportunityId)
        {
            result = UTIL_SFSObjectDoc.getAccountId(this.sfOpportunityId);
        }

        if (null == result && null != this.sfCpqQuoteId)
        {
            result = UTIL_SFSObjectDoc.getAccountId(this.sfCpqQuoteId);
        }

        if (null == result && null != this.sapCustomerId)
        {
            Account account = UTIL_SFAccount.getAccountByCustomerNumber(this.sapCustomerId);
            if (null != account) result = account.Id;
        }

        return result;
    }

    // saveReturnState()
    //
    // NOTE: This is not static. Call it on a specific page state.
    // i.e. UTIL_PageState.current.saveReturnState()
    public void saveReturnState()
    {
        String path = ApexPages.currentPage().getUrl().split('\\?', 2)[0];
        PageReference page = new PageReference(path);
        UTIL_PageState.setPageParamsFromState(page, UTIL_PageState.current);
        this.ensxReturnToUrl = page.getUrl();
        System.debug('UTIL_PageState::saveReturnState - ' + this.ensxReturnToUrl);
    }

    // saveCustomReturnState()
    //
    // Like saveReturnState(), except instead of remembering the current  url,
    // we construct a custom url from a pageName, and params from a page state
    public void saveCustomReturnState(String pageName, UTIL_PageState params)
    {
        string pageURL = UTIL_PageFlow.getPageURL(pageName);
        PageReference returnPage = new PageReference(pageURL);
        UTIL_PageState.setPageParamsFromState(returnPage, params);
        this.ensxReturnToUrl = returnPage.getUrl();
        System.debug('UTIL_PageState::saveCustomReturnState - ' + this.ensxReturnToUrl);
    }

    public String sapAddPartnerTo
    {
        get { return this.propGet(SAP_AddPartnerTo); }
        set { this.propSet(SAP_AddPartnerTo, value); }
    }

    public String sapCustomerId
    {
        get { return this.propGet(SAP_CustId); }
        set { this.propSet(SAP_CustId, value); }
    }

    public String sapDeliveryItemNum
    {
        get { return this.propGet(SAP_DeliveryItem); }
        set { this.propSet(SAP_DeliveryItem, value); }
    }

    public String sapDeliveryNum
    {
        get { return this.propGet(SAP_DeliveryNum); }
        set { this.propSet(SAP_DeliveryNum, value); }
    }

    public String sapDocNum
    {
        get { return this.propGet(SAP_DocNum); }
        set { this.propSet(SAP_DocNum, value); }
    }

    public String sapDocType
    {
        get { return this.propGet(SAP_DocType); }
        set { this.propSet(SAP_DocType, value); }
    }

    public String sapInvoiceNum
    {
        get { return this.propGet(SAP_InvoiceNum); }
        set { this.propSet(SAP_InvoiceNum, value); }
    }

    public String sapItemNum
    {
        get { return this.propGet(SAP_ItemNum); }
        set { this.propSet(SAP_ItemNum, value); }
    }

    public String sapMode
    {
        get { return this.propGet(SAP_Mode); }
        set { this.propSet(SAP_Mode, value); }
    }

    public String sapNoteType
    {
        get { return this.propGet(SAP_NoteType); }
        set { this.propSet(SAP_NoteType, value); }
    }

    public String sapOrderNum
    {
        get { return this.propGet(SAP_OrderNum); }
        set { this.propSet(SAP_OrderNum, value); }
    }

    public String sapPartnerType
    {
        get { return this.propGet(SAP_PartnerType); }
        set { this.propSet(SAP_PartnerType, value); }
    }

    public String sapPreviousScreen
    {
        get { return this.propGet(SAP_PreviousScreen); }
        set { this.propSet(SAP_PreviousScreen, value); }
    }

    public String sapQuoteId
    {
        get { return this.propGet(SAP_QuoteId); }
        set { this.propSet(SAP_QuoteId, value); }
    }

    public String sapRmaId
    {
        get { return this.propGet(SAP_RmaId); }
        set { this.propSet(SAP_RmaId, value); }
    }

    public String sapSalesArea
    {
        get { return this.propGet(SAP_SalesArea); }
        set { this.propSet(SAP_SalesArea, value); }
    }

    public String sapShipToNum
    {
        get { return this.propGet(SAP_ShipToNum); }
        set { this.propSet(SAP_ShipToNum, value); }
    }

    public String sfAccountId
    {
        get { return this.propGet(SF_AcctId); }
        set { this.propSet(SF_AcctId, value); }
    }

    public String sfCaseId
    {
        get { return this.propGet(SF_CaseId); }
        set { this.propSet(SF_CaseId, value); }
    }

    public String sfContactId
    {
        get { return this.propGet(SF_ContactId); }
        set { this.propSet(SF_ContactId, value); }
    }

    public String sfCpqQuoteId
    {
        get { return this.propGet(SF_CPQQuoteId); }
        set { this.propSet(SF_CPQQuoteId, value); }
    }

    public String sfMaterialId
    {
        get { return this.propGet(SF_MatId); }
        set { this.propSet(SF_MatId, value); }
    }

    public String sfOpportunityId
    {
        get { return this.propGet(SF_OppId); }
        set { this.propSet(SF_OppId, value); }
    }

    public String sfOpportunityProductId
    {
        get { return this.propGet(SF_OppProdId); }
        set { this.propSet(SF_OppProdId, value); }
    }

    public String sfPlantId
    {
        get { return this.propGet(SF_PlantId); }
        set { this.propSet(SF_PlantId, value); }
    }

    public String sfProductId
    {
        get { return this.propGet(SF_ProductId); }
        set { this.propSet(SF_ProductId, value); }
    }

    public String sfQuoteId
    {
        get { return this.propGet(SF_QuoteId); }
        set { this.propSet(SF_QuoteId, value); }
    }

    public String sfRecordId
    {
        get { return this.propGet(SF_Record_Id); }
        set { this.propSet(SF_Record_Id, value); }
    }

    public String sfSAPDocNum
    {
        get { return this.propGet(SF_SAP_DocNum); }
        set { this.propSet(SF_SAP_DocNum, value); }
    }

    public String sfDocDetailFlowName
    {
        get { return this.propGet(SF_DocDetailFlowName); }
        set { this.propSet(SF_DocDetailFlowName, value); }
    }

    @testVisible
    public String ensxReturnToUrl
    {
        get { return this.propGet(ENSX_ReturnTo); }
        private set { this.propSet(ENSX_ReturnTo, value); }
    }

    public String ensxPageRoute
    {
        get { return this.propGet(ENSX_Page); }
        set { this.propSet(ENSX_Page,value); }
    }


    // getPageParams()
    //
    // Returns the state as a "query string" map of page parameters
    // ready to be attached to a PageReference. This should probably only be
    // used by UTIL_PageFlow
    public Map<String, String> getPageParams()
    {
        return this.values;
    }

    // Helpers to shorten the property definitions
    private String propGet(String key)
    {
        if (!this.values.containsKey(key))
            return null;
        return this.values.get(key);
    }

    private void propSet(String key, String value)
    {
        if (null == value && this.values.containsKey(key))
        {
            this.values.remove(key);
        }
        else
        {
            this.values.put(key, value);
        }
    }

    private static void setPageParamsFromState(PageReference page, UTIL_PageState state)
    {
        if (null == state) return;

        Integer paramTot = UTIL_PageState.allParams.size();
        for (Integer paramCnt = 0 ; paramCnt < paramTot ; paramCnt++)
        {
            String param = UTIL_PageState.allParams[paramCnt];
            String value = state.propGet(param);
            if (null != value)
            {
                page.getParameters().put(param, value);
            }
        }
    }
}