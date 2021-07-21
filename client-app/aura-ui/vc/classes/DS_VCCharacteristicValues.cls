public with sharing class DS_VCCharacteristicValues
{
    @AuraEnabled public String CharacteristicID { get; set;}
    @AuraEnabled public String CharacteristicValue { get; set;}
    @AuraEnabled public String CharacteristicName { get; set; }
    @AuraEnabled public String CharacteristicValueDescription { get; set; }
    @AuraEnabled public Boolean UserModified { get; set; }

    public SBO_EnosixVC_Detail.SELECTEDVALUES getSBOASelectedValuesForModel()
    {
        SBO_EnosixVC_Detail.SELECTEDVALUES sv = new SBO_EnosixVC_Detail.SELECTEDVALUES();
        sv.CharacteristicID = this.CharacteristicID;
        sv.CharacteristicValue = this.CharacteristicValue;       
        sv.CharacteristicName = this.CharacteristicName;
        sv.CharacteristicValueDescription = this.CharacteristicValueDescription;
        sv.UserModified = this.UserModified;
        return sv;
    }
}