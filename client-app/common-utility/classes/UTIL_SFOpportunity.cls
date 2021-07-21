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
            return (String)UTIL_AppSettings.getValue(UTIL_AppSettings.EnterpriseApp, 'Opportunity.QuoteFieldName', 'FLD_SAP_Quote_Number__c');
        }
    }

    // Returns the field name which stores the SAP Order number
    // The default is from the EDM package or from the AppSettings
    public static String OrderFieldName
    {
        get
        {
            return (String)UTIL_AppSettings.getValue(UTIL_AppSettings.EnterpriseApp, 'Opportunity.OrderFieldName', 'FLD_SAP_Order_Number__c');
        }
    }

    // Returns the field name which stores the SAP Contract number
    // The default is from the EDM package or from the AppSettings
    public static String ContractFieldName
    {
        get
        {
            return (String)UTIL_AppSettings.getValue(UTIL_AppSettings.EnterpriseApp, 'Opportunity.ContractFieldName', 'FLD_SAP_Contract_Number__c');
        }
    }

    public static String InquiryFieldName
    {
        get
        {
            return (String)UTIL_AppSettings.getValue(UTIL_AppSettings.EnterpriseApp, 'Opportunity.InquiryFieldName', 'FLD_SAP_Inquiry_Number__c');
        }
    }

    public static String CreditMemoFieldName
    {
        get
        {
            return (String)UTIL_AppSettings.getValue(UTIL_AppSettings.EnterpriseApp, 'Opportunity.CreditMemoFieldName', 'FLD_SAP_CreditMemo_Number__c');
        }
    }

    public static String DebitMemoFieldName
    {
        get
        {
            return (String)UTIL_AppSettings.getValue(UTIL_AppSettings.EnterpriseApp, 'Opportunity.DebitMemoFieldName', 'FLD_SAP_DebitMemo_Number__c');
        }
    }

    public static String ReturnOrderFieldName
    {
        get
        {
            return (String)UTIL_AppSettings.getValue(UTIL_AppSettings.EnterpriseApp, 'Opportunity.ReturnOrderFieldName', 'FLD_SAP_ReturnOrder_Number__c');
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
                            UTIL_SFOpportunity.OrderFieldName + ',' + UTIL_SFOpportunity.ContractFieldName + ',' + UTIL_SFOpportunity.InquiryFieldName + ',' +
                            UTIL_SFOpportunity.CreditMemoFieldName + ',' + UTIL_SFOpportunity.DebitMemoFieldName + ',' + UTIL_SFOpportunity.ReturnOrderFieldName +
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

    public String getInquiryNumber(SObject sfSObject)
    {
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'Opportunity' ? '' : (String) sfSObject.get(UTIL_SFOpportunity.InquiryFieldName);
    }

    public String getCreditMemoNumber(SObject sfSObject)
    {
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'Opportunity' ? '' : (String) sfSObject.get(UTIL_SFOpportunity.CreditMemoFieldName);
    }

    public String getDebitMemoNumber(SObject sfSObject)
    {
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'Opportunity' ? '' : (String) sfSObject.get(UTIL_SFOpportunity.DebitMemoFieldName);
    }

    public String getReturnOrderNumber(SObject sfSObject)
    {
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'Opportunity' ? '' : (String) sfSObject.get(UTIL_SFOpportunity.ReturnOrderFieldName);
    }

    public String getStatus(SObject sfSObject)
    {
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'Opportunity' ? '' : ((Opportunity) sfSObject).FLD_SalesDocStatus__c;
    }

    public String getOpportunityId(SObject sfSObject)
    {
        return getOpportunity(sfsObject) == null ? null :  getOpportunity(sfsObject).Id;
    }

    private Opportunity getOpportunity(SObject sfSObject)
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

    public String getMaterial(SObject sfSObject, SObject sfsObjectLine)
    {
        return sfsObjectLine == null || sfsObjectLine.getSObjectType().getDescribe().getName() != 'OpportunityLineItem' || ((OpportunityLineItem) sfsObjectLine).Product2 == null ? null : (String) ((OpportunityLineItem) sfsObjectLine).Product2.get(UTIL_SFProduct.MaterialFieldName);
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
                    salesDocItem.Material = getMaterial(sfsObject, sfLineItem);
                    salesDocItem.ItemDescription = oppLineItem.Description;
                    salesDocItem.NetItemPrice = oppLineItem.ListPrice;
                    salesDocItem.OrderQuantity = oppLineItem.Quantity;
                    salesDocItem.ScheduleLineDate = oppLineItem.ServiceDate;
                    if (oppLineItem.Product2 != null) salesDocItem.ConfigurableMaterial = oppLineItem.Product2.FLD_Configurable_Material__c;

                    salesDocItem.PARTNERS = UTIL_SalesDoc.convertAppSettingPartnersToPartners(appSettings.Item.PartnerPickers);
                    salesDocItem.ItemTexts = UTIL_SalesDoc.convertAppSettingTextsToTexts(appSettings.Item.Texts, salesDocDetail.CustomerLanguage);
                }

                salesDocItem.SFId = oppLineItem.Id;
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
            else if (sapDocType == 'Credit Memo') {
                opp.put(UTIL_SFOpportunity.CreditMemoFieldName, salesDocDetail.SalesDocument);
            }
            else if (sapDocType == 'Debit Memo') {
                opp.put(UTIL_SFOpportunity.DebitMemoFieldName, salesDocDetail.SalesDocument);
            }
            else if (sapDocType == 'Inquiry') {
                opp.put(UTIL_SFOpportunity.InquiryFieldName, salesDocDetail.SalesDocument);
            }
            else if (sapDocType == 'Return Order') {
                opp.put(UTIL_SFOpportunity.ReturnOrderFieldName, salesDocDetail.SalesDocument);
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