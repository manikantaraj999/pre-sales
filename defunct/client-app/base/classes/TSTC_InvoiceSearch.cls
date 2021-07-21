@isTest
private class TSTC_InvoiceSearch
{

    class MOC_getSalesAreaMaster implements ensxsdk.EnosixFramework.RFCMock
    {
        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            RFC_SD_GET_SALES_AREAS.RESULT result = new RFC_SD_GET_SALES_AREAS.RESULT();
            result.setSuccess(false);
            return result;
        }
    }

    @isTest 
    static void tesInvoiceSearchSuccess()
    {
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_SALES_AREAS.class, new MOC_getSalesAreaMaster());
        ensxsdk.EnosixFramework.setMock(SBO_EnosixInvoice_Search.class, new MOC_EnosixInvoice_Search.MockEnosixInvoiceSuccess());

        Account account = TSTU_SFTestObject.createTestAccount();
        account.Name = 'uniqueaccountname';
        account.BillingCountry = 'United States';
        // account.BillingCountryCode = 'US';
        UTIL_SFAccount.setAccountCustomerNumber(account, 'test');
        TSTU_SFTestObject.upsertWithRetry(account);

        System.currentPageReference().getParameters().put('customerid',String.valueOf(account.Id));
        UTIL_PageState.current.sfAccountId = account.Id;

        Test.startTest();
        CTRL_InvoiceSearch invList = new CTRL_InvoiceSearch();
        invList.searchInvoice();
        system.assertEquals(System.currentPageReference().getParameters().get('customerid'),  String.valueOf(account.Id));
        invList.searchInvoice();
        Boolean isClassic = invList.isClassic;
        List<SelectOption> salesOrganizations = invList.SalesOrganizations;
        I_SearchController searchController = invList.searchController;
        Pagereference goToInvoiceSearch = invList.goToInvoiceDetail();
        Test.stopTest();
	}

    @isTest 
    static void tesInvoiceSearchFailure()
    {
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_SALES_AREAS.class, new MOC_getSalesAreaMaster());
        ensxsdk.EnosixFramework.setMock(SBO_EnosixInvoice_Search.class, new MOC_EnosixInvoice_Search.MockEnosixInvoiceFailure());

        Account account = TSTU_SFTestObject.createTestAccount();
        account.Name = 'uniqueaccountname';
        account.BillingCountry = 'United States';
        // account.BillingCountryCode = 'US';
        UTIL_SFAccount.setAccountCustomerNumber(account, 'test');
        TSTU_SFTestObject.upsertWithRetry(account);

        System.currentPageReference().getParameters().put('customerid',String.valueOf(account.Id));
        UTIL_PageState.current.sfAccountId = account.Id;

        Test.startTest();
        CTRL_InvoiceSearch invList = new CTRL_InvoiceSearch();
        invList.searchInvoice();
        Test.stopTest();
	}
}