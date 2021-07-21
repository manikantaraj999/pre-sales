public with sharing class UTIL_SFSObjectDoc
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_SFSObjectDoc.class);

    public static final String CALLED_FROM_OPPORTUNITY_PRICING = 'CTRL_OpportunityQuotePricing';

    public static final String STATUS_SIMULATE = 'Simulate';
    public static final String STATUS_CREATE = 'Create';

    // Indexed by sObject type name
    private static Map<String,Object> sfSObjectDocMap = new Map<String,Object>();

    private static String loadedSObjectName;

    @testVisible
    public static SObject sfsObject { get; private set; }
    @testVisible
    public static Account sfAccount { get; private set; }
    @testVisible
    public static String sapCustomerNumber { get; private set; }    

    @testVisible
    private static I_SFSObjectDoc loadSfsObjectDoc(SObject sfSObject)
    {
        if (sfSObject == null) return null;
        return loadSfsObjectDoc(sfSObject.getSObjectType().getDescribe().getName());
    }

    @testVisible
    private static I_SFSObjectDoc loadSfsObjectDoc(Id sfSObjectId)
    {
        if (sfSObjectId == null) return null;
        return loadSfsObjectDoc(sfSObjectId.getSObjectType().getDescribe().getName());
    }

    @testVisible
    private static I_SFSObjectDoc loadSfsObjectDoc(String sObjectTypeName)
    {
        if (String.isEmpty(sObjectTypeName)) return null;
        Object sfSObjectDoc = sfSObjectDocMap.get(sObjectTypeName);
        if (sfSObjectDoc == null)
        {
            String clsName = (String)UTIL_AppSettings.getValue(
                'UTIL_SFSObjectDoc.' + sObjectTypeName,
                'UTIL_SF' + sObjectTypeName
            );
            Type sfsObjectDocType = Type.forName(clsName);
            if (sfsObjectDocType != null) {
                sfSObjectDoc = sfsObjectDocType.newInstance();
                if (sfSObjectDoc instanceof I_SFSObjectDoc) {
                    sfSObjectDocMap.put(sObjectTypeName, sfSObjectDoc);
                }
            }
        }
        return (I_SFSObjectDoc) sfSObjectDoc;
    }

	public static SObject initObjectsForSAP(String SFRecordId, String SAPDocNum, String SAPDocType)
	{
        sfsObject = null;
        if (SFRecordId != null && String.isNotEmpty(SFRecordId))
        {
            sfSObject = UTIL_SFSObjectDoc.getSObject(SFRecordId);
        }
        if (sfSObject == null)
        {
            sfSObject = UTIL_SFSObjectDoc.getSObject('Opportunity', SAPDocType, SAPDocNum);
            if (null == sfSObject)
            {
                sfSObject = UTIL_SFSObjectDoc.getSObject('Quote', SAPDocType, SAPDocNum);
                if (null == sfSObject)
                {
                    sfSObject = UTIL_SFSObjectDoc.getSObject('SBQQ__Quote__c', SAPDocType, SAPDocNum);
               }
            }
        }
        return sfsObject;
    }

	public static void initObjects(String calledFrom)
	{
        boolean isFound = false;

        String idString = null;
        if (!String.isBlank(UTIL_PageState.current.sfOpportunityId))
        {
            idString = UTIL_PageState.current.sfOpportunityId;
        }
        else if (!String.isBlank(UTIL_PageState.current.sfQuoteId))
        {
            idString = UTIL_PageState.current.sfQuoteId;
        }
        else if (!String.isBlank(UTIL_PageState.current.sfCpqQuoteId))
        {
            idString = UTIL_PageState.current.sfCpqQuoteId;
        }
        if (idString != null)
        {
            sfSObject = UTIL_SFSObjectDoc.getSObject(idString);
            if (null != sfSObject)
            {
                isFound = true;
                sfAccount = UTIL_SFAccount.getAccountById(UTIL_SFSObjectDoc.getAccountId(sfSObject));
            }
        }
        else if (!String.isBlank(UTIL_PageState.current.sapQuoteId))
        {
            isFound = true;
            sfSObject = UTIL_SFSObjectDoc.getSObject('Opportunity', 'Quote', UTIL_PageState.current.sapQuoteId);
            if (null == sfSObject)
            {
                sfSObject = UTIL_SFSObjectDoc.getSObject('Quote', 'Quote', UTIL_PageState.current.sapQuoteId);
                if (null == sfSObject)
                {
                    sfSObject = UTIL_SFSObjectDoc.getSObject('SBQQ__Quote__c', 'Quote', UTIL_PageState.current.sapQuoteId);
                    if (null == sfSObject) isFound = false;
               }
            }
            if (isFound)
            {
                sfAccount = UTIL_SFAccount.getAccountById(UTIL_SFSObjectDoc.getAccountId(sfSObject));
            }
        }
        else if (!String.isBlank(UTIL_PageState.current.sapOrderNum))
        {
            isFound = true;
            sfSObject = UTIL_SFSObjectDoc.getSObject('Opportunity', 'Order', UTIL_PageState.current.sapOrderNum);
            if (null == sfSObject)
            {
                sfSObject = UTIL_SFSObjectDoc.getSObject('Quote', 'Order', UTIL_PageState.current.sapOrderNum);
                if (null == sfSObject)
                {
                    sfSObject = UTIL_SFSObjectDoc.getSObject('SBQQ__Quote__c', 'Order', UTIL_PageState.current.sapOrderNum);
                    if (null == sfSObject) isFound = false;
               }
            }
            if (isFound)
            {
                sfAccount = UTIL_SFAccount.getAccountById(UTIL_SFSObjectDoc.getAccountId(sfSObject));
            }
        }

        if (null == sfAccount)
        {
            sfAccount = UTIL_SFAccount.getAccountById(UTIL_PageState.current.sfAccountId);
        }

        if (!isFound && calledFrom == CALLED_FROM_OPPORTUNITY_PRICING)
        {
            sfSObject = null;
            if (sfAccount != null)
            {
                Opportunity opp = new Opportunity();
                opp.Name = sfAccount.Name.subString(0, sfAccount.Name.length() < 105 ? sfAccount.Name.length() : 105) + ' ' + System.today().format();
                opp.StageName = 'Prospecting';
                opp.CloseDate = System.today();
                opp.AccountId = sfAccount.Id;
                sfSObject = opp;
            }
        }

        if (null != sfAccount)
        {
            UTIL_PageState.current.sfAccountId = sfAccount.Id;
            sapCustomerNumber = UTIL_SFAccount.getCustomerNumberFromAccount(sfAccount);
            if (string.isBlank(sapCustomerNumber))
            {
                ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR,
                        'This account is not configured with an SAP customer'));
            }
        }
	}

    public class SfSObjectItem
    {
        public Id id { get; private set; }
        public Boolean isDeleted { get; set; }

        public SfSObjectItem ( Id id )
        {
            this.id = id;
            this.isDeleted = false;
        }
    }

	public static SObject getSObject(string idString)
	{
        SObject result = null;
        try 
        {
            I_SFSObjectDoc sfSObjectDoc = loadSfsObjectDoc((Id) idString);
            result = sfSObjectDoc == null ? null : sfSObjectDoc.getSObject(idString);
        } 
        catch (Exception e) {}
        return result;
	}

	public static SObject getSObject(String sObjectType, String sapType, String sapDocNum)
	{
        I_SFSObjectDoc sfSObjectDoc = loadSfsObjectDoc(sObjectType);
        return sfSObjectDoc == null ? null : sfSObjectDoc.getSObject(sapType, sapDocNum);
	}

	public static Map<Id, SObject> getSObjectLineItems(SObject sfSObject)
	{
        I_SFSObjectDoc sfSObjectDoc = loadSfsObjectDoc(sfSObject);
        return sfSObjectDoc == null ? new Map<Id, SObject>() : sfSObjectDoc.getSObjectLineItems(sfSObject.Id);
	}

    public static Map<Id, SObject> getSObjectContacts(SObject sfSObject)
	{
        I_SFSObjectDoc sfSObjectDoc = loadSfsObjectDoc(sfSObject);
        return sfSObjectDoc == null ? new Map<Id, SObject>() : sfSObjectDoc.getSObjectContacts(sfSObject.Id);
	}
	
	public static String getAccountId(String idString)
	{
        String result = null;
        try 
        {
            I_SFSObjectDoc sfSObjectDoc = loadSfsObjectDoc((Id) idString);
            result = sfSObjectDoc == null ? null : sfSObjectDoc.getAccountId(sfSObjectDoc.getSObject(idString));
        } 
        catch (Exception e) {}
        return result;
	}

	public static String getAccountId(SObject sfSObject)
	{
        I_SFSObjectDoc sfSObjectDoc = loadSfsObjectDoc(sfSObject);
        return sfSObjectDoc == null ? null : sfSObjectDoc.getAccountId(sfSObject);
	}

    public static String getCustomerNumber(SObject sfSObject)
	{
        I_SFSObjectDoc sfSObjectDoc = loadSfsObjectDoc(sfSObject);
        return sfSObjectDoc == null ? null : sfSObjectDoc.getCustomerNumber(sfSObject);
	}

	public static String getName(SObject sfSObject)
	{
        I_SFSObjectDoc sfSObjectDoc = loadSfsObjectDoc(sfSObject);
        return sfSObjectDoc == null ? '' : sfSObjectDoc.getName(sfSObject);
	}

    public static String getQuoteNumber(SObject sfSObject)
    {
        I_SFSObjectDoc sfSObjectDoc = loadSfsObjectDoc(sfSObject);
        return sfSObjectDoc == null ? '' : sfSObjectDoc.getQuoteNumber(sfSObject);
    }

    public static String getOrderNumber(SObject sfSObject)
    {
        I_SFSObjectDoc sfSObjectDoc = loadSfsObjectDoc(sfSObject);
        return sfSObjectDoc == null ? '' : sfSObjectDoc.getOrderNumber(sfSObject);
    }

    public static String getContractNumber(SObject sfSObject)
    {
        I_SFSObjectDoc sfSObjectDoc = loadSfsObjectDoc(sfSObject);
        return sfSObjectDoc == null ? '' : sfSObjectDoc.getContractNumber(sfSObject);
    }

    public static String getStatus(SObject sfSObject)
	{
        I_SFSObjectDoc sfSObjectDoc = loadSfsObjectDoc(sfSObject);
        return sfSObjectDoc == null ? null : sfSObjectDoc.getStatus(sfSObject);
	}

	public static String getOpportunityId(SObject sfSObject)
	{
        I_SFSObjectDoc sfSObjectDoc = loadSfsObjectDoc(sfSObject);
        return sfSObjectDoc == null ? null : sfSObjectDoc.getOpportunityId(sfSObject);
	}

    public static Opportunity getOpportunity(SObject sfSObject)
    {
        I_SFSObjectDoc sfSObjectDoc = loadSfsObjectDoc(sfSObject);
        return sfSObjectDoc == null ? null : sfSObjectDoc.getOpportunity(sfSObject);
    }

    public static Id getPriceBookId(SObject sfSObject)
    {
        I_SFSObjectDoc sfSObjectDoc = loadSfsObjectDoc(sfSObject);
        return sfSObjectDoc == null ? null : sfSObjectDoc.getPriceBookId(sfSObject);
    }
    public static Id getProductId(SObject sfSObject, SObject sfsObjectLine)
    {
        I_SFSObjectDoc sfSObjectDoc = loadSfsObjectDoc(sfSObject);
        return sfSObjectDoc == null ? null : sfSObjectDoc.getProductId(sfsObjectLine);
    }

    public static String getMaterial(SObject sfSObject, SObject sfsObjectLine)
    {
        I_SFSObjectDoc sfSObjectDoc = loadSfsObjectDoc(sfSObject);
        return sfSObjectDoc == null ? null : sfSObjectDoc.getMaterial(sfSObject, sfsObjectLine);
    }

    public static String getItemNumber(SObject sfSObject, SObject sfsObjectLine)
    {
        I_SFSObjectDoc sfSObjectDoc = loadSfsObjectDoc(sfSObject);
        return sfSObjectDoc == null ? '' : sfSObjectDoc.getItemNumber(sfsObjectLine);
    }

    public static Map<Id, String> loadProductSAPMaterialNumberList(SObject sfSObject)
    {
        Set<Id> productIdSet = new Set<Id>();
        List<SObject> sfsObjList = getSObjectLineItems(sfsObject).values();
        Integer objTot = sfsObjList.size();
        for (Integer objCnt = 0 ; objCnt < objTot ; objCnt++)
        {
            SObject sfsObjectLine = sfsObjList[objCnt];
            if (getProductId(sfSObject, sfsObjectLine) != null)
            {
                productIdSet.add(getProductId(sfSObject, sfsObjectLine));
            }
        }
        if (productIdSet.size() == 0) return new Map<Id, String>();

        return UTIL_SFProduct.getSAPMaterialNumbersFromProductList(productIdSet);
    }
    
    public static void validateSAPWithSfsObject(
        String calledFrom,
        SObject sfSObject)
    {
        I_SFSObjectDoc sfSObjectDoc = loadSfsObjectDoc(sfSObject);
        if (sfSObjectDoc != null)
        {
            sfSObjectDoc.validateSAPWithSfsObject(calledFrom, sfSObject);
        }
    }

    @testVisible
    public static void initializeQuoteFromSfSObject(
        String calledFrom, 
        SObject sfSObject, 
        SBO_EnosixQuote_Detail.EnosixQuote quoteDetail, 
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap,
        Map<String, UTIL_Quote.QuoteLineValue> quoteLineValueMap,
        Integer itemIncrement)
    {
        I_SFSObjectDoc sfSObjectDoc = loadSfsObjectDoc(sfSObject);
        if (sfSObjectDoc != null)
        {
            sfSObjectDoc.initializeQuoteFromSfSObject(calledFrom, sfSObject, quoteDetail, sfSObjectLineIdMap, quoteLineValueMap, itemIncrement);
        }
    }

    public static Boolean updateQuotePricingFromSfsObject(
        String calledFrom, 
        SObject sfSObject, 
        SBO_EnosixQuote_Detail.EnosixQuote quoteDetail, 
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap)
    {
        I_SFSObjectDoc sfSObjectDoc = loadSfsObjectDoc(sfSObject);
        if (sfSObjectDoc != null)
        {
            return sfSObjectDoc.updateQuotePricingFromSfsObject(calledFrom, sfSObject, quoteDetail, sfSObjectLineIdMap);
        }
        return false;
    }

    public static void finalizeQuoteAndUpdateSfsObject(
        String calledFrom, 
        SObject sfSObject, 
        SBO_EnosixQuote_Detail.EnosixQuote quoteDetail, 
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap,
        Id pricebookId,
        List<SBO_EnosixQuote_Detail.ITEMS> quoteItems,
        Map<string, Id> materialToProductIdMap,
        Map<Id, PricebookEntry> productToPricebookEntryMap)
    {
        I_SFSObjectDoc sfSObjectDoc = loadSfsObjectDoc(sfSObject);
        if (sfSObjectDoc != null)
        {
            sfSObjectDoc.finalizeQuoteAndUpdateSfsObject(calledFrom, sfSObject, quoteDetail, sfSObjectLineIdMap, pricebookId, 
                quoteItems, materialToProductIdMap, productToPricebookEntryMap);
        }
    }

    @testVisible
    public static void initializeOrderFromSfSObject(
        String calledFrom, 
        SObject sfSObject, 
        SBO_EnosixSO_Detail.EnosixSO orderDetail, 
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap,
        Map<String, UTIL_Order.OrderLineValue> orderLineValueMap,
        Integer itemIncrement)
    {
        I_SFSObjectDoc sfSObjectDoc = loadSfsObjectDoc(sfSObject);
        if (sfSObjectDoc != null)
        {
            sfSObjectDoc.initializeOrderFromSfSObject(calledFrom, sfSObject, orderDetail, sfSObjectLineIdMap, orderLineValueMap, itemIncrement);
        }
    }

    public static Boolean updateOrderPricingFromSfsObject(
        String calledFrom, 
        SObject sfSObject, 
        SBO_EnosixSO_Detail.EnosixSO orderDetail, 
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap)
    {
        I_SFSObjectDoc sfSObjectDoc = loadSfsObjectDoc(sfSObject);
        if (sfSObjectDoc != null)
        {
            return sfSObjectDoc.updateOrderPricingFromSfsObject(calledFrom, sfSObject, orderDetail, sfSObjectLineIdMap);
        }
        return false;
    }

    public static void finalizeOrderAndUpdateSfsObject(
        String calledFrom, 
        SObject sfSObject, 
        SBO_EnosixSO_Detail.EnosixSO orderDetail, 
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap,
        Id pricebookId,
        List<SBO_EnosixSO_Detail.ITEMS> orderItems,
        Map<string, Id> materialToProductIdMap,
        Map<Id, PricebookEntry> productToPricebookEntryMap)
    {
        I_SFSObjectDoc sfSObjectDoc = loadSfsObjectDoc(sfSObject);
        if (sfSObjectDoc != null)
        {
            sfSObjectDoc.finalizeOrderAndUpdateSfsObject(calledFrom, sfSObject, orderDetail, sfSObjectLineIdMap, pricebookId, 
                orderItems, materialToProductIdMap, productToPricebookEntryMap);
        }
    }

    public static DS_Document_Detail sObjectToSalesDocMapping(
        SObject sfSObject,
        List<SObject> sfLineItems,
        DS_Document_Detail salesDocDetail,
        DS_SalesDocAppSettings appSettings)
    {
        I_SFSObjectDoc sfSObjectDoc = loadSfsObjectDoc(sfSObject);
        if (sfSObjectDoc != null)
        {
            return sfSObjectDoc.sObjectToSalesDocMapping(sfSObject, sfLineItems, salesDocDetail, appSettings);
        }
        return null;
    }

    public static SObject salesDocMappingToSObject(
        SObject sfSObject, 
        DS_Document_Detail salesDocDetail, 
        String sapDocType)
    {
        I_SFSObjectDoc sfSObjectDoc = loadSfsObjectDoc(sfSObject);
        if (sfSObjectDoc != null)
        {
            return sfSObjectDoc.salesDocMappingToSObject(sfSObject, salesDocDetail, sapDocType);
        }
        return null;
    }

    public static SObject salesDocLineItemMappingToSObject(
        SObject sfSObject, 
        DS_Document_Detail.ITEMS item, 
        PricebookEntry materialEntry, 
        Id parentId, 
        SObject lineItem)
    {
        I_SFSObjectDoc sfSObjectDoc = loadSfsObjectDoc(sfSObject);
        if (sfSObjectDoc != null)
        {
            return sfSObjectDoc.salesDocLineItemMappingToSObject(sfSObject, item, materialEntry, parentId, lineItem);
        }
        return null;
    }
}