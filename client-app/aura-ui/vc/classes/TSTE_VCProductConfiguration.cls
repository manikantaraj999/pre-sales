@isTest
public class TSTE_VCProductConfiguration
{
    @isTest static void testClassVariables ()
    {
        Test.startTest();
        ENSX_VCProductConfiguration ensxVcProductConfguration = new ENSX_VCProductConfiguration();
        ensxVcProductConfguration.SAPMaterialLinked = true;
        ensxVcProductConfguration.SAPMaterial = 'SAPMaterial';
        ensxVcProductConfguration.ProductFeatureCreated = true;
        ensxVcProductConfguration.AllProductOptionsCreated = true;
        ensxVcProductConfguration.ConfiguredProductOptionsCount = 0;
        ensxVcProductConfguration.SAPCharacteristicCount = 0;
        ensxVcProductConfguration.PriceEditable = true;
        ensxVcProductConfguration.CostEditable = true;
        ensxVcProductConfguration.ExternalConfigurationRequired = true;
        ensxVcProductConfguration.ExternalConfigurationTypeRequired = true;
        ensxVcProductConfguration.ExternalConfigurationEventAlways = true;
        ensxVcProductConfguration.PricebookName = 'PricebookName';
        ensxVcProductConfguration.ProductId = 'ProductId';
        ensxVcProductConfguration.PartiallyConfigured = true;
        ensxVcProductConfguration.FullyConfigured = true;
        Test.stopTest();
    }
}
