public with sharing class UTIL_SFCase implements I_SFSObjectDoc
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_SFCase.class);

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
                string selectCmd = 'SELECT Id, Description, SAP_SaveSalesDocHeader__c, AccountId, Account.' + UTIL_SFAccount.CustomerFieldName + 
                    ', FLD_SAP_Return_Order_Number__c, CaseNumber, FLD_SalesDocStatus__c FROM Case';

                if (String.isNotEmpty(id))
                {
                    selectCmd += ' WHERE Id = \'' + id + '\'';
                    errorString = ' for the provided Id ' + id;
                }
                else
                {
                    if (sapType == 'Order')
                    {
                        selectCmd += ' WHERE     = \'' + sapDocNum + '\'';
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
                'There was an issue retrieving an Case record: ' + errorString);
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
            string selectCmd = 'SELECT Id, CaseId, Product2Id, SAP_SaveSalesDocItem__c, Product2.' + UTIL_SFProduct.MaterialFieldName + ',' +
                        ' QuantityRequested, Description, FLD_SAP_Item_Number__c, Product2.FLD_Configurable_Material__c' +
                        ' FROM ProductRequestLineItem WHERE CaseId = :id ORDER BY FLD_SAP_Item_Number__c ASC';
            
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
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'Case' ? null : ((Case) sfSObject).AccountId;
	}

    public String getCustomerNumber(SObject sfSObject)
	{
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'Case' || ((Case) sfSObject).Account.get(UTIL_SFAccount.CustomerFieldName) == null ? null : (String) ((Case) sfSObject).Account.get(UTIL_SFAccount.CustomerFieldName);
	}

	public String getName(SObject sfSObject)
	{
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'Case' ? '' : ((Case) sfSObject).CaseNumber;
	}

    public String getQuoteNumber(SObject sfSObject)
    {
        return '';
    }

    public String getOrderNumber(SObject sfSObject)
    {
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'Case' ? '' : ((Case) sfSObject).FLD_SAP_Return_Order_Number__c;
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
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'Case' ? '' : ((Case) sfSObject).FLD_SalesDocStatus__c;
    }

    public String getOpportunityId(SObject sfSObject)
    {
        return getOpportunity(sfsObject) == null ? null :  getOpportunity(sfsObject).Id;
    }

    private Opportunity getOpportunity(SObject sfSObject)
    {
        return null;
    }

    public Id getPriceBookId(SObject sfSObject)
    {
        Id pricebookId;
        if (sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'Case') {
            return null;
        }

        if (String.isEmpty(pricebookId)) pricebookId = UTIL_Pricebook.getStandardPriceBookId();

        return pricebookId;
    }

    public Id getProductId(SObject sfsObjectLine)
    {
        return sfsObjectLine == null || sfsObjectLine.getSObjectType().getDescribe().getName() != 'ProductRequestLineItem' ? null : ((ProductRequestLineItem) sfsObjectLine).Product2Id;
    }

    public String getMaterial(SObject sfSObject, SObject sfsObjectLine)
    {
        return sfsObjectLine == null || sfsObjectLine.getSObjectType().getDescribe().getName() != 'ProductRequestLineItem' || ((ProductRequestLineItem) sfsObjectLine).Product2 == null ? null : (String) ((ProductRequestLineItem) sfsObjectLine).Product2.get(UTIL_SFProduct.MaterialFieldName);
    }

    public String getItemNumber(SObject sfsObjectLine)
    {
        return sfsObjectLine == null || sfsObjectLine.getSObjectType().getDescribe().getName() != 'ProductRequestLineItem' ? '' : ((ProductRequestLineItem) sfsObjectLine).FLD_SAP_Item_Number__c;
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
        Case caseObj = (Case) sfSObject;

        if (String.isNotEmpty(caseObj.SAP_SaveSalesDocHeader__c)) {
            salesDocDetail = (DS_Document_Detail) JSON.deserialize(caseObj.SAP_SaveSalesDocHeader__c, DS_Document_Detail.class);
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
                ProductRequestLineItem prli = (ProductRequestLineItem) sfLineItem;
                DS_Document_Detail.ITEMS salesDocItem = new DS_Document_Detail.ITEMS();

                if (String.isNotEmpty(prli.SAP_SaveSalesDocItem__c)) {
                    salesDocItem = (DS_Document_Detail.ITEMS) JSON.deserialize(prli.SAP_SaveSalesDocItem__c, DS_Document_Detail.ITEMS.class);
                    itemNumber = Integer.valueOf(salesDocItem.ItemNumber);
                }
                else {
                    // Mapping of item fields from Sobject line items
                    salesDocItem.ItemNumber = String.valueOf(itemNumber);
                    salesDocItem.HigherLevelItemNumber = '000000';
                    salesDocItem.Material = getMaterial(sfsObject, sfLineItem);
                    salesDocItem.ItemDescription = prli.Description;
                    salesDocItem.OrderQuantity = prli.QuantityRequested;
                    if (prli.Product2 != null) salesDocItem.ConfigurableMaterial = prli.Product2.FLD_Configurable_Material__c;

                    salesDocItem.PARTNERS = UTIL_SalesDoc.convertAppSettingPartnersToPartners(appSettings.Item.PartnerPickers);
                    salesDocItem.ItemTexts = UTIL_SalesDoc.convertAppSettingTextsToTexts(appSettings.Item.Texts, salesDocDetail.CustomerLanguage);
                }

                salesDocItem.SFId = prli.Id;
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
        Case caseObj = (Case) sfSObject;        
        
        if (String.isNotEmpty(salesDocDetail.SalesDocument)) {
            if (sapDocType == 'Order') {
                caseObj.FLD_SAP_Return_Order_Number__c = salesDocDetail.SalesDocument;
            }
        }
        
        DS_Document_Detail copySalesDocDetail = salesDocDetail.cloneHeader();
        caseObj.SAP_SaveSalesDocHeader__c = JSON.serialize(copySalesDocDetail);

        return caseObj;
    }

    public SObject salesDocLineItemMappingToSObject(
        SObject sfSObject, 
        DS_Document_Detail.ITEMS item, 
        PricebookEntry materialEntry, 
        Id parentId, 
        SObject lineItem)
    {
        ProductRequestLineItem prli;

        if (lineItem == null) {
            prli = new ProductRequestLineItem();
            prli.CaseId = parentId;
            prli.Product2Id = materialEntry.Product2Id;
        }
        else {
            prli = (ProductRequestLineItem) lineItem;
        }

        prli.Description = item.ItemDescription;
        prli.QuantityRequested = item.OrderQuantity;
        prli.FLD_SAP_Item_Number__c = item.ItemNumber;
        prli.SAP_SaveSalesDocItem__c = JSON.serialize(item);

        return prli;
    }
}