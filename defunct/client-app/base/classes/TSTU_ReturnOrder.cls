@isTest
public with sharing class TSTU_ReturnOrder
{
    public class MOC_EnosixRO_Detail implements ensxsdk.EnosixFramework.DetailSBOGetMock,
            ensxsdk.EnosixFramework.DetailSBOSaveMock, ensxsdk.EnosixFramework.DetailSBOCommandMock,
            ensxsdk.EnosixFramework.DetailSBOInitMock
    {
        public boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        public ensxsdk.EnosixFramework.DetailObject executeGetDetail(object key)
        {
            SBO_EnosixRO_Detail.EnosixRO result = new SBO_EnosixRO_Detail.EnosixRO();
            result.setSuccess(this.success);
            return result;
        }

        public ensxsdk.EnosixFramework.DetailObject executeSave(ensxsdk.EnosixFramework.DetailObject obj)
        {
            SBO_EnosixRO_Detail.EnosixRO result = new SBO_EnosixRO_Detail.EnosixRO();
            result.setSuccess(this.success);
            return result;
        }

        public ensxsdk.EnosixFramework.DetailObject executeCommand(string command, ensxsdk.EnosixFramework.DetailObject obj)
        {
            SBO_EnosixRO_Detail.EnosixRO result = new SBO_EnosixRO_Detail.EnosixRO();
            result.setSuccess(this.success);
            return result;
        }

        public  ensxsdk.EnosixFramework.DetailObject executeInitialize(ensxsdk.EnosixFramework.DetailObject  initialState)
        {
            SBO_EnosixRO_Detail.EnosixRO result = new SBO_EnosixRO_Detail.EnosixRO();
            result.setSuccess(this.success);
            return result;
        }
    }

    @isTest
    public static void test_getReturnOrderForId()
    {
        MOC_EnosixRO_Detail mocSbo = new MOC_EnosixRO_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixRO_Detail.class, mocSbo);
        Test.startTest();
        UTIL_ReturnOrder.getReturnOrderForId('');
        mocSbo.setSuccess(false);
        UTIL_ReturnOrder.getReturnOrderForId('');
        Test.stopTest();
    }

    @isTest
    static void test_getPartnerFromReturnOrder()
    {
        Test.startTest();
        SBO_EnosixRO_Detail.EnosixRO result = new SBO_EnosixRO_Detail.EnosixRO();
        SBO_EnosixRO_Detail.PARTNERS partner = new SBO_EnosixRO_Detail.PARTNERS();
        result.PARTNERS.add(partner);
        UTIL_ReturnOrder.getPartnerFromReturnOrder(result, UTIL_Customer.SOLD_TO_PARTNER_CODE, true);
        partner.PartnerFunction = UTIL_Customer.SOLD_TO_PARTNER_CODE;
        result.PARTNERS.add(partner);
        UTIL_ReturnOrder.getPartnerFromReturnOrder(result, UTIL_Customer.SOLD_TO_PARTNER_CODE, true);
        Test.stopTest();
    }
}