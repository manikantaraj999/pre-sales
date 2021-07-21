@isTest public class TSTC_enosiXExternalConfiguratorPlugin
{
    @isTest static public void test_getInfo_updateInfo()
    {
        TSTU_CPQ_TestSetup.createAccountQuoteLinked();

        Id accountId = [SELECT Id FROM Account].Id;
        Id quoteId = [SELECT Id FROM SBQQ__Quote__c].Id;
        Id productId = [SELECT Id FROM Product2].Id;

        Map<String, Object> p = new Map<String, Object> { 
            'quoteId' => quoteId, 
            'accountId' => accountId, 
            'productId' => productId, 
            'quoteSAPConfiguration' => 'TEST',
            'quoteShipTo' => '{"shipToParty": "TEST"}' };

        Test.startTest();
        String info = CTRL_enosiXExternalConfiguratorPlugin.getInfo(p);
        CTRL_enosiXExternalConfiguratorPlugin.updateInfo(p);
        Test.stopTest();

        System.assert(info != null);
    }

    @isTest static public void test_emptyCalls()
    {
        Test.startTest();
        CTRL_enosiXExternalConfiguratorPlugin item = new CTRL_enosiXExternalConfiguratorPlugin();
        item.declareDependencies();
        Test.stopTest();
    }
}