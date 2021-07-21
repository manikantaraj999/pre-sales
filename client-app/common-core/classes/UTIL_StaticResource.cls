public class UTIL_StaticResource
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_StaticResource.class);

    // getStringResourceContents()
    //
    // Returns the resource body as a string, or null if the resource isn't found
    public static String getStringResourceContents(String resource)
    {
        String result = null;

        List<StaticResource> resources = [
            SELECT Body FROM StaticResource
            WHERE Name = :resource LIMIT 1
        ];

        if (resources.size() > 0)
        {
            result = resources.get(0).Body.toString();            
        }

        return result;
    }
}