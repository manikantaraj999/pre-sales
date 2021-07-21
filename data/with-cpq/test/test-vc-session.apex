

ENSX_VCPricingConfiguration pricingConfig = new ENSX_VCPricingConfiguration();
pricingConfig.SoldToParty = '500070';
pricingConfig.ShipToParty = '500070';
pricingConfig.SalesOrganization = '3000';
pricingConfig.Plant = '3000';
pricingConfig.OrderQuantity = 1;
pricingConfig.Division = '00';
pricingConfig.DistributionChannel = '01';
pricingConfig.Material = 'DELL COMPUTER1';

Map<String, String> values = new Map<String,String>{
     'MODELS'       => 'Inspiron Small Desktop'
    ,'PROCESSOR'    => 'Intel Celeron'
    ,'MEMORY'       => '4GB' 
    ,'SCREENGUARD'  => '1,333.2226'
}; 

UTIL_VC_PricingAndConfiguration.UseSession = true;

Map<String, String> result = UTIL_VC_Perf.RunConfiguration(pricingConfig, values);

System.debug(JSON.serialize(result));


