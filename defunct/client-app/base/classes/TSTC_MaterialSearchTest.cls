@isTest
public with sharing class TSTC_MaterialSearchTest
{
    @isTest 
    static void test_ctor()
    {
        Test.startTest();
        CTRL_MaterialSearchTest controller = new CTRL_MaterialSearchTest();
        Test.stopTest();
        System.assert(controller.receiver == controller);
    }

    @isTest 
    static void test_onReceiveMaterialSearchResults()
    {
        CTRL_MaterialSearchTest controller = new CTRL_MaterialSearchTest();
        List<CTRL_MaterialSearch.MaterialSearchResult> testResults = new List<CTRL_MaterialSearch.MaterialSearchResult>();
        CTRL_MaterialSearch.MaterialSearchResult materialResult = new CTRL_MaterialSearch.MaterialSearchResult();
        materialResult.quantity = 1.0;
        materialResult.isSelected = true;
        testResults.add(materialResult);

        Test.startTest();
        controller.onReceiveMaterialSearchResults(null, testResults);
        Test.stopTest();

        System.assert(controller.searchResults.size() == 1);
        System.assert(controller.searchResults.get(0) == materialResult);
    }
}
