public with sharing class CTRL_MaterialDetail
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_MaterialDetail.class);

    public SBO_EnosixMaterial_Detail.EnosixMaterial materialDetail { get;  set;}
	public List<SBO_EnosixMaterial_Detail.PLANT_DATA> plantData {get; private set;}
	public Boolean showPageUi {get; set;}
    public string SF_ProductId {get; set;}
    public string materialnumber;
    public string ProductMaterialField = 'ProductCode';

	public Boolean isClassic 
    {
        get {return (UserInfo.getUiThemeDisplayed() == 'Theme3');}
    }

	public CTRL_MaterialDetail()
	{
		//default constructor
	}

	//Default action called by the page to setup UI and load data
	public void loadPageData()
	{
		setPageUi();

		//Figure Out the Material Id
		materialnumber = getMaterialNumberFromPageParameters();

		//Get Material Data
		getMaterialFromMaterialNumber(materialnumber);
	}

	// Determine the material number by inspecting the page parameters
	@testVisible
	private string getMaterialNumberFromPageParameters()
	{
        SF_ProductId = UTIL_PageState.current.sfProductId;
        String materialId = UTIL_PageState.current.sfMaterialId;
        if (!String.isBlank(materialId)) return materialId;

        product2 prod = getProductFromProductId(SF_ProductId);
        return getMaterialNumberFromProduct(prod);
	}

	private void setPageUi()
	{
		String isPopUp = System.currentPageReference().getParameters().get('isPopUp');
		if (isPopUp == 'true')
		{
			showPageUi = false;
		}
		else
		{
			showPageUi = true;
		}
	}

	@testVisible
	private void getMaterialFromMaterialNumber(string materialNumber)
    {
		SBO_EnosixMaterial_Detail.EnosixMaterial result = null;
		SBO_EnosixMaterial_Detail sbo = new SBO_EnosixMaterial_Detail();

		result = sbo.getDetail(materialnumber);

		if (!result.isSuccess())
		{
			UTIL_ViewHelper.displayResultMessages(result.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
		}
		else
		{
			plantData = new List<SBO_EnosixMaterial_Detail.PLANT_DATA>();
			this.materialDetail = result;
			this.materialDetail.PLANT_DATA.copyTo(plantData);
		}
	}

	public String getMaterialNumberFromProduct(product2 product)
    {
        string  result = null;
        string productID = product.Id;
        Product2 prod = Database.query('SELECT ' + ProductMaterialField +  ' FROM Product2 WHERE Id = :productID LIMIT 1');
	    result = (string)prod.get(ProductMaterialField);
        if(result == null || string.isEmpty(result))
        {
        	ApexPages.addMessage(new Apexpages.Message(
				ApexPages.Severity.ERROR , 'The Product record does not have Associated Material Information.'));
        }
        return result;
	}

	public product2 getProductFromProductId(string productId)
	{
		product2 prod = [SELECT Id, ProductCode FROM Product2 WHERE Id = :productId];
		return prod;
	}
}