@isTest
public class TSTU_Customer
{
    public class MOC_Customer implements ensxsdk.EnosixFramework.DetailSBOGetMock, ensxsdk.EnosixFramework.DetailSBOSaveMock
    {
        private boolean throwException = false;
    	public Boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        public void setThrowException(boolean throwException)
        {
            this.throwException = throwException;
        }

        public ensxsdk.EnosixFramework.DetailObject executeGetDetail(object key)
        {
            SBO_EnosixCustomer_Detail.EnosixCustomer result = new SBO_EnosixCustomer_Detail.EnosixCustomer();
            result.setSuccess(success);
            return result;
        }

        public ensxsdk.EnosixFramework.DetailObject executeSave(ensxsdk.EnosixFramework.DetailObject obj)
        {
            SBO_EnosixCustomer_Detail.EnosixCustomer result = (SBO_EnosixCustomer_Detail.EnosixCustomer) obj;
            result.setSuccess(success);
            if (throwException)
            {
                throw new CalloutException();
            }
            return result;
        }
    }

    @isTest
    static void test_TouchProps()
    {
        Test.startTest();
        String soldTo = UTIL_Customer.SOLD_TO_PARTNER_CODE;
        String shipTo = UTIL_Customer.SHIP_TO_PARTNER_CODE;
        String carrier = UTIL_Customer.CARRIER_PARTNER_CODE;
        String billTo = UTIL_Customer.BILL_TO_PARTNER_CODE;
        Test.stopTest();
    }

    @isTest
    static void test_getCustomerByNumber()
    {
        MOC_Customer mockCustomer = new MOC_Customer();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustomer_Detail.class, mockCustomer);

        Test.startTest();
        SBO_EnosixCustomer_Detail.EnosixCustomer result = UTIL_Customer.getCustomerByNumber('Id');
        mockCustomer.setSuccess(false);
        result = UTIL_Customer.getCustomerByNumber('Id');
        Test.stopTest();
    }
}