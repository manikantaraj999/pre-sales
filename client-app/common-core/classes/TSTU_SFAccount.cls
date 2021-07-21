
@IsTest
private class TSTU_SFAccount
{
    @isTest
    static void test_CustomerFieldNameAccessException()
    {
        Test.startTest();
        UTIL_SFAccount.CustomerFieldNameAccessException acctExcep = new UTIL_SFAccount.CustomerFieldNameAccessException();
        String message = acctExcep.getMessage();
        Test.stopTest();
    }

    @isTest
    static void test_getAccountFromId()
    {
        Test.startTest();
        Account acct = TSTU_SFTestObject.createTestAccount();
        TSTU_SFTestObject.upsertWithRetry(acct);
        Account fetched = UTIL_SFAccount.getAccountById('Bad Id');
        fetched = UTIL_SFAccount.getAccountById(acct.Id);
        fetched = UTIL_SFAccount.getAccountById(acct.Id, new List<String>{'name'});
        System.assertEquals(acct.Name, fetched.Name);
        System.assertEquals(acct.Id, fetched.Id);
        UTIL_SFAccount.isAccountLinkedToCustomer(acct);
        UTIL_SFAccount.isAccountLinkedToCustomer(acct.Id);
        UTIL_SFAccount.getValueFromAccountField(acct, '', 'warningMessageFormat');
        UTIL_SFAccount.getValueFromAccountField(acct, 'Bad Field', 'warningMessageFormat');
        UTIL_SFAccount.getValueFromAccountField(acct, 'Name', 'warningMessageFormat');
        acct.Name = null;
        UTIL_SFAccount.getValueFromAccountField(acct, 'Name', 'warningMessageFormat');
        Test.stopTest();
    }

    @isTest
    static void test_getAccountByCustomerNumber()
    {
        Test.startTest();
        Account acct = TSTU_SFTestObject.createTestAccount();
        acct.put(UTIL_SFAccount.CustomerFieldName,'CustomerFieldName');
        TSTU_SFTestObject.upsertWithRetry(acct);
        Account fetched = UTIL_SFAccount.getAccountByCustomerNumber('CustomerFieldName');
        fetched = UTIL_SFAccount.getAccountByCustomerNumber('CustomerFieldName', new List<String>{'name'});
        System.assertEquals(acct.Name, fetched.Name);
        System.assertEquals(acct.Id, fetched.Id);
        Test.stopTest();
    }

    @isTest
    static void test_getCustomerNumberFromAccount()
    {
        Test.startTest();
        Account acct = TSTU_SFTestObject.createTestAccount();
        TSTU_SFTestObject.upsertWithRetry(acct);
        String testCustNumber = 'TESTCUST';
        UTIL_SFAccount.setAccountCustomerNumber(acct, testCustNumber);
        System.assertEquals(UTIL_SFAccount.getCustomerNumberFromAccount(acct), testCustNumber);
        Test.stopTest();
    }
}
