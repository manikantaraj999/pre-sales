public with sharing class CTRL_VC_Characteristics_Detail {

    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_VC_Characteristics_Detail.class);

    @AuraEnabled
    public static UTIL_Aura.Response getVC_Characteristics_Detail(
        String AccountId, String quoteId, String itemId
    )
    {
        Object responseData = null;

        logger.enterAura('getVC_Characteristics_Detail', new Map<String,Object>{
            'accountId' => accountId,
            'quoteId' => quoteId,
            'itemId' => itemId
        });

        try
        {

            SBO_EnosixQuote_Detail.EnosixQuote quoteDetail = getQuoteDetail(quoteId);

            List<SBO_EnosixQuote_Detail.ITEMS_CONFIG> itemsConfig = quoteDetail.ITEMS_CONFIG.getAsList();
            List<SBO_EnosixQuote_Detail.ITEMS_CONFIG> selectedItems = new List<SBO_EnosixQuote_Detail.ITEMS_CONFIG>();
            List<SBO_EnosixQuote_Detail.ITEMS_CONFIG> displayedItems = new List<SBO_EnosixQuote_Detail.ITEMS_CONFIG>();

            Integer configTot = itemsConfig.size();
            for (Integer configCnt = 0 ; configCnt < configTot ; configCnt++)
            {
                SBO_EnosixQuote_Detail.ITEMS_CONFIG config = itemsConfig[configCnt];
                if(config.ItemNumber == itemId)
                {
                    selectedItems.add(config);
                }
            }

            //get material number
            List<SBO_EnosixQuote_Detail.ITEMS> theseItems = quoteDetail.ITEMS.getAsList();
            SBO_EnosixQuote_Detail.ITEMS thisItem = new SBO_EnosixQuote_Detail.ITEMS();

            Integer itemTot = theseItems.size();
            for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
            {
                SBO_EnosixQuote_Detail.ITEMS item = theseItems[itemCnt];
                if(item.ItemNumber == itemId)
                {
                    thisItem = item;
                }
            }

            // our selected items need to be formatted as a list of DS_VCCharacteristicValues
            List<DS_VCCharacteristicValues> convertedList = convertTo_CharacteristicValues(selectedItems);
            SBO_EnosixVC_Detail.EnosixVC config = new SBO_EnosixVC_Detail.EnosixVC();
            config.Material = thisItem.Material;

            DS_VCMaterialConfiguration materialConfig = proccessAndLogVCConfiguration(config, convertedList);

            List<SBO_EnosixVC_Detail.CHARACTERISTICS> itemCharacteristics = materialConfig.characteristics;

            Integer siTot = selectedItems.size();
            Integer icTot = itemCharacteristics.size();
            for (Integer siCnt = 0 ; siCnt < siTot ; siCnt++)
            {
                SBO_EnosixQuote_Detail.ITEMS_CONFIG item = selectedItems[siCnt];
                String CharName = item.CharacteristicName;
                for (Integer icCnt = 0 ; icCnt < icTot ; icCnt++)
                {
                    SBO_EnosixVC_Detail.CHARACTERISTICS thisChar = itemCharacteristics[icCnt];
                    if(thisChar.CharacteristicName == CharName && thisChar.NotToBeDisplayed != 'X')
                    {
                        displayedItems.add(item);
                    }
                }

            }

            responseData = displayedItems;

        } 
        catch (Exception ex) { UTIL_PageMessages.addExceptionMessage(ex); }
        finally
        {
            logger.exit();
        }

        return UTIL_Aura.createResponse(responseData);
    }

    /// This is the internal method that handles calling to SAP during processing of configuration.
    @TestVisible
    private static DS_VCMaterialConfiguration proccessAndLogVCConfiguration(
        SBO_EnosixVC_Detail.EnosixVC sboCFG
        , List<DS_VCCharacteristicValues> selectedValues)
    {
        logger.enterAura('proccessAndLogVCConfiguration', new Map<String, Object> {
            'sboCFG' => sboCFG
            , 'selectedValues' => selectedValues
        });
        try {

            Integer svTot = selectedValues.size();
            for (Integer svCnt = 0 ; svCnt < svTot ; svCnt++)
            {
                DS_VCCharacteristicValues selectedValue = selectedValues[svCnt];
                sboCFG.SELECTEDVALUES.add(selectedValue.getSBOASelectedValuesForModel());
            }

            SBO_EnosixVC_Detail sbo = new SBO_EnosixVC_Detail();

            sboCFG = sbo.command('CMD_INITIALIZE_FROM_DATA', sboCFG);

            return new DS_VCMaterialConfiguration(sboCFG);

        } catch (Exception ex) {
            logger.log(LoggingLevel.ERROR, 'There was an exception thrown when attempting to process configuration', ex);
            //THIS NEEDS TO BE UDPATED SO IT DISPLAYS ON THE PAGE
            //UTIL_PageMessages.addExceptionMessage(ex);
        } finally {
            logger.exit();
        }
        //return UTIL_Aura.createResponse(responseData);
        return null;
    }
    @TestVisible
    private static List<DS_VCCharacteristicValues> convertTo_CharacteristicValues(List<SBO_EnosixQuote_Detail.ITEMS_CONFIG> selectedItems)
    {
        List<DS_VCCharacteristicValues> convertedList = new List<DS_VCCharacteristicValues>();

        try
        {
            Integer siTot = selectedItems.size();
            for (Integer siCnt = 0 ; siCnt < siTot ; siCnt++)
            {
                SBO_EnosixQuote_Detail.ITEMS_CONFIG item = selectedItems[siCnt];
                DS_VCCharacteristicValues newCV = new DS_VCCharacteristicValues();
                newCV.CharacteristicID = item.CharacteristicID;
                newCV.CharacteristicName = item.CharacteristicName;
                newCV.CharacteristicValue = item.CharacteristicValue;
                newCV.CharacteristicValueDescription = item.CharacteristicValueDescription;
                newCV.UserModified = true;

                convertedList.add(newCV);
            }
        } catch (Exception e)
        {
            UTIL_PageMessages.addExceptionMessage(e);
        }

        return convertedList;
    }

    private static SBO_EnosixQuote_Detail.EnosixQuote getQuoteDetail(string quoteId)
    {
        SBO_EnosixQuote_Detail sbo = new SBO_EnosixQuote_Detail();
        SBO_EnosixQuote_Detail.EnosixQuote quoteDetail = new SBO_EnosixQuote_Detail.EnosixQuote();

        try 
        {
            quoteDetail = sbo.getDetail(quoteId);
        } 
        catch (Exception e) 
        {
            logger.error(e);
        }

        return quoteDetail;
    }

}