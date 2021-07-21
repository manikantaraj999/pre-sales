public with sharing class CTRL_VCMaterialConfiguration
{
    @testVisible
     private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_VCMaterialConfiguration.class);

    private static Map<String, Schema.SObjectType> globalObjects; 
    private static String cpqObject = 'sbqq__quote__c';

    /// Gets all the characterisics in addition to pricing information
    @AuraEnabled
    public static UTIL_Aura.Response initializeConfiguration(String material, String serializedPricingConfig)
    {
        //  logger.enterAura('initializeConfiguration', new Map<String, Object> {
        //     'material' => material,
        //     'serializedPricingConfig' => serializedPricingConfig
        // });

        // ENSX_VCConfiguration initialConfig = new ENSX_VCConfiguration();

        // try {
        //     ENSX_VCPricingConfiguration pricingConfiguration = (ENSX_VCPricingConfiguration)JSON.deserializeStrict(serializedPricingConfig,ENSX_VCPricingConfiguration.class);
        //     initialConfig = UTIL_VC_PricingAndConfiguration.getInitialConfigFromMaterialAndPricing( material,pricingConfiguration);
        // } catch (Exception ex) {
        //     logger.log(LoggingLevel.ERROR, 'There was an exception thrown when attempting to initialize VC Configuration', ex);
        //     UTIL_PageMessages.addExceptionMessage(ex);
        // } finally { 
        //     logger.exit();
        // }

        // return UTIL_Aura.createResponse(initialConfig);

        return UTIL_Aura.createResponse(null);
    }

    /// Gets all the characterisics in addition to pricing information
    @AuraEnabled
    public static UTIL_Aura.Response initializeCustomConfiguration(String material, String serializedPricingConfig)
    {
         logger.enterAura('initializeCustomConfiguration', new Map<String, Object> {
            'material' => material,
            'serializedPricingConfig' => serializedPricingConfig
        });

        DS_VCMaterialConfiguration initialConfig = null;

        try 
        {
            ENSX_VCPricingConfiguration pricingConfiguration = (ENSX_VCPricingConfiguration)JSON.deserializeStrict(serializedPricingConfig,ENSX_VCPricingConfiguration.class);
            initialConfig = UTIL_VC_PricingAndConfiguration.getInitialConfigFromMaterialAndPricingAndCustomConfig( material,pricingConfiguration);
        } catch (Exception ex) {
            logger.log(LoggingLevel.ERROR, 'There was an exception thrown when attempting to initialize VC Configuration', ex);
            UTIL_PageMessages.addExceptionMessage(ex);
        } finally {
            logger.exit();
        }

        return UTIL_Aura.createResponse(initialConfig);
    }

    /// Used for reconfiguration, allows you to pass in Bill Of Materials (BOM) which will have the existing characteristics
    @AuraEnabled
    public static UTIL_Aura.Response initializeConfigurationWithBOM(string material, string serializedPricingConfig, string serializedBOM)
    {
         logger.enterAura('initializeConfigurationWithBOM', new Map<String, Object> {
            'material' => material,
            'serializedPricingConfig' => serializedPricingConfig,
            'serializedBOM' => serializedBOM
        });

        DS_VCMaterialConfiguration initialConfig = null;

        try {
            ENSX_VCPricingConfiguration pricingConfiguration = (ENSX_VCPricingConfiguration)JSON.deserializeStrict(serializedPricingConfig,ENSX_VCPricingConfiguration.class);
            List<DS_VCCharacteristicValues> BOMvalues = (List<DS_VCCharacteristicValues>)JSON.deserializeStrict(serializedBOM,List<DS_VCCharacteristicValues>.class);
            initialConfig = UTIL_VC_PricingAndConfiguration.getInitializedConfigSBOModelFromBOM( material, pricingConfiguration, BOMvalues);
        } catch (Exception ex) {
            logger.log(LoggingLevel.ERROR, 'There was an exception thrown when attempting to initialize VC Configuration', ex);
            UTIL_PageMessages.addExceptionMessage(ex);
        } finally {
            logger.exit();
        }
        
        return UTIL_Aura.createResponse(initialConfig);
    }

/*
    @AuraEnabled
    /// This should get a list of pre-configured variants that are set up in SAP.
    /// This really should be implemented in some form for just about every client.
    /// THIS CODE IS CURRENTLY INVALID AND SHOULD BE IGNORED
    public static List<ENSX_VCMaterialVariant> getMaterialVariants()
    {
        logger.enterAura('getMaterialVariants', new Map<String, Object> {
        });
        List<ENSX_VCMaterialVariant> variants = new List<ENSX_VCMaterialVariant>();
        try {
            // Inject code here for actually getting the variants.
        } catch (Exception ex) {
            logger.log(LoggingLevel.ERROR, 'There was an exception thrown when attempting to get material variants', ex);
            //THIS NEEDS TO BE UDPATED SO IT DISPLAYS ON THE PAGE
            UTIL_PageMessages.addExceptionMessage(ex);
        } finally {
            logger.exit();
        }

        return UTIL_Aura.createResponse(variants);
    }
*/
    // Simply used for debugging. Allows you to write out the entire configuration
    @testVisible
    private static void dump(SBO_EnosixVC_Detail.EnosixVC config)
    {
        System.debug('🏈🏈🏈 Start of Dump 🏈🏈🏈');

        //header
        System.debug('header:');
        System.debug('Material' + config.Material);
        System.debug('ConfigInstance' + config.ConfigInstance);
        System.debug('ObjectKey' + config.ObjectKey);
        System.debug('ConfigDate' + config.ConfigDate);
        System.debug('CalculatePrice' + config.CalculatePrice);
        System.debug('SalesDocumentType' + config.SalesDocumentType);
        System.debug('SalesOrganization' + config.SalesOrganization);
        System.debug('DistributionChannel' + config.DistributionChannel);
        System.debug('Division' + config.Division);
        System.debug('SoldToParty' + config.SoldToParty);
        System.debug('ShipToParty' + config.ShipToParty);
        System.debug('Plant' + config.Plant);
        System.debug('NetItemPrice' + config.NetItemPrice);
        //todo: look into why cost was removed?
        // System.debug('Cost' + config.Cost);
        System.debug('ConfigurationIsValid' + config.Configurationisvalid);


        //characteristics
        System.debug('characteristics:');
        List<SBO_EnosixVC_Detail.CHARACTERISTICS> charList = config.CHARACTERISTICS.getAsList();
        Integer charTot = charList.size();
        for (Integer charCnt = 0 ; charCnt < charTot ; charCnt++){
            SBO_EnosixVC_Detail.CHARACTERISTICS val = charList[charCnt];
            System.debug('CharacteristicID' + val.CharacteristicID);
            System.debug('CharacteristicName' + val.CharacteristicName);
            System.debug('CharacteristicDescription' + val.CharacteristicDescription);
            System.debug('Required' + val.Required);
            System.debug('Inherited' + val.Inherited);
            System.debug('ValuesAssigned' + val.ValuesAssigned);
            System.debug('DataType' + val.DataType);
            System.debug('SingleValue' + val.SingleValue);
            System.debug('ValueRequired' + val.ValueRequired);
            System.debug('IntervalsAllowed' + val.IntervalsAllowed);
            System.debug('AdditionalValues' + val.AdditionalValues);
            System.debug('NotToBeDisplayed' + val.NotToBeDisplayed);
            System.debug('NoEntryAllowed' + val.NoEntryAllowed);
            // System.debug('ANZST' + val.ANZST);
            // System.debug('ANZDZ' + val.ANZDZ);
            // System.debug('ValueWithPlusOrMinus' + val.ValueWithPlusOrMinus);
            // System.debug('ATDIM' + val.ATDIM);
            // System.debug('ATDEX' + val.ATDEX);
            // System.debug('ATSCH' + val.ATSCH);
            System.debug('DisplayTemplate' + val.DisplayTemplate);
            // System.debug('CaseSensitive' + val.CaseSensitive);
            // System.debug('UnitOfMeasure' + val.UnitOfMeasure);
            // System.debug('ExternalUnitOfMeasure' + val.ExternalUnitOfMeasure);
            System.debug('DisplayAllowedValues' + val.DisplayAllowedValues);
            // System.debug('ATFOD' + val.ATFOD);
            // System.debug('GroupName' + val.GroupName);
            // System.debug('GroupText' + val.GroupText);
            System.debug('SequenceNumber' + val.SequenceNumber);
        }
        //allowedValues
        System.debug('allowedValues:');
        List<SBO_EnosixVC_Detail.ALLOWEDVALUES> avList = config.ALLOWEDVALUES.getAsList();
        Integer avTot = avList.size();
        for (Integer avCnt = 0 ; avCnt < avTot ; avCnt++){
            SBO_EnosixVC_Detail.ALLOWEDVALUES res = avList[avCnt];
            System.debug('CharacteristicID' + res.CharacteristicID);
            System.debug('CharacteristicValue' + res.CharacteristicValue);
            System.debug('CharacteristicValueDescription' + res.CharacteristicValueDescription);
            // System.debug('FloatingPointValueFrom' + res.FloatingPointValueFrom);
            // System.debug('FloatingPointValueFromUOM' + res.FloatingPointValueFromUOM);
            // System.debug('FloatingPointValueTo' + res.FloatingPointValueTo);
            // System.debug('FloatingPointValueToUOM' + res.FloatingPointValueToUOM);
            // System.debug('ValueDependencyCode' + res.ValueDependencyCode);
            // System.debug('ToleranceFrom' + res.ToleranceFrom);
            // System.debug('ToleranceTo' + res.ToleranceTo);
            // System.debug('ToeranceAsPercentage' + res.ToeranceAsPercentage);
            // System.debug('IncrementWithInterval' + res.IncrementWithInterval);
        }

        //SelectedValues
        List<SBO_EnosixVC_Detail.SELECTEDVALUES> svList = config.SELECTEDVALUES.getAsList();
        Integer svTot = svList.size();
        for (Integer svCnt = 0 ; svCnt < svTot ; svCnt++){
            SBO_EnosixVC_Detail.SELECTEDVALUES res = svList[svCnt];
            System.debug('CharacteristicID' + res.CharacteristicID);
            System.debug('CharacteristicValue' + res.CharacteristicValue);
            System.debug('UserModified' + res.UserModified);
            // System.debug('FloatingPointValueFromUOM' + res.FloatingPointValueFromUOM);
            // System.debug('FloatingPointValueToUOM' + res.FloatingPointValueToUOM);
        }
        System.debug('🏈🏈🏈 End of Dump 🏈🏈🏈');
    }
    @testVisible
    private static void dumpAuraCFG(ENSX_VCConfiguration config, Boolean showCharacteristics )
    {
        System.debug('dumpAuraCFG');
        //header
        System.debug('header:');
        // System.debug('Cost' + config.Cost);
        System.debug('Price' + config.Price);
        System.debug('Selected Values:');
        Integer svTot = config.SelectedValues.size();
        for (Integer svCnt = 0 ; svCnt < svTot ; svCnt++)
        {
            ENSX_VCCharacteristicValues val = config.SelectedValues[svCnt];
            System.debug('🍍 Selected Value 🍍 ');
            System.debug('Value:' + val.Value);
            System.debug('ValDesc:' + val.ValueDescription);
            System.debug('CharId:' + val.CharacteristicId);
        }
        if(showCharacteristics)
        {
            System.debug('Characteristics:');
            Integer charTot = config.Characteristics.size();
            for (Integer charCnt = 0 ; charCnt < charTot ; charCnt++)
            {
                ENSX_VCCharacteristic cha = config.Characteristics[charCnt];
                System.debug('🚜 Characteristic Value 🚜 ');
                System.debug('CharID:' + cha.CharacteristicID);
                System.debug('CharValue:' + cha.CharacteristicValueDescription);
                System.debug('Required:' + cha.Required);
                System.debug('SingleValue:' + cha.SingleValue);
                System.debug('NoEntry:' + cha.NoEntryAllowed);
                System.debug('selectedValue:' + cha.SelectedValue);
                System.debug('PossibleValues:');
                Integer pvTot = cha.PossibleValues.size();
                for (Integer pvCnt = 0 ; pvCnt < pvTot ; pvCnt++)
                {
                    ENSX_VCCharacteristicValues val = cha.PossibleValues[pvCnt];
                    System.debug('➡️:CharId' + val.CharacteristicId);
                    System.debug('➡️:ValDesc' + val.ValueDescription);
                    System.debug('➡️:Val' + val.Value);
                }

            }
        }
    }

    private static String defaultFetchConfig = (String)UTIL_AppSettings.getValue(UTIL_AppSettings.VC, 'DefaultFetchConfig', '1');

    /// Should be done in metadata
    /// These are what comes in from the "gear" configuration on the screen.ApexPages
    /// These are hardcoded, and exist only in the context of a single "VC" session
    ///This should be updated to use Metadata long term.
    @AuraEnabled
    public static UTIL_Aura.Response fetchInitialSettings()
    {
        logger.enterAura('fetchInitialSettings', new Map<String, Object> {
        });

        ENSX_VCSettings settings  = new ENSX_VCSettings();

        try 
        {
            settings.SimulateAddedItems = (Boolean)UTIL_AppSettings.getValue(UTIL_AppSettings.VC, 'SimulateAddedItems', false);
            settings.Rules = (Map<String,Object>)UTIL_AppSettings.getValue(UTIL_AppSettings.VC, 'Rules');
            settings.RequiredOnlyDefaultToggle = (Boolean)UTIL_AppSettings.getValue(UTIL_AppSettings.VC, 'RequiredOnlyDefaultToggle', false);
            settings.DisplayManualRunVCButton = (Boolean)UTIL_AppSettings.getValue(UTIL_AppSettings.VC, 'DisplayManualRunVCButton', false);
            settings.CanChangeSettings = (Boolean)UTIL_AppSettings.getValue(UTIL_AppSettings.VC, 'CanChangeSettings', false);
            settings.DisplayCost = false;
            settings.DisplayPrice = false;
            settings.FetchConfigurationFrequencyPossibilities = new List<ENSX_VCSettingsSelection>();
            ENSX_VCSettingsSelection eachSelection = new ENSX_VCSettingsSelection();
            eachSelection.Value = '1';
            eachSelection.ValueDescription = 'Fetch After Each Characteristic Change';
            settings.FetchConfigurationFrequencyPossibilities.add(eachSelection);
            ENSX_VCSettingsSelection threeSelection = new ENSX_VCSettingsSelection();
            threeSelection.Value = '3';
            threeSelection.ValueDescription = 'Fetch After Three Characteristic Changes';
            settings.FetchConfigurationFrequencyPossibilities.add(threeSelection);
            ENSX_VCSettingsSelection fiveSelection = new ENSX_VCSettingsSelection();
            fiveSelection.Value = '5';
            fiveSelection.ValueDescription = 'Fetch After Five Characteristic Changes';
            settings.FetchConfigurationFrequencyPossibilities.add(fiveSelection);
            ENSX_VCSettingsSelection tenSelection = new ENSX_VCSettingsSelection();
            tenSelection.Value = '10';
            tenSelection.ValueDescription = 'Fetch After Ten Characteristic Changes';
            settings.FetchConfigurationFrequencyPossibilities.add(tenSelection);
            ENSX_VCSettingsSelection fifteenSelection = new ENSX_VCSettingsSelection();
            fifteenSelection.Value = '15';
            fifteenSelection.ValueDescription = 'Fetch After Fifteen Characteristic Changes';
            settings.FetchConfigurationFrequencyPossibilities.add(fifteenSelection);
            ENSX_VCSettingsSelection twentySelection = new ENSX_VCSettingsSelection();
            twentySelection.Value = '20';
            twentySelection.ValueDescription = 'Fetch After Twenty Characteristic Changes';
            settings.FetchConfigurationFrequencyPossibilities.add(twentySelection);

            ENSX_VCSettingsSelection manualSelection = new ENSX_VCSettingsSelection();
            manualSelection.Value = '0';
            manualSelection.ValueDescription = 'Fetch Manually';
            settings.FetchConfigurationFrequencyPossibilities.add(manualSelection);
            settings.FetchConfigurationFrequency = defaultFetchConfig;
            settings.textAllowedValuesLabelRegex = (String)UTIL_AppSettings.getValue(UTIL_AppSettings.VC, 'TextAllowedValuesLabelRegex', '');
            settings.numberAllowedValuesLabelRegex = (String)UTIL_AppSettings.getValue(UTIL_AppSettings.VC, 'NumberAllowedValuesLabelRegex', '');
            settings.dateAllowedValuesLabelRegex = (String)UTIL_AppSettings.getValue(UTIL_AppSettings.VC, 'DateAllowedValuesLabelRegex', '');
          } catch (Exception ex) {
            logger.log(LoggingLevel.ERROR, 'There was an exception thrown when attempting to fetch initial settings', ex);
            //THIS NEEDS TO BE UDPATED SO IT DISPLAYS ON THE PAGE
            UTIL_PageMessages.addExceptionMessage(ex);
        } finally {
            logger.exit();
        }

        return UTIL_Aura.createResponse(settings);
    }

    /// Updates the javascript that temporarily holds the settings. This should be updated to use Metadata long term.
    @AuraEnabled
    public static UTIL_Aura.Response updateSettings(string settings)
    {
        logger.enterAura('updateSettings', new Map<String, Object> {
            'settings' => settings
        });

        ENSX_VCSettings deserializedSettings = new ENSX_VCSettings();

        try 
        {
             deserializedSettings = (ENSX_VCSettings)JSON.deserializeStrict(settings,ENSX_VCSettings.class);
        } catch (Exception ex) {
            logger.log(LoggingLevel.ERROR, 'There was an exception thrown when attempting to update settings', ex);
            UTIL_PageMessages.addExceptionMessage(ex);
        } finally {
            logger.exit();
        }

        return UTIL_Aura.createResponse(deserializedSettings);
    }

    /// This handles the validation from SAP
    /// Fires whenever a call to SAP is required.
    @AuraEnabled
    public static UTIL_Aura.Response processConfiguration(string cfg, string vals, string chrs)
    {
        logger.enterAura('processConfiguration', new Map<String, Object> {
            'cfg' => cfg
            , 'vals' => vals
            , 'chrs' => chrs
        });

        DS_VCMaterialConfiguration config  = null;

        try 
        {
            config  = (DS_VCMaterialConfiguration)JSON.deserialize(cfg, DS_VCMaterialConfiguration.class);
            // Break down the incoming list of objects so that we can build up a list of selectedValues
            List<DS_VCCharacteristicValues> selectedValues = (List<DS_VCCharacteristicValues>)JSON.deserialize(vals, List<DS_VCCharacteristicValues>.class);
            List<String> characteristics = (List<String>)JSON.deserialize(chrs, List<String>.class);
            config = proccessAndLogVCConfiguration(config, selectedValues, characteristics);
        } catch (Exception ex) {
            logger.log(LoggingLevel.ERROR, 'There was an exception thrown when attempting to processConfiguration', ex);

            UTIL_PageMessages.addExceptionMessage(ex);
        } finally {
            logger.exit();
        }

        return UTIL_Aura.createResponse(config);
    }

    /// This is the internal method that handles calling to SAP during processing of configuration.
    @testVisible
    private static DS_VCMaterialConfiguration proccessAndLogVCConfiguration(
        DS_VCMaterialConfiguration config
        , List<DS_VCCharacteristicValues> selectedValues
        , List<String> characteristics)
    {
        logger.enterAura('proccessAndLogVCConfiguration', new Map<String, Object> {
            'config' => config
            , 'selectedValues' => selectedValues
            , 'characteristics' => characteristics
        });
        try {
            return UTIL_VC_PricingAndConfiguration.proccessAndLogVCConfiguration(config, selectedValues, characteristics);
            //System.debug('☎️☎️☎️️ ️reached the end of processConfiguration, config is ' + (processedCFG.ConfigurationIsValid ?'valid':'invalid') +'☎️️☎️️☎️');
            // dumpAuraCFG(processedCFG,true);
            //return processedCFG;
        } catch (Exception ex) {
            logger.log(LoggingLevel.ERROR, 'There was an exception thrown when attempting to process configuration', ex);
            //THIS NEEDS TO BE UDPATED SO IT DISPLAYS ON THE PAGE
            UTIL_PageMessages.addExceptionMessage(ex);
        } finally {
            logger.exit();
        }

        return null;
    }

    @AuraEnabled
    public static UTIL_Aura.Response simulateItem(string material, string serializedPricingConfig, string serializedBOM, string recordId)
    {
        logger.enterAura('simulateItem', new Map<String, Object> {
            'material' => material
            , 'serializedPricingConfig' => serializedPricingConfig
            , 'serializedBOM' => serializedBOM
            , 'quoteId' => recordId
        });

        Map<String, ProductModel> addedProductIdsQuantity = new Map<String, ProductModel>();

        try
        {
            ENSX_VCPricingConfiguration pricingConfiguration = (ENSX_VCPricingConfiguration)JSON.deserializeStrict(serializedPricingConfig,ENSX_VCPricingConfiguration.class);
            List<DS_VCCharacteristicValues> BOMvalues = (List<DS_VCCharacteristicValues>)JSON.deserializeStrict(serializedBOM, List<DS_VCCharacteristicValues>.class);

            SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing sbo = 
                UTIL_VCPricing.getSBOForVC_Config(material, pricingConfiguration, BOMvalues);

            List<string> addedMaterials = new List<string>();
            List<string> productsNotInPricebook = new List<string>();
            Map<String, List<Decimal>> materialsQuantity = new Map<String, List<Decimal>>();

            List<SBO_EnosixOpportunityPricing_Detail.ITEMS> itemList = sbo.ITEMS.getAsList();
            Integer itemTot = itemList.size();
            for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
            {
                SBO_EnosixOpportunityPricing_Detail.ITEMS item = itemList[itemCnt];
                if(item.Material != material)
                {
                    addedMaterials.add(item.Material);
                    if (materialsQuantity.containsKey(item.Material))
                    {
                        List<Decimal> quantities = materialsQuantity.get(item.Material);
                        quantities.add(item.OrderQuantity);
                        materialsQuantity.put(item.Material, quantities);
                    }
                    else materialsQuantity.put(item.Material, new List<Decimal>{item.OrderQuantity});
                }
            }

            SObject sfSObject = UTIL_SFSObjectDoc.getSObject(recordId);
            Id pricebookId = UTIL_SFSObjectDoc.getPriceBookId(sfSObject);
            if(addedMaterials.size() == 0)
            {
                UTIL_PageMessages.addMessage(UTIL_PageMessages.ERROR, 'No materials have been added');
            }
            else
            {
                Map<Id, PriceBookEntry> pricebookEntries = UTIL_Pricebook.getEntriesForPricebookById(pricebookId, new Set<string>(addedMaterials));
                addedProductIdsQuantity = validateProductsInPricebook(pricebookId,addedMaterials, pricebookEntries, materialsQuantity);
            }

        } catch (Exception ex) {
            UTIL_PageMessages.addExceptionMessage(ex);
            // This pushes it up a custom error mesasge to the client so we can handle it there.
            // We're going to prevent finalization of a configuration if we cannot actually add
            // any of the additional BoM to the quote.
            throw new AuraHandledException(ex.getMessage());
        } finally {
            logger.exit();
        }

        return UTIL_Aura.createResponse(addedProductIdsQuantity);
    }

    public class ProductModel
    {
        @AuraEnabled public String materialNumber { get; set; }
        @AuraEnabled public Decimal quantity { get; set; }
    }

    @testVisible
    /// Compares the list of materials to be added to a cpq quote with the list of products in the pricebook
    /// Returns the material numbers of any products that aren't found in the pricebook.
    private static Map<String, ProductModel> validateProductsInPricebook(
        Id pricebookId, List<string> addedMaterials, 
        Map<Id, PriceBookEntry> availableEntries, Map<String, List<Decimal>> materialsQuantity)
    {
        Set<string> materialsToAdd = new Set<string>(addedMaterials);
        Map<string,string> validMaterials = new Map<string,string>();
        Map<String, String> materialDescription = new Map<String, String>();        
        if (null == globalObjects) globalObjects = Schema.getGlobalDescribe();

        // a duplicate value in the pricebook means that there are 2 products with the same name active in the pricebook
        // this may cause errors so it needs to be messaged out.
        List<string> pricebookValues = new List<string>();
        List<string> invalidPricebookValues = new List<string>();

        List<PricebookEntry> peList = availableEntries.values();
        Integer peTot = peList.size();
        for (Integer peCnt = 0 ; peCnt < peTot ; peCnt++)
        {
            PricebookEntry pe = peList[peCnt];
            string materialName = (String) pe.Product2.get(UTIL_SFProduct.MaterialFieldName);

            if(pricebookValues.contains(materialName))
            {
                invalidPricebookValues.add(materialName);
            }
            else
            {
                pricebookValues.add(materialName);
                materialsToAdd.remove(materialName);
                validMaterials.put(materialName, pe.Product2Id);
                materialDescription.put(materialName, pe.Product2.Description);
            }
        }
        
        string finalError = '';

        if (materialsToAdd.size() > 0)
        {
            finalError += ('Some of the products ' + String.join(new List<string>(materialsToAdd), ', ') + ' added to this quote either do not exist in the price book: ' + pricebookId 
                + ', the pricebook entry is inactive '
                + ', the pricebook itself is inactive '
                + ', the product is inactive, or the current user does not have permissions to access the product.');
        }

        if (invalidPricebookValues.size() > 0)
        {
            finalError += ('The following materials have more than one entry in the pricebook: '
                + String.join(invalidPricebookValues,', ')
                + '. Please cleaup pricebook: '
                + pricebookId + ' so that every material only has one entry.');
        }

        if (string.IsNotBlank(finalError))
        {
            throw new ENSX_Exceptions.SimulationException(finalError);
        }

        Map<String, ProductModel> response = new Map<String, ProductModel>();
        Boolean isDuplicateProductFound = false;
        Map<String, Integer> duplicateProductsCounter = new Map<String, Integer>();
        Integer matTot = addedMaterials.size();
        for (Integer matCnt = 0 ; matCnt < matTot ; matCnt++)
        {
            string materialNumber = addedMaterials[matCnt];
            String productId = validMaterials.get(materialNumber);
            List<Decimal> quantities = materialsQuantity.get(materialNumber);
            if (response.containsKey(productId)) 
            {
                isDuplicateProductFound = true;
                Integer counter = duplicateProductsCounter.get(materialNumber);
                duplicateProductsCounter.put(materialNumber, counter == null ? 1 : counter + 1);
            }
            else 
            {
                ProductModel newProdModel = new ProductModel();
                newProdModel.materialNumber = materialNumber;
                newProdModel.quantity = quantities.get(0);
                response.put(productId, newProdModel);

                quantities.remove(0);
                materialsQuantity.put(materialNumber, quantities);
            }
        }
        
        if (isDuplicateProductFound)
        {
            // We cannot add the same Product Id in the Product Feature
            // Need to add a placeholder product for that material
            List<String> dupList = new List<String>(duplicateProductsCounter.keySet());
            Integer dupTot = dupList.size();
            for (Integer dupCnt = 0 ; dupCnt < dupTot ; dupCnt++)
            {
                String materialNumber = dupList[dupCnt];
                addPlaceholderProduct(response, materialNumber, materialDescription.get(materialNumber), 
                    pricebookId, duplicateProductsCounter.get(materialNumber), materialsQuantity.get(materialNumber));
            }            
        }

        return response;
    }

    @testVisible
    private static void addPlaceholderProduct(Map<String, ProductModel> response, String materialNumber, 
        String materialDescription, Id pricebookId, Integer counter, List<Decimal> quantities)
    {
        List<Product2> prods = new List<Product2>();
        Set<String> prodNames = new Set<String>();
        Map<String, Product2> newProdsMap = new Map<String, Product2>();
        
        for (Integer i = 1; i <= counter; i++)
        {
            prodNames.add(materialNumber + ' (' + i + ')');
        }

        prods = Database.query('SELECT Id, Name, ' + UTIL_SFProduct.MaterialFieldName + ' FROM Product2 WHERE Name IN :prodNames');

        Set<String> prodIds = new Set<String>();
        List<PricebookEntry> newPbEntries = new List<PricebookEntry>();
        List<Product2> newProds = new List<Product2>();
        Id standardPricebookId = UTIL_Pricebook.getStandardPriceBookId();

        Integer prodTot = prods.size();
        for (Integer prodCnt = 0 ; prodCnt < prodTot ; prodCnt++)
        {
            Product2 prod = prods[prodCnt];
            prodIds.add(prod.Id);
            newProdsMap.put(prod.Id, prod);
            if (prodNames.contains(prod.Name))
            {
                prodNames.remove(prod.Name);
            }
        }

        List<String> pnList = new List<String>(prodNames);
        Integer pnTot = pnList.size();
        for (Integer pnCnt = 0 ; pnCnt < pnTot ; pnCnt++)
        {
            String prodName = pnList[pnCnt];
            Product2 newProduct = new Product2();
            newProduct.Name = prodName;
            newProduct.Description = materialDescription;
            newProduct.put(UTIL_SFProduct.MaterialFieldName, prodName);
            newProduct.IsActive = true;
            if (null != globalObjects.get(cpqObject)) newProduct.put('SBQQ__Component__c', true);
            newProds.add(newProduct);
        }

        if (newProds.size() > 0)
        {
            insert newProds;
            prodIds.addAll(new Map<String, Product2>(newProds).keySet());

            // Insert standard Pricebook Id for the new Product
            prodTot = newProds.size();
            for (Integer prodCnt = 0 ; prodCnt < prodTot ; prodCnt++)
            {
                Product2 prod = newProds[prodCnt];
                newProdsMap.put(prod.Id, prod);
                PricebookEntry newPbe = new PricebookEntry();
                newPbe.isActive = true;
                newPbe.UnitPrice = 0;
                newPbe.UseStandardPrice = false;
                newPbe.Pricebook2Id = standardPricebookId;
                newPbe.Product2Id = prod.Id;
                newPbEntries.add(newPbe);
            }            
        }        

        List<String> pidList = new List<String>(prodIds);
        Integer pidTot = pidList.size();
        if (pidTot > 0 && pricebookId != standardPricebookId)
        {  
            List<PricebookEntry> pbEntries = 
                [SELECT Id, Product2Id FROM PricebookEntry WHERE Pricebook2Id = :pricebookId AND Product2Id IN :prodIds];

            Map<String, PricebookEntry> savedPbeMap = new Map<String, PricebookEntry>();
            Integer pbeTot = pbEntries.size();
            for (Integer pbeCnt = 0 ; pbeCnt < pbeTot ; pbeCnt++) savedPbeMap.put(pbEntries[pbeCnt].Product2Id, pbEntries[pbeCnt]);

            for (Integer pidCnt = 0 ; pidCnt < pidTot ; pidCnt++)
            {
                String prodId = pidList[pidCnt];
                if (!savedPbeMap.containsKey(prodId))
                {
                    PricebookEntry newPbe = new PricebookEntry();
                    newPbe.isActive = true;
                    newPbe.UnitPrice = 0;
                    newPbe.UseStandardPrice = false;
                    newPbe.Pricebook2Id = pricebookId;
                    newPbe.Product2Id = prodId;
                    newPbEntries.add(newPbe);
                }
            }
        }

        for (Integer pidCnt = 0 ; pidCnt < pidTot ; pidCnt++)
        {
            String prodId = pidList[pidCnt];
            Product2 prod = newProdsMap.get(prodId);
            ProductModel newProdModel = new ProductModel();
            newProdModel.materialNumber = (String) prod.get(UTIL_SFProduct.MaterialFieldName);
            newProdModel.quantity = quantities.get(0);
            response.put(prodId, newProdModel);
            
            quantities.remove(0);
        }

        if (newPbEntries.size() > 0) insert newPbEntries;
    }
}