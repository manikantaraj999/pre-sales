public with sharing class UTIL_CustomerMapping
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_CustomerMapping.class);

    public static CustomerInformationMapping getMapping()
    {
        ensxapp__SAP_Customer_Information_Settings__mdt settings = getSettingsMetadataRecord();
        List<ensxapp__SAP_Customer_Search_Mapping__mdt> searchMappings = getMappingsMetadataRecords(settings.Id);

        CustomerInformationMapping result = new CustomerInformationMapping();
        result.customerNumber = new SearchFieldMapping();
        result.customerNumber.sapField = 'CustomerNumber';
        result.customerNumber.sObjectField = settings.ensxapp__Customer_Number_Field__r.QualifiedApiName;

        Integer mapTot = searchMappings.size();
        for (Integer mapCnt = 0 ; mapCnt < mapTot ; mapCnt++)
        {
            ensxapp__SAP_Customer_Search_Mapping__mdt mapping = searchMappings[mapCnt];
            setResultFromMapping(result, mapping);
        }

        return result;
    }

    public static CustomerInformationMapping getMapping(Id recordId)
    {
        ensxapp__SAP_Customer_Information_Settings__mdt settings = getSettingsMetadataRecord(recordId);
 		if(settings==null) return null;
        
        List<ensxapp__SAP_Customer_Search_Mapping__mdt> searchMappings = getMappingsMetadataRecords(settings.Id);

        CustomerInformationMapping result = new CustomerInformationMapping();
        result.customerNumber = new SearchFieldMapping();
        result.customerNumber.sapField = 'CustomerNumber';
        result.customerNumber.sObjectField = settings.ensxapp__Customer_Number_Field__r.QualifiedApiName;

        Integer mapTot = searchMappings.size();
        for (Integer mapCnt = 0 ; mapCnt < mapTot ; mapCnt++)
        {
            ensxapp__SAP_Customer_Search_Mapping__mdt mapping = searchMappings[mapCnt];
            setResultFromMapping(result, mapping);
        }

        return result;
    }

    public static CustomerInformationMapping getMapping(SObject sObj)
    {
        ensxapp__SAP_Customer_Information_Settings__mdt settings = getSettingsMetadataRecord(sObj);
        List<ensxapp__SAP_Customer_Search_Mapping__mdt> searchMappings = getMappingsMetadataRecords(settings.Id);

        CustomerInformationMapping result = new CustomerInformationMapping();
        result.customerNumber = new SearchFieldMapping();
        result.customerNumber.sapField = 'CustomerNumber';
        result.customerNumber.sObjectField = settings.ensxapp__Customer_Number_Field__r.QualifiedApiName;

        Integer mapTot = searchMappings.size();
        for (Integer mapCnt = 0 ; mapCnt < mapTot ; mapCnt++)
        {
            ensxapp__SAP_Customer_Search_Mapping__mdt mapping = searchMappings[mapCnt];
            setResultFromMapping(result, mapping);
        }

        return result;
    }


    public static String getSettingsUrl()
    {
        ensxapp__SAP_Customer_Information_Settings__mdt settings = getSettingsMetadataRecord();
        return '/' + settings.Id;
    }

    private static ensxapp__SAP_Customer_Information_Settings__mdt getSettingsMetadataRecord()
    {
        String settingsName = 'ensxapp__Settings';

        List<ensxapp__SAP_Customer_Information_Settings__mdt> result = [
            SELECT Id, ensxapp__Customer_Number_Field__r.QualifiedApiName
            FROM ensxapp__SAP_Customer_Information_Settings__mdt
            WHERE QualifiedApiName = :settingsName
        ];

        if (result.size() != 1)
        {
            throw new NoDataFoundException();
        }

        return result.get(0);
    }


    private static ensxapp__SAP_Customer_Information_Settings__mdt getSettingsMetadataRecord(String SObjectTypeName)
    {
        List<ensxapp__SAP_Customer_Information_Settings__mdt> result = new List<ensxapp__SAP_Customer_Information_Settings__mdt>();

        result = [
            SELECT Id, ensxapp__Customer_Number_Field__r.QualifiedApiName
            FROM ensxapp__SAP_Customer_Information_Settings__mdt
            WHERE ensxapp__Entity__c = :SObjectTypeName
        ];


        if (result.size() != 1)
        {
           throw new MetaDataNotFoundException(String.format(System.Label.LBL_CustomerInformationMetaDataException, new List<String>{SObjectTypeName}));
        }

        return result.get(0);
    }

    private static ensxapp__SAP_Customer_Information_Settings__mdt getSettingsMetadataRecord(Id recordId)
    {
        String objectTypeName = UTIL_SObject.getSObjectNameFromId(recordId);
        return getSettingsMetadataRecord(objectTypeName);
    }

    private static ensxapp__SAP_Customer_Information_Settings__mdt getSettingsMetadataRecord(SObject sObj)
    {
        Schema.SObjectType sobjectType = sObj.getSObjectType();
        String sObjectTypeName = sobjectType.getDescribe().getName();

        return getSettingsMetadataRecord(sObjectTypeName);
    }

    private static List<ensxapp__SAP_Customer_Search_Mapping__mdt> getMappingsMetadataRecords(Id parent)
    {
        List<ensxapp__SAP_Customer_Search_Mapping__mdt> result = [
            SELECT
                ensxapp__SAP_Field__c
                , ensxapp__Account_Field__c
                , ensxapp__Account_Field__r.QualifiedApiName
                , ensxapp__Address_SubField__c
                , ensxapp__Editable__c
                , ensxapp__Visible__c
            FROM ensxapp__SAP_Customer_Search_Mapping__mdt
            WHERE ensxapp__Parent__c = :parent
        ];

        return result;
    }

    private static void setResultFromMapping(
        CustomerInformationMapping result, ensxapp__SAP_Customer_Search_Mapping__mdt mapping)
    {
        if ('CustomerName' == mapping.ensxapp__SAP_Field__c)
        {
            result.customerName = getSearchFieldMappingForMetadata(mapping);
        }
        else if ('CustomerAccountGroup' == mapping.ensxapp__SAP_Field__c)
        {
            result.customerAccountGroup = getSearchFieldMappingForMetadata(mapping);
        }
        else if ('PostalCode' == mapping.ensxapp__SAP_Field__c)
        {
            result.customerPostalCode = getSearchFieldMappingForMetadata(mapping);
        }
        else if ('TelephoneNumber' == mapping.ensxapp__SAP_Field__c)
        {
            result.customerPhone = getSearchFieldMappingForMetadata(mapping);
        }
        else if ('EmailAddress' == mapping.ensxapp__SAP_Field__c)
        {
            result.customerEmail = getSearchFieldMappingForMetadata(mapping);
        }
    }

    private static SearchFieldMapping getSearchFieldMappingForMetadata(
        ensxapp__SAP_Customer_Search_Mapping__mdt mapping)
    {
        SearchFieldMapping result = new SearchFieldMapping();

        if (String.isNotBlank(mapping.ensxapp__Account_Field__c))
        {
            result.sObjectField = mapping.ensxapp__Account_Field__r.QualifiedApiName;
        }

        result.sapField = mapping.ensxapp__SAP_Field__c;
        result.addressSubField = mapping.ensxapp__Address_SubField__c;
        result.isEditable = mapping.ensxapp__Editable__c;
        result.isVisible = mapping.ensxapp__Visible__c;

        return result;
    }

    public class CustomerInformationMapping
    {
        public SearchFieldMapping customerNumber { get; set; }
        public SearchFieldMapping customerName { get; set; }
        public SearchFieldMapping customerAccountGroup { get; set; }
        public SearchFieldMapping customerPostalCode { get; set; }
        public SearchFieldMapping customerPhone { get; set; }
        public SearchFieldMapping customerEmail { get; set; }

        public List<SearchFieldMapping> allFields
        {
            get
            {
                return new List<SearchFieldMapping> {
                    this.customerNumber,
                    this.customerName,
                    this.customerAccountGroup,
                    this.customerPostalCode,
                    this.customerPhone,
                    this.customerEmail
                };
            }
        }
    }

    public class SearchFieldMapping
    {
        public String sapField { get; set; }
        public String sObjectField { get; set; }
        public String addressSubField { get; set; }
        public Boolean isVisible { get; set; }
        public Boolean isEditable { get; set; }
    }
    public class MetaDataNotFoundException extends Exception {}
}