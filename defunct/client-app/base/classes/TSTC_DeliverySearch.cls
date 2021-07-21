/**
 * test class for Delivery Inquiry Controllers
 */
@isTest
private class TSTC_DeliverySearch
{
	@isTest 
    static void testDeliveryListSuccess()
	{
		ensxsdk.EnosixFramework.setMock(SBO_EnosixDL_Search.class, new MOC_EnosixDL_Search.MockEnosixDLSuccess());
        Account account = TSTU_SFTestObject.createTestAccount();
        account.Name = 'uniqueaccountname';
        account.BillingCountry = 'United States';
        // account.BillingCountryCode = 'US';
        UTIL_SFAccount.setAccountCustomerNumber(account, 'test');
        TSTU_SFTestObject.upsertWithRetry(account);

        UTIL_PageState.current.sfAccountId = String.valueOf(account.Id);

        Test.startTest();
        CTRL_DeliverySearch dllist = new CTRL_DeliverySearch();
        dllist.searchDL();
		Boolean isClassic = dllist.isClassic;
        Test.stopTest();
	}

	@isTest 
    static void testDeliveryListFailure()
	{
		ensxsdk.EnosixFramework.setMock(SBO_EnosixDL_Search.class, new MOC_EnosixDL_Search.MockEnosixDLFailure());
        Account account = TSTU_SFTestObject.createTestAccount();
        account.Name = 'uniqueaccountname';
        account.BillingCountry = 'United States';
        // account.BillingCountryCode = 'US';
        UTIL_SFAccount.setAccountCustomerNumber(account, 'test');
        TSTU_SFTestObject.upsertWithRetry(account);

        UTIL_PageState.current.sfAccountId = String.valueOf(account.Id);

        Test.startTest();
        CTRL_DeliverySearch dllist = new CTRL_DeliverySearch();
        dllist.searchDL();
        Test.stopTest();
	}

    @isTest
    static void test_gotoDetailPage()
	{
		ensxsdk.EnosixFramework.setMock(SBO_EnosixDL_Search.class, new MOC_EnosixDL_Search.MockEnosixDLSuccess());
        //Create an account to test against.
        Account account = TSTU_SFTestObject.createTestAccount();
        account.Name = 'uniqueaccountname';
        account.BillingCountry = 'United States';
        // account.BillingCountryCode = 'US';
        UTIL_SFAccount.setAccountCustomerNumber(account, 'test');
        TSTU_SFTestObject.upsertWithRetry(account);

        Test.setCurrentPageReference(new PageReference('Page.VFP_DeliverySearch'));
        UTIL_PageState.current.sfAccountId = string.valueOf(account.Id);
        System.currentPageReference().getParameters().put('deliveryID', string.valueOf(1));
        CTRL_DeliverySearch controller = new CTRL_DeliverySearch();

        Test.startTest();

        PageReference result1 = controller.gotoDeliveryDetail();
		I_SearchController searchController = controller.searchController;
        Test.stopTest();
    }
}