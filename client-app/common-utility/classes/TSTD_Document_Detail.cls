@isTest
public class TSTD_Document_Detail
{
    @isTest
    public static void test_properties()
    {
        DS_Document_Detail salesDocDetail = buildSalesDocDetail();
    }

    @isTest
    public static void test_cloneHeader()
    {
        DS_Document_Detail salesDocDetail = new DS_Document_Detail();
        DS_Document_Detail clonedDetail = salesDocDetail.cloneHeader();
    }

    public static DS_Document_Detail buildSalesDocDetail()
    {
        DS_Document_Detail salesDocDetail = new DS_Document_Detail();
        salesDocDetail.SalesDocument = '1111';
        salesDocDetail.SoldToParty = '1111';
        salesDocDetail.SoldToPartyText = 'SoldTo';
        salesDocDetail.SalesDocumentCurrency = 'USD';
        salesDocDetail.CustomerPurchaseOrderNumber = 'Test';
        salesDocDetail.CustomerPurchaseOrderDate = Date.today();
        salesDocDetail.NetOrderValue = 20;
        salesDocDetail.TaxAmount = 5;
        salesDocDetail.ReferenceDocument = 'TEST';
        salesDocDetail.ReferenceDocumentCategory = 'Cat';
        salesDocDetail.PricingType = 'Pricing';
        salesDocDetail.ShippingConditions = '01';
        salesDocDetail.CustomerLanguage = 'EN';
        salesDocDetail.removedItems = new List<String>{'000010'};
        salesDocDetail.IncompletionLogs = new List<DS_Document_Detail.INCOMPLETION_LOG>();
        salesDocDetail.StartDate = Date.today();
        salesDocDetail.EndDate = Date.today();
        salesDocDetail.callSimulateBeforeUpdate = true;
        salesDocDetail.IsSuccess = true;
        salesDocDetail.NeedToSimulate = true;

        salesDocDetail.SALES.SalesDocumentType = '01';
        salesDocDetail.SALES.SalesDocumentTypeDescription = '01';
        salesDocDetail.SALES.SalesOrganization = '01';
        salesDocDetail.SALES.SalesOrganizationName = '01';
        salesDocDetail.SALES.DistributionChannel = '01';
        salesDocDetail.SALES.DistributionChannelName = '01';
        salesDocDetail.SALES.Division = '01';
        salesDocDetail.SALES.DivisionName = '01';
        salesDocDetail.SALES.SalesGroup = '01';
        salesDocDetail.SALES.SalesGroupName = '01';
        salesDocDetail.SALES.SalesOffice = '01';
        salesDocDetail.SALES.SalesOfficeName = '01';
        salesDocDetail.SALES.CreateDate = Date.today();
        salesDocDetail.SALES.EntryTime = Time.newInstance(18, 30, 2, 20);
        salesDocDetail.SALES.CreatedBy = '01';
        salesDocDetail.SALES.ValidFrom = Date.today();
        salesDocDetail.SALES.ValidTo = Date.today();
        salesDocDetail.SALES.SalesDocumentVersionNumber = '01';
        salesDocDetail.SALES.WarrantyDate = Date.today();
        salesDocDetail.SALES.OrderReason = '01';
        salesDocDetail.SALES.OrderReasonDescription = '01';
        salesDocDetail.SALES.AgreedDeliveryTime = '01';
        salesDocDetail.SALES.AgreedDeliveryTimeDescription = '01';
        salesDocDetail.SALES.SalesDocumentCurrency = '01';
        salesDocDetail.SALES.ExchangeRatePriceDetermination = 1;
        salesDocDetail.SALES.DateforPricingExchangeRate = Date.today();
        salesDocDetail.SALES.PricingProcedureInPricing = '01';
        salesDocDetail.SALES.PricingProcedureInPricingDesc = '01';
        salesDocDetail.SALES.CustomerGroup = '01';
        salesDocDetail.SALES.CustomerGroupName = '01';
        salesDocDetail.SALES.PriceListType = '01';
        salesDocDetail.SALES.PriceListTypeText = '01';
        salesDocDetail.SALES.UsageIndicator = '01';
        salesDocDetail.SALES.UsageIndicatorDescription = '01';
        salesDocDetail.SALES.PriceGroup = '01';
        salesDocDetail.SALES.PriceGroupDescription = '01';
        salesDocDetail.SALES.SalesDistrict = '01';
        salesDocDetail.SALES.SalesDistrictName = '01';
        salesDocDetail.SALES.RequestedDeliveryDate = Date.today();
        salesDocDetail.SALES.DeliveryBlock = '01';
        salesDocDetail.SALES.DeliveryBlockDescription = '01';
        salesDocDetail.SALES.BillingBlock = '01';
        salesDocDetail.SALES.BillingBlockDescription = '01';
        salesDocDetail.SALES.TermsofPaymentKey = '01';
        salesDocDetail.SALES.TermsofPaymentKeyDescription = '01';
        salesDocDetail.SALES.IncotermsPart1 = '01';
        salesDocDetail.SALES.IncotermsPart1Description = '01';
        salesDocDetail.SALES.IncotermsPart2 = '01';

        DS_Document_Detail.PARTNERS newPartner1 = new DS_Document_Detail.PARTNERS();
        newPartner1.PartnerFunction = 'SH';
        newPartner1.CustomerNumber = '111';
        newPartner1.PartnerName = 'TEST';
        newPartner1.PartnerName2 = 'TEST';
        newPartner1.HouseNumber = 'TEST';
        newPartner1.Street = 'TEST';
        newPartner1.City = 'TEST';
        newPartner1.PostalCode = 'TEST';
        newPartner1.Region = 'TEST';
        newPartner1.Country = 'TEST';
        newPartner1.isChanged = true;
        DS_Document_Detail.PARTNERS newPartner2 = new DS_Document_Detail.PARTNERS();
        newPartner2.PartnerFunction = 'VE';
        newPartner2.Vendor = '111';
        newPartner2.PartnerName = 'TEST';
        DS_Document_Detail.PARTNERS newPartner3 = new DS_Document_Detail.PARTNERS();
        newPartner3.PartnerFunction = 'PE';
        newpartner3.PersonnelNumber = '111';
        newPartner3.PartnerName = 'TEST';
        DS_Document_Detail.PARTNERS newPartner4 = new DS_Document_Detail.PARTNERS();
        newPartner4.PartnerFunction = 'ZQ';
        newPartner4.ContactPersonNumber = '111';
        newPartner4.PartnerName = 'TEST';
        newPartner4.PartnerName2 = 'TEST';
        salesDocDetail.PARTNERS = new List<DS_Document_Detail.PARTNERS>{
            newPartner1, newPartner2, newPartner3, newPartner4};
        DS_Document_Detail.PARTNERS itemPartner = new DS_Document_Detail.PARTNERS();
        itemPartner.PartnerFunctionName = 'Ship';
        itemPartner.ComponentType = 'Test';
        itemPartner.SearchType = 'Test';
        itemPartner.autoSearch = true;
        itemPartner.allowSearch = true;
        itemPartner.allowAddressOverride = true;
        itemPartner.PartnerFunction = 'SH';
        itemPartner.CustomerNumber = '111';
        itemPartner.PartnerName = 'TEST';
        itemPartner.PartnerName2 = 'TEST';

        DS_Document_Detail.CONDITIONS condition = new DS_Document_Detail.CONDITIONS();
        condition.ConditionType = 'Z';
        condition.Rate = 2;
        condition.CalculationType = 'C';
        condition.OriginOfCondition = 'C';
        salesDocDetail.CONDITIONS = new List<DS_Document_Detail.CONDITIONS>{condition};

        DS_Document_Detail.CONDITIONS sboCondition = new DS_Document_Detail.CONDITIONS();
        sboCondition.ConditionCounter = '1';
        sboCondition.ConditionType = 'Z';
        sboCondition.Rate = 2;
        sboCondition.RateUnit = 'EUR';
        sboCondition.ConditionValue = 10;
        sboCondition.CalculationType = 'C';
        sboCondition.ConditionUnit = '1';
        sboCondition.CurrencyKey = 'USD';
        sboCondition.OriginOfCondition = 'C';
        salesDocDetail.SBOHeaderConditions = new List<DS_Document_Detail.CONDITIONS>{sboCondition};

        DS_Document_Detail.TEXTS text = new DS_Document_Detail.TEXTS();
        text.TextID = '0001';
        text.TextIDDescription = 'DESC';
        text.Text = 'TEST';
        text.TextLanguage = 'EN';
        salesDocDetail.TEXTS = new List<DS_Document_Detail.TEXTS>{text};

        DS_Document_Detail.BILLING_PLAN billingPlan = new DS_Document_Detail.BILLING_PLAN();
        billingPlan.BillingPlanType = 'TEST';
        billingPlan.BillingPlanStartDate = Date.today();
        billingPlan.BillingPlanEndDate = Date.today();
        billingPlan.RuleForNextBillingDateOrigin = 'TEST';

        DS_Document_Detail.BILLING_PLAN_DATES billPlanDate = new DS_Document_Detail.BILLING_PLAN_DATES();
        billPlanDate.DeadlineSettlementDate = Date.today();
        billPlanDate.Usage = 'TEST';
        billPlanDate.PercentageOfValueToBeInvoiced = 1;
        billPlanDate.ValueToBeBilled = 1;
        billPlanDate.BillingBlockForBillingPlan = 'TEST';
        billPlanDate.RuleInBillingPlan = 'TEST';
        billPlanDate.BillingStatusForBillingPlan = 'TEST';
        billPlanDate.DateCategory = 'TEST';
        billPlanDate.ProposedBillingType = 'TEST';

        DS_Document_Detail.SCHEDULE schedule = new DS_Document_Detail.SCHEDULE();
        schedule.ScheduleLineNumber = 'TEST';
        schedule.ScheduleLineDate = Date.today();
        schedule.OrderQuantity = 1;
        schedule.RoundedQuantity = 1;
        schedule.ConfirmedQuantity = 1;
        schedule.SalesUnit = 'TEST';
        schedule.DeliveryBlock = 'TEST';
        schedule.DeliveryBlockDescription = 'TEST';
        schedule.DeliveredQuantity = 1;
        schedule.ScheduleLineCategory = 'TEST';
        schedule.ScheduleLineCategoryDescription = 'TEST';
        schedule.PurchaseRequisitionNumber = 'TEST';
        schedule.PurchaseRequisitionItemNumber = 'TEST';

        salesDocDetail.ITEMS = new List<DS_Document_Detail.ITEMS>();
        DS_Document_Detail.ITEMS item1 = new DS_Document_Detail.ITEMS();
        item1.isAdded = true;
        item1.SFId = 'SFId';
        item1.ItemNumber = '000010';
        item1.HigherLevelItemNumber = '000000';
        item1.Material = 'Material1';
        item1.ItemDescription = 'Material';
        item1.OrderQuantity = 1;
        item1.Plant = '01';
        item1.SalesUnit = 'LB';
        item1.ItemCategory = 'CAT';
        item1.BillingBlockStatus = 'BillingBlockStatus';
        item1.DeliveryBlockStatus = 'DeliveryBlockStatus';
        item1.NetOrderValue = 10;
        item1.NetWeight = 1;
        item1.WeightUnit = 'LB';
        item1.GrossWeight = 1;
        item1.SalesDocumentCurrency = 'USD';
        item1.AlternativeItem = '000000';
        item1.NetItemPrice = 10;
        item1.ConditionPricingUnit = 1;
        item1.BaseUnitOfMeasure = 'LB';
        item1.PriceListType = '01';
        item1.RejectionReason = '01';
        item1.isNeedConfigure = true;
        item1.isConfigurationFromVCComplete = true;
        item1.ScheduleLineDate = Date.today();
        item1.ReferenceItemNumber = '000010';
        item1.ReferenceDocument = 'OR';
        item1.ReferenceDocumentCategory = 'C';
        item1.ItemTexts = new List<DS_Document_Detail.TEXTS>{text};
        item1.ItemConfigurations = new List<DS_Document_Detail.CONFIG>();
        item1.PARTNERS = new List<DS_Document_Detail.PARTNERS>{itemPartner};
        item1.BillingPlan = billingPlan;
        item1.BillingPlanDates = new List<DS_Document_Detail.BILLING_PLAN_DATES>{billPlanDate};
        item1.ItemSchedules = new List<DS_Document_Detail.SCHEDULE>{schedule};

        DS_Document_Detail.CONDITIONS item1Condition1 = new DS_Document_Detail.CONDITIONS();
        item1Condition1.ConditionType = 'ZZZ';
        item1Condition1.ConditionTypeName = 'TEST';
        item1Condition1.Rate = 1;
        item1Condition1.ConditionPricingUnit = 1;
        item1Condition1.OriginOfCondition = 'C';
        item1.ItemConditions = new List<DS_Document_Detail.CONDITIONS>{item1Condition1};

        DS_Document_Detail.INCOMPLETION_LOG incompletionLog = new DS_Document_Detail.INCOMPLETION_LOG();
        incompletionLog.TextID = 'TEST';
        incompletionLog.Text = 'TEST';

        DS_Document_Detail.ITEMS item2 = new DS_Document_Detail.ITEMS();
        item2.isChanged = true;
        item2.ItemNumber = '000020';
        item2.Material = 'Material1';
        item2.OrderQuantity = 1;
        item2.SalesDocumentCurrency = 'USD';
        item2.AlternativeItem = '000000';
        item2.NetItemPrice = 10;
        item2.ConditionPricingUnit = 1;
        item2.BaseUnitOfMeasure = 'LB';
        item2.ConfigurableMaterial = true;
        item2.PriceListType = '01';
        item2.ScheduleLineDate = Date.today();
        item2.ItemTexts = new List<DS_Document_Detail.TEXTS>{text};
        item2.ItemConditions = new List<DS_Document_Detail.CONDITIONS>{item1Condition1};
        item2.PARTNERS = new List<DS_Document_Detail.PARTNERS>{itemPartner};
        item2.ItemIncompletionLogs = new List<DS_Document_Detail.INCOMPLETION_LOG>{incompletionLog};
        item2.BillingPlan = billingPlan;
        item2.BillingPlanDates = new List<DS_Document_Detail.BILLING_PLAN_DATES>{billPlanDate};

        item2.ItemConfigurations = new List<DS_Document_Detail.CONFIG>();
        DS_Document_Detail.CONFIG config = new DS_Document_Detail.CONFIG();
        config.CharacteristicID = 'TEST';
        config.CharacteristicName = 'TEST';
        config.CharacteristicValue = 'TEST';
        config.CharacteristicValueDescription = 'DESC';
        config.UserModified = true;
        item2.ItemConfigurations.add(config);

        DS_Document_Detail.CONDITIONS itemCondition = new DS_Document_Detail.CONDITIONS();
        itemCondition.ConditionType = 'ZZZ';
        itemCondition.RateUnit = 'EUR';
        itemCondition.Rate = 10;
        itemCondition.ConditionValue = 30;
        itemCondition.ConditionPricingUnit = 5;
        itemCondition.OriginOfCondition = 'C';

        item2.SBOItemConditions = new List<DS_Document_Detail.CONDITIONS>();
        item2.SBOItemConditions.add(itemCondition);

        DS_Document_Detail.ITEMS item3 = new DS_Document_Detail.ITEMS();
        item3.isAdded = true;
        item3.ItemNumber = '000030';
        item3.HigherLevelItemNumber = '000000';
        item3.Material = 'Material1';
        item3.ItemDescription = 'Material';
        item3.OrderQuantity = 1;
        item3.Plant = '01';
        item3.SalesUnit = 'LB';
        item3.ItemCategory = 'CAT';
        item3.NetOrderValue = 10;
        item3.NetWeight = 1;
        item3.WeightUnit = 'LB';
        item3.GrossWeight = 1;
        item3.SalesDocumentCurrency = 'USD';
        item3.AlternativeItem = '000000';
        item3.NetItemPrice = 10;
        item3.ConditionPricingUnit = 1;
        item3.BaseUnitOfMeasure = 'LB';
        item3.PriceListType = '01';
        item3.RejectionReason = '01';
        item3.isNeedConfigure = true;
        item3.isConfigurationFromVCComplete = true;
        item3.ScheduleLineDate = Date.today();
        item3.ReferenceItemNumber = '000010';
        item3.ReferenceDocument = 'OR';
        item3.ReferenceDocumentCategory = 'C';
        item3.ItemTexts = new List<DS_Document_Detail.TEXTS>{text};
        item3.ItemConfigurations = new List<DS_Document_Detail.CONFIG>();
        item3.PARTNERS = new List<DS_Document_Detail.PARTNERS>{itemPartner};
        item3.BillingPlan = billingPlan;
        item3.BillingPlanDates = new List<DS_Document_Detail.BILLING_PLAN_DATES>{billPlanDate};

        DS_Document_Detail.ITEMS item4 = new DS_Document_Detail.ITEMS();
        item4.isAdded = true;
        item4.ItemNumber = '000040';
        item4.HigherLevelItemNumber = '000000';
        item4.Material = 'Material1';
        item4.ItemDescription = 'Material';
        item4.OrderQuantity = 1;
        item4.Plant = '01';
        item4.SalesUnit = 'LB';
        item4.ItemCategory = 'CAT';
        item4.NetOrderValue = 10;
        item4.NetWeight = 1;
        item4.WeightUnit = 'LB';
        item4.GrossWeight = 1;
        item4.SalesDocumentCurrency = 'USD';
        item4.AlternativeItem = '000030';
        item4.NetItemPrice = 10;
        item4.ConditionPricingUnit = 1;
        item4.BaseUnitOfMeasure = 'LB';
        item4.PriceListType = '01';
        item4.RejectionReason = '01';
        item4.isNeedConfigure = true;
        item4.isConfigurationFromVCComplete = true;
        item4.ScheduleLineDate = Date.today();
        item4.ReferenceItemNumber = '000010';
        item4.ReferenceDocument = 'OR';
        item4.ReferenceDocumentCategory = 'C';
        item4.ItemTexts = new List<DS_Document_Detail.TEXTS>{text};
        item4.ItemConfigurations = new List<DS_Document_Detail.CONFIG>();
        item4.PARTNERS = new List<DS_Document_Detail.PARTNERS>{itemPartner};
        item4.BillingPlan = billingPlan;
        item4.BillingPlanDates = new List<DS_Document_Detail.BILLING_PLAN_DATES>{billPlanDate};

        salesDocDetail.ITEMS.add(item1);
        salesDocDetail.ITEMS.add(item2);
        salesDocDetail.ITEMS.add(item3);
        salesDocDetail.ITEMS.add(item4);

        return salesDocDetail;
    }
}