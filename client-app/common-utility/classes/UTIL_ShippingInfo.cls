/* utility class for Sales Area information */
// TODO: I think this class shouldn't exist. These methods could go in UTIL_Order, right?
public class UTIL_ShippingInfo
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_ShippingInfo.class);

    // getShippingMaster()
    //
    // Get the Shipping master from the RFC
    public static RFC_SD_GET_SHIP_INFO.RESULT getShippingMaster()
    {
        RFC_SD_GET_SHIP_INFO rfc = new RFC_SD_GET_SHIP_INFO();
        RFC_SD_GET_SHIP_INFO.RESULT result = rfc.execute();

        if (!result.isSuccess())
        {
            UTIL_ViewHelper.displayResultMessages(result.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
        }

        return result;
    }

    // filterShippingConditions()
    //
    // Filter the shipping conditions from the allowedShippingConditions
    public static List<RFC_SD_GET_SHIP_INFO.ET_SHIP_COND> filterShippingConditions(
        RFC_SD_GET_SHIP_INFO.RESULT shippingConditionMaster)
    {
        List<RFC_SD_GET_SHIP_INFO.ET_SHIP_COND> filteredList = new List<RFC_SD_GET_SHIP_INFO.ET_SHIP_COND>();

        if (null != shippingConditionMaster)
        {
            List<RFC_SD_GET_SHIP_INFO.ET_SHIP_COND> shipList = shippingConditionMaster.ET_SHIP_COND_List;
            Integer shipTot = shipList.size();
            for (Integer shipCnt = 0 ; shipCnt < shipTot ; shipCnt++)
            {
                RFC_SD_GET_SHIP_INFO.ET_SHIP_COND shippingCondition = shipList[shipCnt];
                if (allowedShippingConditions.contains(shippingCondition.ShippingConditions)
                    || allowedShippingConditions.contains('*'))
                {
                    filteredList.add(shippingCondition);
                }
            }
        }

        return filteredList;
    }

    @testVisible
    private static Set<String> allowedShippingConditions
    {
        get
        {
            return (Set<String>)UTIL_AppSettings.getSet(
                UTIL_AppSettings.EnterpriseApp, 'Order.AllowedShippingConditions', String.class, new Set<String>{'*'});
        }
    }

    public class ShippingConditionOptionBuilder extends UTIL_SelectOption.OptionBuilder
    {
        public override string getItemValue(object item)
        {
            return ((RFC_SD_GET_SHIP_INFO.ET_SHIP_COND)item).ShippingConditions;
        }

        public override string getItemLabel(object item)
        {
            return string.format('{0} - {1}', new string[]{getItemValue(item), getItemDescription(item)});
        }

        public override string getItemDescription(object item)
        {
            return ((RFC_SD_GET_SHIP_INFO.ET_SHIP_COND)item).VTEXT;
        }
    }
}