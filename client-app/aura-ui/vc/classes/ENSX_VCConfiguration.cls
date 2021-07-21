public with sharing class ENSX_VCConfiguration
{
    @AuraEnabled
    public Boolean ConfigurationIsValid { get; set; }

    @AuraEnabled
    public Decimal Price { get; set; }
 
    // @AuraEnabled 
    // public Decimal Cost { get; set; }
 
    @AuraEnabled
    public String MaterialId { get; set; }
    @AuraEnabled
    public String Instance {get;set;}
    @AuraEnabled
    public ENSX_VCPricingConfiguration PricingConfiguration { get; set; }

    @AuraEnabled
    public List<ENSX_VCCharacteristicValues> SelectedValues{ get;set; }

    @AuraEnabled
    public List<ENSX_VCCharacteristic> Characteristics { get; set; }

    public static ENSX_VCConfiguration getConfigurationFromSBOModel(SBO_EnosixVC_Detail.EnosixVC model)
    {
        ENSX_VCConfiguration config = new ENSX_VCConfiguration();
        //todo: price and cost to come from the sbo model when Jeff finishes
        // config.Price = model.NetItemPrice;
        System.debug('getConfigurationFromSBOModel');
        System.debug('price:' + model.NetItemPrice);
        config.Characteristics = getCharacteristicsFromSBOModel(model);
        config.SelectedValues = getSelectedValuesFromSBOModel(model);
        config.Price = model.NetItemPrice;
        // config.Cost = model.Cost; //String.valueOf((tempPrice *.72).setScale(2));
        config.PricingConfiguration = new ENSX_VCPricingConfiguration();
        config.PricingConfiguration.ConfigDate =  model.ConfigDate;
        config.PricingConfiguration.DistributionChannel = model.DistributionChannel;
        config.PricingConfiguration.Division = model.Division;
        config.PricingConfiguration.ObjectKey = model.ObjectKey;
        config.PricingConfiguration.Plant = model.Plant;
        config.PricingConfiguration.SalesDocumentType = model.SalesDocumentType;
        config.PricingConfiguration.SalesOrganization = model.SalesOrganization;
        config.PricingConfiguration.SoldToParty = model.SoldToParty;
        config.PricingConfiguration.ShipToParty = model.ShipToParty;
        config.PricingConfiguration.SalesDocumentCurrency = model.SalesDocumentCurrency;
        config.PricingConfiguration.OrderQuantity = model.OrderQuantity;
        config.ConfigurationIsValid = model.ConfigurationIsValid;
        config.MaterialId = model.Material;
        config.Instance = model.ConfigInstance;
        return config;
    }
    public static SBO_EnosixVC_Detail.EnosixVC getSBOModelFromConfig(ENSX_VCConfiguration config, Boolean fetchPricing)
    {
        System.debug('getSBOModelFromConfigENSX_VCConfiguration');
        SBO_EnosixVC_Detail.EnosixVC sboConfig = new SBO_EnosixVC_Detail.EnosixVC();
        Integer configTot = config.SelectedValues.size();
        for (Integer configCnt = 0 ; configCnt < configTot ; configCnt++)
        {
            ENSX_VCCharacteristicValues charValue = config.SelectedValues[configCnt];
            sboConfig.SELECTEDVALUES.add(ENSX_VCCharacteristicValues.getSBOASelectedValuesForModel(charValue));
        }
        configTot = config.Characteristics.size();
        for (Integer configCnt = 0 ; configCnt < configTot ; configCnt++)
        {
            ENSX_VCCharacteristic charac = config.Characteristics[configCnt];
            // System.debug('got to characteristic:' + charac.CharacteristicValueDescription);
            sboConfig.CHARACTERISTICS.add(ENSX_VCCharacteristic.getSBOModelCharacteristicForCharacteristic(charac));
            List<SBO_EnosixVC_Detail.ALLOWEDVALUES> av = ENSX_VCCharacteristic.getSBOAllowedValuesFromPossibleValues(charac);
            // System.debug('ALLOWED VALUES PRIOR TO ADDING:' +sboConfig.ALLOWEDVALUES.size());
            Integer avTot = av.size();
            for (Integer avCnt = 0 ; avCnt < avTot ; avCnt++)
            {
                SBO_EnosixVC_Detail.ALLOWEDVALUES v = av[avCnt];
                sboConfig.ALLOWEDVALUES.add(v);
            }
        }
        System.debug('setting header info, done with collections');
        ApplyPricingConfigurationToSBO(sboConfig,config.PricingConfiguration);
        sboConfig.Configurationisvalid = config.ConfigurationIsValid;
        sboConfig.Material = config.MaterialId;
        sboConfig.ConfigInstance = config.Instance;
        sboConfig.NetItemPrice = config.Price;
        // sboConfig.Cost = config.Cost;
        return sboConfig;
    }
    public static void ApplyPricingConfigurationToSBO(SBO_EnosixVC_Detail.EnosixVC sboConfig, ENSX_VCPricingConfiguration pricingConfiguration)
    {
        if(PricingConfiguration!=null)
        {
            sboConfig.ObjectKey = pricingConfiguration.ObjectKey;
            sboConfig.ConfigDate = Date.today();
            sboConfig.CalculatePrice = false; 
            sboConfig.SalesDocumentType = pricingConfiguration.SalesDocumentType;
            sboConfig.SalesOrganization = pricingConfiguration.SalesOrganization;
            sboConfig.DistributionChannel = pricingConfiguration.DistributionChannel;
            sboConfig.Division = pricingConfiguration.Division;
            sboConfig.SoldToParty = pricingConfiguration.SoldToParty;
            sboConfig.ShipToParty = pricingConfiguration.ShipToParty;
            sboConfig.Plant = pricingConfiguration.Plant;
            sboConfig.SalesDocumentCurrency = pricingConfiguration.SalesDocumentCurrency;
            sboConfig.OrderQuantity = pricingConfiguration.OrderQuantity;
            sboConfig.SalesDocumentType = pricingConfiguration.SalesDocumentType;
        }
    }
    @testVisible
    private static List<ENSX_VCCharacteristic> getCharacteristicsFromSBOModel(SBO_EnosixVC_Detail.EnosixVC model)
    {
        List<ENSX_VCCharacteristic> chars = new List<ENSX_VCCharacteristic>();
        List<SBO_EnosixVC_Detail.CHARACTERISTICS> charList = model.CHARACTERISTICS.getAsList();
        Integer charTot = charList.size();
        for (Integer charCnt = 0 ; charCnt < charTot ; charCnt++)
        {
            SBO_EnosixVC_Detail.CHARACTERISTICS res = charList[charCnt];
            chars.add(ENSX_VCCharacteristic.getCharacteristicForSBOModel(model,res));
        }
        return chars;
    }
    @testVisible
    private static List<ENSX_VCCharacteristicValues> getSelectedValuesFromSBOModel(SBO_EnosixVC_Detail.EnosixVC model)
    {
        List<ENSX_VCCharacteristicValues> selectedVals = new List<ENSX_VCCharacteristicValues>();
        List<SBO_EnosixVC_Detail.SELECTEDVALUES> charList = model.SELECTEDVALUES.getAsList();
        Integer charTot = charList.size();
        for (Integer charCnt = 0 ; charCnt < charTot ; charCnt++)
        {
            SBO_EnosixVC_Detail.SELECTEDVALUES res = charList[charCnt];
            ENSX_VCCharacteristicValues val = new ENSX_VCCharacteristicValues();
            val.ValueDescription = ENSX_VCCharacteristic.getValueDescriptionForValueId(model, res.CharacteristicValue);
            val.Value = res.CharacteristicValue;
            val.CharacteristicId = res.CharacteristicID;
            val.CharacteristicDescription = ENSX_VCCharacteristic.getCharacteristicDescriptionForValueId(model,res.CharacteristicID);
            selectedVals.add(val);
        }
        return selectedVals;
    }
}