@isTest
public class TSTU_Customer
{
    public class MOC_Customer implements ensxsdk.EnosixFramework.DetailSBOGetMock, ensxsdk.EnosixFramework.DetailSBOSaveMock
    {
        private boolean throwException = false;
    	public Boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        public void setThrowException(boolean throwException)
        {
            this.throwException = throwException;
        }

        public ensxsdk.EnosixFramework.DetailObject executeGetDetail(object key)
        {
            SBO_EnosixCustomer_Detail.EnosixCustomer result = new SBO_EnosixCustomer_Detail.EnosixCustomer();
            result.setSuccess(success);
            return result;
        }

        public ensxsdk.EnosixFramework.DetailObject executeSave(ensxsdk.EnosixFramework.DetailObject obj)
        {
            SBO_EnosixCustomer_Detail.EnosixCustomer result = (SBO_EnosixCustomer_Detail.EnosixCustomer) obj;
            result.setSuccess(success);
            if (throwException)
            {
                throw new CalloutException();
            }
            return result;
        }
    }

    public class Mock_SBO_SFCIPartner_Search implements ensxsdk.EnosixFramework.SearchSBOSearchMock
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

        private boolean returnRecord = true;

        public void setReturnRecord(boolean returnRecord)
        {
            this.returnRecord = returnRecord;
        }

        public ensxsdk.EnosixFramework.SearchContext executeSearch(ensxsdk.EnosixFramework.SearchContext searchContext)
        {
            SBO_SFCIPartner_Search.SFCIPartner_SR search_result = new SBO_SFCIPartner_Search.SFCIPartner_SR();

            SBO_SFCIPartner_Search.SEARCHRESULT result = new SBO_SFCIPartner_Search.SEARCHRESULT();

            if (returnRecord)
            {
                result.PartnerFunctionName = 'PartnerFunctionName';
                result.PartnerFunction = 'SP';
                result.PartnerNumber = 'PARTNER_NUM';
                result.PartnerName = 'PARTNER_NAME';
                result.HouseNumber = 'HouseNumber';
                result.Street = 'Street';
                result.City = 'City';
                result.Region = 'Region';
                result.PostalCode = 'PostalCode';

                search_result.SearchResults.add(result);
            }

            search_result.setSuccess(success);
            searchContext.baseResult = search_result;
			return searchContext;
        }
    }

    @isTest
    static void test_TouchProps()
    {
        Test.startTest();
        String soldTo = UTIL_Customer.SOLD_TO_PARTNER_CODE;
        String shipTo = UTIL_Customer.SHIP_TO_PARTNER_CODE;
        String carrier = UTIL_Customer.CARRIER_PARTNER_CODE;
        String billTo = UTIL_Customer.BILL_TO_PARTNER_CODE;
        Test.stopTest();
    }

    @isTest
    static void test_CustomerNotFoundException()
    {
        UTIL_Customer.CustomerNotFoundException cnfe = new UTIL_Customer.CustomerNotFoundException('cust#', new List<ensxsdk.EnosixFramework.Message>());
        cnfe.getMessage();
        cnfe.getSAPMessages();
    }

    @isTest
    static void test_allowedClientTypes()
    {
        Test.startTest();
        Set<String> clientTypes = UTIL_Customer.allowedClientTypes;
        Test.stopTest();
    }

    @isTest
    static void test_getCustomerByNumber()
    {
        MOC_Customer mockCustomer = new MOC_Customer();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustomer_Detail.class, mockCustomer);

        Test.startTest();
        SBO_EnosixCustomer_Detail.EnosixCustomer result = UTIL_Customer.getCustomerByNumber('Id');
        mockCustomer.setSuccess(false);
        result = UTIL_Customer.getCustomerByNumber('Id');
        Test.stopTest();
    }

    @isTest
    static void test_saveCustomer()
    {
        MOC_Customer mockCustomer = new MOC_Customer();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustomer_Detail.class, mockCustomer);

        Test.startTest();
        SBO_EnosixCustomer_Detail.EnosixCustomer customer= new SBO_EnosixCustomer_Detail.EnosixCustomer();
        SBO_EnosixCustomer_Detail.EnosixCustomer result = UTIL_Customer.saveCustomer(customer);
        mockCustomer.setSuccess(false);
        result = UTIL_Customer.saveCustomer(customer);
        mockCustomer.setSuccess(true);
        result = UTIL_Customer.saveCustomer(customer);
        mockCustomer.setThrowException(true);
        result = UTIL_Customer.saveCustomer(customer);
        Test.stopTest();
    }

    @isTest
    static void test_reddirect()
    {
        Test.startTest();
        UTIL_Customer.redirectToEditCustomer();
        UTIL_Customer.redirectToDisplayCustomer();
        UTIL_Customer.redirectToCreateCustomer();
        Test.stopTest();
    }

    @isTest
    static void test_getPartnerFromCustomer()
    {
        Mock_SBO_SFCIPartner_Search mocSboSfciPartner = new Mock_SBO_SFCIPartner_Search();
        ensxsdk.EnosixFramework.setMock(SBO_SFCIPartner_Search.class, mocSboSfciPartner);

        Test.startTest();
        SBO_EnosixCustomer_Detail.EnosixCustomer customer = new SBO_EnosixCustomer_Detail.EnosixCustomer();
        customer.CustomerNumber = 'getPartnerFromCustomer';
        UTIL_Customer.getPartnerFromCustomer(customer, UTIL_Customer.SOLD_TO_PARTNER_CODE);
        Test.stopTest();
    }

    @isTest
    static void test_getCustomerPartners()
    {
        Mock_SBO_SFCIPartner_Search mocSboSfciPartner = new Mock_SBO_SFCIPartner_Search();
        ensxsdk.EnosixFramework.setMock(SBO_SFCIPartner_Search.class, mocSboSfciPartner);

        Test.startTest();
        SBO_EnosixCustomer_Detail.EnosixCustomer customer = new SBO_EnosixCustomer_Detail.EnosixCustomer();
        customer.CustomerNumber = 'getCustomerPartners';
        UTIL_Customer.getCustomerPartners(customer, UTIL_Customer.SOLD_TO_PARTNER_CODE);
        Test.stopTest();
    }

    @isTest
    static void test_getPartners()
    {
        Mock_SBO_SFCIPartner_Search mocSboSfciPartner = new Mock_SBO_SFCIPartner_Search();
        ensxsdk.EnosixFramework.setMock(SBO_SFCIPartner_Search.class, mocSboSfciPartner);

        Test.startTest();
        SBO_EnosixCustomer_Detail.EnosixCustomer customer = new SBO_EnosixCustomer_Detail.EnosixCustomer();
        customer.CustomerNumber = 'getPartners';
        mocSboSfciPartner.setSuccess(false);
        UTIL_Customer.getPartners(customer);
        mocSboSfciPartner.setSuccess(true);
        UTIL_Customer.getPartners(customer);
        UTIL_Customer.getPartners(customer);
        Test.stopTest();
    }

    @isTest
    static void test_AddPartners()
    {
        Test.startTest();
        List<SelectOption> result = new List<SelectOption>();
        List<SBO_SFCIPartner_Search.SEARCHRESULT> partners = new List<SBO_SFCIPartner_Search.SEARCHRESULT>();
        SBO_SFCIPartner_Search.SEARCHRESULT partner = new SBO_SFCIPartner_Search.SEARCHRESULT();
        partner.PartnerFunction = UTIL_Customer.SOLD_TO_PARTNER_CODE;
        partner.PartnerNumber = 'PartnerNumber';
        partner.PartnerName = 'PartnerName';
        partner.salesOrganization = 'salesOrganization';
        partner.DistributionChannel = 'DistributionChannel';
        partner.Division = 'Division';
        partners.add(partner);
        UTIL_Customer.AddPartners(result, partners, 'salesOrganization', 'DistributionChannel', 'Division');
        List<Account> badObjTypeList = new List<Account>();
        badObjTypeList.add(new Account());
        UTIL_SelectOption.buildOptionsFromList(
            new UTIL_Customer.Partner_OptionBuilder('salesOrganization', 'distributionChannel', 'division'),
            badObjTypeList, false);
        Test.stopTest();
    }

    @isTest
    static void test_getSalesDataListFromCustomer()
    {
        Test.startTest();
        SBO_EnosixCustomer_Detail.EnosixCustomer customer = new SBO_EnosixCustomer_Detail.EnosixCustomer();
        UTIL_Customer.getSalesDataListFromCustomer(customer);
        Test.stopTest();
    }

    @isTest
    static void test_AddSalesOrganizations()
    {
        Test.startTest();
        List<SelectOption> selectOptions = new List<SelectOption>();
        List<SBO_EnosixCustomer_Detail.SALES_DATA> salesDataItems = new List<SBO_EnosixCustomer_Detail.SALES_DATA>();
        SBO_EnosixCustomer_Detail.SALES_DATA salesData = new SBO_EnosixCustomer_Detail.SALES_DATA();
        salesData.SalesOrganization = 'TESTORG1';
        salesData.SalesOrganizationName = 'TESTORGNAME1';
        salesDataItems.add(salesData);
        UTIL_Customer.AddSalesOrganizations(selectOptions, salesDataItems);
        List<Account> badObjTypeList = new List<Account>();
        badObjTypeList.add(new Account());
        UTIL_SelectOption.buildOptionsFromList(
            new UTIL_Customer.SalesOrganization_OptionBuilder(), badObjTypeList, false);
        Test.stopTest();
    }

    @isTest
    static void test_AddDistributionChannels()
    {
        Test.startTest();
        List<SelectOption> selectOptions = new List<SelectOption>();
        List<SBO_EnosixCustomer_Detail.SALES_DATA> salesDataItems = new List<SBO_EnosixCustomer_Detail.SALES_DATA>();
        SBO_EnosixCustomer_Detail.SALES_DATA salesData = new SBO_EnosixCustomer_Detail.SALES_DATA();
        salesData.DistributionChannel = 'DistributionChannel';
        salesData.DistributionChannelName = 'DistributionChannelName';
        salesData.SalesOrganization = 'SalesOrganization';
        salesDataItems.add(salesData);
        UTIL_Customer.AddDistributionChannels(selectOptions, salesDataItems, 'SalesOrganization');
        List<Account> badObjTypeList = new List<Account>();
        badObjTypeList.add(new Account());
        UTIL_SelectOption.buildOptionsFromList(
            new UTIL_Customer.DistributionChannel_OptionBuilder('SalesOrganization'), badObjTypeList, false);
        Test.stopTest();
    }

    @isTest
    static void test_AddDistributionDivisions()
    {
        Test.startTest();
        List<SelectOption> selectOptions = new List<SelectOption>();
        List<SBO_EnosixCustomer_Detail.SALES_DATA> salesDataItems = new List<SBO_EnosixCustomer_Detail.SALES_DATA>();
        SBO_EnosixCustomer_Detail.SALES_DATA salesData = new SBO_EnosixCustomer_Detail.SALES_DATA();
        salesData.DistributionChannel = 'DistributionChannel';
        salesData.DistributionChannelName = 'DistributionChannelName';
        salesData.Division = 'Division';
        salesData.DivisionName = 'DivisionName';
        salesData.SalesOrganization = 'SalesOrganization';
        salesDataItems.add(salesData);
        UTIL_Customer.AddDistributionDivisions(selectOptions, salesDataItems, 'SalesOrganization', 'DistributionChannel');
        List<Account> badObjTypeList = new List<Account>();
        badObjTypeList.add(new Account());
        UTIL_SelectOption.buildOptionsFromList(
            new UTIL_Customer.DistributionDivisions_OptionBuilder('SalesOrganization', 'DistributionChannel'), badObjTypeList, false);
        Test.stopTest();
    }

    @isTest
    public static void test_defaultOptionBuilders()
    {
        UTIL_AppSettings.resourceJson = '{}';

        Test.startTest();
        UTIL_SelectOption.OptionBuilder ob2 = UTIL_Customer.getCustomerConditionOptionBuilder1();
        UTIL_SelectOption.OptionBuilder ob3 = UTIL_Customer.getCustomerConditionOptionBuilder2();
        Test.stopTest();

        System.assert(ob2 instanceof UTIL_Customer.CustomerConditonOptionBuilder);
        System.assert(ob3 instanceof UTIL_Customer.CustomerConditonOptionBuilder);
    }

    @isTest
    public static void test_optionBuilderOverrides()
    {
        UTIL_AppSettings.resourceJson = '{' +
            '"Order.CustomerConditionGroupBuilder1": "TSTU_Customer.OptionBuilder",' +
            '"Order.CustomerConditionGroupBuilder2": "TSTU_Customer.OptionBuilder"' +
        '}';

        Test.startTest();
        UTIL_SelectOption.OptionBuilder ob1 = UTIL_Customer.getCustomerConditionOptionBuilder1();
        UTIL_SelectOption.OptionBuilder ob2 = UTIL_Customer.getCustomerConditionOptionBuilder2();
        Test.stopTest();

        System.assert(ob1 instanceof OptionBuilder);
        System.assert(ob2 instanceof OptionBuilder);
    }

    public class OptionBuilder extends UTIL_SelectOption.OptionBuilder {}

    @isTest
    static void test_CustomerConditonOptionBuilder()
    {
        Test.startTest();
        UTIL_Customer.CustomerConditonOptionBuilder optionBuilder = new UTIL_Customer.CustomerConditonOptionBuilder();
        optionBuilder.getItemValue(new RFC_SD_GET_CONDITION_GROUP.ET_COND_GROUP());
        optionBuilder.getItemDescription(new RFC_SD_GET_CONDITION_GROUP.ET_COND_GROUP());
        optionBuilder.getItemLabel(new RFC_SD_GET_CONDITION_GROUP.ET_COND_GROUP());
        Test.stopTest();
    }
}