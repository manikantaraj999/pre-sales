@isTest
public with sharing class TSTC_QuoteCreateUpdate
{

    static public MOC_EnosixQuote_Detail sboEnosixQuoteDetail;

    public class Mock_SBO_SFCIPartner_Search implements ensxsdk.EnosixFramework.SearchSBOSearchMock
    {
        private boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        private boolean throwException = false;

        public void setThrowException(boolean throwException)
        {
            this.throwException = throwException;
        }

        private boolean returnRecord = true;

        public void setReturnRecord(boolean returnRecord)
        {
            this.returnRecord = returnRecord;
        }

        public ensxsdk.EnosixFramework.SearchContext executeSearch(ensxsdk.EnosixFramework.SearchContext searchContext)
        {
            SBO_SFCIPartner_Search.SFCIPartner_SR search_result = new SBO_SFCIPartner_Search.SFCIPartner_SR();

            SBO_SFCIPartner_Search.SEARCHRESULT result = new SBO_SFCIPartner_Search.SEARCHRESULT();

            if (returnRecord)
            {
                result.PartnerFunctionName = 'PartnerFunctionName';
                result.PartnerNumber = 'PARTNER_NUM';
                result.PartnerName = 'PARTNER_NAME';
                result.HouseNumber = 'HouseNumber';
                result.Street = 'Street';
                result.City = 'City';
                result.Region = 'Region';
                result.PostalCode = 'PostalCode';
                result.Country = 'USA';

                search_result.SearchResults.add(result);
            }

            search_result.setSuccess(success);
            searchContext.baseResult = search_result;
			return searchContext;
        }
    }

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
            item.ItemNumber = '000010';
            result.ITEMS.add(item);
            SBO_EnosixQuote_Detail.ITEMS_TEXT itemText = new SBO_EnosixQuote_Detail.ITEMS_TEXT();
            itemText.ItemNumber = '000010';
            result.ITEMS_TEXT.add(itemText);
            SBO_EnosixQuote_Detail.PARTNERS partner = new SBO_EnosixQuote_Detail.PARTNERS();
            partner.PartnerFunction = UTIL_Customer.SHIP_TO_PARTNER_CODE;
            result.PARTNERS.add(partner);
            result.SalesDocument = '12345';
            result.setSuccess(success);
            return result;
        }
        public ensxsdk.EnosixFramework.DetailObject executeSave(ensxsdk.EnosixFramework.DetailObject obj)
        {
            SBO_EnosixQuote_Detail.EnosixQuote result = (SBO_EnosixQuote_Detail.EnosixQuote) obj;
            result.SalesDocument = '12345';
            result.setSuccess(success);
            return result;
        }
        public ensxsdk.EnosixFramework.DetailObject executeCommand(string command, ensxsdk.EnosixFramework.DetailObject obj)
        {
            SBO_EnosixQuote_Detail.EnosixQuote result = (SBO_EnosixQuote_Detail.EnosixQuote) obj;
            result.SalesDocument = '12345';
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

    public class MOC_EnosixMaterial_Detail implements ensxsdk.EnosixFramework.DetailSBOGetMock,
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
            SBO_EnosixMaterial_Detail.EnosixMaterial result = new SBO_EnosixMaterial_Detail.EnosixMaterial();
            result.setSuccess(success);
            return result;
        }
        public ensxsdk.EnosixFramework.DetailObject executeSave(ensxsdk.EnosixFramework.DetailObject obj)
        {
            SBO_EnosixMaterial_Detail.EnosixMaterial result = new SBO_EnosixMaterial_Detail.EnosixMaterial();
            result.setSuccess(success);
            return result;
        }
        public ensxsdk.EnosixFramework.DetailObject executeCommand(string command, ensxsdk.EnosixFramework.DetailObject obj)
        {
            SBO_EnosixMaterial_Detail.EnosixMaterial result = new SBO_EnosixMaterial_Detail.EnosixMaterial();
            result.setSuccess(success);
            return result;
        }
        public  ensxsdk.EnosixFramework.DetailObject executeInitialize(ensxsdk.EnosixFramework.DetailObject  initialState)
        {
            SBO_EnosixMaterial_Detail.EnosixMaterial result = new SBO_EnosixMaterial_Detail.EnosixMaterial();
            result.setSuccess(success);
            return result;
        }
    }

    public class MOC_EnosixXiIntercept_Detail implements ensxsdk.EnosixFramework.DetailSBOGetMock,
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
            SBO_EnosixXiIntercept_Detail.EnosixXiIntercept result = new SBO_EnosixXiIntercept_Detail.EnosixXiIntercept();
            result.setSuccess(success);
            return result;
        }
        public ensxsdk.EnosixFramework.DetailObject executeSave(ensxsdk.EnosixFramework.DetailObject obj)
        {
            SBO_EnosixXiIntercept_Detail.EnosixXiIntercept result = new SBO_EnosixXiIntercept_Detail.EnosixXiIntercept();
            result.setSuccess(success);
            return result;
        }
        public ensxsdk.EnosixFramework.DetailObject executeCommand(string command, ensxsdk.EnosixFramework.DetailObject obj)
        {
            SBO_EnosixXiIntercept_Detail.EnosixXiIntercept result = new SBO_EnosixXiIntercept_Detail.EnosixXiIntercept();
            result.setSuccess(success);
            return result;
        }
        public  ensxsdk.EnosixFramework.DetailObject executeInitialize(ensxsdk.EnosixFramework.DetailObject  initialState)
        {
            SBO_EnosixXiIntercept_Detail.EnosixXiIntercept result = new SBO_EnosixXiIntercept_Detail.EnosixXiIntercept();
            result.setSuccess(success);
            return result;
        }
    }

    public class MOC_EnosixMaterial_Search implements ensxsdk.EnosixFramework.SearchSBOSearchMock
    {
        public ensxsdk.EnosixFramework.SearchContext executeSearch(ensxsdk.EnosixFramework.SearchContext searchContext)
        {
            SBO_SFCIMaterial_Search.SFCIMaterial_SR search_result = new SBO_SFCIMaterial_Search.SFCIMaterial_SR();
            search_result.setSuccess(true);
            searchContext.baseResult = search_result;
			return searchContext;
        }
    }

    public class MOC_EnosixCustomer_Detail implements ensxsdk.EnosixFramework.DetailSBOGetMock
    {
        public ensxsdk.EnosixFramework.DetailObject executeGetDetail(object key)
        {
            SBO_EnosixCustomer_Detail.EnosixCustomer result = new SBO_EnosixCustomer_Detail.EnosixCustomer();
            result.CustomerNumber = 'TESTCUST';
            result.Name = 'Test Customer';
            SBO_EnosixCustomer_Detail.SALES_DATA salesData = new SBO_EnosixCustomer_Detail.SALES_DATA();
            salesData.SalesOrganization = 'SalesOrganization';
            salesData.SalesOrganizationName = 'SalesOrganizationName';
            salesData.DistributionChannel = 'DistributionChannel';
            salesData.DistributionChannelName = 'DistributionChannelName';
            salesData.Division = 'Division';
            salesData.DivisionName = 'DivisionName';
            salesData.CurrencyKey = 'CurrencyKey';
            result.SALES_DATA.add(salesData);
            result.setSuccess(true);
            return result;
        }
    }

    public class MOC_RFC_SD_GET_DOC_TYPE_VALUES_ET_OUTPUT implements ensxsdk.EnosixFramework.RFCMock
    {
        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            RFC_SD_GET_DOC_TYPE_VALUES.RESULT result = new RFC_SD_GET_DOC_TYPE_VALUES.RESULT();
            RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT sditm = new RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT();
            sditm.DocumentType = 'QT';
            sditm.BEZEI = 'Standard';
            sditm.INCPO = '000010';
            sditm.VBTYP = 'B';
            sditm.X_PONUM_REQUIRED = true;
            result.getCollection(RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT.class).add(sditm);
            for (integer mocCnt = 0; mocCnt < 20; mocCnt++)
            {
                RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT out = new RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT();
                out.DocumentType = 'tst' + mocCnt;
                out.BEZEI = 'tst' + mocCnt;
                out.INCPO = '000010';
                result.getCollection(RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT.class).add(out);
            }
            result.setSuccess(true);
            return result;
        }
    }

    public class MOC_RFC_SD_GET_ORDER_TYPES implements ensxsdk.EnosixFramework.RFCMock
    {
        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            RFC_SD_GET_ORDER_TYPES.RESULT result = new RFC_SD_GET_ORDER_TYPES.RESULT();
            result.setSuccess(true);
            return result;
        }
    }

    public class MOC_RFC_SD_GET_CONDITION_GROUP implements ensxsdk.EnosixFramework.RFCMock
    {
        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            RFC_SD_GET_CONDITION_GROUP.RESULT result = new RFC_SD_GET_CONDITION_GROUP.RESULT();
            result.setSuccess(true);
            return result;
        }
    }

    public class MOC_RFC_SD_GET_CURRENCY_LIST implements ensxsdk.EnosixFramework.RFCMock
    {
        public boolean success = false;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            RFC_SD_GET_CURRENCY_LIST.RESULT result = new RFC_SD_GET_CURRENCY_LIST.RESULT();
            RFC_SD_GET_CURRENCY_LIST.ET_CURRENCY et_currencyField = new RFC_SD_GET_CURRENCY_LIST.ET_CURRENCY();
            et_currencyField.FieldCurrency = 'USD';
            et_currencyField.LTEXT = 'X';
            et_currencyField.KTEXT = 'X';
			result.getCollection(RFC_SD_GET_CURRENCY_LIST.ET_CURRENCY.class).add(et_currencyField);
            result.setSuccess(this.success);
            return result;
        }
    }

    public class MOC_RFC_SD_GET_ITEMCAT_VALUES implements ensxsdk.EnosixFramework.RFCMock
    {
        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            RFC_SD_GET_ITEMCAT_VALUES.RESULT result = new RFC_SD_GET_ITEMCAT_VALUES.RESULT();
            RFC_SD_GET_ITEMCAT_VALUES.ET_VALUES itemCat = new RFC_SD_GET_ITEMCAT_VALUES.ET_VALUES();
            itemCat.VALUE = 'VALUE';
            itemCat.DESCRIPTION = 'DESCRIPTION';
            result.getCollection(RFC_SD_GET_ITEMCAT_VALUES.ET_VALUES.class).add(itemCat);
            result.setSuccess(true);
            return result;
        }
    }

    public class MOC_RFC_SD_GET_COUNTRIES implements ensxsdk.EnosixFramework.RFCMock
    {
        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            RFC_SD_GET_COUNTRIES.RESULT result = new RFC_SD_GET_COUNTRIES.RESULT();
            RFC_SD_GET_COUNTRIES.ET_OUTPUT country = new RFC_SD_GET_COUNTRIES.ET_OUTPUT();
            country.LAND1 = 'USA';
            country.LANDX = 'United States';
            RFC_SD_GET_COUNTRIES.ET_REGIONS region = new RFC_SD_GET_COUNTRIES.ET_REGIONS();
            region.LAND1 = 'USA';
            region.REGIO = 'OH';
            region.BEZEI = 'OHIO';
            result.getCollection(RFC_SD_GET_COUNTRIES.ET_OUTPUT.class).add(country);
            result.getCollection(RFC_SD_GET_COUNTRIES.ET_REGIONS.class).add(region);
            result.setSuccess(false);
            return result;
        }
    }

    @isTest
    static void test_CreateController1()
    {
        mocRfcCalls();
    	Test.startTest();
        UTIL_AppSettings.resourceJson = '{"SalesOrganization.CurrencyKey.SalesOrganization" : ["USD"], "CTRL_QuoteCreateUpdate.Logging": true}';
		CTRL_QuoteCreateUpdate controller = new CTRL_QuoteCreateUpdate();
        controller.soldToCustomer = new SBO_EnosixCustomer_Detail.EnosixCustomer();
        String customerCurrency = controller.customerCurrency;
        String returnToId = controller.returnToId;
        String returnToName = controller.returnToName;
        String returnToAccountName = controller.returnToAccountName;
        controller.soldToCustomer = null;
        controller.soldToCustomer = controller.soldToCustomer;
        controller.ShipToPartner.CustomerNumber = 'CustomerNumber';
        controller.shipToCustomer = controller.shipToCustomer;
        controller.BillToPartner.CustomerNumber = 'CustomerNumber';
        controller.billToCustomer = controller.billToCustomer;
        controller.PayerPartner.CustomerNumber = 'CustomerNumber';
        controller.payerCustomer = controller.payerCustomer;
        controller.isCloneMode = true;
        SBO_EnosixCustomer_Detail.EnosixCustomer shipToCustomer = controller.shipToCustomer;
        String editActionElementId = controller.editActionElementId;
        customerCurrency = controller.customerCurrency;
        Boolean isCurrencyDisabled = controller.isCurrencyDisabled;
        controller.updateSalesAreas();
        controller.quoteDetail.Sales.SalesDocumentCurrency = '';
        controller.editItemNumber = '000010';
        controller.updateSalesAreas();
        controller.checkForClone = true;
        controller.isInit = false;
        controller.updateSalesAreas();
        controller.quoteDetail.PARTNERS.clear();
        SBO_EnosixQuote_Detail.PARTNERS partner1 = new SBO_EnosixQuote_Detail.PARTNERS();
        partner1.PartnerFunction = CTRL_QuoteCreateUpdate.SOLD_TO_PARTNER_CODE;
        partner1.CustomerNumber = 'CustomerNumber';
        controller.quoteDetail.PARTNERS.add(partner1);
        SBO_EnosixQuote_Detail.PARTNERS partner2 = new SBO_EnosixQuote_Detail.PARTNERS();
        partner2.PartnerFunction = CTRL_QuoteCreateUpdate.SHIP_TO_PARTNER_CODE;
        partner2.CustomerNumber = 'CustomerNumber';
        controller.quoteDetail.PARTNERS.add(partner2);
        SBO_EnosixQuote_Detail.PARTNERS partner3 = new SBO_EnosixQuote_Detail.PARTNERS();
        partner3.PartnerFunction = CTRL_QuoteCreateUpdate.CARRIER_PARTNER_CODE;
        partner3.CustomerNumber = 'CustomerNumber';
        controller.quoteDetail.PARTNERS.add(partner3);
        SBO_EnosixQuote_Detail.PARTNERS partner4 = new SBO_EnosixQuote_Detail.PARTNERS();
        partner4.PartnerFunction = 'TEST';
        partner4.PersonnelNumber = '000';
        partner4.ContactPersonNumber = '000';
        controller.quoteDetail.PARTNERS.add(partner4);
        controller.quoteNumber = 'quoteNumber';
        UTIL_PageState.current.sapAddPartnerTo = 'addPartnerTo';
        UTIL_PageState.current.sapShipToNum = 'shipToNum';
        UTIL_PageState.current.sapSalesArea = 'SalesOrganization,DistributionChannel,Division';
        controller.isCloneMode = true;
        controller.initMode();
        controller.isCloneMode = false;
        controller.isUpdateMode = true;
        controller.initMode();
        SBO_EnosixQuote_Detail.ITEMS item = new SBO_EnosixQuote_Detail.ITEMS();
        item.ItemNumber = '000010';
        controller.quoteDetail.ITEMS.add(item);
        SBO_EnosixQuote_Detail.ITEMS item2 = new SBO_EnosixQuote_Detail.ITEMS();
        item2.ItemNumber = '000020';
        controller.quoteDetail.ITEMS.add(item2);
        SBO_EnosixQuote_Detail.ITEMS item3 = new SBO_EnosixQuote_Detail.ITEMS();
        item3.ItemNumber = '000030';
        controller.quoteDetail.ITEMS.add(item3);
        SBO_EnosixQuote_Detail.ITEMS_ACTION itemAction1 = new SBO_EnosixQuote_Detail.ITEMS_ACTION();
        itemAction1.ItemAdded = true;
        itemAction1.ItemNumber = '000010';
        controller.quoteDetail.ITEMS_ACTION.add(itemAction1);
        SBO_EnosixQuote_Detail.ITEMS_ACTION itemAction2 = new SBO_EnosixQuote_Detail.ITEMS_ACTION();
        itemAction2.ItemChanged = true;
        itemAction2.ItemNumber = '000020';
        controller.quoteDetail.ITEMS_ACTION.add(itemAction2);
        SBO_EnosixQuote_Detail.ITEMS_ACTION itemAction3 = new SBO_EnosixQuote_Detail.ITEMS_ACTION();
        itemAction3.ItemDeleted = true;
        itemAction3.ItemNumber = '000030';
        controller.quoteDetail.ITEMS_ACTION.add(itemAction3);
        SBO_EnosixQuote_Detail.ITEMS_TEXT itemText = new SBO_EnosixQuote_Detail.ITEMS_TEXT();
        itemText.ItemNumber = '000010';
        controller.quoteDetail.ITEMS_TEXT.add(itemText);
        SBO_EnosixQuote_Detail.ITEMS_SCHEDULE itemSchedule = new SBO_EnosixQuote_Detail.ITEMS_SCHEDULE();
        itemSchedule.ItemNumber = '000010';
        controller.quoteDetail.ITEMS_SCHEDULE.add(itemSchedule);
        SBO_EnosixQuote_Detail.CONDITIONS condition = new SBO_EnosixQuote_Detail.CONDITIONS();
        condition.ConditionItemNumber = '000010';
        controller.quoteDetail.CONDITIONS.add(condition);
        SBO_EnosixQuote_Detail.ITEMS_CONFIG itemConfig = new SBO_EnosixQuote_Detail.ITEMS_CONFIG();
        itemConfig.ItemNumber = '000010';
        controller.quoteDetail.ITEMS_CONFIG.add(itemConfig);
        Map<Integer, Integer> changeItemNumberMap = new Map<Integer, Integer>();
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap = new Map<String, UTIL_SFSObjectDoc.SfSObjectItem>();
        CTRL_QuoteCreateUpdate.moveItemsUpOrDown(controller.quoteDetail, changeItemNumberMap, sfSObjectLineIdMap);
        changeItemNumberMap.put(10,20);
        changeItemNumberMap.put(20,10);
        changeItemNumberMap.put(30,30);
        sfSObjectLineIdMap.put('20', new UTIL_SFSObjectDoc.SfSObjectItem(null));
        sfSObjectLineIdMap.put('NotFound', new UTIL_SFSObjectDoc.SfSObjectItem(null));
        CTRL_QuoteCreateUpdate.moveItemsUpOrDown(controller.quoteDetail, changeItemNumberMap, sfSObjectLineIdMap);
        SBO_EnosixQuote_Detail.ITEMS_ACTION itemAction4 = new SBO_EnosixQuote_Detail.ITEMS_ACTION();
        itemAction4.ItemDeleted = true;
        itemAction4.ItemNumber = '000040';
        controller.quoteDetail.ITEMS_ACTION.add(itemAction4);
        SBO_EnosixQuote_Detail.ITEMS_CONFIG itemConfig4 = new SBO_EnosixQuote_Detail.ITEMS_CONFIG();
        itemConfig4.ItemNumber = '000040';
        controller.quoteDetail.ITEMS_CONFIG.add(itemConfig4);
        System.currentPageReference().getParameters().put('editItemNumber', '000010');
        controller.quoteNumber = 'quoteNumber';
        controller.quoteDetail.ITEMS.add(item);
        controller.displayedMaterialItems = null;
        controller.editItemClick();
        controller.ItemCategories = null;
        List<SelectOption> ItemCategories = controller.ItemCategories;
        controller.selectedItemsMap.clear();
        controller.cancelEditItem();
        controller.itemPlant = controller.itemPlant;
        controller.editItemNumber = '000010';
        controller.itemPlant = controller.itemPlant;
        controller.editItemNumber = null;
        controller.quoteDetail.SALES.SalesDocumentType = null;
        controller.init();
        controller.isQuoteMode = true;
        controller.quoteNumber = 'quoteNumber';
        controller.init();
        controller.quoteNumber = null;
        controller.isUpdateMode = true;
        controller.initMode();
        controller.isUpdateMode = false;
        controller.isCloneMode = true;
        controller.initMode();
        UTIL_PageState.current.sfOpportunityId = null;
        controller.isQuoteMode = true;
        controller.quoteNumber = null;
        controller.init();
        controller.isValidSalesData('test', new List<SelectOption>{new SelectOption('test','test')});
        Boolean isClassic = controller.isClassic;
        string pathMaterialDetail = controller.pathMaterialDetail;
        String previousScreen = controller.previousScreen;
        String opportunityId = controller.opportunityId;
        String quoteRequestId = controller.quoteRequestId;
        controller.sfSObject = TSTU_SFTestObject.createTestOpportunity();
        Opportunity quoteOpportunity = controller.quoteOpportunity;
        controller.isQuoteMode = true;
        controller.quoteNumber = '';
        controller.sfSObject = new Opportunity();
        controller.init();
        Object testObj = controller.isAddMaterial;
        testObj = controller.isRemoveMaterial;
        testObj = controller.isEditMaterial;
        testObj = controller.isCloneMaterial;
        testObj = controller.isMoveMaterial;
        testObj = controller.isSelectMaterial;
        controller.soldToCustomer = null;
        controller.quoteAccount = null;
        testObj = controller.soldToCustomer;
        controller.quoteAccount = new Account();
        controller.soldToCustomer = null;
        testObj = controller.soldToCustomer;
        List<SelectOption> CountryOptions = controller.CountryOptions;
        List<SelectOption> RegionOptions = controller.RegionOptions;
    	Test.stopTest();
    }

    @isTest
    static void test_CreateController2()
    {
        mocRfcCalls();
    	Test.startTest();
		Test.setCurrentPageReference(new PageReference('Page.VFP_QuoteCreateUpdate'));
        UTIL_PageState.current.sapAddPartnerTo = 'addPartnerTo';
        UTIL_PageState.current.sapShipToNum = 'shipToNum';
        UTIL_PageState.current.sapSalesArea = 'SalesOrganization,DistributionChannel,Division';
		CTRL_QuoteCreateUpdate controller = new CTRL_QuoteCreateUpdate();
    	Test.stopTest();
    	System.assertNotEquals(controller, null);
    }

 	@isTest
    static void test_validateQuote()
    {
        mocRfcCalls();
    	SBO_EnosixQuote_Detail.EnosixQuote salesQuote = new SBO_EnosixQuote_Detail.EnosixQuote();
        salesQuote.Sales.SalesDocumentType = 'QT';
    	Test.startTest();
        CTRL_QuoteCreateUpdate controller = new CTRL_QuoteCreateUpdate();
        controller.quoteDetail = salesQuote;
    	boolean result = controller.validateQuote();
        controller.quoteDetail.CustomerPurchaseOrderNumber = 'PoNum';
        result = controller.validateQuote();
		Test.stopTest();
		System.assert(false == result);
    }

    @isTest
    static void test_validateNewLineItem()
    {
    	SBO_EnosixQuote_Detail.ITEMS item = new SBO_EnosixQuote_Detail.ITEMS();
    	Test.startTest();
    	boolean result = CTRL_QuoteCreateUpdate.validateNewLineItem(item);
        System.assert(false == result);
        item.Material = 'Material';
        result = CTRL_QuoteCreateUpdate.validateNewLineItem(item);
        item.OrderQuantity = 1;
        result = CTRL_QuoteCreateUpdate.validateNewLineItem(item);
        item.OrderQuantity = -1;
        result = CTRL_QuoteCreateUpdate.validateNewLineItem(item);
		Test.stopTest();
    }

    @isTest
    static void test_getQuoteTypes()
    {
        mocRfcCalls();
    	CTRL_QuoteCreateUpdate controller = new CTRL_QuoteCreateUpdate();
    	Test.startTest();
        controller.checkForClone = true;
		System.assert(controller.QuoteTypes!=null);
		Test.stopTest();
    }

    @isTest
    static void test_getSalesOrganizations()
    {
        mocRfcCalls();
    	CTRL_QuoteCreateUpdate controller = new CTRL_QuoteCreateUpdate();
    	Test.startTest();
		System.assert(controller.SalesOrganizations!=null);
		Test.stopTest();
    }

    @isTest
    static void test_getDistributionChannels()
    {
        mocRfcCalls();
    	CTRL_QuoteCreateUpdate controller = new CTRL_QuoteCreateUpdate();
    	Test.startTest();
		System.assert(controller.DistributionChannels!=null);
		Test.stopTest();
    }

    @isTest
    static void test_getDivisions()
    {
        mocRfcCalls();
    	CTRL_QuoteCreateUpdate controller = new CTRL_QuoteCreateUpdate();
    	Test.startTest();
		System.assert(controller.Divisions!=null);
		Test.stopTest();
    }

    @isTest
    static void test_getSoldToPartners()
    {
        mocRfcCalls();
    	CTRL_QuoteCreateUpdate controller = new CTRL_QuoteCreateUpdate();
    	Test.startTest();
		System.assert(controller.SoldToPartners!=null);
		Test.stopTest();
    }

    @isTest
    static void test_getShipToPartners()
    {
        mocRfcCalls();
    	CTRL_QuoteCreateUpdate controller = new CTRL_QuoteCreateUpdate();
    	Test.startTest();
		System.assert(controller.ShipToPartners!=null);
		Test.stopTest();
    }

    @isTest
    static void test_paymentTerm()
    {
        mocRfcCalls();
    	CTRL_QuoteCreateUpdate controller = new CTRL_QuoteCreateUpdate();
    	Test.startTest();
		System.assert(controller.paymentTerm!=null);
		Test.stopTest();
    }

    @isTest
    static void test_opportunityClosed()
    {
        mocRfcCalls();
    	CTRL_QuoteCreateUpdate controller = new CTRL_QuoteCreateUpdate();
    	Test.startTest();
		System.assert(controller.opportunityClosed!=null);
		Test.stopTest();
    }

    @isTest
    static void test_customerSalesData()
    {
        mocRfcCalls();
    	CTRL_QuoteCreateUpdate controller = new CTRL_QuoteCreateUpdate();
    	Test.startTest();
        controller.customerSalesData = new SBO_EnosixCustomer_Detail.SALES_DATA();
		System.assert(controller.customerSalesData!=null);
		Test.stopTest();
    }

    @isTest
    static void test_companyData()
    {
        mocRfcCalls();
    	CTRL_QuoteCreateUpdate controller = new CTRL_QuoteCreateUpdate();
    	Test.startTest();
        controller.companyData = new SBO_EnosixCustomer_Detail.COMPANY_DATA();
		System.assert(controller.companyData!=null);
		Test.stopTest();
    }

    @isTest
    static void test_pickDefaultQuoteType()
    {
    	Test.startTest();
        List<SelectOption> selectList = new List<SelectOption>();
        selectList.add(new SelectOption('Test','Test'));
        String result = CTRL_QuoteCreateUpdate.pickDefaultQuoteType(selectList);
        selectList.add(new SelectOption('QT','QT'));
        result = CTRL_QuoteCreateUpdate.pickDefaultQuoteType(selectList);
		System.assert(result!=null);
		Test.stopTest();
    }

    @isTest
    static void test_displayedMaterialItems()
    {
        mocRfcCalls();
    	CTRL_QuoteCreateUpdate controller = new CTRL_QuoteCreateUpdate();
    	Test.startTest();
		System.assert(controller.displayedMaterialItems!=null);
		Test.stopTest();
    }

    @isTest
    static void test_ItemCategories()
    {
        mocRfcCalls();
    	CTRL_QuoteCreateUpdate controller = new CTRL_QuoteCreateUpdate();
    	Test.startTest();
        List<SelectOption> ItemCategories = controller.ItemCategories;
		Test.stopTest();
    }

    @isTest
    static void test_isShipToPartnerAddressDisplayed()
    {
        mocRfcCalls();
    	CTRL_QuoteCreateUpdate controller = new CTRL_QuoteCreateUpdate();
    	Test.startTest();
		System.assert(controller.isShipToPartnerAddressDisplayed!=null);
		Test.stopTest();
    }

    @isTest
    static void test_SoldToPartner()
    {
        mocRfcCalls();
    	CTRL_QuoteCreateUpdate controller = new CTRL_QuoteCreateUpdate();
    	Test.startTest();
		System.assert(controller.SoldToPartner!=null);
		Test.stopTest();
    }

    @isTest
    static void test_PlantSelections()
    {
        mocRfcCalls();
    	CTRL_QuoteCreateUpdate controller = new CTRL_QuoteCreateUpdate();
    	Test.startTest();
        controller.editItemNumber = 'editItemNumber';
		System.assert(controller.PlantSelections!=null);
        SBO_EnosixMaterial_Detail.EnosixMaterial material = new SBO_EnosixMaterial_Detail.EnosixMaterial();
        SBO_EnosixMaterial_Detail.PLANT_DATA plant = new SBO_EnosixMaterial_Detail.PLANT_DATA();
        plant.Plant = 'Plant';
        plant.SalesOrganization = 'SalesOrganization';
        plant.DistributionChannel = 'DistributionChannel';
        plant.Name = 'Name';
        material.PLANT_DATA.add(plant);
        controller.selectedMaterialDetail = material;
        controller.quoteDetail.Sales.SalesOrganization = 'SalesOrganization';
        controller.quoteDetail.Sales.DistributionChannel = 'DistributionChannel';
        controller.quoteDetail.Sales.Division = 'Division';
        System.assert(controller.PlantSelections!=null);
		Test.stopTest();
    }

    @isTest
    static void test_defaultQuoteMaterialTypes()
    {
        mocRfcCalls();
    	CTRL_QuoteCreateUpdate controller = new CTRL_QuoteCreateUpdate();
    	Test.startTest();
		System.assert(controller.quoteMaterialTypes!=null);
        System.assert(controller.defaultQuoteMaterialTypes!=null);
		Test.stopTest();
    }

    @isTest
    static void test_isQuoteMaterialAutoSearchEnabled()
    {
        mocRfcCalls();
    	CTRL_QuoteCreateUpdate controller = new CTRL_QuoteCreateUpdate();
    	Test.startTest();
		System.assert(controller.isQuoteMaterialAutoSearchEnabled!=null);
		Test.stopTest();
    }

    @isTest
    static void test_isShipToAutoSearchEnabled()
    {
        mocRfcCalls();
    	CTRL_QuoteCreateUpdate controller = new CTRL_QuoteCreateUpdate();
    	Test.startTest();
		System.assert(controller.isShipToAutoSearchEnabled!=null);
		Test.stopTest();
    }

    @isTest
    static void test_partnerReceiver()
    {
        mocRfcCalls();
    	CTRL_QuoteCreateUpdate controller = new CTRL_QuoteCreateUpdate();
    	Test.startTest();
		System.assert(controller.partnerReceiver!=null);
		Test.stopTest();
    }

    @isTest
    static void test_onReceivePartnerSearch()
    {
        mocRfcCalls();
    	CTRL_QuoteCreateUpdate controller = new CTRL_QuoteCreateUpdate();
        SBO_EnosixQuote_Detail.ITEMS item = new SBO_EnosixQuote_Detail.ITEMS();
        item.ItemNumber = '000010';
        controller.quoteDetail.ITEMS.add(item);
        controller.editItemNumber = '000010';
        controller.saveQuoteItem = item;
    	Test.startTest();
        System.assert(controller.customerReceiver!=null);
        CTRL_CMPCustomerSearch.CustomerSearchResult customerResult = new CTRL_CMPCustomerSearch.CustomerSearchResult();
        customerResult.customerNumber = 'CustNum';
        customerResult.partnerFunction = CTRL_QuoteCreateUpdate.SOLD_TO_PARTNER_CODE;
        controller.onReceiveCustomerSearch(customerResult);
        CTRL_CMPPartnerSearch.PartnerSearchResult partnerResult = new CTRL_CMPPartnerSearch.PartnerSearchResult();
        partnerResult.partnerNumber = 'CustNum';
        partnerResult.partnerFunction = CTRL_QuoteCreateUpdate.PAYER_PARTNER_CODE;
        controller.onReceivePartnerSearch(partnerResult);
        partnerResult.partnerFunction = CTRL_QuoteCreateUpdate.BILL_TO_PARTNER_CODE;
        controller.onReceivePartnerSearch(partnerResult);
        partnerResult.partnerFunction = CTRL_QuoteCreateUpdate.SHIP_TO_PARTNER_CODE;
        controller.onReceivePartnerSearch(partnerResult);
        SBO_EnosixQuote_Detail.ITEMS_ACTION itemAction = new SBO_EnosixQuote_Detail.ITEMS_ACTION();
        itemAction.ItemNumber = '000010';
        controller.quoteDetail.ITEMS.add(item);
        controller.quoteDetail.ITEMS_ACTION.add(itemAction);
        controller.onReceivePartnerSearch(partnerResult);
		Test.stopTest();
    }

    @isTest
    static void test_msReceiver()
    {
        mocRfcCalls();
    	CTRL_QuoteCreateUpdate controller = new CTRL_QuoteCreateUpdate();
    	Test.startTest();
		System.assert(controller.msReceiver!=null);
		Test.stopTest();
    }

    @isTest
    static void test_onReceiveMaterialSearchResults()
    {
        mocRfcCalls();
    	CTRL_QuoteCreateUpdate controller = new CTRL_QuoteCreateUpdate();
    	Test.startTest();
        List<CTRL_MaterialSearch.MaterialSearchResult> results = new List<CTRL_MaterialSearch.MaterialSearchResult>();
        CTRL_MaterialSearch.MaterialSearchResult material = new CTRL_MaterialSearch.MaterialSearchResult();
        SBO_SFCIMaterial_Search.SEARCHRESULT sboMaterial = new SBO_SFCIMaterial_Search.SEARCHRESULT();
        sboMaterial.Material = 'Material';
        material.material = sboMaterial;
        material.quantity = 1;
        results.add(material);
        controller.onReceiveMaterialSearchResults('test', results);
		Test.stopTest();
    }

    @isTest
    static void test_displayQuote()
    {
        mocRfcCalls();
    	CTRL_QuoteCreateUpdate controller = new CTRL_QuoteCreateUpdate();
    	Test.startTest();
        controller.displayQuote();
		Test.stopTest();
    }

    @isTest
    static void test_redirectToCreateCustomer()
    {
        mocRfcCalls();
    	CTRL_QuoteCreateUpdate controller = new CTRL_QuoteCreateUpdate();
    	Test.startTest();
        controller.redirectToCreateCustomer();
		Test.stopTest();
    }

    @isTest
    static void test_createNewQuote()
    {
        mocRfcCalls();
    	CTRL_QuoteCreateUpdate controller = new CTRL_QuoteCreateUpdate();
    	Test.startTest();
        controller.createNewQuote();
        controller.quoteDetail.PARTNERS.clear();
        SBO_EnosixQuote_Detail.PARTNERS partner1 = new SBO_EnosixQuote_Detail.PARTNERS();
        partner1.PartnerFunction = CTRL_QuoteCreateUpdate.SOLD_TO_PARTNER_CODE;
        partner1.CustomerNumber = 'CustomerNumber';
        controller.quoteDetail.PARTNERS.add(partner1);
        SBO_EnosixQuote_Detail.PARTNERS partner2 = new SBO_EnosixQuote_Detail.PARTNERS();
        partner2.PartnerFunction = CTRL_QuoteCreateUpdate.SHIP_TO_PARTNER_CODE;
        partner2.CustomerNumber = 'CustomerNumber';
        controller.quoteDetail.PARTNERS.add(partner2);
        SBO_EnosixQuote_Detail.PARTNERS partner3 = new SBO_EnosixQuote_Detail.PARTNERS();
        partner3.PartnerFunction = CTRL_QuoteCreateUpdate.CARRIER_PARTNER_CODE;
        partner3.CustomerNumber = 'CustomerNumber';
        controller.quoteDetail.PARTNERS.add(partner3);
        SBO_EnosixQuote_Detail.PARTNERS partner4 = new SBO_EnosixQuote_Detail.PARTNERS();
        partner4.PersonnelNumber = '000';
        partner4.ContactPersonNumber = '000';
        controller.quoteDetail.PARTNERS.add(partner4);
        controller.quoteDetail.ORDERDATA.CustomerPurchaseOrderDate = Date.today();
        controller.quoteDetail.SALES.ValidFrom = Date.today();
        controller.quoteDetail.SALES.ValidTo = Date.today().addDays(30);
        controller.quoteDetail.Sales.SalesOrganization = 'SalesOrganization';
        controller.quoteDetail.Sales.DistributionChannel = 'DistributionChannel';
        controller.quoteDetail.Sales.Division = 'Division';
        controller.quoteDetail.CustomerPurchaseOrderNumber = 'PoNum';
        controller.quoteDetail.CustomerPurchaseOrderDate = Date.today();
        controller.SimulateQuote();
        controller.createNewQuote();
        sboEnosixQuoteDetail.setSuccess(false);
        controller.createNewQuote();
        sboEnosixQuoteDetail.setSuccess(true);
        controller.quoteDetail.PARTNERS.clear();
        controller.quoteDetail.PARTNERS.add(partner1);
        controller.quoteDetail.PARTNERS.add(partner2);
        controller.quoteDetail.PARTNERS.add(partner3);
        controller.quoteDetail.ORDERDATA.CustomerPurchaseOrderDate = Date.today();
        controller.quoteDetail.SALES.ValidFrom = Date.today();
        controller.quoteDetail.SALES.ValidTo = Date.today().addDays(30);
        controller.quoteDetail.Sales.SalesOrganization = 'SalesOrganization';
        controller.quoteDetail.Sales.DistributionChannel = 'DistributionChannel';
        controller.quoteDetail.Sales.Division = 'Division';
        controller.updateQuote();
        sboEnosixQuoteDetail.setSuccess(false);
        controller.updateQuote();
        sboEnosixQuoteDetail.setSuccess(true);
        controller.quoteNumber = 'quoteNumber';
        controller.quoteDetail.PARTNERS.clear();
        controller.quoteDetail.PARTNERS.add(partner1);
        controller.quoteDetail.PARTNERS.add(partner2);
        controller.quoteDetail.PARTNERS.add(partner3);
        SBO_EnosixQuote_Detail.ITEMS item = new SBO_EnosixQuote_Detail.ITEMS();
        item.ItemNumber = '000010';
        controller.quoteDetail.ITEMS.add(item);
        SBO_EnosixQuote_Detail.ITEMS_ACTION itemAction1 = new SBO_EnosixQuote_Detail.ITEMS_ACTION();
        itemAction1.ItemChanged = true;
        itemAction1.ItemNumber = '000010';
        controller.quoteDetail.ITEMS_ACTION.add(itemAction1);
        partner3 = new SBO_EnosixQuote_Detail.PARTNERS();
        partner3.PersonnelNumber = '';
        partner3.ContactPersonNumber = '';
        controller.quoteDetail.PARTNERS.add(partner3);
        controller.loadClonedRecord();
        controller.goToSFSObjectPage();
        controller.quoteDetail.Sales.DistributionChannel = 'invalid data';
        controller.validateSalesAreas();
        controller.quoteDetail.Sales.SalesOrganization = 'invalid data';
        controller.validateSalesAreas();
		Test.stopTest();
    }

    @isTest 
    static void test_editItem()
    {
        mocRfcCalls();
        Test.startTest();
        CTRL_QuoteCreateUpdate controller = new CTRL_QuoteCreateUpdate();
        SBO_EnosixQuote_Detail.ITEMS item = new SBO_EnosixQuote_Detail.ITEMS();
        item.ItemNumber = '000010';
        controller.quoteDetail.ITEMS.add(item);
        SBO_EnosixQuote_Detail.ITEMS item2 = new SBO_EnosixQuote_Detail.ITEMS();
        item2.ItemNumber = '000020';
        controller.quoteDetail.ITEMS.add(item2);
        SBO_EnosixQuote_Detail.ITEMS_ACTION itemAction1 = new SBO_EnosixQuote_Detail.ITEMS_ACTION();
        itemAction1.ItemChanged = true;
        itemAction1.ItemNumber = '000010';
        controller.quoteDetail.ITEMS_ACTION.add(itemAction1);
        SBO_EnosixQuote_Detail.PARTNERS partner3 = new SBO_EnosixQuote_Detail.PARTNERS();
        controller.quoteDetail.PARTNERS.add(partner3);
        System.currentPageReference().getParameters().put('editItemNumber', '000010');
        controller.editItemClick();
        controller.saveEditItem();
        controller.quoteDetail.ITEMS.add(item);
        controller.editItemNumber = null;
        controller.editQuoteItem = controller.editQuoteItem;
        controller.editItemClick();
        controller.editQuoteItem = controller.editQuoteItem;
        controller.saveQuoteItem = item;
        controller.cancelEditItem();
        controller.displayedMaterialItems[0].isSelected = true;
        controller.cloneItems();
        controller.displayedMaterialItems[0].isSelected = false;
        controller.cloneItems();
        System.currentPageReference().getParameters().put('cloneItemNumber', '000010');
        controller.cloneItemClick();
        controller.displayedMaterialItems[0].isSelected = false;
        controller.displayedMaterialItems[1].isSelected = true;
        controller.moveItemsUp();
        controller.displayedMaterialItems[0].isSelected = true;
        controller.displayedMaterialItems[1].isSelected = false;
        controller.moveItemsDown();
        controller.displayedMaterialItems[0].isSelected = true;
        controller.displayedMaterialItems[1].isSelected = true;
        controller.editItems();
        controller.saveEditItem();
        controller.backEditItem();
        controller.editItems();
        controller.displayedMaterialItems[0].isSelected = false;
        controller.removeItems();
        controller.displayedMaterialItems[0].isSelected = true;
        controller.cancelEditItem();
        controller.cancelEditItem();
        controller.quoteDetail.ITEMS.add(item);
        controller.quoteDetail.ITEMS_ACTION.clear();
        itemAction1.ItemAdded = false;
        itemAction1.ItemChanged = false;
        itemAction1.ItemDeleted = false;
        controller.quoteDetail.ITEMS_ACTION.add(itemAction1);
        System.currentPageReference().getParameters().put('editItemNumber', '000010');
        controller.editItemNumber = '000010';
        controller.editItemClick();
        controller.editQuoteItem.item.Plant = 'New Plant';
        controller.saveQuoteItem.Plant = 'Old Plant';
        controller.saveEditItem();
        Boolean isNext = controller.isNext;
        Boolean isBack = controller.isBack;
        controller.exitEdits();
        Test.stopTest();
    }

    @isTest
    static void test_validateValidToAndFromDate()
    {
        mocRfcCalls();
        Test.startTest();
        SBO_EnosixQuote_Detail.EnosixQuote quote = new SBO_EnosixQuote_Detail.EnosixQuote();
    	System.assert(!CTRL_QuoteCreateUpdate.validateValidToAndFromDate(quote));
        quote.SALES.ValidTo = Date.today().addDays(-5);
        quote.SALES.ValidFrom = Date.today().addDays(-1);
        CTRL_QuoteCreateUpdate.validateValidToAndFromDate(quote);
        quote.SALES.ValidTo = Date.today().addDays(200);
        CTRL_QuoteCreateUpdate.validateValidToAndFromDate(quote);
        quote.SALES.ValidTo = Date.today().addDays(10);
       	CTRL_QuoteCreateUpdate controller = new CTRL_QuoteCreateUpdate();
        controller.quoteDetail = quote;
        controller.checkValidToAndFromDate();
		Test.stopTest();
    }

    @isTest
    static void test_checkRequestedDate()
    {
        mocRfcCalls();
        Test.startTest();
        SBO_EnosixQuote_Detail.EnosixQuote quote = new SBO_EnosixQuote_Detail.EnosixQuote();
        quote.SALES.RequestedDeliveryDate = Date.today();
        SBO_EnosixQuote_Detail.ITEMS item = new SBO_EnosixQuote_Detail.ITEMS();
        item.ItemNumber = '000010';
        quote.ITEMS.add(item);
       	CTRL_QuoteCreateUpdate controller = new CTRL_QuoteCreateUpdate();
        controller.quoteDetail = quote;
        controller.checkRequestedDate();
        controller.checkRequestedDate();
		Test.stopTest();
    }

    @isTest
    static void test_clearAllConditions()
    {
    	Test.startTest();
        SBO_EnosixQuote_Detail.EnosixQuote quote = new SBO_EnosixQuote_Detail.EnosixQuote();
        List<SBO_EnosixQuote_Detail.CONDITIONS> conditionsList = new List<SBO_EnosixQuote_Detail.CONDITIONS>();
        SBO_EnosixQuote_Detail.CONDITIONS condition = new SBO_EnosixQuote_Detail.CONDITIONS();
        condition.ConditionItemNumber = '000010';
        conditionsList.add(condition);
        CTRL_QuoteCreateUpdate.clearAllConditions(quote, conditionsList);
		Test.stopTest();
    }

    @isTest
    static void test_removeItemClick()
    {
        mocRfcCalls();
        System.currentPageReference().getParameters().put('removeItemNumber','000010');
    	CTRL_QuoteCreateUpdate controller = new CTRL_QuoteCreateUpdate();
    	Test.startTest();
        SBO_EnosixQuote_Detail.EnosixQuote quote = new SBO_EnosixQuote_Detail.EnosixQuote();
        SBO_EnosixQuote_Detail.ITEMS_SCHEDULE itemSchedule = new SBO_EnosixQuote_Detail.ITEMS_SCHEDULE();
        itemSchedule.ItemNumber = '000010';
        quote.ITEMS_SCHEDULE.add(itemSchedule);
        SBO_EnosixQuote_Detail.ITEMS item = new SBO_EnosixQuote_Detail.ITEMS();
        item.ItemNumber = '000010';
        quote.ITEMS.add(item);
        SBO_EnosixQuote_Detail.ITEMS_ACTION itemAction = new SBO_EnosixQuote_Detail.ITEMS_ACTION();
        itemAction.ItemNumber = '000010';
        quote.ITEMS_ACTION.add(itemAction);
        SBO_EnosixQuote_Detail.CONDITIONS condition = new SBO_EnosixQuote_Detail.CONDITIONS();
        condition.ConditionItemNumber = '000010';
        controller.initConditions.add(condition);
        controller.quoteDetail = quote;
        controller.removeItemClick();
        controller.quoteDetail.ITEMS.add(item);
        itemAction.ItemAdded = true;
        controller.quoteDetail.ITEMS_ACTION.add(itemAction);
        controller.removeItemClick();
		Test.stopTest();
    }

    @isTest
    static void test_isRequestedShipEnabled()
    {
        mocRfcCalls();
    	CTRL_QuoteCreateUpdate controller = new CTRL_QuoteCreateUpdate();
    	Test.startTest();
        Boolean testBool = controller.isRequestedShipEnabled;
		Test.stopTest();
    }

    static void mocRfcCalls()
    {
        sboEnosixQuoteDetail = new MOC_EnosixQuote_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixQuote_Detail.class, sboEnosixQuoteDetail);
        ensxsdk.EnosixFramework.setMock(SBO_EnosixMaterial_Detail.class, new MOC_EnosixMaterial_Detail());
        ensxsdk.EnosixFramework.setMock(SBO_EnosixXiIntercept_Detail.class, new MOC_EnosixXiIntercept_Detail());
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustomer_Detail.class, new MOC_EnosixCustomer_Detail());
        ensxsdk.EnosixFramework.setMock(SBO_SFCIMaterial_Search.class, new MOC_EnosixMaterial_Search());
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_DOC_TYPE_VALUES.class, new MOC_RFC_SD_GET_DOC_TYPE_VALUES_ET_OUTPUT());
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_ORDER_TYPES.class, new MOC_RFC_SD_GET_ORDER_TYPES());
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_CONDITION_GROUP.class, new MOC_RFC_SD_GET_CONDITION_GROUP());
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_CURRENCY_LIST.class, new MOC_RFC_SD_GET_CURRENCY_LIST());
        ensxsdk.EnosixFramework.setMock(SBO_SFCIPartner_Search.class, new Mock_SBO_SFCIPartner_Search());
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_ITEMCAT_VALUES.class, new MOC_RFC_SD_GET_ITEMCAT_VALUES());
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_COUNTRIES.class, new MOC_RFC_SD_GET_COUNTRIES());

        Opportunity opp = [SELECT Id, AccountId FROM Opportunity LIMIT 1];
        UTIL_PageState.current.sfAccountId = opp.AccountId;
        UTIL_PageState.current.sfOpportunityId = opp.Id;
    }

    @testSetup
    static void writeTestRecords()
    {
        // Only the DML in @testSetup is applied to each test
        Account acct = TSTU_SFTestObject.createTestAccount();
    	acct.Name='Acme';
    	acct.BillingCity='Cincinnatti';
        acct.put(UTIL_SFAccount.CustomerFieldName,'CustNum');
    	TSTU_SFTestObject.upsertWithRetry(acct);

        Id pricebookId = UTIL_Pricebook.getStandardPriceBookId();
        Opportunity opp = TSTU_SFTestObject.createTestOpportunity();
        opp.Name = 'Test Opp';
        opp.StageName ='Closed Won';
        opp.CloseDate = system.today();
        opp.AccountId = acct.Id;
        opp.put(UTIL_SFOpportunity.QuoteFieldName, '12345');
        opp.Pricebook2Id = pricebookId;
        TSTU_SFTestObject.upsertWithRetry(opp);
        opp = [SELECT Id, Pricebook2Id FROM Opportunity WHERE Id = :opp.Id];

        Product2 product = TSTU_SFTestObject.createTestProduct2();
        product.Name = 'test';
        product.put(UTIL_SFProduct.MaterialFieldName, 'test');
        TSTU_SFTestObject.upsertWithRetry(product);

        PriceBookEntry pbe = TSTU_SFTestObject.createTestPriceBookEntry();
        pbe.UnitPrice = 100;
		pbe.Pricebook2Id = opp.Pricebook2Id;
		pbe.Product2Id = product.Id;
		pbe.UseStandardPrice = false;
		pbe.IsActive = true;
		TSTU_SFTestObject.upsertWithRetry(pbe);

        OpportunityLineItem oli = TSTU_SFTestObject.createTestOpportunityLineItem();
		oli.OpportunityId = opp.Id;
		oli.Quantity = 10;
		oli.UnitPrice = .95;
		oli.Description = 'test Desciption';
        oli.PricebookEntryId = pbe.Id;
        oli.ServiceDate = system.today();
        TSTU_SFTestObject.upsertWithRetry(oli);
    }
}