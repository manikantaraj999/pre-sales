@isTest
public class TSTC_VCMaterialConfiguration
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

        public ensxsdk.EnosixFramework.DetailObject executeInitialize(ensxsdk.EnosixFramework.DetailObject initialState) 
        { 
            return null; 
        }

        public ensxsdk.EnosixFramework.DetailObject executeCommand(String command, ensxsdk.EnosixFramework.DetailObject obj) 
        { 
            return this.executeGetDetail(obj);
        }

        public ensxsdk.EnosixFramework.DetailObject executeGetDetail(object key) { 

            SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing result = new SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing();           
            result.setSuccess(success);
            
            SBO_EnosixOpportunityPricing_Detail.ITEMS item = new SBO_EnosixOpportunityPricing_Detail.ITEMS();
            item.ItemNumber = '10';
            item.Material = 'materialID';
            item.HigherLevelItemNumber = '0';
            item.CostInDocCurrency = 5;
            item.OrderQuantity = 1;
            item.NetItemPrice = 10;
            
            result.ITEMS.add(item);

            SBO_EnosixOpportunityPricing_Detail.ITEMS item2 = new SBO_EnosixOpportunityPricing_Detail.ITEMS();
            item2.ItemNumber = '20';
            item2.Material = 'materialID';
            item2.HigherLevelItemNumber = '0';
            item2.CostInDocCurrency = 5;
            item2.OrderQuantity = 1;
            item2.NetItemPrice = 10;
            
            result.ITEMS.add(item2);
            return result;
        }

        public ensxsdk.EnosixFramework.DetailObject executeSave(ensxsdk.EnosixFramework.DetailObject obj) 
        { 
            SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing result = new SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing();
            result.setSuccess(success);
            return result;
         }
    }

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
            
            sditm.DocumentType = 'YSOR';
            sditm.BEZEI = 'Standard';
            sditm.INCPO = '10';
            result.getCollection(RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT.class).add(sditm);
            
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
    
    public class MOC_EnosixVC_Detail implements ensxsdk.EnosixFramework.DetailSBOGetMock,
            ensxsdk.EnosixFramework.DetailSBOSaveMock, ensxsdk.EnosixFramework.DetailSBOCommandMock,
            ensxsdk.EnosixFramework.DetailSBOInitMock
    {
        public boolean success = true;
        public boolean throwException = false;

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

    @isTest static void testInitializeConfiguration ()
    {
        MOC_EnosixVC_Detail mocEnosixVCDetail = new MOC_EnosixVC_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixVC_Detail.class, mocEnosixVCDetail);

        Test.startTest();
        ENSX_VCConfiguration config = (ENSX_VCConfiguration)(CTRL_VCMaterialConfiguration.initializeConfiguration('materialID', '{plant:10, salesorg:20}')).data;
        config = (ENSX_VCConfiguration)(CTRL_VCMaterialConfiguration.initializeConfiguration('materialID', JSON.serialize(new ENSX_VCPricingConfiguration()))).data;
        //config = CTRL_VCMaterialConfiguration.initializeConfiguration('materialID', JSON.serialize(new ENSX_VCPricingConfiguration()));
        Test.stopTest();
    }

    @isTest static void testInitializeCustomConfiguration ()
    {
        MOC_EnosixVC_Detail mocEnosixVCDetail = new MOC_EnosixVC_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixVC_Detail.class, mocEnosixVCDetail);

        Test.startTest();
        DS_VCMaterialConfiguration config = (DS_VCMaterialConfiguration)(CTRL_VCMaterialConfiguration.initializeCustomConfiguration('materialID',
            JSON.serialize(new ENSX_VCPricingConfiguration()))).data;
        config.ConfigurationIsValid = true;
        config.Material = 'Material';
        config.ConfigInstance = 'ConfigInstance';
        config.SalesDocumentType = 'SalesDocumentType';
        config.SalesOrganization = 'SalesOrganization';
        config.DistributionChannel = 'DistributionChannel';
        config.Division = 'Division';
        config.SoldToParty = 'SoldToParty';
        config.ShipToParty = 'ShipToParty';
        config.Plant = 'Plant';
        config.ObjectKey = 'ObjectKey';
        config.ConfigDate = null;
        config.CalculatePrice = true;
        config.ConfigurationIsValid = true;
        config.characteristics = null;
        config.indexedAllowedValues = null;
        config.indexedSelectedValues = null;
        List<DS_VCCharacteristicValues> selectedValues = new List<DS_VCCharacteristicValues>();
        selectedValues.add(new DS_VCCharacteristicValues());
        SBO_EnosixVC_Detail.EnosixVC convertToSBO = config.convertToSBO(selectedValues);
        SBO_EnosixVC_Detail.EnosixVC vcDetail = new SBO_EnosixVC_Detail.EnosixVC();
        vcDetail.CHARACTERISTICS.add(new SBO_EnosixVC_Detail.CHARACTERISTICS());
        config.prepIndexedCollections(vcDetail);
        vcDetail.ALLOWEDVALUES.add(new SBO_EnosixVC_Detail.ALLOWEDVALUES());
        config.getAllowedValuesFromSBOModel(vcDetail);
        vcDetail.SELECTEDVALUES.add(new SBO_EnosixVC_Detail.SELECTEDVALUES());
        config.getSelectedValuesFromSBOModel(vcDetail);
        CTRL_VCMaterialConfiguration.initializeCustomConfiguration('materialID', 'Bad Json');
        Test.stopTest();
    }

    @isTest static void testInitializeConfigurationWithBOM ()
    {
        MOC_EnosixVC_Detail mocEnosixVCDetail = new MOC_EnosixVC_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixVC_Detail.class, mocEnosixVCDetail);

        Test.startTest();
        DS_VCMaterialConfiguration config = 
            (DS_VCMaterialConfiguration)(CTRL_VCMaterialConfiguration.initializeConfigurationWithBOM('materialID',
            JSON.serialize(new ENSX_VCPricingConfiguration()),
            JSON.serialize(new List<DS_VCCharacteristicValues>()))).data;
        CTRL_VCMaterialConfiguration.initializeConfigurationWithBOM('materialID', 'Bad Json', 'Bad Json');
        Test.stopTest();
    }

    /// Variants are not currently supported.
    // @isTest static void testGetMaterialVariants ()
    // {
    //     MOC_EnosixVC_Detail mocEnosixVCDetail = new MOC_EnosixVC_Detail();
    //     ensxsdk.EnosixFramework.setMock(SBO_EnosixVC_Detail.class, mocEnosixVCDetail);

    //     Test.startTest();
    //     List<ENSX_VCMaterialVariant> materialVariantList = CTRL_VCMaterialConfiguration.getMaterialVariants();
    //     System.assert(materialVariantList.size() == 0);
    //     Test.stopTest();
    // }

    @isTest static void testDump ()
    {
        Test.startTest();
        SBO_EnosixVC_Detail.EnosixVC enosixVc = new SBO_EnosixVC_Detail.EnosixVC();
        SBO_EnosixVC_Detail.CHARACTERISTICS characteristic = new SBO_EnosixVC_Detail.CHARACTERISTICS();
        enosixVc.CHARACTERISTICS.add(Characteristic);
        SBO_EnosixVC_Detail.ALLOWEDVALUES allowedValue = new SBO_EnosixVC_Detail.ALLOWEDVALUES();
        enosixVc.ALLOWEDVALUES.add(allowedValue);
        SBO_EnosixVC_Detail.SELECTEDVALUES selectedValue = new SBO_EnosixVC_Detail.SELECTEDVALUES();
        enosixVc.SELECTEDVALUES.add(selectedValue);
        CTRL_VCMaterialConfiguration.dump(enosixVc);
        Test.stopTest();
    }

    @isTest static void testDumpAuraCFG ()
    {
        Test.startTest();
        ENSX_VCConfiguration ensxVCConfiguration = new ENSX_VCConfiguration();
        ENSX_VCCharacteristicValues ensxVCCharcteristicValue = new ENSX_VCCharacteristicValues();
        ensxVcConfiguration.SelectedValues = new List<ENSX_VCCharacteristicValues>();
        ensxVCConfiguration.SelectedValues.add(ensxVCCharcteristicValue);
        ENSX_VCCharacteristic ensxVCCharacteristic = new ENSX_VCCharacteristic();
        ensxVcCharacteristic.PossibleValues = new List<ENSX_VCCharacteristicValues>();
        ensxVCCharacteristic.PossibleValues.add(ensxVCCharcteristicValue);
        ensxVcConfiguration.Characteristics = new List<ENSX_VCCharacteristic>();
        ensxVCConfiguration.Characteristics.add(ensxVCCharacteristic);
        CTRL_VCMaterialConfiguration.dumpAuraCFG(ensxVCConfiguration, true);
        Test.stopTest();
    }

    @isTest static void testFetchInitialSettings ()
    {
        Test.startTest();
        ENSX_VCSettings ensxVcSettings = (ENSX_VCSettings)(CTRL_VCMaterialConfiguration.fetchInitialSettings()).data;
        System.assert(ensxVcSettings.FetchConfigurationFrequencyPossibilities.size() == 7);
        String TEST_JSON = '{"SimulateAddedItems": "bad boolean", "Rules": "bad Rules"}';
        UTIL_AppSettings.settingsMap.put(UTIL_AppSettings.Prefix + UTIL_AppSettings.VC + UTIL_AppSettings.Suffix, (Map<String, Object>)JSON.deserializeUntyped(TEST_JSON));
        ensxVcSettings = (ENSX_VCSettings)(CTRL_VCMaterialConfiguration.fetchInitialSettings()).data;
        Test.stopTest();
    }

    @isTest static void testUpdateSettings ()
    {
        Test.startTest();
        ENSX_VCSettings ensxVcSettings = (ENSX_VCSettings)CTRL_VCMaterialConfiguration.updateSettings('bad data').data;
        ensxVcSettings = (ENSX_VCSettings)CTRL_VCMaterialConfiguration.updateSettings(JSON.serialize(new ENSX_VCSettings())).data;
        Test.stopTest();
    }

    @isTest static void testProcessConfiguration ()
    {
        MOC_EnosixVC_Detail mocEnosixVCDetail = new MOC_EnosixVC_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixVC_Detail.class, mocEnosixVCDetail);

        Test.startTest();
        DS_VCMaterialConfiguration config;
        config = (DS_VCMaterialConfiguration)CTRL_VCMaterialConfiguration.processConfiguration(
            'bad data',
            'bad data',
            JSON.serialize(new List<String>())
        ).data;
        config = (DS_VCMaterialConfiguration)CTRL_VCMaterialConfiguration.processConfiguration(
            JSON.serialize(new DS_VCMaterialConfiguration(new SBO_EnosixVC_Detail.EnosixVC())),
            JSON.serialize(new List<DS_VCCharacteristicValues>()),
            JSON.serialize(new List<String>())
        ).data;
        Test.stopTest();
    }

    @isTest static void testProccessAndLogVCConfiguration ()
    {
        MOC_EnosixVC_Detail mocEnosixVCDetail = new MOC_EnosixVC_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixVC_Detail.class, mocEnosixVCDetail);

        Test.startTest();
        DS_VCMaterialConfiguration config;
        config = CTRL_VCMaterialConfiguration.proccessAndLogVCConfiguration(
            null,
            null,
            null
        );
        config = CTRL_VCMaterialConfiguration.proccessAndLogVCConfiguration(
            new DS_VCMaterialConfiguration(new SBO_EnosixVC_Detail.EnosixVC()),
            new List<DS_VCCharacteristicValues>(),
            new List<String>()
        );
        mocEnosixVCDetail.setSuccess(false);
        config = CTRL_VCMaterialConfiguration.proccessAndLogVCConfiguration(
            new DS_VCMaterialConfiguration(new SBO_EnosixVC_Detail.EnosixVC()),
            new List<DS_VCCharacteristicValues>(),
            new List<String>()
        );
        SBO_EnosixVC_Detail.EnosixVC model = new SBO_EnosixVC_Detail.EnosixVC();
        SBO_EnosixVC_Detail.ALLOWEDVALUES allowed = new SBO_EnosixVC_Detail.ALLOWEDVALUES();
        allowed.CharacteristicName = 'CharacteristicName';
        model.ALLOWEDVALUES.add(allowed);
        DS_VCMaterialConfiguration vcmc = new DS_VCMaterialConfiguration(model);
        Test.stopTest();
    }

    @isTest static void testvalidateProductsInPricebook()
    {

        List<Product2> newProdList = new List<Product2>();

        Product2 product1 = TSTU_SFTestObject.createTestProduct2();
        newProdList.add(product1);

        Product2 product2 = TSTU_SFTestObject.createTestProduct2();
        product2.Name = 'test';
        product2.put(UTIL_SFProduct.MaterialFieldName, 'test');
        newProdList.add(product2);

        Product2 product3 = TSTU_SFTestObject.createTestProduct2();
        newProdList.add(product3);

        TSTU_SFTestObject.upsertWithRetry(newProdList);

        Id standardPricebook = UTIL_Pricebook.getStandardPriceBookId();
        Id priceBookId = TSTU_SFTestObject.createTestPriceBook2();
        Map<Id, PriceBookEntry> standardPricebookEntriesMap = new Map<Id, PriceBookEntry>();
        Map<Id, PriceBookEntry> pricebookEntriesMap = new Map<Id, PriceBookEntry>();
        Integer prodTot = newProdList.size();
        for (Integer prodCnt = 0 ; prodCnt < prodTot ; prodCnt++)
        {
            Product2 prod = newProdList[prodCnt];
            PricebookEntry standardPBE = TSTU_SFTestObject.createTestPriceBookEntry();
            standardPBE.PriceBook2Id = standardPricebook;
            standardPBE.Product2Id = prod.Id;
            standardPBE.Product2 = prod;
            standardPBE.UnitPrice = 100;
            standardPBE.isActive = true;
            standardPricebookEntriesMap.put(prod.Id, standardPBE);
            PricebookEntry priceBookEntry = TSTU_SFTestObject.createTestPriceBookEntry();
            priceBookEntry.PriceBook2Id = priceBookId;
            priceBookEntry.Product2Id = prod.Id;
            priceBookEntry.Product2 = prod;
            priceBookEntry.UnitPrice = 100;
            priceBookEntry.isActive = true;
            pricebookEntriesMap.put(prod.Id, priceBookEntry);
        }

        Map<String, CTRL_VCMaterialConfiguration.ProductModel> result;
        try 
        {            
            result = CTRL_VCMaterialConfiguration.validateProductsInPricebook(
                standardPricebook, new List<string>{'main'},
                new Map<Id, PriceBookEntry>(),
                new Map<String, List<Decimal>>{'main' => new List<Decimal>{1}});
        } 
        catch (ENSX_Exceptions.SimulationException simEx) 
        {
            System.debug('catch simulation exception');
        }
                
        System.assert(result == null);

        result = CTRL_VCMaterialConfiguration.validateProductsInPricebook(
            standardPricebook, new List<string>{product1.Name},
            standardPricebookEntriesMap, new Map<String, List<Decimal>>{product1.Name => new List<Decimal>{1}});
        System.assertEquals(1, result.get(product1.Id).quantity);

        try 
        {            
            standardPricebookEntriesMap.put(product2.Id,standardPricebookEntriesMap.values()[0]);
            result = CTRL_VCMaterialConfiguration.validateProductsInPricebook(
                standardPricebook, new List<string>{product1.Name},
                standardPricebookEntriesMap, new Map<String, List<Decimal>>{product1.Name => new List<Decimal>{1}});
        } 
        catch (Exception e) {}
        
        List<String> materialNumbers = new List<string>{product1.Name, product2.Name, product2.Name, product3.Name};   
        result = CTRL_VCMaterialConfiguration.validateProductsInPricebook(
            priceBookId, materialNumbers,
            pricebookEntriesMap,
            new Map<String, List<Decimal>>{
                product1.Name => new List<Decimal>{1}, 
                product2.Name => new List<Decimal>{2,4},
                product3.Name => new List<Decimal>{3}});

        System.assertEquals(4, result.size());
        System.assertEquals(1, result.get(product1.Id).quantity);
        System.assertEquals(2, result.get(product2.Id).quantity);
        System.assertEquals(3, result.get(product3.Id).quantity);

        String prodName = product2.Name + ' (1)';
        Product2 placeholderProduct = [SELECT Id, Name FROM Product2 WHERE Name = :prodName LIMIT 1];
        System.assertEquals(4, result.get(placeholderProduct.Id).quantity);

        Product2 product4 = TSTU_SFTestObject.createTestProduct2();
        product4.Name = prodName;
        product4.put(UTIL_SFProduct.MaterialFieldName, prodName);
        TSTU_SFTestObject.upsertWithRetry(product4);

        try 
        {            
            CTRL_VCMaterialConfiguration.addPlaceholderProduct(new Map<String, CTRL_VCMaterialConfiguration.ProductModel>(), product2.Name, 
                '', priceBookId, 1, new List<Decimal>{1,1,1,1,1});
        } 
        catch (Exception e) {}
    }

    @isTest static void testSimulateItem()
    {
        MOC_EnosixVC_Detail mocEnosixVCDetail = new MOC_EnosixVC_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixVC_Detail.class, mocEnosixVCDetail);
        MOC_RFC_SD_GET_DOC_TYPE_VALUES mocRfc = new MOC_RFC_SD_GET_DOC_TYPE_VALUES();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_DOC_TYPE_VALUES.class, mocRfc);
        MockSBO_EnosixOpportunityPricing_Detail mocOpp = new MockSBO_EnosixOpportunityPricing_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixOpportunityPricing_Detail.class, mocOpp);

        Opportunity opp = TSTU_SFTestObject.createTestOpportunity();

        Test.startTest();
        CTRL_VCMaterialConfiguration.simulateItem(
            'materialID',
            JSON.serialize(new ENSX_VCPricingConfiguration()),
            JSON.serialize(new List<DS_VCCharacteristicValues>()),
            opp.Id
        );
        try {
            CTRL_VCMaterialConfiguration.simulateItem(
                'bad material',
                JSON.serialize(new ENSX_VCPricingConfiguration()),
                JSON.serialize(new List<DS_VCCharacteristicValues>()),
                opp.Id
            );
        } catch (Exception e) {}
        try {
            CTRL_VCMaterialConfiguration.simulateItem(
                '',
                JSON.serialize(new ENSX_VCPricingConfiguration()),
                JSON.serialize(new List<DS_VCCharacteristicValues>()),
                opp.Id
            );
        } catch (Exception e) {}
        Test.stopTest();
    }
}