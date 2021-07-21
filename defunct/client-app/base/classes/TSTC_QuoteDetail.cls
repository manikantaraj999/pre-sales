@isTest
private class TSTC_QuoteDetail
{
    static public MOC_EnosixQuote_Detail sboEnosixQuoteDetail;

    public class MOC_EnosixQuote_Detail implements ensxsdk.EnosixFramework.DetailSBOGetMock,
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
            SBO_EnosixQuote_Detail.EnosixQuote result = new SBO_EnosixQuote_Detail.EnosixQuote();
            SBO_EnosixQuote_Detail.ITEMS item = new SBO_EnosixQuote_Detail.ITEMS();
            item.ItemNumber = '10';
            result.ITEMS.add(item);
            SBO_EnosixQuote_Detail.ITEMS_TEXT itemText1 = new SBO_EnosixQuote_Detail.ITEMS_TEXT();
            itemText1.ItemNumber = '20';
            itemText1.TextID = 'Z991';
            itemText1.Text = 'Text';
            result.ITEMS_TEXT.add(itemText1);
            SBO_EnosixQuote_Detail.ITEMS_TEXT itemText2 = new SBO_EnosixQuote_Detail.ITEMS_TEXT();
            itemText2.ItemNumber = '30';
            itemText2.TextID = 'Z992';
            itemText2.Text = 'Text';
            result.ITEMS_TEXT.add(itemText2);
            SBO_EnosixQuote_Detail.ITEMS_TEXT itemText3 = new SBO_EnosixQuote_Detail.ITEMS_TEXT();
            itemText3.ItemNumber = '40';
            itemText3.TextID = 'Z993';
            itemText3.Text = 'Text';
            result.ITEMS_TEXT.add(itemText3);
            SBO_EnosixQuote_Detail.ITEMS_TEXT itemText4 = new SBO_EnosixQuote_Detail.ITEMS_TEXT();
            itemText4.ItemNumber = '50';
            itemText4.TextID = 'Z994';
            itemText4.Text = 'Text';
            result.ITEMS_TEXT.add(itemText4);
            SBO_EnosixQuote_Detail.PARTNERS partner = new SBO_EnosixQuote_Detail.PARTNERS();
            partner.PartnerFunction = UTIL_Customer.SHIP_TO_PARTNER_CODE;
            partner.CustomerNumber = 'CustomerNumber';
            partner.PartnerName = 'PartnerName';
            partner.PartnerName2 = 'PartnerName2';
            partner.HouseNumber = 'HouseNumber';
            partner.Street = 'Street';
            partner.City = 'City';
            partner.Country = 'Country';
            result.PARTNERS.add(partner);
            SBO_EnosixQuote_Detail.ITEMS_SCHEDULE schedule = new SBO_EnosixQuote_Detail.ITEMS_SCHEDULE();
            schedule.ItemNumber = '10';
            result.ITEMS_SCHEDULE.add(schedule);
            SBO_EnosixQuote_Detail.CONDITIONS condition = new SBO_EnosixQuote_Detail.CONDITIONS();
            condition.ConditionItemNumber = '10';
            result.CONDITIONS.add(condition);
            result.setSuccess(success);
            return result;
        }

        public ensxsdk.EnosixFramework.DetailObject executeSave(ensxsdk.EnosixFramework.DetailObject obj)
        {
            SBO_EnosixQuote_Detail.EnosixQuote result = new SBO_EnosixQuote_Detail.EnosixQuote();
            result.setSuccess(success);
            return result;
        }

        public ensxsdk.EnosixFramework.DetailObject executeCommand(string command, ensxsdk.EnosixFramework.DetailObject obj)
        {
            SBO_EnosixQuote_Detail.EnosixQuote result = new SBO_EnosixQuote_Detail.EnosixQuote();
            result.setSuccess(success);
            return result;
        }

        public  ensxsdk.EnosixFramework.DetailObject executeInitialize(ensxsdk.EnosixFramework.DetailObject  initialState)
        {
            SBO_EnosixQuote_Detail.EnosixQuote result = new SBO_EnosixQuote_Detail.EnosixQuote();
            result.setSuccess(success);
            return result;
        }
    }

    @isTest
    static void test_CreateController()
    {
        mocRfcCalls();

        Test.startTest();
        CTRL_QuoteDetail ctrl = new CTRL_QuoteDetail();
        sboEnosixQuoteDetail.setSuccess(false);
        ctrl = new CTRL_QuoteDetail();
        Boolean isClassic = ctrl.isClassic;
        Test.stopTest();
    }

    @isTest
    static void test_ItemDetailPage()
    {
        mocRfcCalls();

        CTRL_QuoteDetail ctrl = new CTRL_QuoteDetail();
        Test.startTest();
        ctrl.ItemDetailPage();
        UTIL_PageState.current.sapItemNum = 'notFound';
        ctrl.ItemDetailPage();
        Test.stopTest();
    }

    @isTest
    static void test_Items()
    {
        mocRfcCalls();

        CTRL_QuoteDetail ctrl = new CTRL_QuoteDetail();
        Test.startTest();
        List<UTIL_Quote.QuoteItem> result = ctrl.Items;
        Test.stopTest();

        system.assert(null != result);
    }

    @isTest
    static void test_Partners()
    {
        mocRfcCalls();

        CTRL_QuoteDetail ctrl = new CTRL_QuoteDetail();
        Test.startTest();
        List<SBO_EnosixQuote_Detail.PARTNERS> result = ctrl.Partners;
        Test.stopTest();

        system.assert(null != result);
    }

    @isTest
    static void test_SelectedItemSchedule()
    {
        mocRfcCalls();

        CTRL_QuoteDetail ctrl = new CTRL_QuoteDetail();
        Test.startTest();
        List<SBO_EnosixQuote_Detail.ITEMS_SCHEDULE> result = ctrl.SelectedItemSchedule;
        Test.stopTest();

        system.assert(null != result);
    }

    @isTest
    static void test_SelectedConditions()
    {
        mocRfcCalls();

        CTRL_QuoteDetail ctrl = new CTRL_QuoteDetail();
        Test.startTest();
        List<SBO_EnosixQuote_Detail.CONDITIONS> result = ctrl.SelectedConditions;
        Test.stopTest();

        system.assert(null != result);
    }

    @isTest
    static void test_screenVariables()
    {
        mocRfcCalls();

        Test.startTest();
        CTRL_QuoteDetail controller = new CTRL_QuoteDetail();
        controller.gotoCustomerPage();
        controller.goToOpportunityPage();
        controller.goToCreateQuotePage();
        controller.updateQuote();
        controller.goToCloneQuotePage();
        controller.goToCreateOrder();
        string pathMaterialDetail = controller.pathMaterialDetail;
        PageReference goToQuoteSearch = controller.goToQuoteSearch();
        Test.stopTest();
    }

    static void mocRfcCalls()
    {
        sboEnosixQuoteDetail = new MOC_EnosixQuote_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixQuote_Detail.class, sboEnosixQuoteDetail);
        UTIL_PageState.current.sapQuoteId = 'quoteId';
        UTIL_PageState.current.sapItemNum = '10';
        UTIL_PageState.current.sfOpportunityId = 'opportunityId';
    }
}