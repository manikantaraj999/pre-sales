@isTest
public with sharing class TSTC_CMPPartnerSearch
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

    public class MOC_SBO_EnosixCustomer_Search implements ensxsdk.EnosixFramework.SearchSBOSearchMock
    {
        public Boolean success = true;

        public void setSuccess(Boolean successfull)
        {
            this.success = successfull;
        }

        public ensxsdk.EnosixFramework.SearchContext executeSearch(ensxsdk.EnosixFramework.SearchContext searchContext)
        {
            SBO_EnosixCustomer_Search.EnosixCustomer_SR sr = new SBO_EnosixCustomer_Search.EnosixCustomer_SR();

            SBO_EnosixCustomer_Search.SEARCHRESULT result = new SBO_EnosixCustomer_Search.SEARCHRESULT();
            result.CustomerNumber = '1234';
            result.Name = 'Bob';
            result.Street = 'Angel Grove St';
            result.City = 'New York';
            result.PostalCode = '4566';
            result.Region = 'New York';
            result.CountryKey = 'USA';
            sr.SearchResults.add(result);
            sr.setSuccess(this.success);
            searchContext.baseResult = sr;
			return searchContext;
        }
    }

    public class MockCountries implements DS_CMPCustomerSearch
    {
        public RFC_SD_GET_COUNTRIES.RESULT getCountries()
        {
            RFC_SD_GET_COUNTRIES.RESULT result = new RFC_SD_GET_COUNTRIES.RESULT();
            RFC_SD_GET_COUNTRIES.ET_OUTPUT country = new RFC_SD_GET_COUNTRIES.ET_OUTPUT();
            country.LAND1 = 'USA';
            country.LANDX = 'United States';
            RFC_SD_GET_COUNTRIES.ET_REGIONS region = new RFC_SD_GET_COUNTRIES.ET_REGIONS();
            region.LAND1 = 'USA';
            region.REGIO = 'OH';
            region.BEZEI = 'OHIO';
            result.getCollection(RFC_SD_GET_COUNTRIES.ET_OUTPUT.class).add(country);
            result.getCollection(RFC_SD_GET_COUNTRIES.ET_REGIONS.class).add(region);
            return result;
        }
    }

    public class MockReceiver implements CB_CMPPartnerSearchReceiver
    {
        public CTRL_CMPPartnerSearch.PartnerSearchResult searchResult { get; set; }
        public void onReceivePartnerSearch(CTRL_CMPPartnerSearch.PartnerSearchResult result)
        {
            this.searchResult = result;
        }
    }

    // test_CMPPartnerSearch()
    //
    // Test method for the CMPPartnerSearch Controller
    static testMethod void test_CMPPartnerSearch()
    {
        MOC_SBO_SFCIPartner_Search mocSboEnosixPartnerSearch = new MOC_SBO_SFCIPartner_Search();
        ensxsdk.EnosixFramework.setMock(SBO_SFCIPartner_Search.class, mocSboEnosixPartnerSearch);
        MOC_SBO_EnosixCustomer_Search mocSboEnosixCustomerSearch = new MOC_SBO_EnosixCustomer_Search();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustomer_Search.class, mocSboEnosixCustomerSearch);

        Test.startTest();
        CTRL_CMPPartnerSearch controller = new CTRL_CMPPartnerSearch();
        I_SearchController searchController = controller.searchController;
        controller.isAutoSearchEnabled = true;
        controller.soldToPartyNumber = '1234';
        controller.salesOrganization = 'salesOrganization';
        controller.distributionChannel = 'distributionChannel';
        controller.division = 'division';
        controller.partnerFunction = 'SH';
        controller.searchNameAction = 'searchNameAction';
        controller.selectedNameAction = 'selectedNameAction';
        controller.componentTitle = 'componentTitle';
        controller.customerAccountGroup = 'customerAccountGroup';
        setParams(controller);
        System.currentPageReference().getParameters().put('isAllShipTo', 'false');
        controller.actionSearch();

        MockReceiver receiver = new MockReceiver();
        controller.searchReceiver = receiver;

        MockCountries dsCustomerSearch = new MockCountries();
        controller.customerSearchData = dsCustomerSearch;
        List<SelectOption> countries = controller.countryOptions;

        System.currentPageReference().getParameters().put('selectedIndex', '0');
        System.currentPageReference().getParameters().put('isAllShipTo', 'true');
        controller.customerSearchContext = null;
        controller.actionSearch();
        controller.actionSelectedPartnerToReceiver();
        System.currentPageReference().getParameters().put('isAllShipTo', 'false');
        controller.actionSearch();
        controller.isCurrentCustomerSearch = true;
        controller.runSearch();
        mocSboEnosixPartnerSearch.setSuccess(false);
        mocSboEnosixCustomerSearch.setSuccess(false);
        controller.searchCustomers();
        controller.actionSearch();
        controller.previousScreen = controller.previousScreen;
        System.currentPageReference().getParameters().put('isAllShipTo', 'true');
        controller.actionSearch();
        CTRL_CMPPartnerSearch.PartnerSearchResult result = new CTRL_CMPPartnerSearch.PartnerSearchResult();
        result.phoneNumber = result.phoneNumber;
        Test.stopTest();
    }

    // setParams(controller)
    //
    // Set the parameter before it does a search
    private static void setParams(CTRL_CMPPartnerSearch controller)
    {
        controller.searchContext.SEARCHPARAMS.CustomerNumber = '1234';
    }
}