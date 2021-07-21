@isTest
public with sharing class TSTU_RFC
{
    public class MOC_RFC_SD_GET_DOC_TYPE_VALUES implements ensxsdk.EnosixFramework.RFCMock
    {
        private boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            RFC_SD_GET_DOC_TYPE_VALUES.RESULT result = new RFC_SD_GET_DOC_TYPE_VALUES.RESULT();
            RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT sditm = new RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT();
            sditm.DocumentType = 'SD';
            sditm.BEZEI = 'Standard';
            result.ET_OUTPUT_List.add(sditm);
            for (integer mocCnt = 0; mocCnt < 20; mocCnt++)
            {
                RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT out = new RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT();
                out.DocumentType = 'tst' + mocCnt;
                out.BEZEI = 'tst' + mocCnt;
                result.ET_OUTPUT_List.add(out);
            }
            result.setSuccess(this.success);
            return result;
        }
    }

    @isTest
    public static void test_getDocTypeMaster()
    {
        MOC_RFC_SD_GET_DOC_TYPE_VALUES mocRfc = new MOC_RFC_SD_GET_DOC_TYPE_VALUES();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_DOC_TYPE_VALUES.class, mocRfc);
        Test.startTest();

        UTIL_RFC.getDocTypeMaster();
        mocRfc.setSuccess(false);
        UTIL_RFC.getDocTypeMaster();

        Test.stopTest();
    }
}