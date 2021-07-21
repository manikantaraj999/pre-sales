public class UTIL_SalesDocument_Detail implements I_Document_Detail
{
    private DS_SalesDocAppSettings appSettings;

    public String getSimulateCommand()
    {
        return 'CMD_SIMULATE_DOCUMENT';
    }

    public String getReferenceDocumentCommand()
    {
        return 'CMD_FILL_REF_DOC_DETAILS';
    }

    public ensxsdk.EnosixFramework.DetailObject removeAllConditions(ensxsdk.EnosixFramework.DetailObject detailObj)
    {
        SBO_EnosixSalesDocument_Detail.EnosixSalesDocument sboObject = (SBO_EnosixSalesDocument_Detail.EnosixSalesDocument) detailObj;
        sboObject.CONDITIONS.clear();
        return sboObject;
    }

    // Update the SBO Header and Item Text Fields
    // Mainly use after simulation before update so it can keep any line breaks in the text
    public ensxsdk.EnosixFramework.DetailObject updateTextFields(ensxsdk.EnosixFramework.DetailObject detailObj, DS_Document_Detail docObj)
    {
        SBO_EnosixSalesDocument_Detail.EnosixSalesDocument sboObject = (SBO_EnosixSalesDocument_Detail.EnosixSalesDocument) detailObj;
        mapHeaderTextsToSBOForUpdate(sboObject, docObj);

        Integer itemsTot = docObj.ITEMS.size();
        List<SBO_EnosixSalesDocument_Detail.ITEMS_TEXT> sboItemTextList = sboObject.ITEMS_TEXT.getAsList();
        Integer sboItemTextsTot = sboItemTextList.size();

        for (Integer itemCnt = 0; itemCnt < itemsTot; itemCnt++)
        {
            DS_Document_Detail.ITEMS item = docObj.ITEMS[itemCnt];
            if (item.isChanged == true || item.isAdded == true)
            {                
                Integer itemTextsTot = item.ItemTexts.size();                
                for (Integer itemTextCnt = 0; itemTextCnt < itemTextsTot; itemTextCnt++)
                {
                    DS_Document_Detail.TEXTS itemText = item.ItemTexts[itemTextCnt];
                    for (Integer sboItemTextCnt = 0; sboItemTextCnt < sboItemTextsTot; sboItemTextCnt++)
                    {
                        SBO_EnosixSalesDocument_Detail.ITEMS_TEXT sboItemText = sboItemTextList[sboItemTextCnt];
                        if (item.ItemNumber == sboItemText.ItemNumber && itemText.TextID == sboItemText.TextID) {
                            sboItemText.Text = itemText.Text;
                            sboItemText.TextLanguage = itemText.TextLanguage;
                            break;
                        }  
                    }
                }
            }
        } 

        return sboObject;
    }

    public ensxsdk.EnosixFramework.DetailObject buildSBOForReference(String salesDocNumber, String salesDocType)
    {
        SBO_EnosixSalesDocument_Detail.EnosixSalesDocument sboObject = new SBO_EnosixSalesDocument_Detail.EnosixSalesDocument();

        sboObject.ORDER_ACTION.ReferenceFlag = true;
        sboObject.ORDER_ACTION.ReferenceDocumentNumber = salesDocNumber;
        sboObject.ORDER_ACTION.ReferenceDocumentType = salesDocType;

        return sboObject;
    }


    // #region Convert to SBO Mapping

    // Implementation of Converting DS_Document_Detail to SBO Detail Object
    // This conversion is needed before sending the request to SAP
    public ensxsdk.EnosixFramework.DetailObject convertToSBO(ensxsdk.EnosixFramework.DetailObject detailObj, 
        DS_Document_Detail docObj, Boolean isUpdate, DS_SalesDocAppSettings appSettings)
    {
        this.appSettings = appSettings;
        SBO_EnosixSalesDocument_Detail.EnosixSalesDocument sboObject;

        if (detailObj == null) sboObject = new SBO_EnosixSalesDocument_Detail.EnosixSalesDocument();
        else sboObject = (SBO_EnosixSalesDocument_Detail.EnosixSalesDocument) detailObj;

        mapHeaderFieldsToSBO(sboObject, docObj);

        if (isUpdate) {
            
            mapPartnersToSBOForUpdate(sboObject, docObj.PARTNERS, null);
            mapHeaderTextsToSBOForUpdate(sboObject, docObj);
            mapHeaderConditionsToSBOForUpdate(sboObject, docObj);
            removedItemsForUpdate(sboObject, docObj);
            mapItemsForUpdate(sboObject, docObj);
        }
        else {       

            // PARTNERS
            if (String.isNotEmpty(docObj.SoldToParty)) 
            {
                sboObject.SoldToParty = docObj.SoldToParty;
                SBO_EnosixSalesDocument_Detail.PARTNERS newPartner = new SBO_EnosixSalesDocument_Detail.PARTNERS();
                newPartner.PartnerFunction = UTIL_Customer.SOLD_TO_PARTNER_CODE;
                newPartner.CustomerNumber = docObj.SoldToParty;
                sboObject.PARTNERS.add(newPartner);
            }
            Integer partTot = docObj.PARTNERS.size();
            for (Integer partCnt = 0 ; partCnt < partTot ; partCnt++)
            {            
                DS_Document_Detail.PARTNERS partner = docObj.PARTNERS[partCnt];
                SBO_EnosixSalesDocument_Detail.PARTNERS sboPartner = createNewPartnerSBO(partner, null);
                if (sboPartner != null) sboObject.PARTNERS.add(sboPartner);                
            }

            // CONDITIONS
            Integer condTot = docObj.CONDITIONS == null ? 0 : docObj.CONDITIONS.size();
            for (Integer condCnt = 0 ; condCnt < condTot ; condCnt++)
            {            
                DS_Document_Detail.CONDITIONS headerCondition = docObj.CONDITIONS[condCnt];
                if (String.isNotEmpty(headerCondition.ConditionType) && headerCondition.Rate != null)
                {
                    SBO_EnosixSalesDocument_Detail.CONDITIONS newCondition = new SBO_EnosixSalesDocument_Detail.CONDITIONS();
                    mapConditionFieldsToSBO(newCondition, headerCondition, '', sboObject.SalesDocumentCurrency);
                    sboObject.CONDITIONS.add(newCondition);
                }
            }

            // TEXTS
            Integer textTot = docObj.TEXTS == null ? 0 : docObj.TEXTS.size();
            for (Integer textCnt = 0 ; textCnt < textTot ; textCnt++)
            {            
                DS_Document_Detail.TEXTS text = docObj.TEXTS[textCnt];
                if (String.isNotEmpty(text.Text))
                {
                    SBO_EnosixSalesDocument_Detail.TEXTS newText = new SBO_EnosixSalesDocument_Detail.TEXTS();
                    mapHeaderTextToSBO(newText, text);
                    sboObject.TEXTS.add(newText);
                }                
            }

            // ITEMS
            if (docObj.ITEMS != null && docObj.ITEMS.size() > 0) 
            {
                mapNewItemsToSBO(sboObject, docObj.ITEMS);
            }
        }

        return sboObject;
    }

    private void mapHeaderFieldsToSBO(SBO_EnosixSalesDocument_Detail.EnosixSalesDocument sboObject, DS_Document_Detail docObj)
    {
        // HEADER
        if (String.isNotEmpty(docObj.SalesDocument)) sboObject.SalesDocument = docObj.SalesDocument;
        if (String.isNotEmpty(docObj.SoldToPartyText)) sboObject.SoldToPartyText = docObj.SoldToPartyText;
        if (String.isNotEmpty(docObj.CustomerPurchaseOrderNumber)) sboObject.CustomerPurchaseOrderNumber = docObj.CustomerPurchaseOrderNumber;
        if (null != docObj.CustomerPurchaseOrderDate) sboObject.CustomerPurchaseOrderDate = docObj.CustomerPurchaseOrderDate;
        if (String.isNotEmpty(docObj.SalesDocumentCurrency))
        {
            sboObject.SalesDocumentCurrency = docObj.SalesDocumentCurrency;
            sboObject.SALES.SalesDocumentCurrency = docObj.SalesDocumentCurrency;
        }

        if (String.isNotEmpty(docObj.ReferenceDocument)) sboObject.ReferenceDocument = docObj.ReferenceDocument;
        if (String.isNotEmpty(docObj.ReferenceDocumentCategory)) sboObject.ReferenceDocumentCategory = docObj.ReferenceDocumentCategory;

        // SALES DATA
        sboObject.SALES.SalesDocumentType = docObj.SALES.SalesDocumentType;
        if (String.isNotEmpty(docObj.SALES.SalesOrganization)) sboObject.SALES.SalesOrganization = docObj.SALES.SalesOrganization;
        if (String.isNotEmpty(docObj.SALES.DistributionChannel)) sboObject.SALES.DistributionChannel = docObj.SALES.DistributionChannel;
        if (String.isNotEmpty(docObj.SALES.Division)) sboObject.SALES.Division = docObj.SALES.Division;
        if (String.isNotEmpty(docObj.SALES.PriceGroup)) sboObject.SALES.PriceGroup = docObj.SALES.PriceGroup;
        if (String.isNotEmpty(docObj.SALES.PriceListType)) sboObject.SALES.PriceListType = docObj.SALES.PriceListType;
        if (String.isNotEmpty(docObj.SALES.SalesDistrict)) sboObject.SALES.SalesDistrict = docObj.SALES.SalesDistrict;
        if (String.isNotEmpty(docObj.SALES.TermsofPaymentKey)) sboObject.SALES.TermsofPaymentKey = docObj.SALES.TermsofPaymentKey;
        if (String.isNotEmpty(docObj.SALES.IncotermsPart1)) sboObject.SALES.IncotermsPart1 = docObj.SALES.IncotermsPart1;
        if (String.isNotEmpty(docObj.SALES.IncotermsPart2)) sboObject.SALES.IncotermsPart2 = docObj.SALES.IncotermsPart2;        
        if (String.isNotEmpty(docObj.SALES.SalesOffice)) sboObject.SALES.SalesOffice = docObj.SALES.SalesOffice;        
        if (String.isNotEmpty(docObj.SALES.OrderReason)) sboObject.SALES.OrderReason = docObj.SALES.OrderReason;
        if (String.isNotEmpty(docObj.SALES.CustomerGroup)) sboObject.SALES.CustomerGroup = docObj.SALES.CustomerGroup;
        if (String.isNotEmpty(docObj.SALES.SalesDocumentVersionNumber)) sboObject.SALES.SalesDocumentVersionNumber = docObj.SALES.SalesDocumentVersionNumber;

        sboObject.SALES.ValidFrom = docObj.SALES.ValidFrom != null ? docObj.SALES.ValidFrom : Date.today();
        sboObject.SALES.ValidTo = docObj.SALES.ValidTo != null ? docObj.SALES.ValidTo : Date.today() + 30;
        sboObject.SALES.DateforPricingExchangeRate = docObj.SALES.DateforPricingExchangeRate != null ? docObj.SALES.DateforPricingExchangeRate : Date.today();
        sboObject.SALES.RequestedDeliveryDate = docObj.SALES.RequestedDeliveryDate != null ? docObj.SALES.RequestedDeliveryDate : Date.today();
        sboObject.SALES.BillingBlock = docObj.SALES.BillingBlock;
        sboObject.SALES.DeliveryBlock = docObj.SALES.DeliveryBlock;

        // SHIPPING
        if (String.isNotEmpty(docObj.ShippingConditions)) sboObject.SHIPPING.ShippingConditions = docObj.ShippingConditions;

        // ORDERDATA
        if (String.isNotEmpty(docObj.CollectiveNumber)) sboObject.ORDERDATA.CollectiveNumber = docObj.CollectiveNumber;
    }

    // Mapping of newly added Items to SBO
    private void mapNewItemsToSBO(SBO_EnosixSalesDocument_Detail.EnosixSalesDocument sboObject, List<DS_Document_Detail.ITEMS> items)
    {
        Integer itemTot = items.size();
        for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
        {
            DS_Document_Detail.ITEMS item = items[itemCnt];
            Boolean isMainItem = String.isEmpty(item.HigherLevelItemNumber) || Integer.valueOf(item.HigherLevelItemNumber) == 0;

            if (this.appSettings.enableBoMItemEdit || isMainItem)
            {
                SBO_EnosixSalesDocument_Detail.ITEMS newItem = new SBO_EnosixSalesDocument_Detail.ITEMS();
                mapItemFieldsToSBO(newItem, item);
                sboObject.ITEMS.add(newItem);

                // Item Texts
                Integer textTot = item.ItemTexts == null ? 0 : item.ItemTexts.size();
                for (Integer textCnt = 0 ; textCnt < textTot ; textCnt++)
                {
                    DS_Document_Detail.TEXTS text = item.ItemTexts[textCnt];
                    SBO_EnosixSalesDocument_Detail.ITEMS_TEXT sboItemsText = new SBO_EnosixSalesDocument_Detail.ITEMS_TEXT();
                    mapItemsTextToSBO(sboItemsText, item.ItemNumber, text);
                    sboObject.ITEMS_TEXT.add(sboItemsText);
                }

                // Add Item Conditions
                Integer condTot = item.ItemConditions == null ? 0 : item.itemConditions.size();
                for (Integer condCnt = 0 ; condCnt < condTot ; condCnt++)
                {
                    DS_Document_Detail.CONDITIONS itemCondition = item.itemConditions[condCnt];
                    SBO_EnosixSalesDocument_Detail.CONDITIONS newItemCondition = new SBO_EnosixSalesDocument_Detail.CONDITIONS();
                    mapConditionFieldsToSBO(newItemCondition, itemCondition, item.ItemNumber, sboObject.SalesDocumentCurrency);
                    sboObject.CONDITIONS.add(newItemCondition);
                }

                // Partners
                if (item.PARTNERS != null && item.PARTNERS.size() > 0){
                    Integer partnerTot = item.PARTNERS.size();
                    for (Integer partnerCnt = 0; partnerCnt < partnerTot; partnerCnt++)
                    {
                        DS_Document_Detail.PARTNERS itemPartner = item.PARTNERS[partnerCnt];
                        SBO_EnosixSalesDocument_Detail.PARTNERS sboPartner = createNewPartnerSBO(itemPartner, item.ItemNumber);
                        if (sboPartner != null) sboObject.PARTNERS.add(sboPartner);
                    }
                }

                // Add Item Configs
                if (String.isEmpty(item.RejectionReason) && item.ItemConfigurations != null && item.ItemConfigurations.size() > 0)
                {
                    Integer configTot = item.ItemConfigurations.size();
                    for (Integer configCnt = 0 ; configCnt < configTot ; configCnt++)
                    {
                        DS_Document_Detail.CONFIG config = item.ItemConfigurations[configCnt];
                        if (config.UserModified != null && config.UserModified) {
                            SBO_EnosixSalesDocument_Detail.ITEMS_CONFIG sboItemConfig = new SBO_EnosixSalesDocument_Detail.ITEMS_CONFIG();
                            mapItemsConfigToSBO(sboItemConfig, item.ItemNumber, config);
                            sboObject.ITEMS_CONFIG.add(sboItemConfig);
                        }
                    }
                }

                SBO_EnosixSalesDocument_Detail.ITEMS_ACTION sboItemAction = new SBO_EnosixSalesDocument_Detail.ITEMS_ACTION();
                sboItemAction.ItemNumber = item.ItemNumber;
                sboItemAction.ItemAdded = true;
                sboObject.ITEMS_ACTION.add(sboItemAction);
            }
        }
    }

    private SBO_EnosixSalesDocument_Detail.PARTNERS createNewPartnerSBO(DS_Document_Detail.PARTNERS partner, String itemNumber)
    {
        SBO_EnosixSalesDocument_Detail.PARTNERS newPartner;

        if (String.isNotEmpty(partner.CustomerNumber) || String.isNotEmpty(partner.Vendor) || String.isNotEmpty(partner.PersonnelNumber) || String.isNotEmpty(partner.ContactPersonNumber))
        {
            newPartner = new SBO_EnosixSalesDocument_Detail.PARTNERS();
            if (String.isNotEmpty(itemNumber)) {
                newPartner.ItemNumber = itemNumber;
            }
            newPartner.PartnerFunction = partner.PartnerFunction;

            if (String.isNotEmpty(partner.CustomerNumber) && partner.CustomerNumber.replaceFirst('^0+(?!$)', '') != '0') {
                newPartner.CustomerNumber = partner.CustomerNumber;
            }
            else if (String.isNotEmpty(partner.Vendor) && partner.Vendor.replaceFirst('^0+(?!$)', '') != '0') {
                newPartner.Vendor = partner.Vendor;
            }
            else if (String.isNotEmpty(partner.PersonnelNumber) && partner.PersonnelNumber.replaceFirst('^0+(?!$)', '') != '0') {
                newPartner.PersonnelNumber = partner.PersonnelNumber;
            }
            else if (String.isNotEmpty(partner.ContactPersonNumber) && partner.ContactPersonNumber.replaceFirst('^0+(?!$)', '') != '0') {
                newPartner.ContactPersonNumber = partner.ContactPersonNumber;
            }

            if (String.isNotEmpty(partner.PartnerName)) newPartner.PartnerName = partner.PartnerName;
            if (String.isNotEmpty(partner.HouseNumber)) newPartner.HouseNumber = partner.HouseNumber;
            if (String.isNotEmpty(partner.Street)) newPartner.Street = partner.Street;
            if (String.isNotEmpty(partner.City)) newPartner.City = partner.City;
            if (String.isNotEmpty(partner.PostalCode)) newPartner.PostalCode = partner.PostalCode;
            if (String.isNotEmpty(partner.Region)) newPartner.Region = partner.Region;
            if (String.isNotEmpty(partner.Country)) newPartner.Country = partner.Country;
        }

        return newPartner;
    }

    private void mapHeaderTextToSBO(SBO_EnosixSalesDocument_Detail.TEXTS sboText, DS_Document_Detail.TEXTS text)
    {
        sboText.TextID = text.TextID;
        sboText.Text = text.Text;
        sboText.TextLanguage = text.TextLanguage;
    }

    private void mapItemsTextToSBO(SBO_EnosixSalesDocument_Detail.ITEMS_TEXT sboItemsText, String itemNumber, DS_Document_Detail.TEXTS text)
    {
        sboItemsText.ItemNumber = itemNumber;
        sboItemsText.TextID = text.TextID;
        sboItemsText.Text = text.Text;
    }

    private void mapItemFieldsToSBO(SBO_EnosixSalesDocument_Detail.ITEMS sboItem, DS_Document_Detail.ITEMS item)
    {
        sboItem.ItemNumber = item.ItemNumber;
        sboItem.Material = item.Material;
        sboItem.HigherLevelItemNumber = item.HigherLevelItemNumber;
        sboItem.ItemDescription = item.ItemDescription;
        sboItem.OrderQuantity = item.OrderQuantity;
        sboItem.ReasonForRejection = item.RejectionReason;
        sboItem.ScheduleLineDate = item.ScheduleLineDate;
        sboItem.Plant = item.Plant;
        sboItem.AlternativeForItem = item.AlternativeItem;
        sboItem.ConfigurableMaterial = item.ConfigurableMaterial;
        sboItem.PriceListType = item.PriceListType;
        sboItem.ItemReferenceDocument = item.ReferenceDocument;
        sboItem.ItemReferenceDocumentItNumber = item.ReferenceItemNumber;
        sboItem.ItemReferenceDocumentCtegory = item.ReferenceDocumentCategory;
    }

    private void mapConditionFieldsToSBO(SBO_EnosixSalesDocument_Detail.CONDITIONS sboCondition,
        DS_Document_Detail.CONDITIONS condition, String itemNumber, String currencyKey)
    {
        if (String.isNotEmpty(itemNumber)) sboCondition.ConditionItemNumber = itemNumber;
        sboCondition.ConditionType = condition.ConditionType;
        sboCondition.Rate = condition.Rate;
        sboCondition.ConditionControl = 'C';
        sboCondition.CalculationType = condition.CalculationType;
        sboCondition.ConditionCounter = condition.ConditionCounter;
        sboCondition.ConditionOrigin = condition.OriginOfCondition;
        // Insert Currency for Calculation type gross weight
        if (sboCondition.CalculationType == 'D') sboCondition.CurrencyKey = currencyKey;
    }

    private void mapItemsConfigToSBO(SBO_EnosixSalesDocument_Detail.ITEMS_CONFIG sboItemConfig, String itemNumber, DS_Document_Detail.CONFIG itemConfig)
    {
        sboItemConfig.ItemNumber = itemNumber;
        sboItemConfig.CharacteristicID = itemConfig.CharacteristicID;
        sboItemConfig.CharacteristicValue = itemConfig.CharacteristicValue;
    }

    private void mapPartnersToSBOForUpdate(SBO_EnosixSalesDocument_Detail.EnosixSalesDocument sboObject, List<DS_Document_Detail.PARTNERS> objPartners, String itemNumber)
    {
        Integer partTot = objPartners.size();
        List<SBO_EnosixSalesDocument_Detail.PARTNERS> sboPartners = sboObject.PARTNERS.getAsList();
        List<SBO_EnosixSalesDocument_Detail.PARTNERS> updatedSBOPartners = new List<SBO_EnosixSalesDocument_Detail.PARTNERS>();
        Integer partTot2 = sboPartners.size();

        for (Integer partCnt = 0 ; partCnt < partTot ; partCnt++)
        {
            DS_Document_Detail.PARTNERS partner = objPartners[partCnt];
            Boolean isFound = false;

            for (Integer partCnt2 = 0 ; partCnt2 < partTot2 ; partCnt2++)
            {
                SBO_EnosixSalesDocument_Detail.PARTNERS sboPartner = sboPartners[partCnt2];
                if (sboPartner.PartnerFunction == partner.PartnerFunction && 
                    (String.isNotEmpty(itemNumber) ? sboPartner.ItemNumber == itemNumber : sboPartner.ItemNumber.replaceFirst('^0+(?!$)', '') == '0')) 
                {
                    if (partner.isChanged == true) {
                        if (String.isNotEmpty(partner.PartnerName)) sboPartner.PartnerName = partner.PartnerName;
                        if (String.isNotEmpty(partner.CustomerNumber)) sboPartner.CustomerNumber = partner.CustomerNumber;
                        if (String.isNotEmpty(partner.Vendor)) sboPartner.Vendor = partner.Vendor;
                        if (String.isNotEmpty(partner.PersonnelNumber)) sboPartner.PersonnelNumber = partner.PersonnelNumber;
                        if (String.isNotEmpty(partner.ContactPersonNumber)) sboPartner.ContactPersonNumber = partner.ContactPersonNumber;
                        if (String.isNotEmpty(partner.HouseNumber)) sboPartner.HouseNumber = partner.HouseNumber;
                        if (String.isNotEmpty(partner.Street)) sboPartner.Street = partner.Street;
                        if (String.isNotEmpty(partner.City)) sboPartner.City = partner.City;
                        if (String.isNotEmpty(partner.PostalCode)) sboPartner.PostalCode = partner.PostalCode;
                        if (String.isNotEmpty(partner.Region)) sboPartner.Region = partner.Region;
                        if (String.isNotEmpty(partner.Country)) sboPartner.Country = partner.Country;
                        updatedSBOPartners.add(sboPartner);
                    }

                    isFound = true;
                    break;
                }
            }

            if (!isFound) {
                SBO_EnosixSalesDocument_Detail.PARTNERS sboPartner = createNewPartnerSBO(partner, itemNumber);
                if (sboPartner != null) updatedSBOPartners.add(sboPartner);
            }
        }

        // Clear all the partners in the SBO
        // And send only the updated partners
        sboObject.PARTNERS.clear();
        if (updatedSBOPartners.size() > 0) sboObject.PARTNERS.addAll(updatedSBOPartners);
    }

    private void mapHeaderTextsToSBOForUpdate(SBO_EnosixSalesDocument_Detail.EnosixSalesDocument sboObject, DS_Document_Detail salesDocDetail)
    {
        Integer textTot = salesDocDetail.TEXTS.size();
        List<SBO_EnosixSalesDocument_Detail.TEXTS> textList = sboObject.TEXTS.getAsList();
        Integer textTot2 = textList.size();
        for (Integer textCnt = 0 ; textCnt < textTot ; textCnt++)
        {
            DS_Document_Detail.TEXTS headerText = salesDocDetail.TEXTS[textCnt];
            Boolean isFound = false;

            for (Integer textCnt2 = 0 ; textCnt2 < textTot2 ; textCnt2++)
            {
                SBO_EnosixSalesDocument_Detail.TEXTS sboText = textList[textCnt2];
                if (sboText.TextID == headerText.TextID) {
                    mapHeaderTextToSBO(sboText, headerText);
                    isFound = true;
                    break;
                }
            }

            if (!isFound) {
                SBO_EnosixSalesDocument_Detail.TEXTS newText = new SBO_EnosixSalesDocument_Detail.TEXTS();
                mapHeaderTextToSBO(newText, headerText);
                sboObject.TEXTS.add(newText);
            }
        }
    }

    private void mapHeaderConditionsToSBOForUpdate(SBO_EnosixSalesDocument_Detail.EnosixSalesDocument sboObject, DS_Document_Detail salesDocDetail)
    {
        Integer condTot = salesDocDetail.CONDITIONS.size();
        for (Integer condCnt = 0 ; condCnt < condTot ; condCnt++)
        {
            DS_Document_Detail.CONDITIONS headerCondition = salesDocDetail.CONDITIONS[condCnt];
            SBO_EnosixSalesDocument_Detail.CONDITIONS sboCondition = new SBO_EnosixSalesDocument_Detail.CONDITIONS();
            mapConditionFieldsToSBO(sboCondition, headerCondition, '', sboObject.SalesDocumentCurrency);
            sboObject.CONDITIONS.add(sboCondition);
        }
    }

    private void removedItemsForUpdate(SBO_EnosixSalesDocument_Detail.EnosixSalesDocument sboObject, DS_Document_Detail salesDocDetail)
    {
        if (salesDocDetail.removedItems != null && salesDocDetail.removedItems.size() > 0)
        {
            Integer itemTot = salesDocDetail.removedItems.size();
            for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++) 
            {
                String itemNumber = salesDocDetail.removedItems[itemCnt];

                SBO_EnosixSalesDocument_Detail.ITEMS_ACTION itemRemovedAction = new SBO_EnosixSalesDocument_Detail.ITEMS_ACTION();
                itemRemovedAction.ItemNumber = itemNumber;
                itemRemovedAction.ItemDeleted = true;
                sboObject.ITEMS_ACTION.add(itemRemovedAction);
            }
        }
    }

    private void mapItemsForUpdate(SBO_EnosixSalesDocument_Detail.EnosixSalesDocument sboObject, DS_Document_Detail salesDocDetail)
    {
        List<DS_Document_Detail.ITEMS> addedItems = new List<DS_Document_Detail.ITEMS>();
        List<DS_Document_Detail.ITEMS> changedItems = new List<DS_Document_Detail.ITEMS>();
        Set<String> changedItemNumbers = new Set<String>();
        Set<String> alternativeItemNumbers = new Set<String>();

        Integer itemTot = salesDocDetail.ITEMS.size();
        for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
        {
            DS_Document_Detail.ITEMS item = salesDocDetail.ITEMS[itemCnt];
            if (item.isAdded == true) {
                salesDocDetail.callSimulateBeforeUpdate = true;
                addedItems.add(item);

                // When a newly added item has Alternative Item Value
                // Need to include the Alternative Item as changed item
                if (String.isNotEmpty(item.AlternativeItem) && item.AlternativeItem.replaceFirst('^0+(?!$)', '') != '0') {
                    alternativeItemNumbers.add(item.AlternativeItem);
                }
            }
            else if (item.isChanged == true) {
                changedItems.add(item);
                changedItemNumbers.add(item.ItemNumber);
            }
        }

        if (alternativeItemNumbers.size() > 0) {
            itemTot = salesDocDetail.ITEMS.size();
            for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
            {
                DS_Document_Detail.ITEMS item = salesDocDetail.ITEMS[itemCnt];
                if (alternativeItemNumbers.contains(item.ItemNumber) && !changedItemNumbers.contains(item.ItemNumber)) {
                    changedItems.add(item);
                }
            }
        }

        if (changedItems.size() > 0) {
            itemTot = changedItems.size();
            List<SBO_EnosixSalesDocument_Detail.ITEMS_TEXT> textList = sboObject.ITEMS_TEXT.getAsList();
            Integer textTot2 = textList.size();
            List<SBO_EnosixSalesDocument_Detail.ITEMS> itemList = sboObject.ITEMS.getAsList();
            Integer itemTot2 = itemList.size();
            for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
            {
                DS_Document_Detail.ITEMS item = changedItems[itemCnt];

                mapPartnersToSBOForUpdate(sboObject, item.PARTNERS, item.ItemNumber);

                Integer condTot = item.ItemConditions == null ? 0 : item.ItemConditions.size();
                for (Integer condCnt = 0 ; condCnt < condTot ; condCnt++)
                {
                    DS_Document_Detail.CONDITIONS itemCondition = item.ItemConditions[condCnt];
                    SBO_EnosixSalesDocument_Detail.CONDITIONS sboCondition = new SBO_EnosixSalesDocument_Detail.CONDITIONS();
                    mapConditionFieldsToSBO(sboCondition, itemCondition, item.ItemNumber, sboObject.SalesDocumentCurrency);
                    sboObject.CONDITIONS.add(sboCondition);
                }

                Integer textTot = item.ItemTexts == null ? 0 : item.ItemTexts.size();
                for (Integer textCnt = 0 ; textCnt < textTot ; textCnt++)
                {
                    DS_Document_Detail.TEXTS itemText = item.ItemTexts[textCnt];
                    for (Integer textCnt2 = 0 ; textCnt2 < textTot2 ; textCnt2++)
                    {
                        SBO_EnosixSalesDocument_Detail.ITEMS_TEXT sboItemText = textList[textCnt2];

                        if (item.ItemNumber == sboItemText.ItemNumber && itemText.TextID == sboItemText.TextID) {
                            sboItemText.Text = itemText.Text;
                            break;
                        }
                    }
                }

                for (Integer itemCnt2 = 0 ; itemCnt2 < itemTot2 ; itemCnt2++)
                {
                    SBO_EnosixSalesDocument_Detail.ITEMS sboItem = itemList[itemCnt2];

                    if (sboItem.ItemNumber == item.ItemNumber) {
                        mapItemFieldsToSBO(sboItem, item);
                        break;
                    }
                }

                SBO_EnosixSalesDocument_Detail.ITEMS_ACTION itemChangedAction = new SBO_EnosixSalesDocument_Detail.ITEMS_ACTION();
                itemChangedAction.ItemNumber = item.ItemNumber;
                itemChangedAction.ItemChanged = true;
                sboObject.ITEMS_ACTION.add(itemChangedAction);
            }
        }
        if (addedItems.size() > 0) {
            mapNewItemsToSBO(sboObject, addedItems);
        }
    }
    // #endregion Convert to SBO Mapping




    // #region Convert to DS Object mapping

    // Implementation of Converting SBO Detail Object to DS_Document_Detail Object
    // This conversion is use before sending the detail object to Front-end
    public void convertToObject(ensxsdk.EnosixFramework.DetailObject detailObj, DS_Document_Detail docObj, 
        Boolean isFromGetDetail, DS_SalesDocAppSettings appSettings)
    {
        SBO_EnosixSalesDocument_Detail.EnosixSalesDocument sboObject = (SBO_EnosixSalesDocument_Detail.EnosixSalesDocument) detailObj;

        convertSBOHeaderAndSales(docObj, sboObject);

        // CONDITIONS
        // Get all the conditions from the SBO
        // Store the Item conditions in a map
        Map<String, List<DS_Document_Detail.CONDITIONS>> itemNumberConditions = new Map<String, List<DS_Document_Detail.CONDITIONS>>();
        docObj.SBOHeaderConditions = new List<DS_Document_Detail.CONDITIONS>();
        
        List<SBO_EnosixSalesDocument_Detail.CONDITIONS> condList = sboObject.CONDITIONS.getAsList();
        Integer condTot = condList.size();
        for (Integer condCnt = 0 ; condCnt < condTot ; condCnt++)
        {
            SBO_EnosixSalesDocument_Detail.CONDITIONS condition = condList[condCnt];

            if (String.isNotEmpty(condition.ConditionItemNumber) && condition.ConditionItemNumber.replaceFirst('^0+(?!$)', '') != '0')
            {
                List<DS_Document_Detail.CONDITIONS> conditions = itemNumberConditions.get(condition.ConditionItemNumber);
                if (null == conditions)
                {
                    conditions = new List<DS_Document_Detail.CONDITIONS>();
                }
                conditions.add(convertSBOCondition(condition));
                itemNumberConditions.put(condition.ConditionItemNumber, conditions);
            }
            else
            {
                docObj.SBOHeaderConditions.add(convertSBOCondition(condition));
            }
        }

        // Item Number that has 'Configuration' (Translated to other languages as well)
        // INCOMPLETION_LOG
        Set<String> itemNumbersNeedConfigure = new Set<String>();
        docObj.IncompletionLogs = new List<DS_Document_Detail.INCOMPLETION_LOG>();
        Map<String, List<DS_Document_Detail.INCOMPLETION_LOG>> itemNumberIncompletionLogs = new Map<String, List<DS_Document_Detail.INCOMPLETION_LOG>>();

        List<SBO_EnosixSalesDocument_Detail.INCOMPLETION_LOG> logList = sboObject.INCOMPLETION_LOG.getAsList();
        Integer logTot = logList.size();
        for (Integer logCnt = 0 ; logCnt < logTot ; logCnt++)
        {
            SBO_EnosixSalesDocument_Detail.INCOMPLETION_LOG log = logList[logCnt];
            if (String.isNotEmpty(log.ItemNumber) && log.ItemNumber.replaceFirst('^0+(?!$)', '') != '0')
            {
                List<DS_Document_Detail.INCOMPLETION_LOG> incompletionLogs = itemNumberIncompletionLogs.get(log.ItemNumber);
                if (null == incompletionLogs)
                {
                    incompletionLogs = new List<DS_Document_Detail.INCOMPLETION_LOG>();
                }
                incompletionLogs.add(convertSBOIncompletionLog(log));
                itemNumberIncompletionLogs.put(log.ItemNumber, incompletionLogs);

                if (UTIL_SalesDoc.configurationLogText.contains(log.Description)) {
                    itemNumbersNeedConfigure.add(log.ItemNumber);
                }
            }
            else
            {
                docObj.IncompletionLogs.add(convertSBOIncompletionLog(log));
            }
        }

        Map<String, List<DS_Document_Detail.SCHEDULE>> itemNumberItemSchedules = 
            new Map<String, List<DS_Document_Detail.SCHEDULE>>();

        // Convert SBO Items Schedule
        List<SBO_EnosixSalesDocument_Detail.ITEMS_SCHEDULE> schedList = sboObject.ITEMS_SCHEDULE.getAsList();
        Integer schedTot = schedList.size();
        for (Integer schedCnt = 0 ; schedCnt < schedTot ; schedCnt++)
        {
            SBO_EnosixSalesDocument_Detail.ITEMS_SCHEDULE sboItemSched = schedList[schedCnt];
            List<DS_Document_Detail.SCHEDULE> itemScheds = itemNumberItemSchedules.get(sboItemSched.ItemNumber);
            if (null == itemScheds) {
                itemScheds = new List<DS_Document_Detail.SCHEDULE>();
            }

            itemScheds.add(convertSBOSched(sboItemSched));
            itemNumberItemSchedules.put(sboItemSched.ItemNumber, itemScheds);
        }

        // Store the current Items in a map
        Map<String, DS_Document_Detail.ITEMS> itemNumberItem = new Map<String, DS_Document_Detail.ITEMS>();
        Integer itemTot = docObj.ITEMS.size();
        for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
        {            
            DS_Document_Detail.ITEMS item = docObj.ITEMS[itemCnt];
            itemNumberItem.put(item.ItemNumber.leftPad(6, '0'), item);            
        }

        Map<String, List<DS_Document_Detail.TEXTS>> itemNumberItemsText = 
            new Map<String, List<DS_Document_Detail.TEXTS>>();
        Map<String, List<DS_Document_Detail.CONFIG>> itemNumberItemsConfig = 
            new Map<String, List<DS_Document_Detail.CONFIG>>();
        Map<String, List<DS_Document_Detail.PARTNERS>> itemNumberItemPartners = 
            new Map<String, List<DS_Document_Detail.PARTNERS>>();

        if (isFromGetDetail)
        {
            // Get the added Condition from the SBO
            docObj.CONDITIONS = UTIL_SBOAdapter.getAddedConditions(docObj.SBOHeaderConditions);

            // Get all the SBO Partners
            List<SBO_EnosixSalesDocument_Detail.PARTNERS> partnerList = sboObject.PARTNERS.getAsList();
            Integer partnerTot = partnerList.size();
            for (Integer partnerCnt = 0 ; partnerCnt < partnerTot ; partnerCnt++)
            {
                SBO_EnosixSalesDocument_Detail.PARTNERS sboPartner = partnerList[partnerCnt];
                List<DS_Document_Detail.PARTNERS> itemPartners = itemNumberItemPartners.get(sboPartner.ItemNumber);
                if (itemPartners == null) {
                    itemPartners = new List<DS_Document_Detail.PARTNERS>();
                }
                itemPartners.add(convertSBOPartner(sboPartner));
                itemNumberItemPartners.put(sboPartner.ItemNumber, itemPartners);
            }            
            docObj.PARTNERS = UTIL_SBOAdapter.filterPartners(
                appSettings.Header.PartnerPickers, docObj.PARTNERS, itemNumberItemPartners.get('000000'));

            // Convert SBO Header Text
            List<DS_Document_Detail.TEXTS> headerTexts = new List<DS_Document_Detail.TEXTS>();
            List<SBO_EnosixSalesDocument_Detail.TEXTS> textList = sboObject.TEXTS.getAsList();
            Integer textTot = textList.size();
            for (Integer textCnt = 0 ; textCnt < textTot ; textCnt++)
            {
                SBO_EnosixSalesDocument_Detail.TEXTS sboHeaderText = textList[textCnt];
                headerTexts.add(convertSBOText(sboHeaderText));
            }
            docObj.TEXTS = UTIL_SBOAdapter.filterTexts(docObj.TEXTS, headerTexts, appSettings.Header.Texts);

            // Convert SBO Items Text
            List<SBO_EnosixSalesDocument_Detail.ITEMS_TEXT> textList2 = sboObject.ITEMS_TEXT.getAsList();
            Integer textTot2 = textList2.size();
            for (Integer textCnt2 = 0 ; textCnt2 < textTot2 ; textCnt2++)
            {
                SBO_EnosixSalesDocument_Detail.ITEMS_TEXT sboItemText = textList2[textCnt2];
                List<DS_Document_Detail.TEXTS> itemTexts = itemNumberItemsText.get(sboItemText.ItemNumber);
                if (null == itemTexts) {
                    itemTexts = new List<DS_Document_Detail.TEXTS>();
                }

                itemTexts.add(convertSBOText(sboItemText));
                itemNumberItemsText.put(sboItemText.ItemNumber, itemTexts);
            }

            // Convert SBO Items Config
            List<SBO_EnosixSalesDocument_Detail.ITEMS_CONFIG> configList = sboObject.ITEMS_CONFIG.getAsList();
            Integer configTot = configList.size();
            for (Integer configCnt = 0 ; configCnt < configTot ; configCnt++)
            {
                SBO_EnosixSalesDocument_Detail.ITEMS_CONFIG sboItemConfig = configList[configCnt];
                List<DS_Document_Detail.CONFIG> itemConfigs = itemNumberItemsConfig.get(sboItemConfig.ItemNumber);
                if (null == itemConfigs) {
                    itemConfigs = new List<DS_Document_Detail.CONFIG>();
                }

                itemConfigs.add(convertSBOConfig(sboItemConfig));
                itemNumberItemsConfig.put(sboItemConfig.ItemNumber, itemConfigs);
            }
        }

        // ITEMS
        // Mapping of items from SBO to DS Object
        docObj.ITEMS = new List<DS_Document_Detail.ITEMS>();
        List<SBO_EnosixSalesDocument_Detail.ITEMS> itemList = sboObject.ITEMS.getAsList();
        itemTot = itemList.size();
        for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
        {
            SBO_EnosixSalesDocument_Detail.ITEMS sboItem = itemList[itemCnt];
            DS_Document_Detail.ITEMS newItem = new DS_Document_Detail.ITEMS();
            newItem.ItemIncompletionLogs = new List<DS_Document_Detail.INCOMPLETION_LOG>();
            newItem.SBOItemConditions = new List<DS_Document_Detail.CONDITIONS>();
            newItem.BillingPlan = new DS_Document_Detail.BILLING_PLAN();
            newItem.BillingPlanDates = new List<DS_Document_Detail.BILLING_PLAN_DATES>();
            newItem.ItemSchedules = new List<DS_Document_Detail.SCHEDULE>();

            DS_Document_Detail.ITEMS currentItem = itemNumberItem.get(sboItem.ItemNumber);

            if (itemNumberConditions.containsKey(sboItem.ItemNumber)) newItem.SBOItemConditions = itemNumberConditions.get(sboItem.ItemNumber);

            if (null != currentItem) {
                newItem.SFId = currentItem.SFId;
                newItem.ItemConditions = currentItem.ItemConditions;
                newItem.ItemConfigurations = currentItem.ItemConfigurations;
                newItem.ItemTexts = currentItem.ItemTexts;
                newItem.isConfigurationFromVCComplete = currentItem.isConfigurationFromVCComplete;
                newItem.isAdded = currentItem.isAdded;
                newItem.isChanged = currentItem.isChanged;
                newItem.PARTNERS = currentItem.PARTNERS;
            }
            else {
                newItem.ItemConditions = UTIL_SBOAdapter.getAddedConditions(newItem.SBOItemConditions);
                newItem.ItemTexts = UTIL_SBOAdapter.filterTexts(new List<DS_Document_Detail.TEXTS>(), itemNumberItemsText.get(sboItem.ItemNumber), appSettings.Item.Texts);
                newItem.ItemConfigurations = itemNumberItemsConfig.get(sboItem.ItemNumber);
                newItem.PARTNERS = UTIL_SBOAdapter.filterPartners(appSettings.Item.PartnerPickers, new List<DS_Document_Detail.PARTNERS>(), itemNumberItemPartners.get(sboItem.ItemNumber));
            }

            if (itemNumberIncompletionLogs.containsKey(sboItem.ItemNumber)) newItem.ItemIncompletionLogs = itemNumberIncompletionLogs.get(sboItem.ItemNumber);
            newItem.ItemSchedules = itemNumberItemSchedules.get(sboItem.ItemNumber);

            convertSBOItem(newItem, sboItem);

            newItem.isNeedConfigure = itemNumbersNeedConfigure.contains(sboItem.ItemNumber) &&
                (newItem.isConfigurationFromVCComplete == null || !newItem.isConfigurationFromVCComplete) ? true : false;

            docObj.ITEMS.add(newItem);
        }
    }

    private void convertSBOHeaderAndSales(DS_Document_Detail docObj, SBO_EnosixSalesDocument_Detail.EnosixSalesDocument sboObject)
    {
        // HEADER
        docObj.SalesDocument = sboObject.SalesDocument;
        docObj.SoldToParty = sboObject.SoldToParty;
        docObj.SoldToPartyText = sboObject.SoldToPartyText;
        docObj.SalesDocumentCurrency = sboObject.SalesDocumentCurrency;
        docObj.CustomerPurchaseOrderNumber = sboObject.CustomerPurchaseOrderNumber;
        docObj.CustomerPurchaseOrderDate = sboObject.CustomerPurchaseOrderDate;
        docObj.NetOrderValue = sboObject.NetOrderValue;
        docObj.ReferenceDocument = sboObject.ReferenceDocument;
        docObj.ReferenceDocumentCategory = sboObject.ReferenceDocumentCategory;
        docObj.TaxAmount = sboObject.TaxAmount;
        docObj.IsSuccess = sboObject.isSuccess();
        docObj.NeedToSimulate = false;

        // SALES
        docObj.SALES.CreateDate = sboObject.SALES.CreateDate;
        docObj.SALES.SalesDocumentType = sboObject.SALES.SalesDocumentType;
        docObj.SALES.SalesOrganization = sboObject.SALES.SalesOrganization;
        docObj.SALES.DistributionChannel = sboObject.SALES.DistributionChannel;
        docObj.SALES.Division = sboObject.SALES.Division;
        docObj.SALES.PricingProcedureInPricing = sboObject.SALES.PricingProcedureInPricing;
        docObj.SALES.PriceGroup = sboObject.SALES.PriceGroup;
        docObj.SALES.PriceListType = sboObject.SALES.PriceListType;
        docObj.SALES.SalesDistrict = sboObject.SALES.SalesDistrict;
        docObj.SALES.SalesOffice = sboObject.SALES.SalesOffice;
        docObj.SALES.OrderReason = sboObject.SALES.OrderReason;
        docObj.SALES.CustomerGroup = sboObject.SALES.CustomerGroup;
        docObj.SALES.ValidFrom = sboObject.SALES.ValidFrom;
        docObj.SALES.ValidTo = sboObject.SALES.ValidTo;
        docObj.SALES.DateforPricingExchangeRate = sboObject.SALES.DateforPricingExchangeRate;
        docObj.SALES.RequestedDeliveryDate = sboObject.SALES.RequestedDeliveryDate;
        docObj.SALES.TermsofPaymentKey = sboObject.SALES.TermsofPaymentKey;
        docObj.SALES.IncotermsPart1 = sboObject.SALES.IncotermsPart1;
        docObj.SALES.IncotermsPart2 = sboObject.SALES.IncotermsPart2;
        docObj.SALES.BillingBlock = sboObject.SALES.BillingBlock;
        docObj.SALES.BillingBlockDescription = sboObject.SALES.BillingBlockDescription;
        docObj.SALES.DeliveryBlock = sboObject.SALES.DeliveryBlock;
        docObj.SALES.DeliveryBlockDescription = sboObject.SALES.DeliveryBlockDescription;

        // SHIPPING
        docObj.ShippingConditions = sboObject.SHIPPING.ShippingConditions;
    }

    private void convertSBOItem(DS_Document_Detail.ITEMS newItem, SBO_EnosixSalesDocument_Detail.ITEMS sboItem)
    {
        newItem.ItemNumber = sboItem.ItemNumber;
        newItem.HigherLevelItemNumber = sboItem.HigherLevelItemNumber;
        newItem.Material = sboItem.Material;
        newItem.ItemDescription = sboItem.ItemDescription;
        newItem.Plant = sboItem.Plant;
        newItem.ScheduleLineDate = sboItem.ScheduleLineDate;
        newItem.OrderQuantity = sboItem.OrderQuantity;
        newItem.NetItemPrice = sboItem.NetItemPrice;
        newItem.ItemCategory = sboItem.ItemCategory;
        newItem.BillingBlockStatus = sboItem.BillingBlockStatus;
        newItem.DeliveryBlockStatus = sboItem.DeliveryBlockStatus;
        newItem.ConditionPricingUnit = sboItem.ConditionPricingUnit;
        newItem.AlternativeItem = sboItem.AlternativeForItem;
        newItem.NetOrderValue = sboItem.NetOrderValue;
        newItem.SalesUnit = sboItem.SalesUnit;
        newItem.BaseUnitOfMeasure = sboItem.BaseUnitOfMeasure;
        newItem.GrossWeight = sboItem.GrossWeight;
        newItem.NetWeight = sboItem.NetWeight;
        newItem.WeightUnit = sboItem.WeightUnit;
        newItem.RejectionReason = sboItem.ReasonForRejection;
        newItem.SalesDocumentCurrency = sboItem.SalesDocumentCurrency;
        newItem.ConfigurableMaterial = sboItem.ConfigurableMaterial;
        newItem.PriceListType = sboItem.PriceListType;
        newItem.ReferenceItemNumber = sboItem.ItemReferenceDocumentItNumber;
        newItem.ReferenceDocument = sboItem.ItemReferenceDocument;
        newItem.ReferenceDocumentCategory = sboItem.ItemReferenceDocumentCtegory;
    }

    private DS_Document_Detail.PARTNERS convertSBOPartner(SBO_EnosixSalesDocument_Detail.PARTNERS sboPartner)
    {
        DS_Document_Detail.PARTNERS newPartner = new DS_Document_Detail.PARTNERS();
        newPartner.PartnerFunction = sboPartner.PartnerFunction;
        newPartner.PartnerFunctionName = sboPartner.PartnerFunctionName;
        newPartner.CustomerNumber = sboPartner.CustomerNumber;
        newPartner.Vendor = sboPartner.Vendor;
        newPartner.PersonnelNumber = sboPartner.PersonnelNumber;
        newPartner.ContactPersonNumber = sboPartner.ContactPersonNumber;
        newPartner.PartnerName = sboPartner.PartnerName;
        newPartner.PartnerName2 = sboPartner.PartnerName2;
        newPartner.HouseNumber = sboPartner.HouseNumber;
        newPartner.Street = sboPartner.Street;
        newPartner.City = sboPartner.City;
        newPartner.PostalCode = sboPartner.PostalCode;
        newPartner.Region = sboPartner.Region;
        newPartner.Country = sboPartner.Country;

        return newPartner;
    }

    private DS_Document_Detail.TEXTS convertSBOText(SBO_EnosixSalesDocument_Detail.ITEMS_TEXT sboText)
    {
        DS_Document_Detail.TEXTS newText = new DS_Document_Detail.TEXTS();
        newText.TextID = sboText.TextID;
        newText.TextLanguage = sboText.TextLanguage;
        newText.TextIDDescription = sboText.TextIDDescription;
        newText.Text = sboText.Text;

        return newText;
    }

    private DS_Document_Detail.TEXTS convertSBOText(SBO_EnosixSalesDocument_Detail.TEXTS sboText)
    {
        DS_Document_Detail.TEXTS newText = new DS_Document_Detail.TEXTS();
        newText.TextID = sboText.TextID;
        newText.TextLanguage = sboText.TextLanguage;
        newText.TextIDDescription = sboText.TextIDDescription;
        newText.Text = sboText.Text;

        return newText;
    }

    private DS_Document_Detail.CONFIG convertSBOConfig(SBO_EnosixSalesDocument_Detail.ITEMS_CONFIG sboItemConfig)
    {
        DS_Document_Detail.CONFIG newConfig = new DS_Document_Detail.CONFIG();
        newConfig.CharacteristicID = sboItemConfig.CharacteristicID;
        newConfig.CharacteristicName = sboItemConfig.CharacteristicName;
        newConfig.CharacteristicValue = sboItemConfig.CharacteristicValue;
        newConfig.CharacteristicValueDescription = sboItemConfig.CharacteristicValueDescription;
        newConfig.UserModified = true;

        return newConfig;
    }

    private DS_Document_Detail.SCHEDULE convertSBOSched(SBO_EnosixSalesDocument_Detail.ITEMS_SCHEDULE sboItemSched)
    {
        DS_Document_Detail.SCHEDULE newSched = new DS_Document_Detail.SCHEDULE();
        newSched.ScheduleLineNumber = sboItemSched.ScheduleLineNumber;
        newSched.ScheduleLineDate = sboItemSched.ScheduleLineDate;
        newSched.OrderQuantity = sboItemSched.OrderQuantity;
        newSched.RoundedQuantity = sboItemSched.RoundedQuantity;
        newSched.ConfirmedQuantity = sboItemSched.ConfirmedQuantity;
        newSched.SalesUnit = sboItemSched.SalesUnit;
        newSched.DeliveryBlock = sboItemSched.DeliveryBlock;
        newSched.DeliveryBlockDescription = sboItemSched.DeliveryBlockDescription;
        newSched.DeliveredQuantity = sboItemSched.DeliveredQuantity;
        newSched.ScheduleLineCategory = sboItemSched.ScheduleLineCategory;
        newSched.ScheduleLineCategoryDescription = sboItemSched.ScheduleLineCategoryDescription;
        newSched.PurchaseRequisitionNumber = sboItemSched.PurchaseRequisitionNumber;
        newSched.PurchaseRequisitionItemNumber = sboItemSched.PurchaseRequisitionItemNumber;

        return newSched;
    }

    // Convert the list of Incompletion logs to DS object
    private DS_Document_Detail.INCOMPLETION_LOG convertSBOIncompletionLog(SBO_EnosixSalesDocument_Detail.INCOMPLETION_LOG sboIncompletionLog)
    {
        DS_Document_Detail.INCOMPLETION_LOG newLog = new DS_Document_Detail.INCOMPLETION_LOG();
        newLog.TextID = sboIncompletionLog.TextID;
        newLog.Text = sboIncompletionLog.Description;
        
        return newLog;
    }

    // Convert List of SBO Conditions to DS Conditoins;
    private DS_Document_Detail.CONDITIONS convertSBOCondition(SBO_EnosixSalesDocument_Detail.CONDITIONS sboCondition)
    {
        DS_Document_Detail.CONDITIONS newCondition = new DS_Document_Detail.CONDITIONS();
        newCondition.ConditionCounter = sboCondition.ConditionCounter;
        newCondition.ConditionType = sboCondition.ConditionType;
        newCondition.ConditionTypeName = sboCondition.ConditionTypeName;
        newCondition.Rate = sboCondition.Rate;
        newCondition.RateUnit = sboCondition.RateUnit;
        newCondition.ConditionPricingUnit = sboCondition.ConditionPricingUnit;
        newCondition.ConditionUnit = sboCondition.ConditionUnit;
        newCondition.ConditionValue = sboCondition.ConditionValue;
        newCondition.CurrencyKey = sboCondition.CurrencyKey;
        newCondition.CalculationType = sboCondition.CalculationType;
        newCondition.OriginOfCondition = sboCondition.ConditionOrigin;
        
        return newCondition;
    }
    // #endregion Convert to DS Object mapping
}