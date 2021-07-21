/*
* Test cases for Order utility class
*/
@isTest 
public class TSTU_SFOrder
{
    @isTest
    public static void test_getSObject()
    {
        SObject testSObject = createTestObjects();

        Test.startTest();
        UTIL_SFOrder utility = new UTIL_SFOrder();
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
        UTIL_SFOrder utility = new UTIL_SFOrder();
        SObject testSObject = createTestObjects();
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
        UTIL_SFOrder utility = new UTIL_SFOrder();
        SObject testSObject = createTestObjects();
		utility.getSObjectContacts(null);
		Test.stopTest();
    }

    @isTest
    static void test_getAccountId()
    {
    	Test.startTest();
        UTIL_SFOrder utility = new UTIL_SFOrder();
        SObject testSObject = createTestObjects();
		utility.getAccountId(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getCustomerNumber()
    {
    	Test.startTest();
        UTIL_SFOrder utility = new UTIL_SFOrder();
        SObject testSObject = createTestObjects();
		utility.getCustomerNumber(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getName()
    {
    	Test.startTest();
        UTIL_SFOrder utility = new UTIL_SFOrder();
        SObject testSObject = createTestObjects();
		utility.getName(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getQuoteNumber()
    {
    	Test.startTest();
        UTIL_SFOrder utility = new UTIL_SFOrder();
        SObject testSObject = createTestObjects();
		utility.getQuoteNumber(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getOrderNumber()
    {
    	Test.startTest();
        UTIL_SFOrder utility = new UTIL_SFOrder();
        SObject testSObject = createTestObjects();
		utility.getOrderNumber(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getContractNumber()
    {
    	Test.startTest();
        UTIL_SFOrder utility = new UTIL_SFOrder();
        SObject testSObject = createTestObjects();
		utility.getContractNumber(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getInquiryNumber()
    {
    	Test.startTest();
        UTIL_SFOrder utility = new UTIL_SFOrder();
        SObject testSObject = createTestObjects();
		utility.getInquiryNumber(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getCreditMemoNumber()
    {
    	Test.startTest();
        UTIL_SFOrder utility = new UTIL_SFOrder();
        SObject testSObject = createTestObjects();
		utility.getCreditMemoNumber(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getDebitMemoNumber()
    {
    	Test.startTest();
        UTIL_SFOrder utility = new UTIL_SFOrder();
        SObject testSObject = createTestObjects();
		utility.getDebitMemoNumber(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getReturnOrderNumber()
    {
    	Test.startTest();
        UTIL_SFOrder utility = new UTIL_SFOrder();
        SObject testSObject = createTestObjects();
		utility.getReturnOrderNumber(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getStatus()
    {
    	Test.startTest();
        UTIL_SFOrder utility = new UTIL_SFOrder();
        SObject testSObject = createTestObjects();
		utility.getStatus(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getOpportunityId()
    {
    	Test.startTest();
        UTIL_SFOrder utility = new UTIL_SFOrder();
        SObject testSObject = createTestObjects();
		utility.getOpportunityId(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getPriceBookId()
    {
    	Test.startTest();
        UTIL_SFOrder utility = new UTIL_SFOrder();
        SObject testSObject = createTestObjects();
		utility.getPriceBookId(null);
		utility.getPriceBookId(testSObject);
		Test.stopTest();
    }

    @isTest
    static void test_getProductId()
    {
    	Test.startTest();
        UTIL_SFOrder utility = new UTIL_SFOrder();
		utility.getProductId(null);
		Test.stopTest();
    }

    @isTest
    static void test_getMaterial()
    {
    	Test.startTest();
        SObject testSObject = createTestObjects();
        UTIL_SFOrder utility = new UTIL_SFOrder();
		utility.getMaterial(testSObject, null);
		Test.stopTest();
    }

    @isTest
    static void test_getItemNumber()
    {
    	Test.startTest();
        UTIL_SFOrder utility = new UTIL_SFOrder();
		utility.getItemNumber(null);
		Test.stopTest();
    }

    @isTest
    static void test_validateSAPWithSfsObject()
    {
        Test.startTest();
        UTIL_SFOrder utility = new UTIL_SFOrder();
        SObject testSObject = createTestObjects();
        utility.validateSAPWithSfsObject('', testSObject);
        Test.stopTest();
    }

    @isTest
    static void test_sObjectToSalesDocMapping()
    {
        UTIL_SFOrder utility = new UTIL_SFOrder();
        SObject testSObject = createTestObjects();
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
        UTIL_SFOrder utility = new UTIL_SFOrder();
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
        UTIL_SFOrder utility = new UTIL_SFOrder();
        SObject testSObject = createTestObjects();
        DS_Document_Detail salesDocDetail = new DS_Document_Detail();
        salesDocDetail.SalesDocument = 'SalesDocument';
        SObject lineItem = null;
		lineItem = utility.salesDocLineItemMappingToSObject(testSObject, new DS_Document_Detail.ITEMS(), new PricebookEntry(), null, lineItem);
		lineItem = utility.salesDocLineItemMappingToSObject(testSObject, new DS_Document_Detail.ITEMS(), new PricebookEntry(), null, lineItem);
		Test.stopTest();
    }

    private static Order createTestObjects()
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

        Order order = TSTU_SFOrder.createTestOrder(opp);
        order.Name = 'TEST ORDER';
        order.OpportunityId = opp.Id;
        order.Pricebook2Id = pricebookId;
        order.EffectiveDate = Date.today();
        order.Status = 'Draft';
        TSTU_SFTestObject.upsertWithRetry(order);
        order = [SELECT Id, Pricebook2Id FROM Order WHERE Id = :order.Id];
        order.Pricebook2Id = pricebookId;
        TSTU_SFTestObject.upsertWithRetry(order);

        UTIL_SFOrder utility = new UTIL_SFOrder();
        return (Order) utility.getSObject(order.Id);
    }

    private static SObject createTestObjectLines()
    {
        OrderItem orderItem = TSTU_SFOrder.createTestOrderItem();
		orderItem.Quantity = 10;
		orderItem.UnitPrice = .95;
		orderItem.Description = 'test Desciption';
        orderItem.FLD_SAP_Item_Number__c = '000010';
        return orderItem;
    }

    public static Order createTestOrder(Opportunity opp)
    {
        Account acct = TSTU_SFTestObject.createTestAccount();
        if (String.isNotEmpty(opp.AccountId)) acct.Id = opp.AccountId;
        TSTU_SFTestObject.upsertWithRetry(acct);

        Order order = new Order();
        order.AccountId = acct.Id;
        order.Status = 'Draft';
        order.Name = 'TestOrder';
        order.EffectiveDate = Date.today();
        return order;
    }

    public static OrderItem createTestOrderItem() {
        OrderItem opportunityLineItemObj = new OrderItem();
        return opportunityLineItemObj;
    }
}
