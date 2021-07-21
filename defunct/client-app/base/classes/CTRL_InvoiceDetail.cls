public with sharing class CTRL_InvoiceDetail
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_InvoiceDetail.class);

	public SBO_EnosixInvoice_Detail.EnosixInvoice invoiceDetail { get; private set;}
  	public SBO_EnosixInvoice_Detail.ITEMS priceInfoDetail	{get; private set;}
  	public List<SBO_EnosixInvoice_Detail.CONDITIONS> priceInfoItems { get; private set;}
  	public String invNum {get; private set;}

	public Boolean isClassic
	{
		get {return (UserInfo.getUiThemeDisplayed() == 'Theme3');}
	}

  	public CTRL_InvoiceDetail()
	{
    	// First check InvoiceNumber and based on invoice number showing the deatil of invoice
    	invNum = UTIL_PageState.current.sapInvoiceNum;

    	//Check null value in Invoice number
    	if (invNum == null)
		{
      		ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Error , 'Invalid Invoice');
      		ApexPages.addMessage(msg);
      		return;
    	}

    	init();
	}

	public List<SBO_EnosixInvoice_Detail.ITEMS> InvoiceItems
	{
		get
		{
			List<SBO_EnosixInvoice_Detail.ITEMS> result = new List<SBO_EnosixInvoice_Detail.ITEMS>();

			if (null != this.invoiceDetail)
			{
				this.invoiceDetail.Items.copyTo(result);
			}

			return result;
		}
	}

	void init()
	{
		this.invoiceDetail = getInvoiceById(this.invNum);
	}

	@testVisible
	static SBO_EnosixInvoice_Detail.EnosixInvoice getInvoiceById(string invoiceNumber)
	{
		SBO_EnosixInvoice_Detail sbo = new SBO_EnosixInvoice_Detail();
		SBO_EnosixInvoice_Detail.EnosixInvoice result = sbo.getDetail(invoiceNumber);

		if (!result.isSuccess())
		{
            UTIL_ViewHelper.displayResultMessages(result.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
        }

		return result;
	}

	@testVisible
	static SBO_EnosixInvoice_Detail.ITEMS getItemByItemNumber(List<SBO_EnosixInvoice_Detail.ITEMS> items, string itemNumber)
	{
		Integer itemTot = items.size();
		for (Integer itemCnt =  0 ; itemCnt < itemTot ; itemCnt++)
		{
			SBO_EnosixInvoice_Detail.ITEMS item = items[itemCnt];
			if (itemNumber == item.ItemNumber)
			{
				return item;
			}
		}
		System.Debug('Item ' + itemNumber +' not found');
		return null;
	}

  	@testVisible
  	static List<SBO_EnosixInvoice_Detail.CONDITIONS> getConditionsForItem(
		SBO_EnosixInvoice_Detail.EnosixInvoice invoice, string itemNumber)
	{
  		List<SBO_EnosixInvoice_Detail.CONDITIONS> result = new List<SBO_EnosixInvoice_Detail.CONDITIONS>();
  		List<SBO_EnosixInvoice_Detail.CONDITIONS> allConditions = new List<SBO_EnosixInvoice_Detail.CONDITIONS>();
  		invoice.CONDITIONS.copyTo(allConditions);

		Integer condTot = allConditions.size();
  		for (Integer condCnt = 0 ; condCnt < condTot ; condCnt++)
		{
			SBO_EnosixInvoice_Detail.CONDITIONS condition = allConditions[condCnt];
  			if(condition.ConditionItemNumber == itemNumber)
			{
      			result.add(condition);
      		}
  		}

  		return result;
  	}

  	//Reterive Pricing info and Pricing info items based on Billing item number of Invoice
	public void PricingInfo()
	{

  		String itemNumber = UTIL_PageState.current.sapItemNum;

  		this.priceInfoDetail = getItemByItemNumber(this.InvoiceItems, itemNumber);
  		//Initialize the list to display data on visualforce page
  		priceInfoItems = getConditionsForItem(this.invoiceDetail, itemNumber);
 	}

	public Pagereference goToInvoiceSearch()
	{
		return UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_InvoiceSearch, UTIL_PageState.current);
	}
}