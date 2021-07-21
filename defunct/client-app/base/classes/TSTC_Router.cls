@isTest
public class TSTC_Router
{
    @isTest 
    public static void test_actionRoute()
    {
        UTIL_PageState.current.ensxPageRoute = UTIL_PageFlow.VFP_StockSearch;
        CTRL_Router controller = new CTRL_Router();

        Test.startTest();
        PageReference result = controller.actionRoute();
        Test.stopTest();

        System.assert(result.getUrl().startsWith(UTIL_PageFlow.getPageURL(UTIL_PageFlow.VFP_StockSearch)));
    }
}
