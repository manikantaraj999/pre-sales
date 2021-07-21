@isTest
public with sharing class TSTC_ShipToSearch
{
    public class MOC_SBO_SFCIPartner_Search implements ensxsdk.EnosixFramework.SearchSBOSearchMock
    {
        public Boolean success = true;

        public void setSuccess(Boolean successfull)
        {
            this.success = successfull;
        }

        public ensxsdk.EnosixFramework.SearchContext executeSearch(ensxsdk.EnosixFramework.SearchContext searchContext)
        {
            SBO_SFCIPartner_Search.SFCIPartner_SR sr = new SBO_SFCIPartner_Search.SFCIPartner_SR();

            SBO_SFCIPartner_Search.SEARCHRESULT result = new SBO_SFCIPartner_Search.SEARCHRESULT();
            result.PartnerNumber = '1234';
            result.PartnerName = 'Bob';
            result.Street = 'Angel Grove St';
            result.City = 'New York';
            result.PostalCode = '4566';
            result.Region = 'New York';
            result.Country = 'USA';
            sr.SearchResults.add(result);
            sr.setSuccess(this.success);
            searchContext.baseResult = sr;
			return searchContext;
        }
    }

    public class MockReceiver implements CB_ShipToSearchReceiver
    {
        public CTRL_ShipToSearch.ShipToSearchResult searchResult { get; set; }
        public void onReceiveShipToSearch(CTRL_ShipToSearch.ShipToSearchResult result)
        {
            this.searchResult = result;
        }
    }

    // test_ShipToSearch()
    //
    // Test method for the ShipToSearch Controller
    static testMethod void test_ShipToSearch()
    {
        MOC_SBO_SFCIPartner_Search mocSboEnosixPartnerSearch = new MOC_SBO_SFCIPartner_Search();
        ensxsdk.EnosixFramework.setMock(SBO_SFCIPartner_Search.class, mocSboEnosixPartnerSearch);

        Test.startTest();
        CTRL_ShipToSearch controller = new CTRL_ShipToSearch();
        I_SearchController searchController = controller.searchController;
        controller.isAutoSearchEnabled = true;
        controller.soldToPartyNumber = '1234';
        controller.salesOrganization = 'salesOrganization';
        controller.distributionChannel = 'distributionChannel';
        controller.division = 'division';
        setParams(controller);
        controller.actionSearch();
        System.currentPageReference().getParameters().put('selectedIndex', '0');
        controller.goToCloneNewShipTo();

        MockReceiver receiver = new MockReceiver();
        controller.searchReceiver = receiver;

        System.currentPageReference().getParameters().put('selectedIndex', '0');
        controller.actionSelectedAddressToReceiver();
        controller.actionSearch();
        mocSboEnosixPartnerSearch.setSuccess(false);
        controller.actionSearch();
        controller.previousScreen = controller.previousScreen;
        CTRL_ShipToSearch.ShipToSearchResult result = new CTRL_ShipToSearch.ShipToSearchResult();
        result.phoneNumber = result.phoneNumber;
        Test.stopTest();
    }

    // setParams(controller)
    //
    // Set the parameter before it does a search
    private static void setParams(CTRL_ShipToSearch controller)
    {
        controller.searchContext.SEARCHPARAMS.CustomerNumber = '1234';
    }
}