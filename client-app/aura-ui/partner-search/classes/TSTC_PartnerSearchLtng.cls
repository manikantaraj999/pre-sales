@isTest
public class TSTC_PartnerSearchLtng
{
    public class MOC_SBO_SFCIPartner_Search implements ensxsdk.EnosixFramework.SearchSBOSearchMock
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

    @isTest
    public static void test_searchPartners()
    {
        MOC_SBO_SFCIPartner_Search mocSboEnosixPartnerSearch = new MOC_SBO_SFCIPartner_Search();
        ensxsdk.EnosixFramework.setMock(SBO_SFCIPartner_Search.class, mocSboEnosixPartnerSearch);

        String customerNumber = '111';
        String partnerFunction = 'SH';
        String salesOrg = '1000';
        String distChannel = '10';
        String division = '00';
        Map<String, Object> pagingOptions = new Map<String, Object>();

        UTIL_Aura.Response response = CTRL_PartnerSearchLtng.searchPartners(customerNumber, partnerFunction, salesOrg, distChannel, division, pagingOptions);
        mocSboEnosixPartnerSearch.setThrowException(true);
        response = CTRL_PartnerSearchLtng.searchPartners(customerNumber, partnerFunction, salesOrg, distChannel, division, pagingOptions);
    }
}