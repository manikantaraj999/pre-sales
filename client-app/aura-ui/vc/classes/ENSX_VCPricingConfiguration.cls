// Not really for pricing simulation -- these are the required header fields for the VC SBO
public with sharing virtual class ENSX_VCPricingConfiguration
{
    @AuraEnabled public Boolean CalculatePrice { get; set; }
    @AuraEnabled public Date ConfigDate { get; set; }
    @AuraEnabled public String ConfigInstance { get; set; }
    @AuraEnabled public String ConfigurationInternal { get; set; }
    @AuraEnabled public Boolean ConfigurationIsValid { get; set; }
    @AuraEnabled public String DistributionChannel { get; set; }
    @AuraEnabled public String Division { get; set; }
    @AuraEnabled public String Material { get; set; }
    @AuraEnabled public String MaterialDescription { get; set; }
    @AuraEnabled public String ObjectKey { get; set; }
    @AuraEnabled public Decimal OrderQuantity { get; set; }
    @AuraEnabled public String Plant { get; set; }
    @AuraEnabled public String SalesDocumentCurrency { get; set; }
    @AuraEnabled public String SalesDocumentType { get; set; }
    @AuraEnabled public String SalesOrganization { get; set; }
    @AuraEnabled public String SalesUnit { get; set; }
    @AuraEnabled public String ShipToParty { get; set; }
    @AuraEnabled public String SoldToParty { get; set; }

    @AuraEnabled public String EnosixObjKey { get; set; }
    @AuraEnabled public String SessionData { get; set; }
    @AuraEnabled public Boolean isSuccess { get; set; }
    @AuraEnabled public String HttpCloseReqquest { get; set; }
}