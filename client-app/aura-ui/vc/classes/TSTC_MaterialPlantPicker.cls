@isTest public with sharing class TSTC_MaterialPlantPicker {

	public class MOC_SBO_EnosixMaterial_Detail implements ensxsdk.EnosixFramework.DetailSBOGetMock
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
            if (throwException)
            {
                throw new CalloutException();
            }
            SBO_EnosixMaterial_Detail.EnosixMaterial result = new SBO_EnosixMaterial_Detail.EnosixMaterial();
            result.setSuccess(this.success);
            return result;
        }
	}

    /*
    public static UTIL_Aura.Response getMaterial(String materialNumber) {
    */
    @isTest public static void test_getMaterial()
    {
		MOC_SBO_EnosixMaterial_Detail sboMoc = new MOC_SBO_EnosixMaterial_Detail();
		ensxsdk.EnosixFramework.setMock(SBO_EnosixMaterial_Detail.class, sboMoc);
        CTRL_MaterialPlantPicker.getMaterial('1');
        sboMoc.setThrowException(true);
        CTRL_MaterialPlantPicker.getMaterial('1');
    } 
}