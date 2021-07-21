@isTest
public class TSTU_SalesDocument_Detail
{
    @isTest
    public static void test_getCommand()
    {
        UTIL_SalesDocument_Detail documentDetail = new UTIL_SalesDocument_Detail();

        String simulateCommand = documentDetail.getSimulateCommand();
        String referenceCommand = documentDetail.getReferenceDocumentCommand();
    }

    @isTest
    public static void test_buildSBOReference()
    {
        UTIL_SalesDocument_Detail documentDetail = new UTIL_SalesDocument_Detail();
        ensxsdk.EnosixFramework.DetailObject docDetail = documentDetail.buildSBOForReference(null, null);
    }

    @isTest
    public static void test_convertToSBO()
    {
        DS_Document_Detail salesDocDetail = TSTD_Document_Detail.buildSalesDocDetail();
        UTIL_SalesDocument_Detail documentDetail = new UTIL_SalesDocument_Detail();
        DS_SalesDocAppSettings salesDocAppSettings = TSTD_SalesDocAppSettings.buildAppSettings();

        salesDocAppSettings.SBODetailType = 'SalesDocument';

        SBO_EnosixSalesDocument_Detail.EnosixSalesDocument salesDocSBO = 
            (SBO_EnosixSalesDocument_Detail.EnosixSalesDocument) documentDetail.convertToSBO(null, salesDocDetail, false, salesDocAppSettings);

        for (SBO_EnosixSalesDocument_Detail.PARTNERS partner : salesDocSBO.PARTNERS.getAsList()) {
            if (String.isEmpty(partner.ItemNumber)) {
                partner.ItemNumber = '0';
            }
        }
        salesDocSBO = (SBO_EnosixSalesDocument_Detail.EnosixSalesDocument) documentDetail.convertToSBO(salesDocSBO, salesDocDetail, true, salesDocAppSettings);
        salesDocSBO.PARTNERS.clear();
        salesDocSBO.TEXTS.clear();
        salesDocSBO = (SBO_EnosixSalesDocument_Detail.EnosixSalesDocument) documentDetail.convertToSBO(salesDocSBO, salesDocDetail, true, salesDocAppSettings);
        salesDocSBO = (SBO_EnosixSalesDocument_Detail.EnosixSalesDocument) documentDetail.updateTextFields(salesDocSBO, salesDocDetail);

        DS_Document_Detail clonedSalesDocHeader = salesDocDetail.cloneHeader();
        salesDocSBO = (SBO_EnosixSalesDocument_Detail.EnosixSalesDocument) documentDetail.removeAllConditions(salesDocSBO);
    }

    @isTest
    public static void test_convertToObject()
    {
        DS_Document_Detail salesDocDetail = TSTD_Document_Detail.buildSalesDocDetail();
        UTIL_SalesDocument_Detail documentDetail = new UTIL_SalesDocument_Detail();
        DS_SalesDocAppSettings salesDocAppSettings = TSTD_SalesDocAppSettings.buildAppSettings();

        salesDocAppSettings.SBODetailType = 'SalesDocument';

        SBO_EnosixSalesDocument_Detail.EnosixSalesDocument salesDocSBO = 
            (SBO_EnosixSalesDocument_Detail.EnosixSalesDocument) documentDetail.convertToSBO(null, salesDocDetail, false, salesDocAppSettings);

        SBO_EnosixSalesDocument_Detail.INCOMPLETION_LOG newLog1 = new SBO_EnosixSalesDocument_Detail.INCOMPLETION_LOG();
        newLog1.Description = 'Configuration';
        newLog1.ItemNumber = '000010';
        salesDocSBO.INCOMPLETION_LOG.add(newLog1);
        SBO_EnosixSalesDocument_Detail.INCOMPLETION_LOG newLog2 = new SBO_EnosixSalesDocument_Detail.INCOMPLETION_LOG();
        newLog2.Description = 'Configuration';
        newLog2.ItemNumber = '000000';
        salesDocSBO.INCOMPLETION_LOG.add(newLog2);

        SBO_EnosixSalesDocument_Detail.ITEMS_SCHEDULE sched = new SBO_EnosixSalesDocument_Detail.ITEMS_SCHEDULE();
        sched.ItemNumber = '000010';
        salesDocSBO.ITEMS_SCHEDULE.add(sched);

        documentDetail.convertToObject(salesDocSBO, salesDocDetail, false, salesDocAppSettings);
        salesDocDetail = new DS_Document_Detail();
        documentDetail.convertToObject(salesDocSBO, salesDocDetail, true, salesDocAppSettings);
    }
}