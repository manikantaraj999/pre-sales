public with sharing class DS_VCMaterialConfiguration extends ENSX_VCPricingConfiguration
{
    // extends ENSX_VCPricingConfiguration to get the block of properties required to populate the header of the VC object

    @AuraEnabled public List<SBO_EnosixVC_Detail.CHARACTERISTICS> characteristics;

    // Key: Characteristic Name
    // Value: All allowed values for that characterisitc
    @AuraEnabled public Map<string, List<SBO_EnosixVC_Detail.ALLOWEDVALUES>> indexedAllowedValues{get; set;}

    // Key: Characteristic Name
    // Value: All selected values for that characteristic
    @AuraEnabled public Map<string, List<SBO_EnosixVC_Detail.SELECTEDVALUES>> indexedSelectedValues{get; set;}

    public DS_VCMaterialConfiguration(SBO_EnosixVC_Detail.EnosixVC model)
    {
        try
        {
            System.debug('getConfigurationFromSBOModel');

            // Corollary of UTIL_VC_PricingAndConfiguration.applyPricingConfigurationToSBO
            // when you make a change here, also make the corresponding change there
            SBO_EnosixVC_Detail.EnosixVC sboConfig = model;
            DS_VCMaterialConfiguration pricingConfiguration = this;

            pricingConfiguration.ConfigDate = sboConfig.ConfigDate;

            pricingConfiguration.EnosixObjKey = sboConfig.getString('EnosixObjKey');

            pricingConfiguration.ConfigInstance = sboConfig.ConfigInstance;
            pricingConfiguration.ConfigurationInternal = sboConfig.ConfigurationInternal;
            pricingConfiguration.DistributionChannel = sboConfig.DistributionChannel;
            pricingConfiguration.Division = sboConfig.Division;
            pricingConfiguration.Material = sboConfig.Material;
            pricingConfiguration.ObjectKey = sboConfig.ObjectKey;
            pricingConfiguration.OrderQuantity = sboConfig.OrderQuantity;
            pricingConfiguration.Plant = sboConfig.Plant;
            pricingConfiguration.SalesDocumentCurrency = sboConfig.SalesDocumentCurrency;
            pricingConfiguration.SalesDocumentType = sboConfig.SalesDocumentType;
            pricingConfiguration.SalesOrganization = sboConfig.SalesOrganization;
            pricingConfiguration.SalesUnit = sboConfig.SalesUnit;
            pricingConfiguration.ShipToParty = sboConfig.ShipToParty;
            pricingConfiguration.SoldToParty = sboConfig.SoldToParty;

            this.MaterialDescription = getMaterialDescription(model.Material);
            this.ConfigurationIsValid = model.ConfigurationIsValid;

            this.characteristics = model.CHARACTERISTICS.getAsList();

            prepIndexedCollections(model);

            getAllowedValuesFromSBOModel(model);
            getSelectedValuesFromSBOModel(model);
        } catch(Exception e)
        {
            System.debug('Exception in DS_VCMaterialConfiguration = ' + e);
        }
    }

    public SBO_EnosixVC_Detail.EnosixVC convertToSBO(List<DS_VCCharacteristicValues> selectedValues)
    {
        SBO_EnosixVC_Detail.EnosixVC sbo = new SBO_EnosixVC_Detail.EnosixVC();
        try
        {
            UTIL_VC_PricingAndConfiguration.applyPricingConfigurationToSBO(sbo, this);

            if (null != this.indexedSelectedValues) {
                List<string> keyList = new List<string>(this.indexedSelectedValues.keySet());
                Integer keyTot = keyList.size();
                for (Integer keyCnt = 0 ; keyCnt < keyTot ; keyCnt++) {
                    string charKey = keyList[keyCnt];
                    List<SBO_EnosixVC_Detail.SELECTEDVALUES> valuesList = this.indexedSelectedValues.get(charKey);
                    Integer vTot = valuesList.size();
                    for (Integer vCnt = 0 ; vCnt < vTot ; vCnt++) {
                        SBO_EnosixVC_Detail.SELECTEDVALUES v = valuesList[vCnt];
                        sbo.SELECTEDVALUES.add(v);
                    }
                }
            }

            Integer svTot = selectedValues.size();
            for (Integer svCnt = 0 ; svCnt < svTot ; svCnt++) 
            {
                DS_VCCharacteristicValues selectedValue = selectedValues[svCnt];
                sbo.SELECTEDVALUES.add(selectedValue.getSBOASelectedValuesForModel());
            }

        }catch (exception e)
        {
            System.debug('error in convertToSBO is ' + e); 
        }
        return sbo;

    }

    // Pre-loads the indexed collections with empty lists of values for both allowed and selected options.
    @testVisible
    private void prepIndexedCollections(SBO_EnosixVC_Detail.EnosixVC vcMaterial)
    {
        try
        {
            indexedAllowedValues = new Map<string, List<SBO_EnosixVC_Detail.ALLOWEDVALUES>>();
            indexedSelectedValues = new Map<string, List<SBO_EnosixVC_Detail.SELECTEDVALUES>>();
            List<SBO_EnosixVC_Detail.CHARACTERISTICS> charList = vcMaterial.CHARACTERISTICS.getAsList();
            Integer charTot = charList.size();
            for (Integer charCnt = 0 ; charCnt < charTot ; charCnt++)
            {
                SBO_EnosixVC_Detail.CHARACTERISTICS characteristic = charList[charCnt];
                indexedAllowedValues.put(characteristic.CharacteristicName, new List<SBO_EnosixVC_Detail.ALLOWEDVALUES>());
                indexedSelectedValues.put(characteristic.CharacteristicName, new List<SBO_EnosixVC_Detail.SELECTEDVALUES>());
            }
        }catch (Exception e)
        {
            System.debug('Error in prepIndexedCollections is' + e);
        }

    }
 
    @testVisible
    private void getAllowedValuesFromSBOModel(SBO_EnosixVC_Detail.EnosixVC vcMaterial)
    {
        try
        {
            List<SBO_EnosixVC_Detail.ALLOWEDVALUES> avList = vcMaterial.ALLOWEDVALUES.getAsList();
            Integer avTot = avList.size();
            for (Integer avCnt = 0 ; avCnt < avTot ; avCnt++)
            {
                SBO_EnosixVC_Detail.ALLOWEDVALUES allowed = avList[avCnt];
                indexedAllowedValues.get(allowed.CharacteristicName).add(allowed);
            }
        } catch (Exception e)
        {
            System.debug('Exception in getAllowedValuesFromSBOModel=' + e);
        }
    }

    @testVisible
    private void getSelectedValuesFromSBOModel(SBO_EnosixVC_Detail.EnosixVC vcMaterial)
    {
        try
        {
            /// indexedSelectedValues is populated from a list of Characteristics 
            /// that have been passed back from SAP; 
            /// this method is intended to match SELECTEDVALUE with their 
            /// corresponding CHARACTERISTIC
            List<SBO_EnosixVC_Detail.SELECTEDVALUES> svList = vcMaterial.SELECTEDVALUES.getAsList();
            Integer svTot = svList.size();
            for (Integer svCnt = 0 ; svCnt < svTot ; svCnt++)
            {
                SBO_EnosixVC_Detail.SELECTEDVALUES selected = svList[svCnt];
                /// this is added to check to see if a given characteristic has had a selected value returned for it
                if (!indexedSelectedValues.containsKey(selected.CharacteristicName))
                {
                    indexedSelectedValues.put(selected.CharacteristicName, new List<SBO_EnosixVC_Detail.SELECTEDVALUES>());
                }
                indexedSelectedValues.get(selected.CharacteristicName).add(selected);
            }
        } catch (Exception e)
        {
            System.debug('Exception in getSelectedValuesFromSBOModel = ' + e);
        }
    }

    @testVisible
    private static String getMaterialDescription(String materialId) {
        if (materialId != null) {
            Integer startIndex = 0;
            while (startIndex < materialId.length()) {
                if (materialId.substring(startIndex,startIndex+1) != '0') {
                    break;
                }
                startIndex++;
            }
            String thisMaterialId = materialId.substring(startIndex);
            Product2 thisMaterial = UTIL_SFProduct.getProductByMaterialNumber(thisMaterialId, new List<String>{'Name'});

            if (thisMaterial != null) {
                return thisMaterial.Name;
            }
        }

        return '';
    }
}