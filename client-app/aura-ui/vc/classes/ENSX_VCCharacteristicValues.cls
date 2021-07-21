public with sharing class ENSX_VCCharacteristicValues
{
    @AuraEnabled
    public String CharacteristicId { get; set;}
    @AuraEnabled
    public String CharacteristicDescription {get;set;}
    @AuraEnabled
    public String Value { get; set;}
    @AuraEnabled
    public String ValueDescription { get; set;}

    public static SBO_EnosixVC_Detail.ALLOWEDVALUES getSBOAllowedValuesForModel(ENSX_VCCharacteristicValues val)
    {
        // System.debug('ENSX_VCCharacteristicValues.getSBOAllowedValuesForModel');
        SBO_EnosixVC_Detail.ALLOWEDVALUES av = new SBO_EnosixVC_Detail.ALLOWEDVALUES();
        av.CharacteristicValueDescription = val.ValueDescription;
        av.CharacteristicValue = val.Value;
        av.CharacteristicID = val.CharacteristicId;
        return av;
    }
    public static SBO_EnosixVC_Detail.SELECTEDVALUES getSBOASelectedValuesForModel(ENSX_VCCharacteristicValues val)
    {
        SBO_EnosixVC_Detail.SELECTEDVALUES sv = new SBO_EnosixVC_Detail.SELECTEDVALUES();
        sv.CharacteristicValue = val.Value;
        sv.CharacteristicID = val.CharacteristicId;
        return sv;
    }
}