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
    static void test_getInquiryNumber()
    {
        Test.startTest();
        UTIL_SFSObjectDoc.getInquiryNumber(null);
        Test.stopTest();
    }

    @isTest
    static void test_getCreditMemoNumber()
    {
        Test.startTest();
        UTIL_SFSObjectDoc.getCreditMemoNumber(null);
        Test.stopTest();
    }

    @isTest
    static void test_getDebitMemoNumber()
    {
        Test.startTest();
        UTIL_SFSObjectDoc.getDebitMemoNumber(null);
        Test.stopTest();
    }

    @isTest
    static void test_getReturnOrderNumber()
    {
        Test.startTest();
        UTIL_SFSObjectDoc.getReturnOrderNumber(null);
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
    static void test_getOpportunityId()
    {
        Test.startTest();
        UTIL_SFSObjectDoc.getOpportunityId(null);
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
    static void test_validateSAPWithSfsObject()
    {
        Test.startTest();
        SObject testSObject = createTestObjects();
        UTIL_SFSObjectDoc.validateSAPWithSfsObject('', testSObject);
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
        return opp;
    }
}
