public with sharing class CTRL_CMPPartnerSearch implements I_SearchController
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_CMPPartnerSearch.class);

    public SBO_SFCIPartner_Search.SEARCHPARAMS searchParams { get; set; }
    private boolean searchResultsLoaded = false;
    public I_SearchController searchController { get { return this; } }
    public SBO_SFCIPartner_Search.SFCIPartner_SC searchContext { get; set; }
    public Boolean hasRecords { get; private set; }
    public UTIL_PagingOptionsWrapper pagingOptionsWrapper { get; private set; }

    private Map<String, List<PartnerSearchResult>> searchResultsMap = new Map<String, List<PartnerSearchResult>>();
    public List<PartnerSearchResult> searchResults
    {
        get
        {
            List<PartnerSearchResult> result = new List<PartnerSearchResult>();
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
    private Boolean isSoldToPartyNumberSet = false;
    private Boolean isSalesOrganizationSet = false;
    private Boolean isDistributionChannelSet = false;
    private Boolean isDivisionSet = false;
    private Boolean isAutoSearchEnabledSet = false;
    private String soldToPartyNumberSave = null;
    private String salesOrganizationSave = null;
    private String distributionChannelSave = null;
    private String divisionSave = null;
    private Boolean isPartnerFunctionSet = false;
    private Boolean isComponentTitleSet = false;

    public String searchNameAction { get; set; }
    public String selectedNameAction { get; set; }

    public String soldToPartyNumber
    {
        get;
        set
        {
            this.soldToPartyNumber = value;
            this.isSoldToPartyNumberSet = true;
            if (value != this.soldToPartyNumberSave)
            {
                this.isInitialLoad = true;
                this.soldToPartyNumberSave = value;
            }
            initialLoad();
        }
    }

    public String salesOrganization
    {
        get;
        set
        {
            this.salesOrganization = value;
            this.isSalesOrganizationSet = true;
            if (value != this.salesOrganizationSave)
            {
                this.isInitialLoad = true;
                this.salesOrganizationSave = value;
            }
            initialLoad();
        }
    }

    public String distributionChannel
    {
        get;
        set
        {
            this.distributionChannel = value;
            this.isDistributionChannelSet = true;
            if (value != this.distributionChannelSave)
            {
                this.isInitialLoad = true;
                this.distributionChannelSave = value;
            }
            initialLoad();
        }
    }

    public String division
    {
        get;
        set
        {
            this.division = value;
            this.isDivisionSet = true;
            if (value != this.divisionSave)
            {
                this.isInitialLoad = true;
                this.divisionSave = value;
            }
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

    public String previousScreen { get; set; }

    public Boolean isAutoSearchEnabled
    {
        get;
        set
        {
            this.isAutoSearchEnabled = value;
            this.isAutoSearchEnabledSet = true;
        }
    }

    public CB_CMPPartnerSearchReceiver searchReceiver
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

    public class PartnerSearchResult
    {
        public Integer index { get; set; }
        public String partnerNumber { get; set; }
        public String salesOrg { get; set; }
        public String distChannel { get; set; }
        public String division { get; set; }
        public String name { get; set; }
        public String address { get; set; }
        public String country { get; set; }
        public String phoneNumber { get; set; }
        public String partnerFunction { get; set; }
    }

    // ctor()
    public CTRL_CMPPartnerSearch()
    {
        this.searchContext = new SBO_SFCIPartner_Search.SFCIPartner_SC();
        this.customerSearchContext = new SBO_EnosixCustomer_Search.EnosixCustomer_SC();
        resetSearchContext();
        this.isInitialLoad = true;
        this.searchParams = new SBO_SFCIPartner_Search.SEARCHPARAMS();
    }

    // initialLoad()
    //
    // Method to check if all assignTo attribute is set
    private void initialLoad()
    {
        if (this.isSoldToPartyNumberSet &&
            this.isPartnerFunctionSet && 
            this.isAutoSearchEnabledSet && 
            this.isComponentTitleSet &&
            String.isNotEmpty(this.soldToPartyNumber))
        {
            initialize();
        }
    }

    public void initialize()
    {
        if (this.isInitialLoad && 
            this.isAutoSearchEnabled)
        {
            this.isCurrentCustomerSearch = false;
            runSearch();
            searchResultsLoaded = true;
        }
        this.isInitialLoad = false;
    }

    @testVisible
    private Boolean isCurrentCustomerSearch { get; set; }
    public String customerAccountGroup { get; set; }
    public SBO_EnosixCustomer_Search.EnosixCustomer_SC customerSearchContext { get; set; }

    // resetSearchResults()
    //
    // Action method to search shipTo address
    public void actionSearch()
    {
        Boolean isAllShipTo = Boolean.valueOf(System.currentPageReference().getParameters().get('isAllShipTo'));
        if (isAllShipTo) 
        {
            this.isCurrentCustomerSearch = true;
            resetSearchCustomersContext();
            searchCustomers();
        }
        else
        {
            this.isCurrentCustomerSearch = false;
            resetSearchContext();
            runSearch();
        }        
    }

    private void resetSearchCustomersContext()
    {
        Integer pageSize = UTIL_ViewHelper.SearchDefaultPageSize;
        if (this.customerSearchContext == null) {
            this.customerSearchContext = new SBO_EnosixCustomer_Search.EnosixCustomer_SC();
        }        
        this.pagingOptionsWrapper = new UTIL_PagingOptionsWrapper(this.customerSearchContext.pagingOptions);
        this.customerSearchContext.pagingOptions.pageSize = pageSize;
        this.customerSearchContext.pagingOptions.pageNumber = 1;
        // this.customerSearchContext.SEARCHPARAMS.CustomerAccountGroup = this.customerAccountGroup;
        // this.customerSearchContext.SEARCHPARAMS.SalesOrganization = this.salesOrganization;
        // this.customerSearchContext.SEARCHPARAMS.DistributionChannel = this.distributionChannel;
        this.hasRecords = false;
    }

    @testVisible
    private void searchCustomers()
    {
        List<PartnerSearchResult> results = null;
        SBO_EnosixCustomer_Search sbo = new SBO_EnosixCustomer_Search();

        sbo.search(this.customerSearchContext);

        SBO_EnosixCustomer_Search.EnosixCustomer_SR searchResult = this.customerSearchContext.result;

        if (!searchResult.isSuccess())
        {
            System.debug('Search Failed');
            this.hasRecords = false;
            UTIL_ViewHelper.displayResultMessages(searchResult.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
        }
        else
        {
            this.hasRecords = true;
            results = new List<PartnerSearchResult>();
            Integer index = 0;
            List<SBO_EnosixCustomer_Search.SEARCHRESULT> resultList = searchResult.getResults();
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

    private void resetSearchContext()
    {
        Integer pageSize = UTIL_ViewHelper.SearchDefaultPageSize;
        if (this.searchContext != null)
        {
            // page size is the only thing not reset
            pageSize = this.searchContext.pagingOptions.pageSize;
        }
        this.searchContext = new SBO_SFCIPartner_Search.SFCIPartner_SC();
        this.pagingOptionsWrapper = new UTIL_PagingOptionsWrapper(this.searchContext.pagingOptions);
        this.searchContext.pagingOptions.pageSize = pageSize;
        this.searchContext.pagingOptions.pageNumber = 1;
        this.hasRecords = false;
    }

    // searchPartner()
    //
    // Action method to search shipTo address
    public void runSearch()
    {
        if (this.isCurrentCustomerSearch) {
            searchCustomers();
            return;
        }

        List<PartnerSearchResult> results = null;
        SBO_SFCIPartner_Search sbo = new SBO_SFCIPartner_Search();

        setSearchParams();
        sbo.search(this.searchContext);

        SBO_SFCIPartner_Search.SFCIPartner_SR result = this.searchContext.result;

        if (!result.isSuccess())
        {
            System.debug('Search Failed');
            this.hasRecords = false;
            UTIL_ViewHelper.displayResultMessages(result.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
        }
        else
        {
            this.hasRecords = true;
            results = new List<PartnerSearchResult>();
            Integer index = 0;
            List<SBO_SFCIPartner_Search.SEARCHRESULT> resultList = result.getResults();
            Integer resultTot = resultList.size();
            for (Integer resultCnt = 0 ; resultCnt < resultTot ; resultCnt++)
            {         
                SBO_SFCIPartner_Search.SEARCHRESULT sr = resultList[resultCnt];   
                results.add(addResult(sr, index));
                index++;
            }
        }
        this.searchResults = results;
    }

    public void setSearchParams()
    {
        if (!String.isBlank(this.soldToPartyNumber))
        {
            this.searchContext.SEARCHPARAMS.CustomerNumber = this.soldToPartyNumber;
        }
        if (!String.isBlank(this.salesOrganization))
        {
            this.searchContext.SEARCHPARAMS.SalesOrganization = this.salesOrganization;
        }
        if (!String.isBlank(this.distributionChannel))
        {
            this.searchContext.SEARCHPARAMS.DistributionChannel = this.distributionChannel;
        }
        if (!String.isBlank(this.division))
        {
            this.searchContext.SEARCHPARAMS.Division = this.division;
        }
        this.searchContext.SEARCHPARAMS.PartnerFunction = this.partnerFunction;
    }

    // addResult(sr)
    //
    // Add partner to the searchResults
    private PartnerSearchResult addResult(SBO_SFCIPartner_Search.SEARCHRESULT sr, Integer index)
    {
        PartnerSearchResult partner = new PartnerSearchResult();
        partner.index = index;
        //Replaces the leading 0s with an empty string
        partner.partnerNumber = sr.PartnerNumber.replaceFirst('^0+(?!$)','');
        partner.salesOrg = sr.SalesOrganization;
        partner.distChannel = sr.DistributionChannel;
        partner.division = sr.Division;
        partner.name = sr.PartnerName;
        partner.address = buildAddress(sr.Street, sr.City, sr.Region, sr.PostalCode);
        partner.country = sr.Country;

        return partner;
    }

    // addResult(sr)
    //
    // Add customer to the searchResults
    private PartnerSearchResult addResult(SBO_EnosixCustomer_Search.SEARCHRESULT sr, Integer index)
    {
        PartnerSearchResult partner = new PartnerSearchResult();
        partner.index = index;
        //Replaces the leading 0s with an empty string
        partner.partnerNumber = sr.CustomerNumber.replaceFirst('^0+(?!$)','');
        partner.name = sr.Name;
        partner.address = buildAddress(sr.Street, sr.City, sr.Region, sr.PostalCode);
        partner.country = sr.CountryKey;

        return partner;
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

    // actionSelectedPartnerToReceiver()
    //
    // Action when selecting the address
    public void actionSelectedPartnerToReceiver()
    {
        Integer selectedIndex = Integer.valueOf(System.currentPageReference().getParameters().get('selectedIndex'));

        PartnerSearchResult partner = null;
        Integer resultTot = this.searchResults.size();
        for (Integer resultCnt = 0 ; resultCnt < resultTot ; resultCnt++)
        {         
            PartnerSearchResult result = this.searchResults[resultCnt];   
            if (result.index == selectedIndex)
            {
                partner = result;
                partner.partnerFunction = this.partnerFunction;
                break;
            }
        }

        if (null != partner)
        {
            // this.searchResults = null;
            this.searchReceiver.onReceivePartnerSearch(partner);
        }
    }
}