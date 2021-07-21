@isTest
private class TSTC_OrderDetail
{

    static public MOC_EnosixSO_Detail sboEnosixSODetail;

    public class MOC_EnosixSO_Detail implements ensxsdk.EnosixFramework.DetailSBOGetMock,
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
            SBO_EnosixSO_Detail.EnosixSO result = new SBO_EnosixSO_Detail.EnosixSO();
            SBO_EnosixSO_Detail.ITEMS item = new SBO_EnosixSO_Detail.ITEMS();
            item.ItemNumber = '000010';
            result.ITEMS.add(item);
            SBO_EnosixSO_Detail.PARTNERS partner = new SBO_EnosixSO_Detail.PARTNERS();
            partner.CustomerNumber = 'CustomerNumber';
            result.PARTNERS.add(partner);
            SBO_EnosixSO_Detail.ITEMS_SCHEDULE schedule = new SBO_EnosixSO_Detail.ITEMS_SCHEDULE();
            schedule.ItemNumber = '000010';
            result.ITEMS_SCHEDULE.add(schedule);
            SBO_EnosixSO_Detail.CONDITIONS condition = new SBO_EnosixSO_Detail.CONDITIONS();
            condition.ConditionItemNumber = '000010';
            result.CONDITIONS.add(condition);
            result.setSuccess(success);
            return result;
        }
        public ensxsdk.EnosixFramework.DetailObject executeSave(ensxsdk.EnosixFramework.DetailObject obj) {
            SBO_EnosixSO_Detail.EnosixSO result = new SBO_EnosixSO_Detail.EnosixSO();
            result.setSuccess(success);
            return result;
        }
        public ensxsdk.EnosixFramework.DetailObject executeCommand(string command, ensxsdk.EnosixFramework.DetailObject obj) {
            SBO_EnosixSO_Detail.EnosixSO result = new SBO_EnosixSO_Detail.EnosixSO();
            result.setSuccess(success);
            return result;
        }
        public  ensxsdk.EnosixFramework.DetailObject executeInitialize(ensxsdk.EnosixFramework.DetailObject  initialState){
            SBO_EnosixSO_Detail.EnosixSO result = new SBO_EnosixSO_Detail.EnosixSO();
            result.setSuccess(success);
            return result;
        }
    }

    @isTest 
    static void test_CreateController()
    {
        mocRfcCalls();
        Test.startTest();
		CTRL_OrderDetail ctrl = new CTRL_OrderDetail();
        sboEnosixSODetail.setSuccess(false);
        ctrl.init();
        ctrl.updateOrder();
        ctrl.goToCloneOrderPage();
        Boolean isClassic = ctrl.isClassic;
        string pathMaterialDetail = ctrl.pathMaterialDetail;
        PageReference goToOrderSearch = ctrl.goToOrderSearch();
        sboEnosixSODetail.setSuccess(false);
        ctrl = new CTRL_OrderDetail();
        SBO_EnosixSO_Detail.EnosixSO orderDetail = ctrl.orderDetail;
		Test.stopTest();
    }

    @isTest 
    static void test_ItemDetailPage()
    {
        mocRfcCalls();
    	CTRL_OrderDetail ctrl = new CTRL_OrderDetail();
        Test.startTest();
		ctrl.ItemDetailPage();
		Test.stopTest();
    }

    @isTest 
    static void test_Items()
    {
        mocRfcCalls();
    	CTRL_OrderDetail ctrl = new CTRL_OrderDetail();
        Test.startTest();
		List<UTIL_Order.OrderItem> result = ctrl.Items;
		Test.stopTest();

		system.assert(null != result);
    }

    @isTest 
    static void test_Partners()
    {
        mocRfcCalls();
    	CTRL_OrderDetail ctrl = new CTRL_OrderDetail();
        Test.startTest();
		List<SBO_EnosixSO_Detail.PARTNERS> result = ctrl.Partners;
		Test.stopTest();

		system.assert(null != result);
    }

    @isTest 
    static void test_SelectedItemSchedule()
    {
        mocRfcCalls();
    	CTRL_OrderDetail ctrl = new CTRL_OrderDetail();
        Test.startTest();
		List<SBO_EnosixSO_Detail.ITEMS_SCHEDULE> result = ctrl.SelectedItemSchedule;
		Test.stopTest();

		system.assert(null != result);
    }

    @isTest 
    static void test_SelectedConditions()
    {
        mocRfcCalls();
    	CTRL_OrderDetail ctrl = new CTRL_OrderDetail();
        Test.startTest();
		List<SBO_EnosixSO_Detail.CONDITIONS> result = ctrl.SelectedConditions;
		Test.stopTest();

		system.assert(null != result);
    }

    @isTest 
    static void test_gotoPage()
    {
        mocRfcCalls();
    	CTRL_OrderDetail ctrl = new CTRL_OrderDetail();
        Test.startTest();
		PageReference pageReference = ctrl.gotoCustomerPage();
        pageReference = ctrl.goToOpportunityPage();
        pageReference = ctrl.goToCreateOrderPage();
		Test.stopTest();
    }

    static void mocRfcCalls()
    {
        sboEnosixSODetail = new MOC_EnosixSO_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixSO_Detail.class, sboEnosixSODetail);

        UTIL_PageState.current.sapOrderNum = 'orderNum';
        UTIL_PageState.current.sfOpportunityId = 'opportunityId';
        UTIL_PageState.current.sapItemNum = '000010';
    }

    @testSetup
    static void writeTestRecords()
    {
        // Only the DML in @testSetup is applied to each test
    }
}