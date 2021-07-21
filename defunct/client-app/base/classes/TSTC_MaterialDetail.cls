@isTest
private class TSTC_MaterialDetail
{

	public class MOC_SBO_EnosixMaterial_Detail implements ensxsdk.EnosixFramework.DetailSBOGetMock
	{
		private boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        private boolean throwException = false;

        public ensxsdk.EnosixFramework.DetailObject executeGetDetail(object key)
        {
            SBO_EnosixMaterial_Detail.EnosixMaterial result = new SBO_EnosixMaterial_Detail.EnosixMaterial();
            result.setSuccess(this.success);
            return result;
        }
	}

	@isTest
	static void testControllerAndParams()
	{
		Test.startTest();
		CTRL_MaterialDetail controller = new CTRL_MaterialDetail();
		controller.materialDetail = new SBO_EnosixMaterial_Detail.EnosixMaterial();
		controller.materialNumber = 'TESTMATERIALNUMBER';
		controller.SF_ProductId = 'ProdID';
		System.assert(controller.ProductMaterialField != null);
		Test.stopTest();
	}

	@isTest
	static void testGetMaterialNumberFromPageParameters()
	{
		Product2 prod = insertProduct();
		Test.startTest();
		CTRL_MaterialDetail controller = new CTRL_MaterialDetail();
		String matId = controller.getMaterialNumberFromPageParameters();
		System.assert(matId != null);
		Test.stopTest();
	}

	@isTest
	static void testGetMaterialNumberFromProduct()
	{
		Product2 prod = insertProduct();
		Test.startTest();
		CTRL_MaterialDetail controller = new CTRL_MaterialDetail();
		String matId = controller.getMaterialNumberFromProduct(prod);
		System.assert(matId != null);
		prod.ProductCode = null;
		TSTU_SFTestObject.upsertWithRetry(prod);
		matId = controller.getMaterialNumberFromProduct(prod);
		Test.stopTest();
	}

	@isTest
	static void testGetMaterialNumberFromProductId()
	{
		Product2 prod = insertProduct();
		Test.startTest();
		CTRL_MaterialDetail controller = new CTRL_MaterialDetail();
		Product2 resProd = controller.getProductFromProductId(prod.Id);
		System.assert(resProd != null);
		Test.stopTest();
	}

	@isTest 
	static void testLoadPageData()
	{
		MOC_SBO_EnosixMaterial_Detail sboMoc = new MOC_SBO_EnosixMaterial_Detail();
		ensxsdk.EnosixFramework.setMock(SBO_EnosixMaterial_Detail.class, sboMoc);
		System.currentPageReference().getParameters().put('isPopUp', 'true');
		Product2 prod = insertProduct();
		Test.startTest();
		CTRL_MaterialDetail controller = new CTRL_MaterialDetail();
		controller.loadPageData();
		System.currentPageReference().getParameters().put('isPopUp', 'false');
		sboMoc.setSuccess(false);
		controller.loadPageData();
		Test.stopTest();
	}

	private static Product2 insertProduct()
	{
		Product2 prod = TSTU_SFTestObject.createTestProduct2();
        TSTU_SFTestObject.upsertWithRetry(prod);
		UTIL_PageState.current.sfProductId = String.valueOf(prod.Id);
		return prod;
	}
}