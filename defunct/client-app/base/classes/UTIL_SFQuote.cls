public with sharing class UTIL_SFQuote implements I_SFSObjectDoc
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_SFQuote.class);

    private SObject loadedSObject;
    private string loadedId;
    private string loadedSapType;
    private string loadedSapDocNum;
    private Map<Id, SObject> loadedLineMap;

	public SObject getSObject(String id)
	{
        return getSObject(id, null, null);
    }

	public SObject getSObject(String sapType, String sapDocNum)
	{
        return getSObject(null, sapType, sapDocNum);
    }

	private SObject getSObject(String id, String sapType, String sapDocNum)
	{
		SObject result = null;
        
        Boolean isIdMatch = (loadedId == id || (String.isNotEmpty(Id) && String.isNotEmpty(loadedId) && (loadedId.startsWith(id) || id.startsWith(loadedId))));
        if (loadedSObject != null && (isIdMatch || (loadedSapType == sapType && loadedSapDocNum == sapDocNum)))
        {
            return loadedSObject;
        }
        loadedId = id;
        loadedSapType = sapType;
        loadedSapDocNum = sapDocNum;
        loadedLineMap = null;
        
        string errorString = '';
        if (String.isNotEmpty(id) || (String.isNotEmpty(sapType) && String.isNotEmpty(sapDocNum)))
        {
            try
            {
                string selectCmd = 'SELECT Id, Name, Description, OpportunityId, Pricebook2Id, SAP_SaveSalesDocHeader__c, AccountId,' +
                    ' Account.' + UTIL_SFAccount.CustomerFieldName + ', FLD_SAP_Quote_Number__c, FLD_SalesDocStatus__c FROM Quote';

                if (String.isNotEmpty(id))
                {
                    selectCmd += ' WHERE Id = \'' + id + '\'';
                    errorString = ' for the provided Id ' + id;
                }
                else
                {
                    if (sapType == 'Quote')
                    {
                        selectCmd += ' WHERE FLD_SAP_Quote_Number__c = \'' + sapDocNum + '\'';
                        errorString = ' for the provided SAP Quote Number ' + sapDocNum;
                    }
                    else
                    {
                        selectCmd = null;
                    }
                }
                if (selectCmd != null)
                {
                    selectCmd += ' Limit 1';

                    List<SObject> resultList = Database.query(selectCmd);

                    if (resultList.size() > 0)
                    {
                        result = resultList[0];
                        loadedId = result.Id;
                    }
                }
            }
            catch (Exception e)
            {
                UTIL_PageMessages.addExceptionMessage(e);
            }
        }

        if (result == null && String.isNotEmpty(id))
        {
            UTIL_PageMessages.addMessage(UTIL_PageMessages.ERROR, 
                'There was an issue retrieving an Quote record: ' + errorString);
        }

        loadedSObject = result;
		return result;
	}

	public Map<Id, SObject> getSObjectLineItems(String id)
	{
        Boolean isIdMatch = (loadedId == id || (String.isNotEmpty(Id) && String.isNotEmpty(loadedId) && (loadedId.startsWith(id) || id.startsWith(loadedId))));
        if (loadedLineMap != null && isIdMatch)
        {
            return loadedLineMap;
        }

        loadedId = id;

		Map<Id, SObject> lineMap = new Map<Id, SObject>();

		try
		{
            string selectCmd = 'SELECT Id, QuoteId, SortOrder, PricebookEntryId, Product2Id, Product2.Name, SAP_SaveSalesDocItem__c, Product2.' + UTIL_SFProduct.MaterialFieldName + ',' +
                        ' Quantity, TotalPrice, UnitPrice, ListPrice, ServiceDate, Description, LineNumber, FLD_SAP_Item_Number__c, Product2.FLD_Configurable_Material__c' +
                        ' FROM QuoteLineItem WHERE QuoteId = :id ORDER BY FLD_SAP_Item_Number__c ASC';

            List<SObject> lineList = Database.query(selectCmd);
            
            Integer lineTot = lineList.size();
            for (Integer lineCnt = 0 ; lineCnt < lineTot ; lineCnt++)
			{
                SObject lineItem = lineList[lineCnt];
				lineMap.put(lineItem.Id, lineItem);
			}

		}
		catch (Exception e)
		{
			UTIL_PageMessages.addExceptionMessage(e);
		}
        loadedLineMap = lineMap;
        return lineMap;
	}
	
	public Map<Id, SObject> getSObjectContacts(String id)
	{
		//Implement to get Contact link to SObject
		return new Map<Id, SObject>();
	}
    
	public String getAccountId(SObject sfSObject)
	{
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'Quote' ? null : ((Quote) sfSObject).AccountId;
	}

    public String getCustomerNumber(SObject sfSObject)
	{
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'Quote' || ((Quote) sfSObject).Account == null ? null : (String) ((Quote) sfSObject).Account.get(UTIL_SFAccount.CustomerFieldName);
	}

	public String getName(SObject sfSObject)
	{
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'Quote' ? '' : ((Quote) sfSObject).Name;
	}

    public String getQuoteNumber(SObject sfSObject)
    {
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'Quote' ? '' : ((Quote) sfSObject).FLD_SAP_Quote_Number__c;
    }

    public String getOrderNumber(SObject sfSObject)
    {
        return '';
    }

    public String getContractNumber(SObject sfSObject)
    {
        return '';
    }

    public String getStatus(SObject sfSObject)
    {
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'Quote' ? '' : ((Quote) sfSObject).FLD_SalesDocStatus__c;
    }

    public String getOpportunityId(SObject sfSObject)
    {
        return getOpportunity(sfsObject) == null ? null :  getOpportunity(sfsObject).Id;
    }

    public Opportunity getOpportunity(SObject sfSObject)
    {
        UTIL_SFOpportunity sfOpportunity = new UTIL_SFOpportunity();
        return sfSObject == null ? null : (Opportunity) sfOpportunity.getSObject(((Quote) sfSObject).OpportunityId);
    }

    public Id getPriceBookId(SObject sfSObject)
    {
        Id pricebookId;
        if (sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'Quote') {
            return null;
        }
        else pricebookId = ((Quote) sfSObject).Pricebook2Id;

        if (String.isEmpty(pricebookId)) pricebookId = UTIL_Pricebook.getStandardPriceBookId();

        return pricebookId;
    }

    public Id getProductId(SObject sfsObjectLine)
    {
        return sfsObjectLine == null || sfsObjectLine.getSObjectType().getDescribe().getName() != 'QuoteLineItem' ? null : ((QuoteLineItem) sfsObjectLine).Product2Id;
    }

    private Map<Id, String> productSAPMaterialNumberList;

    public String getMaterial(SObject sfSObject, SObject sfsObjectLine)
    {
        if (productSAPMaterialNumberList == null)
        {
            productSAPMaterialNumberList = UTIL_SFSObjectDoc.loadProductSAPMaterialNumberList(sfsObject);
        }
        String material = productSAPMaterialNumberList.get(getProductId(sfsObjectLine));
        return material == null ? '' : material;
    }

    public String getItemNumber(SObject sfsObjectLine)
    {
        return sfsObjectLine == null || sfsObjectLine.getSObjectType().getDescribe().getName() != 'QuoteLineItem' ? '' : ((QuoteLineItem) sfsObjectLine).FLD_SAP_Item_Number__c;
    }
    
    public void validateSAPWithSfsObject(
        String calledFrom,
        SObject sfSObject)
    {
    }

    public void initializeQuoteFromSfSObject(
        String calledFrom, 
        SObject sfSObject, 
        SBO_EnosixQuote_Detail.EnosixQuote quoteDetail, 
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap,
        Map<String, UTIL_Quote.QuoteLineValue> quoteLineValueMap,
        Integer itemIncrement)
    {
        List<SObject> solList = getSObjectLineItems(sfsObject.Id).values();
        Integer solTot = solList.size();
        for (Integer solCnt = 0 ; solCnt < solTot ; solCnt++)
        {
            SObject sfsObjectLine = solList[solCnt];
            QuoteLineItem quoteLine = (QuoteLineItem) sfsObjectLine;
            string materialNumber = getMaterial(sfSObject, sfsObjectLine);
            SBO_EnosixQuote_Detail.ITEMS quoteItem = translateLineItemToQuoteItem(quoteLine, materialNumber);
            if (quoteItem != null)
            {
                UTIL_Quote.addItemToQuote(quoteDetail, quoteItem, itemIncrement);
                sfSObjectLineIdMap.put(quoteItem.ItemNumber.replaceFirst('^0+(?!$)', ''), new UTIL_SFSObjectDoc.SfSObjectItem(sfsObjectLine.Id));
            }
        }
    }

    @testVisible
    private SBO_EnosixQuote_Detail.ITEMS translateLineItemToQuoteItem(QuoteLineItem quoteLine, string materialNumber)
    {
        SBO_EnosixQuote_Detail.ITEMS item = null;
        if (null != materialNumber)
        {
            item = new SBO_EnosixQuote_Detail.ITEMS();
            item.Material = materialNumber;
            if (quoteLine.ServiceDate != null)
            {
                item.ScheduleLineDate = quoteLine.ServiceDate;
            }
            item.OrderQuantity = quoteLine.Quantity;
            item.NetItemPrice = quoteLine.UnitPrice;
            item.ItemDescription = quoteLine.Description;
        }
        else
        {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR,
                'Material Detail information could not be derived from the provided Quote Line Item - ' + quoteLine.LineNumber
            ));
        }
        return item;
    }

    public Boolean updateQuotePricingFromSfsObject(
        String calledFrom, 
        SObject sfSObject, 
        SBO_EnosixQuote_Detail.EnosixQuote quoteDetail, 
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap)
    {
        return false;
    }

    public void finalizeQuoteAndUpdateSfsObject(
        String calledFrom, 
        SObject sfSObject, 
        SBO_EnosixQuote_Detail.EnosixQuote quoteDetail, 
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap,
        Id pricebookId,
        List<SBO_EnosixQuote_Detail.ITEMS> quoteItems,
        Map<string, Id> materialToProductIdMap,
        Map<Id, PricebookEntry> productToPricebookEntryMap)
    {
        // Initial save of quote to get Id if new from Quick Quote
        Quote quote = (Quote) sfSObject;
        if (calledFrom != UTIL_SFSObjectDoc.CALLED_FROM_OPPORTUNITY_PRICING) quote.FLD_SAP_Quote_Number__c = quoteDetail.SalesDocument;
        quote.Pricebook2Id = pricebookId;
        upsert quote;

        // Add quote lines
        if (UTIL_Quote.isAddMaterial || UTIL_Quote.isEditMaterial || UTIL_Quote.isCloneMaterial || UTIL_Quote.isMoveMaterial)
        {
            upsertLineItemsFromQuoteItems(quote, quoteItems, materialToProductIdMap, productToPricebookEntryMap, sfSObjectLineIdMap);

            // Save the quote
            upsert quote;
        }
    }

    // upsertLineItemsFromQuoteItems()
    //
    // Map the given quote items to new quote lines and insert them into the db
    @testVisible
    private void upsertLineItemsFromQuoteItems(
        Quote quote,
        List<SBO_EnosixQuote_Detail.ITEMS> quoteItems,
        Map<string, Id> materialToProductIdMap,
        Map<Id, PricebookEntry> productToPricebookEntryMap,
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap)
    {
        List<QuoteLineItem> lineItems = new List<QuoteLineItem>();

        Integer itemTot = quoteItems.size();
        for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
        {
            SBO_EnosixQuote_Detail.ITEMS item = quoteItems[itemCnt];
            Id productId = materialToProductIdMap.get(item.Material);
            PricebookEntry price = productToPricebookEntryMap.get(productId);

            QuoteLineItem qli = new QuoteLineItem();

            if (sfSObjectLineIdMap.containsKey(item.ItemNumber.replaceFirst('^0+(?!$)', '')) 
                && !sfSObjectLineIdMap.get(item.ItemNumber.replaceFirst('^0+(?!$)', '')).isDeleted)
            {
                qli.id = sfSObjectLineIdMap.get(item.ItemNumber.replaceFirst('^0+(?!$)', '')).id;
                System.debug('Updating Quote Line Item');
            }
            else 
            {
                qli.Quote = quote;
                qli.QuoteId = quote.Id;
                qli.PricebookEntry = price;
                qli.PricebookEntryId = price.Id;
                System.debug('Adding Quote Line Item');
            }
            qli.Description = item.ItemDescription;
            qli.Quantity = item.OrderQuantity;
            qli.UnitPrice = item.NetItemPrice;
            qli.FLD_SAP_Item_Number__c = item.ItemNumber;            

            if (null != item.ScheduleLineDate)
                qli.ServiceDate = item.ScheduleLineDate;

            System.debug(qli);

            lineItems.add(qli);
        }

        upsert lineItems;
        quote.QuoteLineItems.addAll(lineItems);
    }

    public void initializeOrderFromSfSObject(
        String calledFrom, 
        SObject sfSObject, 
        SBO_EnosixSO_Detail.EnosixSO orderDetail, 
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap,
        Map<String, UTIL_Order.OrderLineValue> orderLineValueMap,
        Integer itemIncrement)
    {
        orderDetail.CustomerPurchaseOrderNumber = getName(sfSObject);

        List<SObject> solList = getSObjectLineItems(sfsObject.Id).values();
        Integer solTot = solList.size();
        for (Integer solCnt = 0 ; solCnt < solTot ; solCnt++)
        {
            SObject sfsObjectLine = solList[solCnt];
            QuoteLineItem quoteLine = (QuoteLineItem) sfsObjectLine;
            string materialNumber = getMaterial(sfSObject, sfsObjectLine);
            SBO_EnosixSO_Detail.ITEMS orderItem = translateLineItemToOrderItem(quoteLine, materialNumber);
            if (orderItem != null)
            {
                UTIL_Order.addItemToOrder(orderDetail, orderItem, itemIncrement);
                sfSObjectLineIdMap.put(orderItem.ItemNumber.replaceFirst('^0+(?!$)', ''), new UTIL_SFSObjectDoc.SfSObjectItem(sfsObjectLine.Id));
            }
        }
    }

    @testVisible
    public SBO_EnosixSO_Detail.ITEMS translateLineItemToOrderItem(QuoteLineItem quoteLine, string materialNumber)
    {
        SBO_EnosixSO_Detail.ITEMS item = null;
        if (null != materialNumber)
        {
            item = new SBO_EnosixSO_Detail.ITEMS();
            item.Material = materialNumber;
            if (quoteLine.ServiceDate != null)
            {
                item.ScheduleLineDate = quoteLine.ServiceDate;
            }
            item.OrderQuantity = quoteLine.Quantity;
        }
        else
        {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR,
                'Material Detail information could not be derived from the provided Quote Line Item - ' + quoteLine.LineNumber
            ));
        }
        return item;
    }

    public Boolean updateOrderPricingFromSfsObject(
        String calledFrom, 
        SObject sfSObject, 
        SBO_EnosixSO_Detail.EnosixSO orderDetail, 
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap)
    {
        return false;
    }

    public void finalizeOrderAndUpdateSfsObject(
        String calledFrom, 
        SObject sfSObject, 
        SBO_EnosixSO_Detail.EnosixSO orderDetail, 
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap,
        Id pricebookId,
        List<SBO_EnosixSO_Detail.ITEMS> orderItems,
        Map<string, Id> materialToProductIdMap,
        Map<Id, PricebookEntry> productToPricebookEntryMap)
    {
        Quote quote = (Quote) sfSObject;
        if (string.isNotEmpty(orderDetail.SalesDocument))
        {
            // if (calledFrom != UTIL_SFSObjectDoc.CALLED_FROM_OPPORTUNITY_PRICING) quote.FLD_SAP_Order_Number__c = orderDetail.SalesDocument;
        }
        quote.Pricebook2Id = pricebookId;
        upsert quote;

        // Add quote lines
        if (UTIL_Order.isAddMaterial || UTIL_Order.isEditMaterial || UTIL_Order.isCloneMaterial || UTIL_Order.isMoveMaterial)
        {
            upsertLineItemsFromOrderItems(quote, orderItems, materialToProductIdMap, productToPricebookEntryMap, sfSObjectLineIdMap);

            // Save the quote
            upsert quote;
        }
    }

    // upsertLineItemsFromOrderItems()
    //
    // Map the given order items to new quote lines and insert them into the db
    @testVisible
    private void upsertLineItemsFromOrderItems(
        Quote quote,
        List<SBO_EnosixSO_Detail.ITEMS> orderItems,
        Map<string, Id> materialToProductIdMap,
        Map<Id, PricebookEntry> productToPricebookEntryMap,
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap)
    {
        List<QuoteLineItem> lineItems = new List<QuoteLineItem>();

        Integer itemTot = orderItems.size();
        for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
        {
            SBO_EnosixSO_Detail.ITEMS item = orderItems[itemCnt];
            Id productId = materialToProductIdMap.get(item.Material);
            PricebookEntry price = productToPricebookEntryMap.get(productId);

            QuoteLineItem qli = new QuoteLineItem();

            if (sfSObjectLineIdMap.containsKey(item.ItemNumber.replaceFirst('^0+(?!$)', '')) 
                && !sfSObjectLineIdMap.get(item.ItemNumber.replaceFirst('^0+(?!$)', '')).isDeleted)
            {
                qli.id = sfSObjectLineIdMap.get(item.ItemNumber.replaceFirst('^0+(?!$)', '')).id;
                System.debug('Updating Quote Line Item');
            }
            else 
            {
                qli.Quote = quote;
                qli.QuoteId = quote.Id;
                qli.PricebookEntry = price;
                qli.PricebookEntryId = price.Id;
                System.debug('Adding Quote Line Item');
            }
            qli.Description = item.ItemDescription;
            qli.Quantity = item.OrderQuantity;
            qli.UnitPrice = item.NetItemPrice;
            qli.FLD_SAP_Item_Number__c = item.ItemNumber;            

            if (null != item.ScheduleLineDate)
                qli.ServiceDate = item.ScheduleLineDate;

            System.debug(qli);

            lineItems.add(qli);
        }

        upsert lineItems;
        quote.QuoteLineItems.addAll(lineItems);
    }

    public DS_Document_Detail sObjectToSalesDocMapping(
        SObject sfSObject,
        List<SObject> sfLineItems,
        DS_Document_Detail salesDocDetail,
        DS_SalesDocAppSettings appSettings)
    {
        //Do the mapping from SObject and SF Line Items to salesDocDetail here
        Quote quote = (Quote) sfSObject;

        if (String.isNotEmpty(quote.SAP_SaveSalesDocHeader__c)) {
            salesDocDetail = (DS_Document_Detail) JSON.deserialize(quote.SAP_SaveSalesDocHeader__c, DS_Document_Detail.class);
            salesDocDetail.SalesDocument = '';
            salesDocDetail.SALES.SalesDocumentType = appSettings.DefaultDocType;
            salesDocDetail.NeedToSimulate = false;
        }
        else {
            // Mapping of header fields from SObject
            // salesDocDetail.SalesDocumentCurrency = quote.CurrencyIsoCode;
            salesDocDetail.NeedToSimulate = true;
        }

        if (sfLineItems != null && sfLineItems.size() > 0) {
            Integer increment = appSettings.itemNumberIncrement;
            Integer itemNumber = increment;

            Integer lineItemTot = sfLineItems.size();
            for (Integer lineItemCnt = 0; lineItemCnt < lineItemTot; lineItemCnt++)
            {
                SObject sfLineItem = sfLineItems[lineItemCnt];
                QuoteLineItem quoteLine = (QuoteLineItem) sfLineItem;
                DS_Document_Detail.ITEMS salesDocItem = new DS_Document_Detail.ITEMS();

                if (String.isNotEmpty(quoteLine.SAP_SaveSalesDocItem__c)) {
                    salesDocItem = (DS_Document_Detail.ITEMS) JSON.deserialize(quoteLine.SAP_SaveSalesDocItem__c, DS_Document_Detail.ITEMS.class);
                    itemNumber = Integer.valueOf(salesDocItem.ItemNumber);
                }
                else {
                    // Mapping of item fields from Sobject line items
                    salesDocItem.ItemNumber = String.valueOf(itemNumber);
                    salesDocItem.HigherLevelItemNumber = '000000';
                    salesDocItem.Material = (String) quoteLine.Product2.get(UTIL_SFProduct.MaterialFieldName);
                    salesDocItem.ItemDescription = quoteLine.Description;
                    salesDocItem.NetItemPrice = quoteLine.UnitPrice;
                    salesDocItem.OrderQuantity = quoteLine.Quantity;
                    salesDocItem.ConfigurableMaterial = quoteLine.Product2.FLD_Configurable_Material__c;

                    salesDocItem.PARTNERS = UTIL_SalesDoc.convertAppSettingPartnersToPartners(appSettings.Item.PartnerPickers);
                    salesDocItem.ItemTexts = UTIL_SalesDoc.convertAppSettingTextsToTexts(appSettings.Item.Texts, salesDocDetail.CustomerLanguage);
                }

                salesDocDetail.ITEMS.add(salesDocItem);
                itemNumber += increment;
            }
        }

        return salesDocDetail;
    }

    public SObject salesDocMappingToSObject(
        SObject sfSObject, 
        DS_Document_Detail salesDocDetail, 
        String sapDocType)
    {
        Quote quote = (Quote) sfSObject;        
        
        if (String.isNotEmpty(salesDocDetail.SalesDocument)) {
            quote.Status = 'Accepted';                    

            if (sapDocType == 'Quote') {
                quote.FLD_SAP_Quote_Number__c = salesDocDetail.SalesDocument;
            }
        }
        
        DS_Document_Detail copySalesDocDetail = salesDocDetail.cloneHeader();
        quote.SAP_SaveSalesDocHeader__c = JSON.serialize(copySalesDocDetail);
        
        return quote;
    }

    public SObject salesDocLineItemMappingToSObject(
        SObject sfSObject, 
        DS_Document_Detail.ITEMS item, 
        PricebookEntry materialEntry, 
        Id parentId, 
        SObject lineItem)
    {
        QuoteLineItem quoteLine;

        if (lineItem == null) {
            quoteLine = new QuoteLineItem();
            quoteLine.QuoteId = parentId;
            quoteLine.PricebookEntryId = materialEntry.Id;
            quoteLine.Product2Id = materialEntry.Product2Id;
        }
        else {
            quoteLine = (QuoteLineItem) lineItem;
        }

        quoteLine.Description = item.ItemDescription;
        quoteLine.Quantity = item.OrderQuantity;
        quoteLine.UnitPrice = item.NetItemPrice;
        quoteLine.FLD_SAP_Item_Number__c = item.ItemNumber;
        quoteLine.SAP_SaveSalesDocItem__c = JSON.serialize(item);

        return quoteLine;
    }
}