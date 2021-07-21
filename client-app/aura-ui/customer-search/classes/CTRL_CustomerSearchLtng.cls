public class CTRL_CustomerSearchLtng
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_PartnerSearchLtng.class);

    @AuraEnabled
    public static UTIL_Aura.Response searchCustomers(Map<String, Object> pagingOptions, Boolean isContactSearch, Map<String, Object> searchParams)
    {
        logger.enterAura('searchCustomers', new Map<String, Object>{
            'pagingOptions' => pagingOptions,
            'isContactSearch' => isContactSearch,
            'searchParams' => searchParams
        });

        SBO_EnosixCustomer_Search sbo = new SBO_EnosixCustomer_Search();
        String results = '';
        Object responsePagingOptions = null;

        try
        {
            SBO_EnosixCustomer_Search.EnosixCustomer_SC searchContext = new SBO_EnosixCustomer_Search.EnosixCustomer_SC();
            
            if (isContactSearch == true) {
                // Mapping for contact search
                searchContext.CONTACT_PERSON.CustomerNumber = (String) searchParams.get('customerNumber');
                searchContext.CONTACT_PERSON.BusinessPartnerFrom = (String) searchParams.get('fromPartnerNumber');
                searchContext.CONTACT_PERSON.BusinessPartnerTo = (String) searchParams.get('toPartnerNumber');
                searchContext.CONTACT_PERSON.FirstName = (String) searchParams.get('firstName');
                searchContext.CONTACT_PERSON.LastName = (String) searchParams.get('lastName');
                searchContext.CONTACT_PERSON.ContactPersonFlag = (String) searchParams.get('contactSearch');
                searchContext.CONTACT_PERSON.SalesEmployeeFlag = (String) searchParams.get('personnelSearch');
            }
            else {
                // Mapping for customer search
                searchContext.SEARCHPARAMS.CustomerNumberFrom = (String) searchParams.get('customerNumberFrom');
                searchContext.SEARCHPARAMS.CustomerNumberTo = (String) searchParams.get('customerNumberTo');
                searchContext.SEARCHPARAMS.CustomerName = (String) searchParams.get('name');
                searchContext.SEARCHPARAMS.PostalCode = (String) searchParams.get('postalCode');
                searchContext.SEARCHPARAMS.City = (String) searchParams.get('city');
                searchContext.SEARCHPARAMS.Region = (String) searchParams.get('region');
                searchContext.SEARCHPARAMS.CountryKey = (String) searchParams.get('country');
                searchContext.SEARCHPARAMS.TelephoneNO = (String) searchParams.get('telephone');
                searchContext.SEARCHPARAMS.EMailAddress = (String) searchParams.get('email');
            }
            
            UTIL_Aura.setSearchContextPagingOptions(searchContext, pagingOptions);

            sbo.search(searchContext);
            List<CustomerSearchResult> searchResults = convertCustomerSearchResult(searchContext.result.getResults());
            if (searchResults.size() > 0) results = JSON.serialize(searchResults);  
            responsePagingOptions = searchContext.pagingOptions;                   
        }        
        catch (Exception ex)
        {
            UTIL_PageMessages.addExceptionMessage(ex);
        }

        return UTIL_Aura.createResponse(results, responsePagingOptions);        
    }

    private static List<CustomerSearchResult> convertCustomerSearchResult(List<SBO_EnosixCustomer_Search.SEARCHRESULT> results)
    {
        List<CustomerSearchResult> customerSearchResults = new List<CustomerSearchResult>();
        for (SBO_EnosixCustomer_Search.SEARCHRESULT result : results)
        {
            CustomerSearchResult searchResult = new CustomerSearchResult();
            searchResult.CustomerNumber = result.CustomerNumber;
            searchResult.Name = result.Name;
            searchResult.Name2 = result.Name2;
            searchResult.Street = result.Street;
            searchResult.City = result.City;
            searchResult.PostalCode = result.PostalCode;
            searchResult.Region = result.Region;
            searchResult.Country = result.CountryKey;
            searchResult.POBox = result.POBox;
            searchResult.TelephoneNumber = result.TelephoneNO;
            searchResult.Language = result.Language;
            searchResult.EmailAddress = result.EMailAddress;
            customerSearchResults.add(searchResult);
        }

        return customerSearchResults;
    }

    @AuraEnabled
    public static UTIL_Aura.Response searchVendors(Map<String, Object> pagingOptions, Map<String, Object> searchParams)
    {
        logger.enterAura('searchVendors', new Map<String, Object>{
            'pagingOptions' => pagingOptions,
            'searchParams' => searchParams
        });

        SBO_EnosixVendor_Search sbo = new SBO_EnosixVendor_Search();
        String results = '';
        Object responsePagingOptions = null;

        try
        {
            SBO_EnosixVendor_Search.EnosixVendor_SC searchContext = new SBO_EnosixVendor_Search.EnosixVendor_SC();

            searchContext.VENDOR.FromVendor = (String) searchParams.get('customerNumberFrom');
            searchContext.VENDOR.ToVendor = (String) searchParams.get('customerNumberTo');
            searchContext.VENDOR.Name = (String) searchParams.get('name');
            searchContext.VENDOR.Name2 = (String) searchParams.get('name2');

            UTIL_Aura.setSearchContextPagingOptions(searchContext, pagingOptions);

            sbo.search(searchContext);
            List<CustomerSearchResult> searchResults = convertVendorSearchResult(searchContext.result.getResults());
            if (searchResults.size() > 0) results = JSON.serialize(searchResults);  
            responsePagingOptions = searchContext.pagingOptions; 
        }
        catch (Exception ex)
        {
            UTIL_PageMessages.addExceptionMessage(ex);
        }

        return UTIL_Aura.createResponse(results, responsePagingOptions);
    }

    private static List<CustomerSearchResult> convertVendorSearchResult(List<SBO_EnosixVendor_Search.SEARCHRESULT> results)
    {
        List<CustomerSearchResult> customerSearchResults = new List<CustomerSearchResult>();
        for (SBO_EnosixVendor_Search.SEARCHRESULT result : results)
        {
            CustomerSearchResult searchResult = new CustomerSearchResult();
            searchResult.CustomerNumber = result.Vendor;
            searchResult.Name = result.Name;
            searchResult.Name2 = result.Name2;
            searchResult.Street = result.Street;
            searchResult.City = result.City;
            searchResult.PostalCode = result.PostalCode;
            searchResult.Region = result.Region;
            searchResult.Country = result.Country;
            searchResult.POBox = result.POBox;
            searchResult.TelephoneNumber = result.TelephoneNumber;
            searchResult.Language = result.Language;
            searchResult.EmailAddress = result.EMailAddress;
            customerSearchResults.add(searchResult);
        }

        return customerSearchResults;
    }

    public class CustomerSearchResult
    {
        @AuraEnabled public String CustomerNumber { get; set; }
        @AuraEnabled public String Name { get; set; }
        @AuraEnabled public String Name2 { get; set; }
        @AuraEnabled public String Street { get; set; }
        @AuraEnabled public String City { get; set; }
        @AuraEnabled public String PostalCode { get; set; }
        @AuraEnabled public String Region { get; set; }
        @AuraEnabled public String Country { get; set; }
        @AuraEnabled public String POBox { get; set; }
        @AuraEnabled public String TelephoneNumber { get; set; }
        @AuraEnabled public String Language { get; set; }
        @AuraEnabled public String EmailAddress { get; set; }
    }
}