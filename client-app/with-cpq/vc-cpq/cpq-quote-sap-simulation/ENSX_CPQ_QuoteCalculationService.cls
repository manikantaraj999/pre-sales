@RestResource(urlMapping='/ensxCPQQuoteCalculationService/*')
global with sharing class ENSX_CPQ_QuoteCalculationService {
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(ENSX_CPQ_QuoteCalculationService.class);

    //todo: these should be defaulted in metadata, then overrideable per quote
    @testVisible
    private static String conditionType { get { return (String)UTIL_AppSettings.getValue(UTIL_AppSettings.CPQ, 'ConditionType', ''); } set;}
    @testVisible
    private static String defaultSalesDocType { get { return (String)UTIL_AppSettings.getValue(UTIL_AppSettings.CPQ, 'DefaultSalesDocType', ''); } set;}
    @testVisible
    private static String defaultSalesOrg { get { return (String)UTIL_AppSettings.getValue(UTIL_AppSettings.CPQ, 'DefaultSalesOrg', ''); } set;}
    @testVisible
    private static String defaultDistributionChannel { get { return (String)UTIL_AppSettings.getValue(UTIL_AppSettings.CPQ, 'DefaultDistributionChannel', ''); } set;}
    @testVisible
    private static String defaultDivision { get { return (String)UTIL_AppSettings.getValue(UTIL_AppSettings.CPQ, 'DefaultDivision', ''); } set;}
    @testVisible
    private static String defaultCustomerNumber { get { return (String)UTIL_AppSettings.getValue(UTIL_AppSettings.CPQ, 'DefaultCustomerNumber', ''); } set;}
    @testVisible
    private static String listPriceConditionType { get { return (String)UTIL_AppSettings.getValue(UTIL_AppSettings.CPQ, 'ListPriceConditionType', ''); } set;}
    @testVisible
    private static String unitCostConditionType { get { return (String)UTIL_AppSettings.getValue(UTIL_AppSettings.CPQ, 'UnitCostConditionType', ''); } set;}
    @testVisible
    private static String secondaryUnitCostConditionType { get { return (String)UTIL_AppSettings.getValue(UTIL_AppSettings.CPQ, 'SecondaryUnitCostConditionType', ''); } set;}
    @testVisible
    private static String defaultItemPlant { get { return (String)UTIL_AppSettings.getValue(UTIL_AppSettings.CPQ, 'DefaultItemPlant', ''); } set;}

    // Indexed by the CPQ Product Id;
    @testVisible
    private static Map<Integer, ENSX_QuoteLineMapping> preCalculateState = new Map<Integer, ENSX_QuoteLineMapping>();
    @testVisible
    private static Map<String, ENSX_QuoteLine> materialNumberId = new Map<String, ENSX_QuoteLine>();

    @HttpPost
    global static String doPost(String quote)
    {
        logger.enterAura('doPost', new Map<String, Object> {
            'quote' => quote
        });
        try
        {
            System.debug('/ensxCPQQuoteCalculationService/doPost');
            ENSX_Quote qte  = (ENSX_Quote)JSON.deserialize(quote,ENSX_Quote.class);
            return prepareQuoteAndSimulate(qte, false);
        }   
        catch (Exception ex) {
            logger.log(LoggingLevel.ERROR, 'There was an exception thrown when attempting to doPost ', ex);
            SAPSimulationResults simresults = new SAPSimulationResults();
            simresults.Success = false;
            simresults.Message = ex.getMessage();
            simresults.Quote = new ENSX_Quote();
            simresults.Quote.LinkedQuoteLines = new List<ENSX_QuoteLine>();
            return JSON.serialize(simresults);
        }
        finally
        {
            logger.exit();
        }
    }

    public static String prepareQuoteAndSimulate(ENSX_Quote qte, Boolean addMissingFeatures)
    {
        Set<String> productIds = new Set<String>();
        Integer qlTot = qte.LinkedQuoteLines.size();
        for (Integer qlCnt = 0 ; qlCnt < qlTot ; qlCnt++)
        {
            ENSX_QuoteLine ql = qte.LinkedQuoteLines[qlCnt];
            productIds.add(ql.Product);
        }

        Map<Id, Product2> productMap = UTIL_SFProduct.getProductsByField('Id', new List<String>(productIds), null);

        Integer itemIncrement = UTIL_VCPricing.QuoteLineIncrement;
        Integer parentItemNumber = 0;
        Integer childItem = 0;
        Map<String, Integer> placeholderChildItemsCounter = new Map<String, Integer>();
        qlTot = qte.LinkedQuoteLines.size();
        for (Integer qlCnt = 0 ; qlCnt < qlTot ; qlCnt++)
        {
            ENSX_QuoteLine ql = qte.LinkedQuoteLines[qlCnt];
            ql.ItemConfiguration = String.isBlank(ql.itemJSON) ? new ENSX_ItemConfiguration() : (ENSX_ItemConfiguration)JSON.deserialize(ql.itemJSON, ENSX_ItemConfiguration.class);
            // Reduce response size by removing duplicate version of the same data
            ql.itemJSON = null;

            Product2 prod = productMap.get(ql.Product);
            if (UTIL_SFProduct.isProductLinkedToMaterial(prod))
            {
                ql.SAPMaterialNumber = (String) prod.get(UTIL_SFProduct.MaterialFieldName);
                String childItemKey = String.valueOf(parentItemNumber) + ';' + ql.SAPMaterialNumber;
                Integer counter = placeholderChildItemsCounter.containsKey(childItemKey) ? 
                    placeholderChildItemsCounter.get(childItemKey) : -1;
                counter++;
                if (counter > 0) ql.SAPMaterialNumber += ' (' + counter + ')';
                placeholderChildItemsCounter.put(childItemKey, counter);

                materialNumberId.put(ql.SAPMaterialNumber, ql);
                childItem++;
                if (ql.ParentLineItem == null)
                {
                    parentItemNumber += itemIncrement;
                    childItem = 0;
                }
                preCalculateState.put(ql.LineItem, new ENSX_QuoteLineMapping(ql, parentItemNumber + childItem));
                ql.ItemNumber = String.valueOf(parentItemNumber + childItem);
            }
        }

        List<SBQQ__Quote__c> q = [SELECT SAP_Configuration__c, FLD_Ship_To_Number__c, SBQQ__Account__c FROM SBQQ__Quote__c WHERE Id = :qte.QuoteId LIMIT 1];
        if (q.size() == 1) {
            String headerJSON = q[0].SAP_Configuration__c;
            if (String.isNotBlank(headerJSON)) {
                ENSX_Quote headerConfig = (ENSX_Quote)JSON.deserialize(headerJSON, ENSX_Quote.class);
                if (String.isBlank(qte.soldToParty)) qte.soldToParty = headerConfig.soldToParty;
                if (String.isBlank(qte.shipToParty)) qte.shipToParty = headerConfig.shipToParty;
                if (String.isBlank(qte.salesDocType)) qte.salesDocType = headerConfig.salesDocType;
                if (String.isBlank(qte.salesDistChannel)) qte.salesDistChannel = headerConfig.salesDistChannel;
                if (String.isBlank(qte.salesDivision)) qte.salesDivision = headerConfig.salesDivision;
                if (String.isBlank(qte.salesOrg)) qte.salesOrg = headerConfig.salesOrg;
            }
            if (String.isBlank(qte.soldToParty) && !String.isBlank(q[0].SBQQ__Account__c))
            {
                qte.soldToParty = UTIL_SFAccount.getCustomerNumberFromAccount(UTIL_SFAccount.getAccountById(q[0].SBQQ__Account__c));
            } 
            qte.shipToParty = q[0].FLD_Ship_To_Number__c;
        }
        if (String.isBlank(qte.soldToParty)) qte.soldToParty = defaultCustomerNumber;
        if (String.isBlank(qte.salesDocType)) qte.salesDocType = defaultSalesDocType;
        if (String.isBlank(qte.salesOrg)) qte.salesOrg = defaultSalesOrg;
        if (String.isBlank(qte.salesDistChannel)) qte.salesDistChannel = defaultDistributionChannel;
        if (String.isBlank(qte.salesDivision)) qte.salesDivision = defaultDivision;

        try
        {
            SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing sbo = UTIL_CPQ_QuotePricing.getSBOForENSX_Quote(qte, preCalculateState, productMap);
            updateENSX_QuoteForSBOResults(qte, sbo, addMissingFeatures);
            SAPSimulationResults simresults = new SAPSimulationResults();
            simresults.Success = true;
            simresults.Message = 'Simulated Pricing in SAP for ' + sbo.ITEMS.size() + ' items';
            simresults.Quote = qte;
            System.debug('simulation Success ' );
            return JSON.serialize(simresults);
        }
        catch (ENSX_Exceptions.SimulationException simEx)
        {
            System.debug('simulation failure ' );
            SAPSimulationResults simresults = new SAPSimulationResults();
            simresults.Success = false;
            simresults.Message = processMessage(qte, simEx.getMessage());
            simresults.Quote = qte;
            return JSON.serialize(simresults);
        }
    }

    @testVisible
    private static String processMessage(ENSX_Quote qte, String simMessage)
    {
        String returnMessage = '';
        List<String> messageList = simMessage.split('; ');
        Integer mTot = messageList.size();
        Integer qlTot = qte.LinkedQuoteLines.size();
        for (Integer mCnt = 0 ; mCnt < mTot ; mCnt++)
        {
            String message = messageList[mCnt];
            returnMessage += returnMessage == '' ? message : '; ' + message;
            List<String> messageParts = message.split(', ');
            if (messageParts.size() >= 3 && 
                messageParts[0].startsWith('Internal error:') &&
                Integer.valueOf(messageParts[1]) > 0)
            {
                Integer itemNumber = Integer.valueOf(messageParts[1]);
                for (Integer qlCnt = 0 ; qlCnt < qlTot ; qlCnt++)
                {
                    ENSX_QuoteLine ql = qte.LinkedQuoteLines[qlCnt];
                    if (Integer.valueOf(ql.ItemNumber) == itemNumber)
                    {
                        String linkMessage = '';
                        if (String.isNotEmpty(String.valueOf(ql.LineItem))) linkMessage += 'Item Number ' + String.valueOf(ql.LineItem) + ' ';
                        linkMessage += 'Product Code ' + ql.SAPMaterialNumber;
                        if (messageParts[2].right(1) == ',') messageParts[2] = messageParts[2].left(messageParts[2].length()-1);
                        linkMessage += ' for SAP Item Number ' + messageParts[1] + ' error ' + messageParts[2];
                        returnMessage += '; ' + linkMessage;
                    }
                }
            }
        }
        return returnMessage;
    }

    @testVisible
    private static String concatSboMessages(List<ensxsdk.EnosixFramework.Message> messages)
    {
        String exceptionMessage = '';
        if (null == messages || messages.size() == 0)
        {
            exceptionMessage = 'Quote Calculation Failed';
        }
        else
        {
            Integer mTot = messages.size();
            for (integer i = 0; i < mTot; i++ )
            {
                exceptionMessage += messages[i].Text;
                if (i != messages.size() - 1)
                {
                    exceptionMessage += ', ';
                }
            }
        }
        return exceptionMessage;
    }

    // updateENSX_QuoteForSBOResults
    //
    // Maps results of the SAP pricing simulation back to the incoming quote
    @testVisible
    private static void updateENSX_QuoteForSBOResults(ENSX_Quote qte, SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing sbo, Boolean addMissingFeatures)
    {
        Map<Integer,SBO_EnosixOpportunityPricing_Detail.ITEMS> itms = new Map<Integer,SBO_EnosixOpportunityPricing_Detail.ITEMS>();

        // Indexed by the line item number of the lists parent, and then indexed by the material number
        Map<Integer, Map<String, SBO_EnosixOpportunityPricing_Detail.ITEMS>> childItems = new Map<Integer, Map<String, SBO_EnosixOpportunityPricing_Detail.ITEMS>>();
        Map<String, Integer> placeholderChildItemsCounter = new Map<String, Integer>();
        Map<String, String> childItemHigherLevelItem = new Map<String, String>();          

        List<SBO_EnosixOpportunityPricing_Detail.ITEMS> itemList = sbo.ITEMS.getAsList();
        Integer itemTot = itemList.size();
        for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
        {
            SBO_EnosixOpportunityPricing_Detail.ITEMS itm = itemList[itemCnt];
            Integer higherLevelItemNumber = Integer.valueOf(itm.HigherLevelItemNumber);
            // A higher item level number of '0' indicates that the item is root parent item
            if(0 != higherLevelItemNumber)
            {                
                // A child item could have its own child item
                // This is a workaround that replace the HigherLevelItemNumber with the top parent
                if (childItemHigherLevelItem.containsKey(itm.HigherLevelItemNumber)) 
                {
                    itm.HigherLevelItemNumber = childItemHigherLevelItem.get(itm.HigherLevelItemNumber);
                    higherLevelItemNumber = Integer.valueOf(itm.HigherLevelItemNumber);
                }
                childItemHigherLevelItem.put(itm.ItemNumber, itm.HigherLevelItemNumber);

                Map<String, SBO_EnosixOpportunityPricing_Detail.ITEMS> materialItemMap = 
                    childItems.containsKey(higherLevelItemNumber) ? childItems.get(higherLevelItemNumber) :
                    new Map<String, SBO_EnosixOpportunityPricing_Detail.ITEMS>();
                if (materialItemMap.containsKey(itm.Material))
                {
                    String childItemKey = String.valueOf(higherLevelItemNumber) + ';' + itm.Material;
                    Integer counter = placeholderChildItemsCounter.containsKey(childItemKey) ? 
                        placeholderChildItemsCounter.get(childItemKey) : 0;
                    counter++;
                    materialItemMap.put(itm.Material + ' (' + counter + ')', itm);
                    placeholderChildItemsCounter.put(childItemKey, counter);
                }
                else materialItemMap.put(itm.Material, itm);

                childItems.put(higherLevelItemNumber, materialItemMap);
            }
            else
            {
                itms.put(Integer.valueOf(itm.ItemNumber),itm);
            }
        }

        Map<Integer,Date> atp = getItemsAvailableToPromiseDate(sbo);

        Map<Integer,Decimal> listPriceCondition = new Map<Integer,Decimal>();
        Map<Integer,Decimal> unitCostCondition = new Map<Integer,Decimal>();
        Map<Integer,Decimal> secondaryUnitCostCondition = new Map<Integer,Decimal>();
        Map<Integer,Map<String,List<SBO_EnosixOpportunityPricing_Detail.CONDITIONS>>> itemsConditions = new Map<Integer,Map<String,List<SBO_EnosixOpportunityPricing_Detail.CONDITIONS>>>();
        Map<String,Map<Integer,Decimal>> conditions = new Map<String,Map<Integer,Decimal>>();
        processConditions(new Set<String>{ listPriceConditionType, unitCostConditionType, secondaryUnitCostConditionType }, 
            sbo, itemsConditions, conditions);

        if (null != conditions.get(listPriceConditionType))
        {
            listPriceCondition = conditions.get(listPriceConditionType);
        }
        if (null != conditions.get(unitCostConditionType))
        {
            unitCostCondition = conditions.get(unitCostConditionType);
        }
        if (null != conditions.get(secondaryUnitCostConditionType))
        {
            secondaryUnitCostCondition = conditions.get(secondaryUnitCostConditionType);
        }
        System.debug('iterating and updating pricing from SAP on the quote');
        List<ENSX_QuoteLine> newLinkedQuoteLines = new List<ENSX_QuoteLine>();
        Integer currentParent = 0;
        Integer qlTot = qte.LinkedQuoteLines.size();
        for (Integer qlCnt = 0 ; qlCnt < qlTot ; qlCnt++)
        {
            ENSX_QuoteLine ql = qte.LinkedQuoteLines[qlCnt];
            ENSX_QuoteLineMapping priorMapping = preCalculateState.get(ql.LineItem);
            // Gets the item for the current mapped field
            if(priorMapping != null && !priorMapping.IsProductFeature)
            {
                if (addMissingFeatures && currentParent != ql.LineItem)
                {
                    ENSX_QuoteLineMapping parentMapping = preCalculateState.get(currentParent);
                    if (parentMapping != null)
                    {
                        SBO_EnosixOpportunityPricing_Detail.ITEMS parentItm = itms.get(parentMapping.SAPLineItem);
                        Map<String, SBO_EnosixOpportunityPricing_Detail.ITEMS> childItemMap = childItems.get(parentMapping.SAPLineItem);
                        if (childItemMap != null)
                        {
                            List<SBO_EnosixOpportunityPricing_Detail.ITEMS> childItemList = childItemMap.values();
                            Integer childItemTot = childItemList.size();
                            for (Integer childItemCnt = 0 ; childItemCnt < childItemTot ; childItemCnt++)
                            {
                                SBO_EnosixOpportunityPricing_Detail.ITEMS childItm = childItemList[childItemCnt];
                                ENSX_QuoteLine missingQl = new ENSX_QuoteLine();
                                missingQl.SAPMaterialNumber = childItm.Material;
                                missingQl.ParentLineItem = currentParent;
                                missingQl.IsProductFeature = true;
                                missingQl.Quantity = childItm.OrderQuantity;
                                updateQuoteLineFromSAP(missingQl, atp, childItm, parentItm, itemsConditions.get(parentMapping.SAPLineItem), 
                                    listPriceCondition, unitCostCondition, secondaryUnitCostCondition, true);
                                missingQl.record = null;
                                newLinkedQuoteLines.add(missingQl);
                            }
                        }
                    }
                }
                SBO_EnosixOpportunityPricing_Detail.ITEMS parentItm = itms.get(priorMapping.SAPLineItem);
                updateQuoteLineFromSAP(ql, atp, parentItm, null, itemsConditions.get(priorMapping.SAPLineItem), listPriceCondition, 
                    unitCostCondition, secondaryUnitCostCondition, false);
                if (addMissingFeatures) ql.record = null;
                newLinkedQuoteLines.add(ql);
                currentParent = ql.LineItem;
            }
            else if (priorMapping != null)
            {                
                ENSX_QuoteLineMapping parentMapping = preCalculateState.get(priorMapping.CPQParentLineItem);
                if (null != parentMapping && null != childItems.get(parentMapping.SAPLineItem))
                {
                    SBO_EnosixOpportunityPricing_Detail.ITEMS parentItm = itms.get(parentMapping.SAPLineItem);
                    Map<String, SBO_EnosixOpportunityPricing_Detail.ITEMS> childItemMap = childItems.get(parentMapping.SAPLineItem);
                    SBO_EnosixOpportunityPricing_Detail.ITEMS childItm = childItemMap.get(ql.SAPMaterialNumber);
                    if (childItm != null)
                    {
                        updateQuoteLineFromSAP(ql, atp, childItm, parentItm, itemsConditions.get(parentMapping.SAPLineItem), 
                            listPriceCondition, unitCostCondition, secondaryUnitCostCondition, true);
                        childItemMap.remove(ql.SAPMaterialNumber);
                    }
                }
                else
                {
                    logger.debug('updateENSX_QuoteForSBOResults:IsProductFeature:UnexpectedState', new Map<String, Object> {
                        'ql' => ql,
                        'parentMapping' => parentMapping,
                        'childItems.get(parentMapping.SAPLineItem)' => parentMapping != null ? childItems.get(parentMapping.SAPLineItem) : null
                    });
                }
                if (addMissingFeatures) ql.record = null;
                newLinkedQuoteLines.add(ql);
            }       
        }
        if (addMissingFeatures && currentParent > 0)
        {
            ENSX_QuoteLineMapping parentMapping = preCalculateState.get(currentParent);
            if (parentMapping != null)
            {
                SBO_EnosixOpportunityPricing_Detail.ITEMS parentItm = itms.get(parentMapping.SAPLineItem);
                Map<String, SBO_EnosixOpportunityPricing_Detail.ITEMS> childItemMap = childItems.get(parentMapping.SAPLineItem);
                if (childItemMap != null)
                {
                    List<SBO_EnosixOpportunityPricing_Detail.ITEMS> childItemList = childItemMap.values();
                    Integer childItemTot = childItemList.size();
                    for (Integer childItemCnt = 0 ; childItemCnt < childItemTot ; childItemCnt++)
                    {
                        SBO_EnosixOpportunityPricing_Detail.ITEMS childItm = childItemList[childItemCnt];
                        ENSX_QuoteLine missingQl = new ENSX_QuoteLine();
                        missingQl.SAPMaterialNumber = childItm.Material;
                        missingQl.ParentLineItem = currentParent;
                        missingQl.IsProductFeature = true;
                        missingQl.Quantity = childItm.OrderQuantity;
                        updateQuoteLineFromSAP(missingQl, atp, childItm, parentItm, itemsConditions.get(parentMapping.SAPLineItem), 
                            listPriceCondition, unitCostCondition, secondaryUnitCostCondition, true);
                        missingQl.record = null;
                        newLinkedQuoteLines.add(missingQl);
                    }
                }
            }
        }
        qte.LinkedQuoteLines = newLinkedQuoteLines;
        applyQuoteResponseMappingRules(qte, sbo, itemsConditions.get(0));
    }

    @Testvisible
    private static CPQPricingConfig cpqPricingConfig = null;

    public static void applyQuoteRequestMappingRules(
        ENSX_Quote qte,
        SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing requestSBO
    ) {
        if (null == qte || String.isBlank(qte.recordJSON)) {
            return;
        }
        if (cpqPricingConfig == null) {
            cpqPricingConfig = (CPQPricingConfig)UTIL_AppSettings.getSObject(UTIL_AppSettings.CPQ, 'Pricing',CPQPricingConfig.class, null);
        }
        if (null == cpqPricingConfig || null == cpqPricingConfig.Request || null == cpqPricingConfig.Request.Quote || 
            null == cpqPricingConfig.Request.Quote.RecordMapping || cpqPricingConfig.Request.Quote.RecordMapping.isEmpty()) {
            return;
        }
        List<CPQPricingConfigMappingRule> recordMappingRules = cpqPricingConfig.Request.Quote.RecordMapping;
        qte.record = (Map<String,Object>) JSON.deserializeUntyped(qte.recordJSON);
        Integer ruleTot = recordMappingRules.size();
        for (Integer ruleCnt = 0 ; ruleCnt < ruleTot ; ruleCnt++) {
            CPQPricingConfigMappingRule rule = recordMappingRules[ruleCnt];
            Object value = qte.record.get(rule.sObjectField);
            if (null == value) continue;
            switch on rule.sboCollection {
                when 'sales' {
                    switch on rule.sboTarget {
                        when 'SalesDocumentType' {
                            requestSBO.SALES.SalesDocumentType = String.valueOf(value);
                        }
                        when 'SalesOrganization' {
                            requestSBO.SALES.SalesOrganization = String.valueOf(value);
                        }
                        when 'DistributionChannel' {
                            requestSBO.SALES.DistributionChannel = String.valueOf(value);
                        }
                        when 'Division' {
                            requestSBO.SALES.Division = String.valueOf(value);
                        }
                        when 'SalesDocumentCurrency' {
                            requestSBO.SALES.SalesDocumentCurrency = String.valueOf(value);
                        }
                        when else {
                            System.debug('applyQuoteRequestMappingRules: unrecognized sboTarget: ' + rule);
                        }
                    }
                }
                when 'header' {
                    switch on rule.sboTarget {
                        when 'SoldToParty' {
                            requestSBO.SoldToParty = String.valueOf(value);
                        }
                        when 'SalesDocumentCurrency' {
                            requestSBO.SalesDocumentCurrency = String.valueOf(value);
                        }
                        when else {
                            System.debug('applyQuoteRequestMappingRules: unrecognized sboTarget: ' + rule);
                        }
                    }
                }
                when 'partners' {
                    switch on rule.sboTarget {
                        when 'CustomerNumber' {
                            switch on rule.partnerType {
                                when 'SoldToParty' {
                                    getPartner(requestSBO, UTIL_Customer.SOLD_TO_PARTNER_CODE, String.valueOf(value));
                                }
                                when 'ShipToParty' {
                                    getPartner(requestSBO, UTIL_Customer.SHIP_TO_PARTNER_CODE, String.valueOf(value));
                                }
                                when 'BillToParty' {
                                    getPartner(requestSBO, UTIL_Customer.BILL_TO_PARTNER_CODE, String.valueOf(value));
                                }
                                when 'PayerParty' {
                                    getPartner(requestSBO, UTIL_Customer.PAYER_PARTNER_CODE, String.valueOf(value));
                                }
                                when else {
                                    System.debug('applyQuoteRequestMappingRules: unrecognized partnerType: ' + rule);
                                }
                            }
                        }
                    }
                }
                when else {
                    System.debug('applyQuoteRequestMappingRules: unrecognized sboCollection: ' + rule);
                }
            }
        }
    }
    
    public static void getPartner(SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing requestSBO, string function, string customerNumber)
    {
        if (requestSBO != null && String.isNotEmpty(customerNumber))
        {
            SBO_EnosixOpportunityPricing_Detail.PARTNERS result = null;
            List<SBO_EnosixOpportunityPricing_Detail.PARTNERS> partnerList = requestSBO.PARTNERS.getAsList();
            Integer partnerTot = partnerList.size();
            for (Integer partnerCnt = 0 ; partnerCnt < partnerTot ; partnerCnt++)
            {
                SBO_EnosixOpportunityPricing_Detail.PARTNERS partner = partnerList[partnerCnt];
                if (function == partner.PartnerFunction)
                {
                    result = partner;
                    break;
                }
            }

            if (null == result)
            {
                result = new SBO_EnosixOpportunityPricing_Detail.PARTNERS();
                result.PartnerFunction = function;
                requestSBO.PARTNERS.add(result);
            }
            result.CustomerNumber = customerNumber;
        }
    }

    @testvisible
    private static void applyQuoteResponseMappingRules(
        ENSX_Quote qte,
        SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing responseSBO,
        Map<String,List<SBO_EnosixOpportunityPricing_Detail.CONDITIONS>> headerConditions
    ) {
        if (cpqPricingConfig == null) {
            cpqPricingConfig = (CPQPricingConfig)UTIL_AppSettings.getSObject(UTIL_AppSettings.CPQ, 'Pricing',CPQPricingConfig.class, null);
        }
        if (null == cpqPricingConfig || null == cpqPricingConfig.Response || null == cpqPricingConfig.Response.Quote || 
            null == cpqPricingConfig.Response.Quote.RecordMapping || cpqPricingConfig.Response.Quote.RecordMapping.isEmpty()) {
            return;
        }
        List<CPQPricingConfigMappingRule> recordMappingRules = cpqPricingConfig.Response.Quote.RecordMapping;
        if (null == qte.record) qte.record = new Map<String,Object>();
        if (UTIL_CPQ_Setup.getFromAppSettings().config.DEBUG) {
            UTIL_PageMessages.addFrameworkMessages(responseSBO.getMessages());
            qte.debug = new Map<String,Object>{
                'messages' => UTIL_PageMessages.messageList,
                'headerConditions' => headerConditions
            };
        }
        Integer ruleTot = recordMappingRules.size();
        for (Integer ruleCnt = 0 ; ruleCnt < ruleTot ; ruleCnt++) {
            CPQPricingConfigMappingRule rule = recordMappingRules[ruleCnt];
            Object value = null;
            switch on rule.sboCollection {
                when 'header' {
                    switch on rule.sboTarget {
                        when 'TaxAmount' {
                            value = responseSBO.TaxAmount;
                        }
                        when else {
                            System.debug('applyQuoteResponseMappingRules: unrecognized sboTarget: ' + rule);
                        }
                    }
                }
                when 'condition' {
                    value = transformConditionToValue(rule, headerConditions, null);
                }
                when else {
                    System.debug('applyQuoteResponseMappingRules: unrecognized sboCollection: ' + rule);
                }
            }
            qte.record.put(rule.sObjectField, value);
        }
    }

    @testVisible
    private static void updateQuoteLineFromSAP(
        ENSX_QuoteLine ql, 
        Map<Integer,Date> atp, 
        SBO_EnosixOpportunityPricing_Detail.ITEMS itm, 
        SBO_EnosixOpportunityPricing_Detail.ITEMS parentItm, 
        Map<String,List<SBO_EnosixOpportunityPricing_Detail.CONDITIONS>> itemConditions,
        Map<Integer,Decimal> listPriceCondition,
        Map<Integer,Decimal> unitCostCondition,
        Map<Integer,Decimal> secondaryUnitCostCondition,
        Boolean isFeature)
    {
        if (null != itm)
        {
            Decimal listPrice = listPriceCondition.get(ql.LineItem);
            if (null == listPrice)
            {
                listPrice = itm.NetItemPrice;
            }

            Decimal unitCost = unitCostCondition.get(ql.LineItem);
            if (null == unitCost)
            {
                unitCost = secondaryUnitCostCondition.get(ql.LineItem);
                if (null == unitCost)
                {
                    unitCost = itm.CostInDocCurrency / itm.OrderQuantity;
                }
            }

            // Calculate netCost based on CPQ quote-line quantity since at some clients have
            // observed SAP quantities are changed during simulation
            Decimal netCost = unitCost * ql.Quantity;

            System.debug(
                'Found a match for line item, itm.OrderQuantity is ' + itm.OrderQuantity +
                ', itm.NetItemPrice is ' + itm.NetItemPrice + ', listPrice is ' + listPrice +
                '; unitCost is ' + unitCost + ', itm.CostInDocCurrency is ' +
                itm.CostInDocCurrency + ', netCost is ' + netCost
            );

            ql.ItemNumber = itm.ItemNumber;
            ql.UnitCost = unitCost;
            ql.Plant = itm.Plant;
            ql.NetCost = netCost;
            ql.NetWeight = itm.Netweight;
            ql.ListPrice = itm.NetItemPrice;
            ql.CostPrice = itm.CostInDocCurrency / itm.OrderQuantity;
            ql.NetPrice = ql.ListPrice * ql.Quantity;
            ql.Quantity = itm.OrderQuantity;
            if (parentItm != null) ql.Quantity = ql.Quantity / parentItm.OrderQuantity;
            ql.ATPDate = atp.get(ql.LineItem);
            if (ql.record == null) ql.record = new Map<String,Object>();
            ql.record.put('SBQQ__ListPrice__c', ql.ListPrice);
            ql.record.put('SBQQ__UnitCost__c', ql.UnitCost);
            if (isFeature)
            {
                ENSX_QuoteLine quoteLine = materialNumberId.get(itm.Material);
                if (null != quoteLine)
                {
                    ql.RealProductId = quoteLine.Product;
                    ql.RealPricebookEntryId = quoteLine.PricebookEntry;
                }
            } 
            applyQuoteLineResponseMappingRules(ql, itm, itemConditions);
        }
    }

    public static void applyQuoteLineRequestMappingRules(
        ENSX_QuoteLine ql,
        SBO_EnosixOpportunityPricing_Detail.ITEMS item,
        SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing requestSBO
    ) {
        if (null == ql || String.isBlank(ql.recordJSON)) {
            return;
        }
        if (cpqPricingConfig == null) {
            cpqPricingConfig = (CPQPricingConfig)UTIL_AppSettings.getSObject(UTIL_AppSettings.CPQ, 'Pricing',CPQPricingConfig.class, null);
        }
        if (null == cpqPricingConfig || null == cpqPricingConfig.Request || null == cpqPricingConfig.Request.QuoteLine || 
            null == cpqPricingConfig.Request.QuoteLine.RecordMapping || cpqPricingConfig.Request.QuoteLine.RecordMapping.isEmpty()) {
            return;
        }
        List<CPQPricingConfigMappingRule> recordMappingRules = cpqPricingConfig.Request.QuoteLine.RecordMapping;
        ql.record = (Map<String,Object>) JSON.deserializeUntyped(ql.recordJSON);
        Integer ruleTot = recordMappingRules.size();
        for (Integer ruleCnt = 0 ; ruleCnt < ruleTot ; ruleCnt++) {
            CPQPricingConfigMappingRule rule = recordMappingRules[ruleCnt];
            Object value = ql.record.get(rule.sObjectField);
            if (null == value) continue;
            switch on rule.sboCollection {
                when 'item' {
                    switch on rule.sboTarget {
                        when 'SalesUnit' {
                            item.SalesUnit = String.valueOf(value);
                        }
                        when else {
                            System.debug('applyQuoteLineRequestMappingRules: unrecognized sboTarget: ' + rule);
                        }
                    }
                }
                when 'condition' {
                    SBO_EnosixOpportunityPricing_Detail.CONDITIONS condition = new SBO_EnosixOpportunityPricing_Detail.CONDITIONS();
                    condition.ConditionItemNumber = item.itemnumber;
                    condition.ConditionType = rule.sboTarget;
                    condition.ConditionControl = 'C'; // Manually Entered
                    Decimal decimalValue = Decimal.valueOf(String.valueOf(value));
                    switch on rule.transform {
                        when 'conditionRateAsPercent' {
                            condition.Rate = decimalValue;
                        }
                        when 'conditionRateDiscountAsPercent' {
                            condition.Rate = -decimalValue;
                        }
                        when 'conditionRate' {
                            condition.Rate = decimalValue;
                        }
                        when 'conditionRateDiscount' {
                            condition.Rate = -decimalValue;
                        }
                        when else {
                            System.debug('applyQuoteLineRequestMappingRules: unrecognized transform: ' + rule);
                        }
                    }
                    requestSBO.CONDITIONS.add(condition);
                }
                when else {
                    System.debug('applyQuoteLineRequestMappingRules: unrecognized sboCollection: ' + rule);
                }
            }
        }
    }

    @testvisible
    private static void applyQuoteLineResponseMappingRules(
        ENSX_QuoteLine ql,
        SBO_EnosixOpportunityPricing_Detail.ITEMS item,
        Map<String,List<SBO_EnosixOpportunityPricing_Detail.CONDITIONS>> itemConditions
    ) {
        if (cpqPricingConfig == null) {
            cpqPricingConfig = (CPQPricingConfig)UTIL_AppSettings.getSObject(UTIL_AppSettings.CPQ, 'Pricing',CPQPricingConfig.class, null);
        }
        if (null == cpqPricingConfig || null == cpqPricingConfig.Response || null == cpqPricingConfig.Response.QuoteLine || 
            null == cpqPricingConfig.Response.QuoteLine.RecordMapping || cpqPricingConfig.Response.QuoteLine.RecordMapping.isEmpty()) {
            return;
        }
        List<CPQPricingConfigMappingRule> recordMappingRules = cpqPricingConfig.Response.QuoteLine.RecordMapping;
        if (null == ql.record) ql.record = new Map<String,Object>();
        if (UTIL_CPQ_Setup.getFromAppSettings().config.DEBUG) {
            ql.debug = new Map<String,Object>{
                'itemConditions' => itemConditions
            };
        }
        Integer ruleTot = recordMappingRules.size();
        for (Integer ruleCnt = 0 ; ruleCnt < ruleTot ; ruleCnt++) {
            CPQPricingConfigMappingRule rule = recordMappingRules[ruleCnt];
            Object value = null;
            switch on rule.sboCollection {
                when 'item' {
                    switch on rule.sboTarget {
                        when 'NetItemPrice' {
                            value = item.NetItemPrice;
                        }
                        when 'ItemNumber' {
                            value = Integer.valueOf(item.ItemNumber);
                        }
                        when 'SalesUnit' {
                            value = item.SalesUnit;
                        }
                        when else {
                            System.debug('applyQuoteLineResponseMappingRules: unrecognized sboTarget: ' + rule);
                        }
                    }
                }
                when 'condition' {
                    value = transformConditionToValue(rule, itemConditions, item.OrderQuantity);
                }
                when else {
                    System.debug('applyQuoteLineResponseMappingRules: unrecognized sboCollection: ' + rule);
                }
            }
            ql.record.put(rule.sObjectField, value);
        }
    }

    @testvisible
    private static Object transformConditionToValue(
        CPQPricingConfigMappingRule rule,
        Map<String,List<SBO_EnosixOpportunityPricing_Detail.CONDITIONS>> conditions,
        Decimal itemQuantity
    ) {
        Object value = null;
        List<SBO_EnosixOpportunityPricing_Detail.CONDITIONS> conditionList = conditions != null ? conditions.get(rule.sboTarget) : null;
        if (conditionList != null) {
            Decimal totalValue = 0;
            Integer cTot = conditionList.size();
            for (Integer cCnt = 0 ; cCnt < cTot ; cCnt++)
            {
                SBO_EnosixOpportunityPricing_Detail.CONDITIONS condition = conditionList[cCnt];
                switch on rule.transform {
                    when 'conditionValue' {
                        totalValue += condition.KWERT;
                        value = totalValue;
                    }
                    when 'conditionValueDiscount' {
                        totalValue += -condition.KWERT;
                        value = totalValue;
                    }
                    when 'conditionValuePerItemQuantity' {
                        if (itemQuantity > 0) {
                            totalValue += condition.KWERT / itemQuantity; 
                            value = totalValue;
                        }
                    }
                    when 'conditionValueDiscountPerItemQuantity' {
                        if (itemQuantity > 0) {
                            totalValue += -condition.KWERT / itemQuantity;
                            value = totalValue;
                        }
                    }
                    when 'conditionRateAsPercent' {
                        totalValue += condition.Rate;
                        value = totalValue;
                    }
                    when 'conditionRateDiscountAsPercent' {
                        totalValue += -condition.Rate;
                        value = totalValue;
                    }
                    when 'conditionRate' {
                        totalValue += condition.Rate;
                        value = totalValue;
                    }
                    when 'conditionRateDiscount' {
                        totalValue += -condition.Rate;
                        value = totalValue;
                    }
                    when 'conditionRateUnit' {
                        value = condition.RateUnit;
                    }
                    when else {
                        System.debug('transformConditionToValue: unrecognized transform: ' + rule);
                    }
                }
            }
        }
        return value;
    }

    public class CPQPricingConfig {
        public CPQPricingConfigRequestResponse Request;
        public CPQPricingConfigRequestResponse Response;
    }
    public class CPQPricingConfigRequestResponse {
        public CPQPricingConfigRecordMapping Quote;
        public CPQPricingConfigRecordMapping QuoteLine;
    }
    public class CPQPricingConfigRecordMapping {
        public List<CPQPricingConfigMappingRule> RecordMapping;
    }

    @TestVisible
    public class CPQPricingConfigMappingRule {
        public String sObjectField;
        public String sboCollection;
        public String sboTarget;
        public String transform;
        public String partnerType;
    }

    @Testvisible
    private static void processConditions(
        Set<String> conditionTypes, 
        SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing sbo,
        Map<Integer,Map<String,List<SBO_EnosixOpportunityPricing_Detail.CONDITIONS>>> itemsConditions,
        Map<String,Map<Integer,Decimal>> conditions)
    {
        if (null == sbo) return;
        List<SBO_EnosixOpportunityPricing_Detail.CONDITIONS> condList = sbo.CONDITIONS.getAsList();
        Integer condTot = condList.size();
        for (Integer condCnt = 0 ; condCnt < condTot ; condCnt++)
        {
            SBO_EnosixOpportunityPricing_Detail.CONDITIONS condition = condList[condCnt];
            Integer itemNumber = Integer.valueOf(condition.ConditionItemNumber);
            Map<String,List<SBO_EnosixOpportunityPricing_Detail.CONDITIONS>> conditionMap = itemsConditions.get(itemNumber);
            if (null == conditionMap)
            {
                conditionMap = new Map<String,List<SBO_EnosixOpportunityPricing_Detail.CONDITIONS>>();
                itemsConditions.put(itemNumber, conditionMap);
            }
            List<SBO_EnosixOpportunityPricing_Detail.CONDITIONS> conditionList = 
                conditionMap.containsKey(condition.ConditionType) ? conditionMap.get(condition.ConditionType) : 
                new List<SBO_EnosixOpportunityPricing_Detail.CONDITIONS>();
            conditionList.add(condition);
            conditionMap.put(condition.ConditionType, conditionList);

            if (null != conditionTypes)
            {
                conditionTypes.removeAll(new Set<String> { null, '' });
                if (conditionTypes.size() > 0)
                {
                    if (conditionTypes.contains(condition.ConditionType))
                    {
                        Map<Integer,Decimal> priceConditionMap = conditions.get(condition.ConditionType);
                        if (null == priceConditionMap)
                        {
                            priceConditionMap = new Map<Integer,Decimal>();
                            conditions.put(condition.ConditionType, priceConditionMap);
                        }
                        Decimal pricingUnit = condition.ConditionPricingUnit;
                        if(null == pricingUnit || 0 == pricingUnit)
                        {
                            pricingUnit = 1;
                        }
                        Decimal currentValue = priceConditionMap.containsKey(itemNumber) ? priceConditionMap.get(itemNumber) : 0;
                        priceConditionMap.put(itemNumber, currentValue + (condition.Rate / pricingUnit));
                    }
                }
            }
        }
    }

    // getItemsAvailableToPromiseDate
    //
    // Calculates Available To Promise (ATP) dates for all items by taking the
    // greatest schedule date per item with a confirmed quantity.
    private static Map<Integer,Date> getItemsAvailableToPromiseDate(SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing sbo) {
        Map<Integer,Date> atp = new Map<Integer,Date>();
        List<SBO_EnosixOpportunityPricing_Detail.ITEMS_SCHEDULE> schedList = sbo.ITEMS_SCHEDULE.getAsList();
        Integer schedTot = schedList.size();
        for (Integer schedCnt = 0 ; schedCnt < schedTot ; schedCnt++)
        {
            SBO_EnosixOpportunityPricing_Detail.ITEMS_SCHEDULE schedule = schedList[schedCnt];
            Integer i = Integer.valueOf(schedule.ItemNumber);
            if (schedule.ConfirmedQuantity > 0 && (null == atp.get(i) || schedule.ScheduleLineDate > atp.get(i)))
            {
                atp.put(i, schedule.ScheduleLineDate);
            }
        }
        return atp;
    }

    public class SAPSimulationResults
    {
        @AuraEnabled
        public Boolean Success { get; set; }

        @AuraEnabled
        public String Message { get; set; }

        @AuraEnabled
        public ENSX_Quote Quote {get;set;}
    }
}