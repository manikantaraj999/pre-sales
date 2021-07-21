@isTest public with sharing class TSTC_CPQ_Sales_Org
{
    private static final string TEST_JSON =
        '{"GenericCustomerSalesOrgs":["1000","2000"],' + 
        '"SalesOrgList": ["1000"],' +
        '"DistributionChannelList": ["01"],' +
        '"DivisionList": ["01"],' +
        '"DefaultCustomerNumber":"TEST"}';

    @isTest public static void test_getInfo() {
        UTIL_AppSettings.settingsMap.put(UTIL_AppSettings.Prefix + UTIL_AppSettings.CPQ + UTIL_AppSettings.Suffix, (Map<String, Object>)JSON.deserializeUntyped(TEST_JSON));
        
        Test.startTest();
        SBQQ__Quote__c quote = TSTU_SFCPQQuote.createTestQuote();
        TSTU_SFTestObject.upsertWithRetry(quote);
        UTIL_Aura.Response resp = CTRL_CPQ_Sales_Org.getInfo(quote.Id);
        quote.FLD_Sales_Organization__c = 'SO';
        quote.FLD_Distribution_Channel__c = 'DC';
        quote.FLD_Division__c = 'D';
        TSTU_SFTestObject.upsertWithRetry(quote);
        resp = CTRL_CPQ_Sales_Org.getInfo(quote.Id);
        Test.stopTest();
    }

    @isTest public static void test_getSalesAreaList() {
        UTIL_AppSettings.settingsMap.put(UTIL_AppSettings.Prefix + UTIL_AppSettings.CPQ + UTIL_AppSettings.Suffix, (Map<String, Object>)JSON.deserializeUntyped(TEST_JSON));
        
        Test.startTest();
        MockSBO_EnosixCustomer_Detail cdmock = new MockSBO_EnosixCustomer_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustomer_Detail.class, cdmock);
        cdmock.setSuccess(false);
        UTIL_Aura.Response resp = CTRL_CPQ_Sales_Org.getSalesAreaList(null);
        resp = CTRL_CPQ_Sales_Org.getSalesAreaList('TEST');
        cdmock.setSuccess(true);
        cdmock.setReturnSales(false);
        resp = CTRL_CPQ_Sales_Org.getSalesAreaList('TEST');
        cdmock.setReturnSales(true);
        resp = CTRL_CPQ_Sales_Org.getSalesAreaList('TEST');
        cdmock.setThrowException(true);
        resp = CTRL_CPQ_Sales_Org.getSalesAreaList('TEST');
        Test.stopTest();
    }

    @isTest public static void test_updateInfo() {
        UTIL_AppSettings.settingsMap.put(UTIL_AppSettings.Prefix + UTIL_AppSettings.CPQ + UTIL_AppSettings.Suffix, (Map<String, Object>)JSON.deserializeUntyped(TEST_JSON));
        
        Test.startTest();
        SBQQ__Quote__c quote = TSTU_SFCPQQuote.createTestQuote();
        TSTU_SFTestObject.upsertWithRetry(quote);
        Map<String,Object> params = new Map<String,Object>();
        UTIL_Aura.Response resp = CTRL_CPQ_Sales_Org.updateInfo(params);
        params.put('quoteId', quote.Id);
        resp = CTRL_CPQ_Sales_Org.updateInfo(params);
        params.put('quoteId', 'bad Id');
        resp = CTRL_CPQ_Sales_Org.updateInfo(params);
        Test.stopTest();
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

        private boolean returnSales = true;

        public void setReturnSales(boolean returnSales)
        {
            this.returnSales = returnSales;
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
            result.CustomerNumber = 'TEST';
            if (this.returnSales)
            {
                SBO_EnosixCustomer_Detail.SALES_DATA sd1 = new SBO_EnosixCustomer_Detail.SALES_DATA();
                sd1.SalesOrganization = '3000';
                sd1.DistributionChannel = '10';
                sd1.Division = '10';
                result.SALES_DATA.add(sd1);
                SBO_EnosixCustomer_Detail.SALES_DATA sd2 = new SBO_EnosixCustomer_Detail.SALES_DATA();
                sd2.SalesOrganization = '1000';
                sd2.DistributionChannel = '10';
                sd2.Division = '10';
                result.SALES_DATA.add(sd2);
                SBO_EnosixCustomer_Detail.SALES_DATA sd3 = new SBO_EnosixCustomer_Detail.SALES_DATA();
                sd3.SalesOrganization = '1000';
                sd3.DistributionChannel = '01';
                sd3.Division = '10';
                result.SALES_DATA.add(sd3);
                SBO_EnosixCustomer_Detail.SALES_DATA sd4 = new SBO_EnosixCustomer_Detail.SALES_DATA();
                sd4.SalesOrganization = '1000';
                sd4.DistributionChannel = '01';
                sd4.Division = '01';
                result.SALES_DATA.add(sd4);
            }
            
            result.setSuccess(this.success);
            return result;
        }

        public ensxsdk.EnosixFramework.DetailObject executeSave(ensxsdk.EnosixFramework.DetailObject obj) 
        { 
            return null; 
        }
    }
}