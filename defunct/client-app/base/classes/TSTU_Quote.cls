@isTest
public with sharing class TSTU_Quote
{
    public class MOC_EnosixQuote_Detail implements ensxsdk.EnosixFramework.DetailSBOGetMock,
            ensxsdk.EnosixFramework.DetailSBOSaveMock, ensxsdk.EnosixFramework.DetailSBOCommandMock,
            ensxsdk.EnosixFramework.DetailSBOInitMock
    {
        public boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        private boolean throwException = false;

        public void setThrowException(boolean throwException)
        {
            this.throwException = throwException;
        }

        public ensxsdk.EnosixFramework.DetailObject executeGetDetail(object key)
        {
            if (throwException)
            {
                throw new CalloutException();
            }
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

    public class MOC_RFC_SD_GET_DOC_TYPE_VALUES_ET_OUTPUT implements ensxsdk.EnosixFramework.RFCMock
    {
        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            RFC_SD_GET_DOC_TYPE_VALUES.RESULT result = new RFC_SD_GET_DOC_TYPE_VALUES.RESULT();
            RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT sditm = new RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT();
            sditm.DocumentType = 'SD';
            sditm.BEZEI = 'Standard';
            sditm.INCPO = '10';
            result.getCollection(RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT.class).add(sditm);
            for (integer mocCnt = 0; mocCnt < 20; mocCnt++)
            {
                RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT out = new RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT();
                out.DocumentType = 'tst' + mocCnt;
                out.BEZEI = 'tst' + mocCnt;
                out.INCPO = '10';
                result.getCollection(RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT.class).add(out);
            }
            result.setSuccess(true);
            return result;
        }
    }

    @isTest
    static void test_getQuoteDetail()
    {
        Test.startTest();
        MOC_EnosixQuote_Detail mocEnosixQuoteDetail = new MOC_EnosixQuote_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixQuote_Detail.class, mocEnosixQuoteDetail);
        UTIL_Quote.getQuoteDetail('quoteId');
        mocEnosixQuoteDetail.setThrowException(true);
        UTIL_Quote.getQuoteDetail('quoteId');
        Test.stopTest();
    }

    @isTest
    static void test_QuoteItem()
    {
    	Test.startTest();
        SBO_EnosixQuote_Detail.EnosixQuote quoteDetail = new SBO_EnosixQuote_Detail.EnosixQuote();
        SBO_EnosixQuote_Detail.ITEMS item = new SBO_EnosixQuote_Detail.ITEMS();
        item.ItemNumber = '10';
        item.ScheduleLineDate = Date.newInstance(2000, 1, 1);
        quoteDetail.ITEMS.add(item);
        SBO_EnosixQuote_Detail.ITEMS item2 = new SBO_EnosixQuote_Detail.ITEMS();
        item2.ItemNumber = '20';
        quoteDetail.ITEMS.add(item2);
        SBO_EnosixQuote_Detail.ITEMS_SCHEDULE schedule = new SBO_EnosixQuote_Detail.ITEMS_SCHEDULE();
        schedule.ItemNumber = '10';
        schedule.ScheduleLineDate = Date.newInstance(2000, 1, 1);
        quoteDetail.ITEMS_SCHEDULE.add(schedule);
        SBO_EnosixQuote_Detail.ITEMS_SCHEDULE schedule2 = new SBO_EnosixQuote_Detail.ITEMS_SCHEDULE();
        schedule2.ItemNumber = '10';
        schedule2.ScheduleLineDate = Date.newInstance(2005, 1, 1);
        quoteDetail.ITEMS_SCHEDULE.add(schedule2);
        List<SBO_EnosixQuote_Detail.ITEMS_SCHEDULE> scheduleList = new List<SBO_EnosixQuote_Detail.ITEMS_SCHEDULE>();
        scheduleList.add(schedule);
        scheduleList.add(schedule2);
        SBO_EnosixQuote_Detail.ITEMS_TEXT text = new SBO_EnosixQuote_Detail.ITEMS_TEXT();
        text.ItemNumber = '10';
        text.TextId = 'Z991';
        text.Text = 'Z991';
        quoteDetail.ITEMS_TEXT.add(text);
        List<UTIL_Quote.QuoteItem> quoteList = UTIL_Quote.convertQuoteDetailToQuoteItem(quoteDetail, new Map<String, UTIL_Quote.QuoteLineValue>(), 10);
        String scheduleLineDateString = quoteList[0].FormattedScheduleLineDate;
        Date scheduleLineDate = quoteList[0].convertedItemDate;
        quoteList[0].item.ScheduleLineDate = Date.newInstance(2000, 1, 1);
        scheduleLineDate = quoteList[0].convertedItemDate;
        quoteList[0].item.ScheduleLineDate = Date.newInstance(2000, 1, 1);
        quoteList[0].item.OrderQuantity = 1;
        scheduleLineDate = quoteList[0].convertedItemDate;
        Boolean isRequestedShipEnabled = UTIL_Quote.isRequestedShipEnabled;
        UTIL_Quote.QuoteItem quoteItem = new UTIL_Quote.QuoteItem(item, scheduleList, 10, new UTIL_Quote.QuoteLineValue());
		Test.stopTest();
    }

    @isTest
    static void test_CopyCustomerInfoToQuote()
    {
        ensxsdk.EnosixFramework.setMock(SBO_SFCIPartner_Search.class, new TSTU_Customer.Mock_SBO_SFCIPartner_Search());

        Test.startTest();

        SBO_EnosixCustomer_Detail.EnosixCustomer customer = new SBO_EnosixCustomer_Detail.EnosixCustomer();
        customer.CustomerNumber = '1';
        SBO_EnosixQuote_Detail.EnosixQuote result = new SBO_EnosixQuote_Detail.EnosixQuote();
        SBO_EnosixQuote_Detail.PARTNERS partner2 = new SBO_EnosixQuote_Detail.PARTNERS();
        result.PARTNERS.add(partner2);
        UTIL_Quote.CopyCustomerInfoToQuote(result, customer);
        partner2.PartnerFunction = UTIL_Customer.SOLD_TO_PARTNER_CODE;
        result.PARTNERS.add(partner2);
        UTIL_Quote.CopyCustomerInfoToQuote(result, customer);

        Test.stopTest();
    }

    @isTest
    static void test_getQuoteMasterData()
    {
        Test.startTest();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_DOC_TYPE_VALUES.class, new MOC_RFC_SD_GET_DOC_TYPE_VALUES_ET_OUTPUT());
        UTIL_Quote.getQuoteMasterData('bad key');
        Test.stopTest();
    }

    @isTest
    static void test_initializeQuoteFromSfSObject()
    {
        Test.startTest();
        SObject testSObject = createTestObjects();
        SBO_EnosixQuote_Detail.EnosixQuote quoteDetail = createQuote();
        UTIL_Quote.initializeQuoteFromSfSObject('', testSObject, quoteDetail, new Map<String, UTIL_SFSObjectDoc.SfSObjectItem>(), new Map<String, UTIL_Quote.QuoteLineValue>(), 10);
        Test.stopTest();
    }

    @isTest
    static void test_loadSfsObjectLineIdMapFromQuote()
    {
        Test.startTest();
        SObject testSObject = createTestObjects();
        SBO_EnosixQuote_Detail.EnosixQuote quoteDetail = createQuote();
        UTIL_Quote.loadSfsObjectLineIdMapFromQuote('', testSObject, quoteDetail, new Map<String, UTIL_SFSObjectDoc.SfSObjectItem>());
        Test.stopTest();
    }

    @isTest
    static void test_updateQuotePricingFromSfsObject()
    {
        Test.startTest();
        SObject testSObject = createTestObjects();
        SBO_EnosixQuote_Detail.EnosixQuote quoteDetail = createQuote();
        UTIL_Quote.updateQuotePricingFromSfsObject('', testSObject, quoteDetail, new Map<String, UTIL_SFSObjectDoc.SfSObjectItem>());
        Test.stopTest();
    }

    @isTest
    static void test_finalizeQuoteAndUpdateSfSobject()
    {
        Test.startTest();
        SObject testSObject = createTestObjects();
        SBO_EnosixQuote_Detail.EnosixQuote quoteDetail = createQuote();
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap = new Map<String, UTIL_SFSObjectDoc.SfSObjectItem>();
        UTIL_SFSObjectDoc.SfSObjectItem objectItem = new UTIL_SFSObjectDoc.SfSObjectItem(deleteLineId);
        objectItem.isDeleted = true;
        sfSObjectLineIdMap.put('',objectItem);
        UTIL_Quote.finalizeQuoteAndUpdateSfSobject('', testSObject, quoteDetail, sfSObjectLineIdMap);
        objectItem = new UTIL_SFSObjectDoc.SfSObjectItem(null);
        objectItem.isDeleted = true;
        sfSObjectLineIdMap.put('',objectItem);
        UTIL_Quote.finalizeQuoteAndUpdateSfSobject('', testSObject, quoteDetail, sfSObjectLineIdMap);
        Test.stopTest();
    }

    @isTest
    static void test_addItemToQuote()
    {
        Test.startTest();
        UTIL_Quote.addItemToQuote(new SBO_EnosixQuote_Detail.EnosixQuote(), new SBO_EnosixQuote_Detail.ITEMS(), 10);
        Test.stopTest();
    }

    @isTest
    static void test_cloneItemToQuote()
    {
        Test.startTest();
        SBO_EnosixQuote_Detail.EnosixQuote quoteDetail = new SBO_EnosixQuote_Detail.EnosixQuote();
        SBO_EnosixQuote_Detail.ITEMS item = new SBO_EnosixQuote_Detail.ITEMS();
        item.ItemNumber = '1';
        quoteDetail.ITEMS.add(item);
        SBO_EnosixQuote_Detail.ITEMS_TEXT text = new SBO_EnosixQuote_Detail.ITEMS_TEXT();
        text.ItemNumber = '1';
        quoteDetail.ITEMS_TEXT.add(text);
        UTIL_Quote.cloneItemToQuote(quoteDetail, '1', 10);
        Test.stopTest();
    }

    @isTest
    static void test_removeItemFromQuote()
    {
        Test.startTest();
        SBO_EnosixQuote_Detail.EnosixQuote quoteDetail = new SBO_EnosixQuote_Detail.EnosixQuote();
        SBO_EnosixQuote_Detail.ITEMS item = new SBO_EnosixQuote_Detail.ITEMS();
        item.ItemNumber = '1';
        quoteDetail.ITEMS.add(item);
        SBO_EnosixQuote_Detail.ITEMS_ACTION action = new SBO_EnosixQuote_Detail.ITEMS_ACTION();
        action.ItemNumber = '1';
        action.ItemAdded = true;
        quoteDetail.ITEMS_ACTION.add(action);
        SBO_EnosixQuote_Detail.ITEMS_CONFIG config = new SBO_EnosixQuote_Detail.ITEMS_CONFIG();
        config.ItemNumber = '1';
        quoteDetail.ITEMS_CONFIG.add(config);
        SBO_EnosixQuote_Detail.ITEMS_SCHEDULE sched = new SBO_EnosixQuote_Detail.ITEMS_SCHEDULE();
        sched.ItemNumber = '1';
        quoteDetail.ITEMS_SCHEDULE.add(sched);
        SBO_EnosixQuote_Detail.ITEMS item1a = new SBO_EnosixQuote_Detail.ITEMS();
        item1a.ItemNumber = '1a';
        item1a.HigherLevelItemNumber = '1';
        quoteDetail.ITEMS.add(item1a);
        SBO_EnosixQuote_Detail.ITEMS_ACTION action1a = new SBO_EnosixQuote_Detail.ITEMS_ACTION();
        action1a.ItemNumber = '1a';
        action1a.ItemAdded = false;
        quoteDetail.ITEMS_ACTION.add(action1a);
        SBO_EnosixQuote_Detail.ITEMS item1b = new SBO_EnosixQuote_Detail.ITEMS();
        item1a.ItemNumber = '1b';
        item1a.HigherLevelItemNumber = '1';
        quoteDetail.ITEMS.add(item1b);
        SBO_EnosixQuote_Detail.ITEMS item2 = new SBO_EnosixQuote_Detail.ITEMS();
        item2.ItemNumber = '2';
        quoteDetail.ITEMS.add(item2);
        SBO_EnosixQuote_Detail.ITEMS_ACTION action2 = new SBO_EnosixQuote_Detail.ITEMS_ACTION();
        action2.ItemNumber = '2';
        quoteDetail.ITEMS_ACTION.add(action2);
        List<SBO_EnosixQuote_Detail.CONDITIONS> conditionsList = new List<SBO_EnosixQuote_Detail.CONDITIONS>();
        SBO_EnosixQuote_Detail.CONDITIONS condition = new SBO_EnosixQuote_Detail.CONDITIONS();
        condition.ConditionItemNumber = '1';
        conditionsList.add(condition);
        quoteDetail.CONDITIONS.add(condition);
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap = new Map<String, UTIL_SFSObjectDoc.SfSObjectItem>();
        sfSObjectLineIdMap.put('1',new UTIL_SFSObjectDoc.SfSObjectItem(null));
        UTIL_Quote.removeItemFromQuote(quoteDetail, '1', conditionsList, sfSObjectLineIdMap);
        UTIL_Quote.removeItemFromQuote(quoteDetail, '2', conditionsList, sfSObjectLineIdMap);
        UTIL_Quote.removeItemFromQuote(quoteDetail, '3', conditionsList, sfSObjectLineIdMap);
        Test.stopTest();
    }

    @isTest
    static void test_getNextItemNumber()
    {
        Test.startTest();
        SBO_EnosixQuote_Detail.EnosixQuote quoteDetail = new SBO_EnosixQuote_Detail.EnosixQuote();
        SBO_EnosixQuote_Detail.ITEMS item = new SBO_EnosixQuote_Detail.ITEMS();
        item.ItemNumber = '10';
        quoteDetail.ITEMS.add(item);
        SBO_EnosixQuote_Detail.ITEMS_ACTION itemAction = new SBO_EnosixQuote_Detail.ITEMS_ACTION();
        itemAction.ItemNumber = '10';
        quoteDetail.ITEMS_ACTION.add(itemAction);
        string nextItmNumber = UTIL_Quote.getNextItemNumber(quoteDetail, 10);
        Test.stopTest();
    }

    @isTest
    static void test_getItemFromQuoteByItemNumber()
    {
        Test.startTest();
        string itemToCheck = '10';
        SBO_EnosixQuote_Detail.EnosixQuote salesQuote = new SBO_EnosixQuote_Detail.EnosixQuote();
        SBO_EnosixQuote_Detail.ITEMS itm = new SBO_EnosixQuote_Detail.ITEMS();
        itm.ItemNumber = itemToCheck;
        salesQuote.ITEMS.add(itm);
        SBO_EnosixQuote_Detail.ITEMS retrievedItem = UTIL_Quote.getItemFromQuoteByItemNumber(salesQuote, itemToCheck);
        retrievedItem = UTIL_Quote.getItemFromQuoteByItemNumber(salesQuote, 'Missing');
        System.assert(retrievedItem == null);
        Test.stopTest();
    }

    @isTest
    public static void test_isAddMaterial()
    {
        Test.startTest();
        Boolean testBool = UTIL_Quote.isAddMaterial;
        Test.stopTest();
    }

    @isTest
    public static void test_isRemoveMaterial()
    {
        Test.startTest();
        Boolean testBool = UTIL_Quote.isRemoveMaterial;
        Test.stopTest();
    }

    @isTest
    public static void test_isEditMaterial()
    {
        Test.startTest();
        Boolean testBool = UTIL_Quote.isEditMaterial;
        Test.stopTest();
    }

    @isTest
    public static void test_isCloneMaterial()
    {
        Test.startTest();
        Boolean testBool = UTIL_Quote.isCloneMaterial;
        Test.stopTest();
    }

    @isTest
    public static void test_isMoveMaterial()
    {
        Test.startTest();
        Boolean testBool = UTIL_Quote.isMoveMaterial;
        Test.stopTest();
    }

    @isTest
    public static void test_isSelectMaterial()
    {
        Test.startTest();
        Boolean testBool = UTIL_Quote.isSelectMaterial;
        Test.stopTest();
    }

    private static SBO_EnosixQuote_Detail.EnosixQuote createQuote()
    {
        SBO_EnosixQuote_Detail.EnosixQuote result = new SBO_EnosixQuote_Detail.EnosixQuote();

        result.SalesDocument = 'Quote#';

        SBO_EnosixQuote_Detail.ITEMS item1 = new SBO_EnosixQuote_Detail.ITEMS();
        item1.ItemNumber = '1';
        item1.ItemDescription = 'Item 1';
        item1.Material = 'Material1';
        item1.OrderQuantity = 1;
        item1.NetItemPrice = 10.00;
        item1.ScheduleLineDate = Date.newInstance(2017, 3, 17);

        SBO_EnosixQuote_Detail.ITEMS item2 = new SBO_EnosixQuote_Detail.ITEMS();
        item2.ItemNumber = '2';
        item2.ItemDescription = 'Item 2';
        item2.Material = 'Material2';
        item2.OrderQuantity = 2;
        item2.NetItemPrice = 20.00;
        item2.ScheduleLineDate = Date.newInstance(2017, 3, 17);

        result.ITEMS.add(item1);
        result.ITEMS.add(item2);

        return result;
    }

    private static string deleteLineId = null;
    private static string updateLineId = null;

    private static Opportunity createTestObjects()
    {
        Id pricebookId = UTIL_Pricebook.getStandardPriceBookId();
        Opportunity opp = TSTU_SFTestObject.createTestOpportunity();
        opp.Name = 'TEST OPP';
        opp.CloseDate = Date.today();
        opp.StageName = 'IsWon';
        opp.Pricebook2Id = pricebookId;
        TSTU_SFTestObject.upsertWithRetry(opp);
        opp = [SELECT Id, Pricebook2Id FROM Opportunity WHERE Id = :opp.Id];
        opp.Pricebook2Id = pricebookId;
        TSTU_SFTestObject.upsertWithRetry(opp);

        List<Product2> newProdList = new List<Product2>();

        Product2 newProd = TSTU_SFTestObject.createTestProduct2();
        newProd.Name = 'test product';
        newProd.family = 'test family';
        newProd.put(UTIL_SFProduct.MaterialFieldName,'Material1');
        newProdList.add(newProd);

        Product2 newProd2 = TSTU_SFTestObject.createTestProduct2();
        newProd2.Name = 'test product';
        newProd2.family = 'test family';
        newProdList.add(newProd2);

        Product2 newProd3 = TSTU_SFTestObject.createTestProduct2();
        newProd3.Name = 'test product';
        newProd3.family = 'test family';
        newProdList.add(newProd3);

        TSTU_SFTestObject.upsertWithRetry(newProdList);

        List<PriceBookEntry> pbeList = new List<PriceBookEntry>();

        PriceBookEntry standardPbe = TSTU_SFTestObject.createTestPriceBookEntry();
        standardPbe.UnitPrice = 100;
        standardPbe.Pricebook2Id = pricebookId;
        standardPbe.Product2Id = newProd.Id;
        standardPbe.UseStandardPrice = false;
        standardPbe.IsActive = true;
        pbeList.add(standardPbe);

        PriceBookEntry standardPbe2 = TSTU_SFTestObject.createTestPriceBookEntry();
        standardPbe2.UnitPrice = 100;
        standardPbe2.Pricebook2Id = pricebookId;
        standardPbe2.Product2Id = newProd2.Id;
        standardPbe2.UseStandardPrice = false;
        standardPbe2.IsActive = true;
        pbeList.add(standardPbe2);

        PriceBookEntry standardPbe3 = TSTU_SFTestObject.createTestPriceBookEntry();
        standardPbe3.UnitPrice = 100;
        standardPbe3.Pricebook2Id = pricebookId;
        standardPbe3.Product2Id = newProd3.Id;
        standardPbe3.UseStandardPrice = false;
        standardPbe3.IsActive = true;
        pbeList.add(standardPbe3);

        TSTU_SFTestObject.upsertWithRetry(pbeList);

        List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();

        OpportunityLineItem oli = TSTU_SFTestObject.createTestOpportunityLineItem();
		oli.OpportunityId = opp.Id;
		oli.Quantity = 10;
		oli.UnitPrice = .95;
		oli.Description = 'test Desciption';
        oli.PricebookEntryId = standardPbe.Id;
        oli.FLD_SAP_Item_Number__c = '000001';
        oliList.add(oli);

        OpportunityLineItem oli2 = TSTU_SFTestObject.createTestOpportunityLineItem();
		oli2.OpportunityId = opp.Id;
		oli2.Quantity = 20;
		oli2.UnitPrice = .95;
		oli2.Description = 'test Desciption2';
        oli2.PricebookEntryId = standardPbe2.Id;
        oliList.add(oli2);

        OpportunityLineItem oli3 = TSTU_SFTestObject.createTestOpportunityLineItem();
		oli3.OpportunityId = opp.Id;
		oli3.Quantity = 30;
		oli3.UnitPrice = .95;
		oli3.Description = 'test Desciption3';
        oli3.PricebookEntryId = standardPbe3.Id;
        oliList.add(oli3);

        TSTU_SFTestObject.upsertWithRetry(oliList);

        deleteLineId = oli.Id;
        updateLineId = oli2.Id;

        return opp;
    }
}