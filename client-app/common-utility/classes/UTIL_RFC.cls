public with sharing class UTIL_RFC
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_RFC.class);
    
    // getDocTypeMaster()
    //
    // Get the document type master from the RFC
    // Return the result    
    public static RFC_SD_GET_DOC_TYPE_VALUES.RESULT getDocTypeMaster()
    {
        RFC_SD_GET_DOC_TYPE_VALUES rfc = new RFC_SD_GET_DOC_TYPE_VALUES();
        RFC_SD_GET_DOC_TYPE_VALUES.RESULT result = rfc.execute();

        if (!result.isSuccess())
        {
            UTIL_ViewHelper.displayResultMessages(result.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO); 
        }

        return result;
    }
}