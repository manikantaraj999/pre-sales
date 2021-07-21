public with sharing class UTIL_SFOrder implements I_SFSObjectDoc
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_SFOrder.class);

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
                    ' PoDate, PoNumber, Account.' + UTIL_SFAccount.CustomerFieldName + ', FLD_SAP_Order_Number__c,' + 
                    ' OrderNumber, FLD_SalesDocStatus__c FROM Order';

                if (String.isNotEmpty(id))
                {
                    selectCmd += ' WHERE Id = \'' + id + '\'';
                    errorString = ' for the provided Id ' + id;
                }
                else
                {
                    if (sapType == 'Order')
                    {
                        selectCmd += ' WHERE FLD_SAP_Order_Number__c = \'' + sapDocNum + '\'';
                        errorString = ' for the provided SAP Order Number ' + sapDocNum;
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
                'There was an issue retrieving an Order record: ' + errorString);
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
            string selectCmd = 'SELECT Id, OrderId, PricebookEntryId, Product2Id, Product2.Name, SAP_SaveSalesDocItem__c,' +
                        ' Product2.' + UTIL_SFProduct.MaterialFieldName + ', Quantity, TotalPrice, UnitPrice, ListPrice,' +
                        ' ServiceDate, Description, OrderItemNumber, FLD_SAP_Item_Number__c' +
                        ' FROM OrderItem WHERE OrderId = :id AND Product2Id != null ORDER BY FLD_SAP_Item_Number__c ASC';

            List<SObject> lineList = Database.query(selectCmd);
            
            loadLineMap(lineList, lineMap);
		}
		catch (Exception e)
		{
			UTIL_PageMessages.addExceptionMessage(e);
		}
        loadedLineMap = lineMap;
        return lineMap;
	}
		
    @testVisible
    private void loadLineMap(List<SObject> lineList, Map<Id, SObject> lineMap)
    {
        Integer lineTot = lineList.size();
        for (Integer lineCnt = 0 ; lineCnt < lineTot ; lineCnt++)
        {
            SObject lineItem = lineList[lineCnt];
            lineMap.put(lineItem.Id, lineItem);
        }
    }

	public Map<Id, SObject> getSObjectContacts(String id)
	{
		//Implement to get Contact link to SObject
		return new Map<Id, SObject>();
	}
    
	public String getAccountId(SObject sfSObject)
	{
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'Order' ? null : ((Order) sfSObject).AccountId;
	}

    public String getCustomerNumber(SObject sfSObject)
	{
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'Order' || ((Order) sfSObject).Account == null ? null : (String) ((Order) sfSObject).Account.get(UTIL_SFAccount.CustomerFieldName);
	}

	public String getName(SObject sfSObject)
	{
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'Order' ? '' : ((Order) sfSObject).OrderNumber;
	}

    public String getQuoteNumber(SObject sfSObject)
    {
        return '';
    }

    public String getOrderNumber(SObject sfSObject)
    {
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'Order' ? '' : ((Order) sfSObject).FLD_SAP_Order_Number__c;
    }

    public String getContractNumber(SObject sfSObject)
    {
        return '';
    }

    public String getInquiryNumber(SObject sfSObject)
    {
        return '';
    }

    public String getCreditMemoNumber(SObject sfSObject)
    {
        return '';
    }

    public String getDebitMemoNumber(SObject sfSObject)
    {
        return '';
    }

    public String getReturnOrderNumber(SObject sfSObject)
    {
        return '';
    }

    public String getStatus(SObject sfSObject)
    {
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'Order' ? '' : ((Order) sfSObject).FLD_SalesDocStatus__c;
    }

    public String getOpportunityId(SObject sfSObject)
    {
        return getOpportunity(sfsObject) == null ? null :  getOpportunity(sfsObject).Id;
    }

    private Opportunity getOpportunity(SObject sfSObject)
    {
        UTIL_SFOpportunity sfOpportunity = new UTIL_SFOpportunity();
        return sfSObject == null ? null : (Opportunity) sfOpportunity.getSObject(((Order) sfSObject).OpportunityId);
    }

    public Id getPriceBookId(SObject sfSObject)
    {
        Id pricebookId;
        if (sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'Order') {
            return null;
        }
        else pricebookId = ((Order) sfSObject).Pricebook2Id;

        if (String.isEmpty(pricebookId)) pricebookId = UTIL_Pricebook.getStandardPriceBookId();

        return pricebookId;
    }

    public Id getProductId(SObject sfsObjectLine)
    {
        return sfsObjectLine == null || sfsObjectLine.getSObjectType().getDescribe().getName() != 'OrderItem' ? null : ((OrderItem) sfsObjectLine).Product2Id;
    }

    public String getMaterial(SObject sfSObject, SObject sfsObjectLine)
    {
        return sfsObjectLine == null || sfsObjectLine.getSObjectType().getDescribe().getName() != 'OrderItem' || ((OrderItem) sfsObjectLine).Product2 == null ? null : (String) ((OrderItem) sfsObjectLine).Product2.get(UTIL_SFProduct.MaterialFieldName);
    }

    public String getItemNumber(SObject sfsObjectLine)
    {
        return sfsObjectLine == null || sfsObjectLine.getSObjectType().getDescribe().getName() != 'OrderItem' ? '' : ((OrderItem) sfsObjectLine).FLD_SAP_Item_Number__c;
    }
    
    public void validateSAPWithSfsObject(
        String calledFrom,
        SObject sfSObject)
    {
    }

    public DS_Document_Detail sObjectToSalesDocMapping(
        SObject sfSObject,
        List<SObject> sfLineItems,
        DS_Document_Detail salesDocDetail,
        DS_SalesDocAppSettings appSettings)
    {
        //Do the mapping from SObject and SF Line Items to salesDocDetail here
        Order order = (Order) sfSObject;

        if (String.isNotEmpty(order.SAP_SaveSalesDocHeader__c)) {
            salesDocDetail = (DS_Document_Detail) JSON.deserialize(order.SAP_SaveSalesDocHeader__c, DS_Document_Detail.class);
            salesDocDetail.SalesDocument = '';
            salesDocDetail.SALES.SalesDocumentType = appSettings.DefaultDocType;
            salesDocDetail.NeedToSimulate = false;
        }
        else {
            // Mapping of header fields from SObject
            salesDocDetail.NeedToSimulate = true;
        }

        if (sfLineItems != null && sfLineItems.size() > 0) {
            Integer increment = appSettings.itemNumberIncrement;
            Integer itemNumber = increment;

            Integer lineItemTot = sfLineItems.size();
            for (Integer lineItemCnt = 0; lineItemCnt < lineItemTot; lineItemCnt++)
            {
                SObject sfLineItem = sfLineItems[lineItemCnt];
                OrderItem orderLine = (OrderItem) sfLineItem;
                DS_Document_Detail.ITEMS salesDocItem = new DS_Document_Detail.ITEMS();

                if (String.isNotEmpty(orderLine.SAP_SaveSalesDocItem__c)) {
                    salesDocItem = (DS_Document_Detail.ITEMS) JSON.deserialize(orderLine.SAP_SaveSalesDocItem__c, DS_Document_Detail.ITEMS.class);
                    itemNumber = Integer.valueOf(salesDocItem.ItemNumber);
                }
                else {
                    // Mapping of item fields from Sobject line items
                    salesDocItem.ItemNumber = String.valueOf(itemNumber);
                    salesDocItem.HigherLevelItemNumber = '000000';
                    salesDocItem.Material = getMaterial(sfsObject, sfLineItem);
                    salesDocItem.ItemDescription = orderLine.Description;
                    salesDocItem.NetItemPrice = orderLine.UnitPrice;
                    salesDocItem.OrderQuantity = orderLine.Quantity;
                    if (orderLine.Product2 != null) salesDocItem.ConfigurableMaterial = orderLine.Product2.FLD_Configurable_Material__c;

                    salesDocItem.PARTNERS = UTIL_SalesDoc.convertAppSettingPartnersToPartners(appSettings.Item.PartnerPickers);
                    salesDocItem.ItemTexts = UTIL_SalesDoc.convertAppSettingTextsToTexts(appSettings.Item.Texts, salesDocDetail.CustomerLanguage);
                }

                salesDocItem.SFId = orderLine.Id;
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
        Order order = (Order) sfSObject;        
        
        if (String.isNotEmpty(salesDocDetail.SalesDocument)) {
            if (sapDocType == 'Order') {
                order.FLD_SAP_Order_Number__c = salesDocDetail.SalesDocument;
            }
        }
        
        DS_Document_Detail copySalesDocDetail = salesDocDetail.cloneHeader();
        order.SAP_SaveSalesDocHeader__c = JSON.serialize(copySalesDocDetail);
        
        return order;
    }

    public SObject salesDocLineItemMappingToSObject(
        SObject sfSObject, 
        DS_Document_Detail.ITEMS item, 
        PricebookEntry materialEntry, 
        Id parentId, 
        SObject lineItem)
    {
        OrderItem orderLine;

        if (lineItem == null) {
            orderLine = new OrderItem();
            orderLine.OrderId = parentId;
            orderLine.PricebookEntryId = materialEntry.Id;
            orderLine.Product2Id = materialEntry.Product2Id;
        }
        else {
            orderLine = (OrderItem) lineItem;
        }

        orderLine.Description = item.ItemDescription;
        orderLine.Quantity = item.OrderQuantity;
        orderLine.UnitPrice = item.NetItemPrice;
        orderLine.FLD_SAP_Item_Number__c = item.ItemNumber;
        orderLine.SAP_SaveSalesDocItem__c = JSON.serialize(item);

        return orderLine;
    }
}