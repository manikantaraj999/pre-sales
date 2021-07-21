@isTest
public class TSTU_VC_PricingAndConfiguration
{
    public class MOC_EnosixVC_Detail implements ensxsdk.EnosixFramework.DetailSBOGetMock,
            ensxsdk.EnosixFramework.DetailSBOSaveMock, ensxsdk.EnosixFramework.DetailSBOCommandMock,
            ensxsdk.EnosixFramework.DetailSBOInitMock
    {
        public boolean success = true;
        public boolean throwException = false;

        public void setSuccess(boolean success)
        {
            this.success = success;
        }

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
            SBO_EnosixVC_Detail.EnosixVC result = new SBO_EnosixVC_Detail.EnosixVC();
            result.setSuccess(success);
            return result;
        }

        public ensxsdk.EnosixFramework.DetailObject executeSave(ensxsdk.EnosixFramework.DetailObject obj)
        {
            if (throwException)
            {
                throw new CalloutException();
            }
            SBO_EnosixVC_Detail.EnosixVC result = (SBO_EnosixVC_Detail.EnosixVC) obj;
            result.setSuccess(success);
            return result;
        }

        public ensxsdk.EnosixFramework.DetailObject executeCommand(string command, ensxsdk.EnosixFramework.DetailObject obj)
        {
            if (throwException)
            {
                throw new CalloutException();
            }
            SBO_EnosixVC_Detail.EnosixVC result = (SBO_EnosixVC_Detail.EnosixVC) obj;
            result.setSuccess(success);
            return result;
        }

        public  ensxsdk.EnosixFramework.DetailObject executeInitialize(ensxsdk.EnosixFramework.DetailObject  initialState)
        {
            if (throwException)
            {
                throw new CalloutException();
            }
            SBO_EnosixVC_Detail.EnosixVC result = new SBO_EnosixVC_Detail.EnosixVC();
            result.setSuccess(success);
            return result;
        }
    }

    @isTest
    public static void test_logger()
    {
        ensxsdk.Logger logger = UTIL_VC_PricingAndConfiguration.logger;
    }

    @isTest
    public static void test_getProductIdForSAPMaterialNumber()
    {
        Product2 product = TSTU_SFTestObject.createTestProduct2();
        TSTU_SFTestObject.upsertWithRetry(product);
        String prodId = UTIL_VC_PricingAndConfiguration.getProductIdForSAPMaterialNumber(product.Name);
    }

    @isTest
    public static void test_getSAPMaterialNumberFromProductId()
    {
        Product2 product = TSTU_SFTestObject.createTestProduct2();
        TSTU_SFTestObject.upsertWithRetry(product);
        String prodId = UTIL_VC_PricingAndConfiguration.getSAPMaterialNumberFromProductId(product.Id);
    }

    @isTest
    public static void test_stripLeadingZeros()
    {
        System.assertEquals('421', UTIL_VC_PricingAndConfiguration.stripLeadingZeros('00421'));
        System.assertEquals('0', UTIL_VC_PricingAndConfiguration.stripLeadingZeros('0'));
    }

    @isTest
    public static void test_getInitialConfigFromMaterialAndPricing()
    {
        MOC_EnosixVC_Detail mocEnosixVCDetail = new MOC_EnosixVC_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixVC_Detail.class, mocEnosixVCDetail);
        ENSX_VCConfiguration serializableCfg = UTIL_VC_PricingAndConfiguration.getInitialConfigFromMaterialAndPricing('material', new ENSX_VCPricingConfiguration());
    }

    @isTest
    public static void test_getInitialConfigFromMaterialAndPricingAndCustomConfig()
    {
        MOC_EnosixVC_Detail mocEnosixVCDetail = new MOC_EnosixVC_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixVC_Detail.class, mocEnosixVCDetail);
        try
        {
            DS_VCMaterialConfiguration config =
                UTIL_VC_PricingAndConfiguration.getInitialConfigFromMaterialAndPricingAndCustomConfig('material', new ENSX_VCPricingConfiguration());
        }
        catch(Exception e)
        {}
        String TEST_JSON = '{"UseSapSession": false}';
        UTIL_AppSettings.settingsMap.put(UTIL_AppSettings.Prefix + UTIL_AppSettings.VC + UTIL_AppSettings.Suffix, (Map<String, Object>)JSON.deserializeUntyped(TEST_JSON));
        mocEnosixVCDetail.setThrowException(true);
        try
        {
            DS_VCMaterialConfiguration config = 
                UTIL_VC_PricingAndConfiguration.getInitialConfigFromMaterialAndPricingAndCustomConfig('material', new ENSX_VCPricingConfiguration());
        }
        catch(Exception e)
        {}
    }

    @isTest
    public static void test_applyPricingConfigurationToSBO()
    {
        SBO_EnosixVC_Detail.EnosixVC sboConfig = UTIL_VC_PricingAndConfiguration.applyPricingConfigurationToSBO(new SBO_EnosixVC_Detail.EnosixVC (), new ENSX_VCPricingConfiguration());
    }
    
    @isTest
    public static void test_getInitializedConfigSBOModelFromBOM()
    {
        MOC_EnosixVC_Detail mocEnosixVCDetail = new MOC_EnosixVC_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixVC_Detail.class, mocEnosixVCDetail);
        mocEnosixVCDetail.setSuccess(false);
        List<DS_VCCharacteristicValues> BOM = new List<DS_VCCharacteristicValues>();
        DS_VCCharacteristicValues VCValue = new DS_VCCharacteristicValues();
        VCValue.UserModified = false;
        BOM.add(VCValue);
        UTIL_VC_PricingAndConfiguration.getInitializedConfigSBOModelFromBOM('', new ENSX_VCPricingConfiguration(), BOM);
    }

    @isTest
    public static void test_proccessAndLogVCConfiguration()
    {
        MOC_EnosixVC_Detail mocEnosixVCDetail = new MOC_EnosixVC_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixVC_Detail.class, mocEnosixVCDetail);
        
        UTIL_VC_PricingAndConfiguration.proccessAndLogVCConfiguration(
            new DS_VCMaterialConfiguration(new SBO_EnosixVC_Detail.EnosixVC()), 
            new List<DS_VCCharacteristicValues>());
        UTIL_VC_PricingAndConfiguration.proccessAndLogVCConfiguration(
            new DS_VCMaterialConfiguration(new SBO_EnosixVC_Detail.EnosixVC()), 
            new List<DS_VCCharacteristicValues>(),
            new List<String>{'Test'});
    }

    @isTest
    public static void test_execCmd()
    {
        MOC_EnosixVC_Detail mocEnosixVCDetail = new MOC_EnosixVC_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixVC_Detail.class, mocEnosixVCDetail);
        String TEST_JSON = '{"UseSapSession": false}';
        UTIL_AppSettings.settingsMap.put(UTIL_AppSettings.Prefix + UTIL_AppSettings.VC + UTIL_AppSettings.Suffix, (Map<String, Object>)JSON.deserializeUntyped(TEST_JSON));
        UTIL_VC_PricingAndConfiguration.execCmd('Test', new SBO_EnosixVC_Detail.EnosixVC(), 'requestSessionData');
        mocEnosixVCDetail.setSuccess(false);
        UTIL_VC_PricingAndConfiguration.execCmd('Test', new SBO_EnosixVC_Detail.EnosixVC(), 'requestSessionData');
    }

    @isTest
    public static void test_closeSession()
    {
        UTIL_VC_PricingAndConfiguration.headers = new Map<String,String>();
        UTIL_VC_PricingAndConfiguration.headers.put('Test1', 'Test1');
        UTIL_VC_PricingAndConfiguration.headers.put('Test2', 'Test2');
        UTIL_VC_PricingAndConfiguration.closeSession(UTIL_VC_PricingAndConfiguration.SessionData);
    }

    @isTest
    public static void test_getObjectKey()
    {
        UTIL_VC_PricingAndConfiguration.getObjectKey(null);
        UTIL_VC_PricingAndConfiguration.getObjectKey(new SBO_EnosixVC_Detail.EnosixVC());
    }

    @isTest
    public static void test_isInitialKey()
    {
        UTIL_VC_PricingAndConfiguration.isInitialKey('Test');
    }

    @isTest
    public static void test_getBusinessObjectName()
    {
        UTIL_VC_PricingAndConfiguration.getBusinessObjectName(new SBO_EnosixVC_Detail());
    }

    @isTest
    public static void test_deserializeObject()
    {
        UTIL_VC_PricingAndConfiguration.deserializeObject(new SBO_EnosixVC_Detail.CHARACTERISTICS(), new Account());
    }

    @isTest
    public static void test_httpSend()
    {
        UTIL_VC_PricingAndConfiguration.headers = null;
        HttpRequest httpReq = new HttpRequest();
        httpReq.setEndpoint('endPoint');
        UTIL_VC_PricingAndConfiguration.httpSend(httpReq, new Map<String,String>());
    }

    @isTest
    public static void test_executeInitialize()
    {
        UTIL_VC_PricingAndConfiguration.executeInitialize(new SBO_EnosixVC_Detail(), new SBO_EnosixVC_Detail.EnosixVC());
    }

    @isTest
    public static void test_executeCommand()
    {
        UTIL_VC_PricingAndConfiguration.executeCommand(new SBO_EnosixVC_Detail(), new SBO_EnosixVC_Detail.EnosixVC(), 'command');
    }
}