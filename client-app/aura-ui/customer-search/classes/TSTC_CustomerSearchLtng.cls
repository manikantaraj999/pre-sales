@isTest
public class TSTC_CustomerSearchLtng
{
    public class MOC_SBO_EnosixCustomer_Search implements ensxsdk.EnosixFramework.SearchSBOSearchMock
    {
        public Boolean success = true;

        public void setSuccess(Boolean successfull)
        {
            this.success = successfull;
        }

        private boolean throwException = false;

        public void setThrowException(boolean throwException)
        {
            this.throwException = throwException;
        }

        public ensxsdk.EnosixFramework.SearchContext executeSearch(ensxsdk.EnosixFramework.SearchContext searchContext)
        {
            if (throwException) throw new CalloutException();

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

    public class MOC_SBO_EnosixVendor_Search implements ensxsdk.EnosixFramework.SearchSBOSearchMock
    {
        public Boolean success = true;

        public void setSuccess(Boolean successfull)
        {
            this.success = successfull;
        }

        private boolean throwException = false;

        public void setThrowException(boolean throwException)
        {
            this.throwException = throwException;
        }

        public ensxsdk.EnosixFramework.SearchContext executeSearch(ensxsdk.EnosixFramework.SearchContext searchContext)
        {
            if (throwException) throw new CalloutException();

            SBO_EnosixVendor_Search.EnosixVendor_SR sr = new SBO_EnosixVendor_Search.EnosixVendor_SR();
            SBO_EnosixVendor_Search.SEARCHRESULT result = new SBO_EnosixVendor_Search.SEARCHRESULT();
            result.Vendor = '1234';
            result.Name = 'Bob';
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

    @isTest
    public static void test_searchCustomers()
    {
        MOC_SBO_EnosixCustomer_Search mocSboEnosixCustomerSearch = new MOC_SBO_EnosixCustomer_Search();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustomer_Search.class, mocSboEnosixCustomerSearch);

        Map<String, Object> pagingOptions = new Map<String, Object>();
        Map<String, Object> searchParams = new Map<String, Object>();

        UTIL_Aura.Response response = CTRL_CustomerSearchLtng.searchCustomers(pagingOptions, true, searchParams);
        response = CTRL_CustomerSearchLtng.searchCustomers(pagingOptions, false, searchParams);

        mocSboEnosixCustomerSearch.setThrowException(true);
        response = CTRL_CustomerSearchLtng.searchCustomers(pagingOptions, true, searchParams);
    }

    @isTest
    public static void test_searchVendors()
    {
        MOC_SBO_EnosixVendor_Search mocSboEnosixVendorSearch = new MOC_SBO_EnosixVendor_Search();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixVendor_Search.class, mocSboEnosixVendorSearch);

        Map<String, Object> pagingOptions = new Map<String, Object>();
        Map<String, Object> searchParams = new Map<String, Object>();

        UTIL_Aura.Response response = CTRL_CustomerSearchLtng.searchVendors(pagingOptions, searchParams);

        mocSboEnosixVendorSearch.setThrowException(true);
        response = CTRL_CustomerSearchLtng.searchVendors(pagingOptions, searchParams);
    }
}