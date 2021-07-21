@isTest 
public with sharing class TSTU_VCPricing 
{
    public class MockSBO_EnosixOpportunityPricing_Detail implements
        ensxsdk.EnosixFramework.DetailSBOInitMock,
        ensxsdk.EnosixFramework.DetailSBOCommandMock,
        ensxsdk.EnosixFramework.DetailSBOGetMock,
        ensxsdk.EnosixFramework.DetailSBOSaveMock
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

        public ensxsdk.EnosixFramework.DetailObject executeInitialize(ensxsdk.EnosixFramework.DetailObject initialState) 
        { 
            return null; 
        }

        public ensxsdk.EnosixFramework.DetailObject executeCommand(String command, ensxsdk.EnosixFramework.DetailObject obj) 
        { 
            if (throwException)
            {
                throw new ENSX_Exceptions.SimulationException();
            }
            return this.executeGetDetail(obj);
        }

        public ensxsdk.EnosixFramework.DetailObject executeGetDetail(object key) 
        { 
            if (throwException)
            {
                throw new ENSX_Exceptions.SimulationException();
            }

            SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing result = new SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing();           
            result.setSuccess(success);
            
            SBO_EnosixOpportunityPricing_Detail.ITEMS topItem = new SBO_EnosixOpportunityPricing_Detail.ITEMS();
            topItem.ItemNumber = '10';
            topItem.HigherLevelItemNumber = '0';
            topItem.CostInDocCurrency = 5;
            topItem.OrderQuantity = 1;
            topItem.NetItemPrice = 10;
            
            SBO_EnosixOpportunityPricing_Detail.ITEMS childItem = new SBO_EnosixOpportunityPricing_Detail.ITEMS();
            childItem.ItemNumber = '11';
            childItem.Material = 'MAT1';
            childItem.HigherLevelItemNumber = '10';
            childItem.CostInDocCurrency = 6;
            childItem.OrderQuantity = 1;
            childItem.NetItemPrice = 10;

            SBO_EnosixOpportunityPricing_Detail.ITEMS childItem2 = new SBO_EnosixOpportunityPricing_Detail.ITEMS();
            childItem2.ItemNumber = '12';
            childItem2.Material = 'MAT2';
            childItem2.HigherLevelItemNumber = '10';
            childItem2.CostInDocCurrency = 5;
            childItem2.OrderQuantity = 2;
            childItem2.NetItemPrice = 10;

            SBO_EnosixOpportunityPricing_Detail.ITEMS childItem3 = new SBO_EnosixOpportunityPricing_Detail.ITEMS();
            childItem3.ItemNumber = '13';
            childItem3.Material = 'MAT2';
            childItem3.HigherLevelItemNumber = '10';
            childItem3.CostInDocCurrency = 5;
            childItem3.OrderQuantity = 2;
            childItem3.NetItemPrice = 10;

            SBO_EnosixOpportunityPricing_Detail.ITEMS childItem4 = new SBO_EnosixOpportunityPricing_Detail.ITEMS();
            childItem4.ItemNumber = '14';
            childItem4.Material = 'MAT2';
            childItem4.HigherLevelItemNumber = '10';
            childItem4.CostInDocCurrency = 5;
            childItem4.OrderQuantity = 2;
            childItem4.NetItemPrice = 10;
            
            result.ITEMS.add(topItem);
            result.ITEMS.add(childItem);
            result.ITEMS.add(childItem2);
            result.ITEMS.add(childItem3);
            result.ITEMS.add(childItem4);
            
            SBO_EnosixOpportunityPricing_Detail.ITEMS_SCHEDULE itemSched = new SBO_EnosixOpportunityPricing_Detail.ITEMS_SCHEDULE();
        	itemSched.ItemNumber = '10';
        	itemSched.ConfirmedQuantity = 1;
        	result.ITEMS_SCHEDULE.add(itemSched);

            SBO_EnosixOpportunityPricing_Detail.CONDITIONS itemCond = new SBO_EnosixOpportunityPricing_Detail.CONDITIONS();
            itemCond.ConditionItemNumber = '1';
            itemCond.ConditionType = 'TEST';
            itemCond.Rate = 2;
            result.CONDITIONS.add(itemCond);
            SBO_EnosixOpportunityPricing_Detail.CONDITIONS itemCond2 = new SBO_EnosixOpportunityPricing_Detail.CONDITIONS();
            itemCond2.ConditionItemNumber = '1';
            itemCond2.ConditionType = 'SECOND';
            itemCond2.Rate = 10;
            result.CONDITIONS.add(itemCond2);
            
            return result;
        }

        public ensxsdk.EnosixFramework.DetailObject executeSave(ensxsdk.EnosixFramework.DetailObject obj) 
        { 
            SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing result = new SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing();
            result.setSuccess(success);
            return result;
        }
    }

    public class MOC_RFC_SD_GET_DOC_TYPE_VALUES_ET_OUTPUT implements ensxsdk.EnosixFramework.RFCMock
    {
        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            RFC_SD_GET_DOC_TYPE_VALUES.RESULT result = new RFC_SD_GET_DOC_TYPE_VALUES.RESULT();
            RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT sditm = new RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT();
            sditm.DocumentType = 'QT';
            sditm.BEZEI = 'Standard';
            sditm.INCPO = '000010';
            sditm.VBTYP = 'B';
            sditm.X_PONUM_REQUIRED = true;
            result.getCollection(RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT.class).add(sditm);
            result.setSuccess(true);
            return result;
        }
    }

    @isTest static void test_Settings()
    {
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_DOC_TYPE_VALUES.class, new MOC_RFC_SD_GET_DOC_TYPE_VALUES_ET_OUTPUT());

        Test.startTest();
        string TEST_JSON = '{"DefaultQuoteLineIncrement": 0,"DefaultSalesDocType": "QT"}';
        UTIL_AppSettings.settingsMap.put(UTIL_AppSettings.Prefix + UTIL_AppSettings.VC + UTIL_AppSettings.Suffix, (Map<String, Object>)JSON.deserializeUntyped(TEST_JSON));
        String defaultSalesDocType = UTIL_VCPricing.defaultSalesDocType;
        String defaultSalesOrg = UTIL_VCPricing.defaultSalesOrg;
        String defaultDistributionChannel = UTIL_VCPricing.defaultDistributionChannel;
        String defaultDivision = UTIL_VCPricing.defaultDivision;
        String defaultCustomerNumber = UTIL_VCPricing.defaultCustomerNumber;
        String defaultMaterialgroup1 = UTIL_VCPricing.defaultMaterialgroup1;
        String defaultMaterialgroup2 = UTIL_VCPricing.defaultMaterialgroup2;
        Integer QuoteLineIncrement = UTIL_VCPricing.QuoteLineIncrement;
        UTIL_VCPricing.getOrderMasterData('OR');
        Test.stopTest();
    }

    @isTest static void test_getSBOForVC_Config()
    {
        MockSBO_EnosixOpportunityPricing_Detail sbo = new MockSBO_EnosixOpportunityPricing_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixOpportunityPricing_Detail.class, sbo);
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_DOC_TYPE_VALUES.class, new MOC_RFC_SD_GET_DOC_TYPE_VALUES_ET_OUTPUT());

        Test.startTest();
        try {
            UTIL_VCPricing.getSBOForVC_Config(null, null, null);
        } catch (Exception e) {}
        List<DS_VCCharacteristicValues> vcConfig = new List<DS_VCCharacteristicValues>();
        DS_VCCharacteristicValues characteristic = new DS_VCCharacteristicValues();
        characteristic.UserModified = true;
        characteristic.CharacteristicID = 'CharacteristicID';
        vcConfig.add(characteristic);
        ENSX_VCPricingConfiguration pricingConfig = new ENSX_VCPricingConfiguration();
        pricingConfig.ShipToParty = 'ShipToParty';
        UTIL_VCPricing.getSBOForVC_Config('materialNumber', pricingConfig, vcConfig);
        Test.stopTest();
    }

    @isTest static void test_simulatePricing()
    {
        MockSBO_EnosixOpportunityPricing_Detail sbo = new MockSBO_EnosixOpportunityPricing_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixOpportunityPricing_Detail.class, sbo);
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_DOC_TYPE_VALUES.class, new MOC_RFC_SD_GET_DOC_TYPE_VALUES_ET_OUTPUT());
        SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing oppPricingDetail = (SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing) sbo.executeGetDetail(null);

        Test.startTest();
        UTIL_VCPricing.simulatePricing(oppPricingDetail);
        sbo.setSuccess(false);
        try {
            UTIL_VCPricing.simulatePricing(oppPricingDetail);
        } catch (Exception e) {}
        Test.stopTest();
    }

    @isTest static void test_hasErrorMessages()
    {
        Test.startTest();
        ensxsdk.EnosixFramework.Message m1 = new ensxsdk.EnosixFramework.Message(ensxsdk.EnosixFramework.MessageType.ERROR, 'm1');
        try {
            UTIL_VCPricing.hasErrorMessages(new List<ensxsdk.EnosixFramework.Message>());
        } catch (Exception e) {}
        try {
            UTIL_VCPricing.hasErrorMessages(new List<ensxsdk.EnosixFramework.Message>{m1});
        } catch (Exception e) {}
        Test.stopTest();
    }

    @isTest static void test_handleSimulateFailure()
    {
        Test.startTest();
        ensxsdk.EnosixFramework.Message m1 = new ensxsdk.EnosixFramework.Message(ensxsdk.EnosixFramework.MessageType.ERROR, 'm1');
        try {
            UTIL_VCPricing.handleSimulateFailure(new List<ensxsdk.EnosixFramework.Message>());
        } catch (Exception e) {}
        try {
            UTIL_VCPricing.handleSimulateFailure(new List<ensxsdk.EnosixFramework.Message>{m1});
        } catch (Exception e) {}
        Test.stopTest();
    }
}