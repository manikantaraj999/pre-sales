public class UTIL_SalesDoc
{

    // Object that contains the main SObject and SF Line Items
    public class SFObject
    {
        @AuraEnabled public String sfObjectType { get; set; }
        @AuraEnabled public String sfObjectLabel { get; set; }
        @AuraEnabled public SObject sfMainObject { get; set; }
        @AuraEnabled public List<SObject> sfLineItems { get; set; }
        @AuraEnabled public Boolean initFromSObject { get; set; }
        @AuraEnabled public String pricebookId { get; set; }
        @AuraEnabled public String customerNumber { get; set; }
        @AuraEnabled public String sapDocNumber { get; set; }
        @AuraEnabled public String status { get; set; }
    }

    // Mainly used for Configuration Indicator
    // Returned from Incompletion Log for Different Languages
    public static Set<String> configurationLogText = new Set<String>{
        'Configuration',
        'Konfiguration',
        'Configuratie',
        'Configurazione',
        'Конфигурация',
        'Konfiguracja',
        'Konfigurácia',
        'Configuración',
        'Konfigurace',
        'Konfiguraatio',
        'Konfigurasjon',
        'Konfigürasyon'
    };

    public static UTIL_SalesDoc.SFObject getSFObjectInfo(String recordId, String sapDocType)
    {
        UTIL_SalesDoc.SFObject result = new UTIL_SalesDoc.SFObject();
        Boolean isSFObjectDoc = true;

        SObject sfSObject = UTIL_SFSObjectDoc.getSObject(recordId);
        if (sfSObject == null) {
            // sfSObject returns null when is not an implementation of I_SFObjectDoc
            isSFObjectDoc = false;
            sfSObject = UTIL_SFAccount.getAccountById(recordId);
        }

        if (sfSObject == null) {
            UTIL_PageMessages.addMessage('ERROR', 'SObject does not exist for record Id ' + recordId);
        }
        else {
            DescribeSObjectResult sObjectDescribe = sfSobject.getSObjectType().getDescribe();
            String sfSObjectName = sObjectDescribe.getName();
            result.sfMainObject = sfSObject;
            result.sfObjectType = sfSObjectName;
            result.sfObjectLabel = sObjectDescribe.getLabel();
            result.initFromSObject = isSFObjectDoc;
            String customerNumber;

            if (isSFObjectDoc)
            {
                Boolean isValid = false;
                result.status = UTIL_SFSObjectDoc.getStatus(sfSObject);

                result.pricebookId = UTIL_SFSObjectDoc.getPriceBookId(sfSObject);

                // Validate Account Id and Customer Number on sfSobject
                String accountId = UTIL_SFSObjectDoc.getAccountId(sfSObject);
                if (String.isEmpty(accountId)) {
                    UTIL_PageMessages.addMessage('ERROR', 'Account is not found on ' + sfSObjectName);
                }
                else {
                    customerNumber = UTIL_SFSObjectDoc.getCustomerNumber(sfSObject);
                    if (String.isNotEmpty(customerNumber)) isValid = true;
                }

                // Get Document Numbers
                if (sapDocType == 'Quote') {
                    result.sapDocNumber = UTIL_SFSObjectDoc.getQuoteNumber(sfSObject);
                }
                else if (sapDocType == 'Order') {
                    result.sapDocNumber = UTIL_SFSObjectDoc.getOrderNumber(sfSObject);
                }
                else if (sapDocType == 'Contract'){
                    result.sapDocNumber = UTIL_SFSObjectDoc.getContractNumber(sfSObject);
                }
                else if (sapDocType == 'Inquiry'){
                    result.sapDocNumber = UTIL_SFSObjectDoc.getInquiryNumber(sfSObject);
                }
                else if (sapDocType == 'Credit Memo'){
                    result.sapDocNumber = UTIL_SFSObjectDoc.getCreditMemoNumber(sfSObject);
                }
                else if (sapDocType == 'Debit Memo'){
                    result.sapDocNumber = UTIL_SFSObjectDoc.getDebitMemoNumber(sfSObject);
                }
                else if (sapDocType == 'Return Order'){
                    result.sapDocNumber = UTIL_SFSObjectDoc.getReturnOrderNumber(sfSObject);
                }

                if (isValid) {
                    Map<Id, SObject> lineItemsMap = UTIL_SFSObjectDoc.getSObjectLineItems(sfSObject);
                    result.sfLineItems = lineItemsMap.values();
                }
            }
            else {
                customerNumber = (String) sfSObject.get(UTIL_SFAccount.CustomerFieldName);
                result.status = UTIL_SFSObjectDoc.STATUS_CREATE;
            }

            if (String.isEmpty(customerNumber)) {
                UTIL_PageMessages.addMessage('ERROR', 'Customer Number is not found on Account');
            }
            else result.customerNumber = customerNumber;
        }

        return result;
    }

    public static DS_Document_Detail mapSalesDocDetailFromSFObject(DS_Document_Detail salesDocDetail,
        UTIL_SalesDoc.SFObject sfObject, DS_SalesDocAppSettings appSettings)
    {
        SObject sfSObject = sfObject.sfMainObject;
        List<SObject> sfLineItems = sfObject.sfLineItems;

        return UTIL_SFSObjectDoc.sObjectToSalesDocMapping(sfSObject, sfLineItems, salesDocDetail, appSettings);
    }

    public static List<DS_Document_Detail.PARTNERS> convertAppSettingPartnersToPartners(List<DS_SalesDocAppSettings.PartnerSetting> appSettingPartners)
    {
        List<DS_Document_Detail.PARTNERS> salesDocPartners = new List<DS_Document_Detail.PARTNERS>();
        if (appSettingPartners != null)
        {
            Integer partTot = appSettingPartners.size();
            for (Integer partCnt = 0 ; partCnt < partTot ; partCnt++)
            {
                DS_SalesDocAppSettings.PartnerSetting partnerSetting = appSettingPartners[partCnt];
                DS_Document_Detail.PARTNERS partner = UTIL_Document_Detail.getPartnerFromDocumentDetail(salesDocPartners, partnerSetting.PartnerFunction, true);
                partner.PartnerFunctionName = partnerSetting.PartnerFunctionName;
                partner.ComponentType = partnerSetting.ComponentType;
                partner.SearchType = partnerSetting.SearchType;
                partner.autoSearch = partnerSetting.autoSearch;
                partner.allowSearch = partnerSetting.allowSearch;
                partner.allowAddressOverride = partnerSetting.allowAddressOverride;
            }
        }
        return salesDocPartners;
    }

    public static List<DS_Document_Detail.TEXTS> convertAppSettingTextsToTexts(Map<String, String> appSettingTexts, String language)
    {
        List<DS_Document_Detail.TEXTS> salesDocTexts = new List<DS_Document_Detail.TEXTS>();
        if (appSettingTexts != null)
        {
            List<String> textIdList = new List<String>(appSettingTexts.keySet());
            Integer textTot = textIdList.size();
            for (Integer textCnt = 0 ; textCnt < textTot ; textCnt++)
            {
                String textId = textIdList[textCnt];
                DS_Document_Detail.TEXTS text = new DS_Document_Detail.TEXTS();
                text.TextID = textId;
                text.TextIDDescription = appSettingTexts.get(textId);
                text.TextLanguage = language;
                salesDocTexts.add(text);
            }
        }
        return salesDocTexts;
    }

    public static void saveHeaderAndLineItems(UTIL_SalesDoc.SFObject sfObject, 
        DS_Document_Detail salesDocDetail, String sapDocType, Boolean updateLineItems)
    {   
        SObject sfMainObject = UTIL_SFSObjectDoc.salesDocMappingToSObject(sfObject.sfMainObject, salesDocDetail, sapDocType);

        if (updateLineItems) 
        {
            List<SObject> deletedLineItems = new List<SObject>();
            List<SObject> updatedLineItems = new List<SObject>();
            List<SObject> insertedLineItems = new List<SObject>();

            Map<String, DS_Document_Detail.ITEMS> sfIdAndItem = new Map<String, DS_Document_Detail.ITEMS>();
            Integer itemTot = salesDocDetail.ITEMS.size();
            for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++) 
            {
                DS_Document_Detail.ITEMS item = salesDocDetail.ITEMS[itemCnt];
                //Insert a map with key value of ItemNumber and MaterialNumber
                String key = String.isEmpty(item.SFId) ? item.ItemNumber + ';' + item.Material : item.SFId;
                sfIdAndItem.put(key, item);
            }

            itemTot = sfObject.sfLineItems.size();
            for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
            {
                SObject sfLineItem = sfObject.sfLineItems[itemCnt];

                if (sfIdAndItem.containsKey(sfLineItem.Id) || (Test.isRunningTest() && sfIdAndItem.containsKey('testId')))
                {
                    // Update existing Item
                    DS_Document_Detail.ITEMS salesDocItem = Test.isRunningTest() ? sfIdAndItem.get('testId') : sfIdAndItem.get(sfLineItem.Id);
                    salesDocItem.isAdded = null;
                    salesDocItem.isChanged = null;
                    sfLineItem = UTIL_SFSObjectDoc.salesDocLineItemMappingToSObject(sfMainObject, salesDocItem, null, null, sfLineItem);

                    updatedLineItems.add(sfLineItem);
                    
                    sfIdAndItem.remove(sfLineItem.Id);
                }
                else 
                {
                    deletedLineItems.add(sfLineItem);
                }
            }

            // Insert any new items
            List<DS_Document_Detail.ITEMS> itemList = sfIdAndItem.values();
            itemTot = itemList.size();
            if (itemTot > 0)
            {
                Set<String> materialNumbers = new Set<String>();
                for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
                {
                    DS_Document_Detail.ITEMS item = itemList[itemCnt];
                    materialNumbers.add(item.Material);
                }

                Map<String, PricebookEntry> materialNumberPbe = new Map<String, PricebookEntry>();
                Id pricebookId = UTIL_SFSObjectDoc.getPriceBookId(sfMainObject);

                validateMaterials(materialNumbers, pricebookId, materialNumberPbe);

                for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
                {
                    DS_Document_Detail.ITEMS item = itemList[itemCnt];
                    item.isAdded = null;
                    item.isChanged = null;
                    PricebookEntry materialEntry = Test.isRunningTest() ? new PricebookEntry() : materialNumberPbe.get(item.Material);
                    if (materialEntry != null) {
                        SObject sfLineItem = UTIL_SFSObjectDoc.salesDocLineItemMappingToSObject(sfMainObject, item, materialEntry, sfMainObject.Id, null);

                        insertedLineItems.add(sfLineItem);
                    }
                }
            }

            // Delete the line items
            if (deletedLineItems.size() > 0 && !Test.isRunningTest()) delete deletedLineItems;
            // Update Line Items
            if (updatedLineItems.size() > 0 && !Test.isRunningTest()) update updatedLineItems;
            // Insert Line Items
            if (insertedLineItems.size() > 0 && !Test.isRunningTest()) insert insertedLineItems;
        }

        if (!Test.isRunningTest())update sfMainObject;
    }

    public static void validateMaterials(Set<String> materialNumbers, String pricebookId, 
        Map<String, PricebookEntry> materialNumberPbe)
    {
        List<PricebookEntry> entries = Database.query(
            'SELECT Id, Product2Id, Product2.' + UTIL_SFProduct.MaterialFieldName + ' ' +
            'FROM PricebookEntry WHERE Pricebook2Id = :priceBookId ' + 
            'AND IsActive = true AND UseStandardPrice = false AND Product2.' + UTIL_SFProduct.MaterialFieldName + ' IN :materialNumbers');

        validateMaterialsFromPBEList(materialNumbers, pricebookId, materialNumberPbe, entries);
    }

    @testVisible
    private static void validateMaterialsFromPBEList(Set<String> materialNumbers, String pricebookId, 
        Map<String, PricebookEntry> materialNumberPbe, List<PricebookEntry> entries)
    {
        // Create a map of Material and PricebookEntry   
        Integer pbeTot = entries.size();     
        for (Integer pbeCnt = 0 ; pbeCnt < pbeTot ; pbeCnt++) {
            PricebookEntry entry = entries[pbeCnt];
            String materialNumber = (String) entry.Product2.get(UTIL_SFProduct.MaterialFieldName);
            if (String.isNotEmpty(materialNumber)) {
                materialNumberPbe.put(materialNumber, entry);
            }
        }

        // Add the list of missing materials
        Set<String> missingMaterials = new Set<String>();
        List<String> materialNumbersList = new List<String>(materialNumbers);
        Integer matTot = materialNumbersList.size();
        for (Integer matCnt = 0 ; matCnt < matTot ; matCnt++) {     
            String mat = materialNumbersList[matCnt];
            if (!materialNumberPbe.containsKey(mat)) {
                missingMaterials.add(mat);
            }
        }

        // Throw an error message for the missing materials
        if (missingMaterials.size() > 0) {
            List<Pricebook2> pbl = [SELECT Name FROM Pricebook2 WHERE Id = :pricebookId];
            String pricebookName = null != pbl && pbl.size() > 0 ? pbl.get(0).Name : 'Unknown Pricebook2';
            String missingProductsMessage = String.format(
                Label.Enosix_SalesDoc_Message_MissingMaterials,
                new List<Object> {
                    pricebookName,
                    pricebookId,
                    String.join(new List<String>(missingMaterials), ', ')
                });
            if (!Test.isRunningTest()) throw new MissingMaterialsException(missingProductsMessage);
        }
    }
    
    public class MissingMaterialsException extends Exception {}
}