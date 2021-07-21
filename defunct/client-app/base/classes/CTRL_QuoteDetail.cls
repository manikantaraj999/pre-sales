public with sharing class CTRL_QuoteDetail
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_QuoteDetail.class);

    public Boolean isClassic
    {
        get {return (UserInfo.getUiThemeDisplayed() == 'Theme3');}
    }

    // Sales Order Detail
    private transient SBO_EnosixQuote_Detail.EnosixQuote t_quoteDetail;
    public SBO_EnosixQuote_Detail.EnosixQuote quoteDetail
    {
        get
        {
            if (null == t_quoteDetail && String.isNotEmpty(UTIL_PageState.current.sapQuoteId))
            {
                t_quoteDetail = getQuote(UTIL_PageState.current.sapQuoteId);
            }
            return t_quoteDetail;
        }
        private set;
    }

    // Selected Line Item
    public SBO_EnosixQuote_Detail.ITEMS SelectedItem { get; private set; }

    public string OpportunityID { get; private set; }

    public string pathMaterialDetail
    {
        get
        {
            return UTIL_PageFlow.getPageURL(UTIL_PageFlow.VFP_MaterialDetail);
        }
    }

    public CTRL_QuoteDetail()
    {
        if (null != UTIL_PageState.current.sfOpportunityId)
        {
            this.opportunityID = UTIL_PageState.current.sfOpportunityId;
        }

        init();
    }

    public void init()
    {
        // Select line item from item number parameter
        if (null != this.quoteDetail && null != UTIL_PageState.current.sapItemNum)
        {
            this.SelectedItem = UTIL_Quote.getItemFromQuoteByItemNumber(
                this.quoteDetail, UTIL_PageState.current.sapItemNum);
        }
    }

    // Item select action
    public void ItemDetailPage()
    {
        String itemnumber = UTIL_PageState.current.sapItemNum;
        this.SelectedItem = UTIL_Quote.getItemFromQuoteByItemNumber(this.quoteDetail, itemnumber);
    }

    // Item list
    public List<UTIL_Quote.QuoteItem> Items
    {
        get
        {
            return UTIL_Quote.convertQuoteDetailToQuoteItem(this.quoteDetail, new Map<String, UTIL_Quote.QuoteLineValue>(), 0);
        }
    }

    // Partners list
    public List<SBO_EnosixQuote_Detail.PARTNERS> Partners
    {
        get
        {
            List<SBO_EnosixQuote_Detail.PARTNERS> result = new List<SBO_EnosixQuote_Detail.PARTNERS>();

            if (null != this.quoteDetail)
            {
                this.quoteDetail.PARTNERS.copyTo(result);
            }

            return result;
        }
    }

    // Selected item schedule list
    public List<SBO_EnosixQuote_Detail.ITEMS_SCHEDULE> SelectedItemSchedule
    {
        get
        {
            List<SBO_EnosixQuote_Detail.ITEMS_SCHEDULE> result = new List<SBO_EnosixQuote_Detail.ITEMS_SCHEDULE>();

            if (null != this.quoteDetail)
            {
                addSelectedItemsSchedule(result, this.quoteDetail, this.SelectedItem);
            }

            return result;
        }
    }

    // Selected item pricing conditions list
    public List<SBO_EnosixQuote_Detail.CONDITIONS> SelectedConditions
    {
        get
        {
            List<SBO_EnosixQuote_Detail.CONDITIONS> result = new List<SBO_EnosixQuote_Detail.CONDITIONS>();

            addSelectedConditions(result, this.quoteDetail, this.SelectedItem);

            return result;
        }
    }

    @testVisible
    private static SBO_EnosixQuote_Detail.EnosixQuote getQuote(string quoteId)
    {
        SBO_EnosixQuote_Detail.EnosixQuote result = UTIL_Quote.getQuoteDetail(quoteId);

        if (!result.isSuccess())
        {
            UTIL_ViewHelper.displayResultMessages(result.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO); 
        }

        return result;
    }

    @testVisible
    private static void addSelectedItemsSchedule(List<SBO_EnosixQuote_Detail.ITEMS_SCHEDULE> result, 
        SBO_EnosixQuote_Detail.EnosixQuote salesOrder, SBO_EnosixQuote_Detail.ITEMS item)
    {
        if (null == result || null == salesOrder || null == item) return;

        List<SBO_EnosixQuote_Detail.ITEMS_SCHEDULE> schedules = new List<SBO_EnosixQuote_Detail.ITEMS_SCHEDULE>();

        salesOrder.ITEMS_SCHEDULE.copyTo(schedules);

        Integer schedTot = schedules.size();
        for (Integer schedCnt = 0 ; schedCnt < schedTot ; schedCnt++)
        {
            SBO_EnosixQuote_Detail.ITEMS_SCHEDULE schedule = schedules[schedCnt];
            if (schedule.ItemNumber == item.ItemNumber)
            {
                result.add(schedule);
            }
        }
    }

    @testVisible
    private static void addSelectedConditions(List<SBO_EnosixQuote_Detail.CONDITIONS> result, 
        SBO_EnosixQuote_Detail.EnosixQuote salesOrder, SBO_EnosixQuote_Detail.ITEMS item)
    {
        if (null == result || null == salesOrder || null == item) return;

        List<SBO_EnosixQuote_Detail.CONDITIONS> conditions = new List<SBO_EnosixQuote_Detail.CONDITIONS>();

        salesOrder.CONDITIONS.copyTo(conditions);

        Integer condTot = conditions.size();
        for (Integer condCnt = 0 ; condCnt < condTot ; condCnt++)
        {
            SBO_EnosixQuote_Detail.CONDITIONS condition = conditions[condCnt];
            if (condition.ConditionItemNumber == item.ItemNumber)
            {
                result.add(condition);
            }
        }
    }

    public PageReference gotoCustomerPage()
    {
        String selectedCustomerId = System.currentPageReference().getParameters().get('selectedCustomerId');
        UTIL_PageState.current.sapCustomerId = selectedCustomerId;
        return UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_CustomerDetail, UTIL_PageState.current);
    }

    public PageReference goToOpportunityPage()
    {
        return UTIL_PageFlow.redirectTo('/' + opportunityID, null);
    }

    public PageReference goToCreateQuotePage()
    {
        UTIL_PageState.current.sfOpportunityId = OpportunityID;
        return UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_OrderCreateUpdate, UTIL_PageState.current);
    }

    public PageReference updateQuote()
    {
        UTIL_PageState.current.sapMode = UTIL_PageState.SAP_ModeUpdate;
        return UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_QuoteCreateUpdate, UTIL_PageState.current);
    }

    public PageReference goToCloneQuotePage()
    {
        UTIL_PageState.current.sapMode = UTIL_PageState.SAP_ModeClone;
        return UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_QuoteCreateUpdate, UTIL_PageState.current);
    }

    public PageReference goToQuoteSearch()
    {
        return UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_QuoteSearch, UTIL_PageState.current);
    }

    public PageReference goToCreateOrder()
    {
        UTIL_PageState.current.sapDocType = this.quoteDetail.SALES.SalesDocumentType;
        UTIL_PageState.current.sapMode = UTIL_PageState.SAP_ModeReference;
        UTIL_PageState.current.sapQuoteId = this.quoteDetail.SalesDocument;
        return UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_OrderCreateUpdate, UTIL_PageState.current);
    }
}