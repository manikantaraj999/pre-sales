public with sharing class UTIL_SFCPQQuote implements I_SFSObjectDoc
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_SFCPQQuote.class);

    @testVisible
    private static String defaultSalesDocType = (String)UTIL_AppSettings.getValue(UTIL_AppSettings.CPQ, 'DefaultSalesDocType', '');
    @testVisible
    private static String defaultSalesOrg = (String)UTIL_AppSettings.getValue(UTIL_AppSettings.CPQ, 'DefaultSalesOrg', '');
    @testVisible
    private static String defaultDistributionChannel = (String)UTIL_AppSettings.getValue(UTIL_AppSettings.CPQ, 'DefaultDistributionChannel', '');
    @testVisible
    private static String defaultDivision = (String)UTIL_AppSettings.getValue(UTIL_AppSettings.CPQ, 'DefaultDivision', '');

    public static String QuoteFieldName
    {
        get
        {
            return (String)UTIL_AppSettings.getValue(UTIL_AppSettings.CPQ, 'CPQQuote.QuoteFieldName', 'FLD_SAP_Quote_Number__c');
        }
    }

    public static String OrderFieldName
    {
        get
        {
            return (String)UTIL_AppSettings.getValue(UTIL_AppSettings.CPQ, 'CPQQuote.OrderFieldName', 'FLD_SAP_Order_Number__c');
        }
    }

    public static String ContractFieldName
    {
        get
        {
            return (String)UTIL_AppSettings.getValue(UTIL_AppSettings.CPQ, 'CPQQuote.ContractFieldName', 'FLD_SAP_Contract_Number__c');
        }
    }

    public static String InquiryFieldName
    {
        get
        {
            return (String)UTIL_AppSettings.getValue(UTIL_AppSettings.CPQ, 'CPQQuote.InquiryFieldName', 'FLD_SAP_Inquiry_Number__c');
        }
    }

    public static String CreditMemoFieldName
    {
        get
        {
            return (String)UTIL_AppSettings.getValue(UTIL_AppSettings.CPQ, 'CPQQuote.CreditMemoFieldName', 'FLD_SAP_CreditMemo_Number__c');
        }
    }

    public static String DebitMemoFieldName
    {
        get
        {
            return (String)UTIL_AppSettings.getValue(UTIL_AppSettings.CPQ, 'CPQQuote.DebitMemoFieldName', 'FLD_SAP_DebitMemo_Number__c');
        }
    }

    public static String ReturnOrderFieldName
    {
        get
        {
            return (String)UTIL_AppSettings.getValue(UTIL_AppSettings.CPQ, 'CPQQuote.ReturnOrderFieldName', 'FLD_SAP_ReturnOrder_Number__c');
        }
    }

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
                string selectCmd = 'SELECT Id, Name, SBQQ__Opportunity2__c, SBQQ__PriceBook__c, SBQQ__Account__c,' +
                    ' SAP_Configuration__c, SAP_SaveSalesDocHeader__c, FLD_SalesDocStatus__c,' +
                    ' SBQQ__Account__r.' + UTIL_SFAccount.CustomerFieldName + ', FLD_Sold_To_Number__c,' +
                    ' FLD_Ship_To_Number__c, FLD_Bill_To_Number__c, FLD_Payer_Number__c, FLD_Document_Type__c,' +
                    ' FLD_Sales_Organization__c, FLD_Distribution_Channel__c, FLD_Division__c, ' + UTIL_SFCPQQuote.QuoteFieldName + ',' +
                    UTIL_SFCPQQuote.OrderFieldName + ',' + UTIL_SFCPQQuote.ContractFieldName + ',' + UTIL_SFCPQQuote.InquiryFieldName + ',' +
                    UTIL_SFCPQQuote.CreditMemoFieldName + ',' + UTIL_SFCPQQuote.DebitMemoFieldName + ',' + UTIL_SFCPQQuote.ReturnOrderFieldName +
                    ' FROM SBQQ__Quote__c';

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
                    else if (sapType == 'Order')
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
            string selectCmd = 'SELECT Id, Name, SBQQ__Quote__c, SBQQ__PricebookEntryId__c, FLD_SAP_Item_Number__c, SBQQ__Discount__c,' +
                ' SBQQ__AdditionalDiscount__c, SBQQ__Quantity__c, SBQQ__ListPrice__c, SBQQ__Product__r.SBQQ__ExternallyConfigurable__c,' +
                ' SBQQ__NetPrice__c, SBQQ__Description__c, SAP_Configuration__c, SAP_SaveSalesDocItem__c, SBQQ__Product__c,' +
                ' SBQQ__Product__r.' + UTIL_SFProduct.MaterialFieldName + ', SBQQ__DynamicOptionId__c, SBQQ__Number__c,' +
                ' SBQQ__UnitCost__c, SBQQ__BundledQuantity__c' +
                ' FROM SBQQ__QuoteLine__c WHERE SBQQ__Quote__c = :id ORDER BY SBQQ__Number__c';
                        
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
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'SBQQ__Quote__c' ? null : ((SBQQ__Quote__c) sfSObject).SBQQ__Account__c;
	}

    public String getCustomerNumber(SObject sfSObject)
	{
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'SBQQ__Quote__c' || ((SBQQ__Quote__c) sfSObject).SBQQ__Account__c == null ? null : (String) ((SBQQ__Quote__c) sfSObject).SBQQ__Account__r.get(UTIL_SFAccount.CustomerFieldName);
	}

	public String getName(SObject sfSObject)
	{
        return '';
	}

    public String getQuoteNumber(SObject sfSObject)
    {
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'SBQQ__Quote__c' ? '' : (String) ((SBQQ__Quote__c) sfSObject).get(UTIL_SFCPQQuote.QuoteFieldName);
    }

    public String getOrderNumber(SObject sfSObject)
    {
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'SBQQ__Quote__c' ? '' : (String) ((SBQQ__Quote__c) sfSObject).get(UTIL_SFCPQQuote.OrderFieldName);
    }

    public String getContractNumber(SObject sfSObject)
    {
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'SBQQ__Quote__c' ? '' : (String) ((SBQQ__Quote__c) sfSObject).get(UTIL_SFCPQQuote.ContractFieldName);
    }

    public String getInquiryNumber(SObject sfSObject)
    {
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'SBQQ__Quote__c' ? '' : (String) ((SBQQ__Quote__c) sfSObject).get(UTIL_SFCPQQuote.InquiryFieldName);
    }

    public String getCreditMemoNumber(SObject sfSObject)
    {
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'SBQQ__Quote__c' ? '' : (String) ((SBQQ__Quote__c) sfSObject).get(UTIL_SFCPQQuote.CreditMemoFieldName);
    }

    public String getDebitMemoNumber(SObject sfSObject)
    {
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'SBQQ__Quote__c' ? '' : (String) ((SBQQ__Quote__c) sfSObject).get(UTIL_SFCPQQuote.DebitMemoFieldName);
    }

    public String getReturnOrderNumber(SObject sfSObject)
    {
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'SBQQ__Quote__c' ? '' : (String) ((SBQQ__Quote__c) sfSObject).get(UTIL_SFCPQQuote.ReturnOrderFieldName);
    }

    public String getStatus(SObject sfSObject)
    {
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'SBQQ__Quote__c' ? '' : (String) ((SBQQ__Quote__c) sfSObject).FLD_SalesDocStatus__c;
    }

    public String getOpportunityId(SObject sfSObject)
    {
        return getOpportunity(sfsObject) == null ? null :  getOpportunity(sfsObject).Id;
    }

    private Opportunity getOpportunity(SObject sfSObject)
    {
        UTIL_SFOpportunity sfOpportunity = new UTIL_SFOpportunity();
        return sfSObject == null ? null : (Opportunity) sfOpportunity.getSObject(((SBQQ__Quote__c) sfSObject).SBQQ__Opportunity2__c);
    }

    public Id getPriceBookId(SObject sfSObject)
    {
        Id pricebookId;
        if (sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'SBQQ__Quote__c') {
            return null;
        }
        else pricebookId = ((SBQQ__Quote__c) sfSObject).SBQQ__PriceBook__c;

        if (String.isEmpty(pricebookId)) pricebookId = UTIL_Pricebook.getStandardPriceBookId();

        return pricebookId;
    }

    public Id getProductId(SObject sfsObjectLine)
    {
        return sfsObjectLine == null || sfsObjectLine.getSObjectType().getDescribe().getName() != 'SBQQ__QuoteLine__c' ? null : ((SBQQ__QuoteLine__c) sfsObjectLine).SBQQ__Product__c;
    }

    private Map<Id, String> productSAPMaterialNumberList;

    public String getMaterial(SObject sfSObject, SObject sfsObjectLine)
    {
        return sfsObjectLine == null || sfsObjectLine.getSObjectType().getDescribe().getName() != 'SBQQ__QuoteLine__c' || ((SBQQ__QuoteLine__c) sfsObjectLine).SBQQ__Product__c == null ? null : (String) ((SBQQ__QuoteLine__c) sfsObjectLine).SBQQ__Product__r.get(UTIL_SFProduct.MaterialFieldName);
    }

    public String getItemNumber(SObject sfsObjectLine)
    {
        return sfsObjectLine == null || sfsObjectLine.getSObjectType().getDescribe().getName() != 'SBQQ__QuoteLine__c' ? null : ((SBQQ__QuoteLine__c) sfsObjectLine).FLD_SAP_Item_Number__c;
    }

    public void validateSAPWithSfsObject(
        String calledFrom,
        SObject sfSObject)
    {
        // String simresultsJSON = ENSX_CPQ_QuoteCalculationService.prepareQuoteAndSimulate(getQuote(sfSObject, false), true);
        // ENSX_CPQ_QuoteCalculationService.SAPSimulationResults simresults = 
        //     (ENSX_CPQ_QuoteCalculationService.SAPSimulationResults) 
        //     JSON.deserialize(simresultsJSON, ENSX_CPQ_QuoteCalculationService.SAPSimulationResults.class);
        // if (simresults.Success)
        // {
        //     ENSX_Quote currentQuote = getQuote(sfSObject, true);
        //     Map<Integer, Map<String, ENSX_QuoteLine>> currentQuoteMap = new Map<Integer, Map<String, ENSX_QuoteLine>>();
        //     Integer qlTot = currentQuote.LinkedQuoteLines.size();
        //     for (Integer qlCnt = 0 ; qlCnt < qlTot ; qlCnt++)
        //     {
        //         ENSX_QuoteLine ql = currentQuote.LinkedQuoteLines[qlCnt];
        //         if (ql.IsProductFeature)
        //         {
        //             Map<String, ENSX_QuoteLine> materialItemMap = currentQuoteMap.containsKey(ql.ParentLineItem) ? 
        //                 currentQuoteMap.get(ql.ParentLineItem) : new Map<String, ENSX_QuoteLine>();
        //             if (materialItemMap.containsKey(ql.SAPMaterialNumber))
        //             {
        //                 Integer counter = 1;
        //                 while (materialItemMap.containsKey(ql.SAPMaterialNumber + ' (' + counter + ')'))
        //                 {
        //                     counter++;
        //                 }
        //                 materialItemMap.put(ql.SAPMaterialNumber + ' (' + counter + ')', ql);
        //             }
        //             else materialItemMap.put(ql.SAPMaterialNumber, ql);
        //             currentQuoteMap.put(ql.ParentLineItem, materialItemMap);
        //         }
        //     }

        //     Map<Integer, Map<String, ENSX_QuoteLine>> simQuoteMap = new Map<Integer, Map<String, ENSX_QuoteLine>>();
        //     qlTot = simresults.Quote.LinkedQuoteLines.size();
        //     for (Integer qlCnt = 0 ; qlCnt < qlTot ; qlCnt++)
        //     {
        //         ENSX_QuoteLine ql = simresults.Quote.LinkedQuoteLines[qlCnt];
        //         if (ql.IsProductFeature)
        //         {
        //             Map<String, ENSX_QuoteLine> materialItemMap = simQuoteMap.containsKey(ql.ParentLineItem) ? 
        //                 simQuoteMap.get(ql.ParentLineItem) : new Map<String, ENSX_QuoteLine>();
        //             if (materialItemMap.containsKey(ql.SAPMaterialNumber))
        //             {
        //                 Integer counter = 1;
        //                 while (materialItemMap.containsKey(ql.SAPMaterialNumber + ' (' + counter + ')'))
        //                 {
        //                     counter++;
        //                 }
        //                 materialItemMap.put(ql.SAPMaterialNumber + ' (' + counter + ')', ql);
        //             }
        //             else materialItemMap.put(ql.SAPMaterialNumber, ql);
        //             simQuoteMap.put(ql.ParentLineItem, materialItemMap);
        //         }
        //     }

        //     List<Integer> currQuoteList = new List<Integer>(currentQuoteMap.keySet());
        //     Integer currQuoteTot = currQuoteList.size();
        //     for (Integer currQuoteCnt = 0 ; currQuoteCnt < currQuoteTot ; currQuoteCnt++)
        //     {
        //         Integer parentItem = currQuoteList[currQuoteCnt];
        //         Map<String, ENSX_QuoteLine> currentQuoteLinesMap = currentQuoteMap.get(parentItem);
        //         Map<String, ENSX_QuoteLine> simQuoteLinesMap = simQuoteMap.get(parentItem);
        //         List<String> currQuoteLineList = new List<String>(currentQuoteLinesMap.keySet());
        //         Integer currQuoteLineTot = currQuoteLineList.size();
        //         for (Integer currQuoteLineCnt = 0 ; currQuoteLineCnt < currQuoteLineTot ; currQuoteLineCnt++)
        //         {
        //             String materialKey = currQuoteLineList[currQuoteLineCnt];
        //             ENSX_QuoteLine currentQuoteLine = currentQuoteLinesMap.get(materialKey);
        //             ENSX_QuoteLine simQuoteLine = simQuoteLinesMap != null && simQuoteLinesMap.containsKey(materialKey) ? 
        //                 simQuoteLinesMap.get(materialKey) : null;
        //             if (simQuoteLine != null)
        //             {
        //                 Boolean isListChange = (currentQuoteLine.ListPrice != simQuoteLine.ListPrice);
        //                 Boolean isCostChange = currentQuoteLine.CostPrice != simQuoteLine.CostPrice;
        //                 Boolean isQuantityChange = currentQuoteLine.Quantity != simQuoteLine.Quantity;
        //                 if (isQuantityChange)
        //                 {
        //                     if (isListChange && isCostChange)
        //                     {
        //                         UTIL_PageMessages.addMessage(UTIL_PageMessages.WARNING, 
        //                             buildMessage(currentQuote.LinkedQuoteLines, currentQuoteLine, 'List Price, Unit Cost, and Quantity change for ', ''));
        //                     }
        //                     else if (isListChange)
        //                     {
        //                         UTIL_PageMessages.addMessage(UTIL_PageMessages.WARNING, 
        //                             buildMessage(currentQuote.LinkedQuoteLines, currentQuoteLine, 'List Price and Quantity change for ', ''));
        //                     }
        //                     else if (isCostChange)
        //                     {
        //                         UTIL_PageMessages.addMessage(UTIL_PageMessages.WARNING, 
        //                             buildMessage(currentQuote.LinkedQuoteLines, currentQuoteLine, 'Unit Cost and Quantity change for ', ''));
        //                     }
        //                     else 
        //                     {
        //                         UTIL_PageMessages.addMessage(UTIL_PageMessages.WARNING, 
        //                             buildMessage(currentQuote.LinkedQuoteLines, currentQuoteLine, 'Quantity change for ', ''));
        //                     }
        //                 }
        //                 else if (isListChange)
        //                 {
        //                     if (isCostChange)
        //                     {
        //                         UTIL_PageMessages.addMessage(UTIL_PageMessages.WARNING, 
        //                             buildMessage(currentQuote.LinkedQuoteLines, currentQuoteLine, 'List Price and Unit Cost change for ', ''));
        //                     }
        //                     else
        //                     {
        //                         UTIL_PageMessages.addMessage(UTIL_PageMessages.WARNING, 
        //                             buildMessage(currentQuote.LinkedQuoteLines, currentQuoteLine, 'List Price change for ', ''));
        //                     }
        //                 }
        //                 else if (isCostChange)
        //                 {
        //                     UTIL_PageMessages.addMessage(UTIL_PageMessages.WARNING, 
        //                         buildMessage(currentQuote.LinkedQuoteLines, currentQuoteLine, 'Unit Cost change for ', ''));
        //                 }
        //                 simQuoteLinesMap.remove(materialKey);
        //             }
        //             else 
        //             {
        //                 UTIL_PageMessages.addMessage(UTIL_PageMessages.WARNING, 
        //                     buildMessage(currentQuote.LinkedQuoteLines, currentQuoteLine, '', ' from CPQ Quote not on SAP.'));
        //             }
        //         }
        //         if (simQuoteLinesMap != null)
        //         {
        //             List<ENSX_QuoteLine> qlList = simQuoteLinesMap.values();
        //             qlTot = qlList.size();
        //             for (Integer qlCnt = 0 ; qlCnt < qlTot ; qlCnt++)
        //             {
        //                 ENSX_QuoteLine simQuoteLine = qlList[qlCnt];
        //                 UTIL_PageMessages.addMessage(UTIL_PageMessages.WARNING, simQuoteLine.SAPMaterialNumber + ' from SAP not on CPQ Quote.');
        //             }
        //         }
        //     }
        // }
        // else 
        // {
        //     List<String> messageList = simresults.Message.split('; ');
        //     Integer mTot = messageList.size();
        //     for (Integer mCnt = 0 ; mCnt < mTot ; mCnt++)
        //     {
        //         String message = messageList[mCnt];
        //         UTIL_PageMessages.addMessage(UTIL_PageMessages.ERROR, message);
        //     }
        // }
    }

    // private String buildMessage (
    //     List<ENSX_QuoteLine> quoteLines,
    //     ENSX_QuoteLine quoteLine, 
    //     String messageBefore,
    //     String messageAfter)
    // {
    //     String message = messageBefore;
    //     if (String.isNotEmpty(String.valueOf(quoteLine.LineItem))) message += 'Item Number ' + String.valueOf(quoteLine.LineItem) + ' ';
    //     message += 'Product Code ' + quoteLine.SAPMaterialNumber;

    //     Integer parentItemNumber = quoteLine.ParentLineItem;
    //     if (parentItemNumber != 0)
    //     {
    //         String parentSAPMaterialNumber = '';
    //         List<ENSX_QuoteLine> qlList = quoteLines;
    //         Integer qlTot = qlList.size();
    //         for (Integer qlCnt = 0 ; qlCnt < qlTot ; qlCnt++)
    //         {
    //             ENSX_QuoteLine ql = qlList[qlCnt];
    //             if (ql.LineItem == parentItemNumber)
    //             {
    //                 parentSAPMaterialNumber = ql.SAPMaterialNumber;
    //             }
    //         }
    //         message += ' from Parent Item Number ' + String.valueOf(parentItemNumber) + ' SAP Material Number ' + parentSAPMaterialNumber;
    //     }
    //     return message + messageAfter;
    // }

    // private ENSX_Quote getQuote(SObject sfSObject, Boolean withFeatures)
    // {
    //     SBQQ__Quote__c cpqQuote = (SBQQ__Quote__c) sfSObject;

    //     ENSX_Quote qte = new ENSX_Quote();
    //     qte.QuoteId = cpqQuote.Id;
    //     qte.LinkedQuoteLines = new List<ENSX_QuoteLine>();
    //     Integer parentLineItem = 0;
    //     List<SObject> solList = getSObjectLineItems(sfsObject.Id).values();
    //     Integer solTot = solList.size();
    //     for (Integer solCnt = 0 ; solCnt < solTot ; solCnt++)
    //     {
    //         SObject sfsObjectLine = solList[solCnt];
    //         SBQQ__QuoteLine__c quoteLine = (SBQQ__QuoteLine__c) sfsObjectLine;
    //         if (String.isEmpty(quoteLine.SBQQ__DynamicOptionId__c) || withFeatures)
    //         {
    //             ENSX_QuoteLine qteLine = new ENSX_QuoteLine ();
    //             qteLine.ListPrice = quoteLine.SBQQ__ListPrice__c;
    //             qteLine.CostPrice = quoteLine.SBQQ__UnitCost__c;
    //             qteLine.NetPrice = 0.0;
    //             qteLine.DiscountPercent = 0.0;
    //             qteLine.IsProductFeature = String.isNotEmpty(quoteLine.SBQQ__DynamicOptionId__c);
    //             if (qteLine.IsProductFeature)
    //             {
    //                 qteLine.ParentLineItem = parentLineItem;
    //                 qteLine.Quantity = quoteLine.SBQQ__BundledQuantity__c;
    //             }
    //             else 
    //             {
    //                 parentLineItem = quoteLine.SBQQ__Number__c.intValue();
    //                 qteLine.Quantity = quoteLine.SBQQ__Quantity__c;
    //             }
    //             qteLine.LineItem = quoteLine.SBQQ__Number__c.intValue();
    //             qteLine.Product = quoteLine.SBQQ__Product__c;
    //             qteLine.PricebookEntry = quoteLine.SBQQ__PricebookEntryId__c;
    //             qteLine.SAPMaterialNumber = getMaterial(sfsObject, sfsObjectLine);
    //             qteLine.itemJSON = quoteLine.SAP_Configuration__c;
    //             qteLine.ItemNumber = quoteLine.FLD_SAP_Item_Number__c;
    //             qte.LinkedQuoteLines.add(qteLine);
    //         }
    //     }
    //     return qte;
    // }

    public DS_Document_Detail sObjectToSalesDocMapping(
        SObject sfSObject,
        List<SObject> sfLineItems,
        DS_Document_Detail salesDocDetail,
        DS_SalesDocAppSettings appSettings)
    {
        //Do the mapping from SObject and SF Line Items to salesDocDetail here
        SBQQ__Quote__c quote = (SBQQ__Quote__c) sfSObject;

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
                SBQQ__QuoteLine__c quoteLine = (SBQQ__QuoteLine__c) sfLineItem;
                DS_Document_Detail.ITEMS salesDocItem = new DS_Document_Detail.ITEMS();

                if (String.isNotEmpty(quoteLine.SAP_SaveSalesDocItem__c)) {
                    salesDocItem = (DS_Document_Detail.ITEMS) JSON.deserialize(quoteLine.SAP_SaveSalesDocItem__c, DS_Document_Detail.ITEMS.class);
                    itemNumber = Integer.valueOf(salesDocItem.ItemNumber);
                }
                else {
                    // Mapping of item fields from Sobject line items
                    salesDocItem.ItemNumber = String.valueOf(itemNumber);
                    salesDocItem.HigherLevelItemNumber = '000000';
                    salesDocItem.Material = getMaterial(sfsObject, sfLineItem);
                    salesDocItem.ItemDescription = quoteLine.SBQQ__Description__c;
                    salesDocItem.NetItemPrice = quoteLine.SBQQ__ListPrice__c;
                    salesDocItem.OrderQuantity = quoteLine.SBQQ__Quantity__c;
                    if (quoteLine.SBQQ__Product__c != null) salesDocItem.ConfigurableMaterial = quoteLine.SBQQ__Product__r.SBQQ__ExternallyConfigurable__c;

                    salesDocItem.PARTNERS = UTIL_SalesDoc.convertAppSettingPartnersToPartners(appSettings.Item.PartnerPickers);
                    salesDocItem.ItemTexts = UTIL_SalesDoc.convertAppSettingTextsToTexts(appSettings.Item.Texts, salesDocDetail.CustomerLanguage);
                }

                if (String.isNotEmpty(quoteLine.SAP_Configuration__c)) {
                    ENSX_ItemConfiguration cpqItemConfig = (ENSX_ItemConfiguration) JSON.deserialize(quoteLine.SAP_Configuration__c,ENSX_ItemConfiguration.class);
                    if (cpqItemConfig != null && cpqItemConfig.selectedCharacteristics != null) {
                        salesDocItem.ItemConfigurations = new List<DS_Document_Detail.CONFIG>();
                        Integer charTot = cpqItemConfig.selectedCharacteristics.size();
                        for (Integer charCnt = 0; charCnt < charTot; charCnt++)
                        {
                            ENSX_Characteristic characteristic = cpqItemConfig.selectedCharacteristics[charCnt];
                            DS_Document_Detail.CONFIG itemConfig = new DS_Document_Detail.CONFIG();
                            itemConfig.CharacteristicID = characteristic.CharacteristicID;
                            itemConfig.CharacteristicName = characteristic.CharacteristicName;
                            itemConfig.CharacteristicValue = characteristic.CharacteristicValue;
                            itemConfig.CharacteristicValueDescription = characteristic.CharacteristicValueDescription;
                            itemConfig.UserModified = characteristic.UserModified;
                            salesDocItem.ItemConfigurations.add(itemConfig);
                        }
                    }
                }

                salesDocItem.SFId = quoteLine.Id;
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
        SBQQ__Quote__c quote = (SBQQ__Quote__c) sfSObject;
        
        if (String.isNotEmpty(salesDocDetail.SalesDocument)) {
            quote.SBQQ__Status__c = 'Accepted';           

            if (sapDocType == 'Quote') {
                quote.put(UTIL_SFCPQQuote.QuoteFieldName, salesDocDetail.SalesDocument);
            }
            else if (sapDocType == 'Order') {
                quote.put(UTIL_SFCPQQuote.OrderFieldName, salesDocDetail.SalesDocument);
            }
            else if (sapDocType == 'Contract') {
                quote.put(UTIL_SFCPQQuote.ContractFieldName, salesDocDetail.SalesDocument);
            }
            else if (sapDocType == 'Credit Memo') {
                quote.put(UTIL_SFCPQQuote.CreditMemoFieldName, salesDocDetail.SalesDocument);
            }
            else if (sapDocType == 'Debit Memo') {
                quote.put(UTIL_SFCPQQuote.DebitMemoFieldName, salesDocDetail.SalesDocument);
            }
            else if (sapDocType == 'Inquiry') {
                quote.put(UTIL_SFCPQQuote.InquiryFieldName, salesDocDetail.SalesDocument);
            }
            else if (sapDocType == 'Return Order') {
                quote.put(UTIL_SFCPQQuote.ReturnOrderFieldName, salesDocDetail.SalesDocument);
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
        SBQQ__QuoteLine__c quoteLine;

        if (lineItem == null) {
            quoteLine = new SBQQ__QuoteLine__c();
            quoteLine.SBQQ__Quote__c = parentId;
            quoteLine.SBQQ__PricebookEntryId__c = materialEntry.Id;
            quoteLine.SBQQ__Product__c = materialEntry.Product2Id;
        }
        else {
            quoteLine = (SBQQ__QuoteLine__c) lineItem;
        }

        quoteLine.SBQQ__Description__c = item.ItemDescription;
        quoteLine.SBQQ__Quantity__c = item.OrderQuantity;
        quoteLine.SBQQ__NetPrice__c = item.NetItemPrice;
        quoteLine.FLD_SAP_Item_Number__c = item.ItemNumber;
        quoteLine.SAP_SaveSalesDocItem__c = JSON.serialize(item);

        List<ENSX_Characteristic> selectedCharacteristics = new List<ENSX_Characteristic>();
        if (item.ItemConfigurations != null) {
            Integer itemConfigTot = item.ItemConfigurations.size();
            for (Integer itemConfigCnt = 0; itemConfigCnt < itemConfigTot; itemConfigCnt++)
            {
                DS_Document_Detail.CONFIG itemConfig = item.ItemConfigurations[itemConfigCnt];
                ENSX_Characteristic characteristic = new ENSX_Characteristic();
                characteristic.CharacteristicID = itemConfig.CharacteristicID;
                characteristic.CharacteristicName = itemConfig.CharacteristicName;
                characteristic.CharacteristicValue = itemConfig.CharacteristicValue;
                characteristic.CharacteristicValueDescription = itemConfig.CharacteristicValueDescription;
                characteristic.UserModified = itemConfig.UserModified;
                selectedCharacteristics.add(characteristic);
            }
        }

        ENSX_ItemConfiguration cpqItemConfig = new ENSX_ItemConfiguration();
        if (String.isNotEmpty(quoteLine.SAP_Configuration__c)) {
            cpqItemConfig = (ENSX_ItemConfiguration) JSON.deserialize(quoteLine.SAP_Configuration__c,ENSX_ItemConfiguration.class);
        }
        cpqItemConfig.selectedCharacteristics = selectedCharacteristics;

        quoteLine.SAP_Configuration__c = JSON.serialize(cpqItemConfig);

        return quoteLine;
    }
}