@isTest
public with sharing class TSTC_ContactList
{
    public class MOC_SBO_EnosixCustomer_Detail implements ensxsdk.EnosixFramework.DetailSBOGetMock
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

        public ensxsdk.EnosixFramework.DetailObject executeGetDetail(object key)
        {
            SBO_EnosixCustomer_Detail.EnosixCustomer result = new SBO_EnosixCustomer_Detail.EnosixCustomer();
            result.setSuccess(this.success);
            return result;
        }
    }

    @isTest
    public static void test_ContactList()
    {
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustomer_Detail.class, new MOC_SBO_EnosixCustomer_Detail());
        Account acct = TSTU_SFTestObject.createTestAccount();
        acct.Name = 'Test';
        acct.put(UTIL_SFAccount.CustomerFieldName, '1234');
        TSTU_SFTestObject.upsertWithRetry(acct);

        UTIL_PageState.current.sfAccountId = acct.Id;
        Test.startTest();
        CTRL_ContactList controller = new CTRL_ContactList();
        List<SBO_EnosixCustomer_Detail.CONTACTS> contacts = controller.contacts;
        PageReference createNewConactPage = controller.actionAddNewContact();
        Boolean hasAccount = controller.hasAccount;
        acct.put(UTIL_SFAccount.CustomerFieldName, '');
        TSTU_SFTestObject.upsertWithRetry(acct);
        controller = new CTRL_ContactList();
        Boolean isClassic = controller.isClassic;
        Test.stopTest();
    }
}