@IsTest
public with sharing class TSTU_CPQ_Setup
{
    @isTest
    static void test_getFromAppSettings()
    {
        UTIL_CPQ_Setup.getFromAppSettings();
        UTIL_CPQ_Setup.installCustomScript();
        UTIL_CPQ_Setup.getFromAppSettings().installThisCustomScript();
    }
    @IsTest
    public static void test_installCustomScript()
    {
        Test.startTest();
        UTIL_CPQ_Setup util = new UTIL_CPQ_Setup();
        SBQQ__CustomScript__c cs = new SBQQ__CustomScript__c();
        cs.Name = util.customScriptName;
        TSTU_SFTestObject.upsertWithRetry(cs);       
        //util.installThisCustomScript();
        UTIL_CPQ_Setup.installCustomScript();
        Test.stopTest();
        System.assert(null != [SELECT Id FROM SBQQ__CustomScript__c WHERE Name = :(util.customScriptName)].Id);
    }

    

}