public with sharing class UTIL_SFSObjectDoc
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_SFSObjectDoc.class);

    public static final String STATUS_CREATE = 'Create';

    // Indexed by sObject type name
    private static Map<String,Object> sfSObjectDocMap = new Map<String,Object>();

    private static String loadedSObjectName;

    @testVisible
    public static SObject sfsObject { get; private set; }

    @testVisible
    private static I_SFSObjectDoc loadSfsObjectDoc(SObject sfSObject)
    {
        if (sfSObject == null) return null;
        return loadSfsObjectDoc(sfSObject.getSObjectType().getDescribe().getName());
    }

    @testVisible
    private static I_SFSObjectDoc loadSfsObjectDoc(Id sfSObjectId)
    {
        system.debug('sobject id'+sfSObjectId);//
        if (sfSObjectId == null) return null;
        return loadSfsObjectDoc(sfSObjectId.getSObjectType().getDescribe().getName());
    }

    @testVisible
    private static I_SFSObjectDoc loadSfsObjectDoc(String sObjectTypeName)
    {
        system.debug('sobject id'+sObjectTypeName);//
        if (String.isEmpty(sObjectTypeName)) return null;
        Object sfSObjectDoc = sfSObjectDocMap.get(sObjectTypeName);
        if (sfSObjectDoc == null)
        {
            String clsName = (String)UTIL_AppSettings.getValue(
                UTIL_AppSettings.EnterpriseApp, 
                'UTIL_SFSObjectDoc.' + sObjectTypeName,
                'UTIL_SF' + sObjectTypeName
            );
            Type sfsObjectDocType = Type.forName(clsName);
            if (sfsObjectDocType != null) {
                system.debug('sobject !null'+sfsObjectDocType);//
                sfSObjectDoc = sfsObjectDocType.newInstance();
                if (sfSObjectDoc instanceof I_SFSObjectDoc) {
                    sfSObjectDocMap.put(sObjectTypeName, sfSObjectDoc);
                }
                system.debug('sobject typename'+sfsObjectDocType);//
            }
        }
        
        return (I_SFSObjectDoc) sfSObjectDoc;
    }

    static List<String> SFSObjectNameList = new List<String> {
        'Opportunity', 'Quote', 'Order', 'Case', 'SBQQ__Quote__c','SalesAgreement'
    };

	public static SObject initObjectsForSAP(String SFRecordId, String SAPDocNum, String SAPDocType)
	{
        sfsObject = null;
        if (SFRecordId != null && String.isNotEmpty(SFRecordId))
        {
            sfSObject = UTIL_SFSObjectDoc.getSObject(SFRecordId);
        }
        if (sfSObject == null)
        {
            Integer nameTot = SFSObjectNameList.size();
            for (Integer nameCnt = 0 ; nameCnt < nameTot ; nameCnt++)
            {
                String sfsObjectName = SFSObjectNameList[nameCnt];
                sfSObject = UTIL_SFSObjectDoc.getSObject(sfsObjectName, SAPDocType, SAPDocNum);
                if (null != sfSObject) break;
            }
        }
        return sfsObject;
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
        system.debug('result'+result);
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
        system.debug('sfSObjectDoc'+sfSObjectDoc + sfSObject);
        return sfSObjectDoc == null ? new Map<Id, SObject>() : sfSObjectDoc.getSObjectLineItems(sfSObject.Id);
	}
    
    public static Map<Id, SObject> getobj(SObject sfSObject)
	{
        system.debug('***before sfSObject'+ sfSObject);
        I_SFSObjectDoc sfSObjectDoc = loadSfsObjectDoc(sfSObject);
        system.debug('sfSObjectDoc'+sfSObjectDoc + sfSObject);
        return null ;
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

    public static String getInquiryNumber(SObject sfSObject)
    {
        I_SFSObjectDoc sfSObjectDoc = loadSfsObjectDoc(sfSObject);
        return sfSObjectDoc == null ? '' : sfSObjectDoc.getInquiryNumber(sfSObject);
    }

    public static String getCreditMemoNumber(SObject sfSObject)
    {
        I_SFSObjectDoc sfSObjectDoc = loadSfsObjectDoc(sfSObject);
        return sfSObjectDoc == null ? '' : sfSObjectDoc.getCreditMemoNumber(sfSObject);
    }

    public static String getDebitMemoNumber(SObject sfSObject)
    {
        I_SFSObjectDoc sfSObjectDoc = loadSfsObjectDoc(sfSObject);
        return sfSObjectDoc == null ? '' : sfSObjectDoc.getDebitMemoNumber(sfSObject);
    }

    public static String getReturnOrderNumber(SObject sfSObject)
    {
        I_SFSObjectDoc sfSObjectDoc = loadSfsObjectDoc(sfSObject);
        return sfSObjectDoc == null ? '' : sfSObjectDoc.getReturnOrderNumber(sfSObject);
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