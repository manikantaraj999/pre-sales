@isTest public with sharing class TSTU_CustomerMapping
{
    @isTest
    static void test_getMapping()
    {
        Test.startTest();
        Account testAcct = TSTU_SFTestObject.createTestAccount();
        TSTU_SFTestObject.upsertWithRetry(testAcct);
        UTIL_CustomerMapping.CustomerInformationMapping CIM = UTIL_CustomerMapping.getMapping();
        CIM = UTIL_CustomerMapping.getMapping(testAcct.Id);
        CIM = UTIL_CustomerMapping.getMapping(testAcct);
        List<UTIL_CustomerMapping.SearchFieldMapping> allFields = CIM.allFields;
        Test.stopTest();
    }

    @isTest
    static void test_getSettingsUrl()
    {
        Test.startTest();
        UTIL_CustomerMapping.getSettingsUrl();
        Test.stopTest();
    }
}