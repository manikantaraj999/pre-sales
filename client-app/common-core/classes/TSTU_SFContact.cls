
@IsTest
private class TSTU_SFContact
{
    @isTest
    static void test_getContactFromId()
    {
        Test.startTest();
        Contact contact = TSTU_SFTestObject.createTestContact(null);
        TSTU_SFTestObject.upsertWithRetry(contact);
        Contact fetched = UTIL_SFContact.getContactFromId(contact.Id);
        System.assertEquals(contact.LastName, fetched.LastName);
        System.assertEquals(contact.Id, fetched.Id);
        Account acct = TSTU_SFTestObject.createTestAccount();
        TSTU_SFTestObject.upsertWithRetry(acct);
        UTIL_SFContact.getContactFromId(acct.Id);
        Test.stopTest();
    }

    @isTest
    static void test_getContactNumberFromContact()
    {
        Test.startTest();
        Contact contact = TSTU_SFTestObject.createTestContact(null);
        TSTU_SFTestObject.upsertWithRetry(contact);
        String testContactNumber = 'TestContact';
        UTIL_SFContact.setContactContactNumber(contact, testContactNumber);
        System.assertEquals(UTIL_SFContact.getContactNumberFromContact(contact), testContactNumber);
        String ContactCustomerFieldName = UTIL_SFContact.ContactCustomerFieldName;
        Test.stopTest();
    }
}
