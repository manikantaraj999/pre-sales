@isTest
public with sharing class TSTU_Order
{
    @isTest
    public static void test_allowedItemCategoriesByOrderType()
    {
        Test.startTest();
        Map<String, Set<String>> allowedItemCategoriesByOrderType = UTIL_Order.allowedItemCategoriesByOrderType;
        Test.stopTest();
    }
}