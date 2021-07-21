@isTest
public with sharing class TSTC_CMPCustomerSearch 
{
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
            result.Name2 = 'Dole';
            result.Street = 'Angel Grove St';
            result.City = 'New York';
            result.PostalCode = '4566';
            result.Region = 'New York';
            result.CountryKey = 'United States';
            sr.SearchResults.add(result);
            sr.setSuccess(this.success);
            searchContext.baseResult = sr;
			return searchContext;
        }
    }

    public class MockReceiver implements CB_CMPCustomerSearchReceiver
    {
        public CTRL_CMPCustomerSearch.CustomerSearchResult searchResult { get; set; }
        public void onReceiveCustomerSearch(CTRL_CMPCustomerSearch.CustomerSearchResult result)
        {
            this.searchResult = result;
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

    @isTest
    static void test_customerSearch()
    {
        mocCallouts();
        CTRL_CMPCustomerSearch controller = new CTRL_CMPCustomerSearch();
        controller.customerName = 'customerName';
        controller.telephoneNO = 'telephoneNO';
        controller.eMailAddress = 'eMailAddress';
        I_SearchController searchController = controller.searchController;
        setFields(controller);
        controller.actionSearch();

        MockCountries dsCustomerSearch = new MockCountries();
        controller.customerSearchData = dsCustomerSearch;
        List<SelectOption> countries = controller.countryOptions;
        List<SelectOption> regions = controller.regionOptions;
        Boolean isCountryAllowed = controller.isCountryAllowed;
        Boolean isStateAllowed = controller.isStateAllowed;
        String searchNameAction = controller.searchNameAction;
        String selectedNameAction = controller.selectedNameAction;
        String actionCountryChange = controller.actionCountryChange;

        MockReceiver receiver = new MockReceiver();
        controller.searchReceiver = receiver;
        System.currentPageReference().getParameters().put('selectedIndex', '0');
        controller.actionSelectedCustomerToReceiver();
        mocSboEnosixCustomerSearch.setSuccess(false);
        controller.actionSearch();
    }

    private static void setFields(CTRL_CMPCustomerSearch controller)
    {
        controller.isMainShipTo = true;
        controller.isContactSearch = true;
        controller.isPersonnelSearch = true;
        controller.customerNumberFrom = '1000';
        controller.partnerFunction = 'SH';
        controller.accountGroup = '0001';
        controller.componentTitle = 'Test';
        controller.isAutoSearchEnabled = true;
        controller.partnerName = 'Bob';
        controller.name2 = 'Dole';
        controller.firstName = 'first';
        controller.lastName = 'last';
        controller.searchTerm1 = 'term1';
        controller.searchTerm2 = 'term2';
        controller.street = '222 Angel Grove';
        controller.houseNumber = '222';
        controller.postalCode = '3333';
        controller.city = 'New York';
        controller.Country = 'USA';
        controller.region = 'New York';
        CTRL_CMPCustomerSearch.CustomerSearchResult searchResult = new CTRL_CMPCustomerSearch.CustomerSearchResult();
        searchResult.phoneNumber = 'phoneNumber';
    }

    private static MOC_SBO_EnosixCustomer_Search mocSboEnosixCustomerSearch;

    private static void mocCallouts()
    {
        mocSboEnosixCustomerSearch = new MOC_SBO_EnosixCustomer_Search();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustomer_Search.class, mocSboEnosixCustomerSearch);
    }
}
