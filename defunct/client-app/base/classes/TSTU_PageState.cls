@isTest
public with sharing class TSTU_PageState
{
    @isTest 
    static void test_current()
    {
        Test.setCurrentPageReference(new PageReference('Page.VFP_CustomerDetail'));
        UTIL_PageState.current.sfAccountId = 'CURRENT_ACCOUNT';
        System.currentPageReference().getParameters().put('Ignored_Param', 'nothing');

        Test.startTest();
        Map<String, String> values = UTIL_PageState.current.values;
        Test.stopTest();

        System.assert(UTIL_PageState.current.sfAccountId == 'CURRENT_ACCOUNT');
        System.assert(values.containsKey('Ignored_Param') == false);
    }

    @isTest 
    static void test_setCurrentState()
    {
        Test.setCurrentPageReference(new PageReference('Page.VFP_CustomerDetail'));
        UTIL_PageState.current.sfAccountId = '1';

        Test.startTest();

        String ac1 = UTIL_PageState.current.sfAccountId;

        UTIL_PageState newState = new UTIL_PageState();
        newState.sfAccountId = '2';

        UTIL_PageState.setCurrentState(newState);
        String ac2 = UTIL_PageState.current.sfAccountId;

        Test.stopTest();

        System.assert(ac1 == '1');
        System.assert(ac2 == '2');
    }

    @isTest 
    static void test_properties()
    {
        Test.startTest();
        UTIL_PageState state = new UTIL_PageState();

        // test never set property is null
        System.assert(state.sfAccountId == null);

        state.sapAddPartnerTo = 'sapAddPartnerTo';
        state.sapCustomerId = 'sapCustomerId';
        state.sapDeliveryItemNum = 'sapDeliveryItemNum';
        state.sapDeliveryNum = 'sapDeliveryNum';
        state.sapDocNum = 'sapDocNum';
        state.sapDocType = 'sapDocType';
        state.sapInvoiceNum = 'sapInvoiceNum';
        state.sapItemNum = 'sapItemNum';
        state.sapMode = 'sapMode';
        state.sapNoteType = 'sapNoteType';
        state.sapOrderNum = 'sapOrderNum';
        state.sapPartnerType = 'sapPartnerType';
        state.sapPreviousScreen = 'sapPreviousScreen';
        state.sapQuoteId = 'sapQuoteId';
        state.sapRmaId = 'sapRmaId';
        state.sapSalesArea = 'sapSalesArea';
        state.sapShipToNum = 'sapShipToNum';
        state.sfAccountId = 'sfAccountId';
        state.sfCaseId = 'sfCaseId';
        state.sfContactId = 'sfContactId';
        state.sfCpqQuoteId = 'sfCpqQuoteId';
        state.sfMaterialId = 'sfMaterialId';
        state.sfOpportunityId = 'sfOpportunityId';
        state.sfOpportunityProductId = 'sfOpportunityProductId';
        state.sfPlantId = 'sfPlantId';
        state.sfProductId = 'sfProductId';
        state.sfQuoteId = 'sfQuoteId';
        state.sfRecordId = 'sfRecordId';
        state.sfSAPDocNum = 'sfSAPDocNum';
        state.sfSAPDocNum = 'sfSAPDocNum';
        state.sfDocDetailFlowName = 'sfDocDetailFlowName';
        state.ensxReturnToUrl = 'ensxReturnToUrl';
        state.ensxPageRoute = 'ensxPageRoute';

        System.assert(state.sapAddPartnerTo == 'sapAddPartnerTo');
        System.assert(state.sapCustomerId == 'sapCustomerId');
        System.assert(state.sapDeliveryItemNum == 'sapDeliveryItemNum');
        System.assert(state.sapDeliveryNum == 'sapDeliveryNum');
        System.assert(state.sapDocNum == 'sapDocNum');
        System.assert(state.sapDocType == 'sapDocType');
        System.assert(state.sapInvoiceNum == 'sapInvoiceNum');
        System.assert(state.sapItemNum == 'sapItemNum');
        System.assert(state.sapMode == 'sapMode');
        System.assert(state.sapNoteType == 'sapNoteType');
        System.assert(state.sapOrderNum == 'sapOrderNum');
        System.assert(state.sapPartnerType == 'sapPartnerType');
        System.assert(state.sapPreviousScreen == 'sapPreviousScreen');
        System.assert(state.sapQuoteId == 'sapQuoteId');
        System.assert(state.sapRmaId == 'sapRmaId');
        System.assert(state.sapSalesArea == 'sapSalesArea');
        System.assert(state.sapShipToNum == 'sapShipToNum');
        System.assert(state.sfAccountId == 'sfAccountId');
        System.assert(state.sfCaseId == 'sfCaseId');
        System.assert(state.sfContactId == 'sfContactId');
        System.assert(state.sfCpqQuoteId == 'sfCpqQuoteId');
        System.assert(state.sfMaterialId == 'sfMaterialId');
        System.assert(state.sfOpportunityId == 'sfOpportunityId');
        System.assert(state.sfOpportunityProductId == 'sfOpportunityProductId');
        System.assert(state.sfPlantId == 'sfPlantId');
        System.assert(state.sfProductId == 'sfProductId');
        System.assert(state.sfQuoteId == 'sfQuoteId');
        System.assert(state.sfRecordId == 'sfRecordId');
        System.assert(state.sfSAPDocNum == 'sfSAPDocNum');
        System.assert(state.sfDocDetailFlowName == 'sfDocDetailFlowName');
        System.assert(state.ensxReturnToUrl == 'ensxReturnToUrl');
        System.assert(state.ensxPageRoute == 'ensxPageRoute');

        Test.stopTest();
    }

    @isTest 
    static void test_lookupAccountId()
    {
        Test.startTest();
        UTIL_PageState state = new UTIL_PageState();
        state.sfCaseId = 'sfCaseId';
        state.sfQuoteId = 'sfQuoteId';
        state.sfOpportunityId = 'sfOpportunityId';
        state.sfCpqQuoteId = 'sfCpqQuoteId';
        state.sapCustomerId = 'sapCustomerId';
        state.lookupAccountId();
        Test.stopTest();
    }

    @isTest 
    static void test_saveReturnState()
    {
        Test.setCurrentPageReference(new PageReference('Page.VFP_CustomerDetail'));
        UTIL_PageState.current.sfAccountId = 'accid';
        System.currentPageReference().getParameters().put('Ignored_Param', 'nope');

        UTIL_PageState state = new UTIL_PageState();
        Map<String, String> getPageParams = state.getPageParams();

        System.assert(state.ensxReturnToUrl == null);

        Test.startTest();
        state.saveReturnState();
        Test.stopTest();
    }

    @isTest 
    static void test_saveCustomReturnState()
    {
        Test.setCurrentPageReference(new PageReference('Page.Ignored'));
        UTIL_PageState.current.sfAccountId = 'ignored';

        UTIL_PageState state1 = new UTIL_PageState();
        UTIL_PageState state2 = new UTIL_PageState();
        state2.sfAccountId = 'accid';
        state2.sapCustomerId = 'custid';

        Test.startTest();
        state1.saveCustomReturnState('fakePage', state2);
        state2.saveCustomReturnState('fakePage2', null);
        Test.stopTest();

        System.assert(state1.ensxReturnToUrl.startsWith('fakePage'));
        // Query string order is not important, so check params using a
        // PageReference as a help
        PageReference page = new PageReference(state1.ensxReturnToUrl);
        System.assert(state2.ensxReturnToUrl == 'fakePage2');
    }
}
