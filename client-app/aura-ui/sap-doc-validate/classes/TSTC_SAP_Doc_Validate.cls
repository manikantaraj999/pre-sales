@isTest
public class TSTC_SAP_Doc_Validate
{
    @isTest
    public static void test_sapOrderPricingSimulationFromRebate()
    {
        writeTestRecords();

        Test.startTest();
        CTRL_SAP_Doc_Validate.init(opp.Id, 'Order');
        CTRL_SAP_Doc_Validate.init(opp.Id, 'Quote');
        Test.stopTest();
    }

    static Opportunity opp;

    private static void writeTestRecords()
    {
        Id pricebookId = TSTU_SFTestObject.createTestPriceBook2();
        opp = TSTU_SFTestObject.createTestOpportunity();
        opp.Name = 'TEST OPP';
        opp.CloseDate = Date.today();
        opp.StageName = 'IsWon';
        opp.Pricebook2Id = pricebookId;
        TSTU_SFTestObject.upsertWithRetry(opp);
    }
}