@isTest
private class TSTC_DeliveryDetail
{
	public class MOC_EnosixDL_Detail implements ensxsdk.EnosixFramework.DetailSBOGetMock,
            ensxsdk.EnosixFramework.DetailSBOSaveMock, ensxsdk.EnosixFramework.DetailSBOCommandMock,
            ensxsdk.EnosixFramework.DetailSBOInitMock
    {
        public boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        public ensxsdk.EnosixFramework.DetailObject executeGetDetail(object key)
        {
            SBO_EnosixDL_Detail.EnosixDL result = new SBO_EnosixDL_Detail.EnosixDL();
            result.setSuccess(success);
            return result;
        }

        public ensxsdk.EnosixFramework.DetailObject executeSave(ensxsdk.EnosixFramework.DetailObject obj)
        {
            SBO_EnosixDL_Detail.EnosixDL result = new SBO_EnosixDL_Detail.EnosixDL();
            result.setSuccess(success);
            return result;
        }

        public ensxsdk.EnosixFramework.DetailObject executeCommand(string command, ensxsdk.EnosixFramework.DetailObject obj)
        {
            SBO_EnosixDL_Detail.EnosixDL result = new SBO_EnosixDL_Detail.EnosixDL();
            result.setSuccess(success);
            return result;
        }

        public  ensxsdk.EnosixFramework.DetailObject executeInitialize(ensxsdk.EnosixFramework.DetailObject  initialState)
        {
            SBO_EnosixDL_Detail.EnosixDL result = new SBO_EnosixDL_Detail.EnosixDL();
            result.setSuccess(success);
            return result;
        }
    }

	@isTest 
    static void testDeliveryDetailSuccess()
	{
		MOC_EnosixDL_Detail mocEnosixDLDetail = new MOC_EnosixDL_Detail();
		ensxsdk.EnosixFramework.setMock(SBO_EnosixDL_Detail.class, mocEnosixDLDetail);
        UTIL_PageState.current.sapDeliveryNum = '1000';
        UTIL_PageState.current.sapDeliveryItemNum = 'X';

        CTRL_DeliveryDetail dldetail = new CTRL_DeliveryDetail();

        Test.startTest();
        dldetail.ItemDetailPage();
		Boolean isClassic = dldetail.isClassic;
		PageReference result2 = dldetail.goToDeliverySearch();
        Test.stopTest();
	}

	@isTest 
    static void testDeliveryDetailFailure()
	{
		MOC_EnosixDL_Detail mocEnosixDLDetail = new MOC_EnosixDL_Detail();
		mocEnosixDLDetail.setSuccess(false);
		ensxsdk.EnosixFramework.setMock(SBO_EnosixDL_Detail.class, mocEnosixDLDetail);
        UTIL_PageState.current.sapDeliveryNum = '1000';
        UTIL_PageState.current.sapDeliveryItemNum = 'X';

        CTRL_DeliveryDetail dldetail = new CTRL_DeliveryDetail();

        Test.startTest();
        dldetail.ItemDetailPage();
        Test.stopTest();
	}

	@isTest 
    static void testDeliveryDetailNoId()
	{
		MOC_EnosixDL_Detail mocEnosixDLDetail = new MOC_EnosixDL_Detail();
		ensxsdk.EnosixFramework.setMock(SBO_EnosixDL_Detail.class, mocEnosixDLDetail);

        CTRL_DeliveryDetail dldetail = new CTRL_DeliveryDetail();
		SBO_EnosixDL_Detail.ITEMS item = new SBO_EnosixDL_Detail.ITEMS();
		List<SBO_EnosixDL_Detail.ITEMS> dlItems = new List<SBO_EnosixDL_Detail.ITEMS>{item};
		dldetail.dlItems = dlItems;

        Test.startTest();
        dldetail.ItemDetailPage();
        Test.stopTest();
	}
}