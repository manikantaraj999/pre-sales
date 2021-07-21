@isTest
private class TSTC_InvoiceDetail
{
    public class MOC_EnosixInvoice_Detail implements ensxsdk.EnosixFramework.DetailSBOGetMock,
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
            SBO_EnosixInvoice_Detail.EnosixInvoice result = new SBO_EnosixInvoice_Detail.EnosixInvoice();
            SBO_EnosixInvoice_Detail.ITEMS item = new SBO_EnosixInvoice_Detail.ITEMS();
            item.ItemNumber = UTIL_PageState.current.sapItemNum;
            result.ITEMS.add(item);
            SBO_EnosixInvoice_Detail.CONDITIONS condition = new SBO_EnosixInvoice_Detail.CONDITIONS();
            condition.ConditionItemNumber = UTIL_PageState.current.sapItemNum;
            result.CONDITIONS.add(condition);
            result.setSuccess(success);
            return result;
        }
        public ensxsdk.EnosixFramework.DetailObject executeSave(ensxsdk.EnosixFramework.DetailObject obj)
        {
            SBO_EnosixInvoice_Detail.EnosixInvoice result = new SBO_EnosixInvoice_Detail.EnosixInvoice();
            result.setSuccess(success);
            return result;
        }
        public ensxsdk.EnosixFramework.DetailObject executeCommand(string command, ensxsdk.EnosixFramework.DetailObject obj)
        {
            SBO_EnosixInvoice_Detail.EnosixInvoice result = new SBO_EnosixInvoice_Detail.EnosixInvoice();
            result.setSuccess(success);
            return result;
        }
        public  ensxsdk.EnosixFramework.DetailObject executeInitialize(ensxsdk.EnosixFramework.DetailObject  initialState)
        {
            SBO_EnosixInvoice_Detail.EnosixInvoice result = new SBO_EnosixInvoice_Detail.EnosixInvoice();
            result.setSuccess(success);
            return result;
        }
    }

    class MOC_getSalesAreaMaster implements ensxsdk.EnosixFramework.RFCMock
    {
        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            RFC_SD_GET_SALES_AREAS.RESULT result = new RFC_SD_GET_SALES_AREAS.RESULT();
            result.setSuccess(false);
            return result;
        }
    }

	@isTest 
    static void test_ctrlInvoiceDetail()
    {
        MOC_EnosixInvoice_Detail mocEnosixInvoiceDetail = new MOC_EnosixInvoice_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixInvoice_Detail.class, mocEnosixInvoiceDetail);
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_SALES_AREAS.class, new MOC_getSalesAreaMaster());

		UTIL_PageState.current.sapInvoiceNum = '12345';
        UTIL_PageState.current.sapItemNum = 'ItemNumber';
		Test.startTest();
		CTRL_InvoiceDetail controller = new CTRL_InvoiceDetail();
        controller.PricingInfo();
        UTIL_PageState.current.sapItemNum = 'noMatch';
        controller.PricingInfo();
        mocEnosixInvoiceDetail.setSuccess(false);
        controller.PricingInfo();
        Boolean isClassic = controller.isClassic;
        Pagereference goToInvoiceSearch = controller.goToInvoiceSearch();
		Test.stopTest();
	}

	@isTest 
    static void test_ctrlInvoiceDetailNoInvoiceNumber()
    {
		Test.startTest();
		CTRL_InvoiceDetail controller = new CTRL_InvoiceDetail();
		Test.stopTest();
	}

	@isTest 
    static void test_ctrlInvoiceDetailSboFailure()
    {
        MOC_EnosixInvoice_Detail mocEnosixInvoiceDetail = new MOC_EnosixInvoice_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixInvoice_Detail.class, mocEnosixInvoiceDetail);
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_SALES_AREAS.class, new MOC_getSalesAreaMaster());

        UTIL_PageState.current.sapInvoiceNum = '12345';
        UTIL_PageState.current.sapItemNum = 'ItemNumber';
		Test.startTest();
        mocEnosixInvoiceDetail.setSuccess(false);
		CTRL_InvoiceDetail controller = new CTRL_InvoiceDetail();
		Test.stopTest();
	}
}