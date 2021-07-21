@isTest
public class TSTE_CPQ_QuoteCalculationService
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
            SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing result = new SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing();           
            result.setSuccess(success);
            
            SBO_EnosixOpportunityPricing_Detail.ITEMS topItem1 = new SBO_EnosixOpportunityPricing_Detail.ITEMS();
            topItem1.ItemNumber = '10';
            topItem1.Material = 'MAT0';
            topItem1.HigherLevelItemNumber = '0';
            topItem1.CostInDocCurrency = 5;
            topItem1.OrderQuantity = 1;
            topItem1.NetItemPrice = 10;
            
            SBO_EnosixOpportunityPricing_Detail.ITEMS childItem1 = new SBO_EnosixOpportunityPricing_Detail.ITEMS();
            childItem1.ItemNumber = '11';
            childItem1.Material = 'MAT1';
            childItem1.HigherLevelItemNumber = '10';
            childItem1.CostInDocCurrency = 6;
            childItem1.OrderQuantity = 1;
            childItem1.NetItemPrice = 10;

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
            
            SBO_EnosixOpportunityPricing_Detail.ITEMS childItem5 = new SBO_EnosixOpportunityPricing_Detail.ITEMS();
            childItem5.ItemNumber = '15';
            childItem5.Material = 'MAT3';
            childItem5.HigherLevelItemNumber = '14';
            childItem5.CostInDocCurrency = 5;
            childItem5.OrderQuantity = 2;
            childItem5.NetItemPrice = 10;
            
            SBO_EnosixOpportunityPricing_Detail.ITEMS childItem6 = new SBO_EnosixOpportunityPricing_Detail.ITEMS();
            childItem6.ItemNumber = '16';
            childItem6.Material = 'MAT3';
            childItem6.HigherLevelItemNumber = '14';
            childItem6.CostInDocCurrency = 5;
            childItem6.OrderQuantity = 2;
            childItem6.NetItemPrice = 10;
            
            SBO_EnosixOpportunityPricing_Detail.ITEMS topItem2 = new SBO_EnosixOpportunityPricing_Detail.ITEMS();
            topItem2.ItemNumber = '30';
            topItem2.Material = 'MAT0';
            topItem2.HigherLevelItemNumber = '0';
            topItem2.CostInDocCurrency = 5;
            topItem2.OrderQuantity = 1;
            topItem2.NetItemPrice = 10;
            
            SBO_EnosixOpportunityPricing_Detail.ITEMS childItem7 = new SBO_EnosixOpportunityPricing_Detail.ITEMS();
            childItem7.ItemNumber = '21';
            childItem7.Material = 'MAT1';
            childItem7.HigherLevelItemNumber = '30';
            childItem7.CostInDocCurrency = 6;
            childItem7.OrderQuantity = 1;
            childItem7.NetItemPrice = 10;

            SBO_EnosixOpportunityPricing_Detail.ITEMS childItem8 = new SBO_EnosixOpportunityPricing_Detail.ITEMS();
            childItem8.ItemNumber = '22';
            childItem8.Material = 'MAT2';
            childItem8.HigherLevelItemNumber = '30';
            childItem8.CostInDocCurrency = 5;
            childItem8.OrderQuantity = 2;
            childItem8.NetItemPrice = 10;

            SBO_EnosixOpportunityPricing_Detail.ITEMS childItem9 = new SBO_EnosixOpportunityPricing_Detail.ITEMS();
            childItem9.ItemNumber = '23';
            childItem9.Material = 'MAT2';
            childItem9.HigherLevelItemNumber = '30';
            childItem9.CostInDocCurrency = 5;
            childItem9.OrderQuantity = 2;
            childItem9.NetItemPrice = 10;

            result.ITEMS.add(topItem1);
            result.ITEMS.add(childItem1);
            result.ITEMS.add(childItem2);
            result.ITEMS.add(childItem3);
            result.ITEMS.add(childItem4);
            result.ITEMS.add(childItem5);
            result.ITEMS.add(childItem6);
            result.ITEMS.add(topItem2);
            result.ITEMS.add(childItem7);
            result.ITEMS.add(childItem8);
            result.ITEMS.add(childItem9);

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

        public ensxsdk.EnosixFramework.DetailObject executeSave(ensxsdk.EnosixFramework.DetailObject obj) { 
            SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing result = new SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing();
            result.setSuccess(success);
            return result;
        }
    }

    @isTest
    static public void test_doPost()
    {
        string TEST_JSON = '{"ListPriceConditionType":"TEST",' + 
            '"UnitCostConditionType":"TEST",' + 
            '"SecondaryUnitCostConditionType":"SECOND"}';
        UTIL_AppSettings.settingsMap.put(UTIL_AppSettings.Prefix + UTIL_AppSettings.CPQ + UTIL_AppSettings.Suffix, (Map<String, Object>)JSON.deserializeUntyped(TEST_JSON));

        MockSBO_EnosixOpportunityPricing_Detail sbo = new MockSBO_EnosixOpportunityPricing_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixOpportunityPricing_Detail.class, sbo);
        
        MOC_RFC_SD_GET_DOC_TYPE_VALUES mocRfc = new MOC_RFC_SD_GET_DOC_TYPE_VALUES();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_DOC_TYPE_VALUES.class, mocRfc);

        Test.startTest();
        String response = ENSX_CPQ_QuoteCalculationService.doPost(JSON.serialize(new ENSX_Quote()));
        response = ENSX_CPQ_QuoteCalculationService.doPost('Bad Data');
        Test.stopTest();
    }

    @isTest
    static public void test_prepareQuoteAndSimulate()
    {
        string TEST_JSON = '{"ListPriceConditionType":"TEST",' + 
            '"UnitCostConditionType":"TEST",' + 
            '"SecondaryUnitCostConditionType":"SECOND"}';
        UTIL_AppSettings.settingsMap.put(UTIL_AppSettings.Prefix + UTIL_AppSettings.CPQ + UTIL_AppSettings.Suffix, (Map<String, Object>)JSON.deserializeUntyped(TEST_JSON));

        MockSBO_EnosixOpportunityPricing_Detail sbo = new MockSBO_EnosixOpportunityPricing_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixOpportunityPricing_Detail.class, sbo);
        
        MOC_RFC_SD_GET_DOC_TYPE_VALUES mocRfc = new MOC_RFC_SD_GET_DOC_TYPE_VALUES();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_DOC_TYPE_VALUES.class, mocRfc);

        ENSX_Quote qte = new ENSX_Quote();

        Product2 prod = TSTU_CPQ_TestSetup.createProduct2();

        // initialize sObjects
        List<SObject> acctAndQuote = TSTU_CPQ_TestSetup.createAccountQuoteLinked();
        Account acct = (Account)acctAndQuote[0];
        SBQQ__Quote__c quote = (SBQQ__Quote__c)acctAndQuote[1];
        ENSX_Quote quoteHeaderConfig = new ENSX_Quote();
        quote.SAP_Configuration__c = JSON.serialize(quoteHeaderConfig);
        TSTU_SFTestObject.upsertWithRetry(quote);
        
        ENSX_Characteristic chars = new ENSX_Characteristic();
        chars.CharacteristicID = 'TEST';
        chars.CharacteristicName = 'TEST';
        chars.CharacteristicValue = 'TEST';
        chars.UserModified = true;

        List<ENSX_Characteristic> lstChars = new List<ENSX_Characteristic>();
        lstChars.add(chars);

        ENSX_ItemConfiguration conf = new ENSX_ItemConfiguration();
        conf.plant = 'PLANT';
        conf.materialNumber = 'TEST';
        conf.selectedCharacteristics = lstChars;
        conf.SalesDocumentCurrency = 'TEST';
        conf.OrderQuantity = 0;
        
        ENSX_QuoteLine qLine1 = new ENSX_QuoteLine();
        qLine1.Product = prod.Id;
        qLine1.LineItem = 1;
        qLine1.SAPMaterialNumber = 'MAT0';
        qLine1.Quantity = 1;
        qLine1.ListPrice = 5;
        qLine1.NetPrice = 5;
        qLine1.Plant = 'Plant';
        qLine1.NetWeight = 11;
        qLine1.Description = 'TEST';
        qLine1.NetCost = 2;
        qLine1.UnitCost = 2;
        qLine1.CostPrice = 2;
        qLine1.DiscountPercent = 10;
        qLine1.ATPDate = date.Today();
        qLine1.ItemJSON = JSON.serialize(conf);
        qLine1.IsProductFeature = false;
        qLine1.ItemConfiguration = conf;
        qLine1.RealProductId = '';

        ENSX_QuoteLine qLine2 = new ENSX_QuoteLine();
        qLine2.Product = prod.Id;
        qLine2.ParentLineItem = 1;
        qLine2.LineItem = 2;
        qLine2.SAPMaterialNumber = 'MAT1';
        qLine2.Quantity = 1;
        qLine2.ListPrice = 5;
        qLine2.NetPrice = 5;
        qLine2.Plant = 'Plant';
        qLine2.NetWeight = 11;
        qLine2.Description = 'TEST';
        qLine2.NetCost = 2;
        qLine2.UnitCost = 2;
        qLine2.CostPrice = 2;
        qLine2.DiscountPercent = 10;
        qLine2.ATPDate = date.Today();
        qLine2.ItemJSON = JSON.serialize(conf);
        qLine2.IsProductFeature = true;
        qLine2.ItemConfiguration = conf;
        qLine2.RealProductId = 'Real';        

        ENSX_QuoteLine qLine3 = new ENSX_QuoteLine();
        qLine3.Product = prod.Id;
        qLine3.ParentLineItem = 1;
        qLine3.LineItem = 3;
        qLine3.SAPMaterialNumber = 'MAT1';
        qLine3.Quantity = 1;
        qLine3.IsProductFeature = true;

        List<ENSX_QuoteLine> lstQuoteLine = new List<ENSX_QuoteLine>();
        lstQuoteLine.add(qLine1);
        lstQuoteLine.add(qLine2);
        lstQuoteLine.add(qLine3);

        qte.LinkedQuoteLines = lstQuoteLine;
        qte.instanceUrl = 'example.com';
        qte.QuoteId = quote.Id;
        qte.salesOrg = 'TEST';
        qte.salesDistChannel = 'TEST';
        qte.salesDivision = 'TEST';
        qte.soldToParty = 'TEST';
        qte.shipToParty = 'TEST';
        qte.salesDocType = 'TEST';

		// Test affirmative case:
        Test.startTest();
        String response = ENSX_CPQ_QuoteCalculationService.prepareQuoteAndSimulate(qte, false);
        
        sbo.setSuccess(false);
        response = ENSX_CPQ_QuoteCalculationService.prepareQuoteAndSimulate(qte, false);

        sbo.setSuccess(true);
        sbo.setThrowException(true);
        response = ENSX_CPQ_QuoteCalculationService.prepareQuoteAndSimulate(qte, false);

        sbo.setThrowException(false);
        ENSX_QuoteLineMapping qlm = ENSX_CPQ_QuoteCalculationService.preCalculateState.get(1);
        qlm.SAPLineItem = 30;
        
		Test.stopTest();
    }

    @isTest
    static public void test_updateENSX_QuoteForSBOResults()
    {
        string TEST_JSON = '{"ListPriceConditionType":"TEST",' + 
            '"UnitCostConditionType":"TEST",' + 
            '"SecondaryUnitCostConditionType":"SECOND"}';
        UTIL_AppSettings.settingsMap.put(UTIL_AppSettings.Prefix + UTIL_AppSettings.CPQ + UTIL_AppSettings.Suffix, (Map<String, Object>)JSON.deserializeUntyped(TEST_JSON));

        MockSBO_EnosixOpportunityPricing_Detail sbo = new MockSBO_EnosixOpportunityPricing_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixOpportunityPricing_Detail.class, sbo);
        
        MOC_RFC_SD_GET_DOC_TYPE_VALUES mocRfc = new MOC_RFC_SD_GET_DOC_TYPE_VALUES();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_DOC_TYPE_VALUES.class, mocRfc);

        ENSX_Quote qte = new ENSX_Quote();

        Product2 prod = TSTU_CPQ_TestSetup.createProduct2();
        prod.put(UTIL_SFProduct.MaterialFieldName, 'MAT2');
        TSTU_SFTestObject.upsertWithRetry(prod);

        // initialize sObjects
        List<SObject> acctAndQuote = TSTU_CPQ_TestSetup.createAccountQuoteLinked();
        Account acct = (Account)acctAndQuote[0];
        SBQQ__Quote__c quote = (SBQQ__Quote__c)acctAndQuote[1];
        ENSX_Quote quoteHeaderConfig = new ENSX_Quote();
        quote.SAP_Configuration__c = JSON.serialize(quoteHeaderConfig);
        TSTU_SFTestObject.upsertWithRetry(quote);
        
        ENSX_Characteristic chars = new ENSX_Characteristic();
        chars.CharacteristicID = 'TEST';
        chars.CharacteristicName = 'TEST';
        chars.CharacteristicValue = 'TEST';
        chars.UserModified = true;

        List<ENSX_Characteristic> lstChars = new List<ENSX_Characteristic>();
        lstChars.add(chars);

        ENSX_ItemConfiguration conf = new ENSX_ItemConfiguration();
        conf.plant = 'PLANT';
        conf.materialNumber = 'TEST';
        conf.selectedCharacteristics = lstChars;
        conf.SalesDocumentCurrency = 'TEST';
        conf.OrderQuantity = 0;
        
        ENSX_QuoteLine qLine1 = new ENSX_QuoteLine();
        qLine1.Product = prod.Id;
        qLine1.LineItem = 1;
        qLine1.SAPMaterialNumber = 'MAT0';
        qLine1.Quantity = 1;
        qLine1.IsProductFeature = false;

        ENSX_QuoteLine qLine2 = new ENSX_QuoteLine();
        qLine2.Product = prod.Id;
        qLine2.ParentLineItem = 1;
        qLine2.LineItem = 2;
        qLine2.SAPMaterialNumber = 'MAT1';
        qLine2.Quantity = 1;
        qLine2.IsProductFeature = true;

        ENSX_QuoteLine qLine3 = new ENSX_QuoteLine();
        qLine3.Product = prod.Id;
        qLine3.ParentLineItem = 1;
        qLine3.LineItem = 3;
        qLine3.SAPMaterialNumber = 'MAT1';
        qLine3.Quantity = 1;
        qLine3.IsProductFeature = true;
        
        ENSX_QuoteLine qLine4 = new ENSX_QuoteLine();
        qLine4.Product = prod.Id;
        qLine4.LineItem = 4;
        qLine4.SAPMaterialNumber = 'MAT0';
        qLine4.Quantity = 1;
        qLine4.IsProductFeature = false;

        ENSX_QuoteLine qLine5 = new ENSX_QuoteLine();
        qLine5.Product = prod.Id;
        qLine5.ParentLineItem = 4;
        qLine5.LineItem = 3;
        qLine5.SAPMaterialNumber = 'MAT1';
        qLine5.Quantity = 1;
        qLine5.IsProductFeature = true;

        ENSX_QuoteLine qLine6 = new ENSX_QuoteLine();
        qLine6.Product = prod.Id;
        qLine6.ParentLineItem = 4;
        qLine6.LineItem = 3;
        qLine6.SAPMaterialNumber = 'MAT1';
        qLine6.Quantity = 1;
        qLine6.IsProductFeature = true;
        
        ENSX_QuoteLine qLine7 = new ENSX_QuoteLine();
        qLine7.Product = prod.Id;
        qLine7.LineItem = 7;
        qLine7.SAPMaterialNumber = 'MAT0';
        qLine7.Quantity = 1;
        qLine7.IsProductFeature = false;

        ENSX_QuoteLine qLine8 = new ENSX_QuoteLine();
        qLine8.Product = prod.Id;
        qLine8.ParentLineItem = 7;
        qLine8.LineItem = 3;
        qLine8.SAPMaterialNumber = 'MAT1';
        qLine8.Quantity = 1;
        qLine8.IsProductFeature = true;

        ENSX_QuoteLine qLine9 = new ENSX_QuoteLine();
        qLine9.Product = prod.Id;
        qLine9.ParentLineItem = 7;
        qLine9.LineItem = 3;
        qLine9.SAPMaterialNumber = 'MAT1';
        qLine9.Quantity = 1;
        qLine9.IsProductFeature = true;
        
        ENSX_QuoteLine qLine10 = new ENSX_QuoteLine();
        qLine10.Product = prod.Id;
        qLine10.LineItem = 10;
        qLine10.SAPMaterialNumber = 'MAT0';
        qLine10.Quantity = 1;
        qLine10.IsProductFeature = false;

        ENSX_QuoteLine qLine11 = new ENSX_QuoteLine();
        qLine11.Product = prod.Id;
        qLine11.ParentLineItem = 11;
        qLine11.LineItem = 3;
        qLine11.SAPMaterialNumber = 'MAT1';
        qLine11.Quantity = 1;
        qLine11.IsProductFeature = true;

        ENSX_QuoteLine qLine12 = new ENSX_QuoteLine();
        qLine12.Product = prod.Id;
        qLine12.ParentLineItem = 12;
        qLine12.LineItem = 3;
        qLine12.SAPMaterialNumber = 'MAT1';
        qLine12.Quantity = 1;
        qLine12.IsProductFeature = true;

        List<ENSX_QuoteLine> lstQuoteLine = new List<ENSX_QuoteLine>();
        lstQuoteLine.add(qLine1);
        lstQuoteLine.add(qLine2);
        lstQuoteLine.add(qLine3);
        lstQuoteLine.add(qLine4);
        lstQuoteLine.add(qLine5);
        lstQuoteLine.add(qLine6);
        lstQuoteLine.add(qLine7);
        lstQuoteLine.add(qLine8);
        lstQuoteLine.add(qLine9);

        qte.LinkedQuoteLines = lstQuoteLine;
        qte.QuoteId = quote.Id;

        SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing sapQuote = (SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing) sbo.executeGetDetail(null);

		// Test affirmative case:
        Test.startTest();
        ENSX_CPQ_QuoteCalculationService.prepareQuoteAndSimulate(qte, true);
        ENSX_CPQ_QuoteCalculationService.updateENSX_QuoteForSBOResults(qte, sapQuote, true);     
        lstQuoteLine.add(qLine10);
        lstQuoteLine.add(qLine11);
        lstQuoteLine.add(qLine12);
        qte.LinkedQuoteLines = lstQuoteLine;
        ENSX_CPQ_QuoteCalculationService.prepareQuoteAndSimulate(qte, true);
        ENSX_CPQ_QuoteCalculationService.updateENSX_QuoteForSBOResults(qte, sapQuote, true);     
		Test.stopTest();
    }

    @isTest
    static public void test_processMessage()
    {
        ENSX_Quote qte = new ENSX_Quote();
        ENSX_QuoteLine qLine = new ENSX_QuoteLine();
        qLine.LineItem = 1;
        qLine.ItemNumber = '100';
        qLine.SAPMaterialNumber = 'MAT0';
        List<ENSX_QuoteLine> lstQuoteLine = new List<ENSX_QuoteLine>();
        lstQuoteLine.add(qLine);
        qte.LinkedQuoteLines = lstQuoteLine;

        Test.startTest();
        ENSX_CPQ_QuoteCalculationService.processMessage(qte, 'Internal error:, 100, Message,');
        Test.stopTest();
    }

    @isTest
    static public void test_concatSboMessages()
    {
        Test.startTest();
        ENSX_CPQ_QuoteCalculationService.concatSboMessages(new List<ensxsdk.EnosixFramework.Message>{
            new ensxsdk.EnosixFramework.Message(ensxsdk.EnosixFramework.MessageType.ERROR,'TEST1'),
            new ensxsdk.EnosixFramework.Message(ensxsdk.EnosixFramework.MessageType.ERROR,'TEST2')
        });
        ENSX_CPQ_QuoteCalculationService.concatSboMessages(null);
        Test.stopTest();
    }

    @isTest
    static void test_applyQuoteRequestMappingRules()
    {
        string TEST_JSON = '{"Pricing": {"Request": {"Quote": {"RecordMapping": [ ' +
            '{"sObjectField":"FLD_Document_Type__c","sboCollection":"sales","sboTarget":"SalesDocumentType"},' +
            '{"sObjectField":"FLD_Sales_Organization__c","sboCollection":"sales","sboTarget":"SalesOrganization"},' +
            '{"sObjectField":"FLD_Distribution_Channel__c","sboCollection":"sales","sboTarget":"DistributionChannel"},' +
            '{"sObjectField":"FLD_Division__c","sboCollection":"sales","sboTarget":"Division"},' +
            '{"sObjectField":"FLD_Sold_To_Number__c","sboCollection":"sales","sboTarget":"SoldToParty"},' +
            '{"sObjectField":"CurrencyIsoCode","sboCollection":"sales","sboTarget":"SalesDocumentCurrency"},' +
            '{"sObjectField":"FLD_Sold_To_Number__c","sboCollection":"header","sboTarget":"SoldToParty"},' +
            '{"sObjectField":"CurrencyIsoCode","sboCollection":"header","sboTarget":"SalesDocumentCurrency"},' +
            '{"sObjectField":"FLD_Sold_To_Number__c","sboCollection":"partners","sboTarget":"CustomerNumber","partnerType":"SoldToParty"},' +
            '{"sObjectField":"FLD_Sold_To_Number__c","sboCollection":"partners","sboTarget":"CustomerNumber","partnerType":"SoldToParty"},' +
            '{"sObjectField":"FLD_Ship_To_Number__c","sboCollection":"partners","sboTarget":"CustomerNumber","partnerType":"ShipToParty"},' +
            '{"sObjectField":"FLD_Bill_To_Number__c","sboCollection":"partners","sboTarget":"CustomerNumber","partnerType":"BillToParty"},' +
            '{"sObjectField":"FLD_Payer_Number__c","sboCollection":"partners","sboTarget":"CustomerNumber","partnerType":"PayerParty"}' +
            ']}}}}';
        UTIL_AppSettings.settingsMap.put(UTIL_AppSettings.Prefix + UTIL_AppSettings.CPQ + UTIL_AppSettings.Suffix, (Map<String, Object>)JSON.deserializeUntyped(TEST_JSON));

        MockSBO_EnosixOpportunityPricing_Detail sbo = new MockSBO_EnosixOpportunityPricing_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixOpportunityPricing_Detail.class, sbo);
        ENSX_Quote qte = new ENSX_Quote();
        Product2 prod = TSTU_CPQ_TestSetup.createProduct2();
        // initialize sObjects
        List<SObject> acctAndQuote = TSTU_CPQ_TestSetup.createAccountQuoteLinked();
        Account acct = (Account)acctAndQuote[0];
        SBQQ__Quote__c quote = (SBQQ__Quote__c)acctAndQuote[1];
        ENSX_Quote quoteHeaderConfig = new ENSX_Quote();
        quote.SAP_Configuration__c = JSON.serialize(quoteHeaderConfig);
        TSTU_SFTestObject.upsertWithRetry(quote);

        ENSX_Characteristic chars = new ENSX_Characteristic();
        chars.CharacteristicID = 'TEST';
        chars.CharacteristicName = 'TEST';
        chars.CharacteristicValue = 'TEST';
        chars.UserModified = true;

        List<ENSX_Characteristic> lstChars = new List<ENSX_Characteristic>();
        lstChars.add(chars);

        ENSX_ItemConfiguration conf = new ENSX_ItemConfiguration();
        conf.plant = 'PLANT';
        conf.materialNumber = 'TEST';
        conf.selectedCharacteristics = lstChars;
        conf.SalesDocumentCurrency = 'TEST';
        conf.OrderQuantity = 0;
        
        ENSX_QuoteLine qLine = new ENSX_QuoteLine();
        qLine.Product = prod.Id;
        qLine.LineItem = 1;
        qLine.SAPMaterialNumber = 'TEST';
        qLine.Quantity = 1;
        qLine.ListPrice = 5;
        qLine.NetPrice = 5;
        qLine.Plant = 'Plant';
        qLine.NetWeight = 11;
        qLine.Description = 'TEST';
        qLine.NetCost = 2;
        qLine.UnitCost = 2;
        qLine.CostPrice = 2;
        qLine.DiscountPercent = 10;
        qLine.ATPDate = date.Today();
        qLine.ItemJSON = JSON.serialize(conf);
        qLine.IsProductFeature = false;
        qLine.ItemConfiguration = conf;
        qLine.RealProductId = '';

        List<ENSX_QuoteLine> lstQuoteLine = new List<ENSX_QuoteLine>();
        lstQuoteLine.add(qLine);

        qte.LinkedQuoteLines = lstQuoteLine;
        qte.instanceUrl = 'example.com';
        qte.QuoteId = quote.Id;
        qte.salesOrg = 'TEST';
        qte.salesDistChannel = 'TEST';
        qte.salesDivision = 'TEST';
        qte.soldToParty = 'TEST';
        qte.shipToParty = 'TEST';
        qte.salesDocType = 'TEST';
        SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing oppPricingDetail = (SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing) sbo.executeGetDetail(null);
        oppPricingDetail.SoldToParty = qte.soldToParty;
        oppPricingDetail.SALES.SalesDocumentType = qte.salesDocType;
        oppPricingDetail.SALES.SalesOrganization = qte.salesOrg;
        oppPricingDetail.SALES.DistributionChannel = qte.salesDistChannel;
        oppPricingDetail.SALES.Division = qte.salesDivision;
        SBO_EnosixOpportunityPricing_Detail.PARTNERS soldToPartner = new SBO_EnosixOpportunityPricing_Detail.PARTNERS();
        soldToPartner.PartnerFunction = UTIL_Customer.SOLD_TO_PARTNER_CODE;
        soldToPartner.CustomerNumber = qte.soldToParty;
        oppPricingDetail.PARTNERS.add(soldToPartner);

        SBO_EnosixOpportunityPricing_Detail.PARTNERS shipTo = new SBO_EnosixOpportunityPricing_Detail.PARTNERS();
        shipTo.PartnerFunction = UTIL_Customer.SHIP_TO_PARTNER_CODE;
        shipTo.CustomerNumber = qte.soldToParty;
        oppPricingDetail.PARTNERS.add(shipTo);
        qte.recordJSON = '{"CurrencyIsoCode": "USD",' +
            '"Order_Reason__c": "TEST",' +
            '"Price_Date__c": "2019-10-23 00:00:00",' +
            '"FLD_Document_Type__c": "Type",' +
            '"FLD_Sales_Organization__c": "SO",' +
            '"FLD_Distribution_Channel__c": "DC",' +
            '"FLD_Division__c": "D",' +
            '"FLD_Sold_To_Number__c": "SoldTo",' +
            '"FLD_Ship_To_Number__c": "ShipTo",' +
            '"FLD_Bill_To_Number__c": "BillTo",' +
            '"FLD_Payer_Number__c": "Payer"' +
            '}';
        quote.FLD_Document_Type__c = 'Type';
        quote.FLD_Sales_Organization__c = 'SO';
        quote.FLD_Distribution_Channel__c = 'DC';
        quote.FLD_Division__c = 'DI';
        quote.FLD_Ship_To_Number__c = 'ShipTo';
        quote.FLD_Bill_To_Number__c = 'BillTo';
        quote.FLD_Payer_Number__c = 'Payer';
        Test.startTest();
        ENSX_CPQ_QuoteCalculationService.applyQuoteRequestMappingRules(qte,oppPricingDetail);
        ENSX_CPQ_QuoteCalculationService.cpqPricingConfig = null;
        UTIL_AppSettings.settingsMap.put(UTIL_AppSettings.Prefix + UTIL_AppSettings.CPQ + UTIL_AppSettings.Suffix, (Map<String, Object>)JSON.deserializeUntyped('{}'));
        ENSX_CPQ_QuoteCalculationService.applyQuoteRequestMappingRules(qte,oppPricingDetail);

        Test.stopTest();
    }    

    @isTest
    static void test_applyQuoteResponseMappingRules()
    {
        string TEST_JSON ='{"Pricing":{"Response":'+
        '{"Quote":{"RecordMapping":[{"sObjectField":"Cash_Discounts__c","sboCollection":"condition","sboTarget":"SKTO","transform":"conditionValue"},'+
        '{"sObjectField":"Tax_Amount__c","sboCollection":"header","sboTarget":"TaxAmount"}]}}}}';
        UTIL_AppSettings.settingsMap.put(UTIL_AppSettings.Prefix + UTIL_AppSettings.CPQ + UTIL_AppSettings.Suffix, (Map<String, Object>)JSON.deserializeUntyped(TEST_JSON));
       

        ENSX_Quote qte = new ENSX_Quote();
        List<SObject> acctAndQuote = TSTU_CPQ_TestSetup.createAccountQuoteLinked();
        Account acct = (Account)acctAndQuote[0];
        SBQQ__Quote__c quote = (SBQQ__Quote__c)acctAndQuote[1];
        ENSX_Quote quoteHeaderConfig = new ENSX_Quote();
        quote.SAP_Configuration__c = JSON.serialize(quoteHeaderConfig);
        TSTU_SFTestObject.upsertWithRetry(quote);

        qte.instanceUrl = 'example.com';
        qte.QuoteId = quote.Id;
        qte.salesOrg = 'TEST';
        qte.salesDistChannel = 'TEST';
        qte.salesDivision = 'TEST';
        qte.soldToParty = 'TEST';
        qte.shipToParty = 'TEST';
        qte.salesDocType = 'TEST';

        SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing sbo = new SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing(); 
        SBO_EnosixOpportunityPricing_Detail.CONDITIONS itemCond = new SBO_EnosixOpportunityPricing_Detail.CONDITIONS();
        itemCond.ConditionItemNumber = '1';
        itemCond.ConditionType = 'TEST';
        itemCond.Rate = 2;
        sbo.CONDITIONS.add(itemCond);
        SBO_EnosixOpportunityPricing_Detail.CONDITIONS itemCond2 = new SBO_EnosixOpportunityPricing_Detail.CONDITIONS();
        itemCond2.ConditionItemNumber = '1';
        itemCond2.ConditionType = 'SECOND';
        itemCond2.Rate = 10;
        sbo.CONDITIONS.add(itemCond2);

        Map<Integer,Map<String,List<SBO_EnosixOpportunityPricing_Detail.CONDITIONS>>> itemsConditions = new Map<Integer,Map<String,List<SBO_EnosixOpportunityPricing_Detail.CONDITIONS>>>();
        List<SBO_EnosixOpportunityPricing_Detail.CONDITIONS> condList = sbo.CONDITIONS.getAsList();
        Integer condTot = condList.size();
        for (Integer condCnt = 0 ; condCnt < condTot ; condCnt++)
        {
            SBO_EnosixOpportunityPricing_Detail.CONDITIONS condition = condList[condCnt];
            Integer i = Integer.valueOf(condition.ConditionItemNumber);
            Map<String,List<SBO_EnosixOpportunityPricing_Detail.CONDITIONS>> conditionMap = itemsConditions.get(i);
            if (null == conditionMap)
            {
                conditionMap = new Map<String,List<SBO_EnosixOpportunityPricing_Detail.CONDITIONS>>();
                itemsConditions.put(i, conditionMap);
            }
            List<SBO_EnosixOpportunityPricing_Detail.CONDITIONS> conditionList = 
                conditionMap.containsKey(condition.ConditionType) ? conditionMap.get(condition.ConditionType) : 
                new List<SBO_EnosixOpportunityPricing_Detail.CONDITIONS>();
            conditionList.add(condition);
            conditionMap.put(condition.ConditionType, conditionList);
        }
        qte.recordJSON = '{"Cash_Discounts__c": "10", "Tax_Amount__c": "20"}';
        Test.startTest();
        ENSX_CPQ_QuoteCalculationService.applyQuoteResponseMappingRules(qte,sbo,itemsConditions.get(0));
        Test.stopTest();
    }

    @isTest
    static void test_applyQuoteLineRequestMappingRules()
    {        
        string TEST_JSON ='{"Pricing":{"Request":{"QuoteLine":{"RecordMapping":['+
            '{"sObjectField":"Unit_of_Measure__c","sboCollection":"item","sboTarget":"SalesUnit"},'+
            '{"sObjectField":"Project_DCP_Discount_Percent__c","sboCollection":"item","sboTarget":"unrecognized"},'+
            '{"sObjectField":"Project_DCP_Discount_Percent__c","sboCollection":"condition","sboTarget":"ZSD4","transform":"conditionRateAsPercent"},'+
            '{"sObjectField":"Project_DCP_Discount_Percent__c","sboCollection":"condition","sboTarget":"ZSD4","transform":"conditionRateDiscountAsPercent"},'+
            '{"sObjectField":"Project_DCP_Discount_Percent__c","sboCollection":"condition","sboTarget":"ZSD4","transform":"conditionRate"},'+
            '{"sObjectField":"Project_DCP_Discount_Percent__c","sboCollection":"condition","sboTarget":"ZSD4","transform":"conditionRateDiscount"},'+
            '{"sObjectField":"Project_DCP_Discount_Percent__c","sboCollection":"condition","sboTarget":"ZSD4","transform":"unrecognized"}'+
            ']}}}}';
        UTIL_AppSettings.settingsMap.put(UTIL_AppSettings.Prefix + UTIL_AppSettings.CPQ + UTIL_AppSettings.Suffix, (Map<String, Object>)JSON.deserializeUntyped(TEST_JSON));

        ENSX_Quote qte = new ENSX_Quote();
        Product2 prod = TSTU_CPQ_TestSetup.createProduct2();

        MockSBO_EnosixOpportunityPricing_Detail sbo = new MockSBO_EnosixOpportunityPricing_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixOpportunityPricing_Detail.class, sbo);
        List<SObject> acctAndQuote = TSTU_CPQ_TestSetup.createAccountQuoteLinked();
        Account acct = (Account)acctAndQuote[0];
        SBQQ__Quote__c quote = (SBQQ__Quote__c)acctAndQuote[1];
        ENSX_Quote quoteHeaderConfig = new ENSX_Quote();
        quote.SAP_Configuration__c = JSON.serialize(quoteHeaderConfig);
        TSTU_SFTestObject.upsertWithRetry(quote);

        ENSX_Characteristic chars = new ENSX_Characteristic();
        chars.CharacteristicID = 'TEST';
        chars.CharacteristicName = 'TEST';
        chars.CharacteristicValue = 'TEST';
        chars.UserModified = true;

        List<ENSX_Characteristic> lstChars = new List<ENSX_Characteristic>();
        lstChars.add(chars);

        ENSX_ItemConfiguration conf = new ENSX_ItemConfiguration();
        conf.plant = 'PLANT';
        conf.materialNumber = 'TEST';
        conf.selectedCharacteristics = lstChars;
        conf.SalesDocumentCurrency = 'TEST';
        conf.OrderQuantity = 0;

        ENSX_QuoteLine qLine = new ENSX_QuoteLine();
        qLine.Product = prod.Id;
        qLine.LineItem = 1;
        qLine.SAPMaterialNumber = 'TEST';
        qLine.Quantity = 1;
        qLine.ListPrice = 5;
        qLine.NetPrice = 5;
        qLine.Plant = 'Plant';
        qLine.NetWeight = 11;
        qLine.Description = 'TEST';
        qLine.NetCost = 2;
        qLine.UnitCost = 2;
        qLine.CostPrice = 2;
        qLine.DiscountPercent = 10;
        qLine.ATPDate = date.Today();
        qLine.ItemJSON = JSON.serialize(conf);
        qLine.IsProductFeature = false;
        qLine.ItemConfiguration = conf;
        qLine.RealProductId = '';

        List<ENSX_QuoteLine> lstQuoteLine = new List<ENSX_QuoteLine>();
        lstQuoteLine.add(qLine);

        qte.LinkedQuoteLines = lstQuoteLine;
        qte.instanceUrl = 'example.com';
        qte.QuoteId = quote.Id;
        qte.salesOrg = 'TEST';
        qte.salesDistChannel = 'TEST';
        qte.salesDivision = 'TEST';
        qte.soldToParty = 'TEST';
        qte.shipToParty = 'TEST';
        qte.salesDocType = 'TEST';

        SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing oppPricingDetail = (SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing) sbo.executeGetDetail(null);
        oppPricingDetail.SoldToParty = qte.soldToParty;
        oppPricingDetail.SALES.SalesDocumentType = qte.salesDocType;
        oppPricingDetail.SALES.SalesOrganization = qte.salesOrg;
        oppPricingDetail.SALES.DistributionChannel = qte.salesDistChannel;
        oppPricingDetail.SALES.Division = qte.salesDivision;
        SBO_EnosixOpportunityPricing_Detail.PARTNERS soldToPartner = new SBO_EnosixOpportunityPricing_Detail.PARTNERS();
        soldToPartner.PartnerFunction = UTIL_Customer.SOLD_TO_PARTNER_CODE;
        soldToPartner.CustomerNumber = qte.soldToParty;
        oppPricingDetail.PARTNERS.add(soldToPartner);

        SBO_EnosixOpportunityPricing_Detail.PARTNERS shipTo = new SBO_EnosixOpportunityPricing_Detail.PARTNERS();
        shipTo.PartnerFunction = UTIL_Customer.SHIP_TO_PARTNER_CODE;
        shipTo.CustomerNumber = qte.soldToParty;
        oppPricingDetail.PARTNERS.add(shipTo);

        SBO_EnosixOpportunityPricing_Detail.ITEMS itm = new SBO_EnosixOpportunityPricing_Detail.ITEMS();
        itm.ItemNumber = '1';
        itm.Material = 'test';
        itm.Plant = qLine.ItemConfiguration.plant;
        itm.OrderQuantity = qLine.Quantity;
        itm.Materialgroup1 = 'test1';
        itm.Materialgroup2 = 'test2';
        oppPricingDetail.Items.add(itm);
        qLine.recordJSON = '{"Unit_of_Measure__c": "KG", "Project_DCP_Discount_Percent__c": "10"}';
        ENSX_CPQ_QuoteCalculationService.applyQuoteLineRequestMappingRules(qLine, itm, oppPricingDetail);
        ENSX_CPQ_QuoteCalculationService.cpqPricingConfig = null;
        UTIL_AppSettings.settingsMap.put(UTIL_AppSettings.Prefix + UTIL_AppSettings.CPQ + UTIL_AppSettings.Suffix, (Map<String, Object>)JSON.deserializeUntyped('{}'));
        ENSX_CPQ_QuoteCalculationService.applyQuoteLineRequestMappingRules(qLine, itm, oppPricingDetail);
    }

    @isTest
    static void test_applyQuoteLineResponseMappingRules()
    {
        string TEST_JSON ='{"Pricing":{"Response":{"QuoteLine":{"RecordMapping":['+
            '{"sObjectField":"ListPrice","sboCollection":"condition","sboTarget":"ZSD6","transform":"conditionValueDiscountPerItemQuantity"},'+
            '{"sObjectField":"ListPrice","sboCollection":"item","sboTarget":"NetItemPrice"},'+
            '{"sObjectField":"ListPrice","sboCollection":"item","sboTarget":"ItemNumber"},'+
            '{"sObjectField":"ListPrice","sboCollection":"item","sboTarget":"SalesUnit"},'+
            '{"sObjectField":"ListPrice","sboCollection":"item","sboTarget":"unrecognized"},'+
            '{"sObjectField":"ListPrice","sboCollection":"unrecognized","sboTarget":"unrecognized"}'+
            ']}}}}';
        UTIL_AppSettings.settingsMap.put(UTIL_AppSettings.Prefix + UTIL_AppSettings.CPQ + UTIL_AppSettings.Suffix, (Map<String, Object>)JSON.deserializeUntyped(TEST_JSON));

        ENSX_Quote qte = new ENSX_Quote();
        Product2 prod = TSTU_CPQ_TestSetup.createProduct2();
        List<SObject> acctAndQuote = TSTU_CPQ_TestSetup.createAccountQuoteLinked();
        Account acct = (Account)acctAndQuote[0];
        SBQQ__Quote__c quote = (SBQQ__Quote__c)acctAndQuote[1];
        ENSX_Quote quoteHeaderConfig = new ENSX_Quote();
        quote.SAP_Configuration__c = JSON.serialize(quoteHeaderConfig);
        TSTU_SFTestObject.upsertWithRetry(quote);

        ENSX_Characteristic chars = new ENSX_Characteristic();
        chars.CharacteristicID = 'TEST';
        chars.CharacteristicName = 'TEST';
        chars.CharacteristicValue = 'TEST';
        chars.UserModified = true;

        List<ENSX_Characteristic> lstChars = new List<ENSX_Characteristic>();
        lstChars.add(chars);

        ENSX_ItemConfiguration conf = new ENSX_ItemConfiguration();
        conf.plant = 'PLANT';
        conf.materialNumber = 'TEST';
        conf.selectedCharacteristics = lstChars;
        conf.SalesDocumentCurrency = 'TEST';
        conf.OrderQuantity = 0;

        ENSX_QuoteLine qLine = new ENSX_QuoteLine();
        qLine.Product = prod.Id;
        qLine.LineItem = 1;
        qLine.SAPMaterialNumber = 'TEST';
        qLine.Quantity = 1;
        qLine.ListPrice = 5;
        qLine.NetPrice = 5;
        qLine.Plant = 'Plant';
        qLine.NetWeight = 11;
        qLine.Description = 'TEST';
        qLine.NetCost = 2;
        qLine.UnitCost = 2;
        qLine.CostPrice = 2;
        qLine.DiscountPercent = 10;
        qLine.ATPDate = date.Today();
        qLine.ItemJSON = JSON.serialize(conf);
        qLine.IsProductFeature = false;
        qLine.ItemConfiguration = conf;
        qLine.RealProductId = '';

        List<ENSX_QuoteLine> lstQuoteLine = new List<ENSX_QuoteLine>();
        lstQuoteLine.add(qLine);

        qte.LinkedQuoteLines = lstQuoteLine;
        qte.instanceUrl = 'example.com';
        qte.QuoteId = quote.Id;
        qte.salesOrg = 'TEST';
        qte.salesDistChannel = 'TEST';
        qte.salesDivision = 'TEST';
        qte.soldToParty = 'TEST';
        qte.shipToParty = 'TEST';
        qte.salesDocType = 'TEST';

        SBO_EnosixOpportunityPricing_Detail.ITEMS itm = new SBO_EnosixOpportunityPricing_Detail.ITEMS();
        itm.ItemNumber = '1';
        itm.Material = 'test';
        itm.Plant = qLine.ItemConfiguration.plant;
        itm.OrderQuantity = qLine.Quantity;
        itm.Materialgroup1 = 'test1';
        itm.Materialgroup2 = 'test2';        

        SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing sbo = new SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing(); 
        SBO_EnosixOpportunityPricing_Detail.CONDITIONS itemCond = new SBO_EnosixOpportunityPricing_Detail.CONDITIONS();
        itemCond.ConditionItemNumber = '1';
        itemCond.ConditionType = 'TEST';
        itemCond.Rate = 2;
        sbo.CONDITIONS.add(itemCond);
        SBO_EnosixOpportunityPricing_Detail.CONDITIONS itemCond2 = new SBO_EnosixOpportunityPricing_Detail.CONDITIONS();
        itemCond2.ConditionItemNumber = '1';
        itemCond2.ConditionType = 'SECOND';
        itemCond2.Rate = 10;
        sbo.CONDITIONS.add(itemCond2);

        Map<Integer,Map<String,List<SBO_EnosixOpportunityPricing_Detail.CONDITIONS>>> itemsConditions = new Map<Integer,Map<String,List<SBO_EnosixOpportunityPricing_Detail.CONDITIONS>>>();
        List<SBO_EnosixOpportunityPricing_Detail.CONDITIONS> condList = sbo.CONDITIONS.getAsList();
        Integer condTot = condList.size();
        for (Integer condCnt = 0 ; condCnt < condTot ; condCnt++)
        {
            SBO_EnosixOpportunityPricing_Detail.CONDITIONS condition = condList[condCnt];
            Integer i = Integer.valueOf(condition.ConditionItemNumber);
            Map<String,List<SBO_EnosixOpportunityPricing_Detail.CONDITIONS>> conditionMap = itemsConditions.get(i);
            if (null == conditionMap)
            {
                conditionMap = new Map<String,List<SBO_EnosixOpportunityPricing_Detail.CONDITIONS>>();
                itemsConditions.put(i, conditionMap);
            }
            List<SBO_EnosixOpportunityPricing_Detail.CONDITIONS> conditionList = 
                conditionMap.containsKey(condition.ConditionType) ? conditionMap.get(condition.ConditionType) : 
                new List<SBO_EnosixOpportunityPricing_Detail.CONDITIONS>();
            conditionList.add(condition);
            conditionMap.put(condition.ConditionType, conditionList);
        }
        qLine.recordJSON = '{"SAP_Line_Number__c": "1", "Unit_of_Measure__c": "KG","SBQQ__ListPrice__c":"1.00"}';       
        ENSX_CPQ_QuoteCalculationService.applyQuoteLineResponseMappingRules(qLine,itm,itemsConditions.get(0));
    }

    @isTest
    static void test_transformConditionToValue()
    {
        string TEST_JSON ='{"Pricing":{"Response":{"Quote":{"RecordMapping":['+
            '{"sObjectField":"Cash_Discounts__c","sboCollection":"condition","sboTarget":"SKTO","transform":"conditionValue"},'+
            '{"sObjectField":"Tax_Amount__c","sboCollection":"header","sboTarget":"TaxAmount"}]},'+
            '"QuoteLine":{"RecordMapping":['+
            '{"sObjectField":"ListPrice","sboCollection":"condition","sboTarget":"ZSD6","transform":"conditionValue"},'+
            '{"sObjectField":"ListPrice","sboCollection":"condition","sboTarget":"ZSD6","transform":"conditionValueDiscount"},'+
            '{"sObjectField":"ListPrice","sboCollection":"condition","sboTarget":"ZSD6","transform":"conditionValuePerItemQuantity"},'+
            '{"sObjectField":"ListPrice","sboCollection":"condition","sboTarget":"ZSD6","transform":"conditionValueDiscountPerItemQuantity"},'+
            '{"sObjectField":"ListPrice","sboCollection":"condition","sboTarget":"ZSD6","transform":"conditionRateAsPercent"},'+
            '{"sObjectField":"ListPrice","sboCollection":"condition","sboTarget":"ZSD6","transform":"conditionRateDiscountAsPercent"},'+
            '{"sObjectField":"ListPrice","sboCollection":"condition","sboTarget":"ZSD6","transform":"conditionRate"},'+
            '{"sObjectField":"ListPrice","sboCollection":"condition","sboTarget":"ZSD6","transform":"conditionRateDiscount"},'+
            '{"sObjectField":"ListPrice","sboCollection":"condition","sboTarget":"ZSD6","transform":"conditionRateUnit"},'+
            '{"sObjectField":"ListPrice","sboCollection":"condition","sboTarget":"ZSD6","transform":"unrecognized"}'+
            ']}}}}';
        UTIL_AppSettings.settingsMap.put(UTIL_AppSettings.Prefix + UTIL_AppSettings.CPQ + UTIL_AppSettings.Suffix, (Map<String, Object>)JSON.deserializeUntyped(TEST_JSON));
        ENSX_CPQ_QuoteCalculationService.CPQPricingConfig c = (ENSX_CPQ_QuoteCalculationService.CPQPricingConfig)UTIL_AppSettings.getSObject(UTIL_AppSettings.CPQ, 'Pricing',ENSX_CPQ_QuoteCalculationService.CPQPricingConfig.class, null);
        List<ENSX_CPQ_QuoteCalculationService.CPQPricingConfigMappingRule> rules = c.Response.QuoteLine.RecordMapping;

        SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing sbo = new SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing(); 
        SBO_EnosixOpportunityPricing_Detail.CONDITIONS itemCond = new SBO_EnosixOpportunityPricing_Detail.CONDITIONS();
        itemCond.ConditionItemNumber = '1';
        itemCond.ConditionType = 'ZSD6';
        itemCond.Rate = 2;
        itemCond.KWERT = 1;
        itemCond.RateUnit = 'RateUnit';
        sbo.CONDITIONS.add(itemCond);
        SBO_EnosixOpportunityPricing_Detail.CONDITIONS itemCond2 = new SBO_EnosixOpportunityPricing_Detail.CONDITIONS();
        itemCond2.ConditionItemNumber = '2';
        itemCond2.ConditionType = 'ZSD6';
        itemCond2.Rate = 10;
        itemCond2.KWERT = 1;
        itemCond2.RateUnit = 'RateUnit';
        sbo.CONDITIONS.add(itemCond2);

        //Map<Integer,Map<String,SBO_EnosixOpportunityPricing_Detail.CONDITIONS>> itemsConditions = new Map<Integer,Map<String,SBO_EnosixOpportunityPricing_Detail.CONDITIONS>>();
        
        Map<String,List<SBO_EnosixOpportunityPricing_Detail.CONDITIONS>> conditionMap = new Map<String,List<SBO_EnosixOpportunityPricing_Detail.CONDITIONS>>();
        List<SBO_EnosixOpportunityPricing_Detail.CONDITIONS> condList = sbo.CONDITIONS.getAsList();
        Integer condTot = condList.size();
        for (Integer condCnt = 0 ; condCnt < condTot ; condCnt++)
        {
            SBO_EnosixOpportunityPricing_Detail.CONDITIONS condition = condList[condCnt];
            List<SBO_EnosixOpportunityPricing_Detail.CONDITIONS> conditionList = 
                conditionMap.containsKey(condition.ConditionType) ? conditionMap.get(condition.ConditionType) : 
                new List<SBO_EnosixOpportunityPricing_Detail.CONDITIONS>();
            conditionList.add(condition);
            conditionMap.put(condition.ConditionType, conditionList);
        }
        
        test.startTest();        
        Integer ruleTot = rules.size();
        for (Integer ruleCnt = 0 ; ruleCnt < ruleTot ; ruleCnt++)
        {
            ENSX_CPQ_QuoteCalculationService.CPQPricingConfigMappingRule rule = rules[ruleCnt];
             ENSX_CPQ_QuoteCalculationService.transformConditionToValue(rule,conditionMap,1);
        }       
        test.stopTest();      

    }

    @isTest
    static void test_processConditions()
    {
        test.startTest();        
        ENSX_CPQ_QuoteCalculationService.processConditions(
            null, 
            null, 
            new Map<Integer,Map<String,List<SBO_EnosixOpportunityPricing_Detail.CONDITIONS>>>(),
            new Map<String,Map<Integer,Decimal>>());
        ENSX_CPQ_QuoteCalculationService.processConditions(
            new Set<String>(), 
            new SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing(),
            new Map<Integer,Map<String,List<SBO_EnosixOpportunityPricing_Detail.CONDITIONS>>>(),
            new Map<String,Map<Integer,Decimal>>());        
		Test.stopTest();
    }

    @isTest
    static void test_Variable()
    {
        Object testObj = ENSX_CPQ_QuoteCalculationService.conditionType;
        testObj = ENSX_CPQ_QuoteCalculationService.defaultSalesDocType;
        testObj = ENSX_CPQ_QuoteCalculationService.defaultSalesOrg;
        testObj = ENSX_CPQ_QuoteCalculationService.defaultDistributionChannel;
        testObj = ENSX_CPQ_QuoteCalculationService.defaultDivision;
        testObj = ENSX_CPQ_QuoteCalculationService.defaultCustomerNumber;
        testObj = ENSX_CPQ_QuoteCalculationService.listPriceConditionType;
        testObj = ENSX_CPQ_QuoteCalculationService.unitCostConditionType;
        testObj = ENSX_CPQ_QuoteCalculationService.secondaryUnitCostConditionType;
        testObj = ENSX_CPQ_QuoteCalculationService.defaultItemPlant;
    }
}