public inherited sharing class UTIL_VC_Perf {
     public static Map<String, String> RunConfiguration(ENSX_VCPricingConfiguration pricingConfig, Map<String, String> values) {
        System.assertNotEquals(null, pricingConfig, 'pricingConfig required');
        System.assertNotEquals(null, values, 'values required');
        
         Map<String, Long> processsTimes = new Map<String, Long>();

        Long startTime = SW();

        DS_VCMaterialConfiguration initialConfig = UTIL_VC_PricingAndConfiguration.getInitialConfigFromMaterialAndPricingAndCustomConfig(pricingConfig.Material, pricingConfig);

        //System.debug(initialConfig);
        List<DS_VCCharacteristicValues> selectedValues = new List<DS_VCCharacteristicValues>();
        List<String> charactoristics = new List<String>();
       
        List<string> keyList = new List<string>(values.keySet());
        Integer keyTot = keyList.size();
        Integer charTot = initialConfig.characteristics.size();
        for (Integer keyCnt = 0 ; keyCnt < keyTot ; keyCnt++) {
            string key = keyList[keyCnt];
            DS_VCCharacteristicValues addedValue = null;

            for (Integer charCnt = 0 ; charCnt < charTot ; charCnt++) {
                SBO_EnosixVC_Detail.CHARACTERISTICS c = initialConfig.characteristics[charCnt];
                if (key == c.CharacteristicName || key == c.CharacteristicDescription) {
                    charactoristics.add(c.CharacteristicName);
                }
            }
        }

        Long valuesStart = SW();
        initialConfig = UTIL_VC_PricingAndConfiguration.proccessAndLogVCConfiguration(initialConfig, selectedValues, charactoristics);
        Long valuesEnd = SW();
        processsTimes.put('LoadAllowValues'+charactoristics.size(), valuesEnd - valuesStart);

        for (Integer keyCnt = 0 ; keyCnt < keyTot ; keyCnt++) {
            string key = keyList[keyCnt];
            string value = values.get(key);
            DS_VCCharacteristicValues addedValue = CreateValueForCharAndValue(initialConfig, key, value);
            selectedValues = new List<DS_VCCharacteristicValues>{ addedValue };
            
            if (null == addedValue) {
                system.debug('Could not add characteristic (' + key + ') value ' + value);
            }

            //System.assertNotEquals(null, addedValue, 'Could not add characteristic (' + key + ') value ' + value);

            Long configStart = SW();
            DS_VCMaterialConfiguration newConfig = UTIL_VC_PricingAndConfiguration.proccessAndLogVCConfiguration(initialConfig, selectedValues, charactoristics);
            Long configEnd = SW();
            processsTimes.put(key, configEnd - configStart);

            //AssertSelectedValueSet(newConfig, key, value);
            
            initialConfig = newConfig; // Commit
        }

        Long endTime = SW();

        Map<String, String> result = new Map<String, String>{
            'TotalTime' => (endTime - startTime) + 'ms'
            //,'SessionData' => UTIL_VC_PricingAndConfiguration.SessionData
        };
        Long Sum = 0;
        keyList = new List<string>(processsTimes.keySet());
        keyTot = keyList.size();
        for (Integer keyCnt = 0 ; keyCnt < keyTot ; keyCnt++) {
            string key = keyList[keyCnt];
            result.put(key+'_Time', processsTimes.get(key)+'ms');
            Sum += processsTimes.get(key);
        }

        result.put('Avg_Time', (Sum / Math.Max(1, processsTimes.size()) )+'ms');

        return result;
    }

    private static Long SW() { return datetime.now().getTime(); }

    @testVisible
    private static DS_VCCharacteristicValues CreateValueForCharAndValue(DS_VCMaterialConfiguration initialConfig, string key, string value) {

        Integer charTot = initialConfig.characteristics.size();
        for (Integer charCnt = 0 ; charCnt < charTot ; charCnt++) {
            SBO_EnosixVC_Detail.CHARACTERISTICS c = initialConfig.characteristics[charCnt];
            if (key == c.CharacteristicName || key == c.CharacteristicDescription) {
                List<SBO_EnosixVC_Detail.ALLOWEDVALUES> avList = initialConfig.indexedAllowedValues.get(c.CharacteristicName);
                Integer avTot = avList.size();
                for (Integer avCnt = 0 ; avCnt < avTot ; avCnt++)  {
                    SBO_EnosixVC_Detail.ALLOWEDVALUES av = avList[avCnt];
                    if(value == av.CharacteristicValueDescription || value == av.CharacteristicValue) {
                        return CreateValueFromCharAndValue(c, av);
                    }
                }
                return CreateValueFromCharAndValue(c, value);
            }
        }

        return null;
    }

    private static DS_VCCharacteristicValues CreateValueFromCharAndValue(SBO_EnosixVC_Detail.CHARACTERISTICS c, string value) {
        DS_VCCharacteristicValues result = new DS_VCCharacteristicValues();
        result.CharacteristicID = c.CharacteristicID; 
        result.CharacteristicValue = value;
        result.CharacteristicName = c.CharacteristicName;
        result.UserModified = true;
        return result;
    }

    private static DS_VCCharacteristicValues CreateValueFromCharAndValue(SBO_EnosixVC_Detail.CHARACTERISTICS c, SBO_EnosixVC_Detail.ALLOWEDVALUES av) {
        DS_VCCharacteristicValues result = new DS_VCCharacteristicValues();
        result.CharacteristicID = c.CharacteristicID; 
        result.CharacteristicValue = av.CharacteristicValue;
        result.CharacteristicName = av.CharacteristicName;
        result.CharacteristicValueDescription = av.CharacteristicValueDescription;
        result.UserModified = true;
        return result;
    }

    @testVisible
    private static void AssertSelectedValueSet(DS_VCMaterialConfiguration newConfig, string key, string value) {
        List<SBO_EnosixVC_Detail.SELECTEDVALUES> indexedSelectedValues = newConfig.indexedSelectedValues.get(key);

        System.assert(indexedSelectedValues.size() > 0, 'Value Not Set in result from process ' + key);
        if (null != indexedSelectedValues) {
            Integer svTot = indexedSelectedValues.size();
            for (Integer svCnt = 0 ; svCnt < svTot ; svCnt++) {
                SBO_EnosixVC_Detail.SELECTEDVALUES v = indexedSelectedValues[svCnt];
                System.debug('Value '+ v.CharacteristicValueDescription + '(' + v.CharacteristicValue + ') selected for ' + key);
            }
        }
    }
}
