public with sharing class ENSX_VCProductConfiguration
{
    @AuraEnabled
    public Boolean SAPMaterialLinked { get; set; }
   
    @AuraEnabled
    public String SAPMaterial { get; set; }

    @AuraEnabled
    public Boolean ProductFeatureCreated {get;set;}

    @AuraEnabled
    public Boolean AllProductOptionsCreated { get; set;}

    @AuraEnabled
    public Integer ConfiguredProductOptionsCount{ get; set; }

    @AuraEnabled
    public Integer SAPCharacteristicCount{ get; set; }
    
    @AuraEnabled
    public Boolean PriceEditable { get; set; }
    
    @AuraEnabled
    public Boolean CostEditable { get; set; }

    @AuraEnabled
    public Boolean ExternalConfigurationRequired{ get; set; }

    @AuraEnabled
    public Boolean ExternalConfigurationTypeRequired{ get;set; }

    @AuraEnabled
    public Boolean ExternalConfigurationEventAlways{get;set; }

    @AuraEnabled
    public String PricebookName{ get; set; }
    
    @AuraEnabled
    public String ProductId{ get; set; }
    
    @AuraEnabled
    public Boolean PartiallyConfigured { get; set; }
    
    @AuraEnabled
    public Boolean FullyConfigured { get; set; }
}