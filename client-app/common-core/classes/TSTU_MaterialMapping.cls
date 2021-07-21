@isTest public with sharing class TSTU_MaterialMapping
{
    @isTest
    static void test_getMapping()
    {
        Test.startTest();
        UTIL_MaterialMapping.MaterialMapping MM = UTIL_MaterialMapping.getMapping();
        List<UTIL_MaterialMapping.SearchFieldMapping> allFields = MM.allFields;
        Test.stopTest();
    }

    @isTest
    static void test_getSettingsUrl()
    {
        Test.startTest();
        UTIL_MaterialMapping.getSettingsUrl();
        Test.stopTest();
    }
}