@isTest
public with sharing class TSTU_EnsxObject
{
    @isTest
    static void test_trimValueObject()
    {
        Test.startTest();
        SBO_EnosixCustomer_Detail.SALES_DATA salesData = new SBO_EnosixCustomer_Detail.SALES_DATA();
        salesData.SalesOrganization = 'SalesOrganization';
        UTIL_EnsxObject.trimValueObject(salesData, salesData);
        Test.stopTest();
    }

    @isTest
    static void test_trimValueObjectList()
    {
        Test.startTest();
        SBO_EnosixCustomer_Detail.EnosixCustomer customer = new SBO_EnosixCustomer_Detail.EnosixCustomer();
        SBO_EnosixCustomer_Detail.SALES_DATA salesData = new SBO_EnosixCustomer_Detail.SALES_DATA();
        salesData.SalesOrganization = 'SalesOrganization';
        customer.SALES_DATA.add(salesData);
        UTIL_EnsxObject.trimValueObjectList(customer.SALES_DATA, customer.SALES_DATA, 'VKORG', new Set <String>());
        Test.stopTest();
    }

    @isTest
    static void test_setValueObject()
    {
        Test.startTest();
        SBO_EnosixCustomer_Detail.SALES_DATA salesData = new SBO_EnosixCustomer_Detail.SALES_DATA();
        salesData.SalesOrganization = 'SalesOrganization';
        UTIL_EnsxObject.setValueObject(salesData, salesData);
        Test.stopTest();
    }

    @isTest
    static void test_setValueObjectList()
    {
        Test.startTest();
        SBO_EnosixCustomer_Detail.EnosixCustomer customer = new SBO_EnosixCustomer_Detail.EnosixCustomer();
        SBO_EnosixCustomer_Detail.SALES_DATA salesData = new SBO_EnosixCustomer_Detail.SALES_DATA();
        salesData.SalesOrganization = 'SalesOrganization';
        customer.SALES_DATA.add(salesData);
        Set <String> deleteActionMap = new Set <String>();
        UTIL_EnsxObject.setValueObjectList(customer.SALES_DATA, customer.SALES_DATA, 'VKORG', null, deleteActionMap);
        UTIL_EnsxObject.setValueObjectList(customer.SALES_DATA, (new SBO_EnosixCustomer_Detail.EnosixCustomer()).SALES_DATA, 'VKORG', null, deleteActionMap);
        customer.SALES_DATA.add(salesData);
        deleteActionMap.add('SalesOrganization');
        UTIL_EnsxObject.setValueObjectList(customer.SALES_DATA, customer.SALES_DATA, 'VKORG', null, deleteActionMap);
        Test.stopTest();
    }

    @isTest
    static void test_deleteItemValueObjectList()
    {
        Test.startTest();
        SBO_EnosixCustomer_Detail.EnosixCustomer customer = new SBO_EnosixCustomer_Detail.EnosixCustomer();
        SBO_EnosixCustomer_Detail.SALES_DATA salesData = new SBO_EnosixCustomer_Detail.SALES_DATA();
        salesData.SalesOrganization = 'SalesOrganization';
        customer.SALES_DATA.add(salesData);
        Set <String> deleteActionMap = new Set <String>();
        deleteActionMap.add('SalesOrganization');
        UTIL_EnsxObject.deleteItemValueObjectList(customer.SALES_DATA, 'VKORG', deleteActionMap);
        Test.stopTest();
    }

    @isTest
    static void test_moveValueObjectList()
    {
        Test.startTest();
        SBO_EnosixCustomer_Detail.EnosixCustomer customer = new SBO_EnosixCustomer_Detail.EnosixCustomer();
        SBO_EnosixCustomer_Detail.SALES_DATA salesData = new SBO_EnosixCustomer_Detail.SALES_DATA();
        salesData.SalesOrganization = '10';
        customer.SALES_DATA.add(salesData);
        Map<Integer, Integer> changeItemNumberMap = new Map<Integer, Integer>();
        changeItemNumberMap.put(10, 10);
        UTIL_EnsxObject.moveValueObjectList(customer.SALES_DATA, 'VKORG', changeItemNumberMap);
        Test.stopTest();
    }
}
