/// enosiX Inc. Generated Apex Model
/// Generated On: 7/17/2018 8:36:26 PM
/// SAP Host: From REST Service On: https://computing-velocity-5898-dev-ed.cs54.my.salesforce.com
/// CID: From REST Service On: https://computing-velocity-5898-dev-ed.cs54.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
private class TSTC_CPQ_Partners
{
    @isTest
    static void test_getPartnerList()
    {
        MockSBO_EnosixCustomer_Detail cdmock = new MockSBO_EnosixCustomer_Detail();
        MockSBO_SFCICustomer_Search cmock = new MockSBO_SFCICustomer_Search(true);
        MockSBO_SFCIPartner_Search pmock = new MockSBO_SFCIPartner_Search();

        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustomer_Detail.class, cdmock);
        ensxsdk.EnosixFramework.setMock(SBO_SFCICustomer_Search.class, cmock);
        ensxsdk.EnosixFramework.setMock(SBO_SFCIPartner_Search.class, pmock);

        cdmock.setSuccess(false);
        Account acct = TSTU_SFTestObject.createTestAccount();
        acct.put(UTIL_SFAccount.CustomerFieldName,'CustNum');
    	TSTU_SFTestObject.upsertWithRetry(acct);
        SBQQ__Quote__c quote = TSTU_SFCPQQuote.createTestQuote();
        TSTU_SFTestObject.upsertWithRetry(quote);
        UTIL_Aura.Response rslt = CTRL_CPQ_Partners.getPartnerList(null, 'soldToParty');
        rslt = CTRL_CPQ_Partners.getPartnerList(quote.Id, 'soldToParty');
        quote.SBQQ__Account__c = acct.Id;
        quote.FLD_Sales_Organization__c = 'SO';
        quote.FLD_Distribution_Channel__c = 'DC';
        quote.FLD_Division__c = 'D';
        TSTU_SFTestObject.upsertWithRetry(quote);
        rslt = CTRL_CPQ_Partners.getPartnerList(quote.Id, 'soldToParty');
        rslt = CTRL_CPQ_Partners.getPartnerList(quote.Id, 'shipToParty');
        rslt = CTRL_CPQ_Partners.getPartnerList(quote.Id, 'billToParty');
        rslt = CTRL_CPQ_Partners.getPartnerList(quote.Id, 'payerParty');
        rslt = CTRL_CPQ_Partners.getPartnerList(quote.Id, 'badPartnerField');
        cdmock.setSuccess(true);
        cdmock.setThrowException(true);
        rslt = CTRL_CPQ_Partners.getPartnerList(quote.Id, 'soldToParty');
        cdmock.setThrowException(false);
        rslt = CTRL_CPQ_Partners.getPartnerList(quote.Id, 'soldToParty');
        pmock.setReturn(false);
        rslt = CTRL_CPQ_Partners.getPartnerList(quote.Id, 'soldToParty');
    }

    @isTest
    static void test_updatePartner()
    {
        MockSBO_EnosixCustomer_Detail cdmock = new MockSBO_EnosixCustomer_Detail();
        MockSBO_SFCICustomer_Search cmock = new MockSBO_SFCICustomer_Search(true);
        MockSBO_SFCIPartner_Search pmock = new MockSBO_SFCIPartner_Search();

        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustomer_Detail.class, cdmock);
        ensxsdk.EnosixFramework.setMock(SBO_SFCICustomer_Search.class, cmock);
        ensxsdk.EnosixFramework.setMock(SBO_SFCIPartner_Search.class, pmock);

        cdmock.setSuccess(false);
        Account acct = TSTU_SFTestObject.createTestAccount();
        acct.put(UTIL_SFAccount.CustomerFieldName,'CustNum');
    	TSTU_SFTestObject.upsertWithRetry(acct);
        SBQQ__Quote__c quote = TSTU_SFCPQQuote.createTestQuote();
        quote.FLD_Sales_Organization__c = 'SO';
        quote.FLD_Distribution_Channel__c = 'DC';
        quote.FLD_Division__c = 'D';
        TSTU_SFTestObject.upsertWithRetry(quote);
        Map<String, Object> params = new Map<String, Object>();
        UTIL_Aura.Response rslt = CTRL_CPQ_Partners.updatePartner(params);
        params.put('quoteId',quote.Id);
        rslt = CTRL_CPQ_Partners.updatePartner(params);
        params.put('partnerJSON',JSON.serialize(new Map<String, Object>()));
        rslt = CTRL_CPQ_Partners.updatePartner(params);
        params.put('partnerField','shipToParty');
        rslt = CTRL_CPQ_Partners.updatePartner(params);
        params.put('partnerField','billToParty');
        rslt = CTRL_CPQ_Partners.updatePartner(params);
        params.put('partnerField','payerParty');
        rslt = CTRL_CPQ_Partners.updatePartner(params);
        cdmock.setSuccess(true);
        cdmock.setThrowException(true);
        rslt = CTRL_CPQ_Partners.updatePartner(params);
        cdmock.setThrowException(false);
        rslt = CTRL_CPQ_Partners.updatePartner(params);
        pmock.setReturn(false);
        rslt = CTRL_CPQ_Partners.updatePartner(params);
        
    }

    public class MockSBO_SFCICustomer_Search implements ensxsdk.EnosixFramework.SearchSBOInitMock, ensxsdk.EnosixFramework.SearchSBOSearchMock
    {
        Boolean success = true;

        public MockSBO_SFCICustomer_Search(Boolean success)
        {
            this.success = success;
        }
        
        public ensxsdk.EnosixFramework.SearchContext executeInitialize(ensxsdk.EnosixFramework.SearchContext sc)
        {
            return null;
        }

        public ensxsdk.EnosixFramework.SearchContext executeSearch(ensxsdk.EnosixFramework.SearchContext searchContext)
        {
            SBO_SFCICustomer_Search.SFCICustomer_SR searchResult = new SBO_SFCICustomer_Search.SFCICustomer_SR();

            if (success)
            {
                SBO_SFCICustomer_Search.SEARCHRESULT row = new SBO_SFCICustomer_Search.SEARCHRESULT();
                row.CustomerNumber = 'TEST';
                row.Name = 'TEST';
                searchResult.SearchResults.add(row);
            }

            searchResult.setSuccess(success);
            searchContext.baseResult = searchResult;
            return searchContext;
        }
    }

    public class MockSBO_SFCIPartner_Search implements ensxsdk.EnosixFramework.SearchSBOInitMock, ensxsdk.EnosixFramework.SearchSBOSearchMock
    {
        private boolean returnResults = true;

        public void setReturn(boolean returnResults)
        {
            this.returnResults = returnResults;
        }
        
        public ensxsdk.EnosixFramework.SearchContext executeInitialize(ensxsdk.EnosixFramework.SearchContext sc)
        {
            return null;
        }

        public ensxsdk.EnosixFramework.SearchContext executeSearch(ensxsdk.EnosixFramework.SearchContext sc)
        {
            SBO_SFCIPartner_Search.SFCIPartner_SR search_result = new SBO_SFCIPartner_Search.SFCIPartner_SR();
            SBO_SFCIPartner_Search.SEARCHRESULT result = new SBO_SFCIPartner_Search.SEARCHRESULT();
            
            result.City='TEST';
            result.ContactFirstName = 'TEST';
            result.ContactLastName = 'TEST';
            result.ContactNumber = 'TEST';
            result.Country = 'TEST';
            result.DistributionChannel = 'TEST';
            result.Division = 'TEST';
            result.HouseNumber = 'TEST';
            result.PartnerName = 'TEST';
            result.PartnerNumber = 'TEST';
            result.PartnerFunction = 'TEST';
            result.PartnerFunctionName = 'TEST';
            result.PersonnelFirstName = 'TEST';
            result.PersonnelLastName = 'TEST';
            result.PersonnelNumber = 'TEST';
            result.PostalCode = 'TEST';
            result.Region = 'TEST';
            result.SalesOrganization = 'TEST';
            result.Street = 'TEST';
            result.VendorName = 'TEST';
            result.VendorNumber = 'TEST';

            if (this.returnResults)
            {
                search_result.SearchResults.add(result);
            }

            search_result.setSuccess(true);
            sc.baseResult = search_result;

            return sc;
        }
    }   
    
    public class MockSBO_EnosixCustomer_Detail implements
        ensxsdk.EnosixFramework.DetailSBOInitMock,
        ensxsdk.EnosixFramework.DetailSBOCommandMock,
        ensxsdk.EnosixFramework.DetailSBOGetMock,
        ensxsdk.EnosixFramework.DetailSBOSaveMock
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

        public ensxsdk.EnosixFramework.DetailObject executeInitialize(ensxsdk.EnosixFramework.DetailObject initialState) 
        { 
            return null; 
        }

        public ensxsdk.EnosixFramework.DetailObject executeCommand(String command, ensxsdk.EnosixFramework.DetailObject obj) 
        { 
            return null; 
        }

        public ensxsdk.EnosixFramework.DetailObject executeGetDetail(object key) 
        { 
            if (throwException)
            {
                throw new CalloutException();
            }
            SBO_EnosixCustomer_Detail.EnosixCustomer result = new SBO_EnosixCustomer_Detail.EnosixCustomer();
            
            result.setSuccess(this.success);
            return result;
        }

        public ensxsdk.EnosixFramework.DetailObject executeSave(ensxsdk.EnosixFramework.DetailObject obj) 
        { 
            return null; 
        }
    }
}