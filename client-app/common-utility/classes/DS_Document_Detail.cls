public with sharing class DS_Document_Detail 
{
    @AuraEnabled public Boolean NeedToSimulate { get; set; }
    @AuraEnabled public Boolean callSimulateBeforeUpdate { get; set; }

    // HEADER
    @AuraEnabled public String SalesDocument { get; set; }
    @AuraEnabled public String SoldToParty { get; set; }
    @AuraEnabled public String SoldToPartyText { get; set; }
    @AuraEnabled public String CustomerPurchaseOrderNumber { get; set; }
    @AuraEnabled public Date CustomerPurchaseOrderDate { get; set; }
    @AuraEnabled public Decimal NetOrderValue { get; set; }
    @AuraEnabled public Decimal TaxAmount { get; set; }
    @AuraEnabled public String SalesDocumentCurrency { get; set; }
    @AuraEnabled public String ReferenceDocument { get; set; }
    @AuraEnabled public String ReferenceDocumentCategory { get; set; }
    @AuraEnabled public Date StartDate { get; set; }
    @AuraEnabled public Date EndDate { get; set; }

    @AuraEnabled public String ShippingConditions { get; set; }
    @AuraEnabled public String CollectiveNumber { get; set; }
    @AuraEnabled public String PricingType { get; set; }
    @AuraEnabled public String CustomerLanguage { get; set; }
    @AuraEnabled public Boolean IsSuccess { get; set; }

    @AuraEnabled public SALES SALES { get; set; }
    @AuraEnabled public List<PARTNERS> PARTNERS { get; set; }
    @AuraEnabled public List<CONDITIONS> CONDITIONS { get; set; }
    @AuraEnabled public List<TEXTS> TEXTS { get; set; }
    @AuraEnabled public List<ITEMS> ITEMS { get; set; }
    @AuraEnabled public List<CONDITIONS> SBOHeaderConditions { get; set; }
    @AuraEnabled public List<String> removedItems { get; set; }
    @AuraEnabled public List<INCOMPLETION_LOG> IncompletionLogs { get; set; }
    
    public class SALES
    {
        @AuraEnabled public String SalesDocumentType { get; set; }
        @AuraEnabled public String SalesDocumentTypeDescription { get; set; }
        @AuraEnabled public String SalesOrganization { get; set; }
        @AuraEnabled public String SalesOrganizationName { get; set; }
        @AuraEnabled public String DistributionChannel { get; set; }
        @AuraEnabled public String DistributionChannelName { get; set; }
        @AuraEnabled public String Division { get; set; }
        @AuraEnabled public String DivisionName { get; set; }
        @AuraEnabled public String SalesGroup { get; set; }
        @AuraEnabled public String SalesGroupName { get; set; }
        @AuraEnabled public String SalesOffice { get; set; }
        @AuraEnabled public String SalesOfficeName { get; set; }
        @AuraEnabled public Date CreateDate { get; set; }
        @AuraEnabled public Time EntryTime { get; set; }
        @AuraEnabled public String CreatedBy { get; set; }
        @AuraEnabled public Date ValidFrom { get; set; }
        @AuraEnabled public Date ValidTo { get; set; }        
        @AuraEnabled public String SalesDocumentVersionNumber { get; set; }
        @AuraEnabled public Date WarrantyDate { get; set; }
        @AuraEnabled public String OrderReason { get; set; }
        @AuraEnabled public String OrderReasonDescription { get; set; }
        @AuraEnabled public String AgreedDeliveryTime { get; set; }
        @AuraEnabled public String AgreedDeliveryTimeDescription { get; set; }
        @AuraEnabled public String SalesDocumentCurrency { get; set; }
        @AuraEnabled public Decimal ExchangeRatePriceDetermination { get; set; }
        @AuraEnabled public Date DateforPricingExchangeRate { get; set; }
        @AuraEnabled public String PricingProcedureInPricing { get; set; }
        @AuraEnabled public String PricingProcedureInPricingDesc { get; set; }
        @AuraEnabled public String CustomerGroup { get; set; }
        @AuraEnabled public String CustomerGroupName { get; set; }
        @AuraEnabled public String PriceListType { get; set; }
        @AuraEnabled public String PriceListTypeText { get; set; }
        @AuraEnabled public String UsageIndicator { get; set; }
        @AuraEnabled public String UsageIndicatorDescription { get; set; }
        @AuraEnabled public String PriceGroup { get; set; }
        @AuraEnabled public String PriceGroupDescription { get; set; }
        @AuraEnabled public String SalesDistrict { get; set; }
        @AuraEnabled public String SalesDistrictName { get; set; }
        @AuraEnabled public Date RequestedDeliveryDate { get; set; }
        @AuraEnabled public String DeliveryBlock { get; set; }
        @AuraEnabled public String DeliveryBlockDescription { get; set; }
        @AuraEnabled public String BillingBlock { get; set; }
        @AuraEnabled public String BillingBlockDescription { get; set; }
        @AuraEnabled public String TermsofPaymentKey { get; set; }
        @AuraEnabled public String TermsofPaymentKeyDescription { get; set; }
        @AuraEnabled public String IncotermsPart1 { get; set; }
        @AuraEnabled public String IncotermsPart1Description { get; set; }
        @AuraEnabled public String IncotermsPart2 { get; set; }
    }

    public class CONDITIONS
    {
        @AuraEnabled public String ConditionCounter { get; set; }
        @AuraEnabled public String ConditionType { get; set; }
        @AuraEnabled public String ConditionTypeName { get; set; }
        @AuraEnabled public Decimal Rate { get; set; }
        @AuraEnabled public String RateUnit { get; set; }
        @AuraEnabled public Decimal ConditionPricingUnit { get; set; }
        @AuraEnabled public String ConditionUnit { get; set; }
        @AuraEnabled public Decimal ConditionValue { get; set; }
        @AuraEnabled public String CurrencyKey { get; set; }
        @AuraEnabled public String CalculationType { get; set; }
        @AuraEnabled public String OriginOfCondition { get; set; }
    }

    public class PARTNERS
    {
        @AuraEnabled public String PartnerFunction { get; set; }
        @AuraEnabled public String PartnerFunctionName { get; set; }
        @AuraEnabled public String ComponentType { get; set; }
        @AuraEnabled public String SearchType { get; set; }
        @AuraEnabled public Boolean autoSearch { get; set; }
        @AuraEnabled public Boolean allowSearch { get; set; }
        @AuraEnabled public Boolean allowAddressOverride { get; set; }
        @AuraEnabled public String CustomerNumber { get; set; }
        @AuraEnabled public String Vendor { get; set; }
        @AuraEnabled public String PersonnelNumber { get; set; }
        @AuraEnabled public String ContactPersonNumber { get; set; }
        @AuraEnabled public String PartnerName { get; set; }
        @AuraEnabled public String PartnerName2 { get; set; }
        @AuraEnabled public String HouseNumber { get; set; }
        @AuraEnabled public String Street { get; set; }
        @AuraEnabled public String City { get; set; }
        @AuraEnabled public String PostalCode { get; set; }
        @AuraEnabled public String Region { get; set; }
        @AuraEnabled public String Country { get; set; }
        @AuraEnabled public Boolean isChanged { get; set; }
    }

    public class TEXTS
    {
        @AuraEnabled public String TextID { get; set; }
        @AuraEnabled public String TextLanguage { get; set; }
        @AuraEnabled public String TextIDDescription { get; set; }
        @AuraEnabled public String Text { get; set; }
    }

    public class CONFIG
    {
        @AuraEnabled public String CharacteristicID { get; set; }
        @AuraEnabled public String CharacteristicName { get; set; }
        @AuraEnabled public String CharacteristicValue { get; set; }
        @AuraEnabled public String CharacteristicValueDescription { get; set; }
        @AuraEnabled public Boolean UserModified { get; set; }
    }

    // Billing Plan are used in Contract
    public class BILLING_PLAN
    {
        @AuraEnabled public String BillingPlanType { get; set; }
        @AuraEnabled public Date BillingPlanStartDate { get; set; }
        @AuraEnabled public Date BillingPlanEndDate { get; set; }
        @AuraEnabled public String RuleForNextBillingDateOrigin { get; set; }
    }

    // Billing Plan Dates are used in Contract
    public class BILLING_PLAN_DATES
    {
        @AuraEnabled public Date DeadlineSettlementDate { get; set; }
        @AuraEnabled public String Usage { get; set; }
        @AuraEnabled public Decimal PercentageOfValueToBeInvoiced { get; set; }
        @AuraEnabled public Decimal ValueToBeBilled { get; set; }
        @AuraEnabled public String BillingBlockForBillingPlan { get; set; }
        @AuraEnabled public String RuleInBillingPlan { get; set; }
        @AuraEnabled public String BillingStatusForBillingPlan { get; set; }
        @AuraEnabled public String DateCategory { get; set; }
        @AuraEnabled public String ProposedBillingType { get; set; }
    }

    public class SCHEDULE
    {
        @AuraEnabled public String ScheduleLineNumber { get; set; }
        @AuraEnabled public Date ScheduleLineDate { get; set; }
        @AuraEnabled public Decimal OrderQuantity { get; set; }
        @AuraEnabled public Decimal RoundedQuantity { get; set; }
        @AuraEnabled public Decimal ConfirmedQuantity { get; set; }
        @AuraEnabled public String SalesUnit { get; set; }
        @AuraEnabled public String DeliveryBlock { get; set; }
        @AuraEnabled public String DeliveryBlockDescription { get; set; }
        @AuraEnabled public Decimal DeliveredQuantity { get; set; }
        @AuraEnabled public String ScheduleLineCategory { get; set; }
        @AuraEnabled public String ScheduleLineCategoryDescription { get; set; }
        @AuraEnabled public String PurchaseRequisitionNumber { get; set; }
        @AuraEnabled public String PurchaseRequisitionItemNumber { get; set; }
    }

    public class ITEMS
    {
        @AuraEnabled public String SFId { get; set; }
        @AuraEnabled public String ItemNumber { get; set; }
        @AuraEnabled public String HigherLevelItemNumber { get; set; }
        @AuraEnabled public String Material { get; set; }
        @AuraEnabled public Decimal OrderQuantity { get; set; }
        @AuraEnabled public String SalesUnit { get; set; }
        @AuraEnabled public String Plant { get; set; }
        @AuraEnabled public Date ScheduleLineDate { get; set; }
        @AuraEnabled public String ItemDescription { get; set; }
        @AuraEnabled public String ItemCategory { get; set; }
        @AuraEnabled public String BillingBlockStatus { get; set; }
        @AuraEnabled public String DeliveryBlockStatus { get; set; }
        @AuraEnabled public Decimal NetItemPrice { get; set; }
        @AuraEnabled public Decimal ConditionPricingUnit { get; set; }
        @AuraEnabled public Decimal NetOrderValue { get; set; }
        @AuraEnabled public String SalesDocumentCurrency { get; set; }
        @AuraEnabled public Decimal NetWeight { get; set; }
        @AuraEnabled public String WeightUnit { get; set; }
        @AuraEnabled public Decimal GrossWeight { get; set; }
        @AuraEnabled public String BaseUnitOfMeasure { get; set; }
        @AuraEnabled public String AlternativeItem { get; set; }
        @AuraEnabled public String RejectionReason { get; set; }
        @AuraEnabled public Boolean ConfigurableMaterial { get; set; }
        @AuraEnabled public String PriceListType { get; set; }
        @AuraEnabled public String ReferenceItemNumber { get; set; }
        @AuraEnabled public String ReferenceDocument { get; set; }
        @AuraEnabled public String ReferenceDocumentCategory { get; set; }

        @AuraEnabled public Boolean isNeedConfigure { get; set; }
        @AuraEnabled public Boolean isConfigurationFromVCComplete { get; set; }
        @AuraEnabled public Boolean isAdded { get; set; }
        @AuraEnabled public Boolean isChanged { get; set; }

        @AuraEnabled public List<PARTNERS> PARTNERS { get; set; }
        @AuraEnabled public List<CONDITIONS> ItemConditions { get; set; }
        @AuraEnabled public List<TEXTS> ItemTexts { get; set; }
        @AuraEnabled public List<CONFIG> ItemConfigurations { get; set; }
        @AuraEnabled public List<INCOMPLETION_LOG> ItemIncompletionLogs { get; set; }
        @AuraEnabled public List<CONDITIONS> SBOItemConditions { get; set; }
        @AuraEnabled public BILLING_PLAN BillingPlan { get; set; }
        @AuraEnabled public List<BILLING_PLAN_DATES> BillingPlanDates { get; set; }
        @AuraEnabled public List<SCHEDULE> ItemSchedules { get; set; }
    } 

    public class INCOMPLETION_LOG
    {
        @AuraEnabled public String TextID { get; set; }
        @AuraEnabled public String Text { get; set; }
    }

    // Constructor
    public DS_Document_Detail()
    {
        this.SALES = new DS_Document_Detail.SALES();
        this.PARTNERS = new List<DS_Document_Detail.PARTNERS>();
        this.CONDITIONS = new List<DS_Document_Detail.CONDITIONS>();
        this.TEXTS = new List<DS_Document_Detail.TEXTS>();
        this.ITEMS = new List<DS_Document_Detail.ITEMS>();
    }

    // Clone the Header. use for saving to SObject
    public DS_Document_Detail cloneHeader()
    {
        DS_Document_Detail headerObject = new DS_Document_Detail();
        headerObject.SalesDocument = this.SalesDocument;
        headerObject.SoldToParty = this.SoldToParty;
        headerObject.SoldToPartyText = this.SoldToPartyText;
        headerObject.CustomerPurchaseOrderNumber = this.CustomerPurchaseOrderNumber;
        headerObject.CustomerPurchaseOrderDate = this.CustomerPurchaseOrderDate;
        headerObject.NetOrderValue = this.NetOrderValue;
        headerObject.TaxAmount = this.TaxAmount;
        headerObject.SalesDocumentCurrency = this.SalesDocumentCurrency;
        headerObject.ReferenceDocument = this.ReferenceDocument;
        headerObject.ReferenceDocumentCategory = this.ReferenceDocumentCategory;
        headerObject.StartDate = this.StartDate;
        headerObject.EndDate = this.EndDate;

        headerObject.ShippingConditions = this.ShippingConditions;
        headerObject.CollectiveNumber = this.CollectiveNumber;
        headerObject.PricingType = this.PricingType;
        headerObject.IsSuccess = this.IsSuccess;

        headerObject.SALES = this.SALES;
        headerObject.PARTNERS = this.PARTNERS;
        headerObject.CONDITIONS = this.CONDITIONS;
        headerObject.TEXTS = this.TEXTS;
        headerObject.SBOHeaderConditions = this.SBOHeaderConditions;

        return headerObject;
    }
}