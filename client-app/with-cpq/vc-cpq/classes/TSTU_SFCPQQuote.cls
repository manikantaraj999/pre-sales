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
        SBQQ__Quote__c testSObject = createTestObjects();
        utility.getSObjectLineItems('bad Id');
        utility.getSObjectLineItems(testSObject.Id);
        utility.getSObjectLineItems(testSObject.Id);
        utility.loadLineMap(new List<SObject>{new Account()}, new Map<Id, SObject>());
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
    static void test_getInquiryNumber()
    {
    	Test.startTest();
        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();
        SObject testSObject = createTestObjects();
		utility.getInquiryNumber(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getCreditMemoNumber()
    {
    	Test.startTest();
        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();
        SObject testSObject = createTestObjects();
		utility.getCreditMemoNumber(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getDebitMemoNumber()
    {
    	Test.startTest();
        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();
        SObject testSObject = createTestObjects();
		utility.getDebitMemoNumber(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getReturnOrderNumber()
    {
    	Test.startTest();
        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();
        SObject testSObject = createTestObjects();
		utility.getReturnOrderNumber(testSObject);
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
    static void test_getOpportunityId()
    {
    	Test.startTest();
        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();
        SObject testSObject = createTestObjects();
		utility.getOpportunityId(testSObject);
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
    static void test_sObjectToSalesDocMapping()
    {
        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();
        SBQQ__Quote__c testSObject = createTestObjects();
        List<SObject> lineItems = new List<SObject>{createTestObjectLines()};
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
		utility.salesDocMappingToSObject(testSObject, salesDocDetail, 'Contract');
		utility.salesDocMappingToSObject(testSObject, salesDocDetail, 'Credit Memo');
		utility.salesDocMappingToSObject(testSObject, salesDocDetail, 'Debit Memo');
		utility.salesDocMappingToSObject(testSObject, salesDocDetail, 'Inquiry');
		utility.salesDocMappingToSObject(testSObject, salesDocDetail, 'Return Order');
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
        quote.FLD_Ship_To_Number__c = 'ShipTo';
        quote.FLD_Bill_To_Number__c = 'BillTo';
        quote.FLD_Payer_Number__c = 'Payer';
        TSTU_SFTestObject.upsertWithRetry(quote);
        quote = [SELECT Id, SBQQ__Opportunity2__c, SBQQ__Account__c, FLD_SAP_Quote_Number__c, SAP_Configuration__c FROM SBQQ__Quote__c WHERE Id = :quote.Id];
        quote.SBQQ__PriceBook__c = pricebookId;
        TSTU_SFTestObject.upsertWithRetry(quote);

        UTIL_SFCPQQuote utility = new UTIL_SFCPQQuote();
        return (SBQQ__Quote__c) utility.getSObject(quote.Id);
    }

    private static SObject createTestObjectLines()
    {
        SBQQ__QuoteLine__c qli = TSTU_SFCPQQuote.createTestQuoteLine();
        qli.SBQQ__Number__c = 1;
		qli.SBQQ__Quantity__c = 10;
		qli.SBQQ__ListPrice__c = .95;
		qli.SBQQ__Description__c = 'test Desciption';
        qli.SBQQ__Discount__c = 10;
        qli.SBQQ__MarkupAmount__c = 5;
        qli.SBQQ__NetPrice__c = .95;
        qli.FLD_SAP_Item_Number__c = '1';
        qli.SAP_Configuration__c = 
            '{"plant":"plant",' + 
            '"OrderQuantity":1,' + 
            '"materialNumber":"Material1",' + 
            '"selectedCharacteristics":[{"Atwrt":"Atwrt","Atnam":"Atnam","UserModified":true,"CharacteristicID":"1"}]}';
        return qli;
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