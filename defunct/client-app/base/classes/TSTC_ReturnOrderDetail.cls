@isTest
private class TSTC_ReturnOrderDetail
{
    public class MOC_EnosixRO_Detail implements ensxsdk.EnosixFramework.DetailSBOGetMock,
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
            SBO_EnosixRO_Detail.EnosixRO result = new SBO_EnosixRO_Detail.EnosixRO();
            result.setSuccess(success);
            return result;
        }

        public ensxsdk.EnosixFramework.DetailObject executeSave(ensxsdk.EnosixFramework.DetailObject obj)
        {
            SBO_EnosixRO_Detail.EnosixRO result = new SBO_EnosixRO_Detail.EnosixRO();
            result.setSuccess(success);
            return result;
        }

        public ensxsdk.EnosixFramework.DetailObject executeCommand(string command, ensxsdk.EnosixFramework.DetailObject obj)
        {
            SBO_EnosixRO_Detail.EnosixRO result = new SBO_EnosixRO_Detail.EnosixRO();
            result.setSuccess(success);
            return result;
        }

        public  ensxsdk.EnosixFramework.DetailObject executeInitialize(ensxsdk.EnosixFramework.DetailObject  initialState)
        {
            SBO_EnosixRO_Detail.EnosixRO result = new SBO_EnosixRO_Detail.EnosixRO();
            result.setSuccess(success);
            return result;
        }
    }

    @isTest 
    static void test_CreateController()
    {
        ensxsdk.EnosixFramework.setMock(SBO_EnosixRO_Detail.class, new MOC_EnosixRO_Detail());
        Test.startTest();
        UTIL_PageState.current.sapRmaId = 'rmaId';
        CTRL_ReturnOrderDetail ctrl = new CTRL_ReturnOrderDetail();
        ctrl.rmaSaleData = ctrl.rmaSaleData;
        ctrl.returnOrderDetail = new SBO_EnosixRO_Detail.EnosixRO();
        SBO_EnosixRO_Detail.ITEMS item = new SBO_EnosixRO_Detail.ITEMS();
        item.itemNumber = 'itemNumber';
        ctrl.returnOrderDetail.ITEMS.add(item);
        SBO_EnosixRO_Detail.ITEMS_ARM itemArm = new SBO_EnosixRO_Detail.ITEMS_ARM();
        itemArm.Item = 'itemNumber';
        ctrl.returnOrderDetail.ITEMS_ARM.add(itemArm);
        List<CTRL_ReturnOrderDetail.ITEM> DisplayItems = ctrl.DisplayItems;
        ctrl.gotoCustomerPage();
        ctrl.gotoCase();
        Boolean isClassic = ctrl.isClassic;
        Test.stopTest();
    }

    @isTest 
    static void test_ItemDetailPage()
    {
        ensxsdk.EnosixFramework.setMock(SBO_EnosixRO_Detail.class, new MOC_EnosixRO_Detail());
        UTIL_PageState.current.sapItemNum = 'itemNumber';
        CTRL_ReturnOrderDetail ctrl = new CTRL_ReturnOrderDetail();
        Test.startTest();
        ctrl.ItemDetailPage();
        ctrl.returnOrderDetail = new SBO_EnosixRO_Detail.EnosixRO();
        SBO_EnosixRO_Detail.ITEMS item = new SBO_EnosixRO_Detail.ITEMS();
        item.itemNumber = 'itemNumber';
        ctrl.returnOrderDetail.ITEMS.add(item);
        SBO_EnosixRO_Detail.ITEMS_ARM itemArm = new SBO_EnosixRO_Detail.ITEMS_ARM();
        itemArm.Item = 'itemNumber';
        ctrl.returnOrderDetail.ITEMS_ARM.add(itemArm);
        ctrl.ItemDetailPage();
        Test.stopTest();
    }

    @isTest 
    static void test_Items()
    {
        ensxsdk.EnosixFramework.setMock(SBO_EnosixRO_Detail.class, new MOC_EnosixRO_Detail());
        CTRL_ReturnOrderDetail ctrl = new CTRL_ReturnOrderDetail();
        Test.startTest();
        List<SBO_EnosixRO_Detail.ITEMS> result = ctrl.Items;
        ctrl.returnOrderDetail = new SBO_EnosixRO_Detail.EnosixRO();
        result = ctrl.Items;
        CTRL_ReturnOrderDetail.ITEM item = new CTRL_ReturnOrderDetail.ITEM(new SBO_EnosixRO_Detail.ITEMS(), new SBO_EnosixRO_Detail.ITEMS_ARM());
        SBO_EnosixRO_Detail.ITEMS returnItem = item.returnItem;
        SBO_EnosixRO_Detail.ITEMS_ARM replaceItem  = item.replaceItem;
        Test.stopTest();

        system.assert(null != result);
    }

    @isTest 
    static void test_Partners()
    {
        ensxsdk.EnosixFramework.setMock(SBO_EnosixRO_Detail.class, new MOC_EnosixRO_Detail());
        CTRL_ReturnOrderDetail ctrl = new CTRL_ReturnOrderDetail();
        Test.startTest();
        List<SBO_EnosixRO_Detail.PARTNERS> result = ctrl.Partners;
        ctrl.returnOrderDetail = new SBO_EnosixRO_Detail.EnosixRO();
        result = ctrl.Partners;
        Test.stopTest();

        system.assert(null != result);
    }

    @isTest 
    static void test_CCARDS()
    {
        ensxsdk.EnosixFramework.setMock(SBO_EnosixRO_Detail.class, new MOC_EnosixRO_Detail());
        CTRL_ReturnOrderDetail ctrl = new CTRL_ReturnOrderDetail();
        Test.startTest();
        List<SBO_EnosixRO_Detail.CCARD> result = ctrl.RMACards;
        ctrl.returnOrderDetail = new SBO_EnosixRO_Detail.EnosixRO();
        result = ctrl.RMACards;
        Test.stopTest();
    }

    @isTest 
    static void test_SelectedItemSchedule()
    {
        ensxsdk.EnosixFramework.setMock(SBO_EnosixRO_Detail.class, new MOC_EnosixRO_Detail());
        CTRL_ReturnOrderDetail ctrl = new CTRL_ReturnOrderDetail();
        Test.startTest();
        List<SBO_EnosixRO_Detail.ITEMS_SCHEDULE> result = ctrl.SelectedItemSchedule;
        ctrl.returnOrderDetail = new SBO_EnosixRO_Detail.EnosixRO();
        SBO_EnosixRO_Detail.ITEMS_SCHEDULE schedule = new SBO_EnosixRO_Detail.ITEMS_SCHEDULE();
        schedule.itemNumber = 'itemNumber';
        ctrl.returnOrderDetail.ITEMS_SCHEDULE.add(schedule);
        SBO_EnosixRO_Detail.ITEMS item = new SBO_EnosixRO_Detail.ITEMS();
        item.itemNumber = 'itemNumber';
        ctrl.SelectedItem = item;
        result = ctrl.SelectedItemSchedule;
        Test.stopTest();

        system.assert(null != result);
    }

    @isTest 
    static void test_SelectedConditions()
    {
        ensxsdk.EnosixFramework.setMock(SBO_EnosixRO_Detail.class, new MOC_EnosixRO_Detail());
        CTRL_ReturnOrderDetail ctrl = new CTRL_ReturnOrderDetail();
        Test.startTest();
        List<SBO_EnosixRO_Detail.CONDITIONS> result = ctrl.SelectedConditions;
        ctrl.returnOrderDetail = new SBO_EnosixRO_Detail.EnosixRO();
        SBO_EnosixRO_Detail.CONDITIONS condition  = new SBO_EnosixRO_Detail.CONDITIONS();
        condition.ConditionItemNumber = 'itemNumber';
        ctrl.returnOrderDetail.CONDITIONS.add(condition);
        SBO_EnosixRO_Detail.ITEMS item = new SBO_EnosixRO_Detail.ITEMS();
        item.itemNumber = 'itemNumber';
        ctrl.SelectedItem = item;
        result = ctrl.SelectedConditions;
        Test.stopTest();

        system.assert(null != result);
    }
}