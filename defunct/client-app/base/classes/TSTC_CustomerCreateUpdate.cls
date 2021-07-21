/**
 * test class for Customer Create Controllers
 */
@isTest
public with sharing class TSTC_CustomerCreateUpdate
{
    public class MOC_SBO_EnosixCustomer_Detail implements ensxsdk.EnosixFramework.DetailSBOGetMock,
            ensxsdk.EnosixFramework.DetailSBOSaveMock, ensxsdk.EnosixFramework.DetailSBOInitMock, ensxsdk.EnosixFramework.DetailSBOCommandMock
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

        public ensxsdk.EnosixFramework.DetailObject executeGetDetail(object key)
        {
            SBO_EnosixCustomer_Detail.EnosixCustomer result = new SBO_EnosixCustomer_Detail.EnosixCustomer();
            SBO_EnosixCustomer_Detail.SALES_DATA salesData = new SBO_EnosixCustomer_Detail.SALES_DATA();
            salesData.SalesOrganization = 'SalesOrganization';
            salesData.DistributionChannel = 'DistributionChannel';
            salesData.Division = 'Division';
            result.SALES_DATA.add(salesData);
            result.COMPANY_DATA.add(new SBO_EnosixCustomer_Detail.COMPANY_DATA());
            result.PAYMENT_DATA.add(new SBO_EnosixCustomer_Detail.PAYMENT_DATA());
            result.SALES_TEXT.add(new SBO_EnosixCustomer_Detail.SALES_TEXT());
            result.CONTACTS.add(new SBO_EnosixCustomer_Detail.CONTACTS());
            result.CustomerNumber = 'CustomerNumber';
            result.Country = 'US';
            result.setSuccess(this.success);
            return result;
        }

        public ensxsdk.EnosixFramework.DetailObject executeSave(ensxsdk.EnosixFramework.DetailObject obj)
        {
            SBO_EnosixCustomer_Detail.EnosixCustomer result = (SBO_EnosixCustomer_Detail.EnosixCustomer) obj;
            result.setSuccess(this.success);
            if (throwException)
            {
                throw new CalloutException();
            }
            return result;
        }

        public ensxsdk.EnosixFramework.DetailObject executeCommand(string command, ensxsdk.EnosixFramework.DetailObject obj)
        {
            SBO_EnosixCustomer_Detail.EnosixCustomer result = (SBO_EnosixCustomer_Detail.EnosixCustomer) obj;
            result.setSuccess(!this.success);
            if (throwException)
            {
                throw new CalloutException();
            }
            return result;
        }

        public ensxsdk.EnosixFramework.DetailObject executeInitialize(ensxsdk.EnosixFramework.DetailObject  initialState)
        {
            SBO_EnosixCustomer_Detail.EnosixCustomer result = new SBO_EnosixCustomer_Detail.EnosixCustomer();
            result.setSuccess(this.success);
            return result;
        }
    }

    public class MOC_RFC_SD_GET_COUNTRIES implements ensxsdk.EnosixFramework.RFCMock
    {
        public boolean success = false;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            RFC_SD_GET_COUNTRIES.RESULT result = new RFC_SD_GET_COUNTRIES.RESULT();
            RFC_SD_GET_COUNTRIES.ET_REGIONS region = new RFC_SD_GET_COUNTRIES.ET_REGIONS();
            region.LAND1 = 'US';
            region.REGIO = 'REGIO';
            result.getCollection(RFC_SD_GET_COUNTRIES.ET_REGIONS.class).add(region);
            result.setSuccess(this.success);
            return result;
        }
    }

    public class MOC_RFC_SD_GET_GROUP_OFFICE implements ensxsdk.EnosixFramework.RFCMock
    {
        public boolean success = false;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            RFC_SD_GET_GROUP_OFFICE.RESULT result = new RFC_SD_GET_GROUP_OFFICE.RESULT();
            result.setSuccess(this.success);
            return result;
        }
    }

    public class MOC_RFC_SD_GET_PRICING_STAT implements ensxsdk.EnosixFramework.RFCMock
    {
        public boolean success = false;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            RFC_SD_GET_PRICING_STAT.RESULT result = new RFC_SD_GET_PRICING_STAT.RESULT();
            result.setSuccess(this.success);
            return result;
        }
    }

    public class MOC_RFC_SD_GET_SHIP_INFO implements ensxsdk.EnosixFramework.RFCMock
    {
        public boolean success = false;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            RFC_SD_GET_SHIP_INFO.RESULT result = new RFC_SD_GET_SHIP_INFO.RESULT();
            result.setSuccess(this.success);
            return result;
        }
    }

    public class MOC_RFC_SD_GET_SALES_AREAS implements ensxsdk.EnosixFramework.RFCMock
    {
        public boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            RFC_SD_GET_SALES_AREAS.RESULT result = new RFC_SD_GET_SALES_AREAS.RESULT();
            result.setSuccess(this.success);
            return result;
        }
    }

    public class MOC_RFC_SD_GET_BP_ROLE_TYPE implements ensxsdk.EnosixFramework.RFCMock
    {
        public boolean success = false;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            RFC_SD_GET_BP_ROLE_TYPE.RESULT result = new RFC_SD_GET_BP_ROLE_TYPE.RESULT();
            RFC_SD_GET_BP_ROLE_TYPE.ET_BP_CATEGORY bpCat = new RFC_SD_GET_BP_ROLE_TYPE.ET_BP_CATEGORY();
            bpCat.Category = 'Category';
            bpCat.Description = 'Description';
            result.getCollection(RFC_SD_GET_BP_ROLE_TYPE.ET_BP_CATEGORY.class).add(bpCat);
            RFC_SD_GET_BP_ROLE_TYPE.ET_BP_TYPE bpType = new RFC_SD_GET_BP_ROLE_TYPE.ET_BP_TYPE();
            bpType.FieldType = 'FieldType';
            bpType.Description = 'Description';
            result.getCollection(RFC_SD_GET_BP_ROLE_TYPE.ET_BP_TYPE.class).add(bpType);
            result.setSuccess(this.success);
            return result;
        }
    }

    @isTest 
    static void test_AddBPRoleGroups()
    {
        List<SelectOption> roleGroupsResult = new List<SelectOption>();
        List<SelectOption> countriesResult = new List<SelectOption>();
        List<SelectOption> regionsResult = new List<SelectOption>();
        List<RFC_SD_GET_BP_ROLE_TYPE.ET_BP_ROLE_GROUP> roleGroups = new List<RFC_SD_GET_BP_ROLE_TYPE.ET_BP_ROLE_GROUP>();
        List<RFC_SD_GET_COUNTRIES.ET_OUTPUT> countries = new List<RFC_SD_GET_COUNTRIES.ET_OUTPUT>();
        List<RFC_SD_GET_COUNTRIES.ET_REGIONS> regions = new List<RFC_SD_GET_COUNTRIES.ET_REGIONS>();
        RFC_SD_GET_BP_ROLE_TYPE.ET_BP_ROLE_GROUP roleGroup = new RFC_SD_GET_BP_ROLE_TYPE.ET_BP_ROLE_GROUP();
        roleGroup.RLTGR = 'X';
        roleGroup.RLTGRTXT = 'Z';
        roleGroups.add(roleGroup);
        RFC_SD_GET_COUNTRIES.ET_OUTPUT country = new RFC_SD_GET_COUNTRIES.ET_OUTPUT();
        country.LAND1 = 'CX';
        country.LANDX = 'Country X';
        countries.add(country);
        RFC_SD_GET_COUNTRIES.ET_REGIONS region = new RFC_SD_GET_COUNTRIES.ET_REGIONS();
        region.REGIO = 'R1';
        region.LAND1 = 'C2';
        region.BEZEI = 'Region 1';
        regions.add(region);
        Test.startTest();
        CTRL_CustomerCreateUpdate.AddBPRoleGroups(roleGroupsResult, roleGroups);
        CTRL_CustomerCreateUpdate.AddCountries(countriesResult, countries);
        Test.stopTest();
        system.assertEquals(1, roleGroupsResult.size());
        system.assertEquals(1, countriesResult.size());
    }

    @isTest 
    static void test_AddCountries()
    {
        List<SelectOption> countriesResult = new List<SelectOption>();

        List<RFC_SD_GET_COUNTRIES.ET_OUTPUT> countries = new List<RFC_SD_GET_COUNTRIES.ET_OUTPUT>();
        RFC_SD_GET_COUNTRIES.ET_OUTPUT country = new RFC_SD_GET_COUNTRIES.ET_OUTPUT();
        country.LAND1 = 'CX';
        country.LANDX = 'Country X';
        countries.add(country);

        Test.startTest();

        CTRL_CustomerCreateUpdate.AddCountries(countriesResult, countries);

        Test.stopTest();

        system.assertEquals(1, countriesResult.size());
    }

    @isTest 
    static void test_addPartnerToCustomer()
    {
        SBO_EnosixCustomer_Detail.EnosixCustomer customer = new SBO_EnosixCustomer_Detail.EnosixCustomer();
        SBO_EnosixCustomer_Detail.EnosixCustomer partner = new SBO_EnosixCustomer_Detail.EnosixCustomer();

        Test.startTest();

        CTRL_CustomerCreateUpdate.addPartnerToCustomer(customer, partner, UTIL_Customer.SHIP_TO_PARTNER_CODE);

        Test.stopTest();
    }

    @isTest 
    static void test_getAccountByAccountId()
    {
        mocRfcCalls();

        Test.startTest();

        PageReference pageReference = new PageReference('Page.VFP_CustomerCreate');

        // Insert test data
        Account a1 = TSTU_SFTestObject.createTestAccount();
        a1.Name = 'Mock Create Account';
        TSTU_SFTestObject.upsertWithRetry(a1);
        UTIL_PageState.current.sfAccountId = a1.Id;
        Test.setCurrentPageReference(pageReference);

        // Lookup by account id
        CTRL_CustomerCreateUpdate controller = new CTRL_CustomerCreateUpdate();
        Account result1 = controller.getAccount();

        System.assert(a1.Id == result1.Id);

        Test.stopTest();
    }

    @isTest 
    static void test_getAccountByCase()
    {
        mocRfcCalls();

        Test.startTest();

        PageReference pageReference = new PageReference('Page.VFP_CustomerCreateUpdate');

        Account a1 = TSTU_SFTestObject.createTestAccount();
        a1.Name = 'Mock Create Account';
        TSTU_SFTestObject.upsertWithRetry(a1);

        Case testCase = TSTU_SFTestObject.createTestCase();
        testCase.AccountId = a1.Id;
        TSTU_SFTestObject.upsertWithRetry(testCase);
        System.assert(testCase.Id != null);

        UTIL_PageState.current.sfCaseId = testCase.Id;
        Test.setCurrentPageReference(pageReference);
        CTRL_CustomerCreateUpdate controller = new CTRL_CustomerCreateUpdate();
        Account result1 = controller.getAccount();

        UTIL_PageState.current = null;
        UTIL_PageState.current.sfCaseId = testCase.Id;
        controller = new CTRL_CustomerCreateUpdate();
        Account result2 = controller.getAccount();

        Test.stopTest();

        System.assert(a1.Id == result1.Id);
        System.assert(a1.Name == result1.Name);
    }

    @isTest 
    static void testFormattedPhone()
    {
        mocRfcCalls();

        Test.startTest();

        SBO_EnosixCustomer_Detail.EnosixCustomer customer = new SBO_EnosixCustomer_Detail.EnosixCustomer();
        customer.TelephoneNumber = '1234567890';
        customer.TelephoneNumberExtension = '123';

        CTRL_CustomerCreateUpdate controller = new CTRL_CustomerCreateUpdate();
        controller.cDetail = customer;

        Test.stopTest();

        System.assert(controller.FormattedPhone == '1234567890 x123');
    }

    @isTest 
    static void testFormattedFax()
    {
        mocRfcCalls();

        Test.startTest();

        SBO_EnosixCustomer_Detail.EnosixCustomer customer = new SBO_EnosixCustomer_Detail.EnosixCustomer();
        customer.FaxNumber = '1234567890';
        customer.FaxNumberExtension = '123';

        CTRL_CustomerCreateUpdate controller = new CTRL_CustomerCreateUpdate();
        controller.cDetail = customer;

        Test.stopTest();

        System.assert(controller.FormattedFax == '1234567890 x123');
    }

    @isTest 
    static void testInitCreateMode()
    {
        mocRfcCalls();
        MOC_SBO_EnosixCustomer_Detail mocEnosixCustomerDetail = new MOC_SBO_EnosixCustomer_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustomer_Detail.class, mocEnosixCustomerDetail);

        Test.startTest();

        CTRL_CustomerCreateUpdate controller = new CTRL_CustomerCreateUpdate();
        PageReference pageReference = controller.initCreateMode();
        System.assert(pageReference == null);

        Account a1 = TSTU_SFTestObject.createTestAccount();
        a1.Name = 'Mock Create Account';
        a1.BillingStreet = '123 Here';
        TSTU_SFTestObject.upsertWithRetry(a1);
        controller.account = a1;
        controller.initCreateMode();

        a1.BillingStreet = 'Here';
        controller.account = a1;
        controller.initCreateMode();


        controller.addPartnerToId = a1.Id;
        controller.shipToNum = 'shipToNum';
        controller.salesArea = 'SalesOrganization,DistributionChannel,Division';
        controller.initCreateMode();

        controller.caseId = a1.Id;
        controller.initCreateMode();

        controller.parentCustomer = null;
        controller.initCreateMode();
        Boolean isClassic = controller.isClassic;

        Test.stopTest();
    }

    @isTest 
    static void testRfcFailure()
    {
        MOC_RFC_SD_GET_COUNTRIES mocRfcSdGetCountries = new MOC_RFC_SD_GET_COUNTRIES();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_COUNTRIES.class, mocRfcSdGetCountries);
        MOC_RFC_SD_GET_GROUP_OFFICE mocRfcSdGetGroupOffice = new MOC_RFC_SD_GET_GROUP_OFFICE();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_GROUP_OFFICE.class, mocRfcSdGetGroupOffice);
        MOC_RFC_SD_GET_PRICING_STAT mocRfcSdGetPricingStat = new MOC_RFC_SD_GET_PRICING_STAT();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_PRICING_STAT.class, mocRfcSdGetPricingStat);
        MOC_RFC_SD_GET_SHIP_INFO mocRfcSdGetShipInfo = new MOC_RFC_SD_GET_SHIP_INFO();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_SHIP_INFO.class, mocRfcSdGetShipInfo);
        MOC_RFC_SD_GET_SALES_AREAS mocRfcSdGetSalesAreas = new MOC_RFC_SD_GET_SALES_AREAS();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_SALES_AREAS.class, mocRfcSdGetSalesAreas);
        MOC_RFC_SD_GET_BP_ROLE_TYPE mocRfcSdGetBPRoleType = new MOC_RFC_SD_GET_BP_ROLE_TYPE();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_BP_ROLE_TYPE.class, mocRfcSdGetBPRoleType);
        MOC_SBO_EnosixCustomer_Detail mocEnosixCustomerDetail = new MOC_SBO_EnosixCustomer_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustomer_Detail.class, mocEnosixCustomerDetail);

        Test.startTest();

        CTRL_CustomerCreateUpdate controller = new CTRL_CustomerCreateUpdate();
        SBO_EnosixCustomer_Detail.EnosixCustomer customer = new SBO_EnosixCustomer_Detail.EnosixCustomer();
        customer.Country = UTIL_ViewHelper.getValueForSelectOptionLabel(controller.CountryOptions, 'USA');
        controller.cDetail = customer;
        Object testObject = controller.RegionOptions;
        mocRfcSdGetCountries.setSuccess(false);
        mocRfcSdGetGroupOffice.setSuccess(false);
        mocRfcSdGetPricingStat.setSuccess(false);
        mocRfcSdGetShipInfo.setSuccess(false);
        mocRfcSdGetSalesAreas.setSuccess(false);
        mocEnosixCustomerDetail.setSuccess(false);

        Test.stopTest();
    }

    @isTest 
    static void testCopySalesAreasFromCustomer()
    {
        mocRfcCalls();
        MOC_SBO_EnosixCustomer_Detail mocEnosixCustomerDetail = new MOC_SBO_EnosixCustomer_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustomer_Detail.class, mocEnosixCustomerDetail);

        Test.startTest();

        CTRL_CustomerCreateUpdate.copySalesAreasFromCustomer(new SBO_EnosixCustomer_Detail.EnosixCustomer(), new SBO_EnosixCustomer_Detail.EnosixCustomer());

        Test.stopTest();
    }

    @isTest 
    static void testInitEdit()
    {
        mocRfcCalls();
        MOC_SBO_EnosixCustomer_Detail mocEnosixCustomerDetail = new MOC_SBO_EnosixCustomer_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustomer_Detail.class, mocEnosixCustomerDetail);

        Test.startTest();

        UTIL_AppSettings.resourceJson = '{"Customer.IsAddressEditable": true}';
        CTRL_CustomerCreateUpdate controller = new CTRL_CustomerCreateUpdate();
        controller.initEdit();

        Account a1 = TSTU_SFTestObject.createTestAccount();
        a1.Name = 'Mock Create Account';
        a1.put(UTIL_SFAccount.CustomerFieldName,'customerNumber');
        controller.account = a1;
        controller.initEdit();

        Test.stopTest();
    }

    @isTest 
    static void testInitAddress()
    {
        mocRfcCalls();
        MOC_SBO_EnosixCustomer_Detail mocEnosixCustomerDetail = new MOC_SBO_EnosixCustomer_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustomer_Detail.class, mocEnosixCustomerDetail);

        Test.startTest();

        CTRL_CustomerCreateUpdate controller = new CTRL_CustomerCreateUpdate();
        Account a1 = TSTU_SFTestObject.createTestAccount();
        a1.Name = 'Mock Create Account';
        a1.put(UTIL_SFAccount.CustomerFieldName,'customerNumber');
        a1.BillingStreet = '123 Here';
        controller.account = a1;
        SBO_EnosixCustomer_Detail.EnosixCustomer customer = new SBO_EnosixCustomer_Detail.EnosixCustomer();
        customer.Country = 'US';
        controller.cDetail = customer;
        controller.initAddress();
        a1.BillingStreet = 'Here';
        controller.account = a1;
        controller.initAddress();

        Test.stopTest();
    }

    @isTest 
    static void testScreenVariables()
    {
        mocRfcCalls();
        MOC_SBO_EnosixCustomer_Detail mocEnosixCustomerDetail = new MOC_SBO_EnosixCustomer_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustomer_Detail.class, mocEnosixCustomerDetail);

        Test.startTest();

        UTIL_AppSettings.resourceJson = '{"CTRL_CustomerCreateUpdate.Logging": true}';
        CTRL_CustomerCreateUpdate controller = new CTRL_CustomerCreateUpdate();
        SBO_EnosixCustomer_Detail.EnosixCustomer customer = new SBO_EnosixCustomer_Detail.EnosixCustomer();
        customer.SALES_DATA.add(new SBO_EnosixCustomer_Detail.SALES_DATA());
        customer.COMPANY_DATA.add(new SBO_EnosixCustomer_Detail.COMPANY_DATA());
        controller.cDetail = customer;
        controller.parentCustomer = customer;
        Object testObject = controller.IsCustomerContactEditable;
        testObject = controller.IsCustomerAddressEditable;
        testObject = controller.RefrenceAccount;
        testObject = controller.NewCustomer;
        testObject = controller.DS_SalesAreas;
        testObject = controller.CompanyCodes;
        testObject = controller.RegionOptions;
        testObject = controller.BusinessPartnerCategoryOptions;
        testObject = controller.BusinessPartnerTypeOptions;
        testObject = controller.BPRoleGroups;
        testObject = controller.showAddPartnerAction;
        testObject = controller.bpRoleTypes;
        controller.actionReturnToCustomer();
        controller.gotoCase();
        controller.gotoAccounts();
        controller.actionDisplaySapCustomer();
        Boolean isFrom = controller.isFromOrder;
        isFrom = controller.isFromQuote;
        isFrom = controller.isFromOpp;
        controller.newShipToNum = 'newShipToNum';
        CTRL_CustomerCreateUpdate.redirectToPartnerSearch('accountId');
        controller.redirectToOrderPage();
        controller.redirectToQuotePage();
        controller.redirectToOppPage();
        Boolean showCreateCustomerAction = controller.showCreateCustomerAction;
        UTIL_PageState.current.sapMode = UTIL_PageState.SAP_ModeUpdate;
        controller.initMode();
        UTIL_PageState.current.sapMode = null;
        controller.initMode();
        controller.parentCustomer.SALES_DATA.clear();
        controller.initAddPartner();

        Test.stopTest();
    }

    @isTest 
    static void testCustomerCreateSalesAreas()
    {
        mocRfcCalls();
        MOC_SBO_EnosixCustomer_Detail mocEnosixCustomerDetail = new MOC_SBO_EnosixCustomer_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustomer_Detail.class, mocEnosixCustomerDetail);

        Test.startTest();

        CTRL_CustomerCreateUpdate controller = new CTRL_CustomerCreateUpdate();
        SBO_EnosixCustomer_Detail.EnosixCustomer customer = new SBO_EnosixCustomer_Detail.EnosixCustomer();
        controller.cDetail = customer;
        CTRL_CustomerCreateUpdate.CustomerCreateSalesAreas customerCreateSalesAreas = new CTRL_CustomerCreateUpdate.CustomerCreateSalesAreas(controller, new SBO_EnosixCustomer_Detail.SALES_DATA());
        customerCreateSalesAreas.updateSalesArea(new SBO_EnosixCustomer_Detail.SALES_DATA());
        customerCreateSalesAreas.getSALES_DATA();
        customerCreateSalesAreas.getSalesAreas();
        customerCreateSalesAreas.getGroupOffice();
        customerCreateSalesAreas.getPricingStat();
        customerCreateSalesAreas.getShipInfo();
        customerCreateSalesAreas.getParentCustomerSalesAreas();

        controller = new CTRL_CustomerCreateUpdate();
        customer.SALES_DATA.add(new SBO_EnosixCustomer_Detail.SALES_DATA());
        controller.cDetail = customer;
        customerCreateSalesAreas = new CTRL_CustomerCreateUpdate.CustomerCreateSalesAreas(controller, new SBO_EnosixCustomer_Detail.SALES_DATA());
        customerCreateSalesAreas.updateSalesArea(new SBO_EnosixCustomer_Detail.SALES_DATA());

        Test.stopTest();
    }

    @isTest 
    static void testCustomerCreateCompanyCode()
    {
        mocRfcCalls();
        MOC_SBO_EnosixCustomer_Detail mocEnosixCustomerDetail = new MOC_SBO_EnosixCustomer_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustomer_Detail.class, mocEnosixCustomerDetail);

        Test.startTest();

        CTRL_CustomerCreateUpdate controller = new CTRL_CustomerCreateUpdate();
        SBO_EnosixCustomer_Detail.EnosixCustomer customer = new SBO_EnosixCustomer_Detail.EnosixCustomer();
        controller.cDetail = customer;
        CTRL_CustomerCreateUpdate.CustomerCreateCompanyCode customerCreateCompanyCode = new CTRL_CustomerCreateUpdate.CustomerCreateCompanyCode(controller, new SBO_EnosixCustomer_Detail.COMPANY_DATA());
        customerCreateCompanyCode.getCOMPANY_DATA();
        customerCreateCompanyCode.getShipInfo();

        Test.stopTest();
    }

    @isTest 
    static void testActionAddSAPPartner()
    {
        mocRfcCalls();
        MOC_SBO_EnosixCustomer_Detail mocEnosixCustomerDetail = new MOC_SBO_EnosixCustomer_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustomer_Detail.class, mocEnosixCustomerDetail);

        Account a1 = TSTU_SFTestObject.createTestAccount();
        a1.Name = 'Mock Create Account';
        TSTU_SFTestObject.upsertWithRetry(a1);
        UTIL_PageState.current.sfAccountId = a1.Id;

        Test.startTest();

        CTRL_CustomerCreateUpdate controller = new CTRL_CustomerCreateUpdate();
        SBO_EnosixCustomer_Detail.EnosixCustomer customer = new SBO_EnosixCustomer_Detail.EnosixCustomer();
        customer.BusinessPartnerCategory = '1';
        controller.cDetail = customer;
        controller.actionAddSAPPartner();

        customer.Name = 'Name';
        customer.BusinessPartnerCategory = '2';
        customer.Street = 'Street';
        customer.City = 'City';
        customer.Region = 'Region';
        customer.PostalCode = 'PostalCode';
        customer.BPRole = 'BPRole';
        customer.SALES_DATA.add(new SBO_EnosixCustomer_Detail.SALES_DATA());
        customer.COMPANY_DATA.add(new SBO_EnosixCustomer_Detail.COMPANY_DATA());
        controller.cDetail = customer;
        controller.parentCustomer = customer;
        controller.actionAddSAPPartner();
        customer.CustomerNumber = 'CustomerNumber';
        controller.actionAddSAPPartner();

        mocEnosixCustomerDetail.setSuccess(false);
        controller.actionAddSAPPartner();

        mocEnosixCustomerDetail.setThrowException(true);
        controller.actionAddSAPPartner();

        Test.stopTest();
    }

    @isTest 
    static void testCreateSAPCustomer()
    {
        mocRfcCalls();
        MOC_SBO_EnosixCustomer_Detail mocEnosixCustomerDetail = new MOC_SBO_EnosixCustomer_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustomer_Detail.class, mocEnosixCustomerDetail);

        Test.startTest();

        CTRL_CustomerCreateUpdate controller = new CTRL_CustomerCreateUpdate();
        SBO_EnosixCustomer_Detail.EnosixCustomer customer = new SBO_EnosixCustomer_Detail.EnosixCustomer();
        customer.BusinessPartnerCategory = '1';
        controller.cDetail = customer;
        controller.createSAPCustomer();

        customer.Name = 'Name';
        customer.BusinessPartnerCategory = '2';
        customer.Street = 'Street';
        customer.City = 'City';
        customer.Region = 'Region';
        customer.PostalCode = 'PostalCode';
        customer.BPRole = 'BPRole';
        customer.SALES_DATA.add(new SBO_EnosixCustomer_Detail.SALES_DATA());
        customer.COMPANY_DATA.add(new SBO_EnosixCustomer_Detail.COMPANY_DATA());
        controller.cDetail = customer;
        controller.parentCustomer = customer;
        controller.createSAPCustomer();
        Account testAccount = TSTU_SFTestObject.createTestAccount();
        testAccount.Name = 'Name';
        controller.account = testAccount;
        controller.createSAPCustomer();

        mocEnosixCustomerDetail.setSuccess(false);
        controller.createSAPCustomer();

        mocEnosixCustomerDetail.setThrowException(true);
        controller.createSAPCustomer();

        Test.stopTest();
    }

    @isTest 
    static void testValidateFields()
    {
        mocRfcCalls();
        MOC_SBO_EnosixCustomer_Detail mocEnosixCustomerDetail = new MOC_SBO_EnosixCustomer_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustomer_Detail.class, mocEnosixCustomerDetail);

        Test.startTest();

        CTRL_CustomerCreateUpdate controller = new CTRL_CustomerCreateUpdate();
        SBO_EnosixCustomer_Detail.EnosixCustomer customer = new SBO_EnosixCustomer_Detail.EnosixCustomer();
        customer.BusinessPartnerCategory = '1';
        controller.cDetail = customer;
        controller.ValidateFields();
        customer.Name = 'Name';
        controller.cDetail = customer;
        controller.ValidateFields();
        customer.BusinessPartnerCategory = '2';
        controller.cDetail = customer;
        controller.ValidateFields();
        customer.Street = 'Street';
        controller.cDetail = customer;
        controller.ValidateFields();
        customer.City = 'City';
        controller.cDetail = customer;
        controller.ValidateFields();
        customer.Region = 'Region';
        controller.cDetail = customer;
        controller.ValidateFields();
        customer.PostalCode = 'PostalCode';
        controller.cDetail = customer;
        controller.ValidateFields();
        customer.BPRole = 'BPRole';
        controller.cDetail = customer;
        controller.ValidateFields();
        customer.SALES_DATA.add(new SBO_EnosixCustomer_Detail.SALES_DATA());
        customer.COMPANY_DATA.add(new SBO_EnosixCustomer_Detail.COMPANY_DATA());
        controller.cDetail = customer;
        controller.ValidateFields();

        Test.stopTest();
    }

    @isTest 
    static void testActionUpdateSapCustomer()
    {
        mocRfcCalls();
        MOC_SBO_EnosixCustomer_Detail mocEnosixCustomerDetail = new MOC_SBO_EnosixCustomer_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustomer_Detail.class, mocEnosixCustomerDetail);

        Test.startTest();

        CTRL_CustomerCreateUpdate controller = new CTRL_CustomerCreateUpdate();
        SBO_EnosixCustomer_Detail.EnosixCustomer customer = new SBO_EnosixCustomer_Detail.EnosixCustomer();
        controller.cDetail = customer;
        controller.actionUpdateSapCustomer();

        mocEnosixCustomerDetail.setThrowException(true);
        controller.actionUpdateSapCustomer();

        Test.stopTest();
    }

    static void mocRfcCalls()
    {
        MOC_RFC_SD_GET_COUNTRIES mocRfcSdGetCountries = new MOC_RFC_SD_GET_COUNTRIES();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_COUNTRIES.class, mocRfcSdGetCountries);
        MOC_RFC_SD_GET_GROUP_OFFICE mocRfcSdGetGroupOffice = new MOC_RFC_SD_GET_GROUP_OFFICE();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_GROUP_OFFICE.class, mocRfcSdGetGroupOffice);
        MOC_RFC_SD_GET_PRICING_STAT mocRfcSdGetPricingStat = new MOC_RFC_SD_GET_PRICING_STAT();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_PRICING_STAT.class, mocRfcSdGetPricingStat);
        MOC_RFC_SD_GET_SHIP_INFO mocRfcSdGetShipInfo = new MOC_RFC_SD_GET_SHIP_INFO();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_SHIP_INFO.class, mocRfcSdGetShipInfo);
        MOC_RFC_SD_GET_SALES_AREAS mocRfcSdGetSalesAreas = new MOC_RFC_SD_GET_SALES_AREAS();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_SALES_AREAS.class, mocRfcSdGetSalesAreas);
        MOC_RFC_SD_GET_BP_ROLE_TYPE mocRfcSdGetBPRoleType = new MOC_RFC_SD_GET_BP_ROLE_TYPE();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_BP_ROLE_TYPE.class, mocRfcSdGetBPRoleType);
    }
}