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
    String getInquiryNumber(SObject sfSObject);
    String getCreditMemoNumber(SObject sfSObject);
    String getDebitMemoNumber(SObject sfSObject);
    String getReturnOrderNumber(SObject sfSObject);
    String getStatus(SObject sfSObject);
    String getOpportunityId(SObject sfSObject);    
    Id getPriceBookId(SObject sfSObject);
    Id getProductId(SObject sfsObjectLine);
    String getMaterial(SObject sfSObject, SObject sfsObjectLine);
    String getItemNumber(SObject sfsObjectLine);
    void validateSAPWithSfsObject(
        String calledFrom,
        SObject sfSObject);
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
