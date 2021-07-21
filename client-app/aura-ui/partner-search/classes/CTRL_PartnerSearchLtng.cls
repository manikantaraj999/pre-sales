public class CTRL_PartnerSearchLtng
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_PartnerSearchLtng.class);

    @AuraEnabled
    public static UTIL_Aura.Response searchPartners(
        String customerNumber, String partnerFunction, String salesOrg, String distChannel, String division, Map<String, Object> pagingOptions)
    {
        logger.enterAura('searchPartners', new Map<String, Object>{
            'customerNumber' => customerNumber,
            'partnerFunction' => partnerFunction,
            'salesOrg' => salesOrg,
            'distChannel' => distChannel,
            'division' => division,
            'paginOptions' => pagingOptions
        });

        SBO_SFCIPartner_Search sbo = new SBO_SFCIPartner_Search();
        String results = '';
        Object responsePagingOptions = null; 

        try
        {
            SBO_SFCIPartner_Search.SFCIPartner_SC searchContext = new SBO_SFCIPartner_Search.SFCIPartner_SC();
            searchContext.SEARCHPARAMS.CustomerNumber = customerNumber;
            searchContext.SEARCHPARAMS.PartnerFunction = partnerFunction;
            searchContext.SEARCHPARAMS.SalesOrganization = salesOrg;
            searchContext.SEARCHPARAMS.DistributionChannel = distChannel;
            searchContext.SEARCHPARAMS.Division = division;
            UTIL_Aura.setSearchContextPagingOptions(searchContext, pagingOptions);

            sbo.search(searchContext);
            List<SBO_SFCIPartner_Search.SEARCHRESULT> searchResults = searchContext.result.getResults();
            if (searchResults.size() > 0) results = JSON.serialize(searchResults);  
            responsePagingOptions = searchContext.pagingOptions;                   
        }        
        catch (Exception ex)
        {
            UTIL_PageMessages.addExceptionMessage(ex);
        }

        return UTIL_Aura.createResponse(results, responsePagingOptions);        
    }
}