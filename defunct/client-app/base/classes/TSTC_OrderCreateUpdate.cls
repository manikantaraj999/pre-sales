@isTest
public with sharing class TSTC_OrderCreateUpdate
{
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
            SBO_EnosixSO_Detail.ITEMS_TEXT itemText = new SBO_EnosixSO_Detail.ITEMS_TEXT();
            itemText.ItemNumber = '000010';
            result.ITEMS_TEXT.add(itemText);
            SBO_EnosixSO_Detail.PARTNERS partner = new SBO_EnosixSO_Detail.PARTNERS();
            partner.PartnerFunction = UTIL_Customer.SHIP_TO_PARTNER_CODE;
            result.PARTNERS.add(partner);
            result.SalesDocument = '12345';
            result.setSuccess(success);
            return result;
        }
        public ensxsdk.EnosixFramework.DetailObject executeSave(ensxsdk.EnosixFramework.DetailObject obj)
        {
            SBO_EnosixSO_Detail.EnosixSO result = (SBO_EnosixSO_Detail.EnosixSO) obj;
            result.SalesDocument = '12345';
            result.setSuccess(success);
            return result;
        }
        public ensxsdk.EnosixFramework.DetailObject executeCommand(string command, ensxsdk.EnosixFramework.DetailObject obj)
        {
            SBO_EnosixSO_Detail.EnosixSO result = (SBO_EnosixSO_Detail.EnosixSO) obj;
            SBO_EnosixSO_Detail.ITEMS item = new SBO_EnosixSO_Detail.ITEMS();
            item.ItemNumber = '000010';
            result.ITEMS.add(item);
            result.SalesDocument = '12345';
            result.setSuccess(success);
            return result;
        }
        public  ensxsdk.EnosixFramework.DetailObject executeInitialize(ensxsdk.EnosixFramework.DetailObject  obj)
        {
            SBO_EnosixSO_Detail.EnosixSO result = (SBO_EnosixSO_Detail.EnosixSO) obj;
            result.setSuccess(success);
            return result;
        }
    }

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

    public class MOC_EnosixCustomer_Search implements ensxsdk.EnosixFramework.SearchSBOSearchMock
    {
        public ensxsdk.EnosixFramework.SearchContext executeSearch(ensxsdk.EnosixFramework.SearchContext searchContext)
        {
            SBO_SFCICustomer_Search.SFCICustomer_SR search_result = new SBO_SFCICustomer_Search.SFCICustomer_SR();
            search_result.setSuccess(true);
            searchContext.baseResult = search_result;
			return searchContext;
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

    public class MOC_RFC_SD_GET_DOC_TYPE_VALUES_ET_OUTPUT implements ensxsdk.EnosixFramework.RFCMock
    {
        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            RFC_SD_GET_DOC_TYPE_VALUES.RESULT result = new RFC_SD_GET_DOC_TYPE_VALUES.RESULT();
            RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT sditm = new RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT();
            sditm.DocumentType = 'OR';
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

    public class MOC_RFC_SD_GET_RETURN_CUSTINSPEC implements ensxsdk.EnosixFramework.RFCMock
    {
        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            RFC_SD_GET_RETURN_CUSTINSPEC.RESULT result = new RFC_SD_GET_RETURN_CUSTINSPEC.RESULT();
            result.setSuccess(true);
            return result;
        }
    }

    public class MOC_RFC_SD_GET_SHIP_INFO implements ensxsdk.EnosixFramework.RFCMock
    {
        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            RFC_SD_GET_SHIP_INFO.RESULT result = new RFC_SD_GET_SHIP_INFO.RESULT();
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

    static CTRL_OrderCreateUpdate createOrderController()
    {
        mocRfcCalls();
        Test.setCurrentPageReference(new PageReference('Page.VFP_OrderCreateUpdate'));
        CTRL_OrderCreateUpdate controller = new CTRL_OrderCreateUpdate();
        String previousScreen = controller.previousScreen;
        Boolean isClassic = controller.isClassic;
        string pathMaterialDetail = controller.pathMaterialDetail;
        return controller;
    }

    @isTest
    static void test_CreateController1()
    {
        mocRfcCalls();
    	Test.startTest();
        UTIL_AppSettings.resourceJson = '{"CTRL_OrderCreateUpdate.Logging": true}';
		CTRL_OrderCreateUpdate controller = new CTRL_OrderCreateUpdate();
        controller.soldToCustomer = controller.soldToCustomer;
        SBO_EnosixCustomer_Detail.EnosixCustomer shipToCustomer = controller.shipToCustomer;
        String editActionElementId = controller.editActionElementId;
        controller.updateSalesAreas();
        controller.orderDetail.Sales.SalesDocumentCurrency = '';
        controller.editItemNumber = '000010';
        controller.updateSalesAreas();
        controller.isInit = false;
        controller.updateSalesAreas();
        controller.orderDetail.PARTNERS.clear();
        SBO_EnosixSO_Detail.PARTNERS partner1 = new SBO_EnosixSO_Detail.PARTNERS();
        partner1.PartnerFunction = CTRL_OrderCreateUpdate.SOLD_TO_PARTNER_CODE;
        partner1.CustomerNumber = 'CustomerNumber';
        controller.orderDetail.PARTNERS.add(partner1);
        SBO_EnosixSO_Detail.PARTNERS partner2 = new SBO_EnosixSO_Detail.PARTNERS();
        partner2.PartnerFunction = CTRL_OrderCreateUpdate.SHIP_TO_PARTNER_CODE;
        partner2.CustomerNumber = 'CustomerNumber';
        controller.orderDetail.PARTNERS.add(partner2);
        SBO_EnosixSO_Detail.PARTNERS partner3 = new SBO_EnosixSO_Detail.PARTNERS();
        partner3.PartnerFunction = CTRL_OrderCreateUpdate.CARRIER_PARTNER_CODE;
        partner3.CustomerNumber = 'CustomerNumber';
        controller.orderDetail.PARTNERS.add(partner3);
        SBO_EnosixSO_Detail.PARTNERS partner4 = new SBO_EnosixSO_Detail.PARTNERS();
        partner4.PartnerFunction = 'TEST';
        partner4.PersonnelNumber = '000';
        partner4.ContactPersonNumber = '000';
        controller.orderDetail.PARTNERS.add(partner4);
        SBO_EnosixSO_Detail.ITEMS item = new SBO_EnosixSO_Detail.ITEMS();
        item.ItemNumber = '000010';
        controller.orderDetail.ITEMS.add(item);
        controller.orderNumber = 'orderNumber';
        UTIL_PageState.current.sapAddPartnerTo = 'addPartnerTo';
        UTIL_PageState.current.sapShipToNum = 'shipToNum';
        UTIL_PageState.current.sapSalesArea = 'SalesOrganization,DistributionChannel,Division';
        controller.isReferenceMode = true;
        controller.initMode();
        controller.isReferenceMode = false;
        controller.isUpdateMode = true;
        controller.initMode();
        controller.orderDetail.ITEMS.add(item);
        SBO_EnosixSO_Detail.ITEMS item2 = new SBO_EnosixSO_Detail.ITEMS();
        item2.ItemNumber = '000020';
        controller.orderDetail.ITEMS.add(item2);
        SBO_EnosixSO_Detail.ITEMS item3 = new SBO_EnosixSO_Detail.ITEMS();
        item3.ItemNumber = '000030';
        controller.orderDetail.ITEMS.add(item3);
        SBO_EnosixSO_Detail.ITEMS_ACTION itemAction1 = new SBO_EnosixSO_Detail.ITEMS_ACTION();
        itemAction1.ItemAdded = true;
        itemAction1.ItemNumber = '000010';
        controller.orderDetail.ITEMS_ACTION.add(itemAction1);
        SBO_EnosixSO_Detail.ITEMS_ACTION itemAction2 = new SBO_EnosixSO_Detail.ITEMS_ACTION();
        itemAction2.ItemChanged = true;
        itemAction2.ItemNumber = '000020';
        controller.orderDetail.ITEMS_ACTION.add(itemAction2);
        SBO_EnosixSO_Detail.ITEMS_ACTION itemAction3 = new SBO_EnosixSO_Detail.ITEMS_ACTION();
        itemAction3.ItemDeleted = true;
        itemAction3.ItemNumber = '000030';
        controller.orderDetail.ITEMS_ACTION.add(itemAction3);
        SBO_EnosixSO_Detail.ITEMS_TEXT itemText = new SBO_EnosixSO_Detail.ITEMS_TEXT();
        itemText.ItemNumber = '000010';
        controller.orderDetail.ITEMS_TEXT.add(itemText);
        SBO_EnosixSO_Detail.ITEMS_SCHEDULE itemSchedule = new SBO_EnosixSO_Detail.ITEMS_SCHEDULE();
        itemSchedule.ItemNumber = '000010';
        controller.orderDetail.ITEMS_SCHEDULE.add(itemSchedule);
        SBO_EnosixSO_Detail.CONDITIONS condition = new SBO_EnosixSO_Detail.CONDITIONS();
        condition.ConditionItemNumber = '000010';
        controller.orderDetail.CONDITIONS.add(condition);
        SBO_EnosixSO_Detail.ITEMS_CONFIG itemConfig = new SBO_EnosixSO_Detail.ITEMS_CONFIG();
        itemConfig.ItemNumber = '000010';
        controller.orderDetail.ITEMS_CONFIG.add(itemConfig);
        Map<Integer, Integer> changeItemNumberMap = new Map<Integer, Integer>();
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap = new Map<String, UTIL_SFSObjectDoc.SfSObjectItem>();
        CTRL_OrderCreateUpdate.moveItemsUpOrDown(controller.orderDetail, changeItemNumberMap, sfSObjectLineIdMap);
        changeItemNumberMap.put(10,20);
        changeItemNumberMap.put(20,10);
        changeItemNumberMap.put(30,30);
        sfSObjectLineIdMap.put('20', new UTIL_SFSObjectDoc.SfSObjectItem(null));
        sfSObjectLineIdMap.put('NotFound', new UTIL_SFSObjectDoc.SfSObjectItem(null));
        CTRL_OrderCreateUpdate.moveItemsUpOrDown(controller.orderDetail, changeItemNumberMap, sfSObjectLineIdMap);
        SBO_EnosixSO_Detail.ITEMS_ACTION itemAction4 = new SBO_EnosixSO_Detail.ITEMS_ACTION();
        itemAction4.ItemDeleted = true;
        itemAction4.ItemNumber = '000040';
        controller.orderDetail.ITEMS_ACTION.add(itemAction4);
        SBO_EnosixSO_Detail.ITEMS_CONFIG itemConfig4 = new SBO_EnosixSO_Detail.ITEMS_CONFIG();
        itemConfig4.ItemNumber = '000040';
        controller.orderDetail.ITEMS_CONFIG.add(itemConfig4);
        System.currentPageReference().getParameters().put('editItemNumber', '000010');
        controller.orderNumber = 'orderNumber';
        controller.orderDetail.ITEMS.add(item);
        controller.displayedMaterialItems = null;
        controller.editItemClick();
        controller.ItemCategories = null;
        List<SelectOption> ItemCategories = controller.ItemCategories;
        controller.selectedItemsMap.clear();
        controller.cancelEditItem();
        controller.itemPlant = controller.itemPlant;
        controller.orderDetail.SALES.SalesDocumentType = null;
        controller.init();
        controller.isOrderMode = true;
        controller.orderNumber = 'orderNumber';
        controller.init();
        controller.isOrderMode = true;
        controller.orderNumber = '';
        controller.init();
        controller.isUpdateMode = false;
        controller.isReferenceMode = false;
        controller.isCloneMode = true;
        controller.initMode();
        List<SelectOption> orderTypes = controller.OrderTypes;
        partner4.PartnerFunction = 'TEST';
        partner4.PersonnelNumber = '000';
        partner4.ContactPersonNumber = '000';
        controller.orderDetail.PARTNERS.add(partner4);
        controller.loadClonedRecord();
        controller.orderNumber = null;
        controller.isUpdateMode = true;
        controller.initMode();
        controller.isUpdateMode = false;
        controller.isReferenceMode = true;
        controller.initMode();
        controller.isUpdateMode = false;
        controller.isReferenceMode = false;
        controller.isCloneMode = true;
        controller.initMode();
        UTIL_PageState.current.sfOpportunityId = null;
        controller.isOrderMode = true;
        controller.orderNumber = null;
        controller.init();
        controller.isValidSalesData('test', new List<SelectOption>{new SelectOption('test','test')});
        Boolean isClassic = controller.isClassic;
        string pathMaterialDetail = controller.pathMaterialDetail;
        String previousScreen = controller.previousScreen;
        String opportunityId = controller.opportunityId;
        String quoteRequestId = controller.quoteRequestId;
        List<SelectOption> CountryOptions = controller.CountryOptions;
        List<SelectOption> RegionOptions = controller.RegionOptions;
    	Test.stopTest();
    }

    @isTest
    static void test_CreateController2()
    {
        mocRfcCalls();
    	Test.startTest();
		Test.setCurrentPageReference(new PageReference('Page.VFP_OrderCreateUpdate'));
        UTIL_PageState.current.sapAddPartnerTo = 'addPartnerTo';
        UTIL_PageState.current.sapShipToNum = 'shipToNum';
        UTIL_PageState.current.sapSalesArea = 'SalesOrganization,DistributionChannel,Division';
		CTRL_OrderCreateUpdate controller = new CTRL_OrderCreateUpdate();
    	Test.stopTest();
    	System.assertNotEquals(controller, null);
    }

    @isTest
    static void test_screenVariables()
    {
        mocRfcCalls();
        CTRL_OrderCreateUpdate controller = createOrderController();
        Test.startTest();
        controller.customerSalesData = controller.customerSalesData;
        controller.companyData = controller.companyData;
        boolean opportunityClosed = controller.opportunityClosed;
        String returnToId = controller.returnToId;
        String returnToName = controller.returnToName;
        String returnToAccountName = controller.returnToAccountName;
        controller.soldToCustomer = controller.soldToCustomer;
        controller.ShipToPartner.CustomerNumber = 'CustomerNumber';
        controller.shipToCustomer = controller.shipToCustomer;
        controller.BillToPartner.CustomerNumber = 'CustomerNumber';
        controller.billToCustomer = controller.billToCustomer;
        controller.PayerPartner.CustomerNumber = 'CustomerNumber';
        controller.payerCustomer = controller.payerCustomer;
        List<UTIL_Order.OrderItem> displayedMaterialItems = controller.displayedMaterialItems;
        RFC_SD_GET_SHIP_INFO.RESULT shippingMaster = controller.shippingMaster;
        System.assert(controller.isShipToAutoSearchEnabled!=null);
        SBO_EnosixSO_Detail.ITEMS item = new SBO_EnosixSO_Detail.ITEMS();
        item.ItemNumber = '000010';
        controller.orderDetail.ITEMS.add(item);
        controller.editItemNumber = '000010';
        controller.saveOrderItem = item;
        System.assert(controller.customerReceiver!=null);
        CTRL_CMPCustomerSearch.CustomerSearchResult customerResult = new CTRL_CMPCustomerSearch.CustomerSearchResult();
        customerResult.customerNumber = 'CustNum';
        customerResult.partnerFunction = CTRL_OrderCreateUpdate.SOLD_TO_PARTNER_CODE;
        controller.onReceiveCustomerSearch(customerResult);
        System.assert(controller.partnerReceiver!=null);
        CTRL_CMPPartnerSearch.PartnerSearchResult partnerResult = new CTRL_CMPPartnerSearch.PartnerSearchResult();
        partnerResult.partnerNumber = 'CustNum';
        partnerResult.partnerFunction = CTRL_OrderCreateUpdate.SHIP_TO_PARTNER_CODE;
        controller.onReceivePartnerSearch(partnerResult);
        partnerResult.partnerFunction = CTRL_OrderCreateUpdate.BILL_TO_PARTNER_CODE;
        controller.onReceivePartnerSearch(partnerResult);
        partnerResult.partnerFunction = CTRL_OrderCreateUpdate.PAYER_PARTNER_CODE;
        controller.onReceivePartnerSearch(partnerResult);
        controller.shipToCustomer = controller.shipToCustomer;
        Boolean isShipToPartnerAddressDisplayed = controller.isShipToPartnerAddressDisplayed;
        List<SelectOption> ShippingConditions = controller.ShippingConditions;
        List<SelectOption> ItemCategories = controller.ItemCategories;
        SBO_EnosixSO_Detail.PARTNERS Carrier = controller.Carrier;
        controller.selectedMaterialDetail = new SBO_EnosixMaterial_Detail.EnosixMaterial();
        SBO_EnosixMaterial_Detail.PLANT_DATA plantData = new SBO_EnosixMaterial_Detail.PLANT_DATA();
        plantData.Plant = 'Plant';
        plantData.SalesOrganization = 'SalesOrganization';
        plantData.DistributionChannel = 'DistributionChannel';
        plantData.Name = 'Name';
        controller.selectedMaterialDetail.PLANT_DATA.add(plantData);
        List<SelectOption> PlantSelections = controller.PlantSelections;
        List<string> orderMaterialTypes = controller.orderMaterialTypes;
        List<string> defaultOrderMaterialTypes = controller.defaultOrderMaterialTypes;
        boolean isOrderMaterialAutoSearchEnabled = controller.isOrderMaterialAutoSearchEnabled;
        CB_MaterialSearchReceiver msReceiver = controller.msReceiver;
        controller.displayOrder();
        controller.redirectToCreateCustomer();
        controller.sfSObject = TSTU_SFTestObject.createTestOpportunity();
        Object testObj = controller.isAddMaterial;
        testObj = controller.isRemoveMaterial;
        testObj = controller.isEditMaterial;
        testObj = controller.isCloneMaterial;
        testObj = controller.isMoveMaterial;
        testObj = controller.isSelectMaterial;
        controller.orderAccount = new Account();
        controller.soldToCustomer = null;
        testObj = controller.soldToCustomer;
        testObj = CTRL_OrderCreateUpdate.pickDefaultOrderType(new List<SelectOption>{new SelectOption('test','test')});
        Test.stopTest();
    }

    @isTest
    static void test_onReceiveMaterialSearchResults()
    {
        mocRfcCalls();
        CTRL_OrderCreateUpdate controller = new CTRL_OrderCreateUpdate();
        List<CTRL_MaterialSearch.MaterialSearchResult> results = new List<CTRL_MaterialSearch.MaterialSearchResult>();
        SBO_SFCIMaterial_Search.SEARCHRESULT sr = new SBO_SFCIMaterial_Search.SEARCHRESULT();
        CTRL_MaterialSearch.MaterialSearchResult material = CTRL_MaterialSearch.materialSearchResultFromSR(sr, true, false);
        material.quantity = -1;
        results.add(material);
        controller.onReceiveMaterialSearchResults('', results);
        results.clear();
        sr.Material = 'Material';
        material = CTRL_MaterialSearch.materialSearchResultFromSR(sr, true, false);
        material.quantity = -1;
        results.add(material);
        controller.onReceiveMaterialSearchResults('', results);
        results.clear();
        material = CTRL_MaterialSearch.materialSearchResultFromSR(sr, true, true);
        results.add(material);
        controller.onReceiveMaterialSearchResults('', results);
    }

    @isTest
    static void test_createNewOrder()
    {
        mocRfcCalls();
        detailMoc.setSuccess(true);
        CTRL_OrderCreateUpdate controller = new CTRL_OrderCreateUpdate();
        controller.orderDetail.Sales.SalesDocumentType = 'OR';
        controller.orderDetail.PARTNERS.clear();
        SBO_EnosixSO_Detail.PARTNERS partner1 = new SBO_EnosixSO_Detail.PARTNERS();
        partner1.PartnerFunction = CTRL_OrderCreateUpdate.SOLD_TO_PARTNER_CODE;
        partner1.CustomerNumber = 'CustomerNumber';
        controller.orderDetail.PARTNERS.add(partner1);
        SBO_EnosixSO_Detail.PARTNERS partner2 = new SBO_EnosixSO_Detail.PARTNERS();
        partner2.PartnerFunction = CTRL_OrderCreateUpdate.SHIP_TO_PARTNER_CODE;
        partner2.CustomerNumber = 'CustomerNumber';
        controller.orderDetail.PARTNERS.add(partner2);
        SBO_EnosixSO_Detail.PARTNERS partner3 = new SBO_EnosixSO_Detail.PARTNERS();
        partner3.PartnerFunction = CTRL_OrderCreateUpdate.CARRIER_PARTNER_CODE;
        partner3.CustomerNumber = 'CustomerNumber';
        controller.orderDetail.PARTNERS.add(partner3);
        SBO_EnosixSO_Detail.PARTNERS partner4 = new SBO_EnosixSO_Detail.PARTNERS();
        partner4.CustomerNumber = null;
        partner4.Vendor = null;
        partner4.PersonnelNumber = '000';
        partner4.ContactPersonNumber = '000';
        controller.orderDetail.PARTNERS.add(partner4);
        controller.orderDetail.ORDERDATA.CustomerPurchaseOrderDate = Date.today();
        controller.orderDetail.SALES.ValidFrom = Date.today();
        controller.orderDetail.SALES.ValidTo = Date.today().addDays(30);
        controller.orderDetail.Sales.SalesOrganization = 'SalesOrganization';
        controller.orderDetail.Sales.DistributionChannel = 'DistributionChannel';
        controller.orderDetail.CustomerPurchaseOrderNumber = 'PoNum';
        controller.orderDetail.ORDERDATA.CustomerPurchaseOrderDate = Date.today();
        controller.SimulateOrder();
        controller.createNewOrder();
        controller.updateOrder();
        controller.orderDetail.Sales.SalesOrganization = 'SalesOrganization';
        controller.orderDetail.Sales.DistributionChannel = 'DistributionChannel';
        controller.orderDetail.Sales.Division = 'Division';
        controller.orderDetail.Sales.DistributionChannel = 'DistributionChannel';
        controller.orderDetail.PARTNERS.clear();
        controller.orderDetail.PARTNERS.add(partner1);
        controller.orderDetail.PARTNERS.add(partner2);
        controller.orderDetail.PARTNERS.add(partner3);
        controller.orderDetail.PARTNERS.add(partner4);
        controller.orderDetail.CustomerPurchaseOrderNumber = 'CustomerPurchaseOrderNumber';
        controller.orderDetail.ORDERDATA.CustomerPurchaseOrderDate = null;
        controller.createNewOrder();
        controller.updateOrder();
        controller.orderDetail.ORDERDATA.CustomerPurchaseOrderDate = System.now().Date();
        SBO_EnosixSO_Detail.ITEMS_SCHEDULE schedule = new SBO_EnosixSO_Detail.ITEMS_SCHEDULE();
        controller.orderDetail.ITEMS_SCHEDULE.add(schedule);
        controller.createNewOrder();
        controller.updateOrder();
        detailMoc.setSuccess(false);
        controller.createNewOrder();
        controller.updateOrder();
        controller.orderNumber = 'orderNumber';
        UTIL_PageState.current.sapAddPartnerTo = 'addPartnerTo';
        UTIL_PageState.current.sapShipToNum = 'shipToNum';
        UTIL_PageState.current.sapSalesArea = 'SalesOrganization,DistributionChannel,Division';
        controller.isReferenceMode = true;
        controller.initMode();
        controller.isReferenceMode = false;
        controller.isUpdateMode = true;
        controller.initMode();
        controller.itemPlant = controller.itemPlant;
        controller.editItemNumber = '000010';
        controller.itemPlant = controller.itemPlant;
        controller.editItemNumber = null;
        controller.orderDetail.PARTNERS.clear();
        controller.orderDetail.PARTNERS.add(partner1);
        controller.orderDetail.PARTNERS.add(partner2);
        controller.orderDetail.PARTNERS.add(partner3);
        controller.orderDetail.PARTNERS.add(partner4);
        controller.orderDetail.CustomerPurchaseOrderNumber = 'CustomerPurchaseOrderNumber';
        controller.orderDetail.ORDERDATA.CustomerPurchaseOrderDate = Date.today();
        controller.orderDetail.SALES.ValidFrom = Date.today();
        controller.orderDetail.SALES.ValidTo = Date.today().addDays(30);
        controller.orderDetail.SALES.ValidTo = Date.today().addDays(30);
        controller.orderDetail.Sales.SalesOrganization = 'SalesOrganization';
        controller.orderDetail.Sales.DistributionChannel = 'DistributionChannel';
        controller.orderDetail.Sales.Division = 'Division';
        controller.orderDetail.Sales.SalesOrganization = 'SalesOrganization';
        controller.orderDetail.Sales.SalesOrganization = 'SalesOrganization';
        controller.orderDetail.Sales.SalesDocumentType = 'OR';
        controller.soldToPartner.CustomerNumber = 'CustomerNumber';
        controller.shipToPartner.CustomerNumber = 'CustomerNumber';
        controller.createNewOrder();
        controller.updateOrder();
        detailMoc.setSuccess(true);
        controller.createNewOrder();
        controller.updateOrder();
        controller.orderDetail.Sales.SalesOrganization = null;
        controller.orderDetail.ORDERDATA.CustomerPurchaseOrderDate = null;
        controller.createNewOrder();
        controller.updateOrder();
        controller.orderDetail.CustomerPurchaseOrderNumber = null;
        controller.createNewOrder();
        controller.updateOrder();
        controller.orderDetail.PARTNERS.add(partner4);
        controller.initReferenceFromQuote();
        controller.sfSObject = TSTU_SFTestObject.createTestOpportunity();
        controller.goToSFSObjectPage();
}

    @isTest
    static void test_PlantSelections()
    {
        mocRfcCalls();
    	CTRL_OrderCreateUpdate controller = new CTRL_OrderCreateUpdate();
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
        controller.orderDetail.Sales.SalesOrganization = 'SalesOrganization';
        controller.orderDetail.Sales.DistributionChannel = 'DistributionChannel';
        controller.orderDetail.Sales.Division = 'Division';
        System.assert(controller.PlantSelections!=null);
		Test.stopTest();
    }

    @isTest 
    static void test_editItem()
    {
        mocRfcCalls();
        Test.startTest();
        CTRL_OrderCreateUpdate controller = new CTRL_OrderCreateUpdate();
        SBO_EnosixSO_Detail.ITEMS item = new SBO_EnosixSO_Detail.ITEMS();
        item.ItemNumber = '000010';
        controller.orderDetail.ITEMS.add(item);
        SBO_EnosixSO_Detail.ITEMS item2 = new SBO_EnosixSO_Detail.ITEMS();
        item2.ItemNumber = '000020';
        controller.orderDetail.ITEMS.add(item2);
        SBO_EnosixSO_Detail.ITEMS_ACTION itemAction1 = new SBO_EnosixSO_Detail.ITEMS_ACTION();
        itemAction1.ItemChanged = true;
        itemAction1.ItemNumber = '000010';
        controller.orderDetail.ITEMS_ACTION.add(itemAction1);
        SBO_EnosixSO_Detail.PARTNERS partner3 = new SBO_EnosixSO_Detail.PARTNERS();
        controller.orderDetail.PARTNERS.add(partner3);
        System.currentPageReference().getParameters().put('editItemNumber', '000010');
        controller.editItemClick();
        controller.saveEditItem();
        controller.orderDetail.ITEMS.add(item);
        controller.editItemNumber = null;
        controller.editOrderItem = controller.editOrderItem;
        controller.editItemClick();
        controller.editOrderItem = controller.editOrderItem;
        controller.saveOrderItem = item;
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
        controller.orderDetail.ITEMS.add(item);
        controller.orderDetail.ITEMS_ACTION.clear();
        itemAction1.ItemAdded = false;
        itemAction1.ItemChanged = false;
        itemAction1.ItemDeleted = false;
        controller.orderDetail.ITEMS_ACTION.add(itemAction1);
        System.currentPageReference().getParameters().put('editItemNumber', '000010');
        controller.editItemNumber = '000010';
        controller.editItemClick();
        controller.editOrderItem.item.Plant = 'New Plant';
        controller.saveOrderItem.Plant = 'Old Plant';
        controller.saveEditItem();
        Boolean isNext = controller.isNext;
        Boolean isBack = controller.isBack;
        controller.exitEdits();
        Test.stopTest();
    }

    @isTest
    static void test_removeItemClick()
    {
        mocRfcCalls();
        System.currentPageReference().getParameters().put('removeItemNumber', '000010');
        CTRL_OrderCreateUpdate controller = new CTRL_OrderCreateUpdate();
        controller.orderDetail.ITEMS_SCHEDULE.add(new SBO_EnosixSO_Detail.ITEMS_SCHEDULE());
        SBO_EnosixSO_Detail.ITEMS item = new SBO_EnosixSO_Detail.ITEMS();
        item.ItemNumber = '000010';
        controller.orderDetail.ITEMS.add(item);
        SBO_EnosixSO_Detail.ITEMS_ACTION itemAction = new SBO_EnosixSO_Detail.ITEMS_ACTION();
        itemAction.ItemNumber = '000010';
        controller.orderDetail.ITEMS_ACTION.add(itemAction);
        SBO_EnosixSO_Detail.CONDITIONS condition = new SBO_EnosixSO_Detail.CONDITIONS();
        condition.ConditionItemNumber = '000010';
        controller.orderDetail.CONDITIONS.add(condition);
        controller.removeItemClick();
        controller.orderDetail.ITEMS.add(item);
        itemAction.ItemAdded = true;
        controller.orderDetail.ITEMS_ACTION.add(itemAction);
        controller.removeItemClick();
    }

    @isTest
    static void test_validateOrder()
    {
        mocRfcCalls();
        Test.startTest();
        CTRL_OrderCreateUpdate controller = createOrderController();
        controller.orderDetail = new SBO_EnosixSO_Detail.EnosixSO();
        controller.orderDetail.Sales.SalesDocumentType = 'OR';
        boolean result = controller.validateOrder();
        Test.stopTest();
        System.assert(false == result);
    }

    @isTest
    static void test_validateNewLineItem()
    {
        mocRfcCalls();
        SBO_EnosixSO_Detail.ITEMS item = new SBO_EnosixSO_Detail.ITEMS();
        Test.startTest();
        boolean result = CTRL_OrderCreateUpdate.validateNewLineItem(item);
        Test.stopTest();
        System.assert(false == result);
    }


    @isTest
    static void test_getOrderTypes()
    {
        mocRfcCalls();
        CTRL_OrderCreateUpdate controller = new CTRL_OrderCreateUpdate();
        Test.startTest();
        System.assert(controller.OrderTypes != null);
        Test.stopTest();
    }

    @isTest
    static void test_getSalesOrganizations()
    {
        mocRfcCalls();
        CTRL_OrderCreateUpdate controller = new CTRL_OrderCreateUpdate();
        Test.startTest();
        System.assert(controller.SalesOrganizations != null);
        Test.stopTest();
    }

    @isTest
    static void test_getDistributionChannels()
    {
        mocRfcCalls();
        CTRL_OrderCreateUpdate controller = new CTRL_OrderCreateUpdate();
        Test.startTest();
        System.assert(controller.DistributionChannels != null);
        Test.stopTest();
    }

    @isTest
    static void test_getDivisions()
    {
        mocRfcCalls();
        CTRL_OrderCreateUpdate controller = new CTRL_OrderCreateUpdate();
        Test.startTest();
        System.assert(controller.Divisions != null);
        Test.stopTest();
    }

    @isTest
    static void test_getSoldToPartners()
    {
        mocRfcCalls();
        CTRL_OrderCreateUpdate controller = new CTRL_OrderCreateUpdate();
        Test.startTest();
        System.assert(controller.SoldToPartners != null);
        Test.stopTest();
    }

    @isTest
    static void test_getShipToPartners()
    {
        mocRfcCalls();
        CTRL_OrderCreateUpdate controller = new CTRL_OrderCreateUpdate();
        Test.startTest();
        System.assert(controller.ShipToPartners != null);
        Test.stopTest();
    }

    @isTest
    static void test_orderTypeDisabled()
    {
        mocRfcCalls();
        CTRL_OrderCreateUpdate controller = new CTRL_OrderCreateUpdate();
        SBO_EnosixSO_Detail.EnosixSO salesOrder = new SBO_EnosixSO_Detail.EnosixSO();
        salesOrder.ITEMS.add(new SBO_EnosixSO_Detail.ITEMS());
        controller.orderDetail = salesOrder;
        Test.startTest();
        System.assert(controller.isOrderTypeDisabled==true);
        Test.stopTest();
    }

    static MOC_EnosixSO_Detail detailMoc;

    static void mocRfcCalls()
    {
        detailMoc = new MOC_EnosixSO_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixSO_Detail.class, detailMoc);
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustomer_Detail.class, new MOC_EnosixCustomer_Detail());
        ensxsdk.EnosixFramework.setMock(SBO_SFCICustomer_Search.class, new MOC_EnosixCustomer_Search());
        ensxsdk.EnosixFramework.setMock(SBO_SFCIMaterial_Search.class, new MOC_EnosixMaterial_Search());
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_DOC_TYPE_VALUES.class, new MOC_RFC_SD_GET_DOC_TYPE_VALUES_ET_OUTPUT());
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_RETURN_CUSTINSPEC.class, new MOC_RFC_SD_GET_RETURN_CUSTINSPEC());
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_SHIP_INFO.class, new MOC_RFC_SD_GET_SHIP_INFO());
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_ORDER_TYPES.class, new MOC_RFC_SD_GET_ORDER_TYPES());
        ensxsdk.EnosixFramework.setMock(SBO_SFCIPartner_Search.class, new Mock_SBO_SFCIPartner_Search());
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_CONDITION_GROUP.class, new MOC_RFC_SD_GET_CONDITION_GROUP());
        ensxsdk.EnosixFramework.setMock(SBO_EnosixMaterial_Detail.class, new MOC_SBO_EnosixMaterial_Detail());
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
        opp.put(UTIL_SFOpportunity.OrderFieldName, '12345');
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