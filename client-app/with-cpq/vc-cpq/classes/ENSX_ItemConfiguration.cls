global with sharing class ENSX_ItemConfiguration 
{
    public String materialNumber{get;set;}
    public String plant{get;set;}
    public String SalesDocumentCurrency { get; set;}
    public Decimal OrderQuantity { get; set;}
    public List<ENSX_Characteristic> selectedCharacteristics {get;set;}
}