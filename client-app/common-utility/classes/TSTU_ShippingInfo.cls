@isTest
public with sharing class TSTU_ShippingInfo
{
    public class MOC_RFC_SD_GET_SHIP_INFO implements ensxsdk.EnosixFramework.RFCMock
    {
        public boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            RFC_SD_GET_SHIP_INFO.RESULT result = new RFC_SD_GET_SHIP_INFO.RESULT();
            RFC_SD_GET_SHIP_INFO.ET_SHIP_COND shippingCondition = new RFC_SD_GET_SHIP_INFO.ET_SHIP_COND();
            shippingCondition.ShippingConditions = 'ShippingConditions';
            shippingCondition.VTEXT = 'VTEXT';
            result.getCollection(RFC_SD_GET_SHIP_INFO.ET_SHIP_COND.class).add(shippingCondition);
            result.setSuccess(this.success);
            return result;
        }
    }

    @isTest
    public static void test_filterShippingConditions()
    {
        MOC_RFC_SD_GET_SHIP_INFO mocRfcSdGetShipInfo = new MOC_RFC_SD_GET_SHIP_INFO();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_SHIP_INFO.class, mocRfcSdGetShipInfo);

        Test.startTest();
        List<SelectOption> result = Util_SelectOption.buildOptionsFromList(
            new UTIL_ShippingInfo.ShippingConditionOptionBuilder(),
            UTIL_ShippingInfo.filterShippingConditions(UTIL_ShippingInfo.getShippingMaster())
        );
        mocRfcSdGetShipInfo.setSuccess(false);
        UTIL_ShippingInfo.filterShippingConditions(UTIL_ShippingInfo.getShippingMaster());
        Test.stopTest();
    }
}