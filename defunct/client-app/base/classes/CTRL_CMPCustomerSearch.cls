public with sharing class CTRL_CMPCustomerSearch implements I_SearchController
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_CMPCustomerSearch.class);

    public SBO_EnosixCustomer_Search.SEARCHPARAMS searchParams { get; set; }
    private boolean searchResultsLoaded = false;
    public I_SearchController searchController { get { return this; } }
    public SBO_EnosixCustomer_Search.EnosixCustomer_SC searchContext { get; set; }
    public Boolean hasRecords { get; private set; }
    public UTIL_PagingOptionsWrapper pagingOptionsWrapper { get; private set; }

    private Map<String, List<CustomerSearchResult>> searchResultsMap = new Map<String, List<CustomerSearchResult>>();
    public List<CustomerSearchResult> searchResults
    {
        get
        {
            List<CustomerSearchResult> result = new List<CustomerSearchResult>();
            if (searchResultsMap.containsKey(partnerFunction))
            {
                result = searchResultsMap.get(partnerFunction);
            }
            return result;
        } 
        private set
        {
            searchResultsMap.put(partnerFunction, value);
        }
    }

    private Boolean isInitialLoad { get; set; }
    private Boolean isCustomerNumberFromSet = false;
    private Boolean isPartnerFunctionSet = false;
    private Boolean isAccountGroupSet = false;
    private Boolean isAutoSearchEnabledSet = false;
    private Boolean isComponentTitleSet = false;
    private Boolean isContactSearchSet = false;
    private Boolean isPersonnelSearchSet = false;
    private Boolean isMainShipToSet = false;
    public Boolean isCountryAllowed { get { return countryOptions.size() > 0; } }
    public Boolean isStateAllowed { get { return regionOptions.size() > 0; } }
    
    public String searchNameAction { get; set; }
    public String selectedNameAction { get; set; }
    public String actionCountryChange { get; set; }

    public Boolean isMainShipTo
    {
        get;
        set
        {
            this.isMainShipTo = value;
            this.isMainShipToSet = true;
            initialLoad();
        }
    }

    public Boolean isContactSearch
    {
        get;
        set
        {
            this.isContactSearch = value;
            this.isContactSearchSet = true;
            initialLoad();
        }
    }

    public Boolean isPersonnelSearch
    {
        get;
        set
        {
            this.isPersonnelSearch = value;
            this.isPersonnelSearchSet = true;
            initialLoad();
        }
    }

    public String customerNumberFrom
    {
        get;
        set
        {
            this.customerNumberFrom = value;
            this.isCustomerNumberFromSet = true;
            initialLoad();
        }
    }

    public String partnerFunction
    {
        get;
        set
        {
            this.partnerFunction = value;
            this.isPartnerFunctionSet = true;
            initialLoad();
        }
    }

    public String accountGroup
    {
        get;
        set
        {
            this.accountGroup = value;
            this.isAccountGroupSet = true;
            initialLoad();
        }
    }

    public String componentTitle
    {
        get;
        set
        {
            this.componentTitle = value;
            this.isComponentTitleSet = true;
            initialLoad();
        }
    }

    public Boolean isAutoSearchEnabled
    {
        get;
        set
        {
            this.isAutoSearchEnabled = value;
            this.isAutoSearchEnabledSet = true;
            initialLoad();
        }
    }

    public CB_CMPCustomerSearchReceiver searchReceiver
    {
        get;
        set
        {
            this.searchReceiver = value;
        }
    }

    public DS_CMPCustomerSearch customerSearchData
    {
        get;
        set
        {
            this.customerSearchData = value;
        }
    }

    public transient RFC_SD_GET_COUNTRIES.RESULT countriesResult
    {
        get
        {
            RFC_SD_GET_COUNTRIES.RESULT result = new RFC_SD_GET_COUNTRIES.RESULT();
            if (this.customerSearchData != null)
            {
                result = this.customerSearchData.getCountries();
            }
            return result;
        }
    }

    // Search Parameters
    public String partnerName { get; set; }
    public String name2 { get; set; }
    public String customerName { get; set; }
    public String firstName { get; set; }
    public String lastName { get; set; }
    public String searchTerm1 { get; set; }
    public String searchTerm2 { get; set; }
    public String street { get; set; }
    public String houseNumber { get; set; }
    public String postalCode { get; set; }
    public String telephoneNO { get; set; }
    public String eMailAddress { get; set; }
    public String city { get; set; }
    public String country { get; set; }
    public String region { get; set; }

    public class CustomerSearchResult
    {
        public Integer index { get; set; }
        public String customerNumber { get; set; }
        public String name { get; set; }
        public String name2 { get; set; }
        public String address { get; set; }
        public String country { get; set; }
        public String phoneNumber { get; set; }
        public String partnerFunction { get; set; }
        public String accountGroup { get; set; }
        public Boolean isContactPartner { get; set; }
        public Boolean isPersonnelPartner { get; set; }
        public Boolean isMainShipTo { get; set; }
    }

    // ctor()
    public CTRL_CMPCustomerSearch()
    {
        this.searchContext = new SBO_EnosixCustomer_Search.EnosixCustomer_SC();
        resetSearchContext();
        this.isInitialLoad = true;
        this.searchParams = new SBO_EnosixCustomer_Search.SEARCHPARAMS();
    }

    // initialLoad()
    //
    // Method to check if all assignTo attribute is set
    private void initialLoad()
    {
        if (this.isCustomerNumberFromSet && 
            this.isAutoSearchEnabledSet && 
            this.isAccountGroupSet && 
            this.isComponentTitleSet &&
            this.isContactSearchSet &&
            this.isMainShipToSet)
        {
            initialize();
        }
    }

    public void initialize()
    {
        if (this.isInitialLoad && 
            this.isAutoSearchEnabled)
        {
            runSearch();
            searchResultsLoaded = true;
        }
        this.isInitialLoad = false;
    }

    public List<SelectOption> countryOptions
    {
        get
        {
            List<SelectOption> options = new List<SelectOption>();
            if (this.countriesResult != null && this.countriesResult.ET_OUTPUT_List.size() > 0)
            {
                options.add(new SelectOption('',''));
                List<RFC_SD_GET_COUNTRIES.ET_OUTPUT> countryList = this.countriesResult.ET_OUTPUT_List;
                Integer countryTot = countryList.size();
                for (Integer countryCnt = 0 ; countryCnt < countryTot ; countryCnt++)
                {
                    RFC_SD_GET_COUNTRIES.ET_OUTPUT country = countryList[countryCnt];
                    if (String.isNotEmpty(country.LAND1))
                    {
                        options.add(new SelectOption(
                            country.LAND1, country.LANDX == null ? country.LAND1 : country.LAND1 + ' - ' + country.LANDX));
                    }
                }
            }
            return options;
        }
    }

    public List<SelectOption> regionOptions
    {
        get
        {
            List<SelectOption> options = new List<SelectOption>();
            if (this.countriesResult != null && this.countriesResult.ET_OUTPUT_List.size() > 0)
            {
                options.add(new SelectOption('',''));
                if (String.isNotEmpty(this.country))
                {
                    List<RFC_SD_GET_COUNTRIES.ET_REGIONS> regionList = this.countriesResult.ET_REGIONS_List;
                    Integer regionTot = regionList.size();
                    for (Integer regionCnt = 0 ; regionCnt < regionTot ; regionCnt++)
                    {
                        RFC_SD_GET_COUNTRIES.ET_REGIONS region = regionList[regionCnt];
                        if (region.LAND1 == this.country && String.isNotEmpty(region.REGIO))
                        {
                            options.add(new SelectOption(
                                region.REGIO, region.BEZEI == null ? region.REGIO : region.REGIO + ' - ' + region.BEZEI));
                        }
                    }
                }                
            }
            return options;
        }
    }

    // resetSearchResults()
    //
    // Action method to search for partner
    public void actionSearch()
    {
        resetSearchContext();
        runSearch();
    }

    private void resetSearchContext()
    {
        Integer pageSize = UTIL_ViewHelper.SearchDefaultPageSize;
        if (this.searchContext != null)
        {
            // page size is the only thing not reset
            pageSize = this.searchContext.pagingOptions.pageSize;
        }
        this.searchContext = new SBO_EnosixCustomer_Search.EnosixCustomer_SC();
        this.pagingOptionsWrapper = new UTIL_PagingOptionsWrapper(this.searchContext.pagingOptions);
        this.searchContext.pagingOptions.pageSize = pageSize;
        this.searchContext.pagingOptions.pageNumber = 1;
        this.hasRecords = false;
    }

    // runSearch()
    //
    // Action method to search partner
    public void runSearch()
    {
        List<CustomerSearchResult> results = null;
        SBO_EnosixCustomer_Search sbo = new SBO_EnosixCustomer_Search();

        setSearchParams();
        sbo.search(this.searchContext);

        SBO_EnosixCustomer_Search.EnosixCustomer_SR result = this.searchContext.result;

        if (!result.isSuccess())
        {
            System.debug('Search Failed');
            this.hasRecords = false;
            UTIL_ViewHelper.displayResultMessages(result.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
        }
        else
        {
            this.hasRecords = true;
            results = new List<CustomerSearchResult>();
            Integer index = 0;
            List<SBO_EnosixCustomer_Search.SEARCHRESULT> resultList = result.getResults();
            Integer resultTot = resultList.size();
            for (Integer resultCnt = 0 ; resultCnt < resultTot ; resultCnt++)
            {         
                SBO_EnosixCustomer_Search.SEARCHRESULT sr = resultList[resultCnt];   
                results.add(addResult(sr, index));
                index++; 
            }
        }
        this.searchResults = results;
    }

    public void setSearchParams()
    {
        if (!String.isBlank(this.customerNumberFrom))
        {
            this.searchContext.SEARCHPARAMS.CustomerNumberFrom = this.customerNumberFrom;
        }
        // if (!String.isBlank(this.partnerName))
        // {
        //     this.searchContext.SEARCHPARAMS.Name = this.partnerName;
        // }
        // if (!String.isBlank(this.name2))
        // {
        //     this.searchContext.SEARCHPARAMS.Name2 = this.name2;
        // }
        if (!String.isBlank(this.customerName))
        {
            this.searchContext.SEARCHPARAMS.customerName = this.customerName;
        }
        if (!String.isBlank(this.firstName))
        {
            this.searchContext.CONTACT_PERSON.FirstName = this.firstName;
        }
        if (!String.isBlank(this.lastName))
        {
            this.searchContext.CONTACT_PERSON.LastName = this.lastName;
        }
        // if (!String.isBlank(this.searchTerm1))
        // {
        //     this.searchContext.SEARCHPARAMS.SearchTerm1 = this.searchTerm1;
        // }
        // if (!String.isBlank(this.searchTerm2))
        // {
        //     this.searchContext.SEARCHPARAMS.SearchTerm2 = this.searchTerm2;
        // }
        // if (!String.isBlank(this.street))
        // {
        //     this.searchContext.SEARCHPARAMS.Street = this.street;
        // }
        // if (!String.isBlank(this.houseNumber))
        // {
        //     this.searchContext.SEARCHPARAMS.HouseNumber = this.houseNumber;
        // }
        if (!String.isBlank(this.postalCode))
        {
            this.searchContext.SEARCHPARAMS.PostalCode = this.postalCode;
        }
        if (!String.isBlank(this.city))
        {
            this.searchContext.SEARCHPARAMS.City = this.city;
        }
        if (!String.isBlank(this.country))
        {
            this.searchContext.SEARCHPARAMS.CountryKey = this.country;
        }
        if (!String.isBlank(this.region))
        {
            this.searchContext.SEARCHPARAMS.Region = this.region;
        }
        if (!String.isBlank(this.telephoneNO))
        {
            this.searchContext.SEARCHPARAMS.TelephoneNO = this.telephoneNO;
        }
        if (!String.isBlank(this.eMailAddress))
        {
            this.searchContext.SEARCHPARAMS.EMailAddress = this.eMailAddress;
        }
        // if (!String.isBlank(this.accountGroup))
        // {
        //     SBO_EnosixCustomer_Search.ACCOUNT_GROUP acctGroup = new SBO_EnosixCustomer_Search.ACCOUNT_GROUP();
        //     acctGroup.CustomerAccountGroup = accountGroup;
        //     this.searchContext.ACCOUNT_GROUP.add(acctGroup);
        // }
        if (this.isContactSearch)
        {
            this.searchContext.CONTACT_PERSON.ContactPersonFlag = 'X';            
        }
        if (this.isPersonnelSearch)
        {
            this.searchContext.CONTACT_PERSON.SalesEmployeeFlag = 'X';
        }
    }

    // addResult(sr)
    //
    // Add customer to the searchResults
    private CustomerSearchResult addResult(SBO_EnosixCustomer_Search.SEARCHRESULT sr, Integer index)
    {
        CustomerSearchResult customer = new CustomerSearchResult();
        customer.index = index;
        //Replaces the leading 0s with an empty string
        customer.customerNumber = sr.CustomerNumber;
        customer.name = sr.Name;
        customer.name2 = sr.Name2;
        customer.address = buildAddress(sr.Street, sr.City, sr.Region, sr.PostalCode);
        customer.country = sr.CountryKey;

        return customer;
    }

    // buildAddress
    //
    // Build the address
    private String buildAddress(String street, String city, String region, String postalCode)
    {
        String address = '';
        address = UTIL_SyncHelper.combineStrings(city, region, ',');
        address = UTIL_SyncHelper.combineStrings(address, postalCode, ' ');
        address = UTIL_SyncHelper.combineStrings(street, address, '\n');
        return address;
    }

    // actionSelectedCustomerToReceiver()
    //
    // Action when selecting the address
    public void actionSelectedCustomerToReceiver()
    {
        Integer selectedIndex = Integer.valueOf(System.currentPageReference().getParameters().get('selectedIndex'));

        CustomerSearchResult customer = null;
        Integer resultTot = this.searchResults.size();
        for (Integer resultCnt = 0 ; resultCnt < resultTot ; resultCnt++)
        {         
            CustomerSearchResult result = this.searchResults[resultCnt];   
            if (result.index == selectedIndex)
            {
                customer = result;
                customer.partnerFunction = this.partnerFunction;
                customer.accountGroup = this.accountGroup;
                customer.isContactPartner = this.isContactSearch;
                customer.isPersonnelPartner = this.isPersonnelSearch;
                customer.isMainShipTo = this.isMainShipTo;
                break;
            }
        }

        if (null != customer)
        {
            this.searchResults = null;
            this.searchReceiver.onReceiveCustomerSearch(customer);
        }
    }
}
