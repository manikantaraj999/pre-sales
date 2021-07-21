global with sharing class ENSX_Quote
{
    public Object debug{get;set;}
    @AuraEnabled
    public List<ENSX_QuoteLine> LinkedQuoteLines{get;set;}
    @AuraEnabled        
    public String instanceUrl {get;set;}
    @AuraEnabled
    public String QuoteId{get;set;}
    @AuraEnabled
    public String salesOrg{get;set;}
    @AuraEnabled
    public String salesDistChannel{get;set;}
    @AuraEnabled
    public String salesDivision{get;set;}
    @AuraEnabled
    public String soldToParty{get;set;}
    @AuraEnabled
    public String shipToParty{get;set;}
    @AuraEnabled
    public String billToParty{get;set;}
    @AuraEnabled
    public String payerParty{get;set;}
    @AuraEnabled
    public String salesDocType{get;set;}
    public Map<String,Object> record {get;set;}
    public String recordJSON {get;set;}
}