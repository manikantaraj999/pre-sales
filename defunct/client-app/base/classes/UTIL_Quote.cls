public with sharing class UTIL_Quote
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_Quote.class);

    public static SBO_EnosixQuote_Detail.EnosixQuote getQuoteDetail(string quoteId) {
        SBO_EnosixQuote_Detail sbo = new SBO_EnosixQuote_Detail();
        return getQuoteDetail(sbo, quoteId);
    }

    public static SBO_EnosixQuote_Detail.EnosixQuote getQuoteDetail(SBO_EnosixQuote_Detail sbo, string quoteId) {
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

    public class QuoteItem {
        public SBO_EnosixQuote_Detail.ITEMS item { get; private set; }
        public SBO_EnosixQuote_Detail.ITEMS_SCHEDULE maxItemSchedule { get; private set; }
        public Boolean isSelected { get; set; }
        public Boolean isFirst { get; set; }

        public String FormattedScheduleLineDate
        {
            get
            {
                return String.valueOf(this.item.ScheduleLineDate);
            }
        }

        public Date convertedItemDate
        {
            get
            {
                return this.item.ScheduleLineDate;
            }
        }

        public QuoteItem(SBO_EnosixQuote_Detail.ITEMS item, List<SBO_EnosixQuote_Detail.ITEMS_SCHEDULE> itemSchedules,
            Integer itemIncrement, QuoteLineValue quoteLineValue)
        {
            this.item = item;
            this.maxItemSchedule = findMaxSchedule(itemSchedules);
            this.isSelected = false;
            this.isFirst = integer.valueOf(item.ItemNumber) == itemIncrement;
            if (quoteLineValue != null)
            {
            }
        }

        private SBO_EnosixQuote_Detail.ITEMS_SCHEDULE findMaxSchedule(List<SBO_EnosixQuote_Detail.ITEMS_SCHEDULE> itemSchedules)
        {
            if( itemSchedules.size() == 0 )
            {
                return null;
            }

            SBO_EnosixQuote_Detail.ITEMS_SCHEDULE maxSchedule = itemSchedules[0];

            Integer schedTot = itemSchedules.size();
            for (Integer schedCnt = 0 ; schedCnt < schedTot ; schedCnt++)
            {
                SBO_EnosixQuote_Detail.ITEMS_SCHEDULE schedule = itemSchedules[schedCnt];
                if(schedule.ScheduleLineDate > maxSchedule.ScheduleLineDate)
                {
                    maxSchedule = schedule;
                }
            }

            return maxSchedule;
        }
    }

	public class QuoteLineValue
	{
	}

    public static List<QuoteItem> convertQuoteDetailToQuoteItem(SBO_EnosixQuote_Detail.EnosixQuote quoteDetail, 
        Map<String, QuoteLineValue> quoteLineValueMap,
        Integer itemIncrement)
    {
        List<QuoteItem> convertedItems = new List<QuoteItem>();

        if(null != quoteDetail)
        {
            Map<String, SBO_EnosixQuote_Detail.ITEMS_SCHEDULE> maxItemSchedule = new Map<String, SBO_EnosixQuote_Detail.ITEMS_SCHEDULE>();
    
            List<SBO_EnosixQuote_Detail.ITEMS_SCHEDULE> schedList = quoteDetail.ITEMS_SCHEDULE.getAsList();
            Integer schedTot = schedList.size();
            for (Integer schedCnt = 0 ; schedCnt < schedTot ; schedCnt++)
            {
                SBO_EnosixQuote_Detail.ITEMS_SCHEDULE schedule = schedList[schedCnt];
                SBO_EnosixQuote_Detail.ITEMS_SCHEDULE currentSchedule = null;
                String itemNumber = schedule.ItemNumber;
                if (maxItemSchedule.containsKey(itemNumber)) 
                {
                    currentSchedule = maxItemSchedule.get(itemNumber);
                }
                if (currentSchedule == null || schedule.ScheduleLineDate > currentSchedule.ScheduleLineDate)
                {
                    maxItemSchedule.put(itemNumber, schedule);
                }
            }

            List<Integer> itemNumberList = new List<Integer>();
            Map<Integer, SBO_EnosixQuote_Detail.ITEMS> itemNumberMap = new Map<Integer, SBO_EnosixQuote_Detail.ITEMS>();
            List<SBO_EnosixQuote_Detail.ITEMS> itemList = quoteDetail.ITEMS.getAsList();
            Integer itemTot = itemList.size();
            for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
            {
                SBO_EnosixQuote_Detail.ITEMS item = itemList[itemCnt];
                Integer itemNumber = integer.valueOf(item.ItemNumber);
                itemNumberList.add(itemNumber);
                itemNumberMap.put(itemNumber, item);
            }
            itemNumberList.sort();
            itemTot = itemNumberList.size();
            for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
            {
                Integer itemNumber = itemNumberList[itemCnt];
                SBO_EnosixQuote_Detail.ITEMS item = itemNumberMap.get(itemNumber);
                List<SBO_EnosixQuote_Detail.ITEMS_SCHEDULE> matchedItemSchedules =
                    new List<SBO_EnosixQuote_Detail.ITEMS_SCHEDULE>();

                if (maxItemSchedule.containsKey(item.ItemNumber))
                {
                    matchedItemSchedules.add(maxItemSchedule.get(item.ItemNumber));
                }

                convertedItems.add( new QuoteItem(item, matchedItemSchedules, itemIncrement, quoteLineValueMap.get(item.ItemNumber.replaceFirst('^0+(?!$)', ''))));
            }
        }

        return convertedItems;
    }

    public static void CopyCustomerInfoToQuote(SBO_EnosixQuote_Detail.EnosixQuote quoteDetail, SBO_EnosixCustomer_Detail.EnosixCustomer soldToCustomer)
    {
        SBO_SFCIPartner_Search.SEARCHRESULT customerSoldTo = UTIL_Customer.getPartnerFromCustomer(soldToCustomer, UTIL_Customer.SOLD_TO_PARTNER_CODE);

        if (null != customerSoldTo)
        {
            SBO_EnosixQuote_Detail.PARTNERS orderSoldTo = getPartnerFromQuote(quoteDetail, UTIL_Customer.SOLD_TO_PARTNER_CODE, true);
            orderSoldTo.CustomerNumber = customerSoldTo.PartnerNumber;
        }
        if (String.isNotBlank(soldToCustomer.CustomerNumber))
        {
            quoteDetail.SoldToParty = soldToCustomer.CustomerNumber;
        }
    }

    public static SBO_EnosixQuote_Detail.PARTNERS getPartnerFromQuote(SBO_EnosixQuote_Detail.EnosixQuote quoteDetail, string function, boolean create)
    {
        SBO_EnosixQuote_Detail.PARTNERS result = null;
        if (quoteDetail != null)
        {
            List<SBO_EnosixQuote_Detail.PARTNERS> partnerList = quoteDetail.PARTNERS.getAsList();
            Integer partnerTot = partnerList.size();
            for (Integer partnerCnt = 0 ; partnerCnt < partnerTot ; partnerCnt++)
            {
                SBO_EnosixQuote_Detail.PARTNERS partner = partnerList[partnerCnt];
                if (function == partner.PartnerFunction)
                {
                    result = partner;
                    break;
                }
            }

            if (null == result && create)
            {
                result = new SBO_EnosixQuote_Detail.PARTNERS();
                result.PartnerFunction = function;
                quoteDetail.PARTNERS.add(result);
            }
        }

        return result;
    }

    private static transient RFC_SD_GET_DOC_TYPE_VALUES.RESULT t_docTypeMaster;
    public static RFC_SD_GET_DOC_TYPE_VALUES.RESULT docTypeMaster
    {
        get
        {
            if (null == t_docTypeMaster)
            {
                t_docTypeMaster = UTIL_RFC.getDocTypeMaster();
            }
            return t_docTypeMaster;
        }
    }

    public static RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT getQuoteMasterData(string orderTypeKey)
    {
        List<RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT> otList = docTypeMaster.ET_OUTPUT_List;
        Integer otTot = otList.size();
        for (Integer otCnt = 0 ; otCnt < otTot ; otCnt++)
        {
            RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT orderType = otList[otCnt];
            if (orderType.DocumentType == orderTypeKey) return orderType;
        }

        system.Debug('Was unable to locate Master Data matching key: ' + orderTypeKey);
        return null;
    }

    public static void initializeQuoteFromSfSObject(
        String calledFrom, 
        SObject sfSObject, 
        SBO_EnosixQuote_Detail.EnosixQuote quoteDetail, 
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap,
        Map<String, QuoteLineValue> quoteLineValueMap,
        Integer itemIncrement)
    {
        if (sfSObject == null) return;

        UTIL_SFSObjectDoc.initializeQuoteFromSfSObject(calledFrom, sfSObject, quoteDetail, sfSObjectLineIdMap, quoteLineValueMap, itemIncrement);
    }

    public static void loadSfsObjectLineIdMapFromQuote(
        String calledFrom, 
        SObject sfSObject, 
        SBO_EnosixQuote_Detail.EnosixQuote quoteDetail, 
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap)
    {
        sfSObjectLineIdMap.clear();

        if (null == sfSObject) return;

        List<SObject> solList = UTIL_SFSObjectDoc.getSObjectLineItems(sfsObject).values();
        Integer solTot = solList.size();
        List<SBO_EnosixQuote_Detail.ITEMS> itemList = quoteDetail.ITEMS.getAsList();
        Integer itemTot = itemList.size();
        for (Integer solCnt = 0 ; solCnt < solTot ; solCnt++)
        {
            SObject sfsObjectLine = solList[solCnt];
            boolean isFound = false;
            string materialNumber = UTIL_SFSObjectDoc.getMaterial(sfSObject, sfsObjectLine);
            for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
            {
                SBO_EnosixQuote_Detail.ITEMS item = itemList[itemCnt];
                if (UTIL_SFSObjectDoc.getItemNumber(sfSObject, sfsObjectLine) != null &&
                    UTIL_SFSObjectDoc.getItemNumber(sfSObject, sfsObjectLine).replaceFirst('^0+(?!$)', '') == item.ItemNumber.replaceFirst('^0+(?!$)', '')
                    && materialNumber == item.Material)
                {
                    sfSObjectLineIdMap.put(item.ItemNumber.replaceFirst('^0+(?!$)', ''), new UTIL_SFSObjectDoc.SfSObjectItem(sfsObjectLine.Id));
                    isFound = true;
                }                    
            }
            if (!isFound)
            {
                UTIL_SFSObjectDoc.SfSObjectItem sfSObjectLineId = new UTIL_SFSObjectDoc.SfSObjectItem(sfsObjectLine.Id);
                sfSObjectLineId.isDeleted = true;
                sfSObjectLineIdMap.put('NotFound' + sfsObjectLine.Id, sfSObjectLineId);
            }
        }
    }

    public static Boolean updateQuotePricingFromSfsObject(
        String calledFrom, 
        SObject sfSObject, 
        SBO_EnosixQuote_Detail.EnosixQuote quoteDetail, 
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap)
    {
        if (sfSObject == null) return false;

        return UTIL_SFSObjectDoc.updateQuotePricingFromSfsObject(calledFrom, sfSObject, quoteDetail, sfSObjectLineIdMap);
    }

    public static Boolean finalizeQuoteAndUpdateSfSobject(
        String calledFrom, 
        SObject sfSObject, 
        SBO_EnosixQuote_Detail.EnosixQuote quoteDetail, 
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap)
    {
        if (sfSObject == null) return true;

        Savepoint sp = Database.setSavepoint();
        try
        {
            // Setup
            Id pricebookId = UTIL_Pricebook.getStandardPriceBookId();
            List<SBO_EnosixQuote_Detail.ITEMS> quoteItems = quoteDetail.ITEMS.getAsList();
            Set<String> materials = getMaterialNumbersFromQuoteItems(quoteItems);

            Map<Id, PricebookEntry> productToPricebookEntryMap =
                UTIL_Pricebook.getProductIdToEntryMapForMaterials(materials, pricebookId, '');

            Map<string, Id> materialToProductIdMap =
                UTIL_Pricebook.getMaterialToProductIdMapFromPricebookEntryMap(productToPricebookEntryMap);

            // Delete removed lines
            if (isRemoveMaterial)
            {
                List<SObject> delLineItemList = new List<SObject>();
                List<UTIL_SFSObjectDoc.SfSObjectItem> solList = sfSObjectLineIdMap.values();
                Integer solTot = solList.size();
                for (Integer solCnt = 0 ; solCnt < solTot ; solCnt++)
                {
                    UTIL_SFSObjectDoc.SfSObjectItem sfsObjectItem = solList[solCnt];
                    if (sfsObjectItem.isDeleted)
                    {
                        String sObjectName = sfsObjectItem.id.getSObjectType().getDescribe().getName();
                        Type sObjType = Type.forName(sObjectName);
                        SObject delObj = (SObject) sObjType.newInstance();
                        delObj.id = sfsObjectItem.id;
                        delLineItemList.add(delObj);
                    }
                }
                delete delLineItemList;
            }

            // Create missing products and pricebook entries
            createMissingProductsAndUpdateMapFromQuoteItems(quoteItems, materialToProductIdMap);
            createMissingPricebookEntriesAndUpdatePricebookMapFromQuoteItems(
                quoteItems, pricebookId, materialToProductIdMap, productToPricebookEntryMap, '');

            UTIL_SFSObjectDoc.finalizeQuoteAndUpdateSfSObject(calledFrom, sfSObject, quoteDetail, 
                sfSObjectLineIdMap, pricebookId, quoteItems, materialToProductIdMap, productToPricebookEntryMap);
        }
        catch (Exception e)
        {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            Database.rollback(sp);
            return false;
        }
        return true;
    }

    public static void addItemToQuote(SBO_EnosixQuote_Detail.EnosixQuote quoteDetail, SBO_EnosixQuote_Detail.ITEMS item, Integer itemIncrement)
    {
        item.ItemNumber = getNextItemNumber(quoteDetail, itemIncrement);
        quoteDetail.ITEMS.add(item);

        SBO_EnosixQuote_Detail.ITEMS_ACTION action = new SBO_EnosixQuote_Detail.ITEMS_ACTION();
        action.ItemNumber = item.ItemNumber;
        action.ItemAdded = true;
        quoteDetail.ITEMS_ACTION.add(action);
    }

    public static void cloneItemToQuote(SBO_EnosixQuote_Detail.EnosixQuote quoteDetail, String cloneItemNumber, Integer itemIncrement)
    {
        String newItemNumber = getNextItemNumber(quoteDetail, itemIncrement);
        List<SBO_EnosixQuote_Detail.ITEMS> itemList = quoteDetail.ITEMS.getAsList();
        Integer itemTot = itemList.size();
        for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
        {
            SBO_EnosixQuote_Detail.ITEMS item = itemList[itemCnt];
            if (item.ItemNumber == cloneItemNumber)
            {
                SBO_EnosixQuote_Detail.ITEMS newItem = new SBO_EnosixQuote_Detail.ITEMS();
                newItem.ItemNumber = newItemNumber;
                newItem.Material = item.Material;
                newItem.ItemDescription = item.ItemDescription;
                newItem.OrderQuantity = item.OrderQuantity;
                newItem.SalesUnit = item.SalesUnit;
                newItem.NetItemPrice = item.NetItemPrice;
                newItem.Plant = item.Plant;
                newItem.ScheduleLineDate = item.ScheduleLineDate;
                newItem.ItemCategory = item.ItemCategory;
                newItem.PriceListType = item.PriceListType;
                newItem.ReasonForRejection = item.ReasonForRejection;
                newItem.ConfigurableMaterial = item.ConfigurableMaterial;
                newItem.SalesDocumentCurrency = item.SalesDocumentCurrency;
                quoteDetail.ITEMS.add(newItem);
                break;
            }
        }

        List<SBO_EnosixQuote_Detail.ITEMS_TEXT> textList = quoteDetail.ITEMS_TEXT.getAsList();
        Integer textTot = textList.size();
        for (Integer textCnt = 0 ; textCnt < textTot ; textCnt++)
        {
            SBO_EnosixQuote_Detail.ITEMS_TEXT text = textList[textCnt];
            if (text.ItemNumber == cloneItemNumber)
            {
                SBO_EnosixQuote_Detail.ITEMS_TEXT newText = new SBO_EnosixQuote_Detail.ITEMS_TEXT();
                newText.ItemNumber = newItemNumber;
                newText.TextID = text.TextID;
                newText.Text = text.Text;
                quoteDetail.ITEMS_TEXT.add(newText);
            }
        }

        SBO_EnosixQuote_Detail.ITEMS_ACTION action = new SBO_EnosixQuote_Detail.ITEMS_ACTION();
        action.ItemNumber = newItemNumber;
        action.ItemAdded= true;
        quoteDetail.ITEMS_ACTION.add(action);
    }

    @testVisible
    public static void removeItemFromQuote(
        SBO_EnosixQuote_Detail.EnosixQuote quoteDetail, 
        string itemNumber, 
        List<SBO_EnosixQuote_Detail.CONDITIONS> initConditions,
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap)
    {
        removeItemFromQuoteProcess(quoteDetail, itemNumber, initConditions, sfSObjectLineIdMap);

        List<SBO_EnosixQuote_Detail.ITEMS> itemList = quoteDetail.ITEMS.getAsList();
        Integer itemTot = itemList.size();
        for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
        {
            SBO_EnosixQuote_Detail.ITEMS item = itemList[itemCnt];
            if (item.HigherLevelItemNumber != null && item.HigherLevelItemNumber.replaceFirst('^0+(?!$)', '') == itemNumber.replaceFirst('^0+(?!$)', ''))
            {
                removeItemFromQuoteProcess(quoteDetail, item.ItemNumber, initConditions, sfSObjectLineIdMap);
            }
        }
    }

    @testVisible
    private static void removeItemFromQuoteProcess(
        SBO_EnosixQuote_Detail.EnosixQuote quoteDetail, 
        string itemNumber, 
        List<SBO_EnosixQuote_Detail.CONDITIONS> initConditions,
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap)
    {
        SBO_EnosixQuote_Detail.ITEMS_ACTION itemAction = new SBO_EnosixQuote_Detail.ITEMS_ACTION();
        itemAction.ItemNumber = itemNumber;
        itemAction.ItemDeleted= true;

        List<SBO_EnosixQuote_Detail.ITEMS_ACTION> actionList = quoteDetail.ITEMS_ACTION.getAsList();
        Integer actionTot = actionList.size();
        List<SBO_EnosixQuote_Detail.ITEMS> itemList = quoteDetail.ITEMS.getAsList();
        Integer itemTot = itemList.size();
        for (Integer actionCnt = 0 ; actionCnt < actionTot ; actionCnt++)
        {
            SBO_EnosixQuote_Detail.ITEMS_ACTION action = actionList[actionCnt];
            if (action.ItemNumber == itemNumber)
            {
                Boolean isUpdate = true;
                if (action.ItemAdded)
                {
                    for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
                    {
                        SBO_EnosixQuote_Detail.ITEMS item = itemList[itemCnt];
                        if (item.ItemNumber == itemNumber)
                        {
                            quoteDetail.ITEMS.remove(item);
                            quoteDetail.ITEMS_ACTION.remove(action);
                            itemList.remove(itemCnt);
                            itemTot--;
                            isUpdate = false;
                            break;
                        }
                    }
                }
                if (isUpdate)
                {
                    action.ItemAdded = false;
                    action.ItemChanged = false;
                    action.ItemDeleted= true;
                }
                itemAction = null;
                break;
            }
        }
        
        if (itemAction != null)
        {
            quoteDetail.ITEMS_ACTION.add(itemAction);
        }

        for (Integer condCnt = initConditions.size() - 1; condCnt >= 0 ; condCnt--)
        {
            SBO_EnosixQuote_Detail.CONDITIONS condition = initConditions[condCnt];
            if (condition.ConditionItemNumber == itemNumber)
            {
                initConditions.remove(condCnt);
            }
        }

        List<SBO_EnosixQuote_Detail.CONDITIONS> condList = quoteDetail.CONDITIONS.getAsList();
        Integer condTot = condList.size();
        for (Integer condCnt = 0 ; condCnt < condTot ; condCnt++)
        {
            SBO_EnosixQuote_Detail.CONDITIONS condition = condList[condCnt];
            if (condition.ConditionItemNumber == itemNumber)
            {
                quoteDetail.CONDITIONS.remove(condition);
            }
        }

        List<SBO_EnosixQuote_Detail.ITEMS_CONFIG> configList = quoteDetail.ITEMS_CONFIG.getAsList();
        Integer configTot = configList.size();
        for (Integer configCnt = 0 ; configCnt < configTot ; configCnt++)
        {
            SBO_EnosixQuote_Detail.ITEMS_CONFIG config = configList[configCnt];
            if (config.ItemNumber == itemNumber)
            {
                quoteDetail.ITEMS_CONFIG.remove(config);
            }
        }

        List<SBO_EnosixQuote_Detail.ITEMS_SCHEDULE> schedList = quoteDetail.ITEMS_SCHEDULE.getAsList();
        Integer schedTot = schedList.size();
        for (Integer schedCnt = 0 ; schedCnt < schedTot ; schedCnt++)
        {
            SBO_EnosixQuote_Detail.ITEMS_SCHEDULE schedule = schedList[schedCnt];
            if (schedule.ItemNumber == itemNumber)
            {
                quoteDetail.ITEMS_SCHEDULE.remove(schedule);
            }
        }

        if (sfSObjectLineIdMap.containsKey(itemNumber.replaceFirst('^0+(?!$)', '')))
        {
            UTIL_SFSObjectDoc.SfSObjectItem sfsObjectItem = sfSObjectLineIdMap.get(itemNumber.replaceFirst('^0+(?!$)', ''));
            sfsObjectItem.isDeleted = true;
            sfSObjectLineIdMap.put('NotFound' + sfsObjectItem.id, sfsObjectItem);
            sfSObjectLineIdMap.remove(itemNumber.replaceFirst('^0+(?!$)', ''));
        }
    }

    public static string getNextItemNumber(SBO_EnosixQuote_Detail.EnosixQuote quoteDetail, Integer itemIncrement)
    {
        Integer nextItemNumberMax = 0;
        List<SBO_EnosixQuote_Detail.ITEMS> itemList = quoteDetail.ITEMS.getAsList();
        Integer itemTot = itemList.size();
        for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
        {
            SBO_EnosixQuote_Detail.ITEMS item = itemList[itemCnt];
            integer itemNumber = integer.valueOf(item.ItemNumber);
            nextItemNumberMax = Math.max(nextItemNumberMax, itemNumber);
        }
        List<SBO_EnosixQuote_Detail.ITEMS_ACTION> actionList = quoteDetail.ITEMS_ACTION.getAsList();
        Integer actionTot = actionList.size();
        for (Integer actionCnt = 0 ; actionCnt < actionTot ; actionCnt++)
        {
            SBO_EnosixQuote_Detail.ITEMS_ACTION action = actionList[actionCnt];
            integer itemNumber = integer.valueOf(action.ItemNumber);
            nextItemNumberMax = Math.max(nextItemNumberMax, itemNumber);
        }
        nextItemNumberMax = nextItemNumberMax + itemIncrement;
        return string.ValueOf(nextItemNumberMax).leftPad(6,'0');
    }

    @testVisible
    public static SBO_EnosixQuote_Detail.ITEMS getItemFromQuoteByItemNumber(SBO_EnosixQuote_Detail.EnosixQuote quoteDetail, string itemNumber)
    {
        if (quoteDetail != null)
        {
            List<SBO_EnosixQuote_Detail.ITEMS> itemList = quoteDetail.ITEMS.getAsList();
            Integer itemTot = itemList.size();
            for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
            {
                SBO_EnosixQuote_Detail.ITEMS item = itemList[itemCnt];
                if (itemNumber == item.ItemNumber)
                {
                    return item;
                }
            }
        }
        return null;
    }

    public static Boolean isRequestedShipEnabled
    {
        get
        {
            return (Boolean)UTIL_AppSettings.getValue('Quote.IsRequestedShipEnabled', true);
        }
    }

    // Given a list of quote items, return a set of the item.Material values
    public static Set<String> getMaterialNumbersFromQuoteItems(
        List<SBO_EnosixQuote_Detail.ITEMS> quoteItems)
    {
        Set<String> result = new Set<String>();
        Integer itemTot = quoteItems.size();
        for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
        {
            SBO_EnosixQuote_Detail.ITEMS item = quoteItems[itemCnt];
            result.add(item.Material);
        }
        return result;
    }

    // createMissingProductsAndUpdateMapFromQuoteItems()
    //
    // Loop over the given quote items and create/insert new Product2s for any materials
    // not in the map, and update the map with the new products
    public static void createMissingProductsAndUpdateMapFromQuoteItems(
        List<SBO_EnosixQuote_Detail.ITEMS> quoteItems, Map<string, Id> materialToProductIdMap)
    {
        List<Product2> productList = new List<Product2>();

        // Make a list of products we need to create
        Integer itemTot = quoteItems.size();
        for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
        {
            SBO_EnosixQuote_Detail.ITEMS item = quoteItems[itemCnt];
            if (!materialToProductIdMap.containsKey(item.Material))
            {
                Product2 product = createProductFromQuoteItem(item);
                productList.add(product);
                // Remove from map, and we will re-add after the upsert
                materialToProductIdMap.put(item.Material, null);
            }
        }

        // Add them to the db
        upsert productList;

        // Add all the new products to the map
        Integer prodTot = productList.size();
        for (Integer prodCnt = 0 ; prodCnt < prodTot ; prodCnt++)
        {
            Product2 product = productList[prodCnt];
            // The product name is the material
            materialToProductIdMap.put(product.Name, product.Id);
        }
    }

    // createProductFromQuoteItem()
    //
    // Construct and return a new Product2 object from a quote item
    private static Product2 createProductFromQuoteItem(SBO_EnosixQuote_Detail.ITEMS item)
    {
        Product2 result = new Product2(
            Description = item.ItemDescription,
            Name = item.Material,
            ProductCode = item.Material,
            IsActive = true
        );
        UTIL_SFProduct.setProductMaterialNumber(result, item.Material);

        return result;
    }

    // createMissingPricebookEntriesAndUpdatePricebookMapFromQuoteItems()
    //
    // Loop over the given quote items and create/insert new PricebookEntry objects for any
    // materials not in the productToPricebookEntryMap, and update the map with the new entries
    public static void createMissingPricebookEntriesAndUpdatePricebookMapFromQuoteItems(
        List<SBO_EnosixQuote_Detail.ITEMS> quoteItems,
        Id pricebookId,
        Map<string, Id> materialToProductIdMap,
        Map<Id, PricebookEntry> productToPricebookEntryMap,
        String currencyIsoCode)
    {
        List<PricebookEntry> priceList = new List<PricebookEntry>();

        // Make a list of pricebook entries we need to create
        Integer itemTot = quoteItems.size();
        for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
        {
            SBO_EnosixQuote_Detail.ITEMS item = quoteItems[itemCnt];
            Id productId = materialToProductIdMap.get(item.Material);
            PricebookEntry price = productToPricebookEntryMap.get(productId);

            if (null == price)
            {
                price = new PricebookEntry(
                    Pricebook2Id = pricebookId,
                    Product2Id = productId,
                    UnitPrice = 0,
                    IsActive = true,
                    UseStandardPrice = false
                );
                priceList.add(price);
                // This fixes issue where the same material added twice causes DUPLICATE_VALUE error
                productToPricebookEntryMap.put(productId, price);
            }
        }

        upsert priceList;

        // Add all the new prices to the map
        Integer priceTot = priceList.size();
        for (Integer priceCnt = 0 ; priceCnt < priceTot ; priceCnt++)
        {
            PricebookEntry price = priceList[priceCnt];
            productToPricebookEntryMap.put(price.Product2Id, price);
        }
    }

    public static Boolean isAddMaterial { get { return (Boolean) UTIL_AppSettings.getValue('Quote.AddMaterial', true); } }
    public static Boolean isRemoveMaterial { get { return (Boolean) UTIL_AppSettings.getValue('Quote.RemoveMaterial', true); } }
    public static Boolean isEditMaterial { get { return (Boolean) UTIL_AppSettings.getValue('Quote.EditMaterial', true); } }
    public static Boolean isCloneMaterial { get { return (Boolean) UTIL_AppSettings.getValue('Quote.CloneMaterial', true); } }
    public static Boolean isMoveMaterial { get { return (Boolean) UTIL_AppSettings.getValue('Quote.MoveMaterial', true); } }
    public static Boolean isSelectMaterial { get { return isRemoveMaterial || isEditMaterial || isCloneMaterial || isMoveMaterial; } }
}