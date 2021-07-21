/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
public with sharing class TST_SFCISalesDocument_Detail
{
    public class MockSBO_SFCISalesDocument_Detail implements
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
        SBO_SFCISalesDocument_Detail sbo = new SBO_SFCISalesDocument_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_SFCISalesDocument_Detail.class, new MockSBO_SFCISalesDocument_Detail());
        System.assertEquals(null, sbo.initialize(null));
        System.assertEquals(null, sbo.command(null, null));
        System.assertEquals(null, sbo.getDetail(null));
        System.assertEquals(null, sbo.save(null));
    }

    @isTest
    static void testSFCISalesDocument()
    {
        SBO_SFCISalesDocument_Detail.SFCISalesDocument result = new SBO_SFCISalesDocument_Detail.SFCISalesDocument();
        System.assertEquals(SBO_SFCISalesDocument_Detail.SFCISalesDocument.class, result.getType(), 'getType() does not match object type.');

        result.registerReflectionForClass();

        result.SalesDocument = 'X';
        System.assertEquals('X', result.SalesDocument);

        result.SoldToParty = 'X';
        System.assertEquals('X', result.SoldToParty);

        result.SoldToAddress = 'X';
        System.assertEquals('X', result.SoldToAddress);

        result.CustomerPurchaseOrderNumber = 'X';
        System.assertEquals('X', result.CustomerPurchaseOrderNumber);

        result.CustomerPurchaseOrderDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), result.CustomerPurchaseOrderDate);

        result.NetValueInDocumentCurrency = 1.5;
        System.assertEquals(1.5, result.NetValueInDocumentCurrency);

        result.TaxAmountInDocumentCurrency = 1.5;
        System.assertEquals(1.5, result.TaxAmountInDocumentCurrency);

        result.SDDocumentCurrency = 'X';
        System.assertEquals('X', result.SDDocumentCurrency);

        result.NumberOfPaymentCardPlanType = 'X';
        System.assertEquals('X', result.NumberOfPaymentCardPlanType);

        result.TransactionGroup = 'X';
        System.assertEquals('X', result.TransactionGroup);

        result.TransactionGroupDescription = 'X';
        System.assertEquals('X', result.TransactionGroupDescription);

        //Test child collections
        System.assertNotEquals(null,result.SALES);
        System.assertNotEquals(null,result.SHIPPING);
        System.assertNotEquals(null,result.BILLING);
        System.assertNotEquals(null,result.ACCOUNTING);
        System.assertNotEquals(null,result.CONDITIONS.getAsList());
        System.assertNotEquals(null,result.PARTNERS.getAsList());
        System.assertNotEquals(null,result.TEXTS.getAsList());
        System.assertNotEquals(null,result.ORDERDATA);
        System.assertNotEquals(null,result.STATUS);
        System.assertNotEquals(null,result.ADDITIONAL_DATA_A);
        System.assertNotEquals(null,result.ITEMS.getAsList());
        System.assertNotEquals(null,result.ITEMS_SCHEDULE.getAsList());
        System.assertNotEquals(null,result.ITEMS_TEXT.getAsList());
        System.assertNotEquals(null,result.CCARD.getAsList());
        System.assertNotEquals(null,result.USER_DEFINED.getAsList());
        System.assertNotEquals(null,result.ITEM_USER_DEFINED.getAsList());
    }

    @isTest
    static void testSALES()
    {
        SBO_SFCISalesDocument_Detail.SALES childObj = new SBO_SFCISalesDocument_Detail.SALES();
        System.assertEquals(SBO_SFCISalesDocument_Detail.SALES.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.SalesDocumentType = 'X';
        System.assertEquals('X', childObj.SalesDocumentType);

        childObj.SalesDocumentTypeDescription = 'X';
        System.assertEquals('X', childObj.SalesDocumentTypeDescription);

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

        childObj.SalesGroup = 'X';
        System.assertEquals('X', childObj.SalesGroup);

        childObj.SalesGroupName = 'X';
        System.assertEquals('X', childObj.SalesGroupName);

        childObj.SalesOffice = 'X';
        System.assertEquals('X', childObj.SalesOffice);

        childObj.SalesOfficeName = 'X';
        System.assertEquals('X', childObj.SalesOfficeName);

        childObj.CreateDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.CreateDate);

        childObj.EntryTime = Time.newInstance(1,1,1,0);
        System.assertEquals(Time.newInstance(1,1,1,0), childObj.EntryTime);

        childObj.CreatedBy = 'X';
        System.assertEquals('X', childObj.CreatedBy);

        childObj.ValidFrom = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.ValidFrom);

        childObj.ValidTo = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.ValidTo);

        childObj.SalesDocumentVersionNumber = 'X';
        System.assertEquals('X', childObj.SalesDocumentVersionNumber);

        childObj.WarrantyDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.WarrantyDate);

        childObj.OrderReason = 'X';
        System.assertEquals('X', childObj.OrderReason);

        childObj.OrderReasonDescription = 'X';
        System.assertEquals('X', childObj.OrderReasonDescription);

        childObj.AgreedDeliveryTime = 'X';
        System.assertEquals('X', childObj.AgreedDeliveryTime);

        childObj.AgreedDeliveryTimeDescription = 'X';
        System.assertEquals('X', childObj.AgreedDeliveryTimeDescription);

        childObj.SDDocumentCurrency = 'X';
        System.assertEquals('X', childObj.SDDocumentCurrency);

        childObj.ExchangeRatePriceDetermination = 1.5;
        System.assertEquals(1.5, childObj.ExchangeRatePriceDetermination);

        childObj.DateforPricingExchangeRate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.DateforPricingExchangeRate);

        childObj.PricingProcedureInPricing = 'X';
        System.assertEquals('X', childObj.PricingProcedureInPricing);

        childObj.PricingProcedureInPricingDesc = 'X';
        System.assertEquals('X', childObj.PricingProcedureInPricingDesc);

        childObj.CustomerGroup = 'X';
        System.assertEquals('X', childObj.CustomerGroup);

        childObj.CustomerGroupName = 'X';
        System.assertEquals('X', childObj.CustomerGroupName);

        childObj.PriceListType = 'X';
        System.assertEquals('X', childObj.PriceListType);

        childObj.PriceListTypeText = 'X';
        System.assertEquals('X', childObj.PriceListTypeText);

        childObj.UsageIndicator = 'X';
        System.assertEquals('X', childObj.UsageIndicator);

        childObj.UsageIndicatorDescription = 'X';
        System.assertEquals('X', childObj.UsageIndicatorDescription);

        childObj.PriceGroup = 'X';
        System.assertEquals('X', childObj.PriceGroup);

        childObj.PriceGroupDescription = 'X';
        System.assertEquals('X', childObj.PriceGroupDescription);

        childObj.SalesDistrict = 'X';
        System.assertEquals('X', childObj.SalesDistrict);

        childObj.SalesDistrictName = 'X';
        System.assertEquals('X', childObj.SalesDistrictName);

        childObj.RequestedDeliveryDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.RequestedDeliveryDate);

        childObj.DeliveryBlock = 'X';
        System.assertEquals('X', childObj.DeliveryBlock);

        childObj.DeliveryBlockDescription = 'X';
        System.assertEquals('X', childObj.DeliveryBlockDescription);

        childObj.BillingBlock = 'X';
        System.assertEquals('X', childObj.BillingBlock);

        childObj.BillingBlockDescription = 'X';
        System.assertEquals('X', childObj.BillingBlockDescription);

        childObj.TermsofPaymentKey = 'X';
        System.assertEquals('X', childObj.TermsofPaymentKey);

        childObj.TermsofPaymentKeyDescription = 'X';
        System.assertEquals('X', childObj.TermsofPaymentKeyDescription);

        childObj.IncotermsPart1 = 'X';
        System.assertEquals('X', childObj.IncotermsPart1);

        childObj.IncotermsPart1Description = 'X';
        System.assertEquals('X', childObj.IncotermsPart1Description);

        childObj.IncotermsPart2 = 'X';
        System.assertEquals('X', childObj.IncotermsPart2);

        List<string> keyFields = new List<string>{ 'EnosixObjKey' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testSHIPPING()
    {
        SBO_SFCISalesDocument_Detail.SHIPPING childObj = new SBO_SFCISalesDocument_Detail.SHIPPING();
        System.assertEquals(SBO_SFCISalesDocument_Detail.SHIPPING.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.ShipToParty = 'X';
        System.assertEquals('X', childObj.ShipToParty);

        childObj.ShipToPartyText = 'X';
        System.assertEquals('X', childObj.ShipToPartyText);

        childObj.UnloadingPoint = 'X';
        System.assertEquals('X', childObj.UnloadingPoint);

        childObj.ReceivingPoint = 'X';
        System.assertEquals('X', childObj.ReceivingPoint);

        childObj.DepartmentNumber = 'X';
        System.assertEquals('X', childObj.DepartmentNumber);

        childObj.DepartmentNumberDescription = 'X';
        System.assertEquals('X', childObj.DepartmentNumberDescription);

        childObj.DeliveryBlock = 'X';
        System.assertEquals('X', childObj.DeliveryBlock);

        childObj.DeliveryBlockDescription = 'X';
        System.assertEquals('X', childObj.DeliveryBlockDescription);

        childObj.ShippingConditions = 'X';
        System.assertEquals('X', childObj.ShippingConditions);

        childObj.ShippingConditionsDescription = 'X';
        System.assertEquals('X', childObj.ShippingConditionsDescription);

        childObj.DangerousGoodsMngmntProfile = 'X';
        System.assertEquals('X', childObj.DangerousGoodsMngmntProfile);

        childObj.DangerousGoodsMngmntProfDesc = 'X';
        System.assertEquals('X', childObj.DangerousGoodsMngmntProfDesc);

        childObj.MeansofTransportType = 'X';
        System.assertEquals('X', childObj.MeansofTransportType);

        childObj.MeansofTransportTypDescription = 'X';
        System.assertEquals('X', childObj.MeansofTransportTypDescription);

        childObj.MeansofTransport = 'X';
        System.assertEquals('X', childObj.MeansofTransport);

        childObj.MeansofTransportDescription = 'X';
        System.assertEquals('X', childObj.MeansofTransportDescription);

        childObj.RelevantforPODprocessing = true;
        System.assertEquals(true, childObj.RelevantforPODprocessing);

        childObj.CompleteDeliveryDefined = true;
        System.assertEquals(true, childObj.CompleteDeliveryDefined);

        childObj.OrderCombinationIndicator = true;
        System.assertEquals(true, childObj.OrderCombinationIndicator);

        childObj.DocumentContainsDangerousGoods = 'X';
        System.assertEquals('X', childObj.DocumentContainsDangerousGoods);

        childObj.ShippingType = 'X';
        System.assertEquals('X', childObj.ShippingType);

        childObj.ShippingTypeDescription = 'X';
        System.assertEquals('X', childObj.ShippingTypeDescription);

        childObj.SpecialProcessing = 'X';
        System.assertEquals('X', childObj.SpecialProcessing);

        childObj.SpecialProcessingDescription = 'X';
        System.assertEquals('X', childObj.SpecialProcessingDescription);

        childObj.TotalWeight = 1.5;
        System.assertEquals(1.5, childObj.TotalWeight);

        childObj.WeightUnit = 'X';
        System.assertEquals('X', childObj.WeightUnit);

        childObj.Netweight = 1.5;
        System.assertEquals(1.5, childObj.Netweight);

        childObj.Volume = 1.5;
        System.assertEquals(1.5, childObj.Volume);

        childObj.VolumeUnit = 'X';
        System.assertEquals('X', childObj.VolumeUnit);

        List<string> keyFields = new List<string>{ 'EnosixObjKey' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testBILLING()
    {
        SBO_SFCISalesDocument_Detail.BILLING childObj = new SBO_SFCISalesDocument_Detail.BILLING();
        System.assertEquals(SBO_SFCISalesDocument_Detail.BILLING.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.Payer = 'X';
        System.assertEquals('X', childObj.Payer);

        childObj.PayerDisplayText = 'X';
        System.assertEquals('X', childObj.PayerDisplayText);

        childObj.IncotermsPart1 = 'X';
        System.assertEquals('X', childObj.IncotermsPart1);

        childObj.IncotermsPart1Description = 'X';
        System.assertEquals('X', childObj.IncotermsPart1Description);

        childObj.IncotermsPart2 = 'X';
        System.assertEquals('X', childObj.IncotermsPart2);

        childObj.FixedValueDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.FixedValueDate);

        childObj.TermsofPaymentKey = 'X';
        System.assertEquals('X', childObj.TermsofPaymentKey);

        childObj.TermsofPaymentKeyDescription = 'X';
        System.assertEquals('X', childObj.TermsofPaymentKeyDescription);

        childObj.AdditionalValueDays = 'X';
        System.assertEquals('X', childObj.AdditionalValueDays);

        childObj.BillingBlock = 'X';
        System.assertEquals('X', childObj.BillingBlock);

        childObj.BillingBlockDescription = 'X';
        System.assertEquals('X', childObj.BillingBlockDescription);

        childObj.InvoiceDates = 'X';
        System.assertEquals('X', childObj.InvoiceDates);

        childObj.InvoiceDatesText = 'X';
        System.assertEquals('X', childObj.InvoiceDatesText);

        childObj.BillingDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.BillingDate);

        childObj.CompanyCodeToBeBilled = 'X';
        System.assertEquals('X', childObj.CompanyCodeToBeBilled);

        childObj.CompanyCodeToBeBilledText = 'X';
        System.assertEquals('X', childObj.CompanyCodeToBeBilledText);

        childObj.DateOnWhichServicesRendered = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.DateOnWhichServicesRendered);

        childObj.AlternativeTaxClassification = 'X';
        System.assertEquals('X', childObj.AlternativeTaxClassification);

        childObj.AltTaxClassificationDescription = 'X';
        System.assertEquals('X', childObj.AltTaxClassificationDescription);

        childObj.TaxDepartureCountry = 'X';
        System.assertEquals('X', childObj.TaxDepartureCountry);

        childObj.TaxDepartureCountryName = 'X';
        System.assertEquals('X', childObj.TaxDepartureCountryName);

        childObj.TaxDestinationCountry = 'X';
        System.assertEquals('X', childObj.TaxDestinationCountry);

        childObj.TaxDestinationCountryName = 'X';
        System.assertEquals('X', childObj.TaxDestinationCountryName);

        childObj.TriangularDeal = true;
        System.assertEquals(true, childObj.TriangularDeal);

        childObj.PaymentGuaranteeProcedure = 'X';
        System.assertEquals('X', childObj.PaymentGuaranteeProcedure);

        childObj.PaymentGuaranteeProcedureDesc = 'X';
        System.assertEquals('X', childObj.PaymentGuaranteeProcedureDesc);

        childObj.InternalfinancialDocNumber = 'X';
        System.assertEquals('X', childObj.InternalfinancialDocNumber);

        childObj.DepreciationPercentage = 1.5;
        System.assertEquals(1.5, childObj.DepreciationPercentage);

        List<string> keyFields = new List<string>{ 'EnosixObjKey' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testACCOUNTING()
    {
        SBO_SFCISalesDocument_Detail.ACCOUNTING childObj = new SBO_SFCISalesDocument_Detail.ACCOUNTING();
        System.assertEquals(SBO_SFCISalesDocument_Detail.ACCOUNTING.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.AccountAssignmentGroup = 'X';
        System.assertEquals('X', childObj.AccountAssignmentGroup);

        childObj.AccountAssignmentGroupDesc = 'X';
        System.assertEquals('X', childObj.AccountAssignmentGroupDesc);

        childObj.PaymentMethod = 'X';
        System.assertEquals('X', childObj.PaymentMethod);

        childObj.PaymentMethodDescription = 'X';
        System.assertEquals('X', childObj.PaymentMethodDescription);

        childObj.PostingPeriod = 'X';
        System.assertEquals('X', childObj.PostingPeriod);

        childObj.FiscalYear = 'X';
        System.assertEquals('X', childObj.FiscalYear);

        childObj.AssignmentNumber = 'X';
        System.assertEquals('X', childObj.AssignmentNumber);

        childObj.ExchangeRateforFIpostings = 1.5;
        System.assertEquals(1.5, childObj.ExchangeRateforFIpostings);

        childObj.DunningKey = 'X';
        System.assertEquals('X', childObj.DunningKey);

        childObj.DunningKeyText = 'X';
        System.assertEquals('X', childObj.DunningKeyText);

        childObj.DunningBlock = 'X';
        System.assertEquals('X', childObj.DunningBlock);

        childObj.DunningBlockText = 'X';
        System.assertEquals('X', childObj.DunningBlockText);

        childObj.ReferenceDocumentNumber = 'X';
        System.assertEquals('X', childObj.ReferenceDocumentNumber);

        List<string> keyFields = new List<string>{ 'EnosixObjKey' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testCONDITIONS()
    {
        SBO_SFCISalesDocument_Detail.CONDITIONS childObj = new SBO_SFCISalesDocument_Detail.CONDITIONS();
        System.assertEquals(SBO_SFCISalesDocument_Detail.CONDITIONS.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.ConditionNumber = 'X';
        System.assertEquals('X', childObj.ConditionNumber);

        childObj.ConditionItemNumber = 'X';
        System.assertEquals('X', childObj.ConditionItemNumber);

        childObj.StepNumber = 'X';
        System.assertEquals('X', childObj.StepNumber);

        childObj.ConditionCounter = 'X';
        System.assertEquals('X', childObj.ConditionCounter);

        childObj.ConditionType = 'X';
        System.assertEquals('X', childObj.ConditionType);

        childObj.Name = 'X';
        System.assertEquals('X', childObj.Name);

        childObj.Rate = 1.5;
        System.assertEquals(1.5, childObj.Rate);

        childObj.RateUnit = 'X';
        System.assertEquals('X', childObj.RateUnit);

        childObj.ConditionPricingUnit = 1.5;
        System.assertEquals(1.5, childObj.ConditionPricingUnit);

        childObj.Conditionunit = 'X';
        System.assertEquals('X', childObj.Conditionunit);

        childObj.ConditionValue = 1.5;
        System.assertEquals(1.5, childObj.ConditionValue);

        childObj.SDDocumentCurrency = 'X';
        System.assertEquals('X', childObj.SDDocumentCurrency);

        childObj.CondValueforCumulationFields = 1.5;
        System.assertEquals(1.5, childObj.CondValueforCumulationFields);

        childObj.ConditionCurrency = 'X';
        System.assertEquals('X', childObj.ConditionCurrency);

        childObj.StatisticalCondition = true;
        System.assertEquals(true, childObj.StatisticalCondition);

        childObj.CalculationType = 'X';
        System.assertEquals('X', childObj.CalculationType);

        childObj.ManualEntries = 'X';
        System.assertEquals('X', childObj.ManualEntries);

        List<string> keyFields = new List<string>{ 'KNUMV','KPOSN','STUNR','ZAEHK','KSCHL','KSCHL_VTEXT','KOEIN','KMEIN','WAERK','KWAEH' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testPARTNERS()
    {
        SBO_SFCISalesDocument_Detail.PARTNERS childObj = new SBO_SFCISalesDocument_Detail.PARTNERS();
        System.assertEquals(SBO_SFCISalesDocument_Detail.PARTNERS.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.PartnerFunction = 'X';
        System.assertEquals('X', childObj.PartnerFunction);

        childObj.PartnerFunctionName = 'X';
        System.assertEquals('X', childObj.PartnerFunctionName);

        childObj.PartnerNumber = 'X';
        System.assertEquals('X', childObj.PartnerNumber);

        childObj.PartnerName = 'X';
        System.assertEquals('X', childObj.PartnerName);

        childObj.PartnerName2 = 'X';
        System.assertEquals('X', childObj.PartnerName2);

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

        childObj.Country = 'X';
        System.assertEquals('X', childObj.Country);

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

        childObj.TelephoneNumber = 'X';
        System.assertEquals('X', childObj.TelephoneNumber);

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

        childObj.SalesItem = 'X';
        System.assertEquals('X', childObj.SalesItem);

        List<string> keyFields = new List<string>{ 'PARVW','PARVW_VTEXT','PARTNER_NO','NAME1','NAME2','HOUSE_NUM1','STREET','CITY1','LANGU' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testTEXTS()
    {
        SBO_SFCISalesDocument_Detail.TEXTS childObj = new SBO_SFCISalesDocument_Detail.TEXTS();
        System.assertEquals(SBO_SFCISalesDocument_Detail.TEXTS.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.TextID = 'X';
        System.assertEquals('X', childObj.TextID);

        childObj.Language = 'X';
        System.assertEquals('X', childObj.Language);

        childObj.ShortText = 'X';
        System.assertEquals('X', childObj.ShortText);

        childObj.Text = 'X';
        System.assertEquals('X', childObj.Text);

        List<string> keyFields = new List<string>{ 'TDID','TDSPRAS','TDTEXT','TEXT' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testORDERDATA()
    {
        SBO_SFCISalesDocument_Detail.ORDERDATA childObj = new SBO_SFCISalesDocument_Detail.ORDERDATA();
        System.assertEquals(SBO_SFCISalesDocument_Detail.ORDERDATA.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.CustomerPurchaseOrderNumber = 'X';
        System.assertEquals('X', childObj.CustomerPurchaseOrderNumber);

        childObj.CustomerPurchaseOrderDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.CustomerPurchaseOrderDate);

        childObj.CustomerPurchaseOrderType = 'X';
        System.assertEquals('X', childObj.CustomerPurchaseOrderType);

        childObj.PurchaseOrderNumberSupplement = 'X';
        System.assertEquals('X', childObj.PurchaseOrderNumberSupplement);

        childObj.LastCustomerContactDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.LastCustomerContactDate);

        childObj.NumberOfContactsFromCustomer = 1.5;
        System.assertEquals(1.5, childObj.NumberOfContactsFromCustomer);

        childObj.OrdererName = 'X';
        System.assertEquals('X', childObj.OrdererName);

        childObj.CollectiveNumber = 'X';
        System.assertEquals('X', childObj.CollectiveNumber);

        childObj.YourReference = 'X';
        System.assertEquals('X', childObj.YourReference);

        childObj.TelephoneNumber = 'X';
        System.assertEquals('X', childObj.TelephoneNumber);

        childObj.ShipToPurchaseOrderNumber = 'X';
        System.assertEquals('X', childObj.ShipToPurchaseOrderNumber);

        childObj.ShipToPODate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.ShipToPODate);

        childObj.ShipToPurchaseOrderType = 'X';
        System.assertEquals('X', childObj.ShipToPurchaseOrderType);

        childObj.ShipToCharacter = 'X';
        System.assertEquals('X', childObj.ShipToCharacter);

        List<string> keyFields = new List<string>{ 'EnosixObjKey' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testSTATUS()
    {
        SBO_SFCISalesDocument_Detail.STATUS childObj = new SBO_SFCISalesDocument_Detail.STATUS();
        System.assertEquals(SBO_SFCISalesDocument_Detail.STATUS.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.OverallStatusDescription = 'X';
        System.assertEquals('X', childObj.OverallStatusDescription);

        childObj.RejectionStatusDescription = 'X';
        System.assertEquals('X', childObj.RejectionStatusDescription);

        childObj.DeliveryStatusDescription = 'X';
        System.assertEquals('X', childObj.DeliveryStatusDescription);

        childObj.CreditStatusDescription = 'X';
        System.assertEquals('X', childObj.CreditStatusDescription);

        childObj.OveralBlockedStatusDescription = 'X';
        System.assertEquals('X', childObj.OveralBlockedStatusDescription);

        childObj.DataCompleteDescription = 'X';
        System.assertEquals('X', childObj.DataCompleteDescription);

        childObj.HeaderDeliveryDataCompleteDesc = 'X';
        System.assertEquals('X', childObj.HeaderDeliveryDataCompleteDesc);

        childObj.HeaderBillingCompleteDesc = 'X';
        System.assertEquals('X', childObj.HeaderBillingCompleteDesc);

        childObj.ItemDataCompleteDesc = 'X';
        System.assertEquals('X', childObj.ItemDataCompleteDesc);

        childObj.ItemDeliveryDataCompleteDesc = 'X';
        System.assertEquals('X', childObj.ItemDeliveryDataCompleteDesc);

        childObj.ItemBillingDataCompleteDesc = 'X';
        System.assertEquals('X', childObj.ItemBillingDataCompleteDesc);

        List<string> keyFields = new List<string>{ 'EnosixObjKey' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testADDITIONAL_DATA_A()
    {
        SBO_SFCISalesDocument_Detail.ADDITIONAL_DATA_A childObj = new SBO_SFCISalesDocument_Detail.ADDITIONAL_DATA_A();
        System.assertEquals(SBO_SFCISalesDocument_Detail.ADDITIONAL_DATA_A.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.CustomerGroup1 = 'X';
        System.assertEquals('X', childObj.CustomerGroup1);

        childObj.CustomerGroup1Description = 'X';
        System.assertEquals('X', childObj.CustomerGroup1Description);

        childObj.CustomerGroup2 = 'X';
        System.assertEquals('X', childObj.CustomerGroup2);

        childObj.CustomerGroup2Description = 'X';
        System.assertEquals('X', childObj.CustomerGroup2Description);

        childObj.CustomerGroup3 = 'X';
        System.assertEquals('X', childObj.CustomerGroup3);

        childObj.CustomerGroup3Description = 'X';
        System.assertEquals('X', childObj.CustomerGroup3Description);

        childObj.CustomerGroup4 = 'X';
        System.assertEquals('X', childObj.CustomerGroup4);

        childObj.CustomerGroup4Description = 'X';
        System.assertEquals('X', childObj.CustomerGroup4Description);

        childObj.CustomerGroup5 = 'X';
        System.assertEquals('X', childObj.CustomerGroup5);

        childObj.CustomerGroup5Description = 'X';
        System.assertEquals('X', childObj.CustomerGroup5Description);

        childObj.CustomerConditionGroup1 = 'X';
        System.assertEquals('X', childObj.CustomerConditionGroup1);

        childObj.CustomerConditionGroup1Description = 'X';
        System.assertEquals('X', childObj.CustomerConditionGroup1Description);

        childObj.CustomerConditionGroup2 = 'X';
        System.assertEquals('X', childObj.CustomerConditionGroup2);

        childObj.CustomerConditionGroup2Description = 'X';
        System.assertEquals('X', childObj.CustomerConditionGroup2Description);

        childObj.CustomerConditionGroup3 = 'X';
        System.assertEquals('X', childObj.CustomerConditionGroup3);

        childObj.CustomerConditionGroup3Description = 'X';
        System.assertEquals('X', childObj.CustomerConditionGroup3Description);

        childObj.CustomerConditionGroup4 = 'X';
        System.assertEquals('X', childObj.CustomerConditionGroup4);

        childObj.CustomerConditionGroup4Description = 'X';
        System.assertEquals('X', childObj.CustomerConditionGroup4Description);

        childObj.CustomerConditionGroup5 = 'X';
        System.assertEquals('X', childObj.CustomerConditionGroup5);

        childObj.CustomerConditionGroup5Description = 'X';
        System.assertEquals('X', childObj.CustomerConditionGroup5Description);

        List<string> keyFields = new List<string>{ 'EnosixObjKey' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testITEMS()
    {
        SBO_SFCISalesDocument_Detail.ITEMS childObj = new SBO_SFCISalesDocument_Detail.ITEMS();
        System.assertEquals(SBO_SFCISalesDocument_Detail.ITEMS.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.SalesItem = 'X';
        System.assertEquals('X', childObj.SalesItem);

        childObj.Material = 'X';
        System.assertEquals('X', childObj.Material);

        childObj.OrderQuantity = 1.5;
        System.assertEquals(1.5, childObj.OrderQuantity);

        childObj.SalesUnit = 'X';
        System.assertEquals('X', childObj.SalesUnit);

        childObj.SalesUnitDescription = 'X';
        System.assertEquals('X', childObj.SalesUnitDescription);

        childObj.ItemDescription = 'X';
        System.assertEquals('X', childObj.ItemDescription);

        childObj.CustomerMaterialNumber = 'X';
        System.assertEquals('X', childObj.CustomerMaterialNumber);

        childObj.ItemCategory = 'X';
        System.assertEquals('X', childObj.ItemCategory);

        childObj.ItemCategoryDescription = 'X';
        System.assertEquals('X', childObj.ItemCategoryDescription);

        childObj.DangerousGoodsIndicator = 'X';
        System.assertEquals('X', childObj.DangerousGoodsIndicator);

        childObj.HigherLevelItemNumber = 'X';
        System.assertEquals('X', childObj.HigherLevelItemNumber);

        childObj.ScheduleLineDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.ScheduleLineDate);

        childObj.Plant = 'X';
        System.assertEquals('X', childObj.Plant);

        childObj.PlantName = 'X';
        System.assertEquals('X', childObj.PlantName);

        childObj.BatchNumber = 'X';
        System.assertEquals('X', childObj.BatchNumber);

        childObj.ConditionType = 'X';
        System.assertEquals('X', childObj.ConditionType);

        childObj.Rate = 1.5;
        System.assertEquals(1.5, childObj.Rate);

        childObj.RateUnit = 'X';
        System.assertEquals('X', childObj.RateUnit);

        childObj.NetItemPrice = 1.5;
        System.assertEquals(1.5, childObj.NetItemPrice);

        childObj.ConditionPricingUnit = 1.5;
        System.assertEquals(1.5, childObj.ConditionPricingUnit);

        childObj.Conditionunit = 'X';
        System.assertEquals('X', childObj.Conditionunit);

        childObj.ConditionUnitDescription = 'X';
        System.assertEquals('X', childObj.ConditionUnitDescription);

        childObj.NetValueInDocumentCurrency = 1.5;
        System.assertEquals(1.5, childObj.NetValueInDocumentCurrency);

        childObj.ItemTax = 1.5;
        System.assertEquals(1.5, childObj.ItemTax);

        childObj.SDDocumentCurrency = 'X';
        System.assertEquals('X', childObj.SDDocumentCurrency);

        childObj.ConditionScaleQuantity = 1.5;
        System.assertEquals(1.5, childObj.ConditionScaleQuantity);

        childObj.ReasonForRejection = 'X';
        System.assertEquals('X', childObj.ReasonForRejection);

        childObj.CustomerPurchaseOrderNumber = 'X';
        System.assertEquals('X', childObj.CustomerPurchaseOrderNumber);

        childObj.CustomerPurchaseOrderItemNumber = 'X';
        System.assertEquals('X', childObj.CustomerPurchaseOrderItemNumber);

        childObj.DeliveryBlockStatus = 'X';
        System.assertEquals('X', childObj.DeliveryBlockStatus);

        childObj.DeliveryBlockStatusDescription = 'X';
        System.assertEquals('X', childObj.DeliveryBlockStatusDescription);

        childObj.BillingBlockStatus = 'X';
        System.assertEquals('X', childObj.BillingBlockStatus);

        childObj.BillingBlockStatusDescription = 'X';
        System.assertEquals('X', childObj.BillingBlockStatusDescription);

        childObj.AgreedDeliveryTime = 'X';
        System.assertEquals('X', childObj.AgreedDeliveryTime);

        childObj.AgreedDeliveryTimeDescription = 'X';
        System.assertEquals('X', childObj.AgreedDeliveryTimeDescription);

        childObj.Materialgroup1 = 'X';
        System.assertEquals('X', childObj.Materialgroup1);

        childObj.Materialgroup1Description = 'X';
        System.assertEquals('X', childObj.Materialgroup1Description);

        childObj.Materialgroup2 = 'X';
        System.assertEquals('X', childObj.Materialgroup2);

        childObj.Materialgroup2Description = 'X';
        System.assertEquals('X', childObj.Materialgroup2Description);

        childObj.Materialgroup3 = 'X';
        System.assertEquals('X', childObj.Materialgroup3);

        childObj.Materialgroup3Description = 'X';
        System.assertEquals('X', childObj.Materialgroup3Description);

        childObj.Materialgroup4 = 'X';
        System.assertEquals('X', childObj.Materialgroup4);

        childObj.Materialgroup4Description = 'X';
        System.assertEquals('X', childObj.Materialgroup4Description);

        childObj.Materialgroup5 = 'X';
        System.assertEquals('X', childObj.Materialgroup5);

        childObj.Materialgroup5Description = 'X';
        System.assertEquals('X', childObj.Materialgroup5Description);

        childObj.CustomerConditionGroup1 = 'X';
        System.assertEquals('X', childObj.CustomerConditionGroup1);

        childObj.CustomerConditionGroup1Description = 'X';
        System.assertEquals('X', childObj.CustomerConditionGroup1Description);

        childObj.CustomerConditionGroup2 = 'X';
        System.assertEquals('X', childObj.CustomerConditionGroup2);

        childObj.CustomerConditionGroup2Description = 'X';
        System.assertEquals('X', childObj.CustomerConditionGroup2Description);

        childObj.CustomerConditionGroup3 = 'X';
        System.assertEquals('X', childObj.CustomerConditionGroup3);

        childObj.CustomerConditionGroup3Description = 'X';
        System.assertEquals('X', childObj.CustomerConditionGroup3Description);

        childObj.CustomerConditionGroup4 = 'X';
        System.assertEquals('X', childObj.CustomerConditionGroup4);

        childObj.CustomerConditionGroup4Description = 'X';
        System.assertEquals('X', childObj.CustomerConditionGroup4Description);

        childObj.CustomerConditionGroup5 = 'X';
        System.assertEquals('X', childObj.CustomerConditionGroup5);

        childObj.CustomerConditionGroup5Description = 'X';
        System.assertEquals('X', childObj.CustomerConditionGroup5Description);

        childObj.ProductHierarchy = 'X';
        System.assertEquals('X', childObj.ProductHierarchy);

        childObj.MaterialGroupHierarchy1 = 'X';
        System.assertEquals('X', childObj.MaterialGroupHierarchy1);

        childObj.MaterialGroupHierarchy2 = 'X';
        System.assertEquals('X', childObj.MaterialGroupHierarchy2);

        childObj.Division = 'X';
        System.assertEquals('X', childObj.Division);

        childObj.DivisionName = 'X';
        System.assertEquals('X', childObj.DivisionName);

        childObj.WBSElementInternal = 'X';
        System.assertEquals('X', childObj.WBSElementInternal);

        childObj.WBSElement = 'X';
        System.assertEquals('X', childObj.WBSElement);

        childObj.WBSElementDescription = 'X';
        System.assertEquals('X', childObj.WBSElementDescription);

        childObj.OrderNumber = 'X';
        System.assertEquals('X', childObj.OrderNumber);

        childObj.ProfitCenter = 'X';
        System.assertEquals('X', childObj.ProfitCenter);

        childObj.MaterialPricingGroup = 'X';
        System.assertEquals('X', childObj.MaterialPricingGroup);

        childObj.MaterialPricingGroupDescription = 'X';
        System.assertEquals('X', childObj.MaterialPricingGroupDescription);

        childObj.CustomerGroup = 'X';
        System.assertEquals('X', childObj.CustomerGroup);

        childObj.CustomerGroupName = 'X';
        System.assertEquals('X', childObj.CustomerGroupName);

        childObj.PriceGroup = 'X';
        System.assertEquals('X', childObj.PriceGroup);

        childObj.PriceGroupDescription = 'X';
        System.assertEquals('X', childObj.PriceGroupDescription);

        childObj.PriceListType = 'X';
        System.assertEquals('X', childObj.PriceListType);

        childObj.PriceListTypeText = 'X';
        System.assertEquals('X', childObj.PriceListTypeText);

        childObj.SalesDistrict = 'X';
        System.assertEquals('X', childObj.SalesDistrict);

        childObj.SalesDistrictName = 'X';
        System.assertEquals('X', childObj.SalesDistrictName);

        childObj.CustomerPurchaseOrderDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.CustomerPurchaseOrderDate);

        childObj.CustomerPurchaseOrderType = 'X';
        System.assertEquals('X', childObj.CustomerPurchaseOrderType);

        childObj.CustomerPurchaseOrderTypeDesc = 'X';
        System.assertEquals('X', childObj.CustomerPurchaseOrderTypeDesc);

        childObj.ShipToPurchaseOrderNumber = 'X';
        System.assertEquals('X', childObj.ShipToPurchaseOrderNumber);

        childObj.ShipToPODate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.ShipToPODate);

        childObj.ShipToPurchaseOrderType = 'X';
        System.assertEquals('X', childObj.ShipToPurchaseOrderType);

        childObj.ShipToPurchaseOrderTypeDesc = 'X';
        System.assertEquals('X', childObj.ShipToPurchaseOrderTypeDesc);

        childObj.ShipToPurchaseOrderItemNumber = 'X';
        System.assertEquals('X', childObj.ShipToPurchaseOrderItemNumber);

        childObj.StorageLocation = 'X';
        System.assertEquals('X', childObj.StorageLocation);

        childObj.StorageLocationDescription = 'X';
        System.assertEquals('X', childObj.StorageLocationDescription);

        childObj.DeliveryPriority = 'X';
        System.assertEquals('X', childObj.DeliveryPriority);

        childObj.DeliveryPriorityDescription = 'X';
        System.assertEquals('X', childObj.DeliveryPriorityDescription);

        childObj.ShippingPoint = 'X';
        System.assertEquals('X', childObj.ShippingPoint);

        childObj.ShippingPointDescription = 'X';
        System.assertEquals('X', childObj.ShippingPointDescription);

        childObj.PartialDelivery = 'X';
        System.assertEquals('X', childObj.PartialDelivery);

        childObj.PartialDeliveryDescription = 'X';
        System.assertEquals('X', childObj.PartialDeliveryDescription);

        childObj.Route = 'X';
        System.assertEquals('X', childObj.Route);

        childObj.RouteDescription = 'X';
        System.assertEquals('X', childObj.RouteDescription);

        childObj.Netweight = 1.5;
        System.assertEquals(1.5, childObj.Netweight);

        childObj.WeightUnit = 'X';
        System.assertEquals('X', childObj.WeightUnit);

        childObj.GrossWeight = 1.5;
        System.assertEquals(1.5, childObj.GrossWeight);

        childObj.Volume = 1.5;
        System.assertEquals(1.5, childObj.Volume);

        childObj.VolumeUnit = 'X';
        System.assertEquals('X', childObj.VolumeUnit);

        childObj.IncotermsPart1 = 'X';
        System.assertEquals('X', childObj.IncotermsPart1);

        childObj.IncotermsPart1Description = 'X';
        System.assertEquals('X', childObj.IncotermsPart1Description);

        childObj.IncotermsPart2 = 'X';
        System.assertEquals('X', childObj.IncotermsPart2);

        childObj.TermsofPaymentKey = 'X';
        System.assertEquals('X', childObj.TermsofPaymentKey);

        childObj.TermsofPaymentKeyDescription = 'X';
        System.assertEquals('X', childObj.TermsofPaymentKeyDescription);

        childObj.BillingBlock = 'X';
        System.assertEquals('X', childObj.BillingBlock);

        childObj.BillingBlockDescription = 'X';
        System.assertEquals('X', childObj.BillingBlockDescription);

        childObj.BillingRelevant = 'X';
        System.assertEquals('X', childObj.BillingRelevant);

        childObj.BillingRelevantDescription = 'X';
        System.assertEquals('X', childObj.BillingRelevantDescription);

        childObj.BillingPlanInHeaderIndicator = 'X';
        System.assertEquals('X', childObj.BillingPlanInHeaderIndicator);

        childObj.OverallStatusDescription = 'X';
        System.assertEquals('X', childObj.OverallStatusDescription);

        childObj.DataCompleteDescription = 'X';
        System.assertEquals('X', childObj.DataCompleteDescription);

        childObj.ExchangeRatePriceDetermination = 1.5;
        System.assertEquals(1.5, childObj.ExchangeRatePriceDetermination);

        childObj.DateforPricingExchangeRate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.DateforPricingExchangeRate);

        childObj.MaterialEntered = 'X';
        System.assertEquals('X', childObj.MaterialEntered);

        childObj.UsageIndicator = 'X';
        System.assertEquals('X', childObj.UsageIndicator);

        childObj.UsageIndicatorDescription = 'X';
        System.assertEquals('X', childObj.UsageIndicatorDescription);

        childObj.PricingReferenceMaterial = 'X';
        System.assertEquals('X', childObj.PricingReferenceMaterial);

        childObj.CostingSheet = 'X';
        System.assertEquals('X', childObj.CostingSheet);

        childObj.CostingSheetDescription = 'X';
        System.assertEquals('X', childObj.CostingSheetDescription);

        childObj.Overheadkey = 'X';
        System.assertEquals('X', childObj.Overheadkey);

        childObj.ReceivingPoint = 'X';
        System.assertEquals('X', childObj.ReceivingPoint);

        childObj.DepartmentNumber = 'X';
        System.assertEquals('X', childObj.DepartmentNumber);

        childObj.DepartmentNumberDescription = 'X';
        System.assertEquals('X', childObj.DepartmentNumberDescription);

        childObj.MaxNumberOfPartialDeliveriesAllowed = 1.5;
        System.assertEquals(1.5, childObj.MaxNumberOfPartialDeliveriesAllowed);

        childObj.OverdeliveryToleranceLimit = 1.5;
        System.assertEquals(1.5, childObj.OverdeliveryToleranceLimit);

        childObj.UnderdeliveryToleranceLimit = 1.5;
        System.assertEquals(1.5, childObj.UnderdeliveryToleranceLimit);

        childObj.FixedValueDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.FixedValueDate);

        childObj.AdditionalValueDays = 'X';
        System.assertEquals('X', childObj.AdditionalValueDays);

        childObj.InvoiceDates = 'X';
        System.assertEquals('X', childObj.InvoiceDates);

        childObj.InvoiceDatesText = 'X';
        System.assertEquals('X', childObj.InvoiceDatesText);

        childObj.BillingDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.BillingDate);

        childObj.DateOnWhichServicesRendered = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.DateOnWhichServicesRendered);

        childObj.AccountAssignmentGroup = 'X';
        System.assertEquals('X', childObj.AccountAssignmentGroup);

        childObj.AccountAssignmentGroupDescription = 'X';
        System.assertEquals('X', childObj.AccountAssignmentGroupDescription);

        childObj.ComponentQuantity = 1.5;
        System.assertEquals(1.5, childObj.ComponentQuantity);

        childObj.BaseUnitOfMeasure = 'X';
        System.assertEquals('X', childObj.BaseUnitOfMeasure);

        childObj.IUIDRelevant = 'X';
        System.assertEquals('X', childObj.IUIDRelevant);

        childObj.DeliveryBlock = 'X';
        System.assertEquals('X', childObj.DeliveryBlock);

        childObj.DeliveryBlockDescription = 'X';
        System.assertEquals('X', childObj.DeliveryBlockDescription);

        List<string> keyFields = new List<string>{ 'POSNR','MATNR','VRKME','VRKME_TXDIM','ARKTX','KDMAT','PSTYV','PSTYV_VTEXT','PROFL' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testITEMS_SCHEDULE()
    {
        SBO_SFCISalesDocument_Detail.ITEMS_SCHEDULE childObj = new SBO_SFCISalesDocument_Detail.ITEMS_SCHEDULE();
        System.assertEquals(SBO_SFCISalesDocument_Detail.ITEMS_SCHEDULE.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.SalesItem = 'X';
        System.assertEquals('X', childObj.SalesItem);

        childObj.ScheduleLineNumber = 'X';
        System.assertEquals('X', childObj.ScheduleLineNumber);

        childObj.ScheduleLineDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.ScheduleLineDate);

        childObj.OrderQuantity = 1.5;
        System.assertEquals(1.5, childObj.OrderQuantity);

        childObj.RoundedQuantity = 1.5;
        System.assertEquals(1.5, childObj.RoundedQuantity);

        childObj.ConfirmedQuantity = 1.5;
        System.assertEquals(1.5, childObj.ConfirmedQuantity);

        childObj.SalesUnit = 'X';
        System.assertEquals('X', childObj.SalesUnit);

        childObj.DeliveryBlock = 'X';
        System.assertEquals('X', childObj.DeliveryBlock);

        childObj.DeliveryBlockDescription = 'X';
        System.assertEquals('X', childObj.DeliveryBlockDescription);

        childObj.DeliveredQuantity = 1.5;
        System.assertEquals(1.5, childObj.DeliveredQuantity);

        childObj.ScheduleLineCategory = 'X';
        System.assertEquals('X', childObj.ScheduleLineCategory);

        childObj.ScheduleLineCategoryDescription = 'X';
        System.assertEquals('X', childObj.ScheduleLineCategoryDescription);

        childObj.PurchaseRequisitionNumber = 'X';
        System.assertEquals('X', childObj.PurchaseRequisitionNumber);

        childObj.PurchaseRequisitionItemNumber = 'X';
        System.assertEquals('X', childObj.PurchaseRequisitionItemNumber);

        List<string> keyFields = new List<string>{ 'POSNR','ETENR','EDATU','VRKME','LIFSP','LIFSP_VTEXT','ETTYP','ETTYP_VTEXT','BANFN' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testITEMS_TEXT()
    {
        SBO_SFCISalesDocument_Detail.ITEMS_TEXT childObj = new SBO_SFCISalesDocument_Detail.ITEMS_TEXT();
        System.assertEquals(SBO_SFCISalesDocument_Detail.ITEMS_TEXT.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.SalesItem = 'X';
        System.assertEquals('X', childObj.SalesItem);

        childObj.TextID = 'X';
        System.assertEquals('X', childObj.TextID);

        childObj.Language = 'X';
        System.assertEquals('X', childObj.Language);

        childObj.ShortText = 'X';
        System.assertEquals('X', childObj.ShortText);

        childObj.Text = 'X';
        System.assertEquals('X', childObj.Text);

        List<string> keyFields = new List<string>{ 'POSNR','TDID','TDSPRAS','TDTEXT','TEXT' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testCCARD()
    {
        SBO_SFCISalesDocument_Detail.CCARD childObj = new SBO_SFCISalesDocument_Detail.CCARD();
        System.assertEquals(SBO_SFCISalesDocument_Detail.CCARD.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.BillingPlanNumber = 'X';
        System.assertEquals('X', childObj.BillingPlanNumber);

        childObj.ItemForBillingPlan = 'X';
        System.assertEquals('X', childObj.ItemForBillingPlan);

        childObj.CardType = 'X';
        System.assertEquals('X', childObj.CardType);

        childObj.CardNumber = 'X';
        System.assertEquals('X', childObj.CardNumber);

        childObj.PaymentCardSuffix = 'X';
        System.assertEquals('X', childObj.PaymentCardSuffix);

        childObj.ValidTo = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.ValidTo);

        childObj.CardholderName = 'X';
        System.assertEquals('X', childObj.CardholderName);

        childObj.ValueToBeBilledOnTheDateSpecified = 1.5;
        System.assertEquals(1.5, childObj.ValueToBeBilledOnTheDateSpecified);

        childObj.AuthorizedAmount = 1.5;
        System.assertEquals(1.5, childObj.AuthorizedAmount);

        childObj.CurrencyKey = 'X';
        System.assertEquals('X', childObj.CurrencyKey);

        childObj.AuthorizationDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.AuthorizationDate);

        childObj.AuthorizationTime = Time.newInstance(1,1,1,0);
        System.assertEquals(Time.newInstance(1,1,1,0), childObj.AuthorizationTime);

        childObj.AuthorizationNumber = 'X';
        System.assertEquals('X', childObj.AuthorizationNumber);

        childObj.SettlementCarriedOut = true;
        System.assertEquals(true, childObj.SettlementCarriedOut);

        childObj.ReferenceCodeOfClearingHouse = 'X';
        System.assertEquals('X', childObj.ReferenceCodeOfClearingHouse);

        childObj.ResponseToAuthorizationChecks = 'X';
        System.assertEquals('X', childObj.ResponseToAuthorizationChecks);

        childObj.StatusWhenExternalSystemIsCalled = 'X';
        System.assertEquals('X', childObj.StatusWhenExternalSystemIsCalled);

        childObj.Preauthorization = true;
        System.assertEquals(true, childObj.Preauthorization);

        childObj.AmountChanged = true;
        System.assertEquals(true, childObj.AmountChanged);

        childObj.AuthorizationType = 'X';
        System.assertEquals('X', childObj.AuthorizationType);

        childObj.HigherLevelAuthorizationForBillingPlan = 'X';
        System.assertEquals('X', childObj.HigherLevelAuthorizationForBillingPlan);

        childObj.ResultOfCardCheck = 'X';
        System.assertEquals('X', childObj.ResultOfCardCheck);

        childObj.ResultText = 'X';
        System.assertEquals('X', childObj.ResultText);

        List<string> keyFields = new List<string>{ 'FPLNR','FPLTR','CC_TYPE','CC_NUMBER','CC_SEQ_NO','CC_VALID_T','CC_NAME','CURRENCY' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testUSER_DEFINED()
    {
        SBO_SFCISalesDocument_Detail.USER_DEFINED childObj = new SBO_SFCISalesDocument_Detail.USER_DEFINED();
        System.assertEquals(SBO_SFCISalesDocument_Detail.USER_DEFINED.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.FIELD = 'X';
        System.assertEquals('X', childObj.FIELD);

        childObj.VALUE = 'X';
        System.assertEquals('X', childObj.VALUE);

        List<string> keyFields = new List<string>{ 'FIELD','VALUE' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testITEM_USER_DEFINED()
    {
        SBO_SFCISalesDocument_Detail.ITEM_USER_DEFINED childObj = new SBO_SFCISalesDocument_Detail.ITEM_USER_DEFINED();
        System.assertEquals(SBO_SFCISalesDocument_Detail.ITEM_USER_DEFINED.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.SalesItem = 'X';
        System.assertEquals('X', childObj.SalesItem);

        childObj.FIELD = 'X';
        System.assertEquals('X', childObj.FIELD);

        childObj.VALUE = 'X';
        System.assertEquals('X', childObj.VALUE);

        List<string> keyFields = new List<string>{ 'POSNR','FIELD','VALUE' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
}
