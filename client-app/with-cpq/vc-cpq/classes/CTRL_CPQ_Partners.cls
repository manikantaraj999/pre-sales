public with sharing class CTRL_CPQ_Partners
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_CPQ_Partners.class);

    @AuraEnabled
    public static UTIL_Aura.Response getPartnerList(
            String quoteId, 
            String partnerField
        )
    {   
        String partnerLabel = 'NA';
        String currentPartnerNumber = null;
        List <SBO_SFCIPartner_Search.SEARCHRESULT> responseData = null;

        logger.enterAura('getPartnerList', new Map<String, Object> {
            'quoteId' => quoteId,
            'partnerField' => partnerField
        });

        string selectCmd = 'SELECT Id, FLD_Sold_To_Number__c, FLD_Ship_To_Number__c, FLD_Bill_To_Number__c, ' +
            ' FLD_Payer_Number__c, FLD_Sales_Organization__c, FLD_Distribution_Channel__c, FLD_Division__c ' +
            ' FROM SBQQ__Quote__c WHERE Id = :quoteId';
        List<SBQQ__Quote__c> resultList = Database.query(selectCmd);
        if (resultList.size() == 0)
        {
            UTIL_PageMessages.addMessage(UTIL_PageMessages.ERROR, System.Label.LBL_No_Quote_Found + ' ' + quoteId);
        }
        else
        {
            String soldToNumber = null;
            String salesOrg = null;
            String salesDistChannel = null;
            String salesDivision = null;
            soldToNumber = (String) resultList[0].FLD_Sold_To_Number__c;
            salesOrg = String.isEmpty(resultList[0].FLD_Sales_Organization__c) ? 
                (String)UTIL_AppSettings.getValue(UTIL_AppSettings.CPQ, 'DefaultSalesOrg', '') :
                resultList[0].FLD_Sales_Organization__c;
            salesDistChannel = String.isEmpty(resultList[0].FLD_Distribution_Channel__c) ? 
                (String)UTIL_AppSettings.getValue(UTIL_AppSettings.CPQ, 'DefaultDistributionChannel', '') :
                resultList[0].FLD_Distribution_Channel__c;
            salesDivision = String.isEmpty(resultList[0].FLD_Division__c) ? 
                (String)UTIL_AppSettings.getValue(UTIL_AppSettings.CPQ, 'DefaultDivision', '') :
                resultList[0].FLD_Division__c;

            if (soldToNumber == null)
            {
                UTIL_PageMessages.addMessage(UTIL_PageMessages.ERROR, System.Label.LBL_Account_Sold_To_Blank);
            }
            else
            {
                String partnerFunction = null;
                if (partnerField == 'soldToParty')
                {
                    partnerFunction = UTIL_Customer.SOLD_TO_PARTNER_CODE;
                    partnerLabel = System.Label.LBL_CPQ_Quote_SoldToParty;
                    currentPartnerNumber = (String) resultList[0].FLD_Sold_To_Number__c;
                } 
                else if (partnerField == 'shipToParty')
                {
                    partnerFunction = UTIL_Customer.SHIP_TO_PARTNER_CODE;
                    partnerLabel = System.Label.LBL_CPQ_Quote_ShipToParty;
                    currentPartnerNumber = (String) resultList[0].FLD_Ship_To_Number__c;
                }
                else if (partnerField == 'billToParty')
                {
                    partnerFunction = UTIL_Customer.BILL_TO_PARTNER_CODE;
                    partnerLabel = System.Label.LBL_CPQ_Quote_BillToParty;
                    currentPartnerNumber = (String) resultList[0].FLD_Bill_To_Number__c;
                }
                else if (partnerField == 'payerParty')
                {
                    partnerFunction = UTIL_Customer.PAYER_PARTNER_CODE;
                    partnerLabel = System.Label.LBL_CPQ_Quote_PayerParty;
                    currentPartnerNumber = (String) resultList[0].FLD_Payer_Number__c;
                }

                if (partnerFunction == null)
                {
                    UTIL_PageMessages.addMessage(UTIL_PageMessages.ERROR, System.Label.LBL_PartnerFunction_Not_Found);
                }
                else
                {
                    SBO_SFCIPartner_Search sbo = new SBO_SFCIPartner_Search();
                    SBO_SFCIPartner_Search.SFCIPartner_SC sc = new SBO_SFCIPartner_Search.SFCIPartner_SC();
                    try
                    {  
                        SBO_EnosixCustomer_Detail.EnosixCustomer cpqCustomer = UTIL_Customer.getCustomerByNumber(soldToNumber);
                        if (cpqCustomer == null)
                        {
                            UTIL_PageMessages.addMessage(UTIL_PageMessages.ERROR, System.Label.LBL_CPQ_Quote_ErrorNotLinked);
                        }
                        else
                        {
                            sc.SEARCHPARAMS.CustomerNumber = soldToNumber;
                            sc.SEARCHPARAMS.PartnerFunction = partnerFunction;
                            sc.SEARCHPARAMS.SalesOrganization = salesOrg;
                            sc.SEARCHPARAMS.DistributionChannel = salesDistChannel;
                            sc.SEARCHPARAMS.Division = salesDivision;
                            sbo.search(sc);
                            responseData = sc.result.getResults();
                            
                            if(responseData.size() == 0)
                            {
                                UTIL_PageMessages.addMessage(UTIL_PageMessages.ERROR, System.Label.LBL_CPQ_Quote_ErrorNoPartners);
                            }
                        }
                    }
                    catch(Exception ex)
                    {
                        UTIL_PageMessages.addExceptionMessage(ex);
                    }
                    finally
                    {
                        logger.exit();
                    }
                }
            }
        }
        return UTIL_Aura.createResponse(JSON.serialize(new Map<String,String> {
                'results' => JSON.serialize(responseData),
                'partnerLabel' => partnerLabel,
                'currentPartnerNumber' => currentPartnerNumber
            }));
    }

    @AuraEnabled
    public static UTIL_Aura.Response updatePartner(Map<String,Object> params)
    {   
        String quoteId = (String) params.get('quoteId');
        String partnerField = (String) params.get('partnerField');
        String partnerJSON = (String) params.get('partnerJSON');

        Boolean responseData = true;
        logger.enterAura('updatePartner', new Map<String, Object> {
            'quoteId' => quoteId,
            'partnerField' => partnerField,
            'partnerJSON' => partnerJSON
        });

        if (String.isNotBlank(quoteId)) 
        {
            try
            {
                Map<String, Object> partnerInfo = (Map<String, Object>) JSON.deserializeUntyped(partnerJSON);

                Boolean isNeedUpdate = false;
                SBQQ__Quote__c quote = new SBQQ__Quote__c();
                quote.Id = quoteId;
                if (partnerField == 'shipToParty')
                {
                    isNeedUpdate = true;
                    // quote.FLD_Ship_To_Number__c = (String) partnerInfo.get('partnerNumber');
                    quote.SBQQ__ShippingName__c = (String) partnerInfo.get('name');
                    quote.SBQQ__ShippingStreet__c = (String) partnerInfo.get('street');
                    quote.SBQQ__ShippingCity__c = (String) partnerInfo.get('city');
                    quote.SBQQ__ShippingState__c = (String) partnerInfo.get('region');
                    quote.SBQQ__ShippingPostalCode__c = (String) partnerInfo.get('postalCode');
                    quote.SBQQ__ShippingCountry__c = (String) partnerInfo.get('country');
                }
                else if (partnerField == 'billToParty')
                {
                    isNeedUpdate = true;
                    // quote.FLD_Bill_To_Number__c = (String) partnerInfo.get('partnerNumber');
                    quote.SBQQ__BillingName__c = (String) partnerInfo.get('name');
                    quote.SBQQ__BillingStreet__c = (String) partnerInfo.get('street');
                    quote.SBQQ__BillingCity__c = (String) partnerInfo.get('city');
                    quote.SBQQ__BillingState__c = (String) partnerInfo.get('region');
                    quote.SBQQ__BillingPostalCode__c = (String) partnerInfo.get('postalCode');
                    quote.SBQQ__BillingCountry__c = (String) partnerInfo.get('country');
                }
                else if (partnerField == 'payerParty')
                {
                    isNeedUpdate = true;
                    // quote.FLD_Payer_Number__c = (String) partnerInfo.get('partnerNumber');
                }

                if (isNeedUpdate) 
                {
                    update quote;
                }
            }
            catch (Exception ex)
            {
                UTIL_PageMessages.addExceptionMessage(ex);
                responseData = false;
            }
            finally
            {
                logger.exit();
            }
        }

        return UTIL_Aura.createResponse(responseData);
    }
}