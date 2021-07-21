@isTest
public with sharing class TSTC_PartnerSearch
{
    public class MOC_EnosixCustomer_Detail implements ensxsdk.EnosixFramework.DetailSBOGetMock,
        ensxsdk.EnosixFramework.DetailSBOSaveMock
    {
        public boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        public ensxsdk.EnosixFramework.DetailObject executeGetDetail(object key)
        {
            SBO_EnosixCustomer_Detail.EnosixCustomer result = new SBO_EnosixCustomer_Detail.EnosixCustomer();
            result.CustomerNumber = '0045683';
            result.Name = 'Mock Customer';

            List<SBO_EnosixCustomer_Detail.CONTACTS> listContacts = new List<SBO_EnosixCustomer_Detail.CONTACTS>();
            for (Integer mocCnt = 1; mocCnt <= 2; mocCnt++)
            {
                SBO_EnosixCustomer_Detail.CONTACTS sboContact = new SBO_EnosixCustomer_Detail.CONTACTS();
                sboContact.ContactPersonNumber = '000' + String.valueOf(mocCnt);
                sboContact.Name = 'Contact' + String.valueOf(mocCnt);
                listContacts.add(sboContact);
            }

            result.CONTACTS.addAll(listContacts);
            result.setSuccess(true);
            return result;
        }

        public ensxsdk.EnosixFramework.DetailObject executeSave(ensxsdk.EnosixFramework.DetailObject obj)
        {
            SBO_EnosixCustomer_Detail.EnosixCustomer result = new SBO_EnosixCustomer_Detail.EnosixCustomer();
            result.CustomerNumber = '0045683';
            result.Name = 'Mock Customer';
            result.setSuccess(true);
            return result;
        }
    }

    public class Mock_SBO_SFCIPartner_Search implements ensxsdk.EnosixFramework.SearchSBOSearchMock
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

        private boolean returnRecord = true;

        public void setReturnRecord(boolean returnRecord)
        {
            this.returnRecord = returnRecord;
        }

        public ensxsdk.EnosixFramework.SearchContext executeSearch(ensxsdk.EnosixFramework.SearchContext searchContext)
        {
            SBO_SFCIPartner_Search.SFCIPartner_SR search_result = new SBO_SFCIPartner_Search.SFCIPartner_SR();

            SBO_SFCIPartner_Search.SEARCHRESULT result = new SBO_SFCIPartner_Search.SEARCHRESULT();

            if (returnRecord)
            {
                result.PartnerFunctionName = 'PartnerFunctionName';
                result.PartnerNumber = 'PARTNER_NUM';
                result.PartnerName = 'PARTNER_NAME';
                result.HouseNumber = 'HouseNumber';
                result.Street = 'Street';
                result.City = 'City';
                result.Region = 'Region';
                result.PostalCode = 'PostalCode';

                search_result.SearchResults.add(result);
            }

            search_result.setSuccess(success);
            searchContext.baseResult = search_result;
			return searchContext;
        }
    }

    @isTest
    static void test_CTRL_PartnerSearch_constructor()
    {
    	Test.startTest();
        CTRL_PartnerSearch controller = new CTRL_PartnerSearch();
        Test.stopTest();
    }

    @isTest
    static void test_initDetail()
    {
        Mock_SBO_SFCIPartner_Search mockSboEnosixPartnerSearch = new Mock_SBO_SFCIPartner_Search();
        ensxsdk.EnosixFramework.setMock(SBO_SFCIPartner_Search.class, mockSboEnosixPartnerSearch);
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustomer_Detail.class, new MOC_EnosixCustomer_Detail());
        Account account = TSTU_SFTestObject.createTestAccount();
        account.Name = 'Mock Account';
        UTIL_SFAccount.setAccountCustomerNumber(account, 'CUSTID');
        TSTU_SFTestObject.upsertWithRetry(account);

        UTIL_PageState.current.sfAccountId = account.Id;
        CTRL_PartnerSearch controller = new CTRL_PartnerSearch();
        System.assert(controller.accountid == account.Id);

        Test.startTest();

        Boolean showShipToCreate = controller.showShipToCreate;
        Boolean hasAccount = controller.hasAccount;
        System.assert(controller.customerid == 'CUSTID');
        SBO_EnosixCustomer_Detail.EnosixCustomer cDetail = controller.cDetail;
        I_SearchController searchController = controller.searchController;
        List<SelectOption> SalesOrganizations = controller.SalesOrganizations;
        List<SelectOption> DistributionChannels = controller.DistributionChannels;
        List<SelectOption> Divisions = controller.Divisions;
        mockSboEnosixPartnerSearch.setSuccess(false);
        controller.runSearch();
        UTIL_SFAccount.setAccountCustomerNumber(account, '');
        TSTU_SFTestObject.upsertWithRetry(account);
        controller.Init();
        Boolean isClassic = controller.isClassic;

        Test.stopTest();
    }

    @isTest
    static void test_actionAddShipTo()
    {
    	Test.startTest();
        CTRL_PartnerSearch controller = new CTRL_PartnerSearch();
        controller.actionAddShipTo();
        Test.stopTest();
    }

    @isTest
    static void test_gotoCustomerPage()
    {
    	Test.startTest();
        CTRL_PartnerSearch controller = new CTRL_PartnerSearch();
        controller.gotoCustomerPage();
        Test.stopTest();
    }
}