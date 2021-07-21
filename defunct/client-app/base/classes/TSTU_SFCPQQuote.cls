/*
* Test cases for Quote utility class
*/
@isTest 
public class TSTU_SFCPQQuote
{
    public class MockSBO_EnosixOpportunityPricing_Detail implements
        ensxsdk.EnosixFramework.DetailSBOInitMock,
        ensxsdk.EnosixFramework.DetailSBOCommandMock,
        ensxsdk.EnosixFramework.DetailSBOGetMock,
        ensxsdk.EnosixFramework.DetailSBOSaveMock
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

        public ensxsdk.EnosixFramework.DetailObject executeInitialize(ensxsdk.EnosixFramework.DetailObject initialState) 
        { 
            return null;
        }
        
        public ensxsdk.EnosixFramework.DetailObject executeCommand(String command, ensxsdk.EnosixFramework.DetailObject obj) 
        { 
            if (throwException)
            {
                throw new ENSX_Exceptions.SimulationException();
            }
            return this.executeGetDetail(obj);
        }

        public ensxsdk.EnosixFramework.DetailObject executeGetDetail(object key) 
        { 
            SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing result = new SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing();           
            result.setSuccess(success);

            SBO_EnosixOpportunityPricing_Detail.PARTNERS partner = new SBO_EnosixOpportunityPricing_Detail.PARTNERS();
            partner.PartnerFunction = 'SP';
            partner.CustomerNumber = '222';
            result.PARTNERS.add(partner);
            
            SBO_EnosixOpportunityPricing_Detail.ITEMS topItem = new SBO_EnosixOpportunityPricing_Detail.ITEMS();
            topItem.ItemNumber = '10';
            topItem.Material = 'Material1';
            topItem.HigherLevelItemNumber = '0';
            topItem.CostInDocCurrency = 5;
            topItem.OrderQuantity = 1;
            topItem.NetItemPrice = 10;
            
            SBO_EnosixOpportunityPricing_Detail.ITEMS childItem = new SBO_EnosixOpportunityPricing_Detail.ITEMS();
            childItem.ItemNumber = '11';
            childItem.Material = 'Material2';
            childItem.HigherLevelItemNumber = '10';
            childItem.CostInDocCurrency = 6;
            childItem.OrderQuantity = 1;
            childItem.NetItemPrice = 10;

            SBO_EnosixOpportunityPricing_Detail.ITEMS childItem2 = new SBO_EnosixOpportunityPricing_Detail.ITEMS();
            childItem2.ItemNumber = '12';
            childItem2.Material = 'Material2';
            childItem2.HigherLevelItemNumber = '10';
            childItem2.CostInDocCurrency = 5;
            childItem2.OrderQuantity = 2;
            childItem2.NetItemPrice = 10;

            SBO_EnosixOpportunityPricing_Detail.ITEMS childItem3 = new SBO_EnosixOpportunityPricing_Detail.ITEMS();
            childItem3.ItemNumber = '13';
            childItem3.Material = 'Material2';
            childItem3.HigherLevelItemNumber = '10';
            childItem3.CostInDocCurrency = 5;
            childItem3.OrderQuantity = 2;
            childItem3.NetItemPrice = 10;

            SBO_EnosixOpportunityPricing_Detail.ITEMS childItem4 = new SBO_EnosixOpportunityPricing_Detail.ITEMS();
            childItem4.ItemNumber = '14';
            childItem4.Material = 'Material3';
            childItem4.HigherLevelItemNumber = '10';
            childItem4.CostInDocCurrency = 5;
            childItem4.OrderQuantity = 2;
            childItem4.NetItemPrice = 10;

            SBO_EnosixOpportunityPricing_Detail.ITEMS childItem5 = new SBO_EnosixOpportunityPricing_Detail.ITEMS();
            childItem5.ItemNumber = '15';
            childItem5.Material = 'Material3';
            childItem5.HigherLevelItemNumber = '14';
            childItem5.CostInDocCurrency = 5;
            childItem5.OrderQuantity = 2;
            childItem5.NetItemPrice = 10;
            
            SBO_EnosixOpportunityPricing_Detail.ITEMS childItem6 = new SBO_EnosixOpportunityPricing_Detail.ITEMS();
            childItem6.ItemNumber = '16';
            childItem6.Material = 'Material4';
            childItem6.HigherLevelItemNumber = '14';
            childItem6.CostInDocCurrency = 5;
            childItem6.OrderQuantity = 2;
            childItem6.NetItemPrice = 10;
            
            SBO_EnosixOpportunityPricing_Detail.ITEMS childItem7 = new SBO_EnosixOpportunityPricing_Detail.ITEMS();
            childItem7.ItemNumber = '17';
            childItem7.Material = 'Material5';
            childItem7.HigherLevelItemNumber = '10';
            childItem7.CostInDocCurrency = 5;
            childItem7.OrderQuantity = 1;
            childItem7.NetItemPrice = 10;
            
            SBO_EnosixOpportunityPricing_Detail.ITEMS childItem8 = new SBO_EnosixOpportunityPricing_Detail.ITEMS();
            childItem8.ItemNumber = '18';
            childItem8.Material = 'Material6';
            childItem8.HigherLevelItemNumber = '10';
            childItem8.CostInDocCurrency = 5;
            childItem8.OrderQuantity = 1;
            childItem8.NetItemPrice = 10;
            
            SBO_EnosixOpportunityPricing_Detail.ITEMS childItem9 = new SBO_EnosixOpportunityPricing_Detail.ITEMS();
            childItem9.ItemNumber = '19';
            childItem9.Material = 'Material7';
            childItem9.HigherLevelItemNumber = '10';
            childItem9.CostInDocCurrency = 5;
            childItem9.OrderQuantity = 1;
            childItem9.NetItemPrice = 10;
            
            SBO_EnosixOpportunityPricing_Detail.ITEMS childItem10 = new SBO_EnosixOpportunityPricing_Detail.ITEMS();
            childItem10.ItemNumber = '20';
            childItem10.Material = 'Material8';
            childItem10.HigherLevelItemNumber = '10';
            childItem10.CostInDocCurrency = 5;
            childItem10.OrderQuantity = 1;
            childItem10.NetItemPrice = 10;

            result.ITEMS.add(topItem);
            result.ITEMS.add(childItem);
            result.ITEMS.add(childItem2);
            result.ITEMS.add(childItem3);
            result.ITEMS.add(childItem4);
            result.ITEMS.add(childItem5);
            result.ITEMS.add(childItem6);
            result.ITEMS.add(childItem7);
            result.ITEMS.add(childItem8);
            result.ITEMS.add(childItem9);
            result.ITEMS.add(childItem10);
            
            SBO_EnosixOpportunityPricing_Detail.ITEMS_SCHEDULE itemSched = new SBO_EnosixOpportunityPricing_Detail.ITEMS_SCHEDULE();
            itemSched.ItemNumber = '10';
            itemSched.ConfirmedQuantity = 1;
            result.ITEMS_SCHEDULE.add(itemSched);

            SBO_EnosixOpportunityPricing_Detail.CONDITIONS itemCond = new SBO_EnosixOpportunityPricing_Detail.CONDITIONS();
            itemCond.ConditionItemNumber = '1';
            itemCond.ConditionType = 'TEST';
            itemCond.Rate = 2;
            result.CONDITIONS.add(itemCond);
            SBO_EnosixOpportunityPricing_Detail.CONDITIONS itemCond2 = new SBO_EnosixOpportunityPricing_Detail.CONDITIONS();
            itemCond2.ConditionItemNumber = '1';
            itemCond2.ConditionType = 'SECOND';
            itemCond2.Rate = 10;
            result.CONDITIONS.add(itemCond2);
            
            return result;
        }

        public ensxsdk.EnosixFramework.DetailObject executeSave(ensxsdk.EnosixFramework.DetailObject obj) { 
            SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing result = new SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing();
            result.setSuccess(success);
            return result;
        }
    }

    @isTest
    public static void test_getSObject()
    {
        SObject testSObject = createTestObjects();

        Test.startTest();
        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();
        utility.getSObject('bad Id');
        utility.getSObject(testSObject.Id);
        utility.getSObject(testSObject.Id);
        utility.getSObject('Quote', 'sapQuoteNumber');
        utility.getSObject('Order', 'sapOrderNumber');
        utility.getSObject('bad SAP Type', 'bad SAP Type');
        Test.stopTest();
    }

    @isTest
    static void test_getSObjectLineItems()
    {
        Test.startTest();
        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();
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
        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();
        SObject testSObject = createTestObjects();
		utility.getSObjectContacts(null);
		Test.stopTest();
    }

    @isTest
    static void test_getAccountId()
    {
    	Test.startTest();
        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();
        SObject testSObject = createTestObjects();
		utility.getAccountId(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getCustomerNumber()
    {
    	Test.startTest();
        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();
        SObject testSObject = createTestObjects();
		utility.getCustomerNumber(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getName()
    {
    	Test.startTest();
        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();
        SObject testSObject = createTestObjects();
		utility.getName(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getQuoteNumber()
    {
    	Test.startTest();
        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();
        SObject testSObject = createTestObjects();
		utility.getQuoteNumber(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getOrderNumber()
    {
    	Test.startTest();
        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();
        SObject testSObject = createTestObjects();
		utility.getOrderNumber(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getContractNumber()
    {
    	Test.startTest();
        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();
        SObject testSObject = createTestObjects();
		utility.getContractNumber(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getStatus()
    {
    	Test.startTest();
        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();
        SObject testSObject = createTestObjects();
		utility.getStatus(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getOpportunity()
    {
    	Test.startTest();
        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();
        SObject testSObject = createTestObjects();
		utility.getOpportunityId(testSObject);
		utility.getOpportunity(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getPriceBookId()
    {
    	Test.startTest();
        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();
        SObject testSObject = createTestObjects();
		utility.getPriceBookId(null);
		utility.getPriceBookId(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getProductId()
    {
    	Test.startTest();
        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();
		utility.getProductId(null);
		Test.stopTest();
    }

    @isTest
    static void test_getMaterial()
    {
    	Test.startTest();
        SObject testSObject = createTestObjects();
        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();
		utility.getMaterial(testSObject, null);
		Test.stopTest();
    }

    @isTest
    static void test_getItemNumber()
    {
    	Test.startTest();
        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();
		utility.getItemNumber(null);
		Test.stopTest();
    }

    @isTest
    static void test_validateSAPWithSfsObject()
    {
        MockSBO_EnosixOpportunityPricing_Detail sbo = new MockSBO_EnosixOpportunityPricing_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixOpportunityPricing_Detail.class, sbo);
        Test.startTest();
        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();
        SObject testSObject = createTestObjects();
        utility.validateSAPWithSfsObject('', testSObject);
        sbo.setSuccess(false);
        utility.validateSAPWithSfsObject('', testSObject);
        Test.stopTest();
    }

    @isTest
    static void test_initializeQuoteFromSfSObject()
    {
    	Test.startTest();
        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();
        SObject testSObject = createTestObjects();
        SBO_EnosixQuote_Detail.EnosixQuote quoteDetail = createQuote();
		utility.initializeQuoteFromSfSObject('', testSObject, quoteDetail, new Map<String, UTIL_SFSObjectDoc.SfSObjectItem>(), new Map<String, UTIL_Quote.QuoteLineValue>(), 10);
		Test.stopTest();
    }

    @isTest
    static void test_TranslateLineItemToQuoteItem()
    {
    	Test.startTest();
        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();
        SBQQ__QuoteLine__c lineItem = TSTU_SFCPQQuote.createTestQuoteLine();
		utility.translateLineItemToQuoteItem(lineItem, null, null);
		utility.translateLineItemToQuoteItem(lineItem, 'Material1', new ENSX_ItemConfiguration());
		Test.stopTest();
    }

    @isTest
    static void test_updateQuotePricingFromSfsObject()
    {
    	Test.startTest();
        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();
        SObject testSObject = createTestObjects();
        SBO_EnosixQuote_Detail.EnosixQuote quoteDetail = createQuote();
        SBO_EnosixQuote_Detail.ITEMS item1 = new SBO_EnosixQuote_Detail.ITEMS();
        item1.ItemNumber = '1';
        item1.HigherLevelItemNumber = '0';
        item1.Material = 'Material1';
        quoteDetail.ITEMS.add(item1);
        SBO_EnosixQuote_Detail.ITEMS item2 = new SBO_EnosixQuote_Detail.ITEMS();
        item2.ItemNumber = '2';
        item2.HigherLevelItemNumber = '1';
        item2.Material = 'Material2';
        quoteDetail.ITEMS.add(item2);
        SBO_EnosixQuote_Detail.ITEMS item3 = new SBO_EnosixQuote_Detail.ITEMS();
        item3.ItemNumber = '3';
        item3.HigherLevelItemNumber = '2';
        item3.Material = 'Material3';
        quoteDetail.ITEMS.add(item3);
        SBO_EnosixQuote_Detail.ITEMS item4 = new SBO_EnosixQuote_Detail.ITEMS();
        item4.ItemNumber = '4';
        item4.HigherLevelItemNumber = '1';
        item4.Material = 'Material4';
        quoteDetail.ITEMS.add(item4);
        SBO_EnosixQuote_Detail.ITEMS item5 = new SBO_EnosixQuote_Detail.ITEMS();
        item5.ItemNumber = '5';
        item5.HigherLevelItemNumber = '0';
        item5.Material = 'Material1';
        quoteDetail.ITEMS.add(item5);
        SBO_EnosixQuote_Detail.CONDITIONS itemCond = new SBO_EnosixQuote_Detail.CONDITIONS();
        itemCond.ConditionItemNumber = '1';
        itemCond.ConditionType = '9999';
        itemCond.Rate = 2;
        quoteDetail.CONDITIONS.add(itemCond);
        SBO_EnosixQuote_Detail.CONDITIONS itemCond2 = new SBO_EnosixQuote_Detail.CONDITIONS();
        itemCond2.ConditionItemNumber = '1';
        itemCond2.ConditionType = '8888';
        itemCond2.Rate = 10;
        quoteDetail.CONDITIONS.add(itemCond2);
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfsObjectLineIdMap = new Map<String, UTIL_SFSObjectDoc.SfSObjectItem>();
        UTIL_SFSObjectDoc.SfSObjectItem sfSobjectItem1 = new UTIL_SFSObjectDoc.SfSObjectItem(lineId1);
        sfSObjectLineIdMap.put('1',sfSobjectItem1);
        UTIL_SFSObjectDoc.SfSObjectItem sfSobjectItem2 = new UTIL_SFSObjectDoc.SfSObjectItem(lineId2);
        sfSObjectLineIdMap.put('5',sfSobjectItem2);
		utility.updateQuotePricingFromSfsObject('', testSObject, quoteDetail, sfSObjectLineIdMap);
		utility.updateQuotePricingFromSfsObject('', testSObject, quoteDetail, sfSObjectLineIdMap);
        utility.discountPercentConditionType = '9999';
        utility.discountValueConditionType = '8888';
		utility.updateQuotePricingFromSfsObject('', testSObject, quoteDetail, sfSObjectLineIdMap);
		utility.updateQuotePricingFromSfsObject('', testSObject, quoteDetail, sfSObjectLineIdMap);
		Test.stopTest();
    }

    @isTest
    static void test_addConditionQuote()
    {
      	Test.startTest();
        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();
        utility.discountPercentConditionType = '9999';
        utility.discountValueConditionType = '8888';
        SBO_EnosixQuote_Detail.EnosixQuote quoteDetail = createQuote();
        SBO_EnosixQuote_Detail.ITEMS item1 = new SBO_EnosixQuote_Detail.ITEMS();
        item1.ItemNumber = '1';
        item1.HigherLevelItemNumber = '0';
        item1.Material = 'Material1';
        quoteDetail.ITEMS.add(item1);
        SBQQ__Quote__c quote = TSTU_SFCPQQuote.createTestQuote();
        TSTU_SFTestObject.upsertWithRetry(quote);
        Product2 newProd1 = TSTU_SFTestObject.createTestProduct2();
        newProd1.Name = 'test product';
        newProd1.family = 'test family';
        newProd1.put(UTIL_SFProduct.MaterialFieldName,'Material1');
        TSTU_SFTestObject.upsertWithRetry(newProd1);
        SBQQ__QuoteLine__c qli1 = TSTU_SFCPQQuote.createTestQuoteLine();
		qli1.SBQQ__Quote__c = quote.Id;
        qli1.SBQQ__Product__c = newProd1.Id;
        qli1.SBQQ__Discount__c = 10;
        qli1.FLD_SAP_Item_Number__c = '1';
        qli1.SBQQ__RegularPrice__c = 10;
        qli1.SBQQ__CustomerPrice__c = 5;
        TSTU_SFTestObject.upsertWithRetry(qli1);
        qli1 = [SELECT Id, SBQQ__Quote__c, SBQQ__Product__c, SBQQ__Discount__c, FLD_SAP_Item_Number__c, SBQQ__AdditionalDiscount__c FROM SBQQ__QuoteLine__c WHERE Id = :qli1.id];

        Map<String, SBO_EnosixQuote_Detail.CONDITIONS> conditionMapPercent = new Map<String, SBO_EnosixQuote_Detail.CONDITIONS>();
        Map<String, SBO_EnosixQuote_Detail.CONDITIONS> conditionMapValue = new Map<String, SBO_EnosixQuote_Detail.CONDITIONS>();
		utility.addCondition(quoteDetail, '1', qli1, false, conditionMapPercent, conditionMapValue);
        conditionMapPercent.put('1',new SBO_EnosixQuote_Detail.CONDITIONS());
		utility.addCondition(quoteDetail, '1', qli1, false, conditionMapPercent, conditionMapValue);

        qli1.SBQQ__Discount__c = null;
        TSTU_SFTestObject.upsertWithRetry(qli1);
		utility.addCondition(quoteDetail, '1', qli1, false, conditionMapPercent, conditionMapValue);
        conditionMapValue.put('1',new SBO_EnosixQuote_Detail.CONDITIONS());
		utility.addCondition(quoteDetail, '1', qli1, false, conditionMapPercent, conditionMapValue);

		Test.stopTest();
    }

    @isTest
    static void test_finalizeQuoteAndUpdateSfsObject()
    {
    	Test.startTest();
        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();
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
        SBQQ__Quote__c testSObject = createTestObjects();

        SBO_EnosixQuote_Detail.EnosixQuote quoteDetail = createQuote();

        Test.startTest();
        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();

        Map<string, Id> materialToProductIdMap = new Map<string, Id>();
        Map<Id, PricebookEntry> productToPricebookEntryMap = new Map<Id, PricebookEntry>();

        List<Product2> newProdList = new List<Product2>();

        Product2 product1 = TSTU_SFTestObject.createTestProduct2();
        product1.Name = 'Material1';
        product1.Description = 'Material1';
        product1.ProductCode = 'Material1';
        product1.IsActive = true;
        UTIL_SFProduct.setProductMaterialNumber(product1, 'Material1');
        newProdList.add(product1);

        Product2 product2 = TSTU_SFTestObject.createTestProduct2();
        product2.Name = 'Material2';
        product2.Description = 'Material2';
        product2.ProductCode = 'Material2';
        product2.IsActive = true;
        UTIL_SFProduct.setProductMaterialNumber(product2, 'Material2');
        newProdList.add(product2);

        TSTU_SFTestObject.upsertWithRetry(newProdList);

        List<PriceBookEntry> pbeList = new List<PriceBookEntry>();

        PricebookEntry pbe1 = TSTU_SFTestObject.createTestPriceBookEntry();
        pbe1.Pricebook2Id = UTIL_Pricebook.getStandardPriceBookId();
        pbe1.Product2Id = product1.Id;
        pbe1.UnitPrice = 0;
        pbe1.IsActive = true;
        pbe1.UseStandardPrice = false;
        pbeList.add(pbe1);

        PricebookEntry pbe2 = TSTU_SFTestObject.createTestPriceBookEntry();
        pbe2.Pricebook2Id = UTIL_Pricebook.getStandardPriceBookId();
        pbe2.Product2Id = product2.Id;
        pbe2.UnitPrice = 0;
        pbe2.IsActive = true;
        pbe2.UseStandardPrice = false;
        pbeList.add(pbe2);

        TSTU_SFTestObject.upsertWithRetry(pbeList);

        materialToProductIdMap.put('Material1', product1.Id);
        materialToProductIdMap.put('Material2', product2.Id);
        productToPricebookEntryMap.put(product1.Id, pbe1);
        productToPricebookEntryMap.put(product2.Id, pbe2);

        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap = new Map<String, UTIL_SFSObjectDoc.SfSObjectItem>();
        UTIL_SFSObjectDoc.SfSObjectItem sfSobjectItem1 = new UTIL_SFSObjectDoc.SfSObjectItem(lineId1);
        sfSobjectItem1.isDeleted = true;
        sfSObjectLineIdMap.put('1',sfSobjectItem1);
        UTIL_SFSObjectDoc.SfSObjectItem sfSobjectItem2 = new UTIL_SFSObjectDoc.SfSObjectItem(lineId2);
        sfSObjectLineIdMap.put('2',sfSobjectItem2);
        utility.upsertLineItemsFromQuoteItems(testSObject, quoteDetail.ITEMS.getAsList(), materialToProductIdMap, productToPricebookEntryMap, sfSObjectLineIdMap);
        Test.stopTest();
    }

    @isTest
    static void test_initializeOrderFromSfSObject()
    {
    	Test.startTest();
        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();
        SObject testSObject = createTestObjects();
        SBO_EnosixSO_Detail.EnosixSO orderDetail = createOrder();
		utility.initializeOrderFromSfSObject('', testSObject, orderDetail, new Map<String, UTIL_SFSObjectDoc.SfSObjectItem>(), new Map<String, UTIL_Order.OrderLineValue>(), 10);
		Test.stopTest();
    }

    @isTest
    static void test_TranslateLineItemToOrderItem()
    {
    	Test.startTest();
        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();
        SBQQ__QuoteLine__c lineItem = TSTU_SFCPQQuote.createTestQuoteLine();
		utility.translateLineItemToOrderItem(lineItem, null, null);
		utility.translateLineItemToOrderItem(lineItem, 'Material1', new ENSX_ItemConfiguration());
		Test.stopTest();
    }

    @isTest
    static void test_updateOrderPricingFromSfsObject()
    {
    	Test.startTest();
        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();
        SObject testSObject = createTestObjects();
        SBO_EnosixSO_Detail.EnosixSO orderDetail = createOrder();
        SBO_EnosixSO_Detail.ITEMS item1 = new SBO_EnosixSO_Detail.ITEMS();
        item1.ItemNumber = '1';
        item1.HigherLevelItemNumber = '0';
        item1.Material = 'Material1';
        orderDetail.ITEMS.add(item1);
        SBO_EnosixSO_Detail.ITEMS item2 = new SBO_EnosixSO_Detail.ITEMS();
        item2.ItemNumber = '2';
        item2.HigherLevelItemNumber = '1';
        item2.Material = 'Material2';
        orderDetail.ITEMS.add(item2);
        SBO_EnosixSO_Detail.ITEMS item3 = new SBO_EnosixSO_Detail.ITEMS();
        item3.ItemNumber = '3';
        item3.HigherLevelItemNumber = '2';
        item3.Material = 'Material3';
        orderDetail.ITEMS.add(item3);
        SBO_EnosixSO_Detail.ITEMS item4 = new SBO_EnosixSO_Detail.ITEMS();
        item4.ItemNumber = '4';
        item4.HigherLevelItemNumber = '1';
        item4.Material = 'Material4';
        orderDetail.ITEMS.add(item4);
        SBO_EnosixSO_Detail.ITEMS item5 = new SBO_EnosixSO_Detail.ITEMS();
        item5.ItemNumber = '5';
        item5.HigherLevelItemNumber = '0';
        item5.Material = 'Material1';
        orderDetail.ITEMS.add(item5);
        SBO_EnosixSO_Detail.CONDITIONS itemCond = new SBO_EnosixSO_Detail.CONDITIONS();
        itemCond.ConditionItemNumber = '1';
        itemCond.ConditionType = '9999';
        itemCond.Rate = 2;
        orderDetail.CONDITIONS.add(itemCond);
        SBO_EnosixSO_Detail.CONDITIONS itemCond2 = new SBO_EnosixSO_Detail.CONDITIONS();
        itemCond2.ConditionItemNumber = '1';
        itemCond2.ConditionType = '8888';
        itemCond2.Rate = 10;
        orderDetail.CONDITIONS.add(itemCond2);
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfsObjectLineIdMap = new Map<String, UTIL_SFSObjectDoc.SfSObjectItem>();
        UTIL_SFSObjectDoc.SfSObjectItem sfSobjectItem1 = new UTIL_SFSObjectDoc.SfSObjectItem(lineId1);
        sfSObjectLineIdMap.put('1',sfSobjectItem1);
        UTIL_SFSObjectDoc.SfSObjectItem sfSobjectItem2 = new UTIL_SFSObjectDoc.SfSObjectItem(lineId2);
        sfSObjectLineIdMap.put('5',sfSobjectItem2);
		utility.updateOrderPricingFromSfsObject('', testSObject, orderDetail, sfSObjectLineIdMap);
		utility.updateOrderPricingFromSfsObject('', testSObject, orderDetail, sfSObjectLineIdMap);
        utility.discountPercentConditionType = '9999';
        utility.discountValueConditionType = '8888';
		utility.updateOrderPricingFromSfsObject('', testSObject, orderDetail, sfSObjectLineIdMap);
		utility.updateOrderPricingFromSfsObject('', testSObject, orderDetail, sfSObjectLineIdMap);
		Test.stopTest();
    }

    @isTest
    static void test_addConditionOrder()
    {
      	Test.startTest();
        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();
        utility.discountPercentConditionType = '9999';
        utility.discountValueConditionType = '8888';
        SBO_EnosixSO_Detail.EnosixSO orderDetail = createOrder();
        SBO_EnosixSO_Detail.ITEMS item1 = new SBO_EnosixSO_Detail.ITEMS();
        item1.ItemNumber = '1';
        item1.HigherLevelItemNumber = '0';
        item1.Material = 'Material1';
        orderDetail.ITEMS.add(item1);
        SBQQ__Quote__c quote = TSTU_SFCPQQuote.createTestQuote();
        TSTU_SFTestObject.upsertWithRetry(quote);
        Product2 newProd1 = TSTU_SFTestObject.createTestProduct2();
        newProd1.Name = 'test product';
        newProd1.family = 'test family';
        newProd1.put(UTIL_SFProduct.MaterialFieldName,'Material1');
        TSTU_SFTestObject.upsertWithRetry(newProd1);
        SBQQ__QuoteLine__c qli1 = TSTU_SFCPQQuote.createTestQuoteLine();
		qli1.SBQQ__Quote__c = quote.Id;
        qli1.SBQQ__Product__c = newProd1.Id;
        qli1.SBQQ__Discount__c = 10;
        qli1.FLD_SAP_Item_Number__c = '1';
        qli1.SBQQ__RegularPrice__c = 10;
        qli1.SBQQ__CustomerPrice__c = 5;
        TSTU_SFTestObject.upsertWithRetry(qli1);
        qli1 = [SELECT Id, SBQQ__Quote__c, SBQQ__Product__c, SBQQ__Discount__c, FLD_SAP_Item_Number__c, SBQQ__AdditionalDiscount__c FROM SBQQ__QuoteLine__c WHERE Id = :qli1.id];

        Map<String, SBO_EnosixSO_Detail.CONDITIONS> conditionMapPercent = new Map<String, SBO_EnosixSO_Detail.CONDITIONS>();
        Map<String, SBO_EnosixSO_Detail.CONDITIONS> conditionMapValue = new Map<String, SBO_EnosixSO_Detail.CONDITIONS>();
		utility.addCondition(orderDetail, '1', qli1, false, conditionMapPercent, conditionMapValue);
        conditionMapPercent.put('1',new SBO_EnosixSO_Detail.CONDITIONS());
		utility.addCondition(orderDetail, '1', qli1, false, conditionMapPercent, conditionMapValue);

        qli1.SBQQ__Discount__c = null;
        TSTU_SFTestObject.upsertWithRetry(qli1);
		utility.addCondition(orderDetail, '1', qli1, false, conditionMapPercent, conditionMapValue);
        conditionMapValue.put('1',new SBO_EnosixSO_Detail.CONDITIONS());
		utility.addCondition(orderDetail, '1', qli1, false, conditionMapPercent, conditionMapValue);

		Test.stopTest();
    }

    @isTest
    static void test_finalizeOrderAndUpdateSfsObject()
    {
    	Test.startTest();
        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();
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
        SBQQ__Quote__c testSObject = createTestObjects();

        SBO_EnosixSO_Detail.EnosixSO orderDetail = createOrder();

        Test.startTest();
        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();

        Map<string, Id> materialToProductIdMap = new Map<string, Id>();
        Map<Id, PricebookEntry> productToPricebookEntryMap = new Map<Id, PricebookEntry>();

        List<Product2> newProdList = new List<Product2>();

        Product2 product1 = TSTU_SFTestObject.createTestProduct2();
        product1.Name = 'Material1';
        product1.Description = 'Material1';
        product1.ProductCode = 'Material1';
        product1.IsActive = true;
        UTIL_SFProduct.setProductMaterialNumber(product1, 'Material1');
        newProdList.add(product1);

        Product2 product2 = TSTU_SFTestObject.createTestProduct2();
        product2.Name = 'Material2';
        product2.Description = 'Material2';
        product2.ProductCode = 'Material2';
        product2.IsActive = true;
        UTIL_SFProduct.setProductMaterialNumber(product2, 'Material2');
        newProdList.add(product2);

        TSTU_SFTestObject.upsertWithRetry(newProdList);

        List<PriceBookEntry> pbeList = new List<PriceBookEntry>();

        PricebookEntry pbe1 = TSTU_SFTestObject.createTestPriceBookEntry();
        pbe1.Pricebook2Id = UTIL_Pricebook.getStandardPriceBookId();
        pbe1.Product2Id = product1.Id;
        pbe1.UnitPrice = 0;
        pbe1.IsActive = true;
        pbe1.UseStandardPrice = false;
        pbeList.add(pbe1);

        PricebookEntry pbe2 = TSTU_SFTestObject.createTestPriceBookEntry();
        pbe2.Pricebook2Id = UTIL_Pricebook.getStandardPriceBookId();
        pbe2.Product2Id = product2.Id;
        pbe2.UnitPrice = 0;
        pbe2.IsActive = true;
        pbe2.UseStandardPrice = false;
        pbeList.add(pbe2);

        TSTU_SFTestObject.upsertWithRetry(pbeList);

        materialToProductIdMap.put('Material1', product1.Id);
        materialToProductIdMap.put('Material2', product2.Id);
        productToPricebookEntryMap.put(product1.Id, pbe1);
        productToPricebookEntryMap.put(product2.Id, pbe2);

        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap = new Map<String, UTIL_SFSObjectDoc.SfSObjectItem>();
        UTIL_SFSObjectDoc.SfSObjectItem sfSobjectItem1 = new UTIL_SFSObjectDoc.SfSObjectItem(lineId1);
        sfSobjectItem1.isDeleted = true;
        sfSObjectLineIdMap.put('1',sfSobjectItem1);
        UTIL_SFSObjectDoc.SfSObjectItem sfSobjectItem2 = new UTIL_SFSObjectDoc.SfSObjectItem(lineId2);
        sfSObjectLineIdMap.put('2',sfSobjectItem2);
        utility.upsertLineItemsFromOrderItems(testSObject, orderDetail.ITEMS.getAsList(), materialToProductIdMap, productToPricebookEntryMap, sfSObjectLineIdMap);
        Test.stopTest();
    }

    @isTest
    static void test_sObjectToSalesDocMapping()
    {
        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();
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
        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();
        SObject testSObject = createTestObjects();
        DS_Document_Detail salesDocDetail = new DS_Document_Detail();
        salesDocDetail.SalesDocument = 'SalesDocument';
		utility.salesDocMappingToSObject(testSObject, salesDocDetail, 'Quote');
		utility.salesDocMappingToSObject(testSObject, salesDocDetail, 'Order');
		Test.stopTest();
    }

    @isTest
    static void test_salesDocLineItemMappingToSObject()
    {
    	Test.startTest();
        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();
        SObject testSObject = createTestObjects();
        DS_Document_Detail.ITEMS item = new DS_Document_Detail.ITEMS();
        item.ItemConfigurations = new List<DS_Document_Detail.CONFIG>();
        DS_Document_Detail.CONFIG config = new DS_Document_Detail.CONFIG();
        item.ItemConfigurations.add(config);
        SObject lineItem = null;
		lineItem = utility.salesDocLineItemMappingToSObject(testSObject, item, new PricebookEntry(), null, lineItem);
		lineItem = utility.salesDocLineItemMappingToSObject(testSObject, item, new PricebookEntry(), null, lineItem);
		Test.stopTest();
    }

    private static SBO_EnosixQuote_Detail.EnosixQuote createQuote()
    {
        SBO_EnosixQuote_Detail.EnosixQuote result = new SBO_EnosixQuote_Detail.EnosixQuote();

        SBO_EnosixQuote_Detail.ITEMS item1 = new SBO_EnosixQuote_Detail.ITEMS();
        item1.ItemNumber = '1';
        item1.ItemDescription = 'Item 1';
        item1.Material = 'Material1';
        item1.OrderQuantity = 1;
        item1.NetItemPrice = 10.00;
        item1.ScheduleLineDate = Date.newInstance(2017, 3, 17);

        result.ITEMS.add(item1);

        SBO_EnosixQuote_Detail.ITEMS item2 = new SBO_EnosixQuote_Detail.ITEMS();
        item2.ItemNumber = '2';
        item2.ItemDescription = 'Item 2';
        item2.Material = 'Material2';
        item2.OrderQuantity = 2;
        item2.NetItemPrice = 10.00;
        item2.ScheduleLineDate = Date.newInstance(2017, 3, 17);

        result.ITEMS.add(item2);

        return result;
    }

    private static SBO_EnosixSO_Detail.EnosixSO createOrder()
    {
        SBO_EnosixSO_Detail.EnosixSO result = new SBO_EnosixSO_Detail.EnosixSO();

        SBO_EnosixSO_Detail.ITEMS item1 = new SBO_EnosixSO_Detail.ITEMS();
        item1.ItemNumber = '1';
        item1.ItemDescription = 'Item 1';
        item1.Material = 'Material1';
        item1.OrderQuantity = 1;
        item1.NetItemPrice = 10.00;
        item1.ScheduleLineDate = Date.newInstance(2017, 3, 17);

        result.ITEMS.add(item1);

        SBO_EnosixSO_Detail.ITEMS item2 = new SBO_EnosixSO_Detail.ITEMS();
        item2.ItemNumber = '2';
        item2.ItemDescription = 'Item 2';
        item2.Material = 'Material2';
        item2.OrderQuantity = 2;
        item2.NetItemPrice = 10.00;
        item2.ScheduleLineDate = Date.newInstance(2017, 3, 17);

        result.ITEMS.add(item2);

        return result;
    }

    private static string lineId1 = null;
    private static string lineId2 = null;
    private static List<SBQQ__QuoteLine__c> insertQliList = null;

    private static SBQQ__Quote__c createTestObjects()
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

        Account account = TSTU_SFTestObject.createTestAccount();
        account.AccountNumber = 'Test';
        TSTU_SFTestObject.upsertWithRetry(account);

        SBQQ__Quote__c quote = TSTU_SFCPQQuote.createTestQuote();
        quote.SBQQ__Account__c = account.Id;
        quote.SBQQ__Opportunity2__c = opp.Id;
        quote.SBQQ__PriceBook__c = pricebookId;
        quote.SAP_Configuration__c = 
            '{"soldToParty":"soldToParty",' + 
            '"salesOrg":"salesOrg",' + 
            '"distChannel":"distChannel",' + 
            '"division":"division"}';
        quote.FLD_Ship_To_Number__c = 'ShipTo';
        quote.FLD_Bill_To_Number__c = 'BillTo';
        quote.FLD_Payer_Number__c = 'Payer';
        TSTU_SFTestObject.upsertWithRetry(quote);
        quote = [SELECT Id, SBQQ__Opportunity2__c, SBQQ__Account__c, FLD_SAP_Quote_Number__c, SAP_Configuration__c FROM SBQQ__Quote__c WHERE Id = :quote.Id];
        quote.SBQQ__PriceBook__c = pricebookId;
        TSTU_SFTestObject.upsertWithRetry(quote);

        List<Product2> newProdList = new List<Product2>();

        Product2 newProd1 = TSTU_SFTestObject.createTestProduct2();
        newProd1.Name = 'test product';
        newProd1.family = 'test family';
        newProd1.put(UTIL_SFProduct.MaterialFieldName,'Material1');
        newProdList.add(newProd1);

        Product2 newProd2 = TSTU_SFTestObject.createTestProduct2();
        newProd2.Name = 'test product';
        newProd2.family = 'test family';
        newProd2.put(UTIL_SFProduct.MaterialFieldName,'Material2');
        newProdList.add(newProd2);

        Product2 newProd3 = TSTU_SFTestObject.createTestProduct2();
        newProd3.Name = 'test product';
        newProd3.family = 'test family';
        newProd3.put(UTIL_SFProduct.MaterialFieldName,'Material3');
        newProdList.add(newProd3);

        Product2 newProd4 = TSTU_SFTestObject.createTestProduct2();
        newProd4.Name = 'test product';
        newProd4.family = 'test family';
        newProd4.put(UTIL_SFProduct.MaterialFieldName,'Material4');
        newProdList.add(newProd4);

        Product2 newProd5 = TSTU_SFTestObject.createTestProduct2();
        newProd5.Name = 'test product';
        newProd5.family = 'test family';
        newProd5.put(UTIL_SFProduct.MaterialFieldName,'Material5');
        newProdList.add(newProd5);

        Product2 newProd6 = TSTU_SFTestObject.createTestProduct2();
        newProd6.Name = 'test product';
        newProd6.family = 'test family';
        newProd6.put(UTIL_SFProduct.MaterialFieldName,'Material6');
        newProdList.add(newProd6);

        Product2 newProd7 = TSTU_SFTestObject.createTestProduct2();
        newProd7.Name = 'test product';
        newProd7.family = 'test family';
        newProd7.put(UTIL_SFProduct.MaterialFieldName,'Material7');
        newProdList.add(newProd7);

        Product2 newProd8 = TSTU_SFTestObject.createTestProduct2();
        newProd8.Name = 'test product';
        newProd8.family = 'test family';
        newProd8.put(UTIL_SFProduct.MaterialFieldName,'Material8');
        newProdList.add(newProd8);

        TSTU_SFTestObject.upsertWithRetry(newProdList);

        List<PriceBookEntry> insertPbeList = new List<PriceBookEntry>();

        PriceBookEntry standardPbe1 = TSTU_SFTestObject.createTestPriceBookEntry();
        standardPbe1.UnitPrice = 100;
        standardPbe1.Pricebook2Id = pricebookId;
        standardPbe1.Product2Id = newProd1.Id;
        standardPbe1.UseStandardPrice = false;
        standardPbe1.IsActive = true;
        insertPbeList.add(standardPbe1);

        PriceBookEntry standardPbe2 = TSTU_SFTestObject.createTestPriceBookEntry();
        standardPbe2.UnitPrice = 100;
        standardPbe2.Pricebook2Id = pricebookId;
        standardPbe2.Product2Id = newProd2.Id;
        standardPbe2.UseStandardPrice = false;
        standardPbe2.IsActive = true;
        insertPbeList.add(standardPbe2);

        PriceBookEntry standardPbe3 = TSTU_SFTestObject.createTestPriceBookEntry();
        standardPbe3.UnitPrice = 100;
        standardPbe3.Pricebook2Id = pricebookId;
        standardPbe3.Product2Id = newProd3.Id;
        standardPbe3.UseStandardPrice = false;
        standardPbe3.IsActive = true;
        insertPbeList.add(standardPbe3);

        PriceBookEntry standardPbe4 = TSTU_SFTestObject.createTestPriceBookEntry();
        standardPbe4.UnitPrice = 100;
        standardPbe4.Pricebook2Id = pricebookId;
        standardPbe4.Product2Id = newProd4.Id;
        standardPbe4.UseStandardPrice = false;
        standardPbe4.IsActive = true;
        insertPbeList.add(standardPbe4);

        TSTU_SFTestObject.upsertWithRetry(insertPbeList);

        insertQliList = new List<SBQQ__QuoteLine__c>();
        SBQQ__QuoteLine__c qli1 = TSTU_SFCPQQuote.createTestQuoteLine();
		qli1.SBQQ__Quote__c = quote.Id;
        qli1.SBQQ__Product__c = newProd1.Id;
        qli1.SBQQ__Number__c = 1;
		qli1.SBQQ__Quantity__c = 10;
		qli1.SBQQ__ListPrice__c = .95;
		qli1.SBQQ__Description__c = 'test Desciption';
        qli1.SBQQ__PricebookEntryId__c = standardPbe1.Id;
        qli1.SBQQ__Discount__c = 10;
        qli1.SBQQ__MarkupAmount__c = 5;
        qli1.SBQQ__NetPrice__c = .95;
        qli1.FLD_SAP_Item_Number__c = '1';
        qli1.SAP_Configuration__c = 
            '{"plant":"plant",' + 
            '"OrderQuantity":1,' + 
            '"materialNumber":"Material1",' + 
            '"selectedCharacteristics":[{"Atwrt":"Atwrt","Atnam":"Atnam","UserModified":true,"CharacteristicID":"1"}]}';
        insertQliList.add(qli1);

        SBQQ__QuoteLine__c qli1a = TSTU_SFCPQQuote.createTestQuoteLine();
		qli1a.SBQQ__Quote__c = quote.Id;
        qli1a.SBQQ__Product__c = newProd2.Id;
        qli1a.SBQQ__DynamicOptionId__c = '1';
        qli1a.SBQQ__Number__c = 2;
		qli1a.SBQQ__Quantity__c = 10;
		qli1a.SBQQ__ListPrice__c = .95;
		qli1a.SBQQ__Description__c = 'test Desciption';
        qli1a.SBQQ__PricebookEntryId__c = standardPbe2.Id;
        qli1a.SBQQ__Discount__c = 10;
        qli1a.SBQQ__MarkupAmount__c = 5;
        qli1a.SBQQ__NetPrice__c = .95;
        qli1a.FLD_SAP_Item_Number__c = '1';
        qli1a.SAP_Configuration__c = 
            '{"plant":"plant",' + 
            '"OrderQuantity":1,' + 
            '"materialNumber":"Material2",' + 
            '"selectedCharacteristics":[{"Atwrt":"Atwrt","Atnam":"Atnam","UserModified":true,"CharacteristicID":"1"}]}';
        insertQliList.add(qli1a);

        SBQQ__QuoteLine__c qli1b = TSTU_SFCPQQuote.createTestQuoteLine();
		qli1b.SBQQ__Quote__c = quote.Id;
        qli1b.SBQQ__Product__c = newProd3.Id;
        qli1b.SBQQ__DynamicOptionId__c = '1';
        qli1b.SBQQ__Number__c = 2;
		qli1b.SBQQ__Quantity__c = 10;
		qli1b.SBQQ__ListPrice__c = .95;
		qli1b.SBQQ__Description__c = 'test Desciption';
        qli1b.SBQQ__PricebookEntryId__c = standardPbe3.Id;
        qli1b.SBQQ__AdditionalDiscountAmount__c = 10;
        qli1b.SBQQ__RegularPrice__c = 10;
        qli1b.SBQQ__CustomerPrice__c = 5;
        qli1b.SBQQ__MarkupAmount__c = 5;
        qli1b.SBQQ__NetPrice__c = .95;
        qli1b.SBQQ__UnitCost__c = 2.5;
        qli1b.FLD_SAP_Item_Number__c = '3';
        qli1b.SAP_Configuration__c = 
            '{"plant":"plant",' + 
            '"OrderQuantity":1,' + 
            '"materialNumber":"Material3",' + 
            '"selectedCharacteristics":[{"Atwrt":"Atwrt","Atnam":"Atnam","UserModified":true,"CharacteristicID":"1"}]}';
        insertQliList.add(qli1b);

        SBQQ__QuoteLine__c qli1c = TSTU_SFCPQQuote.createTestQuoteLine();
		qli1c.SBQQ__Quote__c = quote.Id;
        qli1c.SBQQ__Product__c = newProd4.Id;
        qli1c.SBQQ__DynamicOptionId__c = '1';
        qli1c.SBQQ__Number__c = 2;
		qli1c.SBQQ__Quantity__c = 10;
		qli1c.SBQQ__ListPrice__c = 10;
		qli1c.SBQQ__Description__c = 'test Desciption';
        qli1c.SBQQ__PricebookEntryId__c = standardPbe4.Id;
        qli1c.SBQQ__Discount__c = 10;
        qli1c.SBQQ__MarkupAmount__c = 5;
        qli1c.SBQQ__NetPrice__c = .95;
        qli1c.FLD_SAP_Item_Number__c = '4';
        qli1c.SAP_Configuration__c = 
            '{"plant":"plant",' + 
            '"OrderQuantity":1,' + 
            '"materialNumber":"Material4",' + 
            '"selectedCharacteristics":[{"Atwrt":"Atwrt","Atnam":"Atnam","UserModified":true,"CharacteristicID":"1"}]}';
        insertQliList.add(qli1c);

        SBQQ__QuoteLine__c qli1d = TSTU_SFCPQQuote.createTestQuoteLine();
		qli1d.SBQQ__Quote__c = quote.Id;
        qli1d.SBQQ__Product__c = newProd4.Id;
        qli1d.SBQQ__DynamicOptionId__c = '1';
        qli1d.SBQQ__Number__c = 2;
		qli1d.SBQQ__Quantity__c = 10;
		qli1d.SBQQ__ListPrice__c = 10;
		qli1d.SBQQ__Description__c = 'test Desciption';
        qli1d.SBQQ__PricebookEntryId__c = standardPbe4.Id;
        qli1d.SBQQ__Discount__c = 10;
        qli1d.SBQQ__MarkupAmount__c = 5;
        qli1d.SBQQ__NetPrice__c = .95;
        qli1d.FLD_SAP_Item_Number__c = '5';
        qli1d.SAP_Configuration__c = 
            '{"plant":"plant",' + 
            '"OrderQuantity":1,' + 
            '"materialNumber":"Material4",' + 
            '"selectedCharacteristics":[{"Atwrt":"Atwrt","Atnam":"Atnam","UserModified":true,"CharacteristicID":"1"}]}';
        insertQliList.add(qli1d);

        SBQQ__QuoteLine__c qli1e = TSTU_SFCPQQuote.createTestQuoteLine();
		qli1e.SBQQ__Quote__c = quote.Id;
        qli1e.SBQQ__Product__c = newProd5.Id;
        qli1e.SBQQ__DynamicOptionId__c = '1';
        qli1e.SBQQ__Number__c = 2;
		qli1e.SBQQ__Quantity__c = 10;
		qli1e.SBQQ__ListPrice__c = 10;
		qli1e.SBQQ__Description__c = 'test Desciption';
        qli1e.SBQQ__PricebookEntryId__c = standardPbe4.Id;
        qli1e.SBQQ__RegularPrice__c = 10;
        qli1e.SBQQ__CustomerPrice__c = 5;
        qli1e.SBQQ__MarkupAmount__c = 5;
        qli1e.SBQQ__NetPrice__c = .95;
        qli1e.FLD_SAP_Item_Number__c = '17';
        qli1e.SBQQ__UnitCost__c = 5;
        qli1e.SBQQ__BundledQuantity__c = 10;
        qli1e.SAP_Configuration__c = 
            '{"plant":"plant",' + 
            '"OrderQuantity":1,' + 
            '"materialNumber":"Material4",' + 
            '"selectedCharacteristics":[{"Atwrt":"Atwrt","Atnam":"Atnam","UserModified":true,"CharacteristicID":"1"}]}';
        insertQliList.add(qli1e);

        SBQQ__QuoteLine__c qli1f = TSTU_SFCPQQuote.createTestQuoteLine();
		qli1f.SBQQ__Quote__c = quote.Id;
        qli1f.SBQQ__Product__c = newProd6.Id;
        qli1f.SBQQ__DynamicOptionId__c = '1';
        qli1f.SBQQ__Number__c = 2;
		qli1f.SBQQ__Quantity__c = 1;
		qli1f.SBQQ__ListPrice__c = 20;
		qli1f.SBQQ__Description__c = 'test Desciption';
        qli1f.SBQQ__PricebookEntryId__c = standardPbe4.Id;
        qli1f.SBQQ__Discount__c = 10;
        qli1f.SBQQ__MarkupAmount__c = 5;
        qli1f.SBQQ__NetPrice__c = .95;
        qli1f.FLD_SAP_Item_Number__c = '18';
        qli1f.SBQQ__UnitCost__c = 10;
        qli1f.SBQQ__BundledQuantity__c = 1;
        qli1f.SAP_Configuration__c = 
            '{"plant":"plant",' + 
            '"OrderQuantity":1,' + 
            '"materialNumber":"Material4",' + 
            '"selectedCharacteristics":[{"Atwrt":"Atwrt","Atnam":"Atnam","UserModified":true,"CharacteristicID":"1"}]}';
        insertQliList.add(qli1f);

        SBQQ__QuoteLine__c qli1g = TSTU_SFCPQQuote.createTestQuoteLine();
		qli1g.SBQQ__Quote__c = quote.Id;
        qli1g.SBQQ__Product__c = newProd7.Id;
        qli1g.SBQQ__DynamicOptionId__c = '1';
        qli1g.SBQQ__Number__c = 2;
		qli1g.SBQQ__Quantity__c = 1;
		qli1g.SBQQ__ListPrice__c = 20;
		qli1g.SBQQ__Description__c = 'test Desciption';
        qli1g.SBQQ__PricebookEntryId__c = standardPbe4.Id;
        qli1g.SBQQ__RegularPrice__c = 10;
        qli1g.SBQQ__CustomerPrice__c = 5;
        qli1g.SBQQ__MarkupAmount__c = 5;
        qli1g.SBQQ__NetPrice__c = .95;
        qli1g.FLD_SAP_Item_Number__c = '19';
        qli1g.SBQQ__UnitCost__c = 5;
        qli1g.SBQQ__BundledQuantity__c = 1;
        qli1g.SAP_Configuration__c = 
            '{"plant":"plant",' + 
            '"OrderQuantity":1,' + 
            '"materialNumber":"Material4",' + 
            '"selectedCharacteristics":[{"Atwrt":"Atwrt","Atnam":"Atnam","UserModified":true,"CharacteristicID":"1"}]}';
        insertQliList.add(qli1g);

        SBQQ__QuoteLine__c qli1h = TSTU_SFCPQQuote.createTestQuoteLine();
		qli1h.SBQQ__Quote__c = quote.Id;
        qli1h.SBQQ__Product__c = newProd8.Id;
        qli1h.SBQQ__DynamicOptionId__c = '1';
        qli1h.SBQQ__Number__c = 2;
		qli1h.SBQQ__Quantity__c = 1;
		qli1h.SBQQ__ListPrice__c = 10;
		qli1h.SBQQ__Description__c = 'test Desciption';
        qli1h.SBQQ__PricebookEntryId__c = standardPbe4.Id;
        qli1h.SBQQ__Discount__c = 10;
        qli1h.SBQQ__MarkupAmount__c = 5;
        qli1h.SBQQ__NetPrice__c = .95;
        qli1h.FLD_SAP_Item_Number__c = '20';
        qli1h.SBQQ__UnitCost__c = 10;
        qli1h.SBQQ__BundledQuantity__c = 1;
        qli1h.SAP_Configuration__c = 
            '{"plant":"plant",' + 
            '"OrderQuantity":1,' + 
            '"materialNumber":"Material4",' + 
            '"selectedCharacteristics":[{"Atwrt":"Atwrt","Atnam":"Atnam","UserModified":true,"CharacteristicID":"1"}]}';
        insertQliList.add(qli1h);

        SBQQ__QuoteLine__c qli2 = TSTU_SFCPQQuote.createTestQuoteLine();
		qli2.SBQQ__Quote__c = quote.Id;
        qli2.SBQQ__Product__c = newProd1.Id;
        qli2.SBQQ__Number__c = 3;
		qli2.SBQQ__Quantity__c = 10;
		qli2.SBQQ__ListPrice__c = .95;
		qli2.SBQQ__Description__c = 'test Desciption';
        qli2.SBQQ__PricebookEntryId__c = standardPbe1.Id;
        qli2.SBQQ__AdditionalDiscountAmount__c = 10;
        qli2.SBQQ__RegularPrice__c = 10;
        qli2.SBQQ__CustomerPrice__c = 5;
        qli2.SBQQ__MarkupAmount__c = 5;
        qli2.SBQQ__NetPrice__c = .95;
        qli2.FLD_SAP_Item_Number__c = '1';
        qli2.SAP_Configuration__c = 
            '{"plant":"plant",' + 
            '"OrderQuantity":1,' + 
            '"materialNumber":"Material1",' + 
            '"selectedCharacteristics":[{"Atwrt":"Atwrt","Atnam":"Atnam","UserModified":true,"CharacteristicID":"1"}]}';
        insertQliList.add(qli2);

        SBQQ__QuoteLine__c qli2a = TSTU_SFCPQQuote.createTestQuoteLine();
		qli2a.SBQQ__Quote__c = quote.Id;
        qli2a.SBQQ__Product__c = newProd2.Id;
        qli2a.SBQQ__DynamicOptionId__c = '2';
        qli2a.SBQQ__Number__c = 4;
		qli2a.SBQQ__Quantity__c = 10;
		qli2a.SBQQ__ListPrice__c = .95;
		qli2a.SBQQ__Description__c = 'test Desciption';
        qli2a.SBQQ__PricebookEntryId__c = standardPbe2.Id;
        qli2a.SBQQ__AdditionalDiscountAmount__c = 10;
        qli2a.SBQQ__RegularPrice__c = 10;
        qli2a.SBQQ__CustomerPrice__c = 5;
        qli2a.SBQQ__MarkupAmount__c = 5;
        qli2a.SBQQ__NetPrice__c = .95;
        qli2a.FLD_SAP_Item_Number__c = '2';
        qli2a.SAP_Configuration__c = 
            '{"plant":"plant",' + 
            '"OrderQuantity":1,' + 
            '"materialNumber":"Material2",' + 
            '"selectedCharacteristics":[{"Atwrt":"Atwrt","Atnam":"Atnam","UserModified":true,"CharacteristicID":"1"}]}';
        insertQliList.add(qli2a);

        SBQQ__QuoteLine__c qli2b = TSTU_SFCPQQuote.createTestQuoteLine();
		qli2b.SBQQ__Quote__c = quote.Id;
        qli2b.SBQQ__Product__c = newProd3.Id;
        qli2b.SBQQ__DynamicOptionId__c = '2';
        qli2b.SBQQ__Number__c = 4;
		qli2b.SBQQ__Quantity__c = 10;
		qli2b.SBQQ__ListPrice__c = .95;
		qli2b.SBQQ__Description__c = 'test Desciption';
        qli2b.SBQQ__PricebookEntryId__c = standardPbe3.Id;
        qli2b.SBQQ__Discount__c = 10;
        qli2b.SBQQ__MarkupAmount__c = 5;
        qli2b.SBQQ__NetPrice__c = .95;
        qli2b.SBQQ__UnitCost__c = 2.5;
        qli2b.FLD_SAP_Item_Number__c = '3';
        qli2b.SAP_Configuration__c = 
            '{"plant":"plant",' + 
            '"OrderQuantity":1,' + 
            '"materialNumber":"Material3",' + 
            '"selectedCharacteristics":[{"Atwrt":"Atwrt","Atnam":"Atnam","UserModified":true,"CharacteristicID":"1"}]}';
        insertQliList.add(qli2b);

        SBQQ__QuoteLine__c qli2c = TSTU_SFCPQQuote.createTestQuoteLine();
		qli2c.SBQQ__Quote__c = quote.Id;
        qli2c.SBQQ__Product__c = newProd2.Id;
        qli2c.SBQQ__DynamicOptionId__c = '2';
        qli2c.SBQQ__Number__c = 4;
		qli2c.SBQQ__Quantity__c = 10;
		qli2c.SBQQ__ListPrice__c = 10;
		qli2c.SBQQ__Description__c = 'test Desciption';
        qli2c.SBQQ__PricebookEntryId__c = standardPbe2.Id;
        qli2c.SBQQ__AdditionalDiscountAmount__c = 10;
        qli2c.SBQQ__RegularPrice__c = 10;
        qli2c.SBQQ__CustomerPrice__c = 5;
        qli2c.SBQQ__MarkupAmount__c = 5;
        qli2c.SBQQ__NetPrice__c = .95;
        qli2c.FLD_SAP_Item_Number__c = '4';
        qli2c.SAP_Configuration__c = 
            '{"plant":"plant",' + 
            '"OrderQuantity":1,' + 
            '"materialNumber":"Material4",' + 
            '"selectedCharacteristics":[{"Atwrt":"Atwrt","Atnam":"Atnam","UserModified":true,"CharacteristicID":"1"}]}';
        insertQliList.add(qli2c);

        SBQQ__QuoteLine__c qli2d = TSTU_SFCPQQuote.createTestQuoteLine();
		qli2d.SBQQ__Quote__c = quote.Id;
        qli2d.SBQQ__Product__c = newProd2.Id;
        qli2d.SBQQ__DynamicOptionId__c = '2';
        qli2d.SBQQ__Number__c = 4;
		qli2d.SBQQ__Quantity__c = 10;
		qli2d.SBQQ__ListPrice__c = 10;
		qli2d.SBQQ__Description__c = 'test Desciption';
        qli2d.SBQQ__PricebookEntryId__c = standardPbe2.Id;
        qli2d.SBQQ__AdditionalDiscountAmount__c = 10;
        qli2d.SBQQ__RegularPrice__c = 10;
        qli2d.SBQQ__CustomerPrice__c = 5;
        qli2d.SBQQ__MarkupAmount__c = 5;
        qli2d.SBQQ__NetPrice__c = .95;
        qli2d.FLD_SAP_Item_Number__c = '5';
        qli2d.SAP_Configuration__c = 
            '{"plant":"plant",' + 
            '"OrderQuantity":1,' + 
            '"materialNumber":"Material4",' + 
            '"selectedCharacteristics":[{"Atwrt":"Atwrt","Atnam":"Atnam","UserModified":true,"CharacteristicID":"1"}]}';
        insertQliList.add(qli2d);

        TSTU_SFTestObject.upsertWithRetry(insertQliList);

        lineId1 = qli1.Id;
        lineId2 = qli2.Id;

        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();
        return (SBQQ__Quote__c) utility.getSObject(quote.Id);
    }

    public static SBQQ__Quote__c createTestQuote()
    {
        SBQQ__Quote__c quote = new SBQQ__Quote__c();
        return quote;
    }

    public static SBQQ__QuoteLine__c createTestQuoteLine()
    {
        SBQQ__QuoteLine__c quoteLine = new SBQQ__QuoteLine__c();
        return quoteLine;
    }
}