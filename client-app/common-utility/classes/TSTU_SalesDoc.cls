@isTest
public class TSTU_SalesDoc
{
    @isTest
    public static void test_saveHeaderAndLineItems()
    {
        Account newAccount = TSTU_SFTestObject.createTestAccount();
        newAccount.put(UTIL_SFAccount.CustomerFieldName, '1111');
        TSTU_SFTestObject.upsertWithRetry(newAccount);

        Id pricebookId = UTIL_Pricebook.getStandardPriceBookId();
        Opportunity opp = TSTU_SFTestObject.createTestOpportunity();

        Product2 product = TSTU_SFTestObject.createTestProduct2();
        product.put(UTIL_SFProduct.MaterialFieldName, 'Material1');

        List<OpportunityLineItem> lineItems = new List<OpportunityLineItem>();
        OpportunityLineItem lineItem1 = TSTU_SFTestObject.createTestOpportunityLineItem();
		lineItem1.Quantity = 10;
		lineItem1.UnitPrice = .95;
		lineItem1.Description = 'test Desciption';
        lineItem1.ServiceDate = System.today();
        lineItems.add(lineItem1);

        OpportunityLineItem lineItem2 = TSTU_SFTestObject.createTestOpportunityLineItem();
        lineItem2.FLD_SAP_Item_Number__c = '000010';
		lineItem2.Quantity = 10;
		lineItem2.UnitPrice = .95;
		lineItem2.Description = 'test Desciption';
        lineItem2.ServiceDate = System.today();
        lineItems.add(lineItem2);

        UTIL_SalesDoc.SFObject sfObject = new UTIL_SalesDoc.SFObject();
        sfObject.sfObjectType = 'Opportunity';
        sfObject.sfObjectLabel = 'Opportunity';
        sfObject.initFromSObject = true;
        sfObject.sfMainObject = opp;
        sfObject.sfLineItems = lineItems;
        sfObject.customerNumber = '1111';

        DS_Document_Detail salesDocDetail = TSTD_Document_Detail.buildSalesDocDetail();

        UTIL_SalesDoc.saveHeaderAndLineItems(sfObject, salesDocDetail, 'Quote', true);

        OpportunityLineItem lineItem3 = TSTU_SFTestObject.createTestOpportunityLineItem();
        lineItem3.FLD_SAP_Item_Number__c = '000020';
		lineItem3.Quantity = 10;
		lineItem3.UnitPrice = .95;
		lineItem3.Description = 'test Desciption';
        lineItem3.ServiceDate = System.today();
        lineItems.clear();
        lineItems.add(lineItem3);

        salesDocDetail.ITEMS[0].sfId = 'testId';

        UTIL_SalesDoc.saveHeaderAndLineItems(sfObject, salesDocDetail, 'Quote', true);

        Set<String> materialNumbers = new Set<String>{product.Name, 'Not Found Material'};
        try {
            UTIL_SalesDoc.validateMaterials(materialNumbers, pricebookId, new Map<String, PricebookEntry>());
            PriceBookEntry pbe = TSTU_SFTestObject.createTestPriceBookEntry();
            pbe.UnitPrice = 100;
            pbe.Product2 = product;
            pbe.UseStandardPrice = false;
            pbe.IsActive = true;
            List<PriceBookEntry> entries = new List<PriceBookEntry>{pbe};
            UTIL_SalesDoc.validateMaterialsFromPBEList(materialNumbers, pricebookId, new Map<String, PricebookEntry>(), entries);
        }
        catch (Exception ex) {}
    }

    @isTest
    public static void test_getSFObjectInfo()
    {
        Account newAccount = TSTU_SFTestObject.createTestAccount();
        TSTU_SFTestObject.upsertWithRetry(newAccount);

        Opportunity opp = TSTU_SFTestObject.createTestOpportunity();
        opp.AccountId = newAccount.Id;
        TSTU_SFTestObject.upsertWithRetry(opp);

        UTIL_SalesDoc.SFObject result = UTIL_SalesDoc.getSFObjectInfo(newAccount.Id, 'Quote');
        newAccount.put(UTIL_SFAccount.CustomerFieldName, '1111');
        TSTU_SFTestObject.upsertWithRetry(newAccount);

        result = UTIL_SalesDoc.getSFObjectInfo(opp.Id, 'Order');

        result = UTIL_SalesDoc.getSFObjectInfo(opp.Id, 'Order');

        result = UTIL_SalesDoc.getSFObjectInfo(opp.Id, 'Quote');

        result = UTIL_SalesDoc.getSFObjectInfo(opp.Id, 'Contract');

        result = UTIL_SalesDoc.getSFObjectInfo(opp.Id, 'Inquiry');

        result = UTIL_SalesDoc.getSFObjectInfo(opp.Id, 'Credit Memo');

        result = UTIL_SalesDoc.getSFObjectInfo(opp.Id, 'Debit Memo');

        result = UTIL_SalesDoc.getSFObjectInfo(opp.Id, 'Return Order');

        result = UTIL_SalesDoc.getSFObjectInfo('bad id', 'Order');
    }

    @isTest
    public static void test_mapSalesDocDetailFromSFObject()
    {
        DS_Document_Detail salesDocDetail = new DS_Document_Detail();
        UTIL_SalesDoc.SFObject sfObject = new UTIL_SalesDoc.SFObject();
        DS_SalesDocAppSettings appSettings = new DS_SalesDocAppSettings();

        DS_Document_Detail newSalesDocDetail = UTIL_SalesDoc.mapSalesDocDetailFromSFObject(salesDocDetail, sfObject, appSettings);
    }

    @isTest
    public static void test_convertAppSettingPartners()
    {
        List<DS_SalesDocAppSettings.PartnerSetting> appSettingPartners = new List<DS_SalesDocAppSettings.PartnerSetting>();
        DS_SalesDocAppSettings.PartnerSetting partnerSetting = new DS_SalesDocAppSettings.PartnerSetting();
        partnerSetting.PartnerFunction = 'SH';
        partnerSetting.PartnerFunctionName = 'Ship';
        partnerSetting.ComponentType = 'TEST';
        appSettingPartners.add(partnerSetting);

        List<DS_Document_Detail.PARTNERS> partners = UTIL_SalesDoc.convertAppSettingPartnersToPartners(appSettingPartners);
    }

    @isTest
    public static void test_convertAppSettingTexts()
    {
        Map<String, String> appSettingTexts = new Map<String, String>{
            '0001' => 'tests'
        };

        List<DS_Document_Detail.TEXTS> texts = UTIL_SalesDoc.convertAppSettingTextsToTexts(appSettingTexts, 'EN');
    }
}