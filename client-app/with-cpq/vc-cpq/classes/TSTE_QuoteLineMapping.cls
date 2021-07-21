@isTest
public class TSTE_QuoteLineMapping
{
    @isTest static void testAttributes ()
    {
        Test.startTest();
        ENSX_QuoteLine quoteLine = new ENSX_QuoteLine();
        quoteLine.LineItem = 1;
        ENSX_QuoteLineMapping testObj = new ENSX_QuoteLineMapping(quoteLine, 10);
        Test.stopTest();
    }
}
