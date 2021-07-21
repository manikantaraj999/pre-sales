@isTest public with sharing class TSTU_SObject
{
     @isTest
    static void test_getSObjectNameFromId()
    {
        Case tstCase = TSTU_SFTestObject.createTestCase();
        TSTU_SFTestObject.upsertWithRetry(tstCase);

        Test.startTest();
        String sObjName = UTIL_SObject.getSObjectNameFromId(null);
        sObjName = UTIL_SObject.getSObjectNameFromId(tstCase.Id);
        Test.stopTest();

        System.assertEquals(sObjName, 'Case');

    }

    @isTest
    static void test_getSObjectById()
    {
        Account testAcct = TSTU_SFTestObject.createTestAccount();
        testAcct.put(UTIL_SFAccount.CustomerFieldName, 'TEST');
        TSTU_SFTestObject.upsertWithRetry(testAcct);

        List<String> fields = new List<String>();
        fields.add('Name');

        Test.startTest();

        SObject getObj = UTIL_SObject.getSObjectById(testAcct.Id, fields);
        
        Account getAcct = (Account)getObj;

        Test.stopTest();

        System.assertEquals(testAcct.Name,getAcct.Name);

    }


    @isTest
    static void test_isSobjectLinkedToCustomer()
    {
        Account testAcct = TSTU_SFTestObject.createTestAccount();
        TSTU_SFTestObject.upsertWithRetry(testAcct);

        Test.startTest();
        Boolean result1 = UTIL_SObject.isSObjectLinkedToCustomer(testAcct.Id);
        UTIL_SObject.setCustomerNumberOnSObject(testAcct.Id, 'customerNumber');
        UTIL_SObject.getValueFromSObjectField(null, null, null);
        UTIL_SObject.getValueFromSObjectField(testAcct, 'Bad Field', '');
        Test.stopTest();

        System.assertEquals(result1, false);
    }

    @isTest
    static void test_isSobjectLinkedToCustomer2()
    {
        Account testAcct = TSTU_SFTestObject.createTestAccount();
        testAcct.put(UTIL_SFAccount.CustomerFieldName, 'TEST');
        TSTU_SFTestObject.upsertWithRetry(testAcct);

        Test.startTest();
        Boolean result2 = UTIL_SObject.isSObjectLinkedToCustomer(testAcct.Id);
        Test.stopTest();

        System.assertEquals(result2, true);
    }

    @isTest
    static void test_booleanCalls()
    {
        Test.startTest();
        Id testId = Id.valueOf('001xa000003DIlo');

        Boolean custMapping = UTIL_SObject.doesSObjectHaveCustomerMapping(testId);
        Boolean userAccess = UTIL_SObject.canUserAccessSObjectCustomerNumber(testId);
        Boolean custNumber = UTIL_SObject.canUserSetSObjectCustomerNumber(testId);
        UTIL_SObject.getCustomerNumberFieldfromSObject(new Account());
        Boolean userAccessField = UTIL_SObject.canUserAccessSObjectField(testId, 'Name');
        Test.stopTest();

        System.Assert(custMapping == true);
        System.Assert(userAccess == true);
        System.Assert(custNumber == true);
        System.Assert(userAccessField == true);
    }
}