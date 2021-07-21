/*
* Test cases for Quote utility class
*/
@isTest 
public class TSTU_SFQuote
{
    @isTest
    public static void test_getSObject()
    {
        SObject testSObject = createTestObjects();

        Test.startTest();
        UTIL_SFQuote utility = new UTIL_SFQuote();
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
        UTIL_SFQuote utility = new UTIL_SFQuote();
        Quote testSObject = createTestObjects();
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
        UTIL_SFQuote utility = new UTIL_SFQuote();
        SObject testSObject = createTestObjects();
		utility.getSObjectContacts(null);
		Test.stopTest();
    }

    @isTest
    static void test_getAccountId()
    {
    	Test.startTest();
        UTIL_SFQuote utility = new UTIL_SFQuote();
        SObject testSObject = createTestObjects();
		utility.getAccountId(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getCustomerNumber()
    {
    	Test.startTest();
        UTIL_SFQuote utility = new UTIL_SFQuote();
        SObject testSObject = createTestObjects();
		utility.getCustomerNumber(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getName()
    {
    	Test.startTest();
        UTIL_SFQuote utility = new UTIL_SFQuote();
        SObject testSObject = createTestObjects();
		utility.getName(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getQuoteNumber()
    {
    	Test.startTest();
        UTIL_SFQuote utility = new UTIL_SFQuote();
        SObject testSObject = createTestObjects();
		utility.getQuoteNumber(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getOrderNumber()
    {
    	Test.startTest();
        UTIL_SFQuote utility = new UTIL_SFQuote();
        SObject testSObject = createTestObjects();
		utility.getOrderNumber(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getContractNumber()
    {
    	Test.startTest();
        UTIL_SFQuote utility = new UTIL_SFQuote();
        SObject testSObject = createTestObjects();
		utility.getContractNumber(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getInquiryNumber()
    {
    	Test.startTest();
        UTIL_SFQuote utility = new UTIL_SFQuote();
        SObject testSObject = createTestObjects();
		utility.getInquiryNumber(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getCreditMemoNumber()
    {
    	Test.startTest();
        UTIL_SFQuote utility = new UTIL_SFQuote();
        SObject testSObject = createTestObjects();
		utility.getCreditMemoNumber(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getDebitMemoNumber()
    {
    	Test.startTest();
        UTIL_SFQuote utility = new UTIL_SFQuote();
        SObject testSObject = createTestObjects();
		utility.getDebitMemoNumber(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getReturnOrderNumber()
    {
    	Test.startTest();
        UTIL_SFQuote utility = new UTIL_SFQuote();
        SObject testSObject = createTestObjects();
		utility.getReturnOrderNumber(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getStatus()
    {
    	Test.startTest();
        UTIL_SFQuote utility = new UTIL_SFQuote();
        SObject testSObject = createTestObjects();
		utility.getStatus(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getOpportunityId()
    {
    	Test.startTest();
        UTIL_SFQuote utility = new UTIL_SFQuote();
        SObject testSObject = createTestObjects();
		utility.getOpportunityId(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getPriceBookId()
    {
    	Test.startTest();
        UTIL_SFQuote utility = new UTIL_SFQuote();
        SObject testSObject = createTestObjects();
		utility.getPriceBookId(null);
		utility.getPriceBookId(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getProductId()
    {
    	Test.startTest();
        UTIL_SFQuote utility = new UTIL_SFQuote();
		utility.getProductId(null);
		Test.stopTest();
    }

    @isTest
    static void test_getMaterial()
    {
    	Test.startTest();
        SObject testSObject = createTestObjects();
        UTIL_SFQuote utility = new UTIL_SFQuote();
		utility.getMaterial(testSObject, null);
		Test.stopTest();
    }

    @isTest
    static void test_getItemNumber()
    {
    	Test.startTest();
        UTIL_SFQuote utility = new UTIL_SFQuote();
		utility.getItemNumber(null);
		Test.stopTest();
    }

    @isTest
    static void test_validateSAPWithSfsObject()
    {
        Test.startTest();
        UTIL_SFQuote utility = new UTIL_SFQuote();
        SObject testSObject = createTestObjects();
        utility.validateSAPWithSfsObject('', testSObject);
        Test.stopTest();
    }

    @isTest
    static void test_sObjectToSalesDocMapping()
    {
        UTIL_SFQuote utility = new UTIL_SFQuote();
        Quote testSObject = createTestObjects();
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
        UTIL_SFQuote utility = new UTIL_SFQuote();
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
        UTIL_SFQuote utility = new UTIL_SFQuote();
        SObject testSObject = createTestObjects();
        DS_Document_Detail salesDocDetail = new DS_Document_Detail();
        salesDocDetail.SalesDocument = 'SalesDocument';
        SObject lineItem = null;
		lineItem = utility.salesDocLineItemMappingToSObject(testSObject, new DS_Document_Detail.ITEMS(), new PricebookEntry(), null, lineItem);
		lineItem = utility.salesDocLineItemMappingToSObject(testSObject, new DS_Document_Detail.ITEMS(), new PricebookEntry(), null, lineItem);
		Test.stopTest();
    }

    private static Quote createTestObjects()
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

        Quote quote = TSTU_SFQuote.createTestQuote();
        quote.Name = 'TEST QUOTE';
        quote.OpportunityId = opp.Id;
        quote.Pricebook2Id = pricebookId;
        TSTU_SFTestObject.upsertWithRetry(quote);
        quote = [SELECT Id, Pricebook2Id FROM Quote WHERE Id = :quote.Id];
        quote.Pricebook2Id = pricebookId;
        TSTU_SFTestObject.upsertWithRetry(quote);

        UTIL_SFQuote utility = new UTIL_SFQuote();
        return (Quote) utility.getSObject(quote.Id);
    }

    private static SObject createTestObjectLines()
    {
        QuoteLineItem qli = TSTU_SFQuote.createTestQuoteLineItem();
		qli.Quantity = 10;
		qli.UnitPrice = .95;
		qli.Description = 'test Desciption';
        qli.ServiceDate = Date.Today();
        qli.FLD_SAP_Item_Number__c = '000010';
        return qli;
    }

    public static Quote createTestQuote()
    {
        Quote quote = new Quote();
        quote.Name = 'TestQuote';
        return quote;
    }

    public static QuoteLineItem createTestQuoteLineItem() {
        QuoteLineItem opportunityLineItemObj = new QuoteLineItem();
        return opportunityLineItemObj;
    }
}
