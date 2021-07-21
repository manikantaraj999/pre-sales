public with sharing class UTIL_Customer
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_Customer.class);

    public static final string SOLD_TO_PARTNER_CODE = 'SP';
    public static final string SHIP_TO_PARTNER_CODE = 'SH';
    public static final string CARRIER_PARTNER_CODE = 'CR';
    public static final string PAYER_PARTNER_CODE = 'PY';
    public static final string BILL_TO_PARTNER_CODE = 'BP';

    public static SBO_EnosixCustomer_Detail.EnosixCustomer getCustomerByNumber(String id)
    {
        SBO_EnosixCustomer_Detail sbo = new SBO_EnosixCustomer_Detail();
        SBO_EnosixCustomer_Detail.EnosixCustomer result = sbo.getDetail(id);

        if (!result.isSuccess())
        {
        	UTIL_ViewHelper.displayResultMessages(
                result.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
            return null;
        }

        return result;
    }
}