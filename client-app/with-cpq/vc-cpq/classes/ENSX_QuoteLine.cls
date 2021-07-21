global with sharing class ENSX_QuoteLine{
    public Object debug{get;set;}
    @AuraEnabled
    public String Product{get;set;}
    public String ItemNumber{get;set;}
    public String PricebookEntry{get;set;}
    public String SAPMaterialNumber{get;set;}
    public Integer ParentLineItem{get;set;}
    public Integer LineItem{get;set;}
    public Decimal Quantity{get;set;}
    public Decimal ListPrice{get;set;}
    public Decimal NetPrice{get;set;}
    public Decimal NetCost{get;set;}
    public Decimal NetWeight{get;set;}
    public Decimal UnitCost{get;set;}
    public Decimal CostPrice{get;set;}
    public String Plant{get;set;}
    public String Description{get;set;}
    public Decimal DiscountPercent{get;set;}
    public Date ATPDate{get;set;}
    public String itemJSON{get;set;}
    public Boolean IsProductFeature{get;set;}
    public ENSX_ItemConfiguration ItemConfiguration {get;set;}
    public String RealProductId {get;set;}
    public String RealPricebookEntryId{get; set;}
    public Map<String,Object> record {get;set;}
    public String recordJSON{get;set;}
}