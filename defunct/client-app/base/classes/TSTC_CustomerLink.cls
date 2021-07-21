@isTest
public with sharing class TSTC_CustomerLink
{

    public class MOC_SBO_SFCICustomer_Search implements ensxsdk.EnosixFramework.SearchSBOSearchMock
	{
        private boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        public ensxsdk.EnosixFramework.SearchContext executeSearch(ensxsdk.EnosixFramework.SearchContext searchContext)
        {
            SBO_SFCICustomer_Search.SFCICustomer_SR results = new SBO_SFCICustomer_Search.SFCICustomer_SR();
            SBO_SFCICustomer_Search.SEARCHRESULT result = new SBO_SFCICustomer_Search.SEARCHRESULT();
            result.CustomerNumber = '330404';
            results.SearchResults.add(result);
            results.setSuccess(this.success);
            searchContext.baseResult = results;
			return searchContext;
        }
	}

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
    static void test_createConstructorAndTouchProperties()
    {
        ensxsdk.EnosixFramework.setMock(SBO_SFCICustomer_Search.class, new MOC_SBO_SFCICustomer_Search());
        insertAccount();
        Test.startTest();
        CTRL_CustomerLink cl = new CTRL_CustomerLink();
        System.assert(cl != null);
        Boolean isClassic = cl.isClassic;
        Test.stopTest();
    }

    @isTest 
    static void test_getAccount()
    {
        ensxsdk.EnosixFramework.setMock(SBO_SFCICustomer_Search.class, new MOC_SBO_SFCICustomer_Search());
        insertAccount();
        Test.startTest();
        CTRL_CustomerLink cl = new CTRL_CustomerLink();
        System.assert(cl != null);
        System.assert(cl.getAccount() != null);
        Test.stopTest();
    }

    @isTest 
    static void test_wildCardSearch()
    {
        ensxsdk.EnosixFramework.setMock(SBO_SFCICustomer_Search.class, new MOC_SBO_SFCICustomer_Search());
        insertAccount();
        Test.startTest();
        CTRL_CustomerLink cl = new CTRL_CustomerLink();
        String wildCardString = 'TESTSTRINGTOSEARCH';
        System.assertNotEquals(wildCardString, cl.wildCardSearch(wildCardString, 500));
        Test.stopTest();
    }

    @isTest 
    static void test_LinkAccount()
    {
        ensxsdk.EnosixFramework.setMock(SBO_SFCICustomer_Search.class, new MOC_SBO_SFCICustomer_Search());
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustomer_Detail.class, new MOC_SBO_EnosixCustomer_Detail());
        insertAccount();
        Test.startTest();
        CTRL_CustomerLink cl = new CTRL_CustomerLink();
        cl.actionLinkAccount();
        System.currentPageReference().getParameters().put('linkedCustomerNumber', '330404');
        cl.actionLinkAccount();
        Test.stopTest();
    }

    @isTest 
    static void test_GoToCreateCustomer()
    {
        ensxsdk.EnosixFramework.setMock(SBO_SFCICustomer_Search.class, new MOC_SBO_SFCICustomer_Search());
        insertAccount();
        Test.startTest();
        CTRL_CustomerLink cl = new CTRL_CustomerLink();
        cl.GoToCreateCustomer();
        Test.stopTest();
    }

    @isTest 
    static void test_ActionCustomerSearch()
    {
        MOC_SBO_SFCICustomer_Search mocSboSfciCustomerSearch = new MOC_SBO_SFCICustomer_Search();
        ensxsdk.EnosixFramework.setMock(SBO_SFCICustomer_Search.class, mocSboSfciCustomerSearch);
        insertAccount();
        Test.startTest();
        CTRL_CustomerLink cl = new CTRL_CustomerLink();
        cl.actionCustomerSearch();
        mocSboSfciCustomerSearch.setSuccess(false);
        cl.actionCustomerSearch();
        Test.stopTest();
    }

    private static void insertAccount()
    {
        Account acct = TSTU_SFTestObject.createTestAccount();
        acct.Name = 'TESTACCT';
        TSTU_SFTestObject.upsertWithRetry(acct);
        Test.setCurrentPageReference(new PageReference('Page.VFP_CustomerLink'));
        UTIL_PageState.current.sfAccountId = acct.Id;
    }
}