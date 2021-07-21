/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
public with sharing class TST_EnosixCustomer_Detail
{
    public class MockSBO_EnosixCustomer_Detail implements
        ensxsdk.EnosixFramework.DetailSBOInitMock,
        ensxsdk.EnosixFramework.DetailSBOCommandMock,
        ensxsdk.EnosixFramework.DetailSBOGetMock,
        ensxsdk.EnosixFramework.DetailSBOSaveMock
    {
        public ensxsdk.EnosixFramework.DetailObject executeInitialize(ensxsdk.EnosixFramework.DetailObject initialState) { return null; }
        public ensxsdk.EnosixFramework.DetailObject executeCommand(String command, ensxsdk.EnosixFramework.DetailObject obj) { return null; }
        public ensxsdk.EnosixFramework.DetailObject executeGetDetail(object key) { return null; }
        public ensxsdk.EnosixFramework.DetailObject executeSave(ensxsdk.EnosixFramework.DetailObject obj) { return null; }
    }

    @isTest
    static void testSBO()
    {
        SBO_EnosixCustomer_Detail sbo = new SBO_EnosixCustomer_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustomer_Detail.class, new MockSBO_EnosixCustomer_Detail());
        System.assertEquals(null, sbo.initialize(null));
        System.assertEquals(null, sbo.command(null, null));
        System.assertEquals(null, sbo.getDetail(null));
        System.assertEquals(null, sbo.save(null));
    }

    @isTest
    static void testEnosixCustomer()
    {
        SBO_EnosixCustomer_Detail.EnosixCustomer result = new SBO_EnosixCustomer_Detail.EnosixCustomer();
        System.assertEquals(SBO_EnosixCustomer_Detail.EnosixCustomer.class, result.getType(), 'getType() does not match object type.');

        result.registerReflectionForClass();

        result.CustomerNumber = 'X';
        System.assertEquals('X', result.CustomerNumber);

        result.BPRole = 'X';
        System.assertEquals('X', result.BPRole);

        result.BPRoleDescription = 'X';
        System.assertEquals('X', result.BPRoleDescription);

        result.BusinessPartnerCategory = 'X';
        System.assertEquals('X', result.BusinessPartnerCategory);

        result.BusinessPartnerCategoryDescription = 'X';
        System.assertEquals('X', result.BusinessPartnerCategoryDescription);

        result.BusinessPartnerType = 'X';
        System.assertEquals('X', result.BusinessPartnerType);

        result.BusinessPartnerTypeDescription = 'X';
        System.assertEquals('X', result.BusinessPartnerTypeDescription);

        result.BusinessPartnerGrouping = 'X';
        System.assertEquals('X', result.BusinessPartnerGrouping);

        result.BusinessPartnerGroupingDesc = 'X';
        System.assertEquals('X', result.BusinessPartnerGroupingDesc);

        result.Title = 'X';
        System.assertEquals('X', result.Title);

        result.TitleName = 'X';
        System.assertEquals('X', result.TitleName);

        result.Name = 'X';
        System.assertEquals('X', result.Name);

        result.Name2 = 'X';
        System.assertEquals('X', result.Name2);

        result.SearchTerm1 = 'X';
        System.assertEquals('X', result.SearchTerm1);

        result.HouseNumber = 'X';
        System.assertEquals('X', result.HouseNumber);

        result.Street = 'X';
        System.assertEquals('X', result.Street);

        result.City = 'X';
        System.assertEquals('X', result.City);

        result.PostalCode = 'X';
        System.assertEquals('X', result.PostalCode);

        result.Region = 'X';
        System.assertEquals('X', result.Region);

        result.RegionDescription = 'X';
        System.assertEquals('X', result.RegionDescription);

        result.CountryKey = 'X';
        System.assertEquals('X', result.CountryKey);

        result.CountryName = 'X';
        System.assertEquals('X', result.CountryName);

        result.POBox = 'X';
        System.assertEquals('X', result.POBox);

        result.POBoxPostalCode = 'X';
        System.assertEquals('X', result.POBoxPostalCode);

        result.CompanyPostalCode = 'X';
        System.assertEquals('X', result.CompanyPostalCode);

        result.Language = 'X';
        System.assertEquals('X', result.Language);

        result.LanguageDesc = 'X';
        System.assertEquals('X', result.LanguageDesc);

        result.TelephoneNO = 'X';
        System.assertEquals('X', result.TelephoneNO);

        result.TelephoneNumberExtension = 'X';
        System.assertEquals('X', result.TelephoneNumberExtension);

        result.MobileNumber = 'X';
        System.assertEquals('X', result.MobileNumber);

        result.FaxNumber = 'X';
        System.assertEquals('X', result.FaxNumber);

        result.FaxNumberExtension = 'X';
        System.assertEquals('X', result.FaxNumberExtension);

        result.EMailAddress = 'X';
        System.assertEquals('X', result.EMailAddress);

        result.TimeZone = 'X';
        System.assertEquals('X', result.TimeZone);

        result.TimeZoneText = 'X';
        System.assertEquals('X', result.TimeZoneText);

        result.TransportationZone = 'X';
        System.assertEquals('X', result.TransportationZone);

        result.TransportationZoneDescription = 'X';
        System.assertEquals('X', result.TransportationZoneDescription);

        result.CustomerAccountGroup = 'X';
        System.assertEquals('X', result.CustomerAccountGroup);

        result.AccountGroupName = 'X';
        System.assertEquals('X', result.AccountGroupName);

        //Test child collections
        System.assertNotEquals(null,result.COMPANY_DATA.getAsList());
        System.assertNotEquals(null,result.SALES_DATA.getAsList());
        System.assertNotEquals(null,result.PAYMENT_DATA.getAsList());
        System.assertNotEquals(null,result.PARTNERS.getAsList());
        System.assertNotEquals(null,result.CREDIT);
        System.assertNotEquals(null,result.SALES_TEXT.getAsList());
        System.assertNotEquals(null,result.USER_DEFINED.getAsList());
        System.assertNotEquals(null,result.CONTACTS.getAsList());
        System.assertNotEquals(null,result.TAX_CLASSIFICATION.getAsList());
    }

    @isTest
    static void testCOMPANY_DATA()
    {
        SBO_EnosixCustomer_Detail.COMPANY_DATA childObj = new SBO_EnosixCustomer_Detail.COMPANY_DATA();
        System.assertEquals(SBO_EnosixCustomer_Detail.COMPANY_DATA.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.CompanyCode = 'X';
        System.assertEquals('X', childObj.CompanyCode);

        childObj.CompanyCodeDescription = 'X';
        System.assertEquals('X', childObj.CompanyCodeDescription);

        childObj.ReconciliationAccount = 'X';
        System.assertEquals('X', childObj.ReconciliationAccount);

        childObj.TermsofPaymentKey = 'X';
        System.assertEquals('X', childObj.TermsofPaymentKey);

        childObj.TermsOfPaymentDescription = 'X';
        System.assertEquals('X', childObj.TermsOfPaymentDescription);

        List<string> keyFields = new List<string>{ 'BUKRS' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testSALES_DATA()
    {
        SBO_EnosixCustomer_Detail.SALES_DATA childObj = new SBO_EnosixCustomer_Detail.SALES_DATA();
        System.assertEquals(SBO_EnosixCustomer_Detail.SALES_DATA.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.SalesOrganization = 'X';
        System.assertEquals('X', childObj.SalesOrganization);

        childObj.SalesOrganizationName = 'X';
        System.assertEquals('X', childObj.SalesOrganizationName);

        childObj.DistributionChannel = 'X';
        System.assertEquals('X', childObj.DistributionChannel);

        childObj.DistributionChannelName = 'X';
        System.assertEquals('X', childObj.DistributionChannelName);

        childObj.Division = 'X';
        System.assertEquals('X', childObj.Division);

        childObj.DivisionName = 'X';
        System.assertEquals('X', childObj.DivisionName);

        childObj.SalesDistrict = 'X';
        System.assertEquals('X', childObj.SalesDistrict);

        childObj.SalesDistrictName = 'X';
        System.assertEquals('X', childObj.SalesDistrictName);

        childObj.SalesOffice = 'X';
        System.assertEquals('X', childObj.SalesOffice);

        childObj.SalesOfficeName = 'X';
        System.assertEquals('X', childObj.SalesOfficeName);

        childObj.SalesGroup = 'X';
        System.assertEquals('X', childObj.SalesGroup);

        childObj.SalesGroupName = 'X';
        System.assertEquals('X', childObj.SalesGroupName);

        childObj.DeliveryPlant = 'X';
        System.assertEquals('X', childObj.DeliveryPlant);

        childObj.DeliveryPlantName = 'X';
        System.assertEquals('X', childObj.DeliveryPlantName);

        childObj.PriceGroup = 'X';
        System.assertEquals('X', childObj.PriceGroup);

        childObj.PriceGroupDescription = 'X';
        System.assertEquals('X', childObj.PriceGroupDescription);

        childObj.CustomerPricingProcedure = 'X';
        System.assertEquals('X', childObj.CustomerPricingProcedure);

        childObj.CustomerPricProcedureDesc = 'X';
        System.assertEquals('X', childObj.CustomerPricProcedureDesc);

        childObj.PriceListType = 'X';
        System.assertEquals('X', childObj.PriceListType);

        childObj.PriceListTypeDescription = 'X';
        System.assertEquals('X', childObj.PriceListTypeDescription);

        childObj.StatisticsGroup = 'X';
        System.assertEquals('X', childObj.StatisticsGroup);

        childObj.StatisticsGroupDescription = 'X';
        System.assertEquals('X', childObj.StatisticsGroupDescription);

        childObj.ShippingConditions = 'X';
        System.assertEquals('X', childObj.ShippingConditions);

        childObj.ShippingConditionDescription = 'X';
        System.assertEquals('X', childObj.ShippingConditionDescription);

        childObj.CompleteDeliveryDefined = true;
        System.assertEquals(true, childObj.CompleteDeliveryDefined);

        childObj.PartialDelivery = 'X';
        System.assertEquals('X', childObj.PartialDelivery);

        childObj.MaximumNoOfPartialDelivery = 1.5;
        System.assertEquals(1.5, childObj.MaximumNoOfPartialDelivery);

        childObj.AccountAssignmentGroup = 'X';
        System.assertEquals('X', childObj.AccountAssignmentGroup);

        childObj.AccountAssignmentGroupDescription = 'X';
        System.assertEquals('X', childObj.AccountAssignmentGroupDescription);

        childObj.TermsofPaymentKey = 'X';
        System.assertEquals('X', childObj.TermsofPaymentKey);

        childObj.TermsOfPaymentDescription = 'X';
        System.assertEquals('X', childObj.TermsOfPaymentDescription);

        childObj.CurrencyKey = 'X';
        System.assertEquals('X', childObj.CurrencyKey);

        childObj.TaxClassification = 'X';
        System.assertEquals('X', childObj.TaxClassification);

        childObj.TaxClassificationDescription = 'X';
        System.assertEquals('X', childObj.TaxClassificationDescription);

        childObj.CustomerGroup1 = 'X';
        System.assertEquals('X', childObj.CustomerGroup1);

        childObj.CustomerGroup1Name = 'X';
        System.assertEquals('X', childObj.CustomerGroup1Name);

        childObj.CustomerBlock = 'X';
        System.assertEquals('X', childObj.CustomerBlock);

        childObj.IncotermsPart1 = 'X';
        System.assertEquals('X', childObj.IncotermsPart1);

        childObj.IncotermsPart2 = 'X';
        System.assertEquals('X', childObj.IncotermsPart2);

        List<string> keyFields = new List<string>{ 'VKORG','VTWEG','SPART' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testPAYMENT_DATA()
    {
        SBO_EnosixCustomer_Detail.PAYMENT_DATA childObj = new SBO_EnosixCustomer_Detail.PAYMENT_DATA();
        System.assertEquals(SBO_EnosixCustomer_Detail.PAYMENT_DATA.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.PaymentCardID = 'X';
        System.assertEquals('X', childObj.PaymentCardID);

        childObj.PaymentCardType = 'X';
        System.assertEquals('X', childObj.PaymentCardType);

        childObj.PaymentCardTypeDesc = 'X';
        System.assertEquals('X', childObj.PaymentCardTypeDesc);

        childObj.CardNumber = 'X';
        System.assertEquals('X', childObj.CardNumber);

        childObj.DefaultPaymentCard = true;
        System.assertEquals(true, childObj.DefaultPaymentCard);

        childObj.CreditCardName = 'X';
        System.assertEquals('X', childObj.CreditCardName);

        childObj.CardHolderName = 'X';
        System.assertEquals('X', childObj.CardHolderName);

        childObj.CardCategory = 'X';
        System.assertEquals('X', childObj.CardCategory);

        childObj.CardCategoryDescription = 'X';
        System.assertEquals('X', childObj.CardCategoryDescription);

        childObj.ValidFromDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.ValidFromDate);

        childObj.ValidToDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.ValidToDate);

        childObj.X_RemoveCard = true;
        System.assertEquals(true, childObj.X_RemoveCard);

        List<string> keyFields = new List<string>{ 'CCARD_ID' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testPARTNERS()
    {
        SBO_EnosixCustomer_Detail.PARTNERS childObj = new SBO_EnosixCustomer_Detail.PARTNERS();
        System.assertEquals(SBO_EnosixCustomer_Detail.PARTNERS.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.SalesOrganization = 'X';
        System.assertEquals('X', childObj.SalesOrganization);

        childObj.SalesOrganizationName = 'X';
        System.assertEquals('X', childObj.SalesOrganizationName);

        childObj.DistributionChannel = 'X';
        System.assertEquals('X', childObj.DistributionChannel);

        childObj.DistributionChannelName = 'X';
        System.assertEquals('X', childObj.DistributionChannelName);

        childObj.Division = 'X';
        System.assertEquals('X', childObj.Division);

        childObj.DivisionName = 'X';
        System.assertEquals('X', childObj.DivisionName);

        childObj.PartnerFunction = 'X';
        System.assertEquals('X', childObj.PartnerFunction);

        childObj.PartnerFunctionName = 'X';
        System.assertEquals('X', childObj.PartnerFunctionName);

        childObj.PartnerNumber = 'X';
        System.assertEquals('X', childObj.PartnerNumber);

        childObj.PartnerName = 'X';
        System.assertEquals('X', childObj.PartnerName);

        childObj.VendorNumber = 'X';
        System.assertEquals('X', childObj.VendorNumber);

        childObj.VendorName = 'X';
        System.assertEquals('X', childObj.VendorName);

        childObj.ContactNumber = 'X';
        System.assertEquals('X', childObj.ContactNumber);

        childObj.ContactFirstName = 'X';
        System.assertEquals('X', childObj.ContactFirstName);

        childObj.ContactLastName = 'X';
        System.assertEquals('X', childObj.ContactLastName);

        childObj.PersonnelNumber = 'X';
        System.assertEquals('X', childObj.PersonnelNumber);

        childObj.PersonnelFirstName = 'X';
        System.assertEquals('X', childObj.PersonnelFirstName);

        childObj.PersonnelLastName = 'X';
        System.assertEquals('X', childObj.PersonnelLastName);

        childObj.HouseNumber = 'X';
        System.assertEquals('X', childObj.HouseNumber);

        childObj.Street = 'X';
        System.assertEquals('X', childObj.Street);

        childObj.City = 'X';
        System.assertEquals('X', childObj.City);

        childObj.PostalCode = 'X';
        System.assertEquals('X', childObj.PostalCode);

        childObj.Region = 'X';
        System.assertEquals('X', childObj.Region);

        childObj.CountryKey = 'X';
        System.assertEquals('X', childObj.CountryKey);

        childObj.DEFPA = true;
        System.assertEquals(true, childObj.DEFPA);

        List<string> keyFields = new List<string>{ 'VKORG','VTWEG','SPART','PARVW','PARTNER_NUM','VENDOR_NUM','CONTACT_NUM' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testCREDIT()
    {
        SBO_EnosixCustomer_Detail.CREDIT childObj = new SBO_EnosixCustomer_Detail.CREDIT();
        System.assertEquals(SBO_EnosixCustomer_Detail.CREDIT.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.CreditLimit = 1.5;
        System.assertEquals(1.5, childObj.CreditLimit);

        childObj.CreditAvailable = 1.5;
        System.assertEquals(1.5, childObj.CreditAvailable);

        childObj.CurrencyKey = 'X';
        System.assertEquals('X', childObj.CurrencyKey);

        childObj.CreditManagmentBlock = true;
        System.assertEquals(true, childObj.CreditManagmentBlock);

        childObj.ValidToDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.ValidToDate);

        childObj.ChangeDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.ChangeDate);

        childObj.CreditAnalyst = 'X';
        System.assertEquals('X', childObj.CreditAnalyst);

        childObj.CustomerCreditGroup = 'X';
        System.assertEquals('X', childObj.CustomerCreditGroup);

        childObj.ResubmissionDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.ResubmissionDate);

        childObj.CalculatedCreditLimit = 1.5;
        System.assertEquals(1.5, childObj.CalculatedCreditLimit);

        childObj.SpecialAttentionRequired = true;
        System.assertEquals(true, childObj.SpecialAttentionRequired);

        childObj.LimitIsZero = true;
        System.assertEquals(true, childObj.LimitIsZero);

        childObj.CreditBlockReason = 'X';
        System.assertEquals('X', childObj.CreditBlockReason);

        childObj.CreditLimitRequested = 1.5;
        System.assertEquals(1.5, childObj.CreditLimitRequested);

        childObj.AutomaticLimitRequest = true;
        System.assertEquals(true, childObj.AutomaticLimitRequest);

        childObj.RequestedValidToDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.RequestedValidToDate);

        childObj.RequestDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.RequestDate);

        List<string> keyFields = new List<string>{ 'EnosixObjKey' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testSALES_TEXT()
    {
        SBO_EnosixCustomer_Detail.SALES_TEXT childObj = new SBO_EnosixCustomer_Detail.SALES_TEXT();
        System.assertEquals(SBO_EnosixCustomer_Detail.SALES_TEXT.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.SalesOrganization = 'X';
        System.assertEquals('X', childObj.SalesOrganization);

        childObj.DistributionChannel = 'X';
        System.assertEquals('X', childObj.DistributionChannel);

        childObj.Division = 'X';
        System.assertEquals('X', childObj.Division);

        childObj.TextID = 'X';
        System.assertEquals('X', childObj.TextID);

        childObj.TextLanguage = 'X';
        System.assertEquals('X', childObj.TextLanguage);

        childObj.TextIDDescription = 'X';
        System.assertEquals('X', childObj.TextIDDescription);

        childObj.FirstLine = 'X';
        System.assertEquals('X', childObj.FirstLine);

        childObj.MoreTextExists = true;
        System.assertEquals(true, childObj.MoreTextExists);

        childObj.Text = 'X';
        System.assertEquals('X', childObj.Text);

        List<string> keyFields = new List<string>{ 'VKORG','VTWEG','SPART','TDID','TDSPRAS','TDTEXT','LTEXT','KZLTX','TEXT' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testUSER_DEFINED()
    {
        SBO_EnosixCustomer_Detail.USER_DEFINED childObj = new SBO_EnosixCustomer_Detail.USER_DEFINED();
        System.assertEquals(SBO_EnosixCustomer_Detail.USER_DEFINED.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.FIELD = 'X';
        System.assertEquals('X', childObj.FIELD);

        childObj.VALUE = 'X';
        System.assertEquals('X', childObj.VALUE);

        List<string> keyFields = new List<string>{ 'FIELD' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testCONTACTS()
    {
        SBO_EnosixCustomer_Detail.CONTACTS childObj = new SBO_EnosixCustomer_Detail.CONTACTS();
        System.assertEquals(SBO_EnosixCustomer_Detail.CONTACTS.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.ContactPersonNumber = 'X';
        System.assertEquals('X', childObj.ContactPersonNumber);

        childObj.FirstName = 'X';
        System.assertEquals('X', childObj.FirstName);

        childObj.LastName = 'X';
        System.assertEquals('X', childObj.LastName);

        childObj.Name = 'X';
        System.assertEquals('X', childObj.Name);

        childObj.VIPPartner = 'X';
        System.assertEquals('X', childObj.VIPPartner);

        childObj.DepartmentNumber = 'X';
        System.assertEquals('X', childObj.DepartmentNumber);

        childObj.Function = 'X';
        System.assertEquals('X', childObj.Function);

        childObj.Authority = 'X';
        System.assertEquals('X', childObj.Authority);

        childObj.HigherPartner = 'X';
        System.assertEquals('X', childObj.HigherPartner);

        childObj.SalesEmployee = 'X';
        System.assertEquals('X', childObj.SalesEmployee);

        childObj.Gender = 'X';
        System.assertEquals('X', childObj.Gender);

        childObj.DateOfBirth = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.DateOfBirth);

        childObj.MaritalStatus = 'X';
        System.assertEquals('X', childObj.MaritalStatus);

        childObj.CallFrequency = 'X';
        System.assertEquals('X', childObj.CallFrequency);

        childObj.BuyingHabits = 'X';
        System.assertEquals('X', childObj.BuyingHabits);

        childObj.Notes = 'X';
        System.assertEquals('X', childObj.Notes);

        childObj.HouseNumber = 'X';
        System.assertEquals('X', childObj.HouseNumber);

        childObj.Street = 'X';
        System.assertEquals('X', childObj.Street);

        childObj.City = 'X';
        System.assertEquals('X', childObj.City);

        childObj.PostalCode = 'X';
        System.assertEquals('X', childObj.PostalCode);

        childObj.Region = 'X';
        System.assertEquals('X', childObj.Region);

        childObj.RegionDescription = 'X';
        System.assertEquals('X', childObj.RegionDescription);

        childObj.CountryKey = 'X';
        System.assertEquals('X', childObj.CountryKey);

        childObj.CountryName = 'X';
        System.assertEquals('X', childObj.CountryName);

        childObj.TimeZone = 'X';
        System.assertEquals('X', childObj.TimeZone);

        childObj.TimeZoneText = 'X';
        System.assertEquals('X', childObj.TimeZoneText);

        childObj.TransportationZone = 'X';
        System.assertEquals('X', childObj.TransportationZone);

        childObj.TransportationZoneDescription = 'X';
        System.assertEquals('X', childObj.TransportationZoneDescription);

        childObj.POBox = 'X';
        System.assertEquals('X', childObj.POBox);

        childObj.POBoxPostalCode = 'X';
        System.assertEquals('X', childObj.POBoxPostalCode);

        childObj.CompanyPostalCode = 'X';
        System.assertEquals('X', childObj.CompanyPostalCode);

        childObj.Language = 'X';
        System.assertEquals('X', childObj.Language);

        childObj.LanguageDesc = 'X';
        System.assertEquals('X', childObj.LanguageDesc);

        childObj.TelephoneNO = 'X';
        System.assertEquals('X', childObj.TelephoneNO);

        childObj.TelephoneNumberExtension = 'X';
        System.assertEquals('X', childObj.TelephoneNumberExtension);

        childObj.MobileNumber = 'X';
        System.assertEquals('X', childObj.MobileNumber);

        childObj.FaxNumber = 'X';
        System.assertEquals('X', childObj.FaxNumber);

        childObj.FaxNumberExtension = 'X';
        System.assertEquals('X', childObj.FaxNumberExtension);

        childObj.EMailAddress = 'X';
        System.assertEquals('X', childObj.EMailAddress);

        childObj.DefaultCommunicationMethod = 'X';
        System.assertEquals('X', childObj.DefaultCommunicationMethod);

        childObj.DefaultCommunicationMethodDescription = 'X';
        System.assertEquals('X', childObj.DefaultCommunicationMethodDescription);

        childObj.Extension1 = 'X';
        System.assertEquals('X', childObj.Extension1);

        childObj.Extension2 = 'X';
        System.assertEquals('X', childObj.Extension2);

        childObj.AddressNotes = 'X';
        System.assertEquals('X', childObj.AddressNotes);

        List<string> keyFields = new List<string>{ 'PARNR' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testTAX_CLASSIFICATION()
    {
        SBO_EnosixCustomer_Detail.TAX_CLASSIFICATION childObj = new SBO_EnosixCustomer_Detail.TAX_CLASSIFICATION();
        System.assertEquals(SBO_EnosixCustomer_Detail.TAX_CLASSIFICATION.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.CountryCode = 'X';
        System.assertEquals('X', childObj.CountryCode);

        childObj.CountryName = 'X';
        System.assertEquals('X', childObj.CountryName);

        childObj.TaxCategory = 'X';
        System.assertEquals('X', childObj.TaxCategory);

        childObj.TaxCategoryName = 'X';
        System.assertEquals('X', childObj.TaxCategoryName);

        childObj.TaxClassification = 'X';
        System.assertEquals('X', childObj.TaxClassification);

        childObj.TaxClassificationDescription = 'X';
        System.assertEquals('X', childObj.TaxClassificationDescription);

        List<string> keyFields = new List<string>{ 'ALAND','COUNTRY_LANDX','TATYP','VTEXT','TAXKD','TAXKD_TEXT' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
}
