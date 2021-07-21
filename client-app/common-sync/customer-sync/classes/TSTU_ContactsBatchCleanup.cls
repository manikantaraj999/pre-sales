@isTest
public with sharing class TSTU_ContactsBatchCleanup
{
    public static testMethod void test_ContactCleanup()
    {
        Database.executeBatch(new UTIL_ContactsBatchCleanup());
        createExistingContactAndAccount();
        Test.startTest();
        Database.executeBatch(new UTIL_ContactsBatchCleanup());
        Test.stopTest();
    }

    public static testMethod void test_BadId_ContactCleanup()
    {
        UTIL_ContactsBatchCleanup cleanup = new UTIL_ContactsBatchCleanup();
        UTIL_ContactsBatchCleanup.CleanupObjectList = new List<UTIL_SyncHelper.CleanupObject> {
            new UTIL_SyncHelper.CleanupObject('Bad Object Name', UTIL_SFAccount.CustomerFieldName, 'BadNotFoundFieldId',
                new List<UTIL_SyncHelper.CleanupField> {
                    new UTIL_SyncHelper.CleanupField(UTIL_SFContact.ContactCustomerFieldName, 'BadId')
                }
            )
        };
        Database.executeBatch(cleanup);
        createExistingContactAndAccount();
        Test.startTest();
    }

    public static testMethod void test_getRecordCount()
    {
        Test.startTest();
        UTIL_ContactsBatchCleanup.getTotalRecordCount();
        Test.stopTest();
    }

    private static void createExistingContactAndAccount()
    {
        Account acct = TSTU_SFTestObject.createTestAccount();
        acct.put(UTIL_SFAccount.CustomerFieldName, '12345');
        TSTU_SFTestObject.upsertWithRetry(acct);

        Contact contact = TSTU_SFTestObject.createTestContact(null);
        contact.put(UTIL_SFContact.ContactCustomerFieldName, '12345');
        TSTU_SFTestObject.upsertWithRetry(contact);
    }
}
