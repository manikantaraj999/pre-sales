/*
* Test cases for opportunity utility class
*/
@isTest 
private class TSTU_SFOpportunity
{
    @isTest
    public static void test_getSObject()
    {
        SObject testSObject = createTestObjects();

        Test.startTest();
        UTIL_SFOpportunity utility = new UTIL_SFOpportunity();
        utility.getSObject('bad Id');
        utility.getSObject(testSObject.Id);
        utility.getSObject(testSObject.Id);
        utility.getSObject('Quote', 'sapQuoteNumber');
        utility.getSObject('Order', 'sapOrderNumber');
        utility.getSObject('Contract', 'sapContractNumber');
        utility.getSObject('bad SAP Type', 'bad SAP Type');
        Test.stopTest();
    }

    @isTest
    static void test_getSObjectLineItems()
    {
        Test.startTest();
        UTIL_SFOpportunity utility = new UTIL_SFOpportunity();
        SObject testSObject = createTestObjects();
        utility.getSObjectLineItems('bad Id');
        utility.getSObjectLineItems(testSObject.Id);
        utility.getSObjectLineItems(testSObject.Id);
        Test.stopTest();
    }

    @isTest
    static void test_getSObjectContacts()
    {
    	Test.startTest();
        UTIL_SFOpportunity utility = new UTIL_SFOpportunity();
        SObject testSObject = createTestObjects();
		utility.getSObjectContacts(testSObject.Id);
		utility.getSObjectContacts(null);
		Test.stopTest();
    }

    @isTest
    static void test_getAccountId()
    {
    	Test.startTest();
        UTIL_SFOpportunity utility = new UTIL_SFOpportunity();
        SObject testSObject = createTestObjects();
		utility.getAccountId(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getCustomerNumber()
    {
    	Test.startTest();
        UTIL_SFOpportunity utility = new UTIL_SFOpportunity();
        SObject testSObject = createTestObjects();
		utility.getCustomerNumber(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getName()
    {
    	Test.startTest();
        UTIL_SFOpportunity utility = new UTIL_SFOpportunity();
        SObject testSObject = createTestObjects();
		utility.getName(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getQuoteNumber()
    {
    	Test.startTest();
        UTIL_SFOpportunity utility = new UTIL_SFOpportunity();
        SObject testSObject = createTestObjects();
		utility.getQuoteNumber(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getOrderNumber()
    {
    	Test.startTest();
        UTIL_SFOpportunity utility = new UTIL_SFOpportunity();
        SObject testSObject = createTestObjects();
		utility.getOrderNumber(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getContractNumber()
    {
    	Test.startTest();
        UTIL_SFOpportunity utility = new UTIL_SFOpportunity();
        SObject testSObject = createTestObjects();
		utility.getContractNumber(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getStatus()
    {
    	Test.startTest();
        UTIL_SFOpportunity utility = new UTIL_SFOpportunity();
        SObject testSObject = createTestObjects();
		utility.getStatus(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getOpportunity()
    {
    	Test.startTest();
        UTIL_SFOpportunity utility = new UTIL_SFOpportunity();
        SObject testSObject = createTestObjects();
		utility.getOpportunityId(testSObject);
		utility.getOpportunity(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getPriceBookId()
    {
    	Test.startTest();
        UTIL_SFOpportunity utility = new UTIL_SFOpportunity();
        SObject testSObject = createTestObjects();
		utility.getPriceBookId(null);
		utility.getPriceBookId(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getProductId()
    {
    	Test.startTest();
        UTIL_SFOpportunity utility = new UTIL_SFOpportunity();
		utility.getProductId(null);
		Test.stopTest();
    }

    @isTest
    static void test_getMaterial()
    {
    	Test.startTest();
        SObject testSObject = createTestObjects();
        UTIL_SFOpportunity utility = new UTIL_SFOpportunity();
		utility.getMaterial(testSObject, null);
		Test.stopTest();
    }

    @isTest
    static void test_getItemNumber()
    {
    	Test.startTest();
        UTIL_SFOpportunity utility = new UTIL_SFOpportunity();
		utility.getItemNumber(null);
		Test.stopTest();
    }
    
    @isTest
    static void test_validateSAPWithSfsObject()
    {
        Test.startTest();
        UTIL_SFOpportunity utility = new UTIL_SFOpportunity();
        SObject testSObject = createTestObjects();
        utility.validateSAPWithSfsObject('', testSObject);
        Test.stopTest();
    }

    @isTest
    static void test_initializeQuoteFromSfSObject()
    {
    	Test.startTest();
        UTIL_SFOpportunity utility = new UTIL_SFOpportunity();
        SObject testSObject = createTestObjects();
        SBO_EnosixQuote_Detail.EnosixQuote quoteDetail = createQuote();
		utility.initializeQuoteFromSfSObject('', testSObject, quoteDetail, new Map<String, UTIL_SFSObjectDoc.SfSObjectItem>(), new Map<String, UTIL_Quote.QuoteLineValue>(), 10);
		Test.stopTest();
    }

    @isTest
    static void test_TranslateLineItemToQuoteItem()
    {
    	Test.startTest();
        UTIL_SFOpportunity utility = new UTIL_SFOpportunity();
        OpportunityLineItem lineItem = TSTU_SFTestObject.createTestOpportunityLineItem();
        lineItem.ServiceDate = Date.Today();
		utility.translateLineItemToQuoteItem(lineItem, null);
		utility.translateLineItemToQuoteItem(lineItem, 'MaterialNumber');
		Test.stopTest();
    }

    @isTest
    static void test_updateQuotePricingFromSfsObject()
    {
    	Test.startTest();
        UTIL_SFOpportunity utility = new UTIL_SFOpportunity();
        SObject testSObject = createTestObjects();
        SBO_EnosixQuote_Detail.EnosixQuote quoteDetail = createQuote();
		utility.updateQuotePricingFromSfsObject('', testSObject, quoteDetail, new Map<String, UTIL_SFSObjectDoc.SfSObjectItem>());
		Test.stopTest();
    }

    @isTest
    static void test_finalizeQuoteAndUpdateSfsObject()
    {
    	Test.startTest();
        UTIL_SFOpportunity utility = new UTIL_SFOpportunity();
        SObject testSObject = createTestObjects();
        SBO_EnosixQuote_Detail.EnosixQuote quoteDetail = createQuote();
        quoteDetail.ITEMS.clear();
		utility.finalizeQuoteAndUpdateSfsObject('', testSObject, quoteDetail, 
            new Map<String, UTIL_SFSObjectDoc.SfSObjectItem>(), UTIL_Pricebook.getStandardPriceBookId(), 
            new List<SBO_EnosixQuote_Detail.ITEMS>(), new Map<string, Id>(), new Map<Id, PricebookEntry>());
		Test.stopTest();
    }

    @isTest public static void test_setOppItemsFromQuote()
    {
        Opportunity testSObject = createTestObjects();

        SBO_EnosixQuote_Detail.EnosixQuote quoteDetail = createQuote();

        Test.startTest();
        UTIL_SFOpportunity utility = new UTIL_SFOpportunity();

        Map<string, Id> materialToProductIdMap = new Map<string, Id>();
        Map<Id, PricebookEntry> productToPricebookEntryMap = new Map<Id, PricebookEntry>();

        Product2 product1 = TSTU_SFTestObject.createTestProduct2();
        product1.Name = 'Material1';
        product1.Description = 'Material1';
        product1.ProductCode = 'Material1';
        product1.IsActive = true;
        UTIL_SFProduct.setProductMaterialNumber(product1, 'Material1');
        TSTU_SFTestObject.upsertWithRetry(product1);

        PricebookEntry pbe1 = TSTU_SFTestObject.createTestPriceBookEntry();
        pbe1.Pricebook2Id = UTIL_Pricebook.getStandardPriceBookId();
        pbe1.Product2Id = product1.Id;
        pbe1.UnitPrice = 0;
        pbe1.IsActive = true;
        pbe1.UseStandardPrice = false;
        TSTU_SFTestObject.upsertWithRetry(pbe1);

        materialToProductIdMap.put('Material1', product1.Id);
        productToPricebookEntryMap.put(product1.Id, pbe1);
        materialToProductIdMap.put('Material2', product1.Id);
        productToPricebookEntryMap.put(product1.Id, pbe1);

        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap = new Map<String, UTIL_SFSObjectDoc.SfSObjectItem>();
        UTIL_SFSObjectDoc.SfSObjectItem sfSobjectItem1 = new UTIL_SFSObjectDoc.SfSObjectItem(deleteLineId);
        sfSobjectItem1.isDeleted = true;
        sfSObjectLineIdMap.put('1',sfSobjectItem1);
        UTIL_SFSObjectDoc.SfSObjectItem sfSobjectItem2 = new UTIL_SFSObjectDoc.SfSObjectItem(updateLineId);
        sfSObjectLineIdMap.put('2',sfSobjectItem2);
        utility.upsertLineItemsFromQuoteItems(testSObject, quoteDetail.ITEMS.getAsList(), materialToProductIdMap, productToPricebookEntryMap, sfSObjectLineIdMap);
        Test.stopTest();
    }

    @isTest
    static void test_initializeOrderFromSfSObject()
    {
    	Test.startTest();
        UTIL_SFOpportunity utility = new UTIL_SFOpportunity();
        SObject testSObject = createTestObjects();
        SBO_EnosixSO_Detail.EnosixSO orderDetail = createOrder();
		utility.initializeOrderFromSfSObject('', testSObject, orderDetail, new Map<String, UTIL_SFSObjectDoc.SfSObjectItem>(), new Map<String, UTIL_Order.OrderLineValue>(), 10);
		Test.stopTest();
    }

    @isTest
    static void test_TranslateLineItemToOrderItem()
    {
    	Test.startTest();
        UTIL_SFOpportunity utility = new UTIL_SFOpportunity();
        OpportunityLineItem lineItem = TSTU_SFTestObject.createTestOpportunityLineItem();
        lineItem.ServiceDate = Date.Today();
		utility.translateLineItemToOrderItem(lineItem, null);
		utility.translateLineItemToOrderItem(lineItem, 'MaterialNumber');
		Test.stopTest();
    }

    @isTest
    static void test_updateOrderPricingFromSfsObject()
    {
    	Test.startTest();
        UTIL_SFOpportunity utility = new UTIL_SFOpportunity();
        SObject testSObject = createTestObjects();
        SBO_EnosixSO_Detail.EnosixSO orderDetail = createOrder();
		utility.updateOrderPricingFromSfsObject('', testSObject, orderDetail, new Map<String, UTIL_SFSObjectDoc.SfSObjectItem>());
		Test.stopTest();
    }

    @isTest
    static void test_finalizeOrderAndUpdateSfsObject()
    {
    	Test.startTest();
        UTIL_SFOpportunity utility = new UTIL_SFOpportunity();
        SObject testSObject = createTestObjects();
        SBO_EnosixSO_Detail.EnosixSO orderDetail = createOrder();
        orderDetail.ITEMS.clear();
		utility.finalizeOrderAndUpdateSfsObject('', testSObject, orderDetail, 
            new Map<String, UTIL_SFSObjectDoc.SfSObjectItem>(), UTIL_Pricebook.getStandardPriceBookId(), 
            new List<SBO_EnosixSO_Detail.ITEMS>(), new Map<string, Id>(), new Map<Id, PricebookEntry>());
		Test.stopTest();
    }

    @isTest public static void test_setOppItemsFromOrder()
    {
        Opportunity testSObject = createTestObjects();

        SBO_EnosixSO_Detail.EnosixSO orderDetail = createOrder();

        Test.startTest();
        UTIL_SFOpportunity utility = new UTIL_SFOpportunity();

        Map<string, Id> materialToProductIdMap = new Map<string, Id>();
        Map<Id, PricebookEntry> productToPricebookEntryMap = new Map<Id, PricebookEntry>();
        Product2 product1 = TSTU_SFTestObject.createTestProduct2();
        product1.Name = 'Material1';
        product1.Description = 'Material1';
        product1.ProductCode = 'Material1';
        product1.IsActive = true;
        UTIL_SFProduct.setProductMaterialNumber(product1, 'Material1');
        TSTU_SFTestObject.upsertWithRetry(product1);
        PricebookEntry pbe1 = TSTU_SFTestObject.createTestPriceBookEntry();
        pbe1.Pricebook2Id = UTIL_Pricebook.getStandardPriceBookId();
        pbe1.Product2Id = product1.Id;
        pbe1.UnitPrice = 0;
        pbe1.IsActive = true;
        pbe1.UseStandardPrice = false;
        TSTU_SFTestObject.upsertWithRetry(pbe1);
        materialToProductIdMap.put('Material1', product1.Id);
        productToPricebookEntryMap.put(product1.Id, pbe1);
        materialToProductIdMap.put('Material2', product1.Id);
        productToPricebookEntryMap.put(product1.Id, pbe1);

        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap = new Map<String, UTIL_SFSObjectDoc.SfSObjectItem>();
        UTIL_SFSObjectDoc.SfSObjectItem sfSobjectItem1 = new UTIL_SFSObjectDoc.SfSObjectItem(deleteLineId);
        sfSobjectItem1.isDeleted = true;
        sfSObjectLineIdMap.put('1',sfSobjectItem1);
        UTIL_SFSObjectDoc.SfSObjectItem sfSobjectItem2 = new UTIL_SFSObjectDoc.SfSObjectItem(updateLineId);
        sfSObjectLineIdMap.put('2',sfSobjectItem2);
        utility.upsertLineItemsFromOrderItems(testSObject, orderDetail.ITEMS.getAsList(), materialToProductIdMap, productToPricebookEntryMap, sfSObjectLineIdMap);
        Test.stopTest();
    }

    @isTest
    static void test_sObjectToSalesDocMapping()
    {
        UTIL_SFOpportunity utility = new UTIL_SFOpportunity();
        SObject testSObject = createTestObjects();
        List<SObject> lineItems = (utility.getSObjectLineItems(testSObject.Id)).values();
        DS_Document_Detail salesDocDetail = new DS_Document_Detail();
        DS_SalesDocAppSettings appSettings = new DS_SalesDocAppSettings();
        appSettings.itemNumberIncrement = 10;
        appSettings.DefaultDocType = 'OR';
        appSettings.Header = new DS_SalesDocAppSettings.DocumentSetting();
        appSettings.Item = new DS_SalesDocAppSettings.DocumentSetting();

        DS_Document_Detail newSalesDocDetail = utility.sObjectToSalesDocMapping(testSObject, lineItems, salesDocDetail, appSettings);
        DS_Document_Detail.ITEMS item = salesDocDetail.ITEMS[0];
        testSObject.put('SAP_SaveSalesDocHeader__c', JSON.serialize(salesDocDetail));
        for (SObject lineItem : lineItems) {
            lineItem.put('SAP_SaveSalesDocItem__c', JSON.serialize(item));
        }
        newSalesDocDetail = utility.sObjectToSalesDocMapping(testSObject, lineItems, salesDocDetail, appSettings);
    }

    @isTest
    static void test_salesDocMappingToSObject()
    {
    	Test.startTest();
        UTIL_SFOpportunity utility = new UTIL_SFOpportunity();
        SObject testSObject = createTestObjects();
        DS_Document_Detail salesDocDetail = new DS_Document_Detail();
        salesDocDetail.SalesDocument = 'SalesDocument';
		utility.salesDocMappingToSObject(testSObject, salesDocDetail, 'Quote');
		utility.salesDocMappingToSObject(testSObject, salesDocDetail, 'Order');
		utility.salesDocMappingToSObject(testSObject, salesDocDetail, 'Contract');
		Test.stopTest();
    }

    @isTest
    static void test_salesDocLineItemMappingToSObject()
    {
    	Test.startTest();
        UTIL_SFOpportunity utility = new UTIL_SFOpportunity();
        SObject testSObject = createTestObjects();
        DS_Document_Detail salesDocDetail = new DS_Document_Detail();
        salesDocDetail.SalesDocument = 'SalesDocument';
        SObject lineItem = null;
		lineItem = utility.salesDocLineItemMappingToSObject(testSObject, new DS_Document_Detail.ITEMS(), new PricebookEntry(), null, lineItem);
		lineItem = utility.salesDocLineItemMappingToSObject(testSObject, new DS_Document_Detail.ITEMS(), new PricebookEntry(), null, lineItem);
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

        Contact cont = TSTU_SFTestObject.createTestContact(null);
        TSTU_SFTestObject.upsertWithRetry(cont);

        OpportunityContactRole oppContRole = TSTU_SFTestObject.createTestOpportunityContactRole(opp, cont);
        oppContRole.OpportunityId = opp.Id;
        TSTU_SFTestObject.upsertWithRetry(oppContRole);

        List<Product2> newProdList = new List<Product2>();

        Product2 newProd = TSTU_SFTestObject.createTestProduct2();
        newProd.Name = 'test product';
        newProd.family = 'test family';
        newProd.put(UTIL_SFProduct.MaterialFieldName,'materialNumber');
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

        List<PriceBookEntry> standardPbeList = new List<PriceBookEntry>();

        PriceBookEntry standardPbe = TSTU_SFTestObject.createTestPriceBookEntry();
        standardPbe.UnitPrice = 100;
        standardPbe.Pricebook2Id = pricebookId;
        standardPbe.Product2Id = newProd.Id;
        standardPbe.UseStandardPrice = false;
        standardPbe.IsActive = true;
        standardPbeList.add(standardPbe);

        PriceBookEntry standardPbe2 = TSTU_SFTestObject.createTestPriceBookEntry();
        standardPbe2.UnitPrice = 100;
        standardPbe2.Pricebook2Id = pricebookId;
        standardPbe2.Product2Id = newProd2.Id;
        standardPbe2.UseStandardPrice = false;
        standardPbe2.IsActive = true;
        standardPbeList.add(standardPbe2);

        PriceBookEntry standardPbe3 = TSTU_SFTestObject.createTestPriceBookEntry();
        standardPbe3.UnitPrice = 100;
        standardPbe3.Pricebook2Id = pricebookId;
        standardPbe3.Product2Id = newProd3.Id;
        standardPbe3.UseStandardPrice = false;
        standardPbe3.IsActive = true;
        standardPbeList.add(standardPbe3);

        TSTU_SFTestObject.upsertWithRetry(standardPbeList);

        List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();

        OpportunityLineItem oli = TSTU_SFTestObject.createTestOpportunityLineItem();
		oli.OpportunityId = opp.Id;
		oli.Quantity = 10;
		oli.UnitPrice = .95;
		oli.Description = 'test Desciption';
        oli.PricebookEntryId = standardPbe.Id;
        oli.FLD_SAP_Item_Number__c = '000010';
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

        UTIL_SFOpportunity utility = new UTIL_SFOpportunity();
        return (Opportunity) utility.getSObject(opp.Id);
    }
}
