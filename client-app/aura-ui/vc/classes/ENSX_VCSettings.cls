public with sharing class ENSX_VCSettings
{
    // @AuraEnabled
    // public Boolean AutoSelectWhenSingleValue { get; set; }
   
    // @AuraEnabled
    // public Boolean AutoSelectFirstValue { get; set; }

    @AuraEnabled
    public Boolean SimulateAddedItems { get; set; }

    @AuraEnabled
    public Map<String,Object> Rules { get; set; }

    @AuraEnabled
    public Boolean RequiredOnlyDefaultToggle { get; set; }

    @AuraEnabled
    public Boolean DisplayManualRunVCButton { get; set; }

    @AuraEnabled
    public Boolean CanChangeSettings { get; set; }

    @AuraEnabled
    public Boolean DisplayCost { get; set; }

    @AuraEnabled
    public Boolean DisplayPrice { get; set; }
     
    @AuraEnabled
    public String FetchConfigurationFrequency { get; set; }

    @AuraEnabled
    public List<ENSX_VCSettingsSelection> FetchConfigurationFrequencyPossibilities{ get; set;}
     
    @AuraEnabled
    public String textAllowedValuesLabelRegex { get; set; }
 
    @AuraEnabled
    public String numberAllowedValuesLabelRegex { get; set; }
 
    @AuraEnabled
    public String dateAllowedValuesLabelRegex { get; set; }
}