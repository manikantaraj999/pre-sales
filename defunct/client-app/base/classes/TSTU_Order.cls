@isTest
public with sharing class TSTU_Order
{
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

    @isTest
    static void test_OrderItem()
    {
    	Test.startTest();
        SBO_EnosixSO_Detail.EnosixSO orderDetail = new SBO_EnosixSO_Detail.EnosixSO();
        SBO_EnosixSO_Detail.ITEMS item = new SBO_EnosixSO_Detail.ITEMS();
        item.ItemNumber = '10';
        item.ScheduleLineDate = Date.newInstance(2000, 1, 1);
        orderDetail.ITEMS.add(item);
        SBO_EnosixSO_Detail.ITEMS item2 = new SBO_EnosixSO_Detail.ITEMS();
        item2.ItemNumber = '20';
        orderDetail.ITEMS.add(item2);
        SBO_EnosixSO_Detail.ITEMS_SCHEDULE schedule = new SBO_EnosixSO_Detail.ITEMS_SCHEDULE();
        schedule.ItemNumber = '10';
        schedule.ScheduleLineDate = Date.newInstance(2000, 1, 1);
        orderDetail.ITEMS_SCHEDULE.add(schedule);
        SBO_EnosixSO_Detail.ITEMS_SCHEDULE schedule2 = new SBO_EnosixSO_Detail.ITEMS_SCHEDULE();
        schedule2.ItemNumber = '10';
        schedule2.ScheduleLineDate = Date.newInstance(2005, 1, 1);
        orderDetail.ITEMS_SCHEDULE.add(schedule2);
        List<SBO_EnosixSO_Detail.ITEMS_SCHEDULE> scheduleList = new List<SBO_EnosixSO_Detail.ITEMS_SCHEDULE>();
        scheduleList.add(schedule);
        scheduleList.add(schedule2);
        SBO_EnosixSO_Detail.ITEMS_TEXT text = new SBO_EnosixSO_Detail.ITEMS_TEXT();
        text.ItemNumber = '10';
        text.TextId = 'Z991';
        text.Text = 'Z991';
        orderDetail.ITEMS_TEXT.add(text);
        List<UTIL_Order.OrderItem> orderList = UTIL_Order.convertOrderDetailToOrderItem(orderDetail, new Map<String, UTIL_Order.OrderLineValue>(), 10);
        String scheduleLineDateString = orderList[0].FormattedScheduleLineDate;
        Date scheduleLineDate = orderList[0].convertedItemDate;
        orderList[0].item.ScheduleLineDate = null;
        scheduleLineDate = orderList[0].convertedItemDate;
        orderList[0].item.ScheduleLineDate = Date.newInstance(2005, 1, 1);
        scheduleLineDate = orderList[0].convertedItemDate;
        UTIL_Order.OrderItem orderItem = new UTIL_Order.OrderItem(item, scheduleList, 10, new UTIL_Order.OrderLineValue());
		Test.stopTest();
    }

    @isTest
    static void test_CopyCustomerInfoToOrder()
    {
        ensxsdk.EnosixFramework.setMock(SBO_SFCIPartner_Search.class, new TSTU_Customer.Mock_SBO_SFCIPartner_Search());

        Test.startTest();

        SBO_EnosixCustomer_Detail.EnosixCustomer customer = new SBO_EnosixCustomer_Detail.EnosixCustomer();
        customer.CustomerNumber = '1';
        SBO_EnosixSO_Detail.EnosixSO result = new SBO_EnosixSO_Detail.EnosixSO();
        SBO_EnosixSO_Detail.PARTNERS partner2 = new SBO_EnosixSO_Detail.PARTNERS();
        result.PARTNERS.add(partner2);
        UTIL_Order.CopyCustomerInfoToOrder(result, customer);
        partner2.PartnerFunction = UTIL_Customer.SOLD_TO_PARTNER_CODE;
        result.PARTNERS.add(partner2);
        UTIL_Order.CopyCustomerInfoToOrder(result, customer);

        Test.stopTest();
    }

    @isTest
    static void test_getOrderMasterData()
    {
        Test.startTest();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_DOC_TYPE_VALUES.class, new MOC_RFC_SD_GET_DOC_TYPE_VALUES_ET_OUTPUT());
        UTIL_Order.getOrderMasterData('bad key');
        Test.stopTest();
    }

    @isTest
    static void test_initializeOrderFromSfSObject()
    {
        Test.startTest();
        SObject testSObject = createTestObjects();
        SBO_EnosixSO_Detail.EnosixSO orderDetail = createOrder();
        UTIL_Order.initializeOrderFromSfSObject('', testSObject, orderDetail, new Map<String, UTIL_SFSObjectDoc.SfSObjectItem>(), new Map<String, UTIL_Order.OrderLineValue>(), 10);
        Test.stopTest();
    }

    @isTest
    static void test_loadSfsObjectLineIdMapFromOrder()
    {
        Test.startTest();
        SObject testSObject = createTestObjects();
        SBO_EnosixSO_Detail.EnosixSO orderDetail = createOrder();
        UTIL_Order.loadSfsObjectLineIdMapFromOrder('', testSObject, orderDetail, new Map<String, UTIL_SFSObjectDoc.SfSObjectItem>());
        Test.stopTest();
    }

    @isTest
    static void test_updateOrderPricingFromSfsObject()
    {
        Test.startTest();
        SObject testSObject = createTestObjects();
        SBO_EnosixSO_Detail.EnosixSO orderDetail = createOrder();
        UTIL_Order.updateOrderPricingFromSfsObject('', testSObject, orderDetail, new Map<String, UTIL_SFSObjectDoc.SfSObjectItem>());
        Test.stopTest();
    }

    @isTest
    static void test_finalizeOrderAndUpdateSfSobject()
    {
        Test.startTest();
        SObject testSObject = createTestObjects();
        SBO_EnosixSO_Detail.EnosixSO orderDetail = createOrder();
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap = new Map<String, UTIL_SFSObjectDoc.SfSObjectItem>();
        UTIL_SFSObjectDoc.SfSObjectItem objectItem = new UTIL_SFSObjectDoc.SfSObjectItem(deleteLineId);
        objectItem.isDeleted = true;
        sfSObjectLineIdMap.put('',objectItem);
        UTIL_Order.finalizeOrderAndUpdateSfSobject('', testSObject, orderDetail, sfSObjectLineIdMap);
        objectItem = new UTIL_SFSObjectDoc.SfSObjectItem(null);
        objectItem.isDeleted = true;
        sfSObjectLineIdMap.put('',objectItem);
        UTIL_Order.finalizeOrderAndUpdateSfSobject('', testSObject, orderDetail, sfSObjectLineIdMap);
        Test.stopTest();
    }

    @isTest
    static void test_addItemToOrder()
    {
        Test.startTest();
        UTIL_Order.addItemToOrder(new SBO_EnosixSO_Detail.EnosixSO(), new SBO_EnosixSO_Detail.ITEMS(), 10);
        Test.stopTest();
    }

    @isTest
    static void test_cloneItemToOrder()
    {
        Test.startTest();
        SBO_EnosixSO_Detail.EnosixSO orderDetail = new SBO_EnosixSO_Detail.EnosixSO();
        SBO_EnosixSO_Detail.ITEMS item = new SBO_EnosixSO_Detail.ITEMS();
        item.ItemNumber = '1';
        orderDetail.ITEMS.add(item);
        SBO_EnosixSO_Detail.ITEMS_TEXT text = new SBO_EnosixSO_Detail.ITEMS_TEXT();
        text.ItemNumber = '1';
        orderDetail.ITEMS_TEXT.add(text);
        UTIL_Order.cloneItemToOrder(orderDetail, '1', 10);
        Test.stopTest();
    }

    @isTest
    static void test_removeItemFromOrder()
    {
        Test.startTest();
        SBO_EnosixSO_Detail.EnosixSO orderDetail = new SBO_EnosixSO_Detail.EnosixSO();
        SBO_EnosixSO_Detail.ITEMS item = new SBO_EnosixSO_Detail.ITEMS();
        item.ItemNumber = '1';
        orderDetail.ITEMS.add(item);
        SBO_EnosixSO_Detail.ITEMS_ACTION action = new SBO_EnosixSO_Detail.ITEMS_ACTION();
        action.ItemNumber = '1';
        action.ItemAdded = true;
        orderDetail.ITEMS_ACTION.add(action);
        SBO_EnosixSO_Detail.ITEMS_CONFIG config = new SBO_EnosixSO_Detail.ITEMS_CONFIG();
        config.ItemNumber = '1';
        orderDetail.ITEMS_CONFIG.add(config);
        SBO_EnosixSO_Detail.ITEMS_SCHEDULE sched = new SBO_EnosixSO_Detail.ITEMS_SCHEDULE();
        sched.ItemNumber = '1';
        orderDetail.ITEMS_SCHEDULE.add(sched);
        SBO_EnosixSO_Detail.ITEMS item1a = new SBO_EnosixSO_Detail.ITEMS();
        item1a.ItemNumber = '1a';
        item1a.HigherLevelItemNumber = '1';
        orderDetail.ITEMS.add(item1a);
        SBO_EnosixSO_Detail.ITEMS_ACTION action1a = new SBO_EnosixSO_Detail.ITEMS_ACTION();
        action1a.ItemNumber = '1a';
        action1a.ItemAdded = false;
        orderDetail.ITEMS_ACTION.add(action1a);
        SBO_EnosixSO_Detail.ITEMS item1b = new SBO_EnosixSO_Detail.ITEMS();
        item1a.ItemNumber = '1b';
        item1a.HigherLevelItemNumber = '1';
        orderDetail.ITEMS.add(item1b);
        SBO_EnosixSO_Detail.ITEMS item2 = new SBO_EnosixSO_Detail.ITEMS();
        item2.ItemNumber = '2';
        orderDetail.ITEMS.add(item2);
        SBO_EnosixSO_Detail.ITEMS_ACTION action2 = new SBO_EnosixSO_Detail.ITEMS_ACTION();
        action2.ItemNumber = '2';
        orderDetail.ITEMS_ACTION.add(action2);
        List<SBO_EnosixSO_Detail.CONDITIONS> conditionsList = new List<SBO_EnosixSO_Detail.CONDITIONS>();
        SBO_EnosixSO_Detail.CONDITIONS condition = new SBO_EnosixSO_Detail.CONDITIONS();
        condition.ConditionItemNumber = '1';
        conditionsList.add(condition);
        orderDetail.CONDITIONS.add(condition);
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap = new Map<String, UTIL_SFSObjectDoc.SfSObjectItem>();
        sfSObjectLineIdMap.put('1',new UTIL_SFSObjectDoc.SfSObjectItem(null));
        UTIL_Order.removeItemFromOrder(orderDetail, '1', conditionsList, sfSObjectLineIdMap);
        UTIL_Order.removeItemFromOrder(orderDetail, '2', conditionsList, sfSObjectLineIdMap);
        UTIL_Order.removeItemFromOrder(orderDetail, '3', conditionsList, sfSObjectLineIdMap);
        Test.stopTest();
    }

    @isTest
    static void test_getNextItemNumber()
    {
        Test.startTest();
        SBO_EnosixSO_Detail.EnosixSO orderDetail = new SBO_EnosixSO_Detail.EnosixSO();
        SBO_EnosixSO_Detail.ITEMS item = new SBO_EnosixSO_Detail.ITEMS();
        item.ItemNumber = '10';
        orderDetail.ITEMS.add(item);
        SBO_EnosixSO_Detail.ITEMS_ACTION itemAction = new SBO_EnosixSO_Detail.ITEMS_ACTION();
        itemAction.ItemNumber = '10';
        orderDetail.ITEMS_ACTION.add(itemAction);
        string nextItmNumber = UTIL_Order.getNextItemNumber(orderDetail, 10);
        Test.stopTest();
    }

    @isTest
    static void test_getItemFromOrderByItemNumber()
    {
        Test.startTest();
        string itemToCheck = '10';
        SBO_EnosixSO_Detail.EnosixSO salesOrder = new SBO_EnosixSO_Detail.EnosixSO();
        SBO_EnosixSO_Detail.ITEMS itm = new SBO_EnosixSO_Detail.ITEMS();
        itm.ItemNumber = itemToCheck;
        salesOrder.ITEMS.add(itm);
        SBO_EnosixSO_Detail.ITEMS retrievedItem = UTIL_Order.getItemFromOrderByItemNumber(salesOrder, itemToCheck);
        retrievedItem = UTIL_Order.getItemFromOrderByItemNumber(salesOrder, 'Missing');
        System.assert(retrievedItem == null);
        Test.stopTest();
    }

    @isTest
    public static void test_isShipToPartnerAddressDisplayed()
    {
        Test.startTest();
        Boolean testBool = UTIL_Order.isShipToPartnerAddressDisplayed;
        Test.stopTest();
    }

    @isTest
    public static void test_isCardLimitEnabled()
    {
        Test.startTest();
        Boolean testBool = UTIL_Order.isCardLimitEnabled;
        Test.stopTest();
    }

    @isTest
    public static void test_allowedItemCategoriesByOrderType()
    {
        Test.startTest();
        Map<String, Set<String>> allowedItemCategoriesByOrderType = UTIL_Order.allowedItemCategoriesByOrderType;
        Test.stopTest();
    }

    @isTest
    public static void test_getDisplayCreditCardSection()
    {
        Test.startTest();

        // Test the same thing with a random char which should also return true.
        System.assert(UTIL_Order.getDisplayCreditCardSection('*'));

        Test.stopTest();
    }

    @isTest
    public static void test_getDisplayCreditCardEntry()
    {
        Test.startTest();

        // Test random char in map which will return true by default since it
        // won't be found.
        System.assert(UTIL_Order.getDisplayCreditCardEntry('*'));

        Test.stopTest();
    }

    @isTest
    public static void test_isAddMaterial()
    {
        Test.startTest();
        Boolean testBool = UTIL_Order.isAddMaterial;
        Test.stopTest();
    }

    @isTest
    public static void test_isRemoveMaterial()
    {
        Test.startTest();
        Boolean testBool = UTIL_Order.isRemoveMaterial;
        Test.stopTest();
    }

    @isTest
    public static void test_isEditMaterial()
    {
        Test.startTest();
        Boolean testBool = UTIL_Order.isEditMaterial;
        Test.stopTest();
    }

    @isTest
    public static void test_isCloneMaterial()
    {
        Test.startTest();
        Boolean testBool = UTIL_Order.isCloneMaterial;
        Test.stopTest();
    }

    @isTest
    public static void test_isMoveMaterial()
    {
        Test.startTest();
        Boolean testBool = UTIL_Order.isMoveMaterial;
        Test.stopTest();
    }

    @isTest
    public static void test_isSelectMaterial()
    {
        Test.startTest();
        Boolean testBool = UTIL_Order.isSelectMaterial;
        Test.stopTest();
    }

    private static SBO_EnosixSO_Detail.EnosixSO createOrder()
    {
        SBO_EnosixSO_Detail.EnosixSO result = new SBO_EnosixSO_Detail.EnosixSO();

        result.SalesDocument = 'Order#';

        SBO_EnosixSO_Detail.ITEMS item1 = new SBO_EnosixSO_Detail.ITEMS();
        item1.ItemNumber = '1';
        item1.ItemDescription = 'Item 1';
        item1.Material = 'Material1';
        item1.OrderQuantity = 1;
        item1.NetItemPrice = 10.00;
        item1.ScheduleLineDate = Date.newInstance(2017, 3, 17);

        SBO_EnosixSO_Detail.ITEMS item2 = new SBO_EnosixSO_Detail.ITEMS();
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