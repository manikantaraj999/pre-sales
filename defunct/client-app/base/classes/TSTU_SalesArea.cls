@isTest
public class TSTU_SalesArea
{
    class MOC_getSalesAreaMaster implements ensxsdk.EnosixFramework.RFCMock
    {
        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            RFC_SD_GET_SALES_AREAS.RESULT result = new RFC_SD_GET_SALES_AREAS.RESULT();
            result.setSuccess(false);
            return result;
        }
    }

    @isTest
    public static void test_getSalesAreaMaster()
    {
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_SALES_AREAS.class, new MOC_getSalesAreaMaster());

        Test.startTest();
        RFC_SD_GET_SALES_AREAS.RESULT result = UTIL_SalesArea.getSalesAreaMaster();
        Test.stopTest();
    }

    @isTest
    public static void test_isSales_Area()
    {
        Test.startTest();
        boolean result = UTIL_SalesArea.isSales_Area(new RFC_SD_GET_SALES_AREAS.SalesAreas());
        Test.stopTest();
        System.assertEquals(true, result);
    }

    @isTest
    public static void test_asSales_Area()
    {
        Test.startTest();
        RFC_SD_GET_SALES_AREAS.SalesAreas result = UTIL_SalesArea.asSales_Area(new RFC_SD_GET_SALES_AREAS.SalesAreas());
        Test.stopTest();
        System.assertNotEquals(null, result);
    }

    @isTest
    public static void test_SalesOrganizationAndDistributionChannelAndDivisions_OptionBuilder_getItemValue()
    {
        SBO_EnosixCustomer_Detail.SALES_DATA item = new SBO_EnosixCustomer_Detail.SALES_DATA();
        item.SalesOrganization = 'org1';
        item.DistributionChannel = 'dc1';
        item.Division = 'd1';
        UTIL_SalesArea.SalesOrganizationAndDistributionChannelAndDivisions_OptionBuilder builder = 
            new UTIL_SalesArea.SalesOrganizationAndDistributionChannelAndDivisions_OptionBuilder();
        Test.startTest();
        string result = builder.getItemValue(item);
        Test.stopTest();
        System.assertEquals('org1/dc1/d1', result);
    }

    @isTest
    public static void test_SalesOrganizationAndDistributionChannelAndDivisions_OptionBuilder_getItemDescription()
    {
        SBO_EnosixCustomer_Detail.SALES_DATA item = new SBO_EnosixCustomer_Detail.SALES_DATA();
        item.SalesOrganization = 'org1';
        item.SalesOrganizationName = 'org1name1';
        item.DistributionChannel = 'dc1';
        item.DistributionChannelName = 'dc1name1';
        item.Division = 'd1';
        item.DivisionName = 'd1name1';
        UTIL_SalesArea.SalesOrganizationAndDistributionChannelAndDivisions_OptionBuilder builder = 
            new UTIL_SalesArea.SalesOrganizationAndDistributionChannelAndDivisions_OptionBuilder();
        Test.startTest();
        string result = builder.getItemDescription(item);
        Test.stopTest();
        System.assertEquals('org1 - org1name1 / dc1 - dc1name1 / d1 - d1name1', result);
    }

    @isTest
    public static void test_SalesOrganizationAndDistributionChannelAndDivisions_OptionBuilder_getItemLabel()
    {
        SBO_EnosixCustomer_Detail.SALES_DATA item = new SBO_EnosixCustomer_Detail.SALES_DATA();
        item.SalesOrganization = 'org1';
        item.SalesOrganizationName = 'org1name1';
        item.DistributionChannel = 'dc1';
        item.DistributionChannelName = 'dc1name1';
        item.Division = 'd1';
        item.DivisionName = 'd1name1';
        UTIL_SalesArea.SalesOrganizationAndDistributionChannelAndDivisions_OptionBuilder builder = 
            new UTIL_SalesArea.SalesOrganizationAndDistributionChannelAndDivisions_OptionBuilder();
        Test.startTest();
        string result = builder.getItemLabel(item);
        Test.stopTest();
        System.assertEquals('org1 - org1name1 / dc1 - dc1name1 / d1 - d1name1', result);
    }

    @isTest
    public static void test_SalesOrganization_OptionBuilder_getItemValue()
    {
        RFC_SD_GET_SALES_AREAS.SalesAreas item = new RFC_SD_GET_SALES_AREAS.SalesAreas();
        item.SalesOrganization = 'org1';
        UTIL_SalesArea.SalesOrganization_OptionBuilder builder = new UTIL_SalesArea.SalesOrganization_OptionBuilder();
        Test.startTest();
        string result = builder.getItemValue(item);
        RFC_SD_GET_COUNTRIES.ET_REGIONS item2 = new RFC_SD_GET_COUNTRIES.ET_REGIONS();
        string result2 = builder.getItemValue(item2);
        Test.stopTest();
        System.assertEquals('org1', result);
    }

    @isTest
    public static void test_SalesOrganization_OptionBuilder_getItemDescription()
    {
        RFC_SD_GET_SALES_AREAS.SalesAreas item = new RFC_SD_GET_SALES_AREAS.SalesAreas();
        item.SalesOrganizationName = 'org1name1';
        UTIL_SalesArea.SalesOrganization_OptionBuilder builder = new UTIL_SalesArea.SalesOrganization_OptionBuilder();
        Test.startTest();
        string result = builder.getItemDescription(item);
        RFC_SD_GET_COUNTRIES.ET_REGIONS item2 = new RFC_SD_GET_COUNTRIES.ET_REGIONS();
        string result2 = builder.getItemDescription(item2);
        Test.stopTest();
        System.assertEquals('org1name1', result);
    }

    @isTest
    public static void test_SalesOrganization_OptionBuilder_getItemLabel()
    {
        RFC_SD_GET_SALES_AREAS.SalesAreas item = new RFC_SD_GET_SALES_AREAS.SalesAreas();
        item.SalesOrganization = 'org1';
        item.SalesOrganizationName = 'org1name1';
        UTIL_SalesArea.SalesOrganization_OptionBuilder builder = new UTIL_SalesArea.SalesOrganization_OptionBuilder();
        Test.startTest();
        string result = builder.getItemLabel(item);
        RFC_SD_GET_COUNTRIES.ET_REGIONS item2 = new RFC_SD_GET_COUNTRIES.ET_REGIONS();
        string result2 = builder.getItemLabel(item2);
        Test.stopTest();
        System.assertEquals('org1 - org1name1', result);
    }

    class Test_DistributionChannel_Filter implements UTIL_SalesArea.DistributionChannel_Filter
    {
        public string getSelectedSalesOrganization()
        {
            return 'org1';
        }
    }

    @isTest
    public static void test_DistributionChannel_OptionBuilder_isItemDisplayed()
    {
        RFC_SD_GET_SALES_AREAS.SalesAreas item = new RFC_SD_GET_SALES_AREAS.SalesAreas();
        item.SalesOrganizationName = 'org1';
        UTIL_SalesArea.DistributionChannel_OptionBuilder builder = new UTIL_SalesArea.DistributionChannel_OptionBuilder(
        new Test_DistributionChannel_Filter());

        Test.startTest();
        boolean result = builder.isItemDisplayed(item);
        RFC_SD_GET_COUNTRIES.ET_REGIONS item2 = new RFC_SD_GET_COUNTRIES.ET_REGIONS();
        boolean result2 = builder.isItemDisplayed(item2);
        Test.stopTest();
        System.assertEquals(false, result);
    }

    @isTest
    public static void test_DistributionChannel_OptionBuilder_getItemValue()
    {
        RFC_SD_GET_SALES_AREAS.SalesAreas item = new RFC_SD_GET_SALES_AREAS.SalesAreas();
        item.DistributionChannel = 'dc1';
        UTIL_SalesArea.DistributionChannel_OptionBuilder builder = new UTIL_SalesArea.DistributionChannel_OptionBuilder(
        new Test_DistributionChannel_Filter());

        Test.startTest();
        string result = builder.getItemValue(item);
        RFC_SD_GET_COUNTRIES.ET_REGIONS item2 = new RFC_SD_GET_COUNTRIES.ET_REGIONS();
        string result2 = builder.getItemValue(item2);
        Test.stopTest();
        System.assertEquals('dc1', result);
    }

    @isTest
    public static void test_DistributionChannel_OptionBuilder_getItemDescription()
    {
        RFC_SD_GET_SALES_AREAS.SalesAreas item = new RFC_SD_GET_SALES_AREAS.SalesAreas();
        item.DistributionChannelName = 'dc1name1';
        UTIL_SalesArea.DistributionChannel_OptionBuilder builder = new UTIL_SalesArea.DistributionChannel_OptionBuilder(
        new Test_DistributionChannel_Filter());

        Test.startTest();
        string result = builder.getItemDescription(item);
        RFC_SD_GET_COUNTRIES.ET_REGIONS item2 = new RFC_SD_GET_COUNTRIES.ET_REGIONS();
        string result2 = builder.getItemDescription(item2);
        Test.stopTest();
        System.assertEquals('dc1name1', result);
    }

    @isTest
    public static void test_DistributionChannel_OptionBuilder_getItemLabel()
    {
        RFC_SD_GET_SALES_AREAS.SalesAreas item = new RFC_SD_GET_SALES_AREAS.SalesAreas();
        item.DistributionChannel = 'dc1';
        item.DistributionChannelName = 'dc1name1';
        UTIL_SalesArea.DistributionChannel_OptionBuilder builder = new UTIL_SalesArea.DistributionChannel_OptionBuilder(
        new Test_DistributionChannel_Filter());

        Test.startTest();
        string result = builder.getItemLabel(item);
        RFC_SD_GET_COUNTRIES.ET_REGIONS item2 = new RFC_SD_GET_COUNTRIES.ET_REGIONS();
        string result2 = builder.getItemLabel(item2);
        Test.stopTest();
        System.assertEquals('dc1 - dc1name1', result);
    }

    class Test_Division_Filter implements UTIL_SalesArea.Division_Filter
    {
        public string getSelectedSalesOrganization()
        {
            return 'org1';
        }
        public string getSelectedDistributionChannel()
        {
            return 'dc1';
        }
    }

    @isTest
    public static void test_Division_OptionBuilder_isItemDisplayed()
    {
        RFC_SD_GET_SALES_AREAS.SalesAreas item = new RFC_SD_GET_SALES_AREAS.SalesAreas();
        item.SalesOrganizationName = 'org1';
        item.DistributionChannel = 'dc1';
        UTIL_SalesArea.Division_OptionBuilder builder = new UTIL_SalesArea.Division_OptionBuilder(
        new Test_Division_Filter());

        Test.startTest();
        boolean result = builder.isItemDisplayed(item);
        RFC_SD_GET_COUNTRIES.ET_REGIONS item2 = new RFC_SD_GET_COUNTRIES.ET_REGIONS();
        boolean result2 = builder.isItemDisplayed(item2);
        Test.stopTest();
        System.assertEquals(false, result);
    }

    @isTest
    public static void test_Division_OptionBuilder_getItemValue()
    {
        RFC_SD_GET_SALES_AREAS.SalesAreas item = new RFC_SD_GET_SALES_AREAS.SalesAreas();
        item.Division = 'd1';
        UTIL_SalesArea.Division_OptionBuilder builder = new UTIL_SalesArea.Division_OptionBuilder(
        new Test_Division_Filter());

        Test.startTest();
        string result = builder.getItemValue(item);
        RFC_SD_GET_COUNTRIES.ET_REGIONS item2 = new RFC_SD_GET_COUNTRIES.ET_REGIONS();
        string result2 = builder.getItemValue(item2);
        Test.stopTest();
        System.assertEquals('d1', result);
    }

    @isTest
    public static void test_Division_OptionBuilder_getItemDescription()
    {
        RFC_SD_GET_SALES_AREAS.SalesAreas item = new RFC_SD_GET_SALES_AREAS.SalesAreas();
        item.DivisionName = 'd1name1';
        UTIL_SalesArea.Division_OptionBuilder builder = new UTIL_SalesArea.Division_OptionBuilder(
        new Test_Division_Filter());

        Test.startTest();
        string result = builder.getItemDescription(item);
        RFC_SD_GET_COUNTRIES.ET_REGIONS item2 = new RFC_SD_GET_COUNTRIES.ET_REGIONS();
        string result2 = builder.getItemDescription(item2);
        Test.stopTest();
        System.assertEquals('d1name1', result);
    }

    @isTest
    public static void test_Division_OptionBuilder_getItemLabel()
    {
        RFC_SD_GET_SALES_AREAS.SalesAreas item = new RFC_SD_GET_SALES_AREAS.SalesAreas();
        item.Division = 'd1';
        item.DivisionName = 'd1name1';
        UTIL_SalesArea.Division_OptionBuilder builder = new UTIL_SalesArea.Division_OptionBuilder(
        new Test_Division_Filter());

        Test.startTest();
        string result = builder.getItemLabel(item);
        RFC_SD_GET_COUNTRIES.ET_REGIONS item2 = new RFC_SD_GET_COUNTRIES.ET_REGIONS();
        string result2 = builder.getItemLabel(item2);
        Test.stopTest();
        System.assertEquals('d1 - d1name1', result);
    }
}