public with sharing class UTIL_MaterialMapping
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_MaterialMapping.class);

    public static MaterialMapping getMapping()
    {
        ensxapp__SAP_Material_Settings__mdt settings = getSettingsMetadataRecord();
        List<ensxapp__SAP_Material_Search_Mapping__mdt> searchMappings = getMappingsMetadataRecords(settings.Id);

        MaterialMapping result = new MaterialMapping();
        result.materialNumber = new SearchFieldMapping();
        result.materialNumber.sapField = 'Material';
        result.materialNumber.productField = settings.ensxapp__Material_Number_Field__r.QualifiedApiName;

        Integer mapTot = searchMappings.size();
        for (Integer mapCnt = 0 ; mapCnt < mapTot ; mapCnt++)
        {
            ensxapp__SAP_Material_Search_Mapping__mdt mapping = searchMappings[mapCnt];
            setResultFromMapping(result, mapping);
        }

        return result;
    }

    public static String getSettingsUrl()
    {
        ensxapp__SAP_Material_Settings__mdt settings = getSettingsMetadataRecord();
        return '/' + settings.Id;
    }

    @testVisible
    private static ensxapp__SAP_Material_Settings__mdt getSettingsMetadataRecord()
    {
        String settingsName = 'ensxapp__Settings';

        List<ensxapp__SAP_Material_Settings__mdt> result = [
            SELECT Id, ensxapp__Material_Number_Field__r.QualifiedApiName
            FROM ensxapp__SAP_Material_Settings__mdt
            WHERE QualifiedApiName = :settingsName
        ];

        if (result.size() != 1)
        {
            throw new NoDataFoundException();
        }

        return result.get(0);
    }

    @testVisible
    private static List<ensxapp__SAP_Material_Search_Mapping__mdt> getMappingsMetadataRecords(Id parent)
    {
        List<ensxapp__SAP_Material_Search_Mapping__mdt> result = [
            SELECT
                ensxapp__SAP_Field__c
                , ensxapp__Product2_Field__c
                , ensxapp__Product2_Field__r.QualifiedApiName
                , ensxapp__Editable__c
                , ensxapp__Visible__c
            FROM ensxapp__SAP_Material_Search_Mapping__mdt
            WHERE ensxapp__Parent__c = :parent
        ];

        if (result.size() < 1)
        {
            throw new NoDataFoundException();
        }

        return result;
    }

    private static void setResultFromMapping(MaterialMapping result, ensxapp__SAP_Material_Search_Mapping__mdt mapping)
    {
        if ('MaterialDescription' == mapping.ensxapp__SAP_Field__c)
        {
            result.materialDescription = getSearchFieldMappingForMetadata(mapping);
        }
        else if ('MaterialGroup' == mapping.ensxapp__SAP_Field__c)
        {
            result.materialGroup = getSearchFieldMappingForMetadata(mapping);
        }
        else if ('MaterialType' == mapping.ensxapp__SAP_Field__c)
        {
            result.materialType = getSearchFieldMappingForMetadata(mapping);
        }
    }

    private static SearchFieldMapping getSearchFieldMappingForMetadata(
        ensxapp__SAP_Material_Search_Mapping__mdt mapping)
    {
        SearchFieldMapping result = new SearchFieldMapping();

        if (String.isNotBlank(mapping.ensxapp__Product2_Field__c))
        {
            result.productField = mapping.ensxapp__Product2_Field__r.QualifiedApiName;
        }

        result.sapField = mapping.ensxapp__SAP_Field__c;
        result.isEditable = mapping.ensxapp__Editable__c;
        result.isVisible = mapping.ensxapp__Visible__c;

        return result;
    }

    public class MaterialMapping
    {
        @AuraEnabled public SearchFieldMapping materialNumber { get; set; }
        @AuraEnabled public SearchFieldMapping materialDescription { get; set; }
        @AuraEnabled public SearchFieldMapping materialGroup { get; set; }
        @AuraEnabled public SearchFieldMapping materialType { get; set; }

        public List<SearchFieldMapping> allFields
        {
            get
            {
                return new List<SearchFieldMapping> {
                    this.materialNumber,
                    this.materialDescription,
                    this.materialGroup,
                    this.materialType
                };
            }
        }
    }

    public class SearchFieldMapping
    {
        @AuraEnabled public String sapField { get; set; }
        @AuraEnabled public String productField { get; set; }
        @AuraEnabled public Boolean isVisible { get; set; }
        @AuraEnabled public Boolean isEditable { get; set; }
    }
}