public class CTRL_GeneratePDF 
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_GeneratePDF.class);

    @AuraEnabled
    public static UTIL_Aura.Response getDocumentsList(String docNum, String messageType)
    {
        Object responseData = null;
        Object responsePagingOptions = null;

        logger.enterAura('getDocumentsList', new Map<String, Object> {
            'docNum' => docNum,
            'messageType' => messageType
        });

        try
        {
            SBO_EnosixSalesDocOutput_Search searchSBO = new SBO_EnosixSalesDocOutput_Search();
            SBO_EnosixSalesDocOutput_Search.EnosixSalesDocOutput_SC searchContext = CTRL_GeneratePDF.getDocSearchContext(docNum, messageType);
            searchContext = searchSBO.search(searchContext);
            responseData = searchContext.result.getResults();
            UTIL_PageMessages.addFrameworkMessages(searchContext.getMessages());
            responsePagingOptions = searchContext.pagingOptions;
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

    public static SBO_EnosixSalesDocOutput_Search.EnosixSalesDocOutput_SC getDocSearchContext(String docNum, String messageType)
    {
        SBO_EnosixSalesDocOutput_Search.EnosixSalesDocOutput_SC searchContext = new SBO_EnosixSalesDocOutput_Search.EnosixSalesDocOutput_SC();
        searchContext.SEARCHPARAMS.SalesDocument = docNum;
        searchContext.SEARCHPARAMS.OutputApplication = 'V1';
        if (String.isNotBlank(messageType))
        {
            SBO_EnosixSalesDocOutput_Search.OUTPUT_TYPE sboOutputType = new SBO_EnosixSalesDocOutput_Search.OUTPUT_TYPE();
            sboOutputType.ConditionType = messageType;
            sboOutputType.X_GetPDF = true;
            searchContext.OUTPUT_TYPE.add(sboOutputType);
        }
        return searchContext;
    }
}