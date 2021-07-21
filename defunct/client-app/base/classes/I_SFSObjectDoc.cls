// I_SFSObjectDoc
//
// This interface is implemented by SalesForce Objects which are used to create
// SAP Documents with items such as Quote and Order
public interface I_SFSObjectDoc
{
	SObject getSObject(String id);
	SObject getSObject(String sapType, String sapDocNum);
  	Map<Id, SObject> getSObjectLineItems(String id);
    Map<Id, SObject> getSObjectContacts(String id);
    String getAccountId(SObject sfSObject);
    String getCustomerNumber(SObject sfSObject);
    String getName(SObject sfSObject);
    String getQuoteNumber(SObject sfSObject);
    String getOrderNumber(SObject sfSObject);
    String getContractNumber(SObject sfSObject);
    String getStatus(SObject sfSObject);
    String getOpportunityId(SObject sfSObject);    
    Opportunity getOpportunity(SObject sfSObject);
    Id getPriceBookId(SObject sfSObject);
    Id getProductId(SObject sfsObjectLine);
    String getMaterial(SObject sfSObject, SObject sfsObjectLine);
    String getItemNumber(SObject sfsObjectLine);
    void validateSAPWithSfsObject(
        String calledFrom,
        SObject sfSObject);
    void initializeQuoteFromSfSObject(
        String calledFrom, 
        SObject sfSObject, 
        SBO_EnosixQuote_Detail.EnosixQuote quoteDetail, 
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap,
        Map<String, UTIL_Quote.QuoteLineValue> quoteLineValueMap,
        Integer itemIncrement);
    Boolean updateQuotePricingFromSfsObject(
        String calledFrom, 
        SObject sfSObject, 
        SBO_EnosixQuote_Detail.EnosixQuote orderDetail, 
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap);
    void finalizeQuoteAndUpdateSfsObject(
        String calledFrom, 
        SObject sfSObject, 
        SBO_EnosixQuote_Detail.EnosixQuote quoteDetail, 
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap, 
        Id pricebookId,
        List<SBO_EnosixQuote_Detail.ITEMS> quoteItems,
        Map<string, Id> materialToProductIdMap,
        Map<Id, PricebookEntry> productToPricebookEntryMap);
    void initializeOrderFromSfSObject(
        String calledFrom, 
        SObject sfSObject, 
        SBO_EnosixSO_Detail.EnosixSO orderDetail, 
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap,
        Map<String, UTIL_Order.OrderLineValue> orderLineValueMap,
        Integer itemIncrement);
    Boolean updateOrderPricingFromSfsObject(
        String calledFrom, 
        SObject sfSObject, 
        SBO_EnosixSO_Detail.EnosixSO orderDetail, 
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap);
    void finalizeOrderAndUpdateSfsObject(
        String calledFrom, 
        SObject sfSObject, 
        SBO_EnosixSO_Detail.EnosixSO orderDetail, 
        Map<String, UTIL_SFSObjectDoc.SfSObjectItem> sfSObjectLineIdMap, 
        Id pricebookId,
        List<SBO_EnosixSO_Detail.ITEMS> orderItems, 
        Map<string, Id> materialToProductIdMap,
        Map<Id, PricebookEntry> productToPricebookEntryMap);

    DS_Document_Detail sObjectToSalesDocMapping(
        SObject sfSObject,
        List<SObject> sfLineItems,
        DS_Document_Detail salesDocDetail,
        DS_SalesDocAppSettings appSettings);
    SObject salesDocMappingToSObject(
        SObject sfSObject, 
        DS_Document_Detail salesDocDetail, 
        String sapDocType);
    SObject salesDocLineItemMappingToSObject(
        SObject sfSObject,
        DS_Document_Detail.ITEMS item, 
        PricebookEntry materialEntry, 
        Id parentId, 
        SObject lineItem);
}
