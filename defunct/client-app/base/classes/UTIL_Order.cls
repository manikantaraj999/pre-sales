public with sharing class UTIL_Order
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_Order.class);

    public class OrderItem
    {
        public SBO_EnosixSO_Detail.ITEMS item { get; private set; }
        public SBO_EnosixSO_Detail.ITEMS_SCHEDULE maxItemSchedule { get; private set; }
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

        public OrderItem ( SBO_EnosixSO_Detail.ITEMS item, List<SBO_EnosixSO_Detail.ITEMS_SCHEDULE> itemSchedules,
            Integer itemIncrement, OrderLineValue orderLineValue)
        {
            this.item = item;
            maxItemSchedule = findMaxSchedule(itemSchedules);
            this.isSelected = false;
            this.isFirst = integer.valueOf(item.ItemNumber) == itemIncrement;
            if (orderLineValue != null)
            {
            }
        }

        private SBO_EnosixSO_Detail.ITEMS_SCHEDULE findMaxSchedule(List<SBO_EnosixSO_Detail.ITEMS_SCHEDULE> itemSchedules)
        {
            if( itemSchedules.size() == 0 )
            {
                return null;
            }

            SBO_EnosixSO_Detail.ITEMS_SCHEDULE maxSchedule = itemSchedules[0];

            Integer schedTot = itemSchedules.size();
            for (Integer schedCnt = 0 ; schedCnt < schedTot ; schedCnt++)
            {
                SBO_EnosixSO_Detail.ITEMS_SCHEDULE schedule = itemSchedules[schedCnt];
                if(schedule.ScheduleLineDate > maxSchedule.ScheduleLineDate)
                {
                    maxSchedule = schedule;
                }
            }

            return maxSchedule;
        }
    }

	public class OrderLineValue
	{
	}

    public static List<OrderItem> convertOrderDetailToOrderItem(SBO_EnosixSO_Detail.EnosixSO orderDetail,
        Map<String, OrderLineValue> orderLineValueMap,
        Integer itemIncrement)
    {
        List<OrderItem> convertedItems = new List<OrderItem>();

        if(null != orderDetail)
        {
            Map<String, SBO_EnosixSO_Detail.ITEMS_SCHEDULE> maxItemSchedule = new Map<String, SBO_EnosixSO_Detail.ITEMS_SCHEDULE>();
    
            List<SBO_EnosixSO_Detail.ITEMS_SCHEDULE> schedList = orderDetail.ITEMS_SCHEDULE.getAsList();
            Integer schedTot = schedList.size();
            for (Integer schedCnt = 0 ; schedCnt < schedTot ; schedCnt++)
            {
                SBO_EnosixSO_Detail.ITEMS_SCHEDULE schedule = schedList[schedCnt];
                SBO_EnosixSO_Detail.ITEMS_SCHEDULE currentSchedule = null;
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
            Map<Integer, SBO_EnosixSO_Detail.ITEMS> itemNumberMap = new Map<Integer, SBO_EnosixSO_Detail.ITEMS>();
            List<SBO_EnosixSO_Detail.ITEMS> itemList = orderDetail.ITEMS.getAsList();
            Integer itemTot = itemList.size();
            for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
            {
                SBO_EnosixSO_Detail.ITEMS item = itemList[itemCnt];
                Integer itemNumber = integer.valueOf(item.ItemNumber);
                itemNumberList.add(itemNumber);
                itemNumberMap.put(itemNumber, item);
            }
            itemNumberList.sort();
            itemTot = itemNumberList.size();
            for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
            {
                Integer itemNumber = itemNumberList[itemCnt];
                SBO_EnosixSO_Detail.ITEMS item = itemNumberMap.get(itemNumber);
                List<SBO_EnosixSO_Detail.ITEMS_SCHEDULE> matchedItemSchedules =
                    new List<SBO_EnosixSO_Detail.ITEMS_SCHEDULE>();

                if (maxItemSchedule.containsKey(item.ItemNumber))
                {
                    matchedItemSchedules.add(maxItemSchedule.get(item.ItemNumber));
                }

                convertedItems.add( new OrderItem(item, matchedItemSchedules, itemIncrement, orderLineValueMap.get(item.ItemNumber.replaceFirst('^0+(?!$)', ''))));
            }
        }

        return convertedItems;
    }

    public static void CopyCustomerInfoToOrder(SBO_EnosixSO_Detail.EnosixSO orderDetail, SBO_EnosixCustomer_Detail.EnosixCustomer soldToCustomer)
    {

        SBO_SFCIPartner_Search.SEARCHRESULT customerSoldTo = UTIL_Customer.getPartnerFromCustomer(soldToCustomer, UTIL_Customer.SOLD_TO_PARTNER_CODE);

        if (null != customerSoldTo)
        {
            SBO_EnosixSO_Detail.PARTNERS orderSoldTo = getPartnerFromOrder(orderDetail, UTIL_Customer.SOLD_TO_PARTNER_CODE, true);
            orderSoldTo.CustomerNumber = customerSoldTo.PartnerNumber;
        }

        if (String.isNotBlank(soldToCustomer.CustomerNumber))
        {
            orderDetail.SoldToParty = soldToCustomer.CustomerNumber;
        }
    }

    public static SBO_EnosixSO_Detail.PARTNERS getPartnerFromOrder(SBO_EnosixSO_Detail.EnosixSO orderDetail, string function, boolean create)
    {
        SBO_EnosixSO_Detail.PARTNERS result = null;
        if (orderDetail != null)
        {
            List<SBO_EnosixSO_Detail.PARTNERS> partnerList = orderDetail.PARTNERS.getAsList();
            Integer partnerTot = partnerList.size();
            for (Integer partnerCnt = 0 ; partnerCnt < partnerTot ; partnerCnt++)
            {
                SBO_EnosixSO_Detail.PARTNERS partner = partnerList[partnerCnt];
                if (function == partner.PartnerFunction)
                {
                    result = partner;
                    break;
                }
            }

            if (null == result && create)
            {
                result = new SBO_EnosixSO_Detail.PARTNERS();
                result.PartnerFunction = function;
                orderDetail.PARTNERS.add(result);
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

    public static RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT getOrderMasterData(string orderTypeKey)
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

    public static void initializeOrderFromSfSObject(
        String calledFrom, 
        SObject sfSObject, 
        SBO_EnosixSO_Detail.EnosixSO orderDetail, 
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap,
        Map<String, OrderLineValue> orderLineValueMap,
        Integer itemIncrement)
    {
        if (sfSObject == null) return;

        UTIL_SFSObjectDoc.initializeOrderFromSfSObject(calledFrom, sfSObject, orderDetail, sfSObjectLineIdMap, orderLineValueMap, itemIncrement);
    }

    public static void loadSfsObjectLineIdMapFromOrder(
        String calledFrom, 
        SObject sfSObject, 
        SBO_EnosixSO_Detail.EnosixSO orderDetail, 
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap)
    {
        sfSObjectLineIdMap.clear();

        if (null == sfSObject) return;

        List<SObject> solList = UTIL_SFSObjectDoc.getSObjectLineItems(sfsObject).values();
        Integer solTot = solList.size();
        List<SBO_EnosixSO_Detail.ITEMS> itemList = orderDetail.ITEMS.getAsList();
        Integer itemTot = itemList.size();
        for (Integer solCnt = 0 ; solCnt < solTot ; solCnt++)
        {
            SObject sfsObjectLine = solList[solCnt];
            boolean isFound = false;
            string materialNumber = UTIL_SFSObjectDoc.getMaterial(sfSObject, sfsObjectLine);
            for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
            {
                SBO_EnosixSO_Detail.ITEMS item = itemList[itemCnt];
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

    public static Boolean updateOrderPricingFromSfsObject(
        String calledFrom, 
        SObject sfSObject, 
        SBO_EnosixSO_Detail.EnosixSO orderDetail, 
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap)
    {
        if (sfSObject == null) return false;

        return UTIL_SFSObjectDoc.updateOrderPricingFromSfsObject(calledFrom, sfSObject, orderDetail, sfSObjectLineIdMap);
    }

    public static Boolean finalizeOrderAndUpdateSfSobject(
        String calledFrom, 
        SObject sfSObject, 
        SBO_EnosixSO_Detail.EnosixSO orderDetail, 
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap)
    {
        if (sfSObject == null) return true;

        Savepoint sp = Database.setSavepoint();
        try
        {
            // Setup
            Id pricebookId = UTIL_Pricebook.getStandardPriceBookId();
            List<SBO_EnosixSO_Detail.ITEMS> orderItems = orderDetail.ITEMS.getAsList();
            Set<String> materials = getMaterialNumbersFromOrderItems(orderItems);

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
            createMissingProductsAndUpdateMapFromOrderItems(orderItems, materialToProductIdMap);
            createMissingPricebookEntriesAndUpdatePricebookMapFromOrderItems(
                orderItems, pricebookId, materialToProductIdMap, productToPricebookEntryMap, '');

            UTIL_SFSObjectDoc.finalizeOrderAndUpdateSfSObject(calledFrom, sfSObject, orderDetail, 
                sfSObjectLineIdMap, pricebookId, orderItems, materialToProductIdMap, productToPricebookEntryMap);
        }
        catch (Exception e)
        {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            Database.rollback(sp);
            return false;
        }
        return true;
    }

    public static void addItemToOrder(SBO_EnosixSO_Detail.EnosixSO orderDetail, SBO_EnosixSO_Detail.ITEMS item, Integer itemIncrement)
    {
        item.ItemNumber = getNextItemNumber(orderDetail, itemIncrement);
        orderDetail.ITEMS.add(item);

        SBO_EnosixSO_Detail.ITEMS_ACTION action = new SBO_EnosixSO_Detail.ITEMS_ACTION();
        action.ItemNumber = item.ItemNumber;
        action.ItemAdded = true;
        orderDetail.ITEMS_ACTION.add(action);
    }

    public static void cloneItemToOrder(SBO_EnosixSO_Detail.EnosixSO orderDetail, String cloneItemNumber, Integer itemIncrement)
    {
        String newItemNumber = getNextItemNumber(orderDetail, itemIncrement);
        List<SBO_EnosixSO_Detail.ITEMS> itemList = orderDetail.ITEMS.getAsList();
        Integer itemTot = itemList.size();
        for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
        {
            SBO_EnosixSO_Detail.ITEMS item = itemList[itemCnt];
            if (item.ItemNumber == cloneItemNumber)
            {
                SBO_EnosixSO_Detail.ITEMS newItem = new SBO_EnosixSO_Detail.ITEMS();
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
                orderDetail.ITEMS.add(newItem);
                break;
            }
        }

        List<SBO_EnosixSO_Detail.ITEMS_TEXT> textList = orderDetail.ITEMS_TEXT.getAsList();
        Integer textTot = textList.size();
        for (Integer textCnt = 0 ; textCnt < textTot ; textCnt++)
        {
            SBO_EnosixSO_Detail.ITEMS_TEXT text = textList[textCnt];
            if (text.ItemNumber == cloneItemNumber)
            {
                SBO_EnosixSO_Detail.ITEMS_TEXT newText = new SBO_EnosixSO_Detail.ITEMS_TEXT();
                newText.ItemNumber = newItemNumber;
                newText.TextID = text.TextID;
                newText.Text = text.Text;
                orderDetail.ITEMS_TEXT.add(newText);
            }
        }

        SBO_EnosixSO_Detail.ITEMS_ACTION action = new SBO_EnosixSO_Detail.ITEMS_ACTION();
        action.ItemNumber = newItemNumber;
        action.ItemAdded= true;
        orderDetail.ITEMS_ACTION.add(action);
    }

    @testVisible
    public static void removeItemFromOrder(
        SBO_EnosixSO_Detail.EnosixSO orderDetail, 
        string itemNumber, 
        List<SBO_EnosixSO_Detail.CONDITIONS> initConditions,
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap)
    {
        removeItemFromOrderProcess(orderDetail, itemNumber, initConditions, sfSObjectLineIdMap);

        List<SBO_EnosixSO_Detail.ITEMS> itemList = orderDetail.ITEMS.getAsList();
        Integer itemTot = itemList.size();
        for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
        {
            SBO_EnosixSO_Detail.ITEMS item = itemList[itemCnt];
            if (item.HigherLevelItemNumber != null && item.HigherLevelItemNumber.replaceFirst('^0+(?!$)', '') == itemNumber.replaceFirst('^0+(?!$)', ''))
            {
                removeItemFromOrderProcess(orderDetail, item.ItemNumber, initConditions, sfSObjectLineIdMap);
            }
        }
    }

    @testVisible
    private static void removeItemFromOrderProcess(
        SBO_EnosixSO_Detail.EnosixSO orderDetail, 
        string itemNumber, 
        List<SBO_EnosixSO_Detail.CONDITIONS> initConditions,
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap)
    {
        SBO_EnosixSO_Detail.ITEMS_ACTION itemAction = new SBO_EnosixSO_Detail.ITEMS_ACTION();
        itemAction.ItemNumber = itemNumber;
        itemAction.ItemDeleted= true;

        List<SBO_EnosixSO_Detail.ITEMS_ACTION> actionList = orderDetail.ITEMS_ACTION.getAsList();
        Integer actionTot = actionList.size();
        List<SBO_EnosixSO_Detail.ITEMS> itemList = orderDetail.ITEMS.getAsList();
        Integer itemTot = itemList.size();
        for (Integer actionCnt = 0 ; actionCnt < actionTot ; actionCnt++)
        {
            SBO_EnosixSO_Detail.ITEMS_ACTION action = actionList[actionCnt];
            if (action.ItemNumber == itemNumber)
            {
                Boolean isUpdate = true;
                if (action.ItemAdded)
                {
                    for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
                    {
                        SBO_EnosixSO_Detail.ITEMS item = itemList[itemCnt];
                        if (item.ItemNumber == itemNumber)
                        {
                            orderDetail.ITEMS.remove(item);
                            orderDetail.ITEMS_ACTION.remove(action);
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
            orderDetail.ITEMS_ACTION.add(itemAction);
        }

        for (Integer condCnt = initConditions.size() - 1; condCnt >= 0 ; condCnt--)
        {
            SBO_EnosixSO_Detail.CONDITIONS condition = initConditions[condCnt];
            if (condition.ConditionItemNumber == itemNumber)
            {
                initConditions.remove(condCnt);
            }
        }

        List<SBO_EnosixSO_Detail.CONDITIONS> condList = orderDetail.CONDITIONS.getAsList();
        Integer condTot = condList.size();
        for (Integer condCnt = 0 ; condCnt < condTot ; condCnt++)
        {
            SBO_EnosixSO_Detail.CONDITIONS condition = condList[condCnt];
            if (condition.ConditionItemNumber == itemNumber)
            {
                orderDetail.CONDITIONS.remove(condition);
            }
        }

        List<SBO_EnosixSO_Detail.ITEMS_CONFIG> configList = orderDetail.ITEMS_CONFIG.getAsList();
        Integer configTot = configList.size();
        for (Integer configCnt = 0 ; configCnt < configTot ; configCnt++)
        {
            SBO_EnosixSO_Detail.ITEMS_CONFIG config = configList[configCnt];
            if (config.ItemNumber == itemNumber)
            {
                orderDetail.ITEMS_CONFIG.remove(config);
            }
        }

        List<SBO_EnosixSO_Detail.ITEMS_SCHEDULE> schedList = orderDetail.ITEMS_SCHEDULE.getAsList();
        Integer schedTot = schedList.size();
        for (Integer schedCnt = 0 ; schedCnt < schedTot ; schedCnt++)
        {
            SBO_EnosixSO_Detail.ITEMS_SCHEDULE schedule = schedList[schedCnt];
            if (schedule.ItemNumber == itemNumber)
            {
                orderDetail.ITEMS_SCHEDULE.remove(schedule);
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
    
    @testVisible
    public static string getNextItemNumber(SBO_EnosixSO_Detail.EnosixSO orderDetail, Integer itemIncrement)
    {
        Integer nextItemNumberMax = 0;
        List<SBO_EnosixSO_Detail.ITEMS> itemList = orderDetail.ITEMS.getAsList();
        Integer itemTot = itemList.size();
        for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
        {
            SBO_EnosixSO_Detail.ITEMS item = itemList[itemCnt];
            integer itemNumber = integer.valueOf(item.ItemNumber);
            nextItemNumberMax = Math.max(nextItemNumberMax, itemNumber);
        }
        List<SBO_EnosixSO_Detail.ITEMS_ACTION> actionList = orderDetail.ITEMS_ACTION.getAsList();
        Integer actionTot = actionList.size();
        for (Integer actionCnt = 0 ; actionCnt < actionTot ; actionCnt++)
        {
            SBO_EnosixSO_Detail.ITEMS_ACTION action = actionList[actionCnt];
            integer itemNumber = integer.valueOf(action.ItemNumber);
            nextItemNumberMax = Math.max(nextItemNumberMax, itemNumber);
        }
        nextItemNumberMax = nextItemNumberMax + itemIncrement;
        return string.ValueOf(nextItemNumberMax).leftPad(6,'0');
    }

    public static SBO_EnosixSO_Detail.ITEMS getItemFromOrderByItemNumber(SBO_EnosixSO_Detail.EnosixSO orderDetail, string itemNumber)
    {
        if (orderDetail != null)
        {
            List<SBO_EnosixSO_Detail.ITEMS> itemList = orderDetail.ITEMS.getAsList();
            Integer itemTot = itemList.size();
            for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
            {
                SBO_EnosixSO_Detail.ITEMS item = itemList[itemCnt];
                if (itemNumber == item.ItemNumber)
                {
                    return item;
                }
            }
        }
        return null;
    }

    public static Boolean isShipToPartnerAddressDisplayed
    {
        get
        {
            return (Boolean)UTIL_AppSettings.getValue('Order.IsShipToPartnerAddressDisplayed', true);
        }
    }

    public static Boolean isCardLimitEnabled
    {
        get
        {
            return (Boolean)UTIL_AppSettings.getValue('Order.IsCardLimitEnabled', false);
        }
    }

    private static Set<String> orderTypesWithCreditCardSectionHidden
    {
        get
        {
            return (Set<String>)UTIL_AppSettings.getSet(
                'Order.OrderTypesWithCreditCardSectionHidden', String.class, new Set<String>{ });
        }
    }

    private static Set<String> orderTypesWithCreditCardEntryHidden
    {
        get
        {
            return (Set<String>)UTIL_AppSettings.getSet(
                'Order.OrderTypesWithCreditCardEntryHidden', String.class, new Set<String>{ });
        }
    }

    public static Map<String, Set<String>> allowedItemCategoriesByOrderType
    {
        get
        {
            return (Map<String, Set<String>>)UTIL_AppSettings.getMap(
                'Order.AllowedItemCategoriesByOrderType',
                String.class,
                Set<String>.class,
                new Map<String, Set<String>>()
            );
        }
    }

    // getDisplayCreditCardSection()
    //
    // Determines whether or not to display the credit card section on page based on order type.
    public static Boolean getDisplayCreditCardSection(String orderType)
    {
        return !orderTypesWithCreditCardSectionHidden.contains(orderType);
    }

    // getDisplayCreditCardEntry()
    //
    // Determines whether or not to display the credit card entry control on page based on order type.
    public static Boolean getDisplayCreditCardEntry(String orderType)
    {
        return !orderTypesWithCreditCardEntryHidden.contains(orderType);
    }

    // Given a list of quote items, return a set of the item.Material values
    public static Set<String> getMaterialNumbersFromOrderItems(
        List<SBO_EnosixSO_Detail.ITEMS> orderItems)
    {
        Set<String> result = new Set<String>();
        Integer itemTot = orderItems.size();
        for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
        {
            SBO_EnosixSO_Detail.ITEMS item = orderItems[itemCnt];
            result.add(item.Material);
        }
        return result;
    }

    // createMissingProductsAndUpdateMapFromOrderItems()
    //
    // Loop over the given order items and create/insert new Product2s for any materials
    // not in the map, and update the map with the new products
    public static void createMissingProductsAndUpdateMapFromOrderItems(
        List<SBO_EnosixSO_Detail.ITEMS> orderItems, Map<string, Id> materialToProductIdMap)
    {
        List<Product2> productList = new List<Product2>();

        // Make a list of products we need to create
        Integer itemTot = orderItems.size();
        for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
        {
            SBO_EnosixSO_Detail.ITEMS item = orderItems[itemCnt];
            if (!materialToProductIdMap.containsKey(item.Material))
            {
                Product2 product = createProductFromOrderItem(item);
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

    // createProductFromOrderItem()
    //
    // Construct and return a new Product2 object from a quote item
    private static Product2 createProductFromOrderItem(SBO_EnosixSO_Detail.ITEMS item)
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

    // createMissingPricebookEntriesAndUpdatePricebookMapFromOrderItems()
    //
    // Loop over the given order items and create/insert new PricebookEntry objects for any
    // materials not in the productToPricebookEntryMap, and update the map with the new entries
    public static void createMissingPricebookEntriesAndUpdatePricebookMapFromOrderItems(
        List<SBO_EnosixSO_Detail.ITEMS> orderItems,
        Id pricebookId,
        Map<string, Id> materialToProductIdMap,
        Map<Id, PricebookEntry> productToPricebookEntryMap,
        String currencyIsoCode)
    {
        List<PricebookEntry> priceList = new List<PricebookEntry>();

        // Make a list of pricebook entries we need to create
        Integer itemTot = orderItems.size();
        for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
        {
            SBO_EnosixSO_Detail.ITEMS item = orderItems[itemCnt];
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

    public static Boolean isAddMaterial { get { return (Boolean) UTIL_AppSettings.getValue('Order.AddMaterial', true); } }
    public static Boolean isRemoveMaterial { get { return (Boolean) UTIL_AppSettings.getValue('Order.RemoveMaterial', true); } }
    public static Boolean isEditMaterial { get { return (Boolean) UTIL_AppSettings.getValue('Order.EditMaterial', true); } }
    public static Boolean isCloneMaterial { get { return (Boolean) UTIL_AppSettings.getValue('Order.CloneMaterial', true); } }
    public static Boolean isMoveMaterial { get { return (Boolean) UTIL_AppSettings.getValue('Order.MoveMaterial', true); } }
    public static Boolean isSelectMaterial { get { return isRemoveMaterial || isEditMaterial || isCloneMaterial || isMoveMaterial; } }
}