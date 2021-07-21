public with sharing class CTRL_SAP_Doc_Validate {

    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_SAP_Doc_Validate.class);

    @AuraEnabled
    public static UTIL_Aura.Response init(String recordId, String sapType) {
        logger.enterAura('init', new Map<String, Object> {
            'recordId' => recordId,
            'sapType' => sapType
        });

        SObject sfsObject = UTIL_SFSObjectDoc.initObjectsForSAP(recordId, null, sapType);
        String docNumber = null;
        if (sapType == 'Order')
        {
            docNumber = UTIL_SFSObjectDoc.getOrderNumber(sfsObject);
        }
        else 
        {
            docNumber = UTIL_SFSObjectDoc.getQuoteNumber(sfsObject);
        }

        if (String.isEmpty(docNumber))
        {
            UTIL_SFSObjectDoc.validateSAPWithSfsObject('CTRL_SAP_Doc_Validate', sfsObject);
        }
        return UTIL_Aura.createResponse(UTIL_PageMessages.messageList.size() == 0);
    }
}