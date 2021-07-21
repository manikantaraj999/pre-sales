public with sharing class CTRL_DeliveryDetail
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_DeliveryDetail.class);

	public Boolean isClassic
	{
		get {return (UserInfo.getUiThemeDisplayed() == 'Theme3');}
	}

	private transient SBO_EnosixDL_Detail.EnosixDL t_dlDetail;
	public SBO_EnosixDL_Detail.EnosixDL dlDetail
	{
		get
		{
			if (null == t_dlDetail)
			{
				SBO_EnosixDL_Detail detail = new SBO_EnosixDL_Detail();
			    t_dlDetail = detail.getDetail(dlnumber);
			}
			return t_dlDetail;
		}
	}

	@testVisible
	private transient List<SBO_EnosixDL_Detail.ITEMS> t_dlItems;
	public List<SBO_EnosixDL_Detail.ITEMS> dlItems
	{
		get
		{
			if (null == t_dlItems && this.dlDetail.isSuccess())
			{
			    t_dlItems = new List<SBO_EnosixDL_Detail.ITEMS>();
				this.dlDetail.Items.copyTo(t_dlItems);
			}
			return t_dlItems == null ? new List<SBO_EnosixDL_Detail.ITEMS>() : t_dlItems;
		}
		set
		{
			t_dlItems = value;
		}
	}

	public SBO_EnosixDL_Detail.ITEMS SelectedItem {get; private set;}
	public String fromaccount {get; private set;}   // if this is set, then show the Back to Account button

	public String dlnumber {get; private set;}

	public CTRL_DeliveryDetail()
	{
		dlnumber = UTIL_PageState.current.sapDeliveryNum;
		fromaccount = UTIL_PageState.current.sfAccountId;

		if (dlnumber == null)
		{
			ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Error , 'Invalid Delivery Inquiry');
			ApexPages.addMessage(msg);
			return;
		}

		if (!this.dlDetail.isSuccess())
		{
			ApexPages.Message msg = new Apexpages.Message(
				ApexPages.Severity.Error , 'Unable to retrieve Delivery Inquiry SAP Webservice');
			ApexPages.addMessage(msg);
			return;
		}

		String itemNum = UTIL_PageState.current.sapDeliveryItemNum;
		if (null != this.dlItems && null != itemNum)
			this.SelectedItem = getDeliveryItemByNumber(this.dlItems, itemNum);
	}

	// Item select action
	public void ItemDetailPage()
	{
		String itemNum = System.currentPageReference().getParameters().get('itemNum');
		this.SelectedItem = getDeliveryItemByNumber(this.dlItems, itemNum);
	}

	@testVisible
	private static SBO_EnosixDL_Detail.ITEMS getDeliveryItemByNumber(
		List<SBO_EnosixDL_Detail.ITEMS> items, string itemNum)
	{

		Integer itemTot = items.size();
		for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
		{
			SBO_EnosixDL_Detail.ITEMS item = items[itemCnt];
			if (itemNum == item.DeliveryItem)
			{
				return item;
			}
		}

		return null;
	}

	public Pagereference goToDeliverySearch()
	{
		return UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_DeliverySearch, UTIL_PageState.current);
	}
}