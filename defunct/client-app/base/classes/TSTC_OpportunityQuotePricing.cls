@isTest
public with sharing class TSTC_OpportunityQuotePricing
{
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

                search_result.SearchResults.add(result);
            }

            search_result.setSuccess(success);
            searchContext.baseResult = search_result;
			return searchContext;
        }
    }

    public class MOC_SBO_EnosixQuote_Detail implements ensxsdk.EnosixFramework.DetailSBOCommandMock
    {
        public boolean success = true;

        public void setSuccess(Boolean successfull)
        {
            this.success = successfull;
        }

        public ensxsdk.EnosixFramework.DetailObject executeCommand(string command, ensxsdk.EnosixFramework.DetailObject obj)
        {
            SBO_EnosixQuote_Detail.EnosixQuote result = new SBO_EnosixQuote_Detail.EnosixQuote();
            SBO_EnosixQuote_Detail.ITEMS item = new SBO_EnosixQuote_Detail.ITEMS();
            item.Material = 'Test Material';
            item.ItemNumber = '123';
            item.OrderQuantity = 12;
            item.NetItemPrice = 1.0;
            result.ITEMS.add(item);
            SBO_EnosixQuote_Detail.ITEMS item2 = new SBO_EnosixQuote_Detail.ITEMS();
            item2.Material = 'Test Material';
            item2.ItemNumber = '123';
            item2.OrderQuantity = 12;
            item2.NetItemPrice = null;
            result.ITEMS.add(item2);

            SBO_EnosixQuote_Detail.ITEMS_ACTION itemAction = new SBO_EnosixQuote_Detail.ITEMS_ACTION();
            itemAction.ItemNumber = '123';
            result.ITEMS_ACTION.add(itemAction);
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
            List<String> currencyList = (List<String>)UTIL_AppSettings.getList(
                'SalesOrganization.CurrencyKey.', String.class, new String[] { 'USD' });
            et_currencyField.FieldCurrency = currencyList[0];
            et_currencyField.LTEXT = 'X';
            et_currencyField.KTEXT = 'X';
			result.getCollection(RFC_SD_GET_CURRENCY_LIST.ET_CURRENCY.class).add(et_currencyField);
            result.setSuccess(this.success);
            return result;
        }
    }

    public class MOC_Material_Search implements ensxsdk.EnosixFramework.SearchSBOSearchMock
    {
        public ensxsdk.EnosixFramework.SearchContext executeSearch(ensxsdk.EnosixFramework.SearchContext searchContext)
        {
            SBO_SFCIMaterial_Search.SFCIMaterial_SR searchResult = new SBO_SFCIMaterial_Search.SFCIMaterial_SR();

            SBO_SFCIMaterial_Search.SEARCHRESULT result = new SBO_SFCIMaterial_Search.SEARCHRESULT();
            result.Material = 'MOCK';
            searchResult.SearchResults.add(result);

            searchResult.setSuccess(true);
            searchContext.baseResult = searchResult;
			return searchContext;
        }
    }

    @isTest
    private static void test_CreateControllerAndTouchProperties()
    {
        mocRfcCalls();

        Test.startTest();
        UTIL_AppSettings.resourceJson = '{"SalesOrganization.CurrencyKey.SalesOrganization" : ["USD"], "CTRL_OpportunityQuotePricing.Logging": true}';
        CTRL_OpportunityQuotePricing controller = new CTRL_OpportunityQuotePricing();
        controller.initConditions.add(new SBO_EnosixQuote_Detail.CONDITIONS());
        controller.quoteDetail = new SBO_EnosixQuote_Detail.EnosixQuote();
        controller.quoteDetail.Sales.SalesOrganization = 'SalesOrganization';
        Boolean isCurrencyDisabled = controller.isCurrencyDisabled;
        SBO_EnosixQuote_Detail.ITEMS item = new SBO_EnosixQuote_Detail.ITEMS();
        item.ItemNumber = '000010';
        controller.quoteDetail.ITEMS.add(item);
        SBO_EnosixQuote_Detail.PARTNERS partner1 = new SBO_EnosixQuote_Detail.PARTNERS();
        partner1.PartnerFunction = UTIL_Customer.SOLD_TO_PARTNER_CODE;
        partner1.CustomerNumber = 'CustomerNumber';
        controller.quoteDetail.PARTNERS.add(partner1);
        SBO_EnosixQuote_Detail.PARTNERS partner2 = new SBO_EnosixQuote_Detail.PARTNERS();
        partner2.PartnerFunction = UTIL_Customer.SHIP_TO_PARTNER_CODE;
        partner2.CustomerNumber = 'CustomerNumber';
        controller.quoteDetail.PARTNERS.add(partner2);
        SBO_EnosixQuote_Detail.PARTNERS partner3 = new SBO_EnosixQuote_Detail.PARTNERS();
        partner3.PartnerFunction = UTIL_Customer.CARRIER_PARTNER_CODE;
        partner3.CustomerNumber = 'CustomerNumber';
        controller.quoteDetail.PARTNERS.add(partner3);
        Opportunity opp = controller.opp;
        System.assert(controller.isShipToAutoSearchEnabled!=null);
        System.assert(controller.shipToReceiver!=null);
        Account acct = TSTU_SFTestObject.createTestAccount();
    	acct.Name='Acme';
    	acct.BillingCity='Cincinnatti';
        acct.put(UTIL_SFAccount.CustomerFieldName,'CustNum');
    	TSTU_SFTestObject.upsertWithRetry(acct);
        opp = TSTU_SFTestObject.createTestOpportunity();
        opp.AccountId = acct.Id;
        controller.sfSObject = opp;
        CTRL_ShipToSearch.ShipToSearchResult shipTo = new CTRL_ShipToSearch.ShipToSearchResult();
        shipTo.shipToNumber = 'CustNum';
        controller.onReceiveShipToSearch(shipTo);
        SBO_EnosixQuote_Detail.ITEMS_ACTION itemAction = new SBO_EnosixQuote_Detail.ITEMS_ACTION();
        itemAction.ItemNumber = '000010';
        controller.quoteDetail.ITEMS_ACTION.add(itemAction);
        controller.onReceiveShipToSearch(shipTo);
        controller.shipToCustomer = controller.shipToCustomer;
        controller.UpdateShipToPartner();
        CB_MaterialSearchReceiver msReceiver = controller.msReceiver;
        controller.quoteDetail = new SBO_EnosixQuote_Detail.EnosixQuote();
        Double netOpportunityPrice = controller.netOpportunityPrice;
        SBO_EnosixCustomer_Detail.EnosixCustomer customer = controller.soldToCustomer;
        String editItemNumber = controller.editItemNumber;
        String editActionElementId = controller.editActionElementId;
        List<SelectOption> CurrencyOptions = controller.CurrencyOptions;
        List<SelectOption> selectList = new List<SelectOption>();
        selectList.add(new SelectOption('test', 'test'));
        controller.setDefaultSalesOrg(selectList);
        List<CTRL_MaterialSearch.MaterialSearchResult> materialList = new List<CTRL_MaterialSearch.MaterialSearchResult>();
        CTRL_MaterialSearch.MaterialSearchResult materialSearch = new CTRL_MaterialSearch.MaterialSearchResult();
        materialSearch.material = new SBO_SFCIMaterial_Search.SEARCHRESULT();
        materialList.add(materialSearch);
        controller.addSelectedMaterialsAsItems(materialList);
        controller.itemPlant = controller.itemPlant;
        controller.quoteDetail.ITEMS.add(item);
        controller.editItemNumber = '000010';
        controller.itemPlant = controller.itemPlant;
        Boolean isClassic = controller.isClassic;
        String previousScreen = controller.previousScreen;
        Test.stopTest();
        System.assertNotEquals(controller, null);
    }

    @isTest
    private static void test_PlantSelections()
    {
        mocRfcCalls();
    	CTRL_OpportunityQuotePricing controller = new CTRL_OpportunityQuotePricing();
        controller.quoteDetail = new SBO_EnosixQuote_Detail.EnosixQuote();
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
    private static void test_editItem()
    {
        mocRfcCalls();
        Test.startTest();
        CTRL_OpportunityQuotePricing controller = new CTRL_OpportunityQuotePricing();
        controller.quoteDetail = new SBO_EnosixQuote_Detail.EnosixQuote();
        SBO_EnosixQuote_Detail.ITEMS item = new SBO_EnosixQuote_Detail.ITEMS();
        item.ItemNumber = '000010';
        controller.quoteDetail.ITEMS.add(item);
        SBO_EnosixQuote_Detail.ITEMS_ACTION itemAction1 = new SBO_EnosixQuote_Detail.ITEMS_ACTION();
        itemAction1.ItemChanged = true;
        itemAction1.ItemNumber = '000010';
        controller.quoteDetail.ITEMS_ACTION.add(itemAction1);
        System.currentPageReference().getParameters().put('editItemNumber', '000010');
        controller.editItem();
        controller.editQuoteItem = controller.editQuoteItem;
        controller.saveEditItem();
        controller.quoteDetail.ITEMS.add(item);
        controller.editItem();
        controller.saveQuoteItem = item;
        controller.cancelEditItem();
        controller.editItemNumber = null;
        controller.editQuoteItem = controller.editQuoteItem;
        Test.stopTest();
    }

    @isTest
    private static void test_ValidateOpp()
    {
        mocRfcCalls();

        Test.startTest();
        Account acct = TSTU_SFTestObject.createTestAccount();
        UTIL_SFAccount.setAccountCustomerNumber(acct, 'C1');
        TSTU_SFTestObject.upsertWithRetry(acct);
        UTIL_PageState.current.sfAccountId = acct.Id;
        CTRL_OpportunityQuotePricing controller = new CTRL_OpportunityQuotePricing();
        controller.opp.Name = 'TEST OPP';
        controller.opp.CloseDate = Date.today().addDays(31);
        SBO_EnosixQuote_Detail.ITEMS itm = new SBO_EnosixQuote_Detail.ITEMS();
        itm.OrderQuantity = 123;
        itm.ItemNumber = '123';
        itm.Material = 'test';
        UTIL_Quote.QuoteItem quoteItem = new UTIL_Quote.QuoteItem(itm, new List<SBO_EnosixQuote_Detail.ITEMS_SCHEDULE>(), 10, new UTIL_Quote.QuoteLineValue());
        controller.displayedMaterialItems.add(quoteItem);
        controller.isValid();
        Test.stopTest();
    }

    @isTest
    private static void test_AddAndRemoveItemToQuote()
    {
        mocRfcCalls();

        Test.startTest();
        Account acct = TSTU_SFTestObject.createTestAccount();
        UTIL_SFAccount.setAccountCustomerNumber(acct, 'C1');
        TSTU_SFTestObject.upsertWithRetry(acct);
        UTIL_PageState.current.sfAccountId = acct.Id;
        CTRL_OpportunityQuotePricing controller = new CTRL_OpportunityQuotePricing();
        controller.opp.Name = 'TEST OPP';
        controller.opp.CloseDate = Date.today().addDays(31);
        SBO_EnosixQuote_Detail.ITEMS itm = new SBO_EnosixQuote_Detail.ITEMS();
        itm.OrderQuantity = 123;
        itm.ItemNumber = '123';
        itm.Material = 'test';

        controller.quoteDetail.ITEMS.add(itm);
        system.assert(controller.displayedMaterialItems.size() > 0);
        controller.quoteDetail = new SBO_EnosixQuote_Detail.EnosixQuote();
        controller.quoteDetail.ITEMS_SCHEDULE.add(new SBO_EnosixQuote_Detail.ITEMS_SCHEDULE());
        SBO_EnosixQuote_Detail.ITEMS item = new SBO_EnosixQuote_Detail.ITEMS();
        item.ItemNumber = '000010';
        controller.quoteDetail.ITEMS.add(item);
        SBO_EnosixQuote_Detail.ITEMS_ACTION itemAction = new SBO_EnosixQuote_Detail.ITEMS_ACTION();
        itemAction.ItemNumber = '000010';
        controller.quoteDetail.ITEMS_ACTION.add(itemAction);
        System.currentPageReference().getParameters().put('removeItemNumber', '000010');
        controller.removeItem();
        controller.quoteDetail.ITEMS.add(item);
        itemAction.ItemAdded = true;
        controller.quoteDetail.ITEMS_ACTION.add(itemAction);
        controller.removeItem();
        Test.stopTest();
    }

    @isTest
    private static void test_OpportunityController()
    {
        mocRfcCalls();

        insertAccountAndOpportunity();
        UTIL_PageState.current.sapAddPartnerTo = 'addPartnerTo';
        UTIL_PageState.current.sapShipToNum = 'shipToNum';
        UTIL_PageState.current.sapSalesArea = 'SalesOrganization,DistributionChannel,Division';

        Test.startTest();
        CTRL_OpportunityQuotePricing controller = new CTRL_OpportunityQuotePricing();
        controller.soldToCustomer = new SBO_EnosixCustomer_Detail.EnosixCustomer();
        initializeQuoteDetail(controller);
        //Initialize Opp
        controller.updateSalesAreas();
        controller.quoteDetail.Sales.SalesDocumentCurrency = 'bad value';
        controller.updateSalesAreas();
        controller.updateSalesAreas();
        List<CTRL_MaterialSearch.MaterialSearchResult> matSearchResult = getMatSearchResult();
        controller.onReceiveMaterialSearchResults('', matSearchResult);
        controller.updateOpportunity();
        Boolean testBoolean = controller.isRequestedShipEnabled;
        String testString = controller.pathMaterialDetail;
        testString = controller.defaultSalesOrg;
        controller.canSaveQuote = false;
        controller.updateOpportunity();
        controller.canSaveQuote = true;
        controller.quoteDetail = new SBO_EnosixQuote_Detail.EnosixQuote();
        controller.updateOpportunity();
        Test.stopTest();
    }

    @isTest
    static void test_PublicProperties()
    {
        mocRfcCalls();
        insertAccountAndOpportunity();

        Test.startTest();
        CTRL_OpportunityQuotePricing controller = new CTRL_OpportunityQuotePricing();
        controller.soldToCustomer = new SBO_EnosixCustomer_Detail.EnosixCustomer();
        initializeQuoteDetail(controller);
        List<String> opportunityMaterialTypes = controller.opportunityMaterialTypes;
        List<String> defaultOpportunityMaterialTypes = controller.defaultOpportunityMaterialTypes;
        Boolean isAutoSearchEnabled = controller.isOpportunityMaterialAutoSearchEnabled;
        Boolean isSalesInfoEnabled = controller.isOpportunitySalesInfoEnabled;
        Boolean isATPEnabled = controller.isOpportunityATPEnabled;
        SBO_EnosixQuote_Detail.SALES salesData = controller.salesData;
        List<String> categoryTypes = CTRL_OpportunityQuotePricing.master_DocumentCategoryTypes;
        List<String> documentTypes = CTRL_OpportunityQuotePricing.master_DocumentTypes;
        List<SelectOption> orderTypes = controller.OrderTypes;
        List<SelectOption> salesOrg = controller.SalesOrganizations;
        List<SelectOption> distChannels = controller.DistributionChannels;
        List<SelectOption> divisions = controller.Divisions;
        List<SelectOption> soldTo = controller.SoldToPartners;
        List<SelectOption> shipTo = controller.ShipToPartners;
        Boolean isShipToDisplayed = controller.isShipToPartnerAddressDisplayed;
        SBO_EnosixQuote_Detail.PARTNERS soldToPartner = controller.SoldToPartner;
        SBO_EnosixQuote_Detail.PARTNERS shipToPartner = controller.ShipToPartner;
        Boolean canQuotePrices = controller.canQuotePrices;
        Test.stopTest();
    }

    private static void initializeQuoteDetail(CTRL_OpportunityQuotePricing controller)
    {
        SBO_EnosixQuote_Detail.ITEMS itm = new SBO_EnosixQuote_Detail.ITEMS();
        itm.OrderQuantity = 123;
        itm.ItemNumber = '123';
        itm.Material = 'test';
        controller.quoteDetail.ITEMS.add(itm);
    }

    private static void insertAccountAndOpportunity()
    {
        Account acct = TSTU_SFTestObject.createTestAccount();
        acct.Name = 'Test Account';
        UTIL_SFAccount.setAccountCustomerNumber(acct, 'TESTCUST');
        TSTU_SFTestObject.upsertWithRetry(acct);

        Id pricebookId = UTIL_Pricebook.getStandardPriceBookId();
        Opportunity opp = TSTU_SFTestObject.createTestOpportunity();
        opp.Name = 'TEST OPP';
        opp.CloseDate = Date.today().addDays(31);
        opp.AccountId = acct.Id;
        opp.StageName = 'Closed';
        opp.Pricebook2Id = pricebookId;
        TSTU_SFTestObject.upsertWithRetry(opp);
        opp = [SELECT Id, Pricebook2Id FROM Opportunity WHERE Id = :opp.Id];

        Product2 prod = TSTU_SFTestObject.createTestProduct2();
        prod.Name = 'New Product';
        prod.IsActive = true;
        TSTU_SFTestObject.upsertWithRetry(prod);

        if (pricebookId != opp.Pricebook2Id)
        {
            PriceBookEntry standardPbe = TSTU_SFTestObject.createTestPriceBookEntry();
            standardPbe.UnitPrice = 100;
    		standardPbe.Pricebook2Id = pricebookId;
    		standardPbe.Product2Id = prod.Id;
    		standardPbe.UseStandardPrice = false;
    		standardPbe.IsActive = true;
    		TSTU_SFTestObject.upsertWithRetry(standardPbe);
        }

        PricebookEntry pbEntry = TSTU_SFTestObject.createTestPriceBookEntry();
        pbEntry.UnitPrice = 1.0;
        pbEntry.Pricebook2Id = opp.Pricebook2Id;
        pbEntry.Product2Id = prod.Id;
        pbEntry.UseStandardPrice = false;
        pbEntry.IsActive = true;
        TSTU_SFTestObject.upsertWithRetry(pbEntry);

        OpportunityLineItem lineItem = TSTU_SFTestObject.createTestOpportunityLineItem();
        lineItem.UnitPrice = 1.0;
        lineItem.Quantity = 2;
        lineItem.Description = 'Desc';
        lineItem.Opportunity = opp;
        lineItem.OpportunityId = opp.Id;
        lineItem.PricebookEntry = pbEntry;
        lineItem.PricebookEntryId = pbEntry.Id;
        lineItem.ServiceDate = Date.newInstance(2016,3,21);
        TSTU_SFTestObject.upsertWithRetry(lineItem);

        UTIL_PageState.current.sfOpportunityId = opp.Id;
    }

    public static List<CTRL_MaterialSearch.MaterialSearchResult> getMatSearchResult()
    {
        SBO_SFCIMaterial_Search.SEARCHRESULT materialSearchResult = new SBO_SFCIMaterial_Search.SEARCHRESULT();
        materialSearchResult.Material = 'MOCK';
        List<CTRL_MaterialSearch.MaterialSearchResult> matLists = new List<CTRL_MaterialSearch.MaterialSearchResult>();
        CTRL_MaterialSearch.MaterialSearchResult material = new CTRL_MaterialSearch.MaterialSearchResult();
        material.material = materialSearchResult;
        material.quantity = 1.0;
        material.isSelected = true;
        matLists.add(material);
        return matLists;
    }

    static void mocRfcCalls()
    {
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustomer_Detail.class, new MOC_EnosixCustomer_Detail());
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_DOC_TYPE_VALUES.class, new MOC_RFC_SD_GET_DOC_TYPE_VALUES_ET_OUTPUT());
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_CURRENCY_LIST.class, new MOC_RFC_SD_GET_CURRENCY_LIST());
        ensxsdk.EnosixFramework.setMock(SBO_SFCIMaterial_Search.class, new MOC_Material_Search());
        ensxsdk.EnosixFramework.setMock(SBO_EnosixQuote_Detail.class, new MOC_SBO_EnosixQuote_Detail());
        ensxsdk.EnosixFramework.setMock(SBO_SFCIPartner_Search.class, new Mock_SBO_SFCIPartner_Search());
        ensxsdk.EnosixFramework.setMock(SBO_EnosixMaterial_Detail.class, new MOC_EnosixMaterial_Detail());
    }
}