@isTest
private class TSTC_SalesAreas
{
    public class MOC_RFC_SD_GET_BP_ROLE_TYPE implements ensxsdk.EnosixFramework.RFCMock
    {
        public boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            RFC_SD_GET_BP_ROLE_TYPE.RESULT result = new RFC_SD_GET_BP_ROLE_TYPE.RESULT();
            result.setSuccess(this.success);
            return result;
        }
    }

    public class MOC_RFC_SD_GET_COUNTRIES implements ensxsdk.EnosixFramework.RFCMock
    {
        public boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            RFC_SD_GET_COUNTRIES.RESULT result = new RFC_SD_GET_COUNTRIES.RESULT();
            result.setSuccess(this.success);
            return result;
        }
    }

    public class MOC_RFC_SD_GET_GROUP_OFFICE implements ensxsdk.EnosixFramework.RFCMock
    {
        public boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            RFC_SD_GET_GROUP_OFFICE.RESULT result = new RFC_SD_GET_GROUP_OFFICE.RESULT();
            result.setSuccess(this.success);
            return result;
        }
    }

    public class MOC_RFC_SD_GET_PRICING_STAT implements ensxsdk.EnosixFramework.RFCMock
    {
        public boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            RFC_SD_GET_PRICING_STAT.RESULT result = new RFC_SD_GET_PRICING_STAT.RESULT();
            result.setSuccess(this.success);
            return result;
        }
    }

    public class MOC_RFC_SD_GET_SHIP_INFO implements ensxsdk.EnosixFramework.RFCMock
    {
        public boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            RFC_SD_GET_SHIP_INFO.RESULT result = new RFC_SD_GET_SHIP_INFO.RESULT();
            result.setSuccess(this.success);
            return result;
        }
    }

    public class MOC_RFC_SD_GET_SALES_AREAS implements ensxsdk.EnosixFramework.RFCMock
    {
        public boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            RFC_SD_GET_SALES_AREAS.RESULT result = new RFC_SD_GET_SALES_AREAS.RESULT();
            RFC_SD_GET_SALES_AREAS.SalesAreas salesArea = new RFC_SD_GET_SALES_AREAS.SalesAreas();
            salesArea.SalesOrganization = 'SalesOrganization';
            salesArea.SalesOrganizationName = 'SalesOrganizationName';
            salesArea.DistributionChannel = 'DistributionChannel';
            salesArea.DistributionChannelName = 'DistributionChannelName';
            salesArea.Division = 'Division';
            salesArea.DivisionName = 'DivisionName';
            result.getCollection(RFC_SD_GET_SALES_AREAS.SalesAreas.class).add(salesArea);
            result.setSuccess(this.success);
            return result;
        }
    }

    @isTest
    static void test_ConstructorAndItems()
    {
        mocRfcCalls();

        Test.startTest();
        CTRL_SalesAreas controller = new CTRL_SalesAreas();
        Object testObject = controller.isPaymentTermsEditEnabled;
        testObject = controller.SalesAreaMaster;
        testObject = controller.GroupOfficeMaster;
        testObject = controller.PricingMaster;
        testObject = controller.ShippingMaster;
        testObject = controller.SalesData;
        testObject = CTRL_SalesAreas.dropDownDescriptionFormat;
        testObject = controller.SalesOrganizations;
        testObject = controller.DistributionChannels;
        testObject = controller.Divisions;
        testObject = controller.SalesOffices;
        testObject = controller.SalesGroups;
        testObject = controller.SalesDistricts;
        testObject = controller.PriceLists;
        testObject = controller.PriceProcedures;
        testObject = controller.PriceGroups;
        testObject = controller.PaymentTerms;
        testObject = controller.ShippingConditions;
        CTRL_CustomerCreateUpdate customerCreateController = new CTRL_CustomerCreateUpdate();
        SBO_EnosixCustomer_Detail.EnosixCustomer customer = new SBO_EnosixCustomer_Detail.EnosixCustomer();
        customerCreateController.cDetail = customer;
        SBO_EnosixCustomer_Detail.SALES_DATA parentSalesData = new SBO_EnosixCustomer_Detail.SALES_DATA();
        parentSalesData.SalesOrganization = 'SalesOrganization';
        parentSalesData.DistributionChannel = 'DistributionChannel';
        parentSalesData.Division = 'Division';
        SBO_EnosixCustomer_Detail.EnosixCustomer parentCustomer = new SBO_EnosixCustomer_Detail.EnosixCustomer();
        parentCustomer.SALES_DATA.add(parentSalesData);
        customerCreateController.parentCustomer = parentCustomer;
        controller.hasUpdated = null;
        List<SBO_EnosixCustomer_Detail.SALES_DATA> ParentCustomerSalesArea = controller.ParentCustomerSalesArea;
        SBO_EnosixCustomer_Detail.SALES_DATA salesData = new SBO_EnosixCustomer_Detail.SALES_DATA();
        salesData.DistributionChannel = 'DistributionChannel';
        salesData.Division = 'Division';
        controller.setMyDataSource(new CTRL_CustomerCreateUpdate.CustomerCreateSalesAreas(customerCreateController, salesData));
        controller.SalesOrganizationAndDistributionChannelAndDivision = '';
        controller.DataSource = null;
        controller.setMyDataSource(new CTRL_CustomerCreateUpdate.CustomerCreateSalesAreas(customerCreateController, salesData));
        controller.setMyDataSource(controller.getMyDataSource());
        testObject = controller.SalesAreaMaster;
        testObject = controller.GroupOfficeMaster;
        testObject = controller.PricingMaster;
        testObject = controller.ShippingMaster;
        testObject = controller.SalesData;
        testObject = controller.SalesOffices;
        testObject = controller.SalesGroups;
        testObject = controller.SalesDistricts;
        testObject = controller.PriceLists;
        testObject = controller.PriceProcedures;
        testObject = controller.PriceGroups;
        testObject = controller.PaymentTerms;
        testObject = controller.ShippingConditions;
        testObject = controller.getSelectedSalesOrganization();
        testObject = controller.getSelectedDistributionChannel();
        testObject = controller.isPartnerMode;
        //controller.setIsPartnerMode(true);
        //controller.setIsPartnerMode(true);
        controller.SalesOrganizationAndDistributionChannelAndDivision = '1/1/1';
        List<RFC_SD_GET_GROUP_OFFICE.ET_SALES_OFFICE> offices = new List<RFC_SD_GET_GROUP_OFFICE.ET_SALES_OFFICE>();
        RFC_SD_GET_GROUP_OFFICE.ET_SALES_OFFICE office = new RFC_SD_GET_GROUP_OFFICE.ET_SALES_OFFICE();
        office.VKBUR = 'VKBUR';
        office.SalesOrganization = 'SalesOrganization';
        office.DistributionChannel = 'DistributionChannel';
        office.Division = 'Division';
        office.BEZEI = 'BEZEI';
        offices.add(office);
        CTRL_SalesAreas.AddSalesOffice(new List<SelectOption>(), offices, 'SalesOrganization', 'DistributionChannel', 'Division');
        List<RFC_SD_GET_GROUP_OFFICE.ET_SALES_GROUP> salesGroups = new List<RFC_SD_GET_GROUP_OFFICE.ET_SALES_GROUP>();
        RFC_SD_GET_GROUP_OFFICE.ET_SALES_GROUP salesGroup = new RFC_SD_GET_GROUP_OFFICE.ET_SALES_GROUP();
        salesGroup.SalesGroup = 'SalesGroup';
        salesGroup.VKBUR = 'VKBUR';
        salesGroup.BEZEI = 'BEZEI';
        salesGroups.add(salesGroup);
        CTRL_SalesAreas.AddSalesGroups(new List<SelectOption>(), salesGroups, 'VKBUR');
        List<RFC_SD_GET_GROUP_OFFICE.ET_SALES_DISTRICT> districts = new List<RFC_SD_GET_GROUP_OFFICE.ET_SALES_DISTRICT>();
        RFC_SD_GET_GROUP_OFFICE.ET_SALES_DISTRICT district = new RFC_SD_GET_GROUP_OFFICE.ET_SALES_DISTRICT();
        district.BZIRK = 'BZIRK';
        district.BZTXT = 'BZTXT';
        districts.add(district);
        CTRL_SalesAreas.AddSalesDistricts(new List<SelectOption>(), districts);
        List<RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_LIST> priceLists = new List<RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_LIST>();
        RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_LIST priceList = new RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_LIST();
        priceList.PLTYP = 'PLTYP';
        priceList.PTEXT = 'PTEXT';
        priceLists.add(priceList);
        CTRL_SalesAreas.AddPriceList(new List<SelectOption>(), priceLists);
        List<RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_PROC> priceProcs = new List<RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_PROC>();
        RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_PROC priceProc = new RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_PROC();
        priceProc.KALKS = 'KALKS';
        priceProc.VTEXT = 'VTEXT';
        priceProcs.add(priceProc);
        CTRL_SalesAreas.AddPriceProcedure(new List<SelectOption>(), priceProcs);
        List<RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_GRP> priceGrps = new List<RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_GRP>();
        RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_GRP priceGrp = new RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_GRP();
        priceGrp.KONDA = 'R';
        priceGrp.VTEXT = 'VTEXT';
        priceGrps.add(priceGrp);
        CTRL_SalesAreas.AddPriceGroup(new List<SelectOption>(), priceGrps);
        List<RFC_SD_GET_SHIP_INFO.ET_PAY_TERMS> payTerms = new List<RFC_SD_GET_SHIP_INFO.ET_PAY_TERMS>();
        RFC_SD_GET_SHIP_INFO.ET_PAY_TERMS payTerm = new RFC_SD_GET_SHIP_INFO.ET_PAY_TERMS();
        payTerm.ZTERM = 'ZTERM';
        payTerm.VTEXT = 'VTEXT';
        payTerms.add(payTerm);
        CTRL_SalesAreas.AddPaymentTerms(new List<SelectOption>(), payTerms);
        List<RFC_SD_GET_SHIP_INFO.ET_SHIP_COND> shipConds = new List<RFC_SD_GET_SHIP_INFO.ET_SHIP_COND>();
        RFC_SD_GET_SHIP_INFO.ET_SHIP_COND shipCond = new RFC_SD_GET_SHIP_INFO.ET_SHIP_COND();
        shipCond.ShippingConditions = 'ShippingConditions';
        shipCond.VTEXT = 'VTEXT';
        shipConds.add(shipCond);
        CTRL_SalesAreas.AddShippingConditions(new List<SelectOption>(), shipConds);
        List<SelectOption> selectOptions = new List<SelectOption>();
        Test.stopTest();
    }

    static void mocRfcCalls()
    {
        MOC_RFC_SD_GET_BP_ROLE_TYPE mocRfcSdGetBPRoleTypes = new MOC_RFC_SD_GET_BP_ROLE_TYPE();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_BP_ROLE_TYPE.class, mocRfcSdGetBPRoleTypes);
        MOC_RFC_SD_GET_COUNTRIES mocRfcSdGetCountries = new MOC_RFC_SD_GET_COUNTRIES();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_COUNTRIES.class, mocRfcSdGetCountries);
        MOC_RFC_SD_GET_GROUP_OFFICE mocRfcSdGetGroupOffice = new MOC_RFC_SD_GET_GROUP_OFFICE();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_GROUP_OFFICE.class, mocRfcSdGetGroupOffice);
        MOC_RFC_SD_GET_PRICING_STAT mocRfcSdGetPricingStat = new MOC_RFC_SD_GET_PRICING_STAT();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_PRICING_STAT.class, mocRfcSdGetPricingStat);
        MOC_RFC_SD_GET_SHIP_INFO mocRfcSdGetShipInfo = new MOC_RFC_SD_GET_SHIP_INFO();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_SHIP_INFO.class, mocRfcSdGetShipInfo);
        MOC_RFC_SD_GET_SALES_AREAS mocRfcSdGetSalesAreas = new MOC_RFC_SD_GET_SALES_AREAS();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_SALES_AREAS.class, mocRfcSdGetSalesAreas);
    }
}