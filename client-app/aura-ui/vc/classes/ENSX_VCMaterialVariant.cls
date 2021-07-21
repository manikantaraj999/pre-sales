public with sharing class ENSX_VCMaterialVariant
{
    @AuraEnabled
    public String VariantDescription{get;set;}
    @AuraEnabled
    public String VariantId{get;set;}
    @AuraEnabled
    public List<ENSX_VCCharacteristicValues> CharacteristicValues {get;set;}

}