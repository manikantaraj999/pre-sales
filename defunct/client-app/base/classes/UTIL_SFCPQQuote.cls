public with sharing class UTIL_SFCPQQuote implements I_SFSObjectDoc
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_SFCPQQuote.class);

    @testVisible
    private static String defaultSalesDocType = (String)UTIL_AppSettings.getValue('CPQSimulation.DefaultSalesDocType', '');
    @testVisible
    private static String defaultSalesOrg = (String)UTIL_AppSettings.getValue('CPQSimulation.DefaultSalesOrg', '');
    @testVisible
    private static String defaultDistributionChannel = (String)UTIL_AppSettings.getValue('CPQSimulation.DefaultDistributionChannel', '');
    @testVisible
    private static String defaultDivision = (String)UTIL_AppSettings.getValue('CPQSimulation.DefaultDivision', '');

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
                    ' FLD_SAP_Order_Number__c, FLD_SAP_Quote_Number__c, FLD_SAP_Contract_Number__c, SAP_Configuration__c, SAP_SaveSalesDocHeader__c,' +
                    ' SBQQ__Account__r.' + UTIL_SFAccount.CustomerFieldName + ', FLD_SalesDocStatus__c,' +
                    ' FLD_Sold_To_Number__c, FLD_Ship_To_Number__c, FLD_Bill_To_Number__c, FLD_Payer_Number__c,' +
                    ' FLD_Document_Type__c, FLD_Sales_Organization__c, FLD_Distribution_Channel__c, FLD_Division__c' +
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
            string selectCmd = 'SELECT Id, Name, SBQQ__Quote__c, SBQQ__PricebookEntryId__c, FLD_SAP_Item_Number__c,' +
                        ' SBQQ__Discount__c, SBQQ__AdditionalDiscount__c, SBQQ__Quantity__c, SBQQ__ListPrice__c, SBQQ__Product__r.SBQQ__ExternallyConfigurable__c,' +
                        ' SBQQ__NetPrice__c, SBQQ__Description__c, SAP_Configuration__c, SBQQ__ProductCode__c, SAP_SaveSalesDocItem__c,' + 
                        ' SBQQ__Product__c, SBQQ__DynamicOptionId__c, SBQQ__Number__c, SBQQ__UnitCost__c, SBQQ__BundledQuantity__c' +
                        ' FROM SBQQ__QuoteLine__c WHERE SBQQ__Quote__c = :id ORDER BY SBQQ__Number__c';
                        
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
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'SBQQ__Quote__c' ? '' : ((SBQQ__Quote__c) sfSObject).FLD_SAP_Quote_Number__c;
    }

    public String getOrderNumber(SObject sfSObject)
    {
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'SBQQ__Quote__c' ? '' : ((SBQQ__Quote__c) sfSObject).FLD_SAP_Order_Number__c;
    }

    public String getContractNumber(SObject sfSObject)
    {
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'SBQQ__Quote__c' ? '' : ((SBQQ__Quote__c) sfSObject).FLD_SAP_Contract_Number__c;
    }

    public String getStatus(SObject sfSObject)
    {
        return sfSObject == null || sfSObject.getSObjectType().getDescribe().getName() != 'SBQQ__Quote__c' ? '' : ((SBQQ__Quote__c) sfSObject).FLD_SalesDocStatus__c;
    }

    public String getOpportunityId(SObject sfSObject)
    {
        return getOpportunity(sfsObject) == null ? null :  getOpportunity(sfsObject).Id;
    }

    public Opportunity getOpportunity(SObject sfSObject)
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
        return sfsObjectLine == null || sfsObjectLine.getSObjectType().getDescribe().getName() != 'SBQQ__QuoteLine__c' ? null : ((SBQQ__QuoteLine__c) sfsObjectLine).SBQQ__ProductCode__c;
    }

    public String getItemNumber(SObject sfsObjectLine)
    {
        return sfsObjectLine == null || sfsObjectLine.getSObjectType().getDescribe().getName() != 'SBQQ__QuoteLine__c' ? null : ((SBQQ__QuoteLine__c) sfsObjectLine).FLD_SAP_Item_Number__c;
    }

    public void validateSAPWithSfsObject(
        String calledFrom,
        SObject sfSObject)
    {
        String simresultsJSON = ENSX_CPQ_QuoteCalculationService.prepareQuoteAndSimulate(getQuote(sfSObject, false), true);
        ENSX_CPQ_QuoteCalculationService.SAPSimulationResults simresults = 
            (ENSX_CPQ_QuoteCalculationService.SAPSimulationResults) 
            JSON.deserialize(simresultsJSON, ENSX_CPQ_QuoteCalculationService.SAPSimulationResults.class);
        if (simresults.Success)
        {
            ENSX_Quote currentQuote = getQuote(sfSObject, true);
            Map<Integer, Map<String, ENSX_QuoteLine>> currentQuoteMap = new Map<Integer, Map<String, ENSX_QuoteLine>>();
            Integer qlTot = currentQuote.LinkedQuoteLines.size();
            for (Integer qlCnt = 0 ; qlCnt < qlTot ; qlCnt++)
            {
                ENSX_QuoteLine ql = currentQuote.LinkedQuoteLines[qlCnt];
                if (ql.IsProductFeature)
                {
                    Map<String, ENSX_QuoteLine> materialItemMap = currentQuoteMap.containsKey(ql.ParentLineItem) ? 
                        currentQuoteMap.get(ql.ParentLineItem) : new Map<String, ENSX_QuoteLine>();
                    if (materialItemMap.containsKey(ql.SAPMaterialNumber))
                    {
                        Integer counter = 1;
                        while (materialItemMap.containsKey(ql.SAPMaterialNumber + ' (' + counter + ')'))
                        {
                            counter++;
                        }
                        materialItemMap.put(ql.SAPMaterialNumber + ' (' + counter + ')', ql);
                    }
                    else materialItemMap.put(ql.SAPMaterialNumber, ql);
                    currentQuoteMap.put(ql.ParentLineItem, materialItemMap);
                }
            }

            Map<Integer, Map<String, ENSX_QuoteLine>> simQuoteMap = new Map<Integer, Map<String, ENSX_QuoteLine>>();
            qlTot = simresults.Quote.LinkedQuoteLines.size();
            for (Integer qlCnt = 0 ; qlCnt < qlTot ; qlCnt++)
            {
                ENSX_QuoteLine ql = simresults.Quote.LinkedQuoteLines[qlCnt];
                if (ql.IsProductFeature)
                {
                    Map<String, ENSX_QuoteLine> materialItemMap = simQuoteMap.containsKey(ql.ParentLineItem) ? 
                        simQuoteMap.get(ql.ParentLineItem) : new Map<String, ENSX_QuoteLine>();
                    if (materialItemMap.containsKey(ql.SAPMaterialNumber))
                    {
                        Integer counter = 1;
                        while (materialItemMap.containsKey(ql.SAPMaterialNumber + ' (' + counter + ')'))
                        {
                            counter++;
                        }
                        materialItemMap.put(ql.SAPMaterialNumber + ' (' + counter + ')', ql);
                    }
                    else materialItemMap.put(ql.SAPMaterialNumber, ql);
                    simQuoteMap.put(ql.ParentLineItem, materialItemMap);
                }
            }

            List<Integer> currQuoteList = new List<Integer>(currentQuoteMap.keySet());
            Integer currQuoteTot = currQuoteList.size();
            for (Integer currQuoteCnt = 0 ; currQuoteCnt < currQuoteTot ; currQuoteCnt++)
            {
                Integer parentItem = currQuoteList[currQuoteCnt];
                Map<String, ENSX_QuoteLine> currentQuoteLinesMap = currentQuoteMap.get(parentItem);
                Map<String, ENSX_QuoteLine> simQuoteLinesMap = simQuoteMap.get(parentItem);
                List<String> currQuoteLineList = new List<String>(currentQuoteLinesMap.keySet());
                Integer currQuoteLineTot = currQuoteLineList.size();
                for (Integer currQuoteLineCnt = 0 ; currQuoteLineCnt < currQuoteLineTot ; currQuoteLineCnt++)
                {
                    String materialKey = currQuoteLineList[currQuoteLineCnt];
                    ENSX_QuoteLine currentQuoteLine = currentQuoteLinesMap.get(materialKey);
                    ENSX_QuoteLine simQuoteLine = simQuoteLinesMap != null && simQuoteLinesMap.containsKey(materialKey) ? 
                        simQuoteLinesMap.get(materialKey) : null;
                    if (simQuoteLine != null)
                    {
                        Boolean isListChange = (currentQuoteLine.ListPrice != simQuoteLine.ListPrice);
                        Boolean isCostChange = currentQuoteLine.CostPrice != simQuoteLine.CostPrice;
                        Boolean isQuantityChange = currentQuoteLine.Quantity != simQuoteLine.Quantity;
                        if (isQuantityChange)
                        {
                            if (isListChange && isCostChange)
                            {
                                UTIL_PageMessages.addMessage(UTIL_PageMessages.WARNING, 
                                    buildMessage(currentQuote.LinkedQuoteLines, currentQuoteLine, 'List Price, Unit Cost, and Quantity change for ', ''));
                            }
                            else if (isListChange)
                            {
                                UTIL_PageMessages.addMessage(UTIL_PageMessages.WARNING, 
                                    buildMessage(currentQuote.LinkedQuoteLines, currentQuoteLine, 'List Price and Quantity change for ', ''));
                            }
                            else if (isCostChange)
                            {
                                UTIL_PageMessages.addMessage(UTIL_PageMessages.WARNING, 
                                    buildMessage(currentQuote.LinkedQuoteLines, currentQuoteLine, 'Unit Cost and Quantity change for ', ''));
                            }
                            else 
                            {
                                UTIL_PageMessages.addMessage(UTIL_PageMessages.WARNING, 
                                    buildMessage(currentQuote.LinkedQuoteLines, currentQuoteLine, 'Quantity change for ', ''));
                            }
                        }
                        else if (isListChange)
                        {
                            if (isCostChange)
                            {
                                UTIL_PageMessages.addMessage(UTIL_PageMessages.WARNING, 
                                    buildMessage(currentQuote.LinkedQuoteLines, currentQuoteLine, 'List Price and Unit Cost change for ', ''));
                            }
                            else
                            {
                                UTIL_PageMessages.addMessage(UTIL_PageMessages.WARNING, 
                                    buildMessage(currentQuote.LinkedQuoteLines, currentQuoteLine, 'List Price change for ', ''));
                            }
                        }
                        else if (isCostChange)
                        {
                            UTIL_PageMessages.addMessage(UTIL_PageMessages.WARNING, 
                                buildMessage(currentQuote.LinkedQuoteLines, currentQuoteLine, 'Unit Cost change for ', ''));
                        }
                        simQuoteLinesMap.remove(materialKey);
                    }
                    else 
                    {
                        UTIL_PageMessages.addMessage(UTIL_PageMessages.WARNING, 
                            buildMessage(currentQuote.LinkedQuoteLines, currentQuoteLine, '', ' from CPQ Quote not on SAP.'));
                    }
                }
                if (simQuoteLinesMap != null)
                {
                    List<ENSX_QuoteLine> qlList = simQuoteLinesMap.values();
                    qlTot = qlList.size();
                    for (Integer qlCnt = 0 ; qlCnt < qlTot ; qlCnt++)
                    {
                        ENSX_QuoteLine simQuoteLine = qlList[qlCnt];
                        UTIL_PageMessages.addMessage(UTIL_PageMessages.WARNING, simQuoteLine.SAPMaterialNumber + ' from SAP not on CPQ Quote.');
                    }
                }
            }
        }
        else 
        {
            List<String> messageList = simresults.Message.split('; ');
            Integer mTot = messageList.size();
            for (Integer mCnt = 0 ; mCnt < mTot ; mCnt++)
            {
                String message = messageList[mCnt];
                UTIL_PageMessages.addMessage(UTIL_PageMessages.ERROR, message);
            }
        }
    }

    private String buildMessage (
        List<ENSX_QuoteLine> quoteLines,
        ENSX_QuoteLine quoteLine, 
        String messageBefore,
        String messageAfter)
    {
        String message = messageBefore;
        if (String.isNotEmpty(String.valueOf(quoteLine.LineItem))) message += 'Item Number ' + String.valueOf(quoteLine.LineItem) + ' ';
        message += 'Product Code ' + quoteLine.SAPMaterialNumber;

        Integer parentItemNumber = quoteLine.ParentLineItem;
        if (parentItemNumber != 0)
        {
            String parentProductCode = '';
            List<ENSX_QuoteLine> qlList = quoteLines;
            Integer qlTot = qlList.size();
            for (Integer qlCnt = 0 ; qlCnt < qlTot ; qlCnt++)
            {
                ENSX_QuoteLine ql = qlList[qlCnt];
                if (ql.LineItem == parentItemNumber)
                {
                    parentProductCode = ql.SAPMaterialNumber;
                }
            }
            message += ' from Parent Item Number ' + String.valueOf(parentItemNumber) + ' Product Code ' + parentProductCode;
        }
        return message + messageAfter;
    }

    private ENSX_Quote getQuote(SObject sfSObject, Boolean withFeatures)
    {
        SBQQ__Quote__c cpqQuote = (SBQQ__Quote__c) sfSObject;

        ENSX_Quote qte = new ENSX_Quote();
        qte.QuoteId = cpqQuote.Id;
        qte.LinkedQuoteLines = new List<ENSX_QuoteLine>();
        Integer parentLineItem = 0;
        List<SObject> solList = getSObjectLineItems(sfsObject.Id).values();
        Integer solTot = solList.size();
        for (Integer solCnt = 0 ; solCnt < solTot ; solCnt++)
        {
            SObject sfsObjectLine = solList[solCnt];
            SBQQ__QuoteLine__c quoteLine = (SBQQ__QuoteLine__c) sfsObjectLine;
            if (String.isEmpty(quoteLine.SBQQ__DynamicOptionId__c) || withFeatures)
            {
                ENSX_QuoteLine qteLine = new ENSX_QuoteLine ();
                qteLine.ListPrice = quoteLine.SBQQ__ListPrice__c;
                qteLine.CostPrice = quoteLine.SBQQ__UnitCost__c;
                qteLine.NetPrice = 0.0;
                qteLine.DiscountPercent = 0.0;
                qteLine.IsProductFeature = String.isNotEmpty(quoteLine.SBQQ__DynamicOptionId__c);
                if (qteLine.IsProductFeature)
                {
                    qteLine.ParentLineItem = parentLineItem;
                    qteLine.Quantity = quoteLine.SBQQ__BundledQuantity__c;
                }
                else 
                {
                    parentLineItem = quoteLine.SBQQ__Number__c.intValue();
                    qteLine.Quantity = quoteLine.SBQQ__Quantity__c;
                }
                qteLine.LineItem = quoteLine.SBQQ__Number__c.intValue();
                qteLine.Product = quoteLine.SBQQ__Product__c;
                qteLine.PricebookEntry = quoteLine.SBQQ__PricebookEntryId__c;
                qteLine.SAPMaterialNumber = getMaterial(sfsObject, sfsObjectLine);
                qteLine.itemJSON = quoteLine.SAP_Configuration__c;
                qteLine.ItemNumber = quoteLine.FLD_SAP_Item_Number__c;
                qte.LinkedQuoteLines.add(qteLine);
            }
        }
        return qte;
    }

    public void initializeQuoteFromSfSObject(
        String calledFrom, 
        SObject sfSObject, 
        SBO_EnosixQuote_Detail.EnosixQuote quoteDetail, 
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap,
        Map<String, UTIL_Quote.QuoteLineValue> quoteLineValueMap,
        Integer itemIncrement)
    {
		SBQQ__Quote__c cpqQuote = (SBQQ__Quote__c) sfSObject;

        quoteDetail.SALES.SalesDocumentType = String.isNotEmpty(cpqQuote.FLD_Document_Type__c) ? cpqQuote.FLD_Document_Type__c : defaultSalesDocType;
        quoteDetail.SALES.SalesOrganization = String.isNotEmpty(cpqQuote.FLD_Sales_Organization__c) ? cpqQuote.FLD_Sales_Organization__c : defaultSalesOrg;
        quoteDetail.SALES.DistributionChannel = String.isNotEmpty(cpqQuote.FLD_Distribution_Channel__c) ? cpqQuote.FLD_Distribution_Channel__c : defaultDistributionChannel;
        quoteDetail.SALES.Division = String.isNotEmpty(cpqQuote.FLD_Division__c) ? cpqQuote.FLD_Division__c : defaultDivision;

        String soldToParty = cpqQuote.FLD_Sold_To_Number__c;
        if (String.isNotEmpty(soldToParty))
        {
            quoteDetail.SoldToParty = soldToParty;
            SBO_EnosixQuote_Detail.PARTNERS soldToPartner = UTIL_Quote.getPartnerFromQuote(quoteDetail, UTIL_Customer.SOLD_TO_PARTNER_CODE, true);
		    soldToPartner.CustomerNumber = soldToParty;
        }

        String shipToParty = cpqQuote.FLD_Ship_To_Number__c;
        if (String.isEmpty(shipToParty)) shipToParty = soldToParty;
        if (String.isNotEmpty(shipToParty))
        {
            quoteDetail.SHIPPING.ShipToParty = shipToParty;
            SBO_EnosixQuote_Detail.PARTNERS shipToPartner = UTIL_Quote.getPartnerFromQuote(quoteDetail, UTIL_Customer.SHIP_TO_PARTNER_CODE, true);
            shipToPartner.CustomerNumber = shipToParty;
        }

        String billToParty = cpqQuote.FLD_Bill_To_Number__c;
        if (String.isNotEmpty(billToParty))
        {
            SBO_EnosixQuote_Detail.PARTNERS billToPartner = UTIL_Quote.getPartnerFromQuote(quoteDetail, UTIL_Customer.BILL_TO_PARTNER_CODE, true);
            billToPartner.CustomerNumber = billToParty;
        }

        String payerParty = cpqQuote.FLD_Payer_Number__c;
        if (String.isNotEmpty(payerParty))
        {
            SBO_EnosixQuote_Detail.PARTNERS payerPartner = UTIL_Quote.getPartnerFromQuote(quoteDetail, UTIL_Customer.PAYER_PARTNER_CODE, true);
            payerPartner.CustomerNumber = payerParty;
        }

        List<SObject> solList = getSObjectLineItems(sfsObject.Id).values();
        Integer solTot = solList.size();
        for (Integer solCnt = 0 ; solCnt < solTot ; solCnt++)
        {
            SObject sfsObjectLine = solList[solCnt];
            SBQQ__QuoteLine__c quoteLine = (SBQQ__QuoteLine__c) sfsObjectLine;
            if (String.isEmpty(quoteLine.SBQQ__DynamicOptionId__c))
            {
                string materialNumber = getMaterial(sfSObject, sfsObjectLine);
                ENSX_ItemConfiguration itemConfig = null;
                if (String.isNotEmpty(quoteLine.SAP_Configuration__c))
                {
                    itemConfig = (ENSX_ItemConfiguration) JSON.deserialize(quoteLine.SAP_Configuration__c,ENSX_ItemConfiguration.class);
                }
                SBO_EnosixQuote_Detail.ITEMS quoteItem = translateLineItemToQuoteItem(quoteLine, materialNumber, itemConfig);
                if (quoteItem != null)
                {
                    UTIL_Quote.addItemToQuote(quoteDetail, quoteItem, itemIncrement);
                    addItemsConfig(quoteDetail, quoteItem, quoteLine, itemConfig);
                    UTIL_Quote.QuoteLineValue quoteLineValue = new UTIL_Quote.QuoteLineValue();
                    addItemsConditions(quoteDetail, quoteItem, quoteLine, quoteLineValue);
                    quoteLineValueMap.put(quoteItem.ItemNumber.replaceFirst('^0+(?!$)', ''), quoteLineValue);
                    sfSObjectLineIdMap.put(quoteItem.ItemNumber.replaceFirst('^0+(?!$)', ''), new UTIL_SFSObjectDoc.SfSObjectItem(sfsObjectLine.Id));
                }
            }
        }
    }

    @testVisible
    private SBO_EnosixQuote_Detail.ITEMS translateLineItemToQuoteItem(SBQQ__QuoteLine__c quoteLine, string materialNumber, ENSX_ItemConfiguration itemConfig)
    {
        SBO_EnosixQuote_Detail.ITEMS item = null;
        if (String.isNotBlank(materialNumber))
        {
            item = new SBO_EnosixQuote_Detail.ITEMS();
            item.Material = materialNumber;
            item.ItemDescription = quoteLine.SBQQ__Description__c;
            item.OrderQuantity = quoteLine.SBQQ__Quantity__c;
            if (itemConfig != null)
            {
                item.OrderQuantity = itemConfig.OrderQuantity;
    			item.Plant = itemConfig.plant;
            }
            item.NetItemPrice = quoteLine.SBQQ__ListPrice__c;
        }
        return item;
    }

    @testVisible
    private void addItemsConfig(SBO_EnosixQuote_Detail.EnosixQuote quoteDetail, SBO_EnosixQuote_Detail.ITEMS quoteItem, SBQQ__QuoteLine__c quoteLine, ENSX_ItemConfiguration itemConfig)
    {
        if (itemConfig != null && itemConfig.selectedCharacteristics != null && itemConfig.selectedCharacteristics.size() > 0)
        {
            Integer charTot = itemConfig.selectedCharacteristics.size();
            for (Integer charCnt = 0 ; charCnt < charTot ; charCnt++)
            {
                ENSX_Characteristic characteristic = itemConfig.selectedCharacteristics[charCnt];
                if (characteristic.UserModified != null && characteristic.UserModified && String.isNotEmpty(characteristic.CharacteristicID))
                {
                    SBO_EnosixQuote_Detail.ITEMS_CONFIG itemsConfig = new SBO_EnosixQuote_Detail.ITEMS_CONFIG();
                    itemsConfig.ItemNumber = quoteItem.ItemNumber;
                    itemsConfig.CharacteristicID = characteristic.CharacteristicID;
                    itemsConfig.CharacteristicName = characteristic.CharacteristicName;
                    itemsConfig.CharacteristicValue = characteristic.CharacteristicValue;
                    quoteDetail.ITEMS_CONFIG.add(itemsConfig);
                }
            }
        }
    }

    @testVisible
    private void addItemsConditions(
        SBO_EnosixQuote_Detail.EnosixQuote quoteDetail, 
        SBO_EnosixQuote_Detail.ITEMS quoteItem, 
        SBQQ__QuoteLine__c quoteLine,
        UTIL_Quote.QuoteLineValue quoteLineValue)
    {
        String ItemNumber = quoteItem.ItemNumber.replaceFirst('^0+(?!$)', '');
        addCondition(quoteDetail, ItemNumber, quoteLine, true, null, null);
    }

    public String discountPercentConditionType = '';
    public String discountValueConditionType = '';

    public Boolean updateQuotePricingFromSfsObject(
        String calledFrom, 
        SObject sfSObject, 
        SBO_EnosixQuote_Detail.EnosixQuote quoteDetail, 
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap)
    {
        Map<String, List<SObject>> childMap = new Map<String, List<SObject>>();
        Map<Id, SObject> lineMap = getSObjectLineItems(sfsObject.Id);
        String Id;
        List<SObject> lineList = lineMap.values();
        Integer lineTot = lineList.size();
        for (Integer lineCnt = 0 ; lineCnt < lineTot ; lineCnt++)
        {
            SObject line = lineList[lineCnt];
            String dynamicOptionId = (String) line.get('SBQQ__DynamicOptionId__c');
            if (String.isEmpty(dynamicOptionId))
            {
                id = line.Id;
            }
            else
            {
                List<SObject> childList = new List<SObject>();
                if (childMap.containsKey(id)) childList = childMap.get(id);
                childList.add(line);
                childMap.put(id, childList);
            }
        }

        Map<String, SBO_EnosixQuote_Detail.CONDITIONS> conditionMapPercent = new Map<String, SBO_EnosixQuote_Detail.CONDITIONS>();
        Map<String, SBO_EnosixQuote_Detail.CONDITIONS> conditionMapValue = new Map<String, SBO_EnosixQuote_Detail.CONDITIONS>();
        List<SBO_EnosixQuote_Detail.CONDITIONS> condList = quoteDetail.CONDITIONS.getAsList();
        Integer condTot = condList.size();
        for (Integer condCnt = 0 ; condCnt < condTot ; condCnt++)
        {
            SBO_EnosixQuote_Detail.CONDITIONS condition = condList[condCnt];
            if (String.isNotEmpty(condition.ConditionItemNumber))
            {
                if (condition.ConditionType == discountPercentConditionType && String.isNotEmpty(discountPercentConditionType))
                {
                    conditionMapPercent.put(condition.ConditionItemNumber.replaceFirst('^0+(?!$)', ''), condition);
                }
                if (condition.ConditionType == discountValueConditionType && String.isNotEmpty(discountValueConditionType))
                {
                    conditionMapValue.put(condition.ConditionItemNumber.replaceFirst('^0+(?!$)', ''), condition);
                }
            }
        }

        Boolean isChanged = false;
        Map<String, SBO_EnosixQuote_Detail.ITEMS> itemNumberMap = new Map<String, SBO_EnosixQuote_Detail.ITEMS>();
        List<SBO_EnosixQuote_Detail.ITEMS> itemList = quoteDetail.ITEMS.getAsList();
        Integer itemTot = itemList.size();
        for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
        {
            SBO_EnosixQuote_Detail.ITEMS quoteItem = itemList[itemCnt];
            String ItemNumber = quoteItem.ItemNumber.replaceFirst('^0+(?!$)', '');
            itemNumberMap.put (ItemNumber, quoteItem);
            String HigherItemNumber = ItemNumber;
            if (quoteItem.HigherLevelItemNumber != null && quoteItem.HigherLevelItemNumber != '000000')
            {
                HigherItemNumber = quoteItem.HigherLevelItemNumber.replaceFirst('^0+(?!$)', '');
                while (itemNumberMap.containsKey(HigherItemNumber) && 
                    itemNumberMap.get(HigherItemNumber).HigherLevelItemNumber != null &&
                    itemNumberMap.get(HigherItemNumber).HigherLevelItemNumber != '000000')
                {
                    HigherItemNumber = itemNumberMap.get(HigherItemNumber).HigherLevelItemNumber.replaceFirst('^0+(?!$)', '');
                }
            }
            UTIL_SFSObjectDoc.SfSObjectItem sfsObjectLineId = sfSObjectLineIdMap.get(HigherItemNumber);
            if (sfsObjectLineId != null) 
            {
                id = sfsObjectLineId.id;
                if (String.isNotEmpty(id) && childMap.containsKey(id))
                {
                    List<SObject> childList = childMap.get(id);
                    Integer childTot = childList.size();
                    for (Integer childCnt = 0 ; childCnt <childTot ; childCnt++)
                    {
                        SBQQ__QuoteLine__c quoteLine = (SBQQ__QuoteLine__c) childList[childCnt];
                        String qlItemNumber = quoteLine.FLD_SAP_Item_Number__c;
                        if (String.isNotEmpty(qlItemNumber)) qlItemNumber = qlItemNumber.replaceFirst('^0+(?!$)', '');
                        if (quoteItem.ItemNumber.replaceFirst('^0+(?!$)', '') == qlItemNumber)
                        {
                            isChanged = addCondition(quoteDetail, ItemNumber, quoteLine, isChanged, conditionMapPercent, conditionMapValue);
                            List<String> keyList = new List<String>(sfSObjectLineIdMap.keySet());
                            Integer keyTot = keyList.size();
                            for (Integer keyCnt = 0 ; keyCnt < keyTot ; keyCnt++)
                            {
                                String key = keyList[keyCnt];
                                UTIL_SFSObjectDoc.SfSObjectItem sfSObjectItem = sfSObjectLineIdMap.get(key);
                                if (quoteLine.Id == sfSObjectItem.id)
                                {
                                    sfSObjectLineIdMap.remove(key);
                                    break;
                                }
                            }
                            sfSObjectLineIdMap.put(quoteItem.ItemNumber.replaceFirst('^0+(?!$)', ''), new UTIL_SFSObjectDoc.SfSObjectItem(quoteLine.Id));
                            childList.remove(childCnt);
                            childMap.put(id, childList);
                            break;
                        }
                    }
                }
            }
        }
        return isChanged;
    }

    @testVisible
    private Boolean addCondition(
        SBO_EnosixQuote_Detail.EnosixQuote quoteDetail,
        String ItemNumber,
        SBQQ__QuoteLine__c quoteLine,
        Boolean isChanged,
        Map<String, SBO_EnosixQuote_Detail.CONDITIONS> conditionMapPercent,
        Map<String, SBO_EnosixQuote_Detail.CONDITIONS> conditionMapValue)
    {
        if (quoteLine.SBQQ__Discount__c != null && quoteLine.SBQQ__Discount__c != 0 && String.isNotEmpty(discountPercentConditionType))
        {
            SBO_EnosixQuote_Detail.CONDITIONS condition;
            if (conditionMapPercent != null && conditionMapPercent.containsKey(ItemNumber))
            {
                condition = conditionMapPercent.get(ItemNumber);
            }
            else
            {
                condition = new SBO_EnosixQuote_Detail.CONDITIONS();
                condition.ConditionItemNumber = ItemNumber;
                condition.ConditionType = discountPercentConditionType;
                condition.CurrencyKey = quoteDetail.Sales.SalesDocumentCurrency;
                quoteDetail.CONDITIONS.add(condition);
            }
            condition.ConditionControl = 'C';
            condition.Rate = quoteLine.SBQQ__Discount__c * -1;
            isChanged = true;
        } 
        else if (quoteLine.SBQQ__AdditionalDiscount__c != null && quoteLine.SBQQ__AdditionalDiscount__c != 0 && String.isNotEmpty(discountValueConditionType))
        {
            SBO_EnosixQuote_Detail.CONDITIONS condition;
            if (conditionMapValue != null && conditionMapValue.containsKey(ItemNumber))
            {
                condition = conditionMapValue.get(ItemNumber);
            }
            else
            {
                condition = new SBO_EnosixQuote_Detail.CONDITIONS();
                condition.ConditionItemNumber = ItemNumber;
                condition.ConditionType = discountValueConditionType;
                condition.CurrencyKey = quoteDetail.Sales.SalesDocumentCurrency;
                quoteDetail.CONDITIONS.add(condition);
            }
            condition.ConditionControl = 'C';
            condition.Rate = quoteLine.SBQQ__AdditionalDiscount__c * -1;
            isChanged = true;
        }
        return isChanged;
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
        SBQQ__Quote__c cpqQuote = (SBQQ__Quote__c) sfSObject;

        cpqQuote.FLD_SAP_Quote_Number__c = quoteDetail.SalesDocument;

        upsert cpqQuote;

        // Add quote lines
        if (UTIL_Quote.isAddMaterial || UTIL_Quote.isEditMaterial || UTIL_Quote.isCloneMaterial || UTIL_Quote.isMoveMaterial)
        {
            upsertLineItemsFromQuoteItems(cpqQuote, quoteItems, materialToProductIdMap, productToPricebookEntryMap, sfSObjectLineIdMap);
        }
    }

    // upsertLineItemsFromQuoteItems()
    //
    // Map the given quote items to new quote lines and insert them into the db
    @testVisible
    private void upsertLineItemsFromQuoteItems(
        SBQQ__Quote__c quote,
        List<SBO_EnosixQuote_Detail.ITEMS> quoteItems,
        Map<string, Id> materialToProductIdMap,
        Map<Id, PricebookEntry> productToPricebookEntryMap,
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap)
    {
        List<SBQQ__QuoteLine__c> lineItems = new List<SBQQ__QuoteLine__c>();
        Map<Id, SObject> quoteLineItems = getSObjectLineItems(quote.Id);

        Integer itemTot = quoteItems.size();
        for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
        {
            SBO_EnosixQuote_Detail.ITEMS item = quoteItems[itemCnt];
            if (item.HigherLevelItemNumber == null || String.isEmpty(item.HigherLevelItemNumber.replace('0',''.trim())))
            {
                Id productId = materialToProductIdMap.get(item.Material);
                PricebookEntry price = productToPricebookEntryMap.get(productId);

                SBQQ__QuoteLine__c qli = new SBQQ__QuoteLine__c();
                if (sfSObjectLineIdMap.containsKey(item.ItemNumber.replaceFirst('^0+(?!$)', '')) 
                    && !sfSObjectLineIdMap.get(item.ItemNumber.replaceFirst('^0+(?!$)', '')).isDeleted)
                {
                    qli.id = sfSObjectLineIdMap.get(item.ItemNumber.replaceFirst('^0+(?!$)', '')).id;
                    if (quoteLineItems.containsKey(qli.id))
                    {
                        SBQQ__QuoteLine__c quoteLine = (SBQQ__QuoteLine__c) quoteLineItems.get(qli.id);
                        ENSX_ItemConfiguration itemConfig = new ENSX_ItemConfiguration();
                        if (String.isNotEmpty(quoteLine.SAP_Configuration__c))
                        {
                            itemConfig = (ENSX_ItemConfiguration) JSON.deserialize(quoteLine.SAP_Configuration__c,ENSX_ItemConfiguration.class);
                        }
                        itemConfig.OrderQuantity = item.OrderQuantity;
                        itemConfig.plant = item.Plant;
                        qli.SAP_Configuration__c = JSON.serialize(itemConfig);
                    }
                    System.debug('Updating Quote Line Item');
                }
                else 
                {
                    qli.SBQQ__Quote__c = quote.Id;
                    qli.SBQQ__PricebookEntryId__c = price != null ? price.Id : null;
                    qli.SBQQ__Product__c = productId;
                    System.debug('Adding Quote Line Item');
                }
                qli.SBQQ__Description__c = item.ItemDescription;
                qli.SBQQ__Quantity__c = item.OrderQuantity;
                qli.SBQQ__NetPrice__c = item.NetItemPrice;
                qli.FLD_SAP_Item_Number__c = item.ItemNumber;            

                System.debug(qli);

                lineItems.add(qli);
            }
        }

        upsert lineItems;
    }

    public void initializeOrderFromSfSObject(
        String calledFrom, 
        SObject sfSObject, 
        SBO_EnosixSO_Detail.EnosixSO orderDetail, 
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap,
        Map<String, UTIL_Order.OrderLineValue> orderLineValueMap,
        Integer itemIncrement)
    {
		SBQQ__Quote__c cpqQuote = (SBQQ__Quote__c) sfSObject;

        orderDetail.SALES.SalesDocumentType = String.isNotEmpty(cpqQuote.FLD_Document_Type__c) ? cpqQuote.FLD_Document_Type__c : defaultSalesDocType;
        orderDetail.SALES.SalesOrganization = String.isNotEmpty(cpqQuote.FLD_Sales_Organization__c) ? cpqQuote.FLD_Sales_Organization__c : defaultSalesOrg;
        orderDetail.SALES.DistributionChannel = String.isNotEmpty(cpqQuote.FLD_Distribution_Channel__c) ? cpqQuote.FLD_Distribution_Channel__c : defaultDistributionChannel;
        orderDetail.SALES.Division = String.isNotEmpty(cpqQuote.FLD_Division__c) ? cpqQuote.FLD_Division__c : defaultDivision;
        
        String soldToParty = cpqQuote.FLD_Sold_To_Number__c;
        if (String.isNotEmpty(soldToParty))
        {
            orderDetail.SoldToParty = soldToParty;
            SBO_EnosixSO_Detail.PARTNERS soldToPartner = UTIL_Order.getPartnerFromOrder(orderDetail, UTIL_Customer.SOLD_TO_PARTNER_CODE, true);
		    soldToPartner.CustomerNumber = soldToParty;
        }

        String shipToParty = cpqQuote.FLD_Ship_To_Number__c;
        if (String.isEmpty(shipToParty)) shipToParty = soldToParty;
        if (String.isNotEmpty(shipToParty))
        {
            orderDetail.SHIPPING.ShipToParty = shipToParty;
            SBO_EnosixSO_Detail.PARTNERS shipToPartner = UTIL_Order.getPartnerFromOrder(orderDetail, UTIL_Customer.SHIP_TO_PARTNER_CODE, true);
            shipToPartner.CustomerNumber = shipToParty;
        }

        String billToParty = cpqQuote.FLD_Bill_To_Number__c;
        if (String.isNotEmpty(billToParty))
        {
            SBO_EnosixSO_Detail.PARTNERS billToPartner = UTIL_Order.getPartnerFromOrder(orderDetail, UTIL_Customer.BILL_TO_PARTNER_CODE, true);
            billToPartner.CustomerNumber = billToParty;
        }

        String payerParty = cpqQuote.FLD_Payer_Number__c;
        if (String.isNotEmpty(payerParty))
        {
            SBO_EnosixSO_Detail.PARTNERS payerPartner = UTIL_Order.getPartnerFromOrder(orderDetail, UTIL_Customer.PAYER_PARTNER_CODE, true);
            payerPartner.CustomerNumber = payerParty;
        }

        List<SObject> solList = getSObjectLineItems(sfsObject.Id).values();
        Integer solTot = solList.size();
        for (Integer solCnt = 0 ; solCnt < solTot ; solCnt++)
        {
            SObject sfsObjectLine = solList[solCnt];
            SBQQ__QuoteLine__c quoteLine = (SBQQ__QuoteLine__c) sfsObjectLine;
            if (String.isEmpty(quoteLine.SBQQ__DynamicOptionId__c))
            {
                string materialNumber = getMaterial(sfSObject, sfsObjectLine);
                ENSX_ItemConfiguration itemConfig = null;
                if (String.isNotEmpty(quoteLine.SAP_Configuration__c))
                {
                    itemConfig = (ENSX_ItemConfiguration) JSON.deserialize(quoteLine.SAP_Configuration__c,ENSX_ItemConfiguration.class);
                }
                SBO_EnosixSO_Detail.ITEMS orderItem = translateLineItemToOrderItem(quoteLine, materialNumber, itemConfig);
                if (orderItem != null)
                {
                    UTIL_Order.addItemToOrder(orderDetail, orderItem, itemIncrement);
                    addItemsConfig(orderDetail, orderItem, quoteLine, itemConfig);
                    UTIL_Order.OrderLineValue orderLineValue = new UTIL_Order.OrderLineValue();
                    addItemsConditions(orderDetail, orderItem, quoteLine, orderLineValue);
                    orderLineValueMap.put(orderItem.ItemNumber.replaceFirst('^0+(?!$)', ''), orderLineValue);
                    sfSObjectLineIdMap.put(orderItem.ItemNumber.replaceFirst('^0+(?!$)', ''), new UTIL_SFSObjectDoc.SfSObjectItem(sfsObjectLine.Id));
                }
            }
        }
    }

    @testVisible
    private SBO_EnosixSO_Detail.ITEMS translateLineItemToOrderItem(SBQQ__QuoteLine__c quoteLine, string materialNumber, ENSX_ItemConfiguration itemConfig)
    {
        SBO_EnosixSO_Detail.ITEMS item = null;
        if (String.isNotBlank(materialNumber))
        {
            item = new SBO_EnosixSO_Detail.ITEMS();
            item.Material = materialNumber;
            item.ItemDescription = quoteLine.SBQQ__Description__c;
            item.OrderQuantity = quoteLine.SBQQ__Quantity__c;
            if (itemConfig != null)
            {
                item.OrderQuantity = itemConfig.OrderQuantity;
    			item.Plant = itemConfig.plant;
            }
            item.NetItemPrice = quoteLine.SBQQ__ListPrice__c;
        }
        return item;
    }

    @testVisible
    private void addItemsConfig(SBO_EnosixSO_Detail.EnosixSO orderDetail, SBO_EnosixSO_Detail.ITEMS orderItem, SBQQ__QuoteLine__c quoteLine, ENSX_ItemConfiguration itemConfig)
    {
        if (itemConfig != null && itemConfig.selectedCharacteristics != null && itemConfig.selectedCharacteristics.size() > 0)
        {
            Integer charTot = itemConfig.selectedCharacteristics.size();
            for (Integer charCnt = 0 ; charCnt < charTot ; charCnt++)
            {
                ENSX_Characteristic characteristic = itemConfig.selectedCharacteristics[charCnt];
                if (characteristic.UserModified != null && characteristic.UserModified && String.isNotEmpty(characteristic.CharacteristicID))
                {
                    SBO_EnosixSO_Detail.ITEMS_CONFIG itemsConfig = new SBO_EnosixSO_Detail.ITEMS_CONFIG();
                    itemsConfig.ItemNumber = orderItem.ItemNumber;
                    itemsConfig.CharacteristicID = characteristic.CharacteristicID;
                    itemsConfig.CharacteristicName = characteristic.CharacteristicName;
                    itemsConfig.CharacteristicValue = characteristic.CharacteristicValue;
                    orderDetail.ITEMS_CONFIG.add(itemsConfig);
                }
            }
        }
    }

    @testVisible
    private void addItemsConditions(SBO_EnosixSO_Detail.EnosixSO orderDetail, SBO_EnosixSO_Detail.ITEMS orderItem, SBQQ__QuoteLine__c quoteLine,
        UTIL_Order.OrderLineValue orderLineValue)
    {
        String ItemNumber = orderItem.ItemNumber.replaceFirst('^0+(?!$)', '');
        addCondition(orderDetail, ItemNumber, quoteLine, true, null, null);
    }

    public Boolean updateOrderPricingFromSfsObject(
        String calledFrom, 
        SObject sfSObject, 
        SBO_EnosixSO_Detail.EnosixSO orderDetail, 
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap)
    {
        Map<String, List<SObject>> childMap = new Map<String, List<SObject>>();
        Map<Id, SObject> lineMap = getSObjectLineItems(sfsObject.Id);
        String Id;
        List<SObject> lineList = lineMap.values();
        Integer lineTot = lineList.size();
        for (Integer lineCnt = 0 ; lineCnt < lineTot ; lineCnt++)
        {
            SObject line = lineList[lineCnt];
            String dynamicOptionId = (String) line.get('SBQQ__DynamicOptionId__c');
            if (String.isEmpty(dynamicOptionId))
            {
                id = line.Id;
            }
            else
            {
                List<SObject> childList = new List<SObject>();
                if (childMap.containsKey(id)) childList = childMap.get(id);
                childList.add(line);
                childMap.put(id, childList);
            }
        }

        Map<String, SBO_EnosixSO_Detail.CONDITIONS> conditionMapPercent = new Map<String, SBO_EnosixSO_Detail.CONDITIONS>();
        Map<String, SBO_EnosixSO_Detail.CONDITIONS> conditionMapValue = new Map<String, SBO_EnosixSO_Detail.CONDITIONS>();
        List<SBO_EnosixSO_Detail.CONDITIONS> condList = orderDetail.CONDITIONS.getAsList();
        Integer condTot = condList.size();
        for (Integer condCnt = 0 ; condCnt < condTot ; condCnt++)
        {
            SBO_EnosixSO_Detail.CONDITIONS condition = condList[condCnt];
            if (String.isNotEmpty(condition.ConditionItemNumber))
            {
                if (condition.ConditionType == discountPercentConditionType && String.isNotEmpty(discountPercentConditionType))
                {
                    conditionMapPercent.put(condition.ConditionItemNumber.replaceFirst('^0+(?!$)', ''), condition);
                }
                if (condition.ConditionType == discountValueConditionType && String.isNotEmpty(discountValueConditionType))
                {
                    conditionMapValue.put(condition.ConditionItemNumber.replaceFirst('^0+(?!$)', ''), condition);
                }
            }
        }

        Boolean isChanged = false;
        Map<String, SBO_EnosixSO_Detail.ITEMS> itemNumberMap = new Map<String, SBO_EnosixSO_Detail.ITEMS>();
        List<SBO_EnosixSO_Detail.ITEMS> itemList = orderDetail.ITEMS.getAsList();
        Integer itemTot = itemList.size();
        for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
        {
            SBO_EnosixSO_Detail.ITEMS orderItem = itemList[itemCnt];
            String ItemNumber = orderItem.ItemNumber.replaceFirst('^0+(?!$)', '');
            itemNumberMap.put (ItemNumber, orderItem);
            String HigherItemNumber = ItemNumber;
            if (orderItem.HigherLevelItemNumber != null && orderItem.HigherLevelItemNumber != '000000')
            {
                HigherItemNumber = orderItem.HigherLevelItemNumber.replaceFirst('^0+(?!$)', '');
                while (itemNumberMap.containsKey(HigherItemNumber) && 
                    itemNumberMap.get(HigherItemNumber).HigherLevelItemNumber != null &&
                    itemNumberMap.get(HigherItemNumber).HigherLevelItemNumber != '000000')
                {
                    HigherItemNumber = itemNumberMap.get(HigherItemNumber).HigherLevelItemNumber.replaceFirst('^0+(?!$)', '');
                }
            }
            UTIL_SFSObjectDoc.SfSObjectItem sfsObjectLineId = sfSObjectLineIdMap.get(HigherItemNumber);
            if (sfsObjectLineId != null) 
            {
                id = sfsObjectLineId.id;
                if (String.isNotEmpty(id) && childMap.containsKey(id))
                {
                    List<SObject> childList = childMap.get(id);
                    Integer childTot = childList.size();
                    for (Integer childCnt = 0 ; childCnt < childTot ; childCnt++)
                    {
                        SBQQ__QuoteLine__c quoteLine = (SBQQ__QuoteLine__c) childList[childCnt];
                        String qlItemNumber = quoteLine.FLD_SAP_Item_Number__c;
                        if (String.isNotEmpty(qlItemNumber)) qlItemNumber = qlItemNumber.replaceFirst('^0+(?!$)', '');
                        if (orderItem.ItemNumber.replaceFirst('^0+(?!$)', '') == qlItemNumber)
                        {
                            isChanged = addCondition(orderDetail, ItemNumber, quoteLine, isChanged, conditionMapPercent, conditionMapValue);
                            List<String> keyList = new List<String>(sfSObjectLineIdMap.keySet());
                            Integer keyTot = keyList.size();
                            for (Integer keyCnt = 0 ; keyCnt < keyTot ; keyCnt++)
                            {
                                String key = keyList[keyCnt];
                                UTIL_SFSObjectDoc.SfSObjectItem sfSObjectItem = sfSObjectLineIdMap.get(key);
                                if (quoteLine.Id == sfSObjectItem.id)
                                {
                                    sfSObjectLineIdMap.remove(key);
                                    break;
                                }
                            }
                            sfSObjectLineIdMap.put(orderItem.ItemNumber.replaceFirst('^0+(?!$)', ''), new UTIL_SFSObjectDoc.SfSObjectItem(quoteLine.Id));
                            childList.remove(childCnt);
                            childMap.put(id, childList);
                            break;
                        }
                    }
                }
            }
        }
        return isChanged;
    }

    @testVisible
    private Boolean addCondition(
        SBO_EnosixSO_Detail.EnosixSO orderDetail,
        String ItemNumber,
        SBQQ__QuoteLine__c quoteLine,
        Boolean isChanged,
        Map<String, SBO_EnosixSO_Detail.CONDITIONS> conditionMapPercent,
        Map<String, SBO_EnosixSO_Detail.CONDITIONS> conditionMapValue)
    {
        if (quoteLine.SBQQ__Discount__c != null && quoteLine.SBQQ__Discount__c != 0 && String.isNotEmpty(discountPercentConditionType))
        {
            SBO_EnosixSO_Detail.CONDITIONS condition;
            if (conditionMapPercent != null && conditionMapPercent.containsKey(ItemNumber))
            {
                condition = conditionMapPercent.get(ItemNumber);
            }
            else
            {
                condition = new SBO_EnosixSO_Detail.CONDITIONS();
                condition.ConditionItemNumber = ItemNumber;
                condition.ConditionType = discountPercentConditionType;
                condition.CurrencyKey = orderDetail.Sales.SalesDocumentCurrency;
                orderDetail.CONDITIONS.add(condition);
            }
            condition.ConditionControl = 'C';
            condition.Rate = quoteLine.SBQQ__Discount__c * -1;
            isChanged = true;
        } 
        else if (quoteLine.SBQQ__AdditionalDiscount__c != null && quoteLine.SBQQ__AdditionalDiscount__c != 0 && String.isNotEmpty(discountValueConditionType))
        {
            SBO_EnosixSO_Detail.CONDITIONS condition;
            if (conditionMapValue != null && conditionMapValue.containsKey(ItemNumber))
            {
                condition = conditionMapValue.get(ItemNumber);
            }
            else
            {
                condition = new SBO_EnosixSO_Detail.CONDITIONS();
                condition.ConditionItemNumber = ItemNumber;
                condition.ConditionType = discountValueConditionType;
                condition.CurrencyKey = orderDetail.Sales.SalesDocumentCurrency;
                orderDetail.CONDITIONS.add(condition);
            }
            condition.ConditionControl = 'C';
            condition.Rate = quoteLine.SBQQ__AdditionalDiscount__c * -1;
            isChanged = true;
        }
        return isChanged;
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
        SBQQ__Quote__c cpqQuote = (SBQQ__Quote__c) sfSObject;

        cpqQuote.FLD_SAP_Order_Number__c = orderDetail.SalesDocument;

        upsert cpqQuote;

        // Add quote lines
        if (UTIL_Order.isAddMaterial || UTIL_Order.isEditMaterial || UTIL_Order.isCloneMaterial || UTIL_Order.isMoveMaterial)
        {
            upsertLineItemsFromOrderItems(cpqQuote, orderItems, materialToProductIdMap, productToPricebookEntryMap, sfSObjectLineIdMap);
        }
    }

    // upsertLineItemsFromOrderItems()
    //
    // Map the given order items to new quote lines and insert them into the db
    @testVisible
    private void upsertLineItemsFromOrderItems(
        SBQQ__Quote__c quote,
        List<SBO_EnosixSO_Detail.ITEMS> orderItems,
        Map<string, Id> materialToProductIdMap,
        Map<Id, PricebookEntry> productToPricebookEntryMap,
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap)
    {
        List<SBQQ__QuoteLine__c> lineItems = new List<SBQQ__QuoteLine__c>();
        Map<Id, SObject> quoteLineItems = getSObjectLineItems(quote.Id);

        Integer itemTot = orderItems.size();
        for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
        {
            SBO_EnosixSO_Detail.ITEMS item = orderItems[itemCnt];
            Id productId = materialToProductIdMap.get(item.Material);
            PricebookEntry price = productToPricebookEntryMap.get(productId);

            SBQQ__QuoteLine__c qli = null;

            if (sfSObjectLineIdMap.containsKey(item.ItemNumber.replaceFirst('^0+(?!$)', '')) 
                && !sfSObjectLineIdMap.get(item.ItemNumber.replaceFirst('^0+(?!$)', '')).isDeleted)
            {
                qli = new SBQQ__QuoteLine__c();
                qli.id = sfSObjectLineIdMap.get(item.ItemNumber.replaceFirst('^0+(?!$)', '')).id;
                if (quoteLineItems.containsKey(qli.id))
                {
                    SBQQ__QuoteLine__c quoteLine = (SBQQ__QuoteLine__c) quoteLineItems.get(qli.id);
                    ENSX_ItemConfiguration itemConfig = new ENSX_ItemConfiguration();
                    if (String.isNotEmpty(quoteLine.SAP_Configuration__c))
                    {
                        itemConfig = (ENSX_ItemConfiguration) JSON.deserialize(quoteLine.SAP_Configuration__c,ENSX_ItemConfiguration.class);
                    }
                    itemConfig.OrderQuantity = item.OrderQuantity;
                    itemConfig.plant = item.Plant;
                    qli.SAP_Configuration__c = JSON.serialize(itemConfig);
                }
                System.debug('Updating Quote Line Item');
            }
            else if (item.HigherLevelItemNumber == null || String.isEmpty(item.HigherLevelItemNumber.replace('0',''.trim())))
            {
                qli = new SBQQ__QuoteLine__c();
                qli.SBQQ__Quote__c = quote.Id;
                qli.SBQQ__PricebookEntryId__c = price.Id;
                qli.SBQQ__Product__c = productId;
                System.debug('Adding Quote Line Item');
            }
            if (qli != null)
            {
                qli.SBQQ__Description__c = item.ItemDescription;
                qli.SBQQ__Quantity__c = item.OrderQuantity;
                qli.SBQQ__NetPrice__c = item.NetItemPrice;
                qli.FLD_SAP_Item_Number__c = item.ItemNumber;            

                System.debug(qli);

                lineItems.add(qli);
            }
        }

        upsert lineItems;
    }

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
                    salesDocItem.Material = quoteLine.SBQQ__ProductCode__c;
                    salesDocItem.ItemDescription = quoteLine.SBQQ__Description__c;
                    salesDocItem.NetItemPrice = quoteLine.SBQQ__ListPrice__c;
                    salesDocItem.OrderQuantity = quoteLine.SBQQ__Quantity__c;
                    salesDocItem.ConfigurableMaterial = quoteLine.SBQQ__Product__r.SBQQ__ExternallyConfigurable__c;

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
                quote.FLD_SAP_Quote_Number__c = salesDocDetail.SalesDocument;
            }
            else if (sapDocType == 'Order') {
                quote.FLD_SAP_Order_Number__c = salesDocDetail.SalesDocument;
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