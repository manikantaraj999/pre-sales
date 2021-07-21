public class DS_SalesDocAppSettings
{
    @AuraEnabled public Integer itemNumberIncrement { get; set; }
    @AuraEnabled public Map<String, Boolean> autoSimulate { get; set; }
    @AuraEnabled public Boolean enableBoMItemEdit { get; set; }
    @AuraEnabled public Boolean enableConfiguration { get; set; }
    @AuraEnabled public String SAPDocType { get; set; }
    @AuraEnabled public String SBODetailType { get; set; }
    @AuraEnabled public String DefaultDocType { get; set; }
    @AuraEnabled public List<DocumentType> DocTypes { get; set; }
    @AuraEnabled public DocumentSetting Header { get; set; }
    @AuraEnabled public DocumentSetting Item { get; set; }
    @AuraEnabled public Boolean updateLineItems { get; set; }
    
    public class DocumentType
    {
        @AuraEnabled public String id { get; set; }
        @AuraEnabled public String label { get; set; }
    }
    
    public class DocumentSetting
    {
        @AuraEnabled public List<PartnerSetting> PartnerPickers { get; set; }
        @AuraEnabled public Map<String, String> Texts { get; set; }
    }

    public class PartnerSetting
    {
        @AuraEnabled public String PartnerFunction { get; set; }
        @AuraEnabled public String PartnerFunctionName { get; set; }
        @AuraEnabled public String ComponentType { get; set; }
        @AuraEnabled public String SearchType { get; set; }
        @AuraEnabled public Boolean autoSearch { get; set; }
        @AuraEnabled public Boolean allowSearch { get; set; }
        @AuraEnabled public Boolean allowAddressOverride { get; set; }
    }
}