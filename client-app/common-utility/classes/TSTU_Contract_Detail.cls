@isTest
public class TSTU_Contract_Detail
{
    @isTest
    public static void test_getCommand()
    {
        UTIL_Contract_Detail documentDetail = new UTIL_Contract_Detail();

        String simulateCommand = documentDetail.getSimulateCommand();
        String referenceCommand = documentDetail.getReferenceDocumentCommand();
    }

    @isTest
    public static void test_buildSBOReference()
    {
        UTIL_Contract_Detail documentDetail = new UTIL_Contract_Detail();
        ensxsdk.EnosixFramework.DetailObject docDetail = documentDetail.buildSBOForReference(null, null);
    }

    @isTest
    public static void test_convertToSBO()
    {
        DS_Document_Detail salesDocDetail = TSTD_Document_Detail.buildSalesDocDetail();
        UTIL_Contract_Detail documentDetail = new UTIL_Contract_Detail();
        DS_SalesDocAppSettings salesDocAppSettings = TSTD_SalesDocAppSettings.buildAppSettings();

        salesDocAppSettings.SBODetailType = 'Contract';

        SBO_EnosixContract_Detail.EnosixContract salesDocSBO = 
            (SBO_EnosixContract_Detail.EnosixContract) documentDetail.convertToSBO(null, salesDocDetail, false, salesDocAppSettings);

        for (SBO_EnosixContract_Detail.PARTNERS partner : salesDocSBO.PARTNERS.getAsList()) {
            if (String.isEmpty(partner.ItemNumber)) {
                partner.ItemNumber = '0';
            }
        }
        for (SBO_EnosixContract_Detail.CONTRACT contract : salesDocSBO.CONTRACT.getAsList()) {
            if (String.isEmpty(contract.ItemNumber)) {
                contract.ItemNumber = '0';
            }
        }
        salesDocSBO = (SBO_EnosixContract_Detail.EnosixContract) documentDetail.convertToSBO(salesDocSBO, salesDocDetail, true, salesDocAppSettings);
        salesDocSBO.CONTRACT.clear();
        salesDocSBO.PARTNERS.clear();
        salesDocSBO.TEXTS.clear();
        salesDocSBO = (SBO_EnosixContract_Detail.EnosixContract) documentDetail.convertToSBO(salesDocSBO, salesDocDetail, true, salesDocAppSettings);
        salesDocSBO = (SBO_EnosixContract_Detail.EnosixContract) documentDetail.updateTextFields(salesDocSBO, salesDocDetail);

        DS_Document_Detail clonedSalesDocHeader = salesDocDetail.cloneHeader();
        salesDocSBO = (SBO_EnosixContract_Detail.EnosixContract) documentDetail.removeAllConditions(salesDocSBO);
    }

    @isTest
    public static void test_convertToObject()
    {
        DS_Document_Detail salesDocDetail = TSTD_Document_Detail.buildSalesDocDetail();
        UTIL_Contract_Detail documentDetail = new UTIL_Contract_Detail();
        DS_SalesDocAppSettings salesDocAppSettings = TSTD_SalesDocAppSettings.buildAppSettings();

        salesDocAppSettings.SBODetailType = 'Contract';

        SBO_EnosixContract_Detail.EnosixContract salesDocSBO = 
            (SBO_EnosixContract_Detail.EnosixContract) documentDetail.convertToSBO(null, salesDocDetail, false, salesDocAppSettings);

        SBO_EnosixContract_Detail.INCOMPLETION_LOG newLog1 = new SBO_EnosixContract_Detail.INCOMPLETION_LOG();
        newLog1.Description = 'Configuration';
        newLog1.ItemNumber = '000010';
        salesDocSBO.INCOMPLETION_LOG.add(newLog1);
        SBO_EnosixContract_Detail.INCOMPLETION_LOG newLog2 = new SBO_EnosixContract_Detail.INCOMPLETION_LOG();
        newLog2.Description = 'Configuration';
        newLog2.ItemNumber = '000000';
        salesDocSBO.INCOMPLETION_LOG.add(newLog2);
        SBO_EnosixContract_Detail.BILLING_PLAN_DATES billPlanDate = new SBO_EnosixContract_Detail.BILLING_PLAN_DATES();
        billPlanDate.ItemNumber = '000010';
        billPlanDate.DeadlineSettlementDate = Date.today();
        billPlanDate.Usage = 'Usage';
        salesDocSBO.BILLING_PLAN_DATES.add(billPlanDate);
        for (SBO_EnosixContract_Detail.CONTRACT contract : salesDocSBO.CONTRACT.getAsList()) {
            if (String.isEmpty(contract.ItemNumber)) {
                contract.ItemNumber = '0';
            }
        }

        documentDetail.convertToObject(salesDocSBO, salesDocDetail, false, salesDocAppSettings);
        salesDocDetail = new DS_Document_Detail();
        documentDetail.convertToObject(salesDocSBO, salesDocDetail, true, salesDocAppSettings);
    }
}