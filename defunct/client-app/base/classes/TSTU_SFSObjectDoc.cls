/*
* Test cases for SFSObjectDoc utility class
*/
@isTest 
public class TSTU_SFSObjectDoc
{
    @isTest
    public static void test_loadSfsObjectDoc()
    {
        SObject testSObject = createTestObjects();

        Test.startTest();
        UTIL_SFSObjectDoc.loadSfsObjectDoc(testSObject);
        UTIL_SFSObjectDoc.loadSfsObjectDoc(testSObject.Id);
        UTIL_SFSObjectDoc.loadSfsObjectDoc('Opporutunity');
        Test.stopTest();
    }

    @isTest
    public static void test_initObjectsForSAP()
    {
        Test.startTest();
        Map<Id, SObject> testLines = null;
        Account testAccount = TSTU_SFTestObject.createTestAccount();
        testAccount.Name = 'test';
        TSTU_SFTestObject.upsertWithRetry(testAccount);
        UTIL_SFSObjectDoc.initObjectsForSAP('Bad Id', 'SAPDocNum', 'SAPDocType');
        UTIL_SFSObjectDoc.initObjectsForSAP(null, 'SAPDocNum', 'SAPDocType');
        Test.stopTest();
    }

    @isTest
    public static void test_initObjects()
    {
        Test.startTest();
        Map<Id, SObject> testLines = null;
        Account testAccount = TSTU_SFTestObject.createTestAccount();
        testAccount.Name = 'test';
        TSTU_SFTestObject.upsertWithRetry(testAccount);
        UTIL_PageState.current.sfAccountId = testAccount.Id;
        UTIL_SFSObjectDoc.initObjects('');
        UTIL_SFSObjectDoc.initObjects(UTIL_SFSObjectDoc.CALLED_FROM_OPPORTUNITY_PRICING);
        UTIL_SFSObjectDoc.sfsObject = TSTU_SFTestObject.createTestAccount();
        UTIL_PageState.current.sapOrderNum = 'SAPOppO';
        UTIL_SFSObjectDoc.initObjects('');
        UTIL_PageState.current.sapQuoteId = 'SAPQuoteQ';
        UTIL_SFSObjectDoc.initObjects('');
        Opportunity testOpportunity = createTestObjects();
        UTIL_PageState.current.sapQuoteId = null;
        UTIL_PageState.current.sapOrderNum = 'SAPOppO';
        UTIL_SFSObjectDoc.initObjects('');
        UTIL_PageState.current.sapQuoteId = 'SAPOppQ';
        UTIL_SFSObjectDoc.initObjects('');
        UTIL_PageState.current.sfCpqQuoteId = 'sfCpqQuoteId';
        UTIL_SFSObjectDoc.initObjects('');
        UTIL_PageState.current.sfQuoteId = 'sfQuoteId';
        UTIL_SFSObjectDoc.initObjects('');
        UTIL_PageState.current.sfOpportunityId = testOpportunity.Id;
        UTIL_SFSObjectDoc.initObjects('');
        UTIL_SFSObjectDoc.SfSObjectItem sfsObjectItem = new UTIL_SFSObjectDoc.SfSObjectItem(testOpportunity.AccountId);
        sfsObjectItem = new UTIL_SFSObjectDoc.SfSObjectItem(testOpportunity.AccountId);
        Test.stopTest();
    }

    @isTest
    public static void test_getSObject()
    {
        Test.startTest();
        SObject testSObject = createTestObjects();
        UTIL_SFSObjectDoc.getSObject('bad id');
        UTIL_SFSObjectDoc.getSObject(testSObject.Id);
        UTIL_SFSObjectDoc.getSObject('Opportunity', 'sapType', 'sapDocNum');
        Test.stopTest();
    }

    @isTest
    static void test_getSObjectLineItems()
    {
        Test.startTest();
        UTIL_SFSObjectDoc.getSObjectLineItems(null);
        Test.stopTest();
    }

    @isTest
    static void test_getSObjectContacts()
    {
        Test.startTest();
        UTIL_SFSObjectDoc.getSObjectContacts(null);
        Test.stopTest();
    }

    @isTest
    static void test_getAccountId()
    {
    	Test.startTest();
        SObject testSObject = createTestObjects();
		UTIL_SFSObjectDoc.getAccountId('bad id');
		UTIL_SFSObjectDoc.getAccountId(testSObject.Id);
		UTIL_SFSObjectDoc.getAccountId(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getCustomerNumber()
    {
    	Test.startTest();
        SObject testSObject = createTestObjects();
		UTIL_SFSObjectDoc.getCustomerNumber(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getName()
    {
    	Test.startTest();
		UTIL_SFSObjectDoc.getName(null);
		Test.stopTest();
    }

    @isTest
    static void test_getQuoteNumber()
    {
    	Test.startTest();
		UTIL_SFSObjectDoc.getQuoteNumber(null);
		Test.stopTest();
    }

    @isTest
    static void test_getOrderNumber()
    {
    	Test.startTest();
		UTIL_SFSObjectDoc.getOrderNumber(null);
		Test.stopTest();
    }

    @isTest
    static void test_getContractNumber()
    {
    	Test.startTest();
		UTIL_SFSObjectDoc.getContractNumber(null);
		Test.stopTest();
    }

    @isTest
    static void test_getStatus()
    {
    	Test.startTest();
		UTIL_SFSObjectDoc.getStatus(null);
		Test.stopTest();
    }

    @isTest
    static void test_getOpportunity()
    {
    	Test.startTest();
		UTIL_SFSObjectDoc.getOpportunityId(null);
		UTIL_SFSObjectDoc.getOpportunity(null);
		Test.stopTest();
    }

    @isTest
    static void test_getPriceBookId()
    {
    	Test.startTest();
		UTIL_SFSObjectDoc.getPriceBookId(null);
		Test.stopTest();
    }

    @isTest
    static void test_getProductId()
    {
    	Test.startTest();
        SObject testSObject = createTestObjects();
		UTIL_SFSObjectDoc.getProductId(testSObject, null);
		Test.stopTest();
    }

    @isTest
    static void test_getMaterial()
    {
    	Test.startTest();
        SObject testSObject = createTestObjects();
		UTIL_SFSObjectDoc.getMaterial(testSObject, null);
		Test.stopTest();
    }

    @isTest
    static void test_getItemNumber()
    {
    	Test.startTest();
        SObject testSObject = createTestObjects();
		UTIL_SFSObjectDoc.getItemNumber(testSObject, null);
		Test.stopTest();
    }

    @isTest
    static void test_loadProductSAPMaterialNumberList()
    {
    	Test.startTest();
        SObject testSObject = createTestObjects();
		UTIL_SFSObjectDoc.loadProductSAPMaterialNumberList(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_validateSAPWithSfsObject()
    {
        Test.startTest();
        SObject testSObject = createTestObjects();
        UTIL_SFSObjectDoc.validateSAPWithSfsObject('', testSObject);
        Test.stopTest();
    }

    @isTest
    static void test_initializeQuoteFromSfSObject()
    {
    	Test.startTest();
        SObject testSObject = createTestObjects();
		UTIL_SFSObjectDoc.initializeQuoteFromSfSObject('', testSObject, new SBO_EnosixQuote_Detail.EnosixQuote(), 
            new Map<String, UTIL_SFSObjectDoc.SfSObjectItem>(), new Map<String, UTIL_Quote.QuoteLineValue>(), 10);
		Test.stopTest();
    }

    @isTest
    static void test_updateQuotePricingFromSfsObject()
    {
    	Test.startTest();
        SObject testSObject = createTestObjects();
		UTIL_SFSObjectDoc.updateQuotePricingFromSfsObject('', testSObject, new SBO_EnosixQuote_Detail.EnosixQuote(), new Map<String, UTIL_SFSObjectDoc.SfSObjectItem>());
		UTIL_SFSObjectDoc.updateQuotePricingFromSfsObject('', null, new SBO_EnosixQuote_Detail.EnosixQuote(), new Map<String, UTIL_SFSObjectDoc.SfSObjectItem>());
		Test.stopTest();
    }

    @isTest
    static void test_finalizeQuoteAndUpdateSfsObject()
    {
    	Test.startTest();
        SObject testSObject = createTestObjects();
		UTIL_SFSObjectDoc.finalizeQuoteAndUpdateSfsObject('', testSObject, new SBO_EnosixQuote_Detail.EnosixQuote(), 
            new Map<String, UTIL_SFSObjectDoc.SfSObjectItem>(), UTIL_Pricebook.getStandardPriceBookId(), 
            new List<SBO_EnosixQuote_Detail.ITEMS>(), new Map<string, Id>(), new Map<Id, PricebookEntry>());
		Test.stopTest();
    }

    @isTest
    static void test_initializeOrderFromSfSObject()
    {
    	Test.startTest();
        SObject testSObject = createTestObjects();
		UTIL_SFSObjectDoc.initializeOrderFromSfSObject('', testSObject, new SBO_EnosixSO_Detail.EnosixSO(), 
            new Map<String, UTIL_SFSObjectDoc.SfSObjectItem>(), new Map<String, UTIL_Order.OrderLineValue>(), 10);
		Test.stopTest();
    }

    @isTest
    static void test_updateOrderPricingFromSfsObject()
    {
    	Test.startTest();
        SObject testSObject = createTestObjects();
		UTIL_SFSObjectDoc.updateOrderPricingFromSfsObject('', testSObject, new SBO_EnosixSO_Detail.EnosixSO(), new Map<String, UTIL_SFSObjectDoc.SfSObjectItem>());
		UTIL_SFSObjectDoc.updateOrderPricingFromSfsObject('', null, new SBO_EnosixSO_Detail.EnosixSO(), new Map<String, UTIL_SFSObjectDoc.SfSObjectItem>());
		Test.stopTest();
    }

    @isTest
    static void test_finalizeOrderAndUpdateSfsObject()
    {
    	Test.startTest();
        SObject testSObject = createTestObjects();
		UTIL_SFSObjectDoc.finalizeOrderAndUpdateSfsObject('', testSObject, new SBO_EnosixSO_Detail.EnosixSO(), 
            new Map<String, UTIL_SFSObjectDoc.SfSObjectItem>(), UTIL_Pricebook.getStandardPriceBookId(), 
            new List<SBO_EnosixSO_Detail.ITEMS>(), new Map<string, Id>(), new Map<Id, PricebookEntry>());
		Test.stopTest();
    }

    @isTest
    static void test_sObjectToSalesDocMapping()
    {
    	Test.startTest();
        SObject testSObject = createTestObjects();
		UTIL_SFSObjectDoc.sObjectToSalesDocMapping(testSObject, new List<SObject>(), new DS_Document_Detail(), new DS_SalesDocAppSettings());
		UTIL_SFSObjectDoc.sObjectToSalesDocMapping(null, new List<SObject>(), new DS_Document_Detail(), new DS_SalesDocAppSettings());
		Test.stopTest();
    }

    @isTest
    static void test_salesDocMappingToSObject()
    {
    	Test.startTest();
        SObject testSObject = createTestObjects();
		UTIL_SFSObjectDoc.salesDocMappingToSObject(testSObject, new DS_Document_Detail(), '');
		UTIL_SFSObjectDoc.salesDocMappingToSObject(null, new DS_Document_Detail(), '');
		Test.stopTest();
    }

    @isTest
    static void test_salesDocLineItemMappingToSObject()
    {
    	Test.startTest();
        SObject testSObject = createTestObjects();
		UTIL_SFSObjectDoc.salesDocLineItemMappingToSObject(testSObject, new DS_Document_Detail.ITEMS(), new PricebookEntry(), null, null);
		UTIL_SFSObjectDoc.salesDocLineItemMappingToSObject(null, new DS_Document_Detail.ITEMS(), new PricebookEntry(), null, null);
		Test.stopTest();
    }

    private static Opportunity createTestObjects()
    {
        Account testAccount = TSTU_SFTestObject.createTestAccount();
        testAccount.Name = 'test';
        TSTU_SFTestObject.upsertWithRetry(testAccount);

        Id pricebookId = UTIL_Pricebook.getStandardPriceBookId();
        Opportunity opp = TSTU_SFTestObject.createTestOpportunity();
        opp.Name = 'TEST OPP';
        opp.CloseDate = Date.today();
        opp.StageName = 'IsWon';
        opp.AccountId = testAccount.Id;
        opp.Pricebook2Id = pricebookId;
        opp.put(UTIL_SFOpportunity.OrderFieldName, 'SAPOppO');
        opp.put(UTIL_SFOpportunity.QuoteFieldName, 'SAPOppQ');
        TSTU_SFTestObject.upsertWithRetry(opp);
        opp = [SELECT Id, Pricebook2Id FROM Opportunity WHERE Id = :opp.Id];
        opp.Pricebook2Id = pricebookId;
        TSTU_SFTestObject.upsertWithRetry(opp);

        Product2 prod = TSTU_SFTestObject.createTestProduct2();
        prod.Name = 'New Product';
        prod.IsActive = true;
        TSTU_SFTestObject.upsertWithRetry(prod);

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
        return opp;
    }
}
