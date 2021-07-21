/**
 * OrderDetail page controller class displays sales order detail section + the item listing section
 *
 * this page is also used by QuoteDetail page
 *
 * This controller also handles the item detail page displaying and item detail editing as well.
 * Because Item detail information is retrieved in the same webservice call, 
 * keeping controller in the same class prevents us from calling the webservice again
 */
public with sharing class CTRL_OrderDetail
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_OrderDetail.class);

    // Sales Order Detail
    private transient SBO_EnosixSO_Detail.EnosixSO t_orderDetail;
    public SBO_EnosixSO_Detail.EnosixSO orderDetail
    {
        get
        {
            if (null == t_orderDetail && String.isNotEmpty(UTIL_PageState.current.sapOrderNum))
            {
                SBO_EnosixSO_Detail sbo = new SBO_EnosixSO_Detail();

                t_orderDetail = sbo.getDetail(UTIL_PageState.current.sapOrderNum);

                if (!t_orderDetail.isSuccess()) {
                    UTIL_ViewHelper.displayResultMessages(t_orderDetail.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
                }
            }
            return t_orderDetail;
        }
    }

    public Boolean isClassic
    {
        get {return (UserInfo.getUiThemeDisplayed() == 'Theme3');}
    }

    // Selected Line Item
    public SBO_EnosixSO_Detail.ITEMS SelectedItem { get; private set; }

    public string OpportunityID { get; private set; }

    public string pathMaterialDetail
    {
        get
        {
            return UTIL_PageFlow.getPageURL(UTIL_PageFlow.VFP_MaterialDetail);
        }
    }

    public CTRL_OrderDetail()
    {
        init();
    }

    public void init()
    {
        if (null != UTIL_PageState.current.sfOpportunityId)
        {
            this.opportunityID = UTIL_PageState.current.sfOpportunityId;
        }

        // Select line item from item number parameter
        if (null != this.orderDetail && UTIL_PageState.current.sapItemNum != null)
        {
            this.SelectedItem = UTIL_Order.getItemFromOrderByItemNumber(this.orderDetail, UTIL_PageState.current.sapItemNum);
        }
    }

    // Item select action
    public void ItemDetailPage()
    {
        String itemNumber = System.currentPageReference().getParameters().get('itemnumber');
        this.SelectedItem = UTIL_Order.getItemFromOrderByItemNumber(this.orderDetail, itemnumber);
    }

    // Item list
    public List<UTIL_Order.OrderItem> Items
    {
        get
        {
            return UTIL_Order.convertOrderDetailToOrderItem(this.orderDetail, new Map<String, UTIL_Order.OrderLineValue>(), 0);
        }
    }

    // Partners list
    public List<SBO_EnosixSO_Detail.PARTNERS> Partners
    {
        get
        {
            List<SBO_EnosixSO_Detail.PARTNERS> result = new List<SBO_EnosixSO_Detail.PARTNERS>();

            if (null != this.orderDetail)
            {
                this.orderDetail.PARTNERS.copyTo(result);
            }

            return result;
        }
    }

    // Selected item schedule list
    public List<SBO_EnosixSO_Detail.ITEMS_SCHEDULE> SelectedItemSchedule
    {
        get
        {
            List<SBO_EnosixSO_Detail.ITEMS_SCHEDULE> result = new List<SBO_EnosixSO_Detail.ITEMS_SCHEDULE>();

            if (null != this.orderDetail)
            {
                addSelectedItemsSchedule(result, this.orderDetail, this.SelectedItem);
            }

            return result;
        }
    }

    // Selected item pricing conditions list
    public List<SBO_EnosixSO_Detail.CONDITIONS> SelectedConditions
    {
        get
        {
            List<SBO_EnosixSO_Detail.CONDITIONS> result = new List<SBO_EnosixSO_Detail.CONDITIONS>();

            addSelectedConditions(result, this.orderDetail, this.SelectedItem);

            return result;
        }
    }

    @testVisible
    private static void addSelectedItemsSchedule(List<SBO_EnosixSO_Detail.ITEMS_SCHEDULE> result, 
        SBO_EnosixSO_Detail.EnosixSO salesOrder, SBO_EnosixSO_Detail.ITEMS item)
    {
        if (null == result || null == salesOrder || null == item) return;

        List<SBO_EnosixSO_Detail.ITEMS_SCHEDULE> schedules = new List<SBO_EnosixSO_Detail.ITEMS_SCHEDULE>();

        salesOrder.ITEMS_SCHEDULE.copyTo(schedules);

        Integer schedTot = schedules.size();
        for (Integer schedCnt = 0 ; schedCnt < schedTot ; schedCnt++)
        {
            SBO_EnosixSO_Detail.ITEMS_SCHEDULE schedule = schedules[schedCnt];
            if (schedule.ItemNumber == item.ItemNumber)
            {
                result.add(schedule);
            }
        }
    }

    @testVisible
    private static void addSelectedConditions(List<SBO_EnosixSO_Detail.CONDITIONS> result, 
        SBO_EnosixSO_Detail.EnosixSO salesOrder, SBO_EnosixSO_Detail.ITEMS item)
    {
        if (null == result || null == salesOrder || null == item) return;

        List<SBO_EnosixSO_Detail.CONDITIONS> conditions = new List<SBO_EnosixSO_Detail.CONDITIONS>();

        salesOrder.CONDITIONS.copyTo(conditions);

        Integer condTot = conditions.size();
        for (Integer condCnt = 0 ; condCnt < condTot ; condCnt++)
        {
            SBO_EnosixSO_Detail.CONDITIONS condition = conditions[condCnt];
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

    public PageReference goToCreateOrderPage()
    {
        UTIL_PageState.current.sfOpportunityId = OpportunityID;
        return UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_OrderCreateUpdate, UTIL_PageState.current);
    }

    public PageReference updateOrder()
    {
        UTIL_PageState.current.sapMode = UTIL_PageState.SAP_ModeUpdate;
        return UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_OrderCreateUpdate, UTIL_PageState.current);
    }

    public PageReference goToCloneOrderPage()
    {
        UTIL_PageState.current.sapMode = UTIL_PageState.SAP_ModeClone;
        return UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_OrderCreateUpdate, UTIL_PageState.current);
    }

    public PageReference goToOrderSearch()
    {
        return UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_OrderSearch, UTIL_PageState.current);
    }
}