global with sharing class CTRL_enosiXExternalConfiguratorPlugin
{
    private static String defaultCustomerNumber = (String)UTIL_AppSettings.getValue(UTIL_AppSettings.CPQ, 'DefaultCustomerNumber', '');
    private static String defaultSalesDocType = (String)UTIL_AppSettings.getValue(UTIL_AppSettings.CPQ, 'DefaultSalesDocType', '');
    private static String defaultSalesOrg = (String)UTIL_AppSettings.getValue(UTIL_AppSettings.CPQ, 'DefaultSalesOrg', '');
    private static String defaultDistributionChannel = (String)UTIL_AppSettings.getValue(UTIL_AppSettings.CPQ, 'DefaultDistributionChannel', '');
    private static String defaultDivision = (String)UTIL_AppSettings.getValue(UTIL_AppSettings.CPQ, 'DefaultDivision', '');
    private static String defaultItemPlant = (String)UTIL_AppSettings.getValue(UTIL_AppSettings.CPQ, 'DefaultItemPlant', '');

    @RemoteAction
    global static String getInfo(Map<String,Object> params) {
        String quoteId = (String)params.get('quoteId');
        String productId = (String)params.get('productId');

        String soldToNumber;
        String shipToNumber;
        String salesDocType;
        String salesOrg;
        String salesDistChannel;
        String salesDivision;
        String quoteSAPConfiguration;
        if (String.isNotEmpty(quoteId)) {
            string selectCmd = 'SELECT Id, SAP_Configuration__c, FLD_Sold_To_Number__c, FLD_Ship_To_Number__c, ' + 
                ' FLD_Document_Type__c, FLD_Sales_Organization__c, FLD_Distribution_Channel__c, FLD_Division__c ' +
                ' FROM SBQQ__Quote__c WHERE Id = :quoteId';
            List<SBQQ__Quote__c> quotes = Database.query(selectCmd);

            if (quotes.size() == 1) {
                soldToNumber = quotes[0].FLD_Sold_To_Number__c;
                shipToNumber = quotes[0].FLD_Ship_To_Number__c;
                salesDocType = quotes[0].FLD_Document_Type__c;
                salesOrg = quotes[0].FLD_Sales_Organization__c;
                salesDistChannel = quotes[0].FLD_Distribution_Channel__c;
                salesDivision = quotes[0].FLD_Division__c;
                quoteSAPConfiguration = quotes[0].SAP_Configuration__c;
            }
        }

        if (String.isEmpty(soldToNumber)) soldToNumber = defaultCustomerNumber;
        if (String.isEmpty(shipToNumber)) shipToNumber = soldToNumber;
        if (String.isEmpty(salesDocType)) salesDocType = defaultSalesDocType;
        if (String.isEmpty(salesOrg)) salesOrg = defaultSalesOrg;
        if (String.isEmpty(salesDistChannel)) salesDistChannel = defaultDistributionChannel;
        if (String.isEmpty(salesDivision)) salesDivision = defaultDivision;
        if (String.isEmpty(quoteSAPConfiguration)) quoteSAPConfiguration = '{}';
        ENSX_Quote headConfig = (ENSX_Quote) JSON.deserialize(quoteSAPConfiguration,ENSX_Quote.class);
        headConfig.salesDocType = salesDocType;
        headConfig.salesOrg = salesOrg;
        headConfig.salesDistChannel = salesDistChannel;
        headConfig.salesDivision = salesDivision;
        headConfig.soldToParty = soldToNumber;
        headConfig.shipToParty = shipToNumber;
        quoteSAPConfiguration = JSON.serialize(headConfig);

        String productMaterial;
        if (String.isNotEmpty(productId)) {
            Product2 pdt = UTIL_SFProduct.getProductById(productId);
            productMaterial = UTIL_SFProduct.getMaterialNumberFromProduct(pdt);
        }

        Map<String, String> itemObj = new Map<String, String>();
        itemObj.put('plant', defaultItemPlant);
        String defaultItem = JSON.serialize(itemObj);

        return JSON.serialize(new Map<String,String> {
            'soldToNumber' => soldToNumber,
            'productMaterial' => productMaterial,
            'quoteSAPConfiguration' => quoteSAPConfiguration,
            'defaultItem' => defaultItem
        });
    }

    @RemoteAction
    global static void updateInfo(Map<String,Object> params) {
        String sessionData = (String)params.get('sessionData');
        String quoteId = (String)params.get('quoteId');

        closeSession(sessionData);
    }

    @RemoteAction
    global static void closeSession(String sessionData) {
        UTIL_VC_PricingAndConfiguration.closeSession(sessionData);
    }

    // declareDependencies is never called - it's purpose is for the compiler to raise the red flag when custom fields are missing
    @testVisible
    private void declareDependencies() {
        if(!Test.isRunningTest()) return;
        Object o = [SELECT SAP_Configuration__c FROM SBQQ__QuoteLine__c LIMIT 1];
    }
}