public with sharing class CTRL_ContractDetail
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_ContractDetail.class);

    /// Gets the details of a specific sales doc in SAP
    /// @argument docNum -- SAP ID for the document.
    @AuraEnabled(cacheable=true)
    public static UTIL_Aura.Response getContractDetail(string docNum)
    {
        SBO_EnosixContract_Detail.EnosixContract responseData = null;

        logger.enterAura('getContractDetail', new Map<String, Object> {
            'docNum' => docNum
        });
        try
        {
            SBO_EnosixContract_Detail sbo = new SBO_EnosixContract_Detail();
            responseData = sbo.getDetail(docNum);
            UTIL_PageMessages.addFrameworkMessages(responseData.getMessages());
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

}