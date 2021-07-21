/**
 * test class for Customer Detail Controller
 */
@isTest
public with sharing class TSTC_CustomerDetail
{
    public class MOC_SBO_EnosixCustomer_Detail implements ensxsdk.EnosixFramework.DetailSBOGetMock,
            ensxsdk.EnosixFramework.DetailSBOSaveMock, ensxsdk.EnosixFramework.DetailSBOInitMock, ensxsdk.EnosixFramework.DetailSBOCommandMock
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

        public ensxsdk.EnosixFramework.DetailObject executeSave(ensxsdk.EnosixFramework.DetailObject obj)
        {
            SBO_EnosixCustomer_Detail.EnosixCustomer result = (SBO_EnosixCustomer_Detail.EnosixCustomer) obj;
            result.setSuccess(this.success);
            if (throwException)
            {
                throw new CalloutException();
            }
            return result;
        }

        public ensxsdk.EnosixFramework.DetailObject executeCommand(string command, ensxsdk.EnosixFramework.DetailObject obj)
        {
            SBO_EnosixCustomer_Detail.EnosixCustomer result = (SBO_EnosixCustomer_Detail.EnosixCustomer) obj;
            result.setSuccess(this.success);
            if (throwException)
            {
                throw new CalloutException();
            }
            return result;
        }

        public ensxsdk.EnosixFramework.DetailObject executeInitialize(ensxsdk.EnosixFramework.DetailObject  initialState)
        {
            SBO_EnosixCustomer_Detail.EnosixCustomer result = new SBO_EnosixCustomer_Detail.EnosixCustomer();
            result.setSuccess(this.success);
            return result;
        }
    }

    static testMethod void test_CTRL_CustomerDetail_constructor()
    {
        MOC_SBO_EnosixCustomer_Detail mocEnosixCustomerDetail = new MOC_SBO_EnosixCustomer_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustomer_Detail.class, mocEnosixCustomerDetail);
    	Test.startTest();
        CTRL_CustomerDetail detail = new CTRL_CustomerDetail();
        UTIL_PageState.current.sfCaseId = 'caseId';
        CTRL_CustomerDetail controller = new CTRL_CustomerDetail();
        UTIL_PageState.current.sfCaseId = null;
        UTIL_PageState.current.sfAccountId = 'accountId';
        UTIL_PageState.current.sapCustomerId = 'customerId';
        controller = new CTRL_CustomerDetail();
        UTIL_PageState.current.sfAccountId = null;
        Account account = TSTU_SFTestObject.createTestAccount();
        account.Name = 'Name';
        account.put(UTIL_SFAccount.CustomerFieldName,'customerId');
        TSTU_SFTestObject.upsertWithRetry(account);
        controller = new CTRL_CustomerDetail();
        controller.GoToCreateCustomer();
        controller.actionAddShipTo();
        controller.updateSAPCustomer();
        controller.gotoCustomerPage();
        Boolean isFrom = controller.isFromOrder;
        isFrom = controller.isFromQuote;
        isFrom = controller.isFromOpp;
        controller.redirectToOrderPage();
        controller.redirectToQuotePage();
        controller.redirectToOppPage();
        controller.GoToCustomerLinkPage();
        Boolean isClassic = controller.isClassic;
        Test.stopTest();
    }

    @isTest static void test_refreshIdsFromAccount()
    {
        // Insert test data
        Account a1 = TSTU_SFTestObject.createTestAccount();
        a1.Name = 'Mock Account';
        TSTU_SFTestObject.upsertWithRetry(a1);

        Account a2 = TSTU_SFTestObject.createTestAccount();
        a2.Name = 'Mock Account2';
        UTIL_SFAccount.setAccountCustomerNumber(a2, 'CUSTID');
        TSTU_SFTestObject.upsertWithRetry(a2);

        UTIL_PageState.current.sfAccountId = a1.Id;
        CTRL_CustomerDetail controller = new CTRL_CustomerDetail();
        System.assert(controller.accountid == a1.Id);

        Test.startTest();

        // null does nothing
        controller.refreshIdsFromAccount(null);
        System.assert(controller.accountid == a1.Id);

        // This should update accountid and customerid properties on controller
        controller.refreshIdsFromAccount(a2);

        Test.stopTest();

        System.assert(controller.accountid == a2.Id);
        System.assert(controller.customerid == UTIL_SFAccount.getCustomerNumberFromAccount(a2));
    }

    @isTest static void testFormattedPhone()
    {
        SBO_EnosixCustomer_Detail.EnosixCustomer customer = new SBO_EnosixCustomer_Detail.EnosixCustomer();
        customer.TelephoneNumber = '1234567890';
        customer.TelephoneNumberExtension = '123';

        CTRL_CustomerDetail controller = new CTRL_CustomerDetail();
        controller.cDetail = customer;

        System.assertEquals(controller.FormattedPhone,'1234567890 x123');

    }

    @isTest static void testFormattedFax()
    {
        SBO_EnosixCustomer_Detail.EnosixCustomer customer = new SBO_EnosixCustomer_Detail.EnosixCustomer();
        customer.FaxNumber = '1234567890';
        customer.FaxNumberExtension = '123';

        CTRL_CustomerDetail controller = new CTRL_CustomerDetail();
        controller.cDetail = customer;

        System.assertEquals(controller.FormattedFax,'1234567890 x123');
    }

    @isTest static void testScreenVariables()
    {
        MOC_SBO_EnosixCustomer_Detail mocEnosixCustomerDetail = new MOC_SBO_EnosixCustomer_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustomer_Detail.class, mocEnosixCustomerDetail);
        UTIL_PageState.current.sfAccountId = null;
        UTIL_PageState.current.sapCustomerId = 'customerId';
        Account account = TSTU_SFTestObject.createTestAccount();
        account.Name = 'Name';
        account.put(UTIL_SFAccount.CustomerFieldName,'customerId');
        TSTU_SFTestObject.upsertWithRetry(account);
        CTRL_CustomerDetail controller = new CTRL_CustomerDetail();
        boolean showComapnyInfo = controller.showCompanyInfo;
        boolean showSalesAreas = controller.showSalesAreas;
        boolean hasAccount = controller.hasAccount;
        set<String> shipToParentPartnerTypes = controller.shipToParentPartnerTypes;
        List<SBO_EnosixCustomer_Detail.COMPANY_DATA> CompanyList = controller.CompanyList;
        List<SBO_EnosixCustomer_Detail.SALES_DATA> SalesAreaList = controller.SalesAreaList;
        List<SBO_EnosixCustomer_Detail.CREDIT> CreditList = controller.CreditList;
    }
}