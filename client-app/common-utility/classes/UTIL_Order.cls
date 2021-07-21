public with sharing class UTIL_Order
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_Order.class);

    public static Map<String, Set<String>> allowedItemCategoriesByOrderType
    {
        get
        {
            return (Map<String, Set<String>>)UTIL_AppSettings.getMap(
                UTIL_AppSettings.EnterpriseApp,
                'Order.AllowedItemCategoriesByOrderType',
                String.class,
                Set<String>.class,
                new Map<String, Set<String>>()
            );
        }
    }
}