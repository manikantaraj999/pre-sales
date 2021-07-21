/*
* Test cases for price book utility class
*/
@isTest
public class TSTU_Pricebook
{
    @isTest
    public static void test_getStandardPricebook()
    {
        Test.startTest();
        Id pb = UTIL_Pricebook.getStandardPriceBookId();
        Test.stopTest();
    }

    @isTest
    public static void test_getEntriesForPricebook()
    {
        Test.startTest();
        Account testAcct = TSTU_SFTestObject.createTestAccount();
        TSTU_SFTestObject.upsertWithRetry(testAcct);
        UTIL_Pricebook.getEntriesForPricebookById(testAcct.Id, null);
        UTIL_Pricebook.getEntriesForPricebookById(null, new Set<String>{'Test'});
        UTIL_Pricebook.loadResult(new List<PriceBookEntry>{new PriceBookEntry()}, new Map<Id, PriceBookEntry>());
        Test.stopTest();
    }
}
