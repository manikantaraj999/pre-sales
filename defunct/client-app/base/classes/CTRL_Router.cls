// Class acts as a redirect based on query string value ENSX_Page (UTIL_PageState.ensxPageRoute)
// - A map of pageKeys to URLs exists in UTIL_PageFlow and can be overridden in appSettings

public with sharing class CTRL_Router
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_Router.class);

    public PageReference actionRoute()
    {
        String pageKey = UTIL_PageState.current.ensxPageRoute;
        UTIL_PageState.current.ensxPageRoute = null;
        PageReference destination = UTIL_PageFlow.redirectTo(pageKey, UTIL_PageState.current);
        System.debug(destination);
        return destination;
    }
}