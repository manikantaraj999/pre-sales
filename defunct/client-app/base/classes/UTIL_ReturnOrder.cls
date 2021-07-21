public with sharing class UTIL_ReturnOrder
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_ReturnOrder.class);

    // getReturnOrderForId()
    //
    // Return the detail of return order from the given Id
    public static SBO_EnosixRO_Detail.EnosixRO getReturnOrderForId(string id)
    {
        SBO_EnosixRO_Detail ro = new SBO_EnosixRO_Detail();
        SBO_EnosixRO_Detail.EnosixRO result =  ro.getDetail(id);
        if (!result.isSuccess())
        {
            UTIL_ViewHelper.displayResultMessages(result.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
        }
        return result;
    }

    // getPartnerFromReturnOrder
    //
    // Return the partner from the given return order detail
    public static SBO_EnosixRO_Detail.PARTNERS getPartnerFromReturnOrder(SBO_EnosixRO_Detail.EnosixRO returnOrder, string function, boolean create)
    {
        SBO_EnosixRO_Detail.PARTNERS result = null;
        list<SBO_EnosixRO_Detail.PARTNERS> partners = new list<SBO_EnosixRO_Detail.PARTNERS>();

        if (returnOrder.PARTNERS != null)
        {
            returnOrder.PARTNERS.copyTo(partners);

            Integer partnerTot = partners.size();
            for (Integer partnerCnt = 0 ; partnerCnt < partnerTot ; partnerCnt++)
            {
                SBO_EnosixRO_Detail.PARTNERS partner = partners[partnerCnt];
                if (function == partner.PartnerFunction)
                {
                    result = partner;
                    break;
                }
            }
        }

        if (null == result && create)
        {
            result = new SBO_EnosixRO_Detail.PARTNERS();
            result.PartnerFunction = function;
            returnOrder.PARTNERS.add(result);
        }

        return result;
    }
}