public class UTIL_Error
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_Error.class);

    public static void displayResultErrors(ensxsdk.EnosixFramework.Result result)
    {
        if (null == result) return;

        if (!result.isSuccess())
        {
            UTIL_ViewHelper.displayResultMessages(result.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
        }
    }
}