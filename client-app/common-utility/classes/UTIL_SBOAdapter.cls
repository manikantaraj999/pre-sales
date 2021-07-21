public class UTIL_SBOAdapter
{
    // Filter the next that only needs to be shown on the view
    public static List<DS_Document_Detail.TEXTS> filterTexts(
        List<DS_Document_Detail.TEXTS> currentTexts, 
        List<DS_Document_Detail.TEXTS> textList,
        Map<String, String> textSettings)
    {
        Set<String> textIds = new Set<String>();
        if (currentTexts.isEmpty()) {
            addDefaultTexts(currentTexts, textSettings);
        }

        Integer textTot = currentTexts == null ? 0 : currentTexts.size();
        for (Integer textCnt = 0 ; textCnt < textTot ; textCnt++)
        {
            DS_Document_Detail.TEXTS currentText = currentTexts[textCnt];
            textIds.add(currentText.TextID);
        }

        Map<String, DS_Document_Detail.TEXTS> textIdValue = new Map<String, DS_Document_Detail.TEXTS>();
        textTot = textList == null ? 0 : textList.size();
        for (Integer textCnt = 0 ; textCnt < textTot ; textCnt++)
        {
            DS_Document_Detail.TEXTS text = textList[textCnt];
            if (textIds.contains(text.TextID)) {
                textIdValue.put(text.TextID, text);
            }
        }

        textTot = currentTexts.size();
        for (Integer textCnt = 0 ; textCnt < textTot ; textCnt++)
        {
            DS_Document_Detail.TEXTS currentText = currentTexts[textCnt];
            DS_Document_Detail.TEXTS text = textIdValue.get(currentText.TextID);
            if (text != null) {
                currentText.Text = text.Text;
                currentText.TextLanguage = text.TextLanguage;
            }
        }

        return currentTexts;
    }

    private static void addDefaultTexts(List<DS_Document_Detail.TEXTS> currentTexts, Map<String, String> defaultTexts)
    {
        List<String> keyList = new List<String>(defaultTexts.keySet());
        Integer keyTot = keyList.size();
        for (Integer keyCnt = 0 ; keyCnt < keyTot ; keyCnt++) 
        {
            String key = keyList[keyCnt];

            DS_Document_Detail.TEXTS newText = new DS_Document_Detail.TEXTS();
            newText.TextID = key;
            newText.TextIDDescription = defaultTexts.get(key);
            currentTexts.add(newText);
        }
    }

    // Get the list of Added Conditions from the SBO
    // Conditions that are marked 'C' in ConditionOrigin are manually added
    public static List<DS_Document_Detail.CONDITIONS> getAddedConditions(List<DS_Document_Detail.CONDITIONS> conditions)
    {
        List<DS_Document_Detail.CONDITIONS> addedConditions = new List<DS_Document_Detail.CONDITIONS>();

        Integer condTot = conditions.size();
        for (Integer condCnt = 0 ; condCnt < condTot ; condCnt++)
        {
            DS_Document_Detail.CONDITIONS condition = conditions[condCnt];
            if (condition.OriginOfCondition == 'C') {
                addedConditions.add(condition);
            }
        }

        return addedConditions;
    }

    // Filter the Partners that only needs to be shown on the view
    public static List<DS_Document_Detail.PARTNERS> filterPartners(
        List<DS_SalesDocAppSettings.PartnerSetting> appSettingPartners, 
        List<DS_Document_Detail.PARTNERS> objPartners,
        List<DS_Document_Detail.PARTNERS> partners)
    {
        if (objPartners == null) objPartners = new List<DS_Document_Detail.PARTNERS>();

        if (appSettingPartners != null) 
        {
            Integer appSettingTot = appSettingPartners.size();
            for (Integer appSettingCnt = 0; appSettingCnt < appSettingTot; appSettingCnt++) 
            {
                DS_SalesDocAppSettings.PartnerSetting partnerSetting = appSettingPartners[appSettingCnt];
                DS_Document_Detail.PARTNERS partner = UTIL_Document_Detail.getPartnerFromDocumentDetail(partners, partnerSetting.PartnerFunction, true);
                partner.PartnerFunctionName = partnerSetting.PartnerFunctionName;
                partner.ComponentType = partnerSetting.ComponentType;
                partner.SearchType = partnerSetting.SearchType;
                partner.autoSearch = partnerSetting.autoSearch;
                partner.allowSearch = partnerSetting.allowSearch;
                partner.allowAddressOverride = partnerSetting.allowAddressOverride;
                objPartners.add(partner);
            }
        }

        return objPartners;
    }
}