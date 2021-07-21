global with sharing class CTRL_SAP_Sales_Doc_Actions 
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_SAP_Sales_Doc_Actions.class);

    @AuraEnabled(cacheable=true)
    public static UTIL_Aura.Response getDetail(String docNum) 
    {
        logger.enterAura('getDetail', new Map<String, Object> {
            'docNum' => docNum
        });

        SBO_EnosixSalesDocument_Detail.EnosixSalesDocument responseData = null;
        try
        {
            SBO_EnosixSalesDocument_Detail sbo = new SBO_EnosixSalesDocument_Detail();
            responseData = sbo.getDetail(docNum);
        }
        catch (Exception ex)
        {
            UTIL_PageMessages.addExceptionMessage(ex);
        }
        finally
        {
            logger.exit();
        }

        return UTIL_Aura.createResponse(responseData);
    }

    @AuraEnabled
    public static UTIL_Aura.Response getButtons (
        Id SFRecordId, 
        String SAPDocNum, 
        String SAPDocType,
        Boolean allowBackToLinkedObject,
        Boolean allowBackToAccount,
        Boolean allowBackToOpportunity,
        Boolean allowClone,
        Boolean allowUpdate
    ) 
    {
        logger.enterAura('getButtons', new Map<String, Object> {
            'SFRecordId' => SFRecordId,
            'SAPDocNum' => SAPDocNum,
            'SAPDocType' => SAPDocType,
            'allowBackToLinkedObject' => allowBackToLinkedObject,
            'allowBackToAccount' => allowBackToAccount,
            'allowBackToOpportunity' => allowBackToOpportunity,
            'allowClone' => allowClone,
            'allowUpdate' => allowUpdate
        });

        SObject sfsObject = UTIL_SFSObjectDoc.initObjectsForSAP(SFRecordId, SAPDocNum, SAPDocType);        
        List<ButtonClass> buttonList = new List<ButtonClass>();
        Map <String, Object> pageReference = new Map<String, Object>();        
        Map <String, Object> attributes = new Map<String, Object>();
        String acctId;

        if (sfsObject != null) {
            String sObjectName = null;            
            pageReference.put('type', 'standard__recordPage');
            attributes.put('actionName', 'view');

            if (String.isNotEmpty(sfsObject.Id) && allowBackToLinkedObject != null && allowBackToLinkedObject)
            {
                Schema.SObjectType sobjectType = sfsObject.Id.getSObjectType();
                sObjectName = sobjectType.getDescribe().getName();
                String recordName = UTIL_SFSObjectDoc.getName(sfsObject);
                attributes.put('recordId', sfsObject.Id);
                attributes.put('objectApiName', sObjectName);
                pageReference.put('attributes', attributes);
                buttonList.add(new ButtonClass('LinkedRecord', 'Back to ' + recordName, null, JSON.serialize(pageReference)));
            }

            acctId = (String) UTIL_SFSObjectDoc.getAccountId(sfsObject);
            if (String.isNotEmpty(acctId) && sObjectName != 'Account' && allowBackToAccount != null && allowBackToAccount)
            {
                attributes.put('recordId', acctId);
                attributes.put('objectApiName', 'Account');
                pageReference.put('attributes', attributes);
                buttonList.add(new ButtonClass('Account', 'Back to Account', null, JSON.serialize(pageReference)));
            }

            String oppId = (String) UTIL_SFSObjectDoc.getOpportunityId(sfsObject);
            if (String.isNotEmpty(oppId) && sObjectName != 'Opportunity' && allowBackToOpportunity != null && allowBackToOpportunity)
            {
                attributes.put('recordId', oppId);
                attributes.put('objectApiName', 'Opportunity');
                pageReference.put('attributes', attributes);
                buttonList.add(new ButtonClass('Opportunity', 'Back to Opportunity', null, JSON.serialize(pageReference)));
            }
        }

        if (sfSobject == null) {
            sfSobject = UTIL_SFAccount.getAccountById(SFRecordId);
            if (sfSobject != null) acctId = sfSobject.Id;
        }

        attributes.clear();
        
        if (allowClone != null && allowClone)
        {
            buttonList.add(new ButtonClass('Clone', 'Clone ' + SAPDocType, SAPDocType, null));                  
        }

        if (allowUpdate != null && allowUpdate)
        {
            buttonList.add(new ButtonClass('Update', 'Update ' + SAPDocType, SAPDocType, null));                   
        }
        
        return UTIL_Aura.createResponse(buttonList);
    }

    global with sharing class ButtonClass 
    {
        @AuraEnabled global String Value { get; private set; }
        @AuraEnabled global String Label { get; private set; }
        @AuraEnabled global String SAPDocType { get; private set; }
        @AuraEnabled global String PageReference { get; private set; }

        global ButtonClass(
            String Value,
            String Label,
            String SAPDocType,
            String PageReference)
        {
            this.Value = Value;
            this.Label = Label;
            this.SAPDocType = SAPDocType;
            this.PageReference = PageReference;
        }
    }
}