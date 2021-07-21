@isTest
public class TSTC_SalesDocCreateUpdate
{
    public class MOC_SBO_EnosixCustomer_Detail implements ensxsdk.EnosixFramework.DetailSBOGetMock
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

            SBO_EnosixCustomer_Detail.EnosixCustomer result = new SBO_EnosixCustomer_Detail.EnosixCustomer();            
            result.setSuccess(this.success);
            return result;
        }
    }

    public class MOC_RFC_SD_GET_SHIP_INFO implements ensxsdk.EnosixFramework.RFCMock
    {
        public boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        private boolean throwException = false;

        public void setThrowException(boolean throwException)
        {
            this.throwException = throwException;
        }

        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            if (throwException) throw new CalloutException();
            RFC_SD_GET_SHIP_INFO.RESULT result = new RFC_SD_GET_SHIP_INFO.RESULT();
            result.setSuccess(this.success);
            return result;
        }
    }

    public class MOC_RFC_SD_GET_PRICING_STAT implements ensxsdk.EnosixFramework.RFCMock
    {
        public boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        private boolean throwException = false;

        public void setThrowException(boolean throwException)
        {
            this.throwException = throwException;
        }

        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            if (throwException) throw new CalloutException();
            RFC_SD_GET_PRICING_STAT.RESULT result = new RFC_SD_GET_PRICING_STAT.RESULT();
            result.setSuccess(this.success);
            return result;
        }
    }

    public class MOC_RFC_SD_GET_GROUP_OFFICE implements ensxsdk.EnosixFramework.RFCMock
    {
        public boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        private boolean throwException = false;

        public void setThrowException(boolean throwException)
        {
            this.throwException = throwException;
        }

        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            if (throwException) throw new CalloutException();
            RFC_SD_GET_GROUP_OFFICE.RESULT result = new RFC_SD_GET_GROUP_OFFICE.RESULT();
            result.setSuccess(this.success);
            return result;
        }
    }

    public class MOC_RFC_SD_GET_CONDITION_TYPES implements ensxsdk.EnosixFramework.RFCMock
    {
        public boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        private boolean throwException = false;

        public void setThrowException(boolean throwException)
        {
            this.throwException = throwException;
        }

        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            if (throwException) throw new CalloutException();
            RFC_SD_GET_CONDITION_TYPES.RESULT result = new RFC_SD_GET_CONDITION_TYPES.RESULT();
            result.setSuccess(this.success);
            return result;
        }
    }

    public class MOC_RFC_SD_GET_REJECTION_REASONS implements ensxsdk.EnosixFramework.RFCMock
    {
        public boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        private boolean throwException = false;

        public void setThrowException(boolean throwException)
        {
            this.throwException = throwException;
        }

        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            if (throwException) throw new CalloutException();
            RFC_SD_GET_REJECTION_REASONS.RESULT result = new RFC_SD_GET_REJECTION_REASONS.RESULT();
            result.setSuccess(this.success);
            return result;
        }
    }

    public class MOC_RFC_SD_GET_PERIO implements ensxsdk.EnosixFramework.RFCMock
    {
        public boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        private boolean throwException = false;

        public void setThrowException(boolean throwException)
        {
            this.throwException = throwException;
        }

        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            if (throwException) throw new CalloutException();
            RFC_SD_GET_PERIO.RESULT result = new RFC_SD_GET_PERIO.RESULT();
            result.setSuccess(this.success);
            return result;
        }
    }

    public class MOC_RFC_SD_GET_COUNTRIES implements ensxsdk.EnosixFramework.RFCMock
    {
        public boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        private boolean throwException = false;

        public void setThrowException(boolean throwException)
        {
            this.throwException = throwException;
        }

        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            if (throwException) throw new CalloutException();
            RFC_SD_GET_COUNTRIES.RESULT result = new RFC_SD_GET_COUNTRIES.RESULT();
            result.setSuccess(this.success);
            return result;
        }
    }

    public class MOC_RFC_SD_GET_ITEMCAT_VALUES implements ensxsdk.EnosixFramework.RFCMock
    {
        public boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        private boolean throwException = false;

        public void setThrowException(boolean throwException)
        {
            this.throwException = throwException;
        }

        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            if (throwException) throw new CalloutException();
            RFC_SD_GET_ITEMCAT_VALUES.RESULT result = new RFC_SD_GET_ITEMCAT_VALUES.RESULT();
            result.setSuccess(this.success);
            return result;
        }
    }

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
            if (throwException) throw new CalloutException();

            SBO_EnosixMaterial_Detail.EnosixMaterial result = new SBO_EnosixMaterial_Detail.EnosixMaterial();  
            SBO_EnosixMaterial_Detail.PLANT_DATA plantData = new SBO_EnosixMaterial_Detail.PLANT_DATA();
            plantData.Plant = 'Plant';
            plantData.Name = 'Name';
            plantData.SalesOrganization = '0001';
            plantData.DistributionChannel = '01';
            result.PLANT_DATA.add(plantData);
            result.setSuccess(this.success);
            return result;
        }
    }

    public class MOC_SBO_EnosixSalesDocument_Detail implements ensxsdk.EnosixFramework.DetailSBOGetMock,
        ensxsdk.EnosixFramework.DetailSBOCommandMock, ensxsdk.EnosixFramework.DetailSBOSaveMock
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

            SBO_EnosixSalesDocument_Detail.EnosixSalesDocument result = new SBO_EnosixSalesDocument_Detail.EnosixSalesDocument();
            SBO_EnosixSalesDocument_Detail.ITEMS item = new SBO_EnosixSalesDocument_Detail.ITEMS();
            item.ItemNumber = '10';
            item.Material = null;
            result.ITEMS.add(item);
            result.setSuccess(success);
            return result;
        }

        public ensxsdk.EnosixFramework.DetailObject executeCommand(String command, ensxsdk.EnosixFramework.DetailObject obj)
        {
            if (throwException) throw new CalloutException();

            SBO_EnosixSalesDocument_Detail.EnosixSalesDocument result = new SBO_EnosixSalesDocument_Detail.EnosixSalesDocument();
            result.setSuccess(success);
            return result;
        }

        public ensxsdk.EnosixFramework.DetailObject executeSave(ensxsdk.EnosixFramework.DetailObject obj)
        {
            SBO_EnosixSalesDocument_Detail.EnosixSalesDocument result = new SBO_EnosixSalesDocument_Detail.EnosixSalesDocument();
            result.setSuccess(success);
            return result;
        }
    }

    @isTest
    public static void test_getCustomerDetail()
    {
        MOC_SBO_EnosixCustomer_Detail mocEnosixCustomerDetail = new MOC_SBO_EnosixCustomer_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustomer_Detail.class, mocEnosixCustomerDetail);

        UTIL_Aura.Response response = CTRL_SalesDocCreateUpdate.getCustomerDetail('TEST');

        mocEnosixCustomerDetail.setThrowException(true);
        response = CTRL_SalesDocCreateUpdate.getCustomerDetail('TEST');
    }

    @isTest
    public static void test_getShipInfo()
    {
        MOC_RFC_SD_GET_SHIP_INFO mocRfc = new MOC_RFC_SD_GET_SHIP_INFO();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_SHIP_INFO.class, mocRfc);

        UTIL_Aura.Response response = CTRL_SalesDocCreateUpdate.getShipInfo();

        mocRfc.setThrowException(true);
        response = CTRL_SalesDocCreateUpdate.getShipInfo();
    }

    @isTest
    public static void test_getPricingStat()
    {
        MOC_RFC_SD_GET_PRICING_STAT mocRfc = new MOC_RFC_SD_GET_PRICING_STAT();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_PRICING_STAT.class, mocRfc);

        UTIL_Aura.Response response = CTRL_SalesDocCreateUpdate.getPricingStat();

        mocRfc.setThrowException(true);
        response = CTRL_SalesDocCreateUpdate.getPricingStat();
    }

    @isTest
    public static void test_getGroupOffice()
    {
        MOC_RFC_SD_GET_GROUP_OFFICE mocRfc = new MOC_RFC_SD_GET_GROUP_OFFICE();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_GROUP_OFFICE.class, mocRfc);

        UTIL_Aura.Response response = CTRL_SalesDocCreateUpdate.getGroupOffice();

        mocRfc.setThrowException(true);
        response = CTRL_SalesDocCreateUpdate.getGroupOffice();
    }

    @isTest
    public static void test_getConditionTypes()
    {
        MOC_RFC_SD_GET_CONDITION_TYPES mocRfc = new MOC_RFC_SD_GET_CONDITION_TYPES();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_CONDITION_TYPES.class, mocRfc);

        UTIL_Aura.Response response = CTRL_SalesDocCreateUpdate.getConditionTypes(true, 'procedure');

        mocRfc.setThrowException(true);
        response = CTRL_SalesDocCreateUpdate.getConditionTypes(true, 'procedure');
    }

    @isTest
    public static void test_getRejectionReasons()
    {
        MOC_RFC_SD_GET_REJECTION_REASONS mocRfc = new MOC_RFC_SD_GET_REJECTION_REASONS();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_REJECTION_REASONS.class, mocRfc);

        UTIL_Aura.Response response = CTRL_SalesDocCreateUpdate.getRejectionReasons();

        mocRfc.setThrowException(true);
        response = CTRL_SalesDocCreateUpdate.getRejectionReasons();
    }

    @isTest
    public static void test_getBillingPlans()
    {
        MOC_RFC_SD_GET_PERIO mocRfc = new MOC_RFC_SD_GET_PERIO();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_PERIO.class, mocRfc);

        UTIL_Aura.Response response = CTRL_SalesDocCreateUpdate.getBillingPlans();

        mocRfc.setThrowException(true);
        response = CTRL_SalesDocCreateUpdate.getBillingPlans();
    }

    @isTest
    public static void test_getCountries()
    {
        MOC_RFC_SD_GET_COUNTRIES mocRfc = new MOC_RFC_SD_GET_COUNTRIES();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_COUNTRIES.class, mocRfc);

        UTIL_Aura.Response response = CTRL_SalesDocCreateUpdate.getCountries();

        mocRfc.setThrowException(true);
        response = CTRL_SalesDocCreateUpdate.getCountries();
    }

    @isTest
    public static void test_getItemCategories()
    {
        MOC_RFC_SD_GET_ITEMCAT_VALUES mocRfc = new MOC_RFC_SD_GET_ITEMCAT_VALUES();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_ITEMCAT_VALUES.class, mocRfc);

        UTIL_Aura.Response response = CTRL_SalesDocCreateUpdate.getItemCategories(new DS_Document_Detail.SALES(), '');

        mocRfc.setThrowException(true);
        response = CTRL_SalesDocCreateUpdate.getItemCategories(new DS_Document_Detail.SALES(), '');
    }

    @isTest
    public static void test_getMaterialSalesText()
    {
        MOC_SBO_EnosixMaterial_Detail mocEnosixMaterialDetail = new MOC_SBO_EnosixMaterial_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixMaterial_Detail.class, mocEnosixMaterialDetail);

        UTIL_Aura.Response response = CTRL_SalesDocCreateUpdate.getMaterialsDetail(new List<String>{'TEST'}, '111', '222');

        mocEnosixMaterialDetail.setSuccess(false);
        response = CTRL_SalesDocCreateUpdate.getMaterialsDetail(new List<String>{'TEST'}, '111', '222');

        mocEnosixMaterialDetail.setThrowException(true);
        response = CTRL_SalesDocCreateUpdate.getMaterialsDetail(new List<String>{'TEST'}, '111', '222');
    }

    @isTest
    public static void test_initSFObject()
    {
        Opportunity opp = TSTU_SFTestObject.createTestOpportunity();
        TSTU_SFTestObject.upsertWithRetry(opp);

        UTIL_Aura.Response response = CTRL_SalesDocCreateUpdate.initSFObject(opp.Id, 'Order');
    }

    @isTest
    public static void test_initSalesDocDetailFromSFObject()
    {
        DS_Document_Detail salesDocDetail = new DS_Document_Detail();
        UTIL_SalesDoc.SFObject sfObject = new UTIL_SalesDoc.SFObject();
        DS_SalesDocAppSettings appSettings = new DS_SalesDocAppSettings();

        UTIL_Aura.Response response = CTRL_SalesDocCreateUpdate.initSalesDocDetailFromSFObject(salesDocDetail, sfObject, appSettings);
    }

    @isTest
    public static void test_getSalesDocDetail()
    {

        MOC_SBO_EnosixSalesDocument_Detail mocEnosixSalesDocumentDetail = new MOC_SBO_EnosixSalesDocument_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixSalesDocument_Detail.class, mocEnosixSalesDocumentDetail);
        DS_SalesDocAppSettings appSettings = createAppSettings();
        appSettings.Header = new DS_SalesDocAppSettings.DocumentSetting();
        appSettings.Header.Texts = new Map<String, String>();
        appSettings.Header.PartnerPickers = new List<DS_SalesDocAppSettings.PartnerSetting>();
        appSettings.Item = new DS_SalesDocAppSettings.DocumentSetting();
        appSettings.Item.Texts = new Map<String, String>();
        appSettings.Item.PartnerPickers = new List<DS_SalesDocAppSettings.PartnerSetting>();

        UTIL_SalesDoc.SFObject sfObject = new UTIL_SalesDoc.SFObject();
        Opportunity opp = TSTU_SFTestObject.createTestOpportunity();
        TSTU_SFTestObject.upsertWithRetry(opp);

        OpportunityLineItem oli = TSTU_SFTestObject.createTestOpportunityLineItem();
        oli.OpportunityId = opp.Id;
        oli.Quantity = 10;
        oli.UnitPrice = .95;
        oli.Description = 'test Desciption';
        oli.FLD_SAP_Item_Number__c = '10';

        sfObject = new UTIL_SalesDoc.SFObject();
        sfObject.sfLineItems = new List<SObject>{oli};
        sfObject.initFromSObject = true;
        sfObject.sfMainObject = opp;

        UTIL_Aura.Response response = CTRL_SalesDocCreateUpdate.getSalesDocDetail('salesDocNumber', appSettings, sfObject);

        mocEnosixSalesDocumentDetail.setThrowException(true);
        response = CTRL_SalesDocCreateUpdate.getSalesDocDetail('salesDocNumber', appSettings, sfObject);

        response = CTRL_SalesDocCreateUpdate.validateProductsInSalesforce(new List<String>{'Test'}, 'pricebookId');
    }

    @isTest
    public static void test_getReferenceDocument()
    {
        MOC_SBO_EnosixSalesDocument_Detail mocEnosixSalesDocumentDetail = new MOC_SBO_EnosixSalesDocument_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixSalesDocument_Detail.class, mocEnosixSalesDocumentDetail);

        DS_Document_Detail salesDocDetail = new DS_Document_Detail();
        DS_SalesDocAppSettings appSettings = createAppSettings();
        appSettings.Header = new DS_SalesDocAppSettings.DocumentSetting();
        appSettings.Header.Texts = new Map<String, String>();

        UTIL_Aura.Response response = CTRL_SalesDocCreateUpdate.getReferenceDocument('111', appSettings);

        mocEnosixSalesDocumentDetail.setThrowException(true);
        response = CTRL_SalesDocCreateUpdate.getReferenceDocument('111', appSettings);
    }

    @isTest
    public static void test_simulateSalesDoc()
    {
        MOC_SBO_EnosixSalesDocument_Detail mocEnosixSalesDocumentDetail = new MOC_SBO_EnosixSalesDocument_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixSalesDocument_Detail.class, mocEnosixSalesDocumentDetail);

        DS_Document_Detail salesDocDetail = new DS_Document_Detail();
        DS_SalesDocAppSettings appSettings = createAppSettings();

        UTIL_Aura.Response response = CTRL_SalesDocCreateUpdate.simulateSalesDoc(salesDocDetail, appSettings);

        mocEnosixSalesDocumentDetail.setThrowException(true);
        response = CTRL_SalesDocCreateUpdate.simulateSalesDoc(salesDocDetail, appSettings);
    }

    @isTest
    public static void test_createSAPDocument()
    {
        MOC_SBO_EnosixSalesDocument_Detail mocEnosixSalesDocumentDetail = new MOC_SBO_EnosixSalesDocument_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixSalesDocument_Detail.class, mocEnosixSalesDocumentDetail);
        
        Id pricebookId = Test.getStandardPricebookId();
        UTIL_SalesDoc.SFObject sfObject = new UTIL_SalesDoc.SFObject();
        DS_SalesDocAppSettings appSettings = createAppSettings();
        
        DS_Document_Detail salesDocDetail = TSTD_Document_Detail.buildsalesDocDetail();

        UTIL_Aura.Response response = CTRL_SalesDocCreateUpdate.createSAPDocument(sfObject, salesDocDetail, appSettings);
        Opportunity opp = TSTU_SFTestObject.createTestOpportunity();
        TSTU_SFTestObject.upsertWithRetry(opp);
        sfObject = new UTIL_SalesDoc.SFObject();
        sfObject.sfLineItems = new List<SObject>();
        sfObject.initFromSObject = true;
        sfObject.sfMainObject = opp;
        response = CTRL_SalesDocCreateUpdate.createSAPDocument(sfObject, salesDocDetail, appSettings);
    }

    @isTest
    public static void test_updateSAPDocument()
    {
        MOC_SBO_EnosixSalesDocument_Detail mocEnosixSalesDocumentDetail = new MOC_SBO_EnosixSalesDocument_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixSalesDocument_Detail.class, mocEnosixSalesDocumentDetail);
        
        Id pricebookId = Test.getStandardPricebookId();
        UTIL_SalesDoc.SFObject sfObject = new UTIL_SalesDoc.SFObject();
        DS_SalesDocAppSettings appSettings = createAppSettings();
        
        DS_Document_Detail salesDocDetail = TSTD_Document_Detail.buildsalesDocDetail();

        UTIL_Aura.Response response = CTRL_SalesDocCreateUpdate.updateSAPDocument(sfObject, salesDocDetail, appSettings);
        Opportunity opp = TSTU_SFTestObject.createTestOpportunity();
        TSTU_SFTestObject.upsertWithRetry(opp);
        sfObject = new UTIL_SalesDoc.SFObject();
        sfObject.sfLineItems = new List<SObject>();
        sfObject.initFromSObject = true;
        sfObject.sfMainObject = opp;
        response = CTRL_SalesDocCreateUpdate.updateSAPDocument(sfObject, salesDocDetail, appSettings);
    }

    @isTest
    public static void test_saveToObject()
    {
        UTIL_SalesDoc.SFObject sfObject = new UTIL_SalesDoc.SFObject();
        DS_Document_Detail salesDocDetail = new DS_Document_Detail();

        UTIL_Aura.Response response = CTRL_SalesDocCreateUpdate.saveToSObject(sfObject, salesDocDetail, true);
    }

    private static DS_SalesDocAppSettings createAppSettings()
    {
        DS_SalesDocAppSettings appSettings = new DS_SalesDocAppSettings();
        appSettings.SBODetailType = 'SalesDocument';
        appSettings.SAPDocType = 'Quote';
        appSettings.enableBoMItemEdit = false;
        appSettings.updateLineItems = true;
        return appSettings;
    }
}