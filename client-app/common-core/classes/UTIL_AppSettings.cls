// UTIL_AppSettings - Class to manage customer configuration settings
//
// To override system defaults, add an AppSettings.json file in the root folder
// of the customer child project
public virtual class UTIL_AppSettings
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_AppSettings.class);

    public static final string Prefix = 'SR_enosix';
    public static final string Suffix = 'Settings';
    public static final string EnterpriseApp = 'EnterpriseApp';
    public static final string VC = 'VC';
    public static final string CPQ = 'CPQ';
    public static final string CustomerSyncBatch = 'CustomerSyncBatch';
    public static final string MaterialSyncBatch = 'MaterialSyncBatch';
    public static final string ContactSyncBatch = 'ContactSyncBatch';
    public static final string InvoiceSyncBatch = 'InvoiceSyncBatch';
    public static final string OrderSyncBatch = 'OrderSyncBatch';
    public static final string QuoteSyncBatch = 'QuoteSyncBatch';

    // getValue()
    //
    // Get a setting by key, with a default value in case the setting was never set
    //
    // Use this for primitive settings like Integer, Decimal, String, Boolean
    // If you have a complex type like a list, use getList(), getSet(), or getMap()
    //
    // You need to cast the output to the expected type.
    // Example:
    //      String testString = (String)UTIL_AppSettings.getValue(UTIL_AppSettings.EnterpriseApp, 's', 'not set');
    public static Object getValue(String resourceName, String key, Object defaultValue)
    {
        return getTypedValue(resourceName, key, Object.class, defaultValue);
    }

    // getValue()
    //
    // Get primitive setting with a default of null
    public static Object getValue(String resourceName, String key)
    {
        return getValue(resourceName, key, null);
    }


    // getList()
    //
    // Get a list setting by key with the given list type and default value
    //
    // Example:
    //    List<Boolean> bools =
    //        (List<Boolean>)UTIL_AppSettings.getList(UTIL_AppSettings.EnterpriseApp, 'bools', Boolean.class, new Boolean[]);
    public static Object getList(String resourceName, String key, Type itemType, Object defaultValue)
    {
        Type collectionType = Type.forName('List<' + itemType.getName() + '>');
        return getTypedValue(resourceName, key, collectionType, defaultValue);
    }

    // getList()
    //
    // Get a list setting with default of null
    public static Object getList(String resourceName, String key, Type itemType)
    {
        return getList(resourceName, key, itemType, null);
    }


    // getSet()
    //
    // Get a set setting by key with the given set type and default value
    //
    // Example:
    //    Set<String> stringSet =
    //        (Set<String>)UTIL_AppSettings.getList(UTIL_AppSettings.EnterpriseApp, 'strings', String.class, new String[]);
    public static Object getSet(String resourceName, String key, Type itemType, Object defaultValue)
    {
        Type collectionType = Type.forName('Set<' + itemType.getName() + '>');
        return getTypedValue(resourceName, key, collectionType, defaultValue);
    }

    // getSet()
    //
    // Get a set setting with default of null
    public static Object getSet(String resourceName, String key, Type itemType)
    {
        return getSet(resourceName, key, itemType, null);
    }


    // getMap()
    //
    // Get a map settings by key with the given key and item types and a default value
    //
    // Example:
    //     Map<String, Boolean> defaultBools = new Map<String, Boolean>{
    //        'b1' => true,
    //        'b2' => false
    //     };
    //     Map<String, Boolean> namedBools = (Map<String, Boolean>)UTIL_AppSettings.getMap(
    //         UTIL_AppSettings.EnterpriseApp, 'namedBools', String.class, Boolean.class, defaultBools)
    public static Object getMap(String resourceName, String key, Type keyType, Type itemType, Object defaultValue)
    {
        Type collectionType = Type.forName('Map<' + keyType.getName() + ',' + itemType.getName() + '>');
        return getTypedValue(resourceName, key, collectionType, defaultValue);
    }

    // getMap()
    //
    // Get a map setting with default of null
    public static Object getMap(String resourceName, String key, Type keyType, Type itemType)
    {
        return UTIL_AppSettings.getMap(resourceName, key, keyType, itemType, null);
    }


    // getSObject()
    //
    // Get an sObject setting by key with the given type and default value
    //
    // Example:
    //     Account acc =
    //         (Account)UTIL_AppSettings.getSObject(UTIL_AppSettings.EnterpriseApp, 'account', Account.type, new Account());
    public static Object getSObject(String resourceName, String key, Type outputType, Object defaultValue)
    {
        return getTypedValue(resourceName, key, outputType, defaultValue);
    }

    // getSObject()
    //
    // Get an sObject setting with default of null
    public static Object getSObject(String resourceName, String key, Type outputType)
    {
        return getSObject(resourceName, key, outputType, null);
    }


    @testVisible
    private static Map<String, Map<String, Object>> settingsMap = new Map<String, Map<String, Object>>();

    @testVisible
    private static Map<String, Map<String, Boolean>> hasBeenRetypedMap = new Map<String, Map<String, Boolean>>();

    // getTypedValue()
    //
    // Underlying implementation of getValue(), getList(), getSet(), and getMap()
    // Returns setting for key with the given default converted to the desired outputType
    private static Object getTypedValue(String resourceName, String key, Type outputType, Object defaultValue)
    {
        resourceName = Prefix + resourceName + Suffix;
        if (!settingsMap.containsKey(resourceName))
        {
            String resourceJson = UTIL_StaticResource.getStringResourceContents(resourceName);
            if (null == resourceJson) resourceJson = '{}';

            settingsMap.put(resourceName, (Map<String, Object>)JSON.deserializeUntyped(resourceJson));
        }
        Object result = defaultValue;
        Map<String, Object> settings = settingsMap.get(resourceName);
        if (settings.containsKey(key))
        {
            result = settings.get(key);

            // If the object in the map is too generic, re-type it
            // More explicitly -
            // if
            //   result has a value
            // AND
            //   The desired output type is not Object (no need to re-type)
            // AND
            //   The map item hasn't been re-typed already
            Map<String, Boolean> hasBeenRetyped = hasBeenRetypedMap.get(resourceName);
            if (hasBeenRetyped == null) hasBeenRetyped = new Map<String, Boolean>();
            if (result != null && Object.class != outputType && true != hasBeenRetyped.get(key))
            {
                result = retype(resourceName, settings, key, result, outputType);
                settingsMap.put(resourceName, settings);
            }
        }
        return result;
    }

    // retype()
    //
    // Up-converts the given value/collection to the outputType, and stores it back into the
    // settings map.
    //
    // This is needed because the JSON.deserialize() method will bring in lists or other collections
    // from the JSON file as List<Object> when we will typically want List<String> or something
    // else specific, and you cannot just cast List<Object> to List<String>
    private static Object retype(String resourceName, Map<String, Object> settings, String key, Object value, Type outputType)
    {
        // Let the built-in Apex deserialize() do the hard conversion work for us
        String temp = JSON.serialize(value);
        Object result = JSON.deserialize(temp, outputType);

        // Put it back in the map so we don't have to re-do this later
        settings.put(key, result);
        Map<String, Boolean> hasBeenRetyped = hasBeenRetypedMap.get(resourceName);
        if (hasBeenRetyped == null) hasBeenRetyped = new Map<String, Boolean>();
        hasBeenRetyped.put(key, true);
        hasBeenRetypedMap.put(resourceName, hasBeenRetyped);

        return result;
    }
}