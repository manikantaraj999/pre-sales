/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
public with sharing class TST_EnosixOpportunityPricing_Detail
{
    public class MockSBO_EnosixOpportunityPricing_Detail implements
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
        SBO_EnosixOpportunityPricing_Detail sbo = new SBO_EnosixOpportunityPricing_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixOpportunityPricing_Detail.class, new MockSBO_EnosixOpportunityPricing_Detail());
        System.assertEquals(null, sbo.initialize(null));
        System.assertEquals(null, sbo.command(null, null));
        System.assertEquals(null, sbo.getDetail(null));
        System.assertEquals(null, sbo.save(null));
    }

    @isTest
    static void testEnosixOpportunityPricing()
    {
        SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing result = new SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing();
        System.assertEquals(SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing.class, result.getType(), 'getType() does not match object type.');

        result.registerReflectionForClass();

        result.SalesDocument = 'X';
        System.assertEquals('X', result.SalesDocument);

        result.SoldToParty = 'X';
        System.assertEquals('X', result.SoldToParty);

        result.SoldToPartyText = 'X';
        System.assertEquals('X', result.SoldToPartyText);

        result.CustomerPurchaseOrderNumber = 'X';
        System.assertEquals('X', result.CustomerPurchaseOrderNumber);

        result.CustomerPurchaseOrderDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), result.CustomerPurchaseOrderDate);

        result.NetOrderValue = 1.5;
        System.assertEquals(1.5, result.NetOrderValue);

        result.TaxAmount = 1.5;
        System.assertEquals(1.5, result.TaxAmount);

        result.SalesDocumentCurrency = 'X';
        System.assertEquals('X', result.SalesDocumentCurrency);

        result.BillingPlan = 'X';
        System.assertEquals('X', result.BillingPlan);

        result.ReferenceDocument = 'X';
        System.assertEquals('X', result.ReferenceDocument);

        result.ReferenceDocumentCategory = 'X';
        System.assertEquals('X', result.ReferenceDocumentCategory);

        result.DocumentCategory = 'X';
        System.assertEquals('X', result.DocumentCategory);

        result.DocumentCategoryDescription = 'X';
        System.assertEquals('X', result.DocumentCategoryDescription);

        result.TransactionGroup = 'X';
        System.assertEquals('X', result.TransactionGroup);

        result.TransactionGroupDescription = 'X';
        System.assertEquals('X', result.TransactionGroupDescription);

        //Test child collections
        System.assertNotEquals(null,result.SALES);
        System.assertNotEquals(null,result.CONDITIONS.getAsList());
        System.assertNotEquals(null,result.PARTNERS.getAsList());
        System.assertNotEquals(null,result.ITEMS.getAsList());
        System.assertNotEquals(null,result.ITEMS_SCHEDULE.getAsList());
        System.assertNotEquals(null,result.ITEMS_CONFIG.getAsList());
    }

    @isTest
    static void testSALES()
    {
        SBO_EnosixOpportunityPricing_Detail.SALES childObj = new SBO_EnosixOpportunityPricing_Detail.SALES();
        System.assertEquals(SBO_EnosixOpportunityPricing_Detail.SALES.class,childObj.getType(),'getType() does not match object type.');

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

        childObj.SalesDocumentCurrency = 'X';
        System.assertEquals('X', childObj.SalesDocumentCurrency);

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
    static void testCONDITIONS()
    {
        SBO_EnosixOpportunityPricing_Detail.CONDITIONS childObj = new SBO_EnosixOpportunityPricing_Detail.CONDITIONS();
        System.assertEquals(SBO_EnosixOpportunityPricing_Detail.CONDITIONS.class,childObj.getType(),'getType() does not match object type.');

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

        childObj.ConditionTypeName = 'X';
        System.assertEquals('X', childObj.ConditionTypeName);

        childObj.Rate = 1.5;
        System.assertEquals(1.5, childObj.Rate);

        childObj.RateUnit = 'X';
        System.assertEquals('X', childObj.RateUnit);

        childObj.ConditionPricingUnit = 1.5;
        System.assertEquals(1.5, childObj.ConditionPricingUnit);

        childObj.ConditionUnit = 'X';
        System.assertEquals('X', childObj.ConditionUnit);

        childObj.KWERT = 1.5;
        System.assertEquals(1.5, childObj.KWERT);

        childObj.CurrencyKey = 'X';
        System.assertEquals('X', childObj.CurrencyKey);

        childObj.CondValueforCumulationFields = 1.5;
        System.assertEquals(1.5, childObj.CondValueforCumulationFields);

        childObj.CondCurrencyforCumulationFlds = 'X';
        System.assertEquals('X', childObj.CondCurrencyforCumulationFlds);

        childObj.ConditionStatistics = true;
        System.assertEquals(true, childObj.ConditionStatistics);

        childObj.KRECH = 'X';
        System.assertEquals('X', childObj.KRECH);

        childObj.KMANU = 'X';
        System.assertEquals('X', childObj.KMANU);

        childObj.ConditionControl = 'X';
        System.assertEquals('X', childObj.ConditionControl);

        childObj.KHERK = 'X';
        System.assertEquals('X', childObj.KHERK);

        List<string> keyFields = new List<string>{ 'KPOSN','STUNR','ZAEHK','KSCHL' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testPARTNERS()
    {
        SBO_EnosixOpportunityPricing_Detail.PARTNERS childObj = new SBO_EnosixOpportunityPricing_Detail.PARTNERS();
        System.assertEquals(SBO_EnosixOpportunityPricing_Detail.PARTNERS.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.PartnerFunction = 'X';
        System.assertEquals('X', childObj.PartnerFunction);

        childObj.PartnerFunctionName = 'X';
        System.assertEquals('X', childObj.PartnerFunctionName);

        childObj.CustomerNumber = 'X';
        System.assertEquals('X', childObj.CustomerNumber);

        childObj.Vendor = 'X';
        System.assertEquals('X', childObj.Vendor);

        childObj.PersonnelNumber = 'X';
        System.assertEquals('X', childObj.PersonnelNumber);

        childObj.ContactPersonNumber = 'X';
        System.assertEquals('X', childObj.ContactPersonNumber);

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

        childObj.District = 'X';
        System.assertEquals('X', childObj.District);

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

        childObj.ItemNumber = 'X';
        System.assertEquals('X', childObj.ItemNumber);

        List<string> keyFields = new List<string>{ 'PARVW','KUNNR','LIFNR','PERNR','PARNR' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testITEMS()
    {
        SBO_EnosixOpportunityPricing_Detail.ITEMS childObj = new SBO_EnosixOpportunityPricing_Detail.ITEMS();
        System.assertEquals(SBO_EnosixOpportunityPricing_Detail.ITEMS.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.ItemNumber = 'X';
        System.assertEquals('X', childObj.ItemNumber);

        childObj.Material = 'X';
        System.assertEquals('X', childObj.Material);

        childObj.OrderQuantity = 1.5;
        System.assertEquals(1.5, childObj.OrderQuantity);

        childObj.SalesUnit = 'X';
        System.assertEquals('X', childObj.SalesUnit);

        childObj.SalesUnitDescription = 'X';
        System.assertEquals('X', childObj.SalesUnitDescription);

        childObj.TaxAmount = 1.5;
        System.assertEquals(1.5, childObj.TaxAmount);

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

        childObj.ConditionUnit = 'X';
        System.assertEquals('X', childObj.ConditionUnit);

        childObj.ConditionUnitDescription = 'X';
        System.assertEquals('X', childObj.ConditionUnitDescription);

        childObj.NetOrderValue = 1.5;
        System.assertEquals(1.5, childObj.NetOrderValue);

        childObj.SalesDocumentCurrency = 'X';
        System.assertEquals('X', childObj.SalesDocumentCurrency);

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

        childObj.ItemReferenceDocument = 'X';
        System.assertEquals('X', childObj.ItemReferenceDocument);

        childObj.ItemReferenceDocumentItNumber = 'X';
        System.assertEquals('X', childObj.ItemReferenceDocumentItNumber);

        childObj.ItemReferenceDocumentCtegory = 'X';
        System.assertEquals('X', childObj.ItemReferenceDocumentCtegory);

        childObj.CostInDocCurrency = 1.5;
        System.assertEquals(1.5, childObj.CostInDocCurrency);

        childObj.ConfigurableMaterial = true;
        System.assertEquals(true, childObj.ConfigurableMaterial);

        childObj.GRPOS = 'X';
        System.assertEquals('X', childObj.GRPOS);

        childObj.STLNR = 'X';
        System.assertEquals('X', childObj.STLNR);

        List<string> keyFields = new List<string>{ 'POSNR' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testITEMS_SCHEDULE()
    {
        SBO_EnosixOpportunityPricing_Detail.ITEMS_SCHEDULE childObj = new SBO_EnosixOpportunityPricing_Detail.ITEMS_SCHEDULE();
        System.assertEquals(SBO_EnosixOpportunityPricing_Detail.ITEMS_SCHEDULE.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.ItemNumber = 'X';
        System.assertEquals('X', childObj.ItemNumber);

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

        List<string> keyFields = new List<string>{ 'POSNR','ETENR' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testITEMS_CONFIG()
    {
        SBO_EnosixOpportunityPricing_Detail.ITEMS_CONFIG childObj = new SBO_EnosixOpportunityPricing_Detail.ITEMS_CONFIG();
        System.assertEquals(SBO_EnosixOpportunityPricing_Detail.ITEMS_CONFIG.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.ItemNumber = 'X';
        System.assertEquals('X', childObj.ItemNumber);

        childObj.Material = 'X';
        System.assertEquals('X', childObj.Material);

        childObj.CharacteristicID = 'X';
        System.assertEquals('X', childObj.CharacteristicID);

        childObj.CharacteristicName = 'X';
        System.assertEquals('X', childObj.CharacteristicName);

        childObj.CharacteristicDescription = 'X';
        System.assertEquals('X', childObj.CharacteristicDescription);

        childObj.CharacteristicValue = 'X';
        System.assertEquals('X', childObj.CharacteristicValue);

        childObj.CharacteristicValueDescription = 'X';
        System.assertEquals('X', childObj.CharacteristicValueDescription);

        List<string> keyFields = new List<string>{ 'POSNR','MATNR','ATINN','ATNAM','ATBEZ','ATWRT','ATWTB' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
}
