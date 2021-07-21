public with sharing class CTRL_ShipToSearch implements I_SearchController
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_ShipToSearch.class);

    public SBO_SFCIPartner_Search.SEARCHPARAMS searchParams { get; set; }
    private boolean searchResultsLoaded = false;
    public I_SearchController searchController { get { return this; } }
    public SBO_SFCIPartner_Search.SFCIPartner_SC searchContext { get; set; }
    public Boolean hasRecords { get; private set; }
    public UTIL_PagingOptionsWrapper pagingOptionsWrapper { get; private set; }

    public List<ShipToSearchResult> searchResults
    {
        get; private set;
    }

    public ShipToSearchResult selectedAddress { get; set; }
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

    public CB_ShipToSearchReceiver searchReceiver
    {
        get;
        set
        {
            this.searchReceiver = value;
        }
    }

    public class ShipToSearchResult
    {
        public Integer index { get; set; }
        public String shipToNumber { get; set; }
        public String salesOrg { get; set; }
        public String distChannel { get; set; }
        public String division { get; set; }
        public String name { get; set; }
        public String address { get; set; }
        public String country { get; set; }
        public String phoneNumber { get; set; }
    }

    // ctor()
    public CTRL_ShipToSearch()
    {
        this.searchContext = new SBO_SFCIPartner_Search.SFCIPartner_SC();
        this.selectedAddress = new ShipToSearchResult();
        resetSearchContext();
        this.isInitialLoad = true;
        this.searchParams = new SBO_SFCIPartner_Search.SEARCHPARAMS();
    }

    // initialLoad()
    //
    // Method to check if all assignTo attribute is set
    private void initialLoad()
    {
        if (this.isSoldToPartyNumberSet && this.isAutoSearchEnabledSet)
        {
            initialize();
        }
    }

    public void initialize()
    {
        if (this.isInitialLoad && this.isAutoSearchEnabled)
        {
            runSearch();
            searchResultsLoaded = true;
        }
        this.isInitialLoad = false;
    }

    // resetSearchResults()
    //
    // Action method to search shipTo address
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
        this.searchContext = new SBO_SFCIPartner_Search.SFCIPartner_SC();
        this.pagingOptionsWrapper = new UTIL_PagingOptionsWrapper(this.searchContext.pagingOptions);
        this.searchContext.pagingOptions.pageSize = pageSize;
        this.searchContext.pagingOptions.pageNumber = 1;
        this.hasRecords = false;
    }

    // searchShipTo()
    //
    // Action method to search shipTo address
    public void runSearch()
    {
        List<ShipToSearchResult> results = null;
        SBO_SFCIPartner_Search sbo = new SBO_SFCIPartner_Search();

        if (!String.isBlank(this.soldToPartyNumber))
        {
            this.searchContext.SEARCHPARAMS.CustomerNumber = this.soldToPartyNumber;
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
            this.searchContext.SEARCHPARAMS.PartnerFunction = UTIL_Customer.SHIP_TO_PARTNER_CODE;
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
                results = new List<ShipToSearchResult>();
                Integer index = 0;
                List<SBO_SFCIPartner_Search.SEARCHRESULT> resultList = result.getResults();
                Integer resultTot = resultList.size();
                for (Integer resultCnt = 0 ; resultCnt < resultTot ; resultCnt++)
                {         
                    SBO_SFCIPartner_Search.SEARCHRESULT sr = resultList[resultCnt];   
                    results.add(addShipToResult(sr, index));
                    index++;
                }
            }
        }
        this.searchResults = results;
    }

    // addShipToResult(sr)
    //
    // Add shipTo to the searchResults
    private ShipToSearchResult addShipToResult(SBO_SFCIPartner_Search.SEARCHRESULT sr, Integer index)
    {
        ShipToSearchResult shipTo = new ShipToSearchResult();
        shipTo.index = index;
        //Replaces the leading 0s with an empty string
        shipTo.shipToNumber = sr.PartnerNumber.replaceFirst('^0+(?!$)','');
        shipTo.salesOrg = sr.SalesOrganization;
        shipTo.distChannel = sr.DistributionChannel;
        shipTo.division = sr.Division;
        shipTo.name = sr.PartnerName;
        shipTo.address = buildShipToAddress(sr.Street, sr.City, sr.Region, sr.PostalCode);
        shipTo.country = sr.Country;

        return shipTo;
    }

    // buildShipToAddress
    //
    // Build the address
    private String buildShipToAddress(String street, String city, String region, String postalCode)
    {
        String area = '\n' + city + ', ' + region + ' ' + postalCode;
        return street + area;
    }

    // selectAddress()
    //
    // Action when selecting the address
    public void actionSelectedAddressToReceiver()
    {
        Integer selectedIndex = Integer.valueOf(System.currentPageReference().getParameters().get('selectedIndex'));

        ShipToSearchResult shipTo = null;
        Integer srTot = this.searchResults.size();
        for (Integer srCnt = 0 ; srCnt < srTot ; srCnt++)
        {
            ShipToSearchResult result = this.searchResults[srCnt];
            if (result.index == selectedIndex)
            {
                shipTo = result;
                break;
            }
        }

        if (null != shipTo)
        {
            this.searchReceiver.onReceiveShipToSearch(shipTo);
        }
    }

    //goToCloneNewShipTo()
    //
    // Action to go to create new ShipTo page
    public PageReference goToCloneNewShipTo()
    {
        Integer selectedIndex = Integer.valueOf(System.currentPageReference().getParameters().get('selectedIndex'));
        ShipToSearchResult shipTo = null;

        Integer srTot = this.searchResults.size();
        for (Integer srCnt = 0 ; srCnt < srTot ; srCnt++)
        {
            ShipToSearchResult result = this.searchResults[srCnt];
            if (result.index == selectedIndex)
            {
                shipTo = result;
                break;
            }
        }

        UTIL_PageState.current.sapPreviousScreen = this.previousScreen;
        UTIL_PageState.current.sapAddPartnerTo = this.soldToPartyNumber;
        UTIL_PageState.current.sapShipToNum = shipTo.shipToNumber;
        UTIL_PageState.current.sapSalesArea = shipTo.salesOrg + ',' + shipTo.distChannel + ',' + shipTo.division;
        UTIL_PageState.current.sapPartnerType = UTIL_Customer.SHIP_TO_PARTNER_CODE;

        return UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_CustomerCreateUpdate, UTIL_PageState.current);
    }
}