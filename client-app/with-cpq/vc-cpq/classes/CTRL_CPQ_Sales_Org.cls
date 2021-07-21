public with sharing class CTRL_CPQ_Sales_Org
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_CPQ_Sales_Org.class);

    private static String defaultCustomerNumber = (String)UTIL_AppSettings.getValue(UTIL_AppSettings.CPQ, 'DefaultCustomerNumber', '');
    private static Set<String> genericSalesOrgs = (Set<String>)UTIL_AppSettings.getSet(UTIL_AppSettings.CPQ, 'GenericCustomerSalesOrgs', String.class, new Set<String>{''});
    private static List<String> salesOrgList = (List<String>)UTIL_AppSettings.getList(UTIL_AppSettings.CPQ, 'SalesOrgList', String.class, new List<String>());
    private static List<String> distributionChannelList = (List<String>)UTIL_AppSettings.getList(UTIL_AppSettings.CPQ, 'DistributionChannelList', String.class, new List<String>());
    private static List<String> divisionList = (List<String>)UTIL_AppSettings.getList(UTIL_AppSettings.CPQ, 'DivisionList', String.class, new List<String>());

    @AuraEnabled
    public static UTIL_Aura.Response getInfo(String quoteId) 
    {   
        Object responseData = null;
        logger.enterAura('getInfo', new Map<String, Object> {
            'quoteId' => quoteId
        });
        string selectCmd = 'SELECT Id, FLD_Sold_To_Number__c, FLD_Sales_Organization__c, ' +
            ' FLD_Distribution_Channel__c, FLD_Division__c ' +
            ' FROM SBQQ__Quote__c WHERE Id = :quoteId';
        List<SBQQ__Quote__c> resultList = Database.query(selectCmd);
        String soldToNumber = null;
        String salesOrg = null;
        String salesDistChannel = null;
        String salesDivision = null;
        if (resultList.size() > 0)
        {
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
        }

        return UTIL_Aura.createResponse(JSON.serialize(new Map<String,String> {
            'soldToNumber' => soldToNumber,
            'salesOrg' => salesOrg,
            'salesDistChannel' => salesDistChannel,
            'salesDivision' => salesDivision
        }));
    }

    @AuraEnabled
    public static UTIL_Aura.Response getSalesAreaList(String soldToNumber) 
    {   
        Object responseData = null;
        logger.enterAura('getSalesAreaList', new Map<String, Object> {
            'soldToNumber' => soldToNumber
        });
        try
        {   
            if(soldToNumber == null)
            {
                UTIL_PageMessages.addMessage(UTIL_PageMessages.ERROR, System.Label.LBL_CustomerNumber_Not_Found);
            }
            else
            {
                SBO_EnosixCustomer_Detail.EnosixCustomer cpqCustomer = UTIL_Customer.getCustomerByNumber(soldToNumber);
                if (cpqCustomer == null)
                {
                    UTIL_PageMessages.addMessage(UTIL_PageMessages.ERROR, System.Label.LBL_CPQ_Quote_ErrorNotLinked);
                }
                else
                {
                    List<SBO_EnosixCustomer_Detail.SALES_DATA> sdList = cpqCustomer.SALES_DATA.getAsList();
                    Integer sdTot = sdList.size();
                    Integer soTot = salesOrgList.size();
                    Integer dcTot = distributionChannelList.size();
                    Integer dTot = divisionList.size();
                    for (Integer sdCnt = 0 ; sdCnt < sdTot ; sdCnt++)
                    {
                        SBO_EnosixCustomer_Detail.SALES_DATA sd = sdList[sdCnt];
                        boolean isValid = true;
                        if (soTot > 0)
                        {
                            boolean isFound = false;
                            for (Integer soCnt = 0 ; soCnt < soTot ; soCnt++)
                            {
                                String so = salesOrgList[soCnt];
                                if (so == sd.SalesOrganization) isFound = true;
                            }
                            if (!isFound) isValid = false;
                        }
                        if (dcTot > 0 && isValid)
                        {
                            boolean isFound = false;
                            for (Integer dcCnt = 0 ; dcCnt < dcTot ; dcCnt++)
                            {
                                String dc = distributionChannelList[dcCnt];
                                if (dc == sd.DistributionChannel) isFound = true;
                            }
                            if (!isFound) isValid = false;
                        }
                        if (dTot > 0 && isValid)
                        {
                            boolean isFound = false;
                            for (Integer dCnt = 0 ; dCnt < dTot ; dCnt++)
                            {
                                String div = divisionList[dCnt];
                                if (div == sd.Division) isFound = true;
                            }
                            if (!isFound) isValid = false;
                        }
                        if (cpqCustomer.CustomerNumber == defaultCustomerNumber && isValid)
                        {
                            if (!genericSalesOrgs.contains(sd.SalesOrganization)) isValid = false;
                        }
                        if (!isValid) cpqCustomer.SALES_DATA.remove(sd);
                    }
                    if(cpqCustomer.SALES_DATA.size() == 0)
                    {
                        UTIL_PageMessages.addMessage(UTIL_PageMessages.ERROR, System.Label.LBL_CPQ_Quote_ErrorNoSalesOrgs);
                    }
                    responseData = cpqCustomer; 
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

        return UTIL_Aura.createResponse(responseData);
    }
    
    @AuraEnabled
    public static UTIL_Aura.Response updateInfo(Map<String,Object> params) 
    {   
        String quoteId = (String) params.get('quoteId');
        String salesOrg = (String) params.get('salesOrg');
        String salesDistChannel = (String) params.get('salesDistChannel');
        String salesDivision = (String) params.get('salesDivision');

        Boolean responseData = true;
        logger.enterAura('getInfo', new Map<String, Object> {
            'quoteId' => quoteId,
            'salesOrg' => salesOrg,
            'salesDistChannel' => salesDistChannel,
            'salesDivision' => salesDivision
        });
        try
        {
            SBQQ__Quote__c quote = new SBQQ__Quote__c();
            quote.Id = quoteId;
            quote.FLD_Sales_Organization__c = salesOrg;
            quote.FLD_Distribution_Channel__c = salesDistChannel;
            quote.FLD_Division__c = salesDivision;
            upsert quote;
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

        return UTIL_Aura.createResponse(responseData);
    }
}