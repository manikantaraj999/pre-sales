@isTest
public class TSTE_VCPricingConfiguration
{
    @isTest static void testClassVariables ()
    {
        Test.startTest();
        ENSX_VCPricingConfiguration ensxVcPricingConfguration = new ENSX_VCPricingConfiguration();
        ensxVcPricingConfguration.CalculatePrice = true;
        ensxVcPricingConfguration.ConfigDate = Date.today();
        ensxVcPricingConfguration.ConfigInstance = 'ConfigInstance';
        ensxVcPricingConfguration.ConfigurationIsValid = true;
        ensxVcPricingConfguration.ConfigurationInternal = 'ConfigurationInternal';
        ensxVcPricingConfguration.DistributionChannel = 'DistributionChannel';
        ensxVcPricingConfguration.Division = 'Division';
        ensxVcPricingConfguration.Material = 'Material';
        ensxVcPricingConfguration.MaterialDescription = 'MaterialDescription';
        ensxVcPricingConfguration.ObjectKey = 'ObjectKey';
        ensxVcPricingConfguration.OrderQuantity = 0;
        ensxVcPricingConfguration.Plant = 'Plant';
        ensxVcPricingConfguration.SalesDocumentCurrency = 'SalesDocumentCurrency';
        ensxVcPricingConfguration.SalesDocumentType = 'SalesDocumentType';
        ensxVcPricingConfguration.SalesOrganization = 'SalesOrganization';
        ensxVcPricingConfguration.SalesUnit = 'SalesUnit';
        ensxVcPricingConfguration.ShipToParty = 'ShipToParty';
        ensxVcPricingConfguration.SoldToParty = 'SoldToParty';
        ensxVcPricingConfguration.EnosixObjKey = 'EnosixObjKey';
        ensxVcPricingConfguration.SessionData = 'SessionData';
        Test.stopTest();
    }
}
