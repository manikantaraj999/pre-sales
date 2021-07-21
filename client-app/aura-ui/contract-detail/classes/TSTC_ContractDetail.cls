@isTest
public class TSTC_ContractDetail
{
    public class MOC_SBO_EnosixContract_Detail implements ensxsdk.EnosixFramework.DetailSBOGetMock
    {
        private boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        private boolean throwException = false;

        public void setThrowException(boolean throwException)
        {
            this.throwException = throwException;
        }

        public ensxsdk.EnosixFramework.DetailObject executeGetDetail(object key)
        {
            if (throwException) throw new CalloutException();

            SBO_EnosixContract_Detail.EnosixContract result = new SBO_EnosixContract_Detail.EnosixContract();            
            result.setSuccess(this.success);
            return result;
        }
    }

    @isTest
    public static void test_getContractDetail()
    {
        MOC_SBO_EnosixContract_Detail mocEnosixContractDetail = new MOC_SBO_EnosixContract_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixContract_Detail.class, mocEnosixContractDetail);

        UTIL_Aura.Response response = CTRL_ContractDetail.getContractDetail('TEST');

        mocEnosixContractDetail.setThrowException(true);
        response = CTRL_ContractDetail.getContractDetail('TEST');
    }
}