@isTest
public with sharing class TSTU_ObjectLookups
{
    public class MOC_EnosixCustomer_Detail implements ensxsdk.EnosixFramework.DetailSBOGetMock
    {
        public ensxsdk.EnosixFramework.DetailObject executeGetDetail(object key)
        {
            SBO_EnosixCustomer_Detail.EnosixCustomer result = new SBO_EnosixCustomer_Detail.EnosixCustomer();
            result.setSuccess(false);
            return result;
        }
    }

    public class MOC_EnosixMaterial_Detail implements ensxsdk.EnosixFramework.DetailSBOGetMock
    {
        public ensxsdk.EnosixFramework.DetailObject executeGetDetail(object key)
        {
            SBO_EnosixMaterial_Detail.EnosixMaterial result = new SBO_EnosixMaterial_Detail.EnosixMaterial();
            result.setSuccess(false);
            return result;
        }
    }

    private static Case createTestCase()
    {
        Case testCase = TSTU_SFTestObject.createTestCase();
        TSTU_SFTestObject.upsertWithRetry(testCase);
        return testCase;
    }

    private static Opportunity createTestOpp()
    {
        Account testAccount = TSTU_SFTestObject.createTestAccount();
        testAccount.Name = 'test';
        TSTU_SFTestObject.upsertWithRetry(testAccount);

        Opportunity testOpportunity = TSTU_SFTestObject.createTestOpportunity();
        testOpportunity.Name = 'test';
        testOpportunity.StageName = 'test';
        testOpportunity.CloseDate = DateTime.Now().Date();
        testOpportunity.AccountId = testAccount.Id;
        testOpportunity.put(UTIL_SFOpportunity.OrderFieldName, 'SAPOppO');
        testOpportunity.put(UTIL_SFOpportunity.QuoteFieldName, 'SAPOppQ');

        Id priceBookId = TSTU_SFTestObject.createTestPriceBook2();
        testOpportunity.Pricebook2Id = priceBookId;
        TSTU_SFTestObject.upsertWithRetry(testOpportunity);
        return testOpportunity;
    }

    @isTest
    public static void test_getCaseById()
    {
        Case testCase = createTestCase();

        Test.startTest();
        Case result = UTIL_ObjectLookups.getCaseById('bad Id');
        result = UTIL_ObjectLookups.getCaseById(testCase.Id);
        Test.stopTest();
    }

    @isTest
    public static void test_getCustomerForCase()
    {
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustomer_Detail.class, new MOC_EnosixCustomer_Detail());

        Account testAccount = TSTU_SFTestObject.createTestAccount();
        testAccount.Name = 'test';
        TSTU_SFTestObject.upsertWithRetry(testAccount);

        Case testCase = createTestCase();
        testCase.AccountId = testAccount.Id;

        Test.startTest();
        SBO_EnosixCustomer_Detail.EnosixCustomer cust = UTIL_ObjectLookups.GetCustomerForCase(testCase);

        testAccount.put(UTIL_SFAccount.CustomerFieldName,'test');
        TSTU_SFTestObject.upsertWithRetry(testAccount);
        cust = UTIL_ObjectLookups.GetCustomerForCase(testCase);
        Test.stopTest();
    }

    @isTest
    public static void test_getContactById()
    {
        Opportunity testOpportunity = createTestOpp();

        Test.startTest();
        Contact contact = UTIL_ObjectLookups.getContactById(testOpportunity.Id);
        Test.stopTest();
    }
}