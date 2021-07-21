@isTest
public class TSTE_Quote
{
    @isTest static void testAttributes ()
    {
        Test.startTest();
        ENSX_Quote testObj = new ENSX_Quote();
        List<ENSX_QuoteLine> LinkedQuoteLines = testObj.LinkedQuoteLines;
        String instanceUrl = testObj.instanceUrl;
        String QuoteId = testObj.QuoteId;
        String salesOrg = testObj.salesOrg;
        String salesDistChannel = testObj.salesDistChannel;
        String salesDivision = testObj.salesDivision;
        String soldToParty = testObj.soldToParty;
        String shipToParty = testObj.shipToParty;
        String billToParty = testObj.billToParty;
        String payerParty = testObj.payerParty;
        String salesDocType = testObj.salesDocType;
        Map<String,Object> record = testObj.record;
        Object debug = testObj.debug;
        String jsonObj = testObj.recordJSON;
        Test.stopTest();
    }
}
