public with sharing class UTIL_SFOpportunity implements I_SFSObjectDoc
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_SFOpportunity.class);

    private SObject loadedSObject;
    private string loadedId;
    private string loadedSapType;
    private string loadedSapDocNum;
    private Map<Id, SObject> loadedLineMap;

    // Returns the field name which stores the SAP Quote number
    // The default is from the EDM package or from the AppSettings
    public static String QuoteFieldName
    {
        get
        {
            return (String)UTIL_AppSettings.getValue('Opportunity.QuoteFieldName', 'FLD_SAP_Quote_Number__c');
        }
    }

    // Returns the field name which stores the SAP Order number
    // The default is from the EDM package or from the AppSettings
    public static String OrderFieldName
    {
        get
        {
            return (String)UTIL_AppSettings.getValue('Opportunity.OrderFieldName', 'FLD_SAP_Order_Number__c');
        }
    }

    // Returns the field name which stores the SAP Contract number
    // The default is from the EDM package or from the AppSettings
    public static String ContractFieldName
    {
        get
        {
            return (String)UTIL_AppSettings.getValue('Opportunity.ContractFieldName', 'FLD_SAP_Contract_Number__c');
        }
    }

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
        Boolean isIdMatch = (loadedId == id || (String.isNotEmpty(Id) && String.isNotEmpty(loadedId) && (loadedId.startsWith(id) || id.startsWith(loadedId))));
        if (loadedSObject != null && (isIdMatch || (loadedSapType == sapType && loadedSapDocNum == sapDocNum)))
        {
            return loadedSObject;
        }

        loadedId = id;
        loadedSapType = sapType;
        loadedSapDocNum = sapDocNum;
        loadedLineMap = null;

		SObject result = null;

        string errorString = '';
        if (String.isNotEmpty(id) || (String.isNotEmpty(sapType) && String.isNotEmpty(sapDocNum)))
        {
            try
            {
                string selectCmd = 'SELECT Id, Name, Description, StageName, SAP_SaveSalesDocHeader__c, FLD_SalesDocStatus__c,' +
                            ' Amount, Type, NextStep, Probability, HasOpportunityLineItem, Account.' + UTIL_SFAccount.CustomerFieldName + ',' +
                            ' LeadSource, AccountID, CloseDate, Pricebook2Id, ' + UTIL_SFOpportunity.QuoteFieldName + ',' +
                            UTIL_SFOpportunity.OrderFieldName + ',' + UTIL_SFOpportunity.ContractFieldName +
                            ' FROM Opportunity';
                if (String.isNotEmpty(id))
                {
                    selectCmd += ' WHERE Id = \'' + id + '\'';
                    errorString = ' for the provided Id ' + id;
                }
                else
                {
                    if (sapType == 'Quote')
                    {
                        selectCmd += ' WHERE ' + UTIL_SFOpportunity.QuoteFieldName + ' = \'' + sapDocNum + '\'';
                        errorString = ' for the provided SAP Quote Number ' + sapDocNum;
                    }
                    else if (sapType == 'Order')
                    {
                        selectCmd += ' WHERE ' + UTIL_SFOpportunity.OrderFieldName + ' = \'' + sapDocNum + '\'';
                        errorString = ' for the provided SAP Order Number ' + sapDocNum;
                    }
                    else if (sapType == 'Contract')
                    {
                        selectCmd += ' WHERE ' + UTIL_SFOpportunity.ContractFieldName + ' = \'' + sapDocNum + '\'';
                        errorString = ' for the provided SAP Contract Number ' + sapDocNum;
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
                'There was an issue retrieving an Opportunity record: ' + errorString);
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
            string selectCmd = 'SELECT Id, OpportunityId, SortOrder, PricebookEntryId, Product2Id, Product2.Name, Name, Product2.' + UTIL_SFProduct.MaterialFieldName + ',' +
                        ' Quantity, TotalPrice, UnitPrice, ListPrice, ServiceDate, Description, FLD_SAP_Item_Number__c, SAP_SaveSalesDocItem__c, Product2.FLD_Configurable_Material__c' +
                        ' FROM OpportunityLineItem WHERE OpportunityId = :id ORDER BY FLD_SAP_Item_Number__c ASC';
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
		Map<Id, SObject> contactsMap = new Map<Id, SObject>();

		try
		{
            string query = 'SELECT Id, OpportunityId, IsPrimary, ContactId, Contact.Name, Contact.' + UTIL_SFContact.ContactFieldName + 
                ' FROM OpportunityContactRole WHERE OpportunityId = :id';

            List<SObject> contactList = Database.query(query);
            
            Integer contactTot = contactList.size();
            for (Integer conCnt = 0 ; conCnt < contactTot ; conCnt++)
			{
                SObject contact = contactList[conCnt];
				contactsMap.put(contact.Id, contact);
			}

		}
		catch (Exception e)
		{
			UTIL_PageMessages.addExceptionMessage(e);
		}

        return contactsMap;
    }
	public String getAccountId(SObject sfSObject)
	{
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'Opportunity' ? null : ((Opportunity) sfSObject).AccountId;
	}

    public String getCustomerNumber(SObject sfSObject)
	{
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'Opportunity' || ((Opportunity) sfSObject).Account == null ? null : (String) ((Opportunity) sfSObject).Account.get(UTIL_SFAccount.CustomerFieldName);
	}

	public String getName(SObject sfSObject)
	{
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'Opportunity' ? '' : ((Opportunity) sfSObject).Name;
	}

    public String getQuoteNumber(SObject sfSObject)
    {
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'Opportunity' ? '' : (String) sfSObject.get(UTIL_SFOpportunity.QuoteFieldName);
    }

    public String getOrderNumber(SObject sfSObject)
    {
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'Opportunity' ? '' : (String) sfSObject.get(UTIL_SFOpportunity.OrderFieldName);
    }

    public String getContractNumber(SObject sfSObject)
    {
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'Opportunity' ? '' : (String) sfSObject.get(UTIL_SFOpportunity.ContractFieldName);
    }

    public String getStatus(SObject sfSObject)
    {
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'Opportunity' ? '' : ((Opportunity) sfSObject).FLD_SalesDocStatus__c;
    }

    public String getOpportunityId(SObject sfSObject)
    {
        return getOpportunity(sfsObject) == null ? null :  getOpportunity(sfsObject).Id;
    }

    public Opportunity getOpportunity(SObject sfSObject)
    {
        return (Opportunity) sfSObject;
    }

    public Id getPriceBookId(SObject sfSObject)
    {
        Id pricebookId;
        if (sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'Opportunity') {
            return null;
        }
        else pricebookId = ((Opportunity) sfSObject).Pricebook2Id;

        if (String.isEmpty(pricebookId)) pricebookId = UTIL_Pricebook.getStandardPriceBookId();

        return pricebookId;
    }

    public Id getProductId(SObject sfsObjectLine)
    {
        return sfsObjectLine == null || sfsObjectLine.getSObjectType().getDescribe().getName() != 'OpportunityLineItem' ? null : ((OpportunityLineItem) sfsObjectLine).Product2Id;
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
        return sfsObjectLine == null || sfsObjectLine.getSObjectType().getDescribe().getName() != 'OpportunityLineItem' ? '' : ((OpportunityLineItem) sfsObjectLine).FLD_SAP_Item_Number__c;
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
            OpportunityLineItem oppLine = (OpportunityLineItem) sfsObjectLine;
            string materialNumber = getMaterial(sfSObject, sfsObjectLine);
            SBO_EnosixQuote_Detail.ITEMS quoteItem = translateLineItemToQuoteItem(oppLine, materialNumber);
            if (quoteItem != null)
            {
                UTIL_Quote.addItemToQuote(quoteDetail, quoteItem, itemIncrement);
                sfSObjectLineIdMap.put(quoteItem.ItemNumber.replaceFirst('^0+(?!$)', ''), new UTIL_SFSObjectDoc.SfSObjectItem(sfsObjectLine.Id));
            }
        }
    }

    @testVisible
    private SBO_EnosixQuote_Detail.ITEMS translateLineItemToQuoteItem(OpportunityLineItem oppLine, string materialNumber)
    {
        SBO_EnosixQuote_Detail.ITEMS item = null;
        if (null != materialNumber)
        {
            item = new SBO_EnosixQuote_Detail.ITEMS();
            item.Material = materialNumber;
            if (oppLine.ServiceDate != null)
            {
                item.ScheduleLineDate = oppLine.ServiceDate;
            }
            item.OrderQuantity = oppLine.Quantity;
            item.NetItemPrice = oppLine.UnitPrice;
            item.ItemDescription = oppLine.Description;
        }
        else
        {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR,
                'Material Detail information could not be derived from the provided Product - ' + oppLine.Name
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
        // Initial save of opportunity to get Id if new from Quick Quote
        Opportunity opp = (Opportunity) sfSObject;
        opp.Pricebook2Id = pricebookId;
        if (calledFrom != UTIL_SFSObjectDoc.CALLED_FROM_OPPORTUNITY_PRICING) opp.put(UTIL_SFOpportunity.QuoteFieldName, quoteDetail.SalesDocument);
        opp.Amount = quoteDetail.NetOrderValue;
        opp.CloseDate = System.today();
        upsert opp;

        // Add opportunity lines
        if (UTIL_Quote.isAddMaterial || UTIL_Quote.isEditMaterial || UTIL_Quote.isCloneMaterial || UTIL_Quote.isMoveMaterial)
        {
            upsertLineItemsFromQuoteItems(opp, quoteItems, materialToProductIdMap, productToPricebookEntryMap, sfSObjectLineIdMap);

            // Save the opportunity
            upsert opp;
        }
    }

    // upsertLineItemsFromQuoteItems()
    //
    // Map the given quote items to new opportunity lines and insert them into the db
    @testVisible
    private void upsertLineItemsFromQuoteItems(
        Opportunity opp,
        List<SBO_EnosixQuote_Detail.ITEMS> quoteItems,
        Map<string, Id> materialToProductIdMap,
        Map<Id, PricebookEntry> productToPricebookEntryMap,
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap)
    {
        List<OpportunityLineItem> lineItems = new List<OpportunityLineItem>();

        Integer itemTot = quoteItems.size();
        for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
        {
            SBO_EnosixQuote_Detail.ITEMS item = quoteItems[itemCnt];
            Id productId = materialToProductIdMap.get(item.Material);
            PricebookEntry price = productToPricebookEntryMap.get(productId);

            OpportunityLineItem oli = new OpportunityLineItem();

            if (sfSObjectLineIdMap.containsKey(item.ItemNumber.replaceFirst('^0+(?!$)', '')) 
                && !sfSObjectLineIdMap.get(item.ItemNumber.replaceFirst('^0+(?!$)', '')).isDeleted)
            {
                oli.id = sfSObjectLineIdMap.get(item.ItemNumber.replaceFirst('^0+(?!$)', '')).id;
                System.debug('Updating Opportunity Line Item');
            }
            else 
            {
                oli.Opportunity = opp;
                oli.OpportunityId = opp.Id;
                oli.PricebookEntry = price;
                oli.PricebookEntryId = price.Id;
                System.debug('Adding Opportunity Line Item');
            }
            oli.Description = item.ItemDescription;
            oli.Quantity = item.OrderQuantity;
            oli.UnitPrice = item.NetItemPrice;
            oli.FLD_SAP_Item_Number__c = item.ItemNumber;            

            if (null != item.ScheduleLineDate)
                oli.ServiceDate = item.ScheduleLineDate;

            System.debug(oli);

            lineItems.add(oli);
        }

        upsert lineItems;
        opp.OpportunityLineItems.addAll(lineItems);
    }

    public void initializeOrderFromSfSObject(
        String calledFrom, 
        SObject sfSObject, 
        SBO_EnosixSO_Detail.EnosixSO orderDetail, 
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap,
        Map<String, UTIL_Order.OrderLineValue> orderLineValueMap,
        Integer itemIncrement)
    {
        List<SObject> solList = getSObjectLineItems(sfsObject.Id).values();
        Integer solTot = solList.size();
        for (Integer solCnt = 0 ; solCnt < solTot ; solCnt++)
        {
            SObject sfsObjectLine = solList[solCnt];
            OpportunityLineItem oppLine = (OpportunityLineItem) sfsObjectLine;
            string materialNumber = getMaterial(sfSObject, sfsObjectLine);
            SBO_EnosixSO_Detail.ITEMS orderItem = translateLineItemToOrderItem(oppLine, materialNumber);
            if (orderItem != null)
            {
                UTIL_Order.addItemToOrder(orderDetail, orderItem, itemIncrement);
                sfSObjectLineIdMap.put(orderItem.ItemNumber.replaceFirst('^0+(?!$)', ''), new UTIL_SFSObjectDoc.SfSObjectItem(sfsObjectLine.Id));
            }
        }
    }

    @testVisible
    private SBO_EnosixSO_Detail.ITEMS translateLineItemToOrderItem(OpportunityLineItem oppLine, string materialNumber)
    {
        SBO_EnosixSO_Detail.ITEMS item = null;
        if (null != materialNumber)
        {
            item = new SBO_EnosixSO_Detail.ITEMS();
            item.Material = materialNumber;
            if (oppLine.ServiceDate != null)
            {
                item.ScheduleLineDate = oppLine.ServiceDate;
            }
            item.OrderQuantity = oppLine.Quantity;
        }
        else
        {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR,
                'Material Detail information could not be derived from the provided Product - ' + oppLine.Name
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
        Opportunity opp = (Opportunity) sfSObject;
        opp.Amount = orderDetail.NetOrderValue;
        opp.StageName = 'Closed Won';
        opp.Probability = 100;
        opp.CloseDate = System.today();

        if (string.isNotEmpty(orderDetail.SalesDocument))
        {
            if (calledFrom != UTIL_SFSObjectDoc.CALLED_FROM_OPPORTUNITY_PRICING) opp.put(UTIL_SFOpportunity.OrderFieldName, orderDetail.SalesDocument);
        }
        opp.Pricebook2Id = pricebookId;
        upsert opp;

        // Add opportunity lines
        if (UTIL_Order.isAddMaterial || UTIL_Order.isEditMaterial || UTIL_Order.isCloneMaterial || UTIL_Order.isMoveMaterial)
        {
            upsertLineItemsFromOrderItems(opp, orderItems, materialToProductIdMap, productToPricebookEntryMap, sfSObjectLineIdMap);

            // Save the opportunity
            upsert opp;
        }
    }

    // upsertLineItemsFromOrderItems()
    //
    // Map the given order items to new opportunity lines and insert them into the db
    @testVisible
    private void upsertLineItemsFromOrderItems(
        Opportunity opp,
        List<SBO_EnosixSO_Detail.ITEMS> orderItems,
        Map<string, Id> materialToProductIdMap,
        Map<Id, PricebookEntry> productToPricebookEntryMap,
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap)
    {
        List<OpportunityLineItem> lineItems = new List<OpportunityLineItem>();

        Integer itemTot = orderItems.size();
        for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
        {
            SBO_EnosixSO_Detail.ITEMS item = orderItems[itemCnt];
            Id productId = materialToProductIdMap.get(item.Material);
            PricebookEntry price = productToPricebookEntryMap.get(productId);

            OpportunityLineItem oli = new OpportunityLineItem();

            if (sfSObjectLineIdMap.containsKey(item.ItemNumber.replaceFirst('^0+(?!$)', '')) 
                && !sfSObjectLineIdMap.get(item.ItemNumber.replaceFirst('^0+(?!$)', '')).isDeleted)
            {
                oli.id = sfSObjectLineIdMap.get(item.ItemNumber.replaceFirst('^0+(?!$)', '')).id;
                System.debug('Updating Opportunity Line Item');
            }
            else 
            {
                oli.Opportunity = opp;
                oli.OpportunityId = opp.Id;
                oli.PricebookEntry = price;
                oli.PricebookEntryId = price.Id;
                System.debug('Adding Opportunity Line Item');
            }
            oli.Description = item.ItemDescription;
            oli.Quantity = item.OrderQuantity;
            oli.UnitPrice = item.NetItemPrice;
            oli.FLD_SAP_Item_Number__c = item.ItemNumber;            

            if (null != item.ScheduleLineDate)
                oli.ServiceDate = item.ScheduleLineDate;

            System.debug(oli);

            lineItems.add(oli);
        }

        upsert lineItems;
        opp.OpportunityLineItems.addAll(lineItems);
    }

    public DS_Document_Detail sObjectToSalesDocMapping(
        SObject sfSObject,
        List<SObject> sfLineItems,
        DS_Document_Detail salesDocDetail,
        DS_SalesDocAppSettings appSettings)
    {
        //Do the mapping from SObject and SF Line Items to salesDocDetail here
        Opportunity opp = (Opportunity) sfSObject;

        if (String.isNotEmpty(opp.SAP_SaveSalesDocHeader__c)) {
            salesDocDetail = (DS_Document_Detail) JSON.deserialize(opp.SAP_SaveSalesDocHeader__c, DS_Document_Detail.class);
            salesDocDetail.SalesDocument = '';
            salesDocDetail.SALES.SalesDocumentType = appSettings.DefaultDocType;
            salesDocDetail.NeedToSimulate = false;
        }
        else {
            // Mapping of header fields from SObject
            // salesDocDetail.SalesDocumentCurrency = opp.CurrencyIsoCode;
            salesDocDetail.NeedToSimulate = true;
        }

        if (sfLineItems != null && sfLineItems.size() > 0) {
            Integer increment = appSettings.itemNumberIncrement;
            Integer itemNumber = increment;

            Integer lineItemTot = sfLineItems.size();
            for (Integer lineItemCnt = 0; lineItemCnt < lineItemTot; lineItemCnt++)
            {
                SObject sfLineItem = sfLineItems[lineItemCnt];
                OpportunityLineItem oppLineItem = (OpportunityLineItem) sfLineItem;
                DS_Document_Detail.ITEMS salesDocItem = new DS_Document_Detail.ITEMS();

                if (String.isNotEmpty(oppLineItem.SAP_SaveSalesDocItem__c)) {
                    salesDocItem = (DS_Document_Detail.ITEMS) JSON.deserialize(oppLineItem.SAP_SaveSalesDocItem__c, DS_Document_Detail.ITEMS.class);
                    itemNumber = Integer.valueOf(salesDocItem.ItemNumber);
                }
                else {
                    // Mapping of item fields from Sobject line items
                    salesDocItem.ItemNumber = String.valueOf(itemNumber);
                    salesDocItem.HigherLevelItemNumber = '000000';
                    salesDocItem.Material = (String) oppLineItem.Product2.get(UTIL_SFProduct.MaterialFieldName);
                    salesDocItem.ItemDescription = oppLineItem.Description;
                    salesDocItem.NetItemPrice = oppLineItem.ListPrice;
                    salesDocItem.OrderQuantity = oppLineItem.Quantity;
                    salesDocItem.ScheduleLineDate = oppLineItem.ServiceDate;
                    salesDocItem.ConfigurableMaterial = oppLineItem.Product2.FLD_Configurable_Material__c;

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
        Opportunity opp = (Opportunity) sfSObject;        
        
        if (String.isNotEmpty(salesDocDetail.SalesDocument)) {
            opp.StageName = 'Closed Won';
            opp.Probability = 100;                    

            if (sapDocType == 'Quote') {
                opp.put(UTIL_SFOpportunity.QuoteFieldName, salesDocDetail.SalesDocument);
            }
            else if (sapDocType == 'Order') {
                opp.put(UTIL_SFOpportunity.OrderFieldName, salesDocDetail.SalesDocument);
            }
            else if (sapDocType == 'Contract') {
                opp.put(UTIL_SFOpportunity.ContractFieldName, salesDocDetail.SalesDocument);
            }
        }
        
        opp.Amount = salesDocDetail.NetOrderValue;
        DS_Document_Detail copySalesDocDetail = salesDocDetail.cloneHeader();
        opp.SAP_SaveSalesDocHeader__c = JSON.serialize(copySalesDocDetail);
        
        return opp;
    }

    public SObject salesDocLineItemMappingToSObject(
        SObject sfSObject, 
        DS_Document_Detail.ITEMS item, 
        PricebookEntry materialEntry, 
        Id parentId, 
        SObject lineItem)
    {
        OpportunityLineItem oppLine;

        if (lineItem == null) {
            oppLine = new OpportunityLineItem();
            oppLine.OpportunityId = parentId;
            oppLine.PricebookEntryId = materialEntry.Id;
            oppLine.Product2Id = materialEntry.Product2Id;
        }
        else {
            oppLine = (OpportunityLineItem) lineItem;
        }

        oppLine.Description = item.ItemDescription;
        oppLine.Quantity = item.OrderQuantity;
        oppLine.UnitPrice = item.NetItemPrice;
        oppLine.FLD_SAP_Item_Number__c = item.ItemNumber;
        oppLine.SAP_SaveSalesDocItem__c = JSON.serialize(item);

        return oppLine;
    }
}