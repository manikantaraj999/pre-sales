@isTest
public class TSTU_Document_Detail
{
    private static final String sboDetailType = 'SalesDocument';

    @isTest
    public static void test_simulateCommand()
    {
        String simulateCommand = UTIL_Document_Detail.getSimulateCommand(sboDetailType);
    }

    @isTest
    public static void test_referenceCommand()
    {
        String referenceCommand = UTIL_Document_Detail.getReferenceDocumentCommand(sboDetailType);
    }

    @isTest
    public static void test_removeAllConditions()
    {
        ensxsdk.EnosixFramework.DetailObject docDetail = UTIL_Document_Detail.removeAllConditions(
            new SBO_EnosixSalesDocument_Detail.EnosixSalesDocument(), sboDetailType);
    }

    @isTest
    public static void test_updateTextFields()
    {
        DS_Document_Detail salesDocDetail = new DS_Document_Detail();

        ensxsdk.EnosixFramework.DetailObject docDetail = UTIL_Document_Detail.updateTextFields(
            new SBO_EnosixSalesDocument_Detail.EnosixSalesDocument(), salesDocDetail, sboDetailType);
    }

    @isTest
    public static void test_buildSBOReference()
    {
        ensxsdk.EnosixFramework.DetailObject docDetail = UTIL_Document_Detail.buildSBOForReference('111', 'Test', sboDetailType);
    }

    @isTest
    public static void test_convertToSBO()
    {
        DS_Document_Detail salesDocDetail = new DS_Document_Detail();
        DS_SalesDocAppSettings salesDocAppSettings = new DS_SalesDocAppSettings();
        salesDocAppSettings.SBODetailType = sboDetailType;

        ensxsdk.EnosixFramework.DetailObject salesDocSBO = UTIL_Document_Detail.convertToSBO(null, salesDocDetail, false, salesDocAppSettings);
    }

    @isTest
    public static void test_convertToObject()
    {
        DS_Document_Detail salesDocDetail = new DS_Document_Detail();
        DS_SalesDocAppSettings salesDocAppSettings = new DS_SalesDocAppSettings();
        salesDocAppSettings.SBODetailType = sboDetailType;

        UTIL_Document_Detail.convertToObject(new SBO_EnosixSalesDocument_Detail.EnosixSalesDocument(), salesDocDetail, false, salesDocAppSettings);
    }

    @isTest
    public static void test_getPartnerFromDocumentDetail()
    {
        List<DS_Document_Detail.PARTNERS> partnerList = new List<DS_Document_Detail.PARTNERS>();

        UTIL_Document_Detail.getPartnerFromDocumentDetail(partnerList, 'partnerFunction', true);
        UTIL_Document_Detail.getPartnerFromDocumentDetail(partnerList, 'partnerFunction', true);
    }
}