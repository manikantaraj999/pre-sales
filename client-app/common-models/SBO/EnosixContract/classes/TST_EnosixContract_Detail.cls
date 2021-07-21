/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
public with sharing class TST_EnosixContract_Detail
{
    public class MockSBO_EnosixContract_Detail implements
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
        SBO_EnosixContract_Detail sbo = new SBO_EnosixContract_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixContract_Detail.class, new MockSBO_EnosixContract_Detail());
        System.assertEquals(null, sbo.initialize(null));
        System.assertEquals(null, sbo.command(null, null));
        System.assertEquals(null, sbo.getDetail(null));
        System.assertEquals(null, sbo.save(null));
    }

    @isTest
    static void testEnosixContract()
    {
        SBO_EnosixContract_Detail.EnosixContract result = new SBO_EnosixContract_Detail.EnosixContract();
        System.assertEquals(SBO_EnosixContract_Detail.EnosixContract.class, result.getType(), 'getType() does not match object type.');

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

        result.NetValue = 1.5;
        System.assertEquals(1.5, result.NetValue);

        result.TaxAmount = 1.5;
        System.assertEquals(1.5, result.TaxAmount);

        result.DocumentCurrency = 'X';
        System.assertEquals('X', result.DocumentCurrency);

        result.ReferenceDocument = 'X';
        System.assertEquals('X', result.ReferenceDocument);

        result.ReferenceDocumentCategory = 'X';
        System.assertEquals('X', result.ReferenceDocumentCategory);

        result.ProductProposalSearchTerm = 'X';
        System.assertEquals('X', result.ProductProposalSearchTerm);

        result.ShippingConditions = 'X';
        System.assertEquals('X', result.ShippingConditions);

        result.ShippingConditionsDescription = 'X';
        System.assertEquals('X', result.ShippingConditionsDescription);

        result.BusinessArea = 'X';
        System.assertEquals('X', result.BusinessArea);

        result.BusinessAreaDescription = 'X';
        System.assertEquals('X', result.BusinessAreaDescription);

        //Test child collections
        System.assertNotEquals(null,result.SALES);
        System.assertNotEquals(null,result.CONTRACT.getAsList());
        System.assertNotEquals(null,result.BILL_PLAN.getAsList());
        System.assertNotEquals(null,result.BILLING_PLAN_DATES.getAsList());
        System.assertNotEquals(null,result.SHIPPING);
        System.assertNotEquals(null,result.BILLING);
        System.assertNotEquals(null,result.ACCOUNTING);
        System.assertNotEquals(null,result.CONDITIONS.getAsList());
        System.assertNotEquals(null,result.ACCOUNT_ASSIGNMENT);
        System.assertNotEquals(null,result.PARTNERS.getAsList());
        System.assertNotEquals(null,result.TEXTS.getAsList());
        System.assertNotEquals(null,result.ORDERDATA);
        System.assertNotEquals(null,result.STATUS);
        System.assertNotEquals(null,result.ADDITIONAL_DATA_A);
        System.assertNotEquals(null,result.ITEMS.getAsList());
        System.assertNotEquals(null,result.ITEMS_TEXT.getAsList());
        System.assertNotEquals(null,result.MATERIAL_UOM.getAsList());
        System.assertNotEquals(null,result.ITEMS_ACTION.getAsList());
        System.assertNotEquals(null,result.ORDER_ACTION);
        System.assertNotEquals(null,result.ITEMS_CONFIG.getAsList());
        System.assertNotEquals(null,result.INCOMPLETION_LOG.getAsList());
    }

    @isTest
    static void testSALES()
    {
        SBO_EnosixContract_Detail.SALES childObj = new SBO_EnosixContract_Detail.SALES();
        System.assertEquals(SBO_EnosixContract_Detail.SALES.class,childObj.getType(),'getType() does not match object type.');

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

        childObj.CheckPartnerAuthorizations = 'X';
        System.assertEquals('X', childObj.CheckPartnerAuthorizations);

        childObj.CheckPartnerAuthorizationDescription = 'X';
        System.assertEquals('X', childObj.CheckPartnerAuthorizationDescription);

        childObj.MasterContractNumber = 'X';
        System.assertEquals('X', childObj.MasterContractNumber);

        childObj.AgreedDeliveryTime = 'X';
        System.assertEquals('X', childObj.AgreedDeliveryTime);

        childObj.AgreedDeliveryTimeDescription = 'X';
        System.assertEquals('X', childObj.AgreedDeliveryTimeDescription);

        childObj.DocumentCurrency = 'X';
        System.assertEquals('X', childObj.DocumentCurrency);

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

        childObj.TermsOfPaymentKey = 'X';
        System.assertEquals('X', childObj.TermsOfPaymentKey);

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
    static void testCONTRACT()
    {
        SBO_EnosixContract_Detail.CONTRACT childObj = new SBO_EnosixContract_Detail.CONTRACT();
        System.assertEquals(SBO_EnosixContract_Detail.CONTRACT.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.ItemNumber = 'X';
        System.assertEquals('X', childObj.ItemNumber);

        childObj.ContractStartDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.ContractStartDate);

        childObj.RuleForContractStartDate = 'X';
        System.assertEquals('X', childObj.RuleForContractStartDate);

        childObj.RuleForContractStartDateDescription = 'X';
        System.assertEquals('X', childObj.RuleForContractStartDateDescription);

        childObj.ContractEndDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.ContractEndDate);

        childObj.RuleForContractEndDate = 'X';
        System.assertEquals('X', childObj.RuleForContractEndDate);

        childObj.RuleForContractEndDateDescription = 'X';
        System.assertEquals('X', childObj.RuleForContractEndDateDescription);

        childObj.ValidityPeriodCategory = 'X';
        System.assertEquals('X', childObj.ValidityPeriodCategory);

        childObj.ValidityPeriodCategoryDescription = 'X';
        System.assertEquals('X', childObj.ValidityPeriodCategoryDescription);

        childObj.ValidityPeriodOfContract = 'X';
        System.assertEquals('X', childObj.ValidityPeriodOfContract);

        childObj.UnitOfValidityPeriod = 'X';
        System.assertEquals('X', childObj.UnitOfValidityPeriod);

        childObj.UnitOfValidityPeriodDescription = 'X';
        System.assertEquals('X', childObj.UnitOfValidityPeriodDescription);

        childObj.InstallationDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.InstallationDate);

        childObj.AgreementAcceptanceDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.AgreementAcceptanceDate);

        childObj.ContractSignedDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.ContractSignedDate);

        childObj.DismantlingDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.DismantlingDate);

        childObj.ActionAtEndOfContract = 'X';
        System.assertEquals('X', childObj.ActionAtEndOfContract);

        childObj.ActionAtEndOfContractDescription = 'X';
        System.assertEquals('X', childObj.ActionAtEndOfContractDescription);

        childObj.DateForAction = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.DateForAction);

        childObj.DateRuleForAction = 'X';
        System.assertEquals('X', childObj.DateRuleForAction);

        childObj.DateRuleForActionDescription = 'X';
        System.assertEquals('X', childObj.DateRuleForActionDescription);

        childObj.AssignmentCancellationProcedure = 'X';
        System.assertEquals('X', childObj.AssignmentCancellationProcedure);

        childObj.AssignmentCancellationProcedureDescription = 'X';
        System.assertEquals('X', childObj.AssignmentCancellationProcedureDescription);

        childObj.ReasonForCancellation = 'X';
        System.assertEquals('X', childObj.ReasonForCancellation);

        childObj.ReasonForCancellationDescription = 'X';
        System.assertEquals('X', childObj.ReasonForCancellationDescription);

        childObj.CancellationRequestReceivedDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.CancellationRequestReceivedDate);

        childObj.CancellationParty = 'X';
        System.assertEquals('X', childObj.CancellationParty);

        childObj.CancellationPartyDescription = 'X';
        System.assertEquals('X', childObj.CancellationPartyDescription);

        childObj.RequestedCancellationDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.RequestedCancellationDate);

        childObj.CancellationDocumentFromContractPartnerDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.CancellationDocumentFromContractPartnerDate);

        childObj.CancellationDocumentNumberOfContractPartner = 'X';
        System.assertEquals('X', childObj.CancellationDocumentNumberOfContractPartner);

        List<string> keyFields = new List<string>{ 'VPOSN' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testBILL_PLAN()
    {
        SBO_EnosixContract_Detail.BILL_PLAN childObj = new SBO_EnosixContract_Detail.BILL_PLAN();
        System.assertEquals(SBO_EnosixContract_Detail.BILL_PLAN.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.ItemNumber = 'X';
        System.assertEquals('X', childObj.ItemNumber);

        childObj.BillingPlanNumber = 'X';
        System.assertEquals('X', childObj.BillingPlanNumber);

        childObj.BillingPlanCategory = 'X';
        System.assertEquals('X', childObj.BillingPlanCategory);

        childObj.BillingPlanType = 'X';
        System.assertEquals('X', childObj.BillingPlanType);

        childObj.BillingPlanTypeDescription = 'X';
        System.assertEquals('X', childObj.BillingPlanTypeDescription);

        childObj.BillingPlanStartDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.BillingPlanStartDate);

        childObj.BillingPlanEndDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.BillingPlanEndDate);

        childObj.WBSElement = 'X';
        System.assertEquals('X', childObj.WBSElement);

        childObj.RuleForNextBillingDateOrigin = 'X';
        System.assertEquals('X', childObj.RuleForNextBillingDateOrigin);

        childObj.RuleForNextBillingDateOriginDescription = 'X';
        System.assertEquals('X', childObj.RuleForNextBillingDateOriginDescription);

        List<string> keyFields = new List<string>{ 'POSNR','FPLNR' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testBILLING_PLAN_DATES()
    {
        SBO_EnosixContract_Detail.BILLING_PLAN_DATES childObj = new SBO_EnosixContract_Detail.BILLING_PLAN_DATES();
        System.assertEquals(SBO_EnosixContract_Detail.BILLING_PLAN_DATES.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.BillingPlanNumber = 'X';
        System.assertEquals('X', childObj.BillingPlanNumber);

        childObj.ItemNumber = 'X';
        System.assertEquals('X', childObj.ItemNumber);

        childObj.ItemForBillingPlan = 'X';
        System.assertEquals('X', childObj.ItemForBillingPlan);

        childObj.DeadlineSettlementDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.DeadlineSettlementDate);

        childObj.DateDescription = 'X';
        System.assertEquals('X', childObj.DateDescription);

        childObj.Usage = 'X';
        System.assertEquals('X', childObj.Usage);

        childObj.PercentageOfValueToBeInvoiced = 1.5;
        System.assertEquals(1.5, childObj.PercentageOfValueToBeInvoiced);

        childObj.ValueToBeBilled = 1.5;
        System.assertEquals(1.5, childObj.ValueToBeBilled);

        childObj.CurrencyKeyOfCreditControlArea = 'X';
        System.assertEquals('X', childObj.CurrencyKeyOfCreditControlArea);

        childObj.BillingBlockForBillingPlan = 'X';
        System.assertEquals('X', childObj.BillingBlockForBillingPlan);

        childObj.RuleInBillingPlan = 'X';
        System.assertEquals('X', childObj.RuleInBillingPlan);

        childObj.BillingStatusForBillingPlan = 'X';
        System.assertEquals('X', childObj.BillingStatusForBillingPlan);

        childObj.TermsOfPaymentKey = 'X';
        System.assertEquals('X', childObj.TermsOfPaymentKey);

        childObj.DateCategory = 'X';
        System.assertEquals('X', childObj.DateCategory);

        childObj.ProposedBillingType = 'X';
        System.assertEquals('X', childObj.ProposedBillingType);

        childObj.ExchangeRateForFIPostings = 1.5;
        System.assertEquals(1.5, childObj.ExchangeRateForFIPostings);

        childObj.MilestoneNumber = 'X';
        System.assertEquals('X', childObj.MilestoneNumber);

        childObj.IDForAdoptingBilling = 'X';
        System.assertEquals('X', childObj.IDForAdoptingBilling);

        List<string> keyFields = new List<string>{ 'FPLNR','POSNR','FPLTR' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testSHIPPING()
    {
        SBO_EnosixContract_Detail.SHIPPING childObj = new SBO_EnosixContract_Detail.SHIPPING();
        System.assertEquals(SBO_EnosixContract_Detail.SHIPPING.class,childObj.getType(),'getType() does not match object type.');

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
        SBO_EnosixContract_Detail.BILLING childObj = new SBO_EnosixContract_Detail.BILLING();
        System.assertEquals(SBO_EnosixContract_Detail.BILLING.class,childObj.getType(),'getType() does not match object type.');

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

        childObj.TermsOfPaymentKey = 'X';
        System.assertEquals('X', childObj.TermsOfPaymentKey);

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

        childObj.DeadlineSettlementDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.DeadlineSettlementDate);

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
        SBO_EnosixContract_Detail.ACCOUNTING childObj = new SBO_EnosixContract_Detail.ACCOUNTING();
        System.assertEquals(SBO_EnosixContract_Detail.ACCOUNTING.class,childObj.getType(),'getType() does not match object type.');

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

        childObj.ExchangeRateForFIPostings = 1.5;
        System.assertEquals(1.5, childObj.ExchangeRateForFIPostings);

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
        SBO_EnosixContract_Detail.CONDITIONS childObj = new SBO_EnosixContract_Detail.CONDITIONS();
        System.assertEquals(SBO_EnosixContract_Detail.CONDITIONS.class,childObj.getType(),'getType() does not match object type.');

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

        childObj.ConditionValue = 1.5;
        System.assertEquals(1.5, childObj.ConditionValue);

        childObj.CurrencyKeyOfCreditControlArea = 'X';
        System.assertEquals('X', childObj.CurrencyKeyOfCreditControlArea);

        childObj.CondValueforCumulationFields = 1.5;
        System.assertEquals(1.5, childObj.CondValueforCumulationFields);

        childObj.CondCurrencyforCumulationFlds = 'X';
        System.assertEquals('X', childObj.CondCurrencyforCumulationFlds);

        childObj.ConditionStatistics = true;
        System.assertEquals(true, childObj.ConditionStatistics);

        childObj.CalculationType = 'X';
        System.assertEquals('X', childObj.CalculationType);

        childObj.ManualEntries = 'X';
        System.assertEquals('X', childObj.ManualEntries);

        childObj.CondtionControl = 'X';
        System.assertEquals('X', childObj.CondtionControl);

        childObj.OriginOfCondition = 'X';
        System.assertEquals('X', childObj.OriginOfCondition);

        List<string> keyFields = new List<string>{ 'KPOSN','STUNR','ZAEHK','KSCHL' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testACCOUNT_ASSIGNMENT()
    {
        SBO_EnosixContract_Detail.ACCOUNT_ASSIGNMENT childObj = new SBO_EnosixContract_Detail.ACCOUNT_ASSIGNMENT();
        System.assertEquals(SBO_EnosixContract_Detail.ACCOUNT_ASSIGNMENT.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.BusinessArea = 'X';
        System.assertEquals('X', childObj.BusinessArea);

        childObj.WBSElementInternal = 'X';
        System.assertEquals('X', childObj.WBSElementInternal);

        childObj.WBSElement = 'X';
        System.assertEquals('X', childObj.WBSElement);

        childObj.WBSElementDescription = 'X';
        System.assertEquals('X', childObj.WBSElementDescription);

        List<string> keyFields = new List<string>{ 'EnosixObjKey' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testPARTNERS()
    {
        SBO_EnosixContract_Detail.PARTNERS childObj = new SBO_EnosixContract_Detail.PARTNERS();
        System.assertEquals(SBO_EnosixContract_Detail.PARTNERS.class,childObj.getType(),'getType() does not match object type.');

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
    static void testTEXTS()
    {
        SBO_EnosixContract_Detail.TEXTS childObj = new SBO_EnosixContract_Detail.TEXTS();
        System.assertEquals(SBO_EnosixContract_Detail.TEXTS.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.TextID = 'X';
        System.assertEquals('X', childObj.TextID);

        childObj.TextLanguage = 'X';
        System.assertEquals('X', childObj.TextLanguage);

        childObj.TextIDDescription = 'X';
        System.assertEquals('X', childObj.TextIDDescription);

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
        SBO_EnosixContract_Detail.ORDERDATA childObj = new SBO_EnosixContract_Detail.ORDERDATA();
        System.assertEquals(SBO_EnosixContract_Detail.ORDERDATA.class,childObj.getType(),'getType() does not match object type.');

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
        SBO_EnosixContract_Detail.STATUS childObj = new SBO_EnosixContract_Detail.STATUS();
        System.assertEquals(SBO_EnosixContract_Detail.STATUS.class,childObj.getType(),'getType() does not match object type.');

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
        SBO_EnosixContract_Detail.ADDITIONAL_DATA_A childObj = new SBO_EnosixContract_Detail.ADDITIONAL_DATA_A();
        System.assertEquals(SBO_EnosixContract_Detail.ADDITIONAL_DATA_A.class,childObj.getType(),'getType() does not match object type.');

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
        SBO_EnosixContract_Detail.ITEMS childObj = new SBO_EnosixContract_Detail.ITEMS();
        System.assertEquals(SBO_EnosixContract_Detail.ITEMS.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.ItemNumber = 'X';
        System.assertEquals('X', childObj.ItemNumber);

        childObj.Material = 'X';
        System.assertEquals('X', childObj.Material);

        childObj.TargetQuantity = 1.5;
        System.assertEquals(1.5, childObj.TargetQuantity);

        childObj.SalesUnit = 'X';
        System.assertEquals('X', childObj.SalesUnit);

        childObj.SalesUnitDescription = 'X';
        System.assertEquals('X', childObj.SalesUnitDescription);

        childObj.HigherLevelItemNumber = 'X';
        System.assertEquals('X', childObj.HigherLevelItemNumber);

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

        childObj.NetValue = 1.5;
        System.assertEquals(1.5, childObj.NetValue);

        childObj.DocumentCurrency = 'X';
        System.assertEquals('X', childObj.DocumentCurrency);

        childObj.ConditionScaleQuantity = 1.5;
        System.assertEquals(1.5, childObj.ConditionScaleQuantity);

        childObj.ReasonForRejection = 'X';
        System.assertEquals('X', childObj.ReasonForRejection);

        childObj.CustomerPurchaseOrderNumber = 'X';
        System.assertEquals('X', childObj.CustomerPurchaseOrderNumber);

        childObj.CustomerPurchaseOrderItemNumber = 'X';
        System.assertEquals('X', childObj.CustomerPurchaseOrderItemNumber);

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

        childObj.TermsOfPaymentKey = 'X';
        System.assertEquals('X', childObj.TermsOfPaymentKey);

        childObj.TermsofPaymentKeyDescription = 'X';
        System.assertEquals('X', childObj.TermsofPaymentKeyDescription);

        childObj.BillingBlockForBillingPlan = 'X';
        System.assertEquals('X', childObj.BillingBlockForBillingPlan);

        childObj.BillingBlockDescription = 'X';
        System.assertEquals('X', childObj.BillingBlockDescription);

        childObj.BillingRelevant = 'X';
        System.assertEquals('X', childObj.BillingRelevant);

        childObj.BillingRelevantDescription = 'X';
        System.assertEquals('X', childObj.BillingRelevantDescription);

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

        childObj.DeadlineSettlementDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.DeadlineSettlementDate);

        childObj.DateOnWhichServicesRendered = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.DateOnWhichServicesRendered);

        childObj.AccountAssignmentGroup = 'X';
        System.assertEquals('X', childObj.AccountAssignmentGroup);

        childObj.AccountAssignmentGroupDescription = 'X';
        System.assertEquals('X', childObj.AccountAssignmentGroupDescription);

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

        childObj.ItemAlternative = 'X';
        System.assertEquals('X', childObj.ItemAlternative);

        childObj.BillOfMaterial = 'X';
        System.assertEquals('X', childObj.BillOfMaterial);

        List<string> keyFields = new List<string>{ 'POSNR' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testITEMS_TEXT()
    {
        SBO_EnosixContract_Detail.ITEMS_TEXT childObj = new SBO_EnosixContract_Detail.ITEMS_TEXT();
        System.assertEquals(SBO_EnosixContract_Detail.ITEMS_TEXT.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.ItemNumber = 'X';
        System.assertEquals('X', childObj.ItemNumber);

        childObj.TextID = 'X';
        System.assertEquals('X', childObj.TextID);

        childObj.TextLanguage = 'X';
        System.assertEquals('X', childObj.TextLanguage);

        childObj.TextIDDescription = 'X';
        System.assertEquals('X', childObj.TextIDDescription);

        childObj.Text = 'X';
        System.assertEquals('X', childObj.Text);

        List<string> keyFields = new List<string>{ 'POSNR','TDID','TDSPRAS' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testMATERIAL_UOM()
    {
        SBO_EnosixContract_Detail.MATERIAL_UOM childObj = new SBO_EnosixContract_Detail.MATERIAL_UOM();
        System.assertEquals(SBO_EnosixContract_Detail.MATERIAL_UOM.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.Material = 'X';
        System.assertEquals('X', childObj.Material);

        childObj.AlternateUnitOfMeasure = 'X';
        System.assertEquals('X', childObj.AlternateUnitOfMeasure);

        List<string> keyFields = new List<string>{ 'MATNR','MEINH' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testITEMS_ACTION()
    {
        SBO_EnosixContract_Detail.ITEMS_ACTION childObj = new SBO_EnosixContract_Detail.ITEMS_ACTION();
        System.assertEquals(SBO_EnosixContract_Detail.ITEMS_ACTION.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.ItemNumber = 'X';
        System.assertEquals('X', childObj.ItemNumber);

        childObj.ItemChanged = true;
        System.assertEquals(true, childObj.ItemChanged);

        childObj.ItemDeleted = true;
        System.assertEquals(true, childObj.ItemDeleted);

        childObj.ItemAdded = true;
        System.assertEquals(true, childObj.ItemAdded);

        childObj.PriceOverride = true;
        System.assertEquals(true, childObj.PriceOverride);

        List<string> keyFields = new List<string>{ 'POSNR' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testORDER_ACTION()
    {
        SBO_EnosixContract_Detail.ORDER_ACTION childObj = new SBO_EnosixContract_Detail.ORDER_ACTION();
        System.assertEquals(SBO_EnosixContract_Detail.ORDER_ACTION.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.ReferenceFlag = true;
        System.assertEquals(true, childObj.ReferenceFlag);

        childObj.ReferenceDocumentType = 'X';
        System.assertEquals('X', childObj.ReferenceDocumentType);

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
    static void testITEMS_CONFIG()
    {
        SBO_EnosixContract_Detail.ITEMS_CONFIG childObj = new SBO_EnosixContract_Detail.ITEMS_CONFIG();
        System.assertEquals(SBO_EnosixContract_Detail.ITEMS_CONFIG.class,childObj.getType(),'getType() does not match object type.');

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
    @isTest
    static void testINCOMPLETION_LOG()
    {
        SBO_EnosixContract_Detail.INCOMPLETION_LOG childObj = new SBO_EnosixContract_Detail.INCOMPLETION_LOG();
        System.assertEquals(SBO_EnosixContract_Detail.INCOMPLETION_LOG.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.Client = 'X';
        System.assertEquals('X', childObj.Client);

        childObj.SalesDocument = 'X';
        System.assertEquals('X', childObj.SalesDocument);

        childObj.ItemNumber = 'X';
        System.assertEquals('X', childObj.ItemNumber);

        childObj.ScheduleLineNumber = 'X';
        System.assertEquals('X', childObj.ScheduleLineNumber);

        childObj.PartnerFunction = 'X';
        System.assertEquals('X', childObj.PartnerFunction);

        childObj.TextID = 'X';
        System.assertEquals('X', childObj.TextID);

        childObj.TableName = 'X';
        System.assertEquals('X', childObj.TableName);

        childObj.FieldName = 'X';
        System.assertEquals('X', childObj.FieldName);

        childObj.IncompletionProcedure = 'X';
        System.assertEquals('X', childObj.IncompletionProcedure);

        childObj.StatusGroup = 'X';
        System.assertEquals('X', childObj.StatusGroup);

        childObj.Description = 'X';
        System.assertEquals('X', childObj.Description);

        List<string> keyFields = new List<string>{ 'MANDT','VBELN','POSNR','ETENR','PARVW','TDID','TBNAM','FDNAM','FEHGR','STATG','FDTXT' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
}
