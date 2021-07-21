public with sharing class CTRL_CustomerCreateUpdate
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_CustomerCreateUpdate.class);

    public void logCallouts(String location)
    {
        if ((Boolean)UTIL_AppSettings.getValue('CTRL_CustomerCreateUpdate.Logging', false))
        {
            logger.debug(location);
        }
    }

    // Account refrenced from url parameter acctId
    public Account account { get; set; }

    public Boolean showCreateCustomerAction { get; private set; }

    public String customerid { get; private set; }
    public String accountid { get; private set; }

    @testVisible
    public String caseid { get; private set; }

    //ID fo the customer to which we're adding a partner
    @testVisible
    public String addPartnerToId { get; private set; }
    @testVisible
    public String shipToNum {get; private set; }
    @testVisible
    public String salesArea {get; private set;}
    public Boolean isShipToCreated {get; private set;}
    @testVisible
    public String newShipToNum {get; private set;}
    @testVisible
    public Boolean isCloningShipTo { get; private set;}
    public Boolean isCreate { get; private set; }
    public Boolean isUpdate { get; private set; }
    public Boolean isAddPartner { get; private set; }

    public Boolean isClassic
    {
        get {return (UserInfo.getUiThemeDisplayed() == 'Theme3');}
    }

    public Boolean isFromOrder 
    {
        get
        {
            return UTIL_PageState.current.sapPreviousScreen == UTIL_PageState.SAP_PreviousScreenOrder;
        }
    }

    public Boolean isFromQuote 
    {
        get
        {
            return UTIL_PageState.current.sapPreviousScreen == UTIL_PageState.SAP_PreviousScreenQuote;
        }
    }

    public Boolean isFromOpp 
    {
        get
        {
            return UTIL_PageState.current.sapPreviousScreen == UTIL_PageState.SAP_PreviousScreenOpp;
        }
    }

    private transient RFC_SD_GET_COUNTRIES.RESULT t_countries;
    RFC_SD_GET_COUNTRIES.RESULT countries
    {
        get
        {
            if (null == t_countries)
            {
                RFC_SD_GET_COUNTRIES rfc = new RFC_SD_GET_COUNTRIES();
                t_countries = rfc.execute();
                if (!t_countries.isSuccess())
                {
                    UTIL_ViewHelper.displayResultMessages(t_countries.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
                }
            }
            return t_countries;
        }
    }

    private transient RFC_SD_GET_GROUP_OFFICE.RESULT t_officeMaster;
    RFC_SD_GET_GROUP_OFFICE.RESULT officeMaster
    {
        get
        {
            if (null == t_officeMaster)
            {
                RFC_SD_GET_GROUP_OFFICE rfc = new RFC_SD_GET_GROUP_OFFICE();
                t_officeMaster = rfc.execute();
                if (!t_officeMaster.isSuccess())
                {
                    UTIL_ViewHelper.displayResultMessages(t_officeMaster.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
                }
            }
            return t_officeMaster;
        }
    }

    private transient RFC_SD_GET_PRICING_STAT.RESULT t_priceMaster;
    RFC_SD_GET_PRICING_STAT.RESULT priceMaster
    {
        get
        {
            if (null == t_priceMaster)
            {
                RFC_SD_GET_PRICING_STAT rfc = new RFC_SD_GET_PRICING_STAT();
                t_priceMaster = rfc.execute();
                if (!t_priceMaster.isSuccess())
                {
                    UTIL_ViewHelper.displayResultMessages(t_priceMaster.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
                }
            }
            return t_priceMaster;
        }
    }

    private transient RFC_SD_GET_SALES_AREAS.RESULT t_salesAreaMaster;
    RFC_SD_GET_SALES_AREAS.RESULT salesAreaMaster
    {
        get
        {
            if (null == t_salesAreaMaster)
            {
                t_salesAreaMaster = UTIL_SalesArea.getSalesAreaMaster();
            }
            return t_salesAreaMaster;
        }
    }

    private transient RFC_SD_GET_SHIP_INFO.RESULT t_shippingMaster;
    RFC_SD_GET_SHIP_INFO.RESULT shippingMaster
    {
        get
        {
            if (null == t_shippingMaster)
            {
                RFC_SD_GET_SHIP_INFO rfc = new RFC_SD_GET_SHIP_INFO();
                t_shippingMaster = rfc.execute();
                if (!t_shippingMaster.isSuccess())
                {
                    UTIL_ViewHelper.displayResultMessages(t_shippingMaster.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
                }
            }
            return t_shippingMaster;
        }
    }

    private transient RFC_SD_GET_BP_ROLE_TYPE.RESULT t_bpRoleTypes;
    @testVisible
    RFC_SD_GET_BP_ROLE_TYPE.RESULT bpRoleTypes
    {
        get
        {
            if (null == t_bpRoleTypes)
            {
                RFC_SD_GET_BP_ROLE_TYPE rfc = new RFC_SD_GET_BP_ROLE_TYPE();
                t_bpRoleTypes = rfc.execute();
                if (!t_bpRoleTypes.isSuccess())
                {
                    UTIL_ViewHelper.displayResultMessages(t_bpRoleTypes.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
                }
            }
            return t_bpRoleTypes;
        }
    }

    //Customer being created
    @testVisible
    public SBO_EnosixCustomer_Detail.EnosixCustomer cDetail
    {
        get;
        protected set;
    }

    private static String C_DETAIL_TYPE = 'cDetail';
    private static String PARENT_CUSTOMER_TYPE = 'parentCustomer';
    private SBO_EnosixCustomer_Detail.EnosixCustomer setCustomerRecord (String customerNumber, String type)
    {
        return UTIL_Customer.getCustomerByNumber(customerNumber);
    }

    private SBO_EnosixCustomer_Detail.EnosixCustomer setCustomerRecord (SBO_EnosixCustomer_Detail.EnosixCustomer customer, String type)
    {
        return customer;
    }

    private SBO_EnosixCustomer_Detail.EnosixCustomer getCustomerRecord (SBO_EnosixCustomer_Detail.EnosixCustomer customer, String type)
    {
        return customer;
    }

    // The customer that the new customer will be applied to
    private transient Boolean isParentCustomerCustomerRetrieved;
    private transient SBO_EnosixCustomer_Detail.EnosixCustomer t_parentCustomer;
    public SBO_EnosixCustomer_Detail.EnosixCustomer parentCustomer
    {
        get
        {
            if (null == t_parentCustomer && null == this.isParentCustomerCustomerRetrieved && 
                null != addPartnerToId)
            {                
                this.isParentCustomerCustomerRetrieved = true;
                t_parentCustomer = setCustomerRecord(addPartnerToId, PARENT_CUSTOMER_TYPE);                
            }
            return t_parentCustomer;
        }

        set
        {
            t_parentCustomer = value;
        }
    }

    public Boolean IsCustomerContactEditable
    {
        get
        {
            return (Boolean)UTIL_AppSettings.getValue('Customer.IsContactEditable', false);
        }
    }

    public Boolean IsCustomerAddressEditable
    {
        get
        {
            return (Boolean)UTIL_AppSettings.getValue('Customer.IsAddressEditable', false);
        }
    }

    @testVisible
    private Account getAccount()
    {
        if (this.caseid != null)
        {
            Case sfCase = UTIL_ObjectLookups.getCaseById(this.caseid);
            this.accountid = sfCase.AccountId;
        }
        return UTIL_SFAccount.getAccountById(this.accountid);
    }

    public String FormattedPhone
    {
        get
        {
            return UTIL_ViewHelper.formatPhoneForDisplay(
                this.cDetail.TelephoneNumber, this.cDetail.TelephoneNumberExtension);
        }
    }

    public String FormattedFax
    {
        get
        {
            return UTIL_ViewHelper.formatPhoneForDisplay(
                this.cDetail.FaxNumber, this.cDetail.FaxNumberExtension);
        }
    }

    //ctor
    public CTRL_CustomerCreateUpdate()
    {
        logCallouts('CTRL_CustomerCreateUpdate');
        this.accountid = UTIL_PageState.current.sfAccountId;
        this.caseid = UTIL_PageState.current.sfCaseId;
        this.customerid = UTIL_PageState.current.sapCustomerId;
        this.account = getAccount();
        this.addPartnerToId = UTIL_PageState.current.sapAddPartnerTo;
        this.shipToNum = UTIL_PageState.current.sapShipToNum;
        this.salesArea = UTIL_PageState.current.sapSalesArea;
        this.isShipToCreated = false;
        this.isCloningShipTo = false;        
        this.isCreate = false;
        this.isUpdate = false;
        this.isAddPartner = false;
    }

    public void initMode()
    {
        if (UTIL_PageState.current.sapMode == UTIL_PageState.SAP_ModeUpdate)
        {
            this.isUpdate = true;
            initEdit();
        }
        else
        {
            initCreateMode();
        }        
    }

    public PageReference initCreateMode()
    {
        this.isCreate = true;
        logCallouts('initCreateMode');
        //If no account was found on iniitalization, break.
        //A custom link is displayed to redirect either back to the Case
        //or redirect to the account page so that an account can be created first.
        if (this.account != null)
        {
            this.cDetail = setCustomerRecord(createCustomerDetail(this.account, this.caseid), C_DETAIL_TYPE);
        }

        if (null != addPartnerToId)
        {
            this.isAddPartner = true;
            initAddPartner();
        }

        return null;
    }

    /*
    * customer create for adding as a sold to partner type
    * This will initialse a new custom that will be saved and then
    *   added as a ship to on the calling cutomer detail screen.
    * After comletion re-direct back to the calling customer detail.
    */
    public PageReference initAddPartner()
    {
        if (null == this.parentCustomer)
        {
            String errorMessage = String.format('SAP Customer {0} not found.', new String[] {addPartnerToId});
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, errorMessage));
            return null;
        }
        List<SBO_EnosixCustomer_Detail.SALES_DATA> parentCustomerSalesData = new List<SBO_EnosixCustomer_Detail.SALES_DATA>();

        this.parentCustomer.SALES_DATA.copyTo(parentCustomerSalesData);
        if (parentCustomerSalesData.size() == 0)
        {
            String errorMessage = String.format('No Sales Areas set up for SAP Customer {0}.', new String[] {addPartnerToId});
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, errorMessage));
            return null;
        }

        this.cDetail.BusinessPartnerType = UTIL_PageState.current.sapPartnerType;
        this.cDetail = setCustomerRecord(commandApplyEdits(this.cDetail), C_DETAIL_TYPE);

        showAddPartnerAction = true;

        return null;
    }

    // enables the Add partner action button
    public Boolean showAddPartnerAction { get; private set; }

    @testVisible
    private static void copySalesAreasFromCustomer(
        SBO_EnosixCustomer_Detail.EnosixCustomer srcCustomer,
        SBO_EnosixCustomer_Detail.EnosixCustomer destCustomer)
    {
        List<SBO_EnosixCustomer_Detail.SALES_DATA> salesAreas = new List<SBO_EnosixCustomer_Detail.SALES_DATA>();
        srcCustomer.SALES_DATA.copyTo(salesAreas);

        destCustomer.BusinessPartnerCategory = srcCustomer.BusinessPartnerCategory;
        destCustomer.BusinessPartnerType = srcCustomer.BusinessPartnerType;
        destCustomer.BPRole = srcCustomer.BPRole;
    }

    public PageReference initEdit()
    {
        logCallouts('initEdit');
        String customerNumber = UTIL_PageState.current.sapCustomerId;
        if (String.isBlank(customerNumber) && null != this.account)
        {
            customerNumber = UTIL_SFAccount.getCustomerNumberFromAccount(this.account);
        }

        if (String.isBlank(customerNumber))
        {
            return UTIL_Customer.redirectToCreateCustomer();
        }

        this.cDetail = setCustomerRecord(customerNumber, C_DETAIL_TYPE);

        if (this.IsCustomerAddressEditable)
        {
            initAddress();
        }

        return null;
    }

    @testVisible
    private void initAddress()
    {
        this.cDetail.City = this.account.BillingCity;
        String billingStreet = this.account.BillingStreet;
        if (String.isNotBlank(billingStreet))
        {
            if (billingStreet.indexOf(' ') >= 0)
            {
                this.cDetail.HouseNumber = billingStreet.subString(0, billingStreet.indexOf(' '));
                this.cDetail.Street = billingStreet.subString(billingStreet.indexOf(' ') + 1);
            }
            else
            {
                this.cDetail.Street = billingStreet;
            }
        }
        this.cDetail.PostalCode = this.account.BillingPostalCode;

        this.cDetail.Country = UTIL_ViewHelper.getValueForSelectOptionByValueOrLabel(this.CountryOptions,
            String.isEmpty(this.account.BillingCountry) ? 'US' : this.account.BillingCountry);
        // this.cDetail.Country = UTIL_ViewHelper.getValueForSelectOptionByValueOrLabel(this.CountryOptions,
        //     String.isEmpty(this.account.BillingCountryCode) ? 'US' : this.account.BillingCountryCode);
        if (String.isEmpty(this.cDetail.Country))
        {
            this.cDetail.Country = 'US';
        }

        this.cDetail.Region = UTIL_ViewHelper.getValueForSelectOptionByValueOrLabel(
            this.getRegionOptionsForCountry(this.cDetail.Country),
            this.account.BillingState
        );
    }

    public Account RefrenceAccount
    {
        get
        {
            return this.account;
        }
    }

    public SBO_EnosixCustomer_Detail.EnosixCustomer NewCustomer
    {
        get
        {
            return this.cDetail;
        }
    }

    @testVisible
    class CustomerCreateSalesAreas implements DS_SalesArea
    {
        private CTRL_CustomerCreateUpdate parent;
        private SBO_EnosixCustomer_Detail.SALES_DATA salesData;

        public void updateSalesArea(SBO_EnosixCustomer_Detail.SALES_DATA salesData)
        {
            if (this.parent.cDetail.SALES_DATA.size() > 0)
            {
                this.parent.cDetail.SALES_DATA.remove(this.parent.cDetail.SALES_DATA.get(0));
                this.parent.cDetail.SALES_DATA.add(salesData);
            }
            else
            {
                this.parent.cDetail.SALES_DATA.add(salesData);
            }
            this.parent.updateDetail();
        }

        public CustomerCreateSalesAreas(CTRL_CustomerCreateUpdate parent, SBO_EnosixCustomer_Detail.SALES_DATA salesData)
        {
            this.parent = parent;
            this.salesData = salesData;
        }

        public SBO_EnosixCustomer_Detail.SALES_DATA getSALES_DATA()
        {
            return this.salesData;
        }

        public List<SBO_EnosixCustomer_Detail.SALES_DATA> getParentCustomerSalesAreas()
        {
            List<SBO_EnosixCustomer_Detail.SALES_DATA> parentCustomerSalesData = 
                new List<SBO_EnosixCustomer_Detail.SALES_DATA>();

            if (this.parent.parentCustomer != null)
            {
                parentCustomerSalesData = this.parent.parentCustomer.SALES_DATA.getAsList();
            }

            return parentCustomerSalesData;
        }

        public RFC_SD_GET_SALES_AREAS.RESULT getSalesAreas()
        {
            return this.parent.salesAreaMaster;
        }

        public RFC_SD_GET_GROUP_OFFICE.RESULT getGroupOffice()
        {
            return this.parent.officeMaster;
        }

        public RFC_SD_GET_PRICING_STAT.RESULT getPricingStat()
        {
            return this.parent.priceMaster;
        }

        public RFC_SD_GET_SHIP_INFO.RESULT getShipInfo()
        {
            return this.parent.shippingMaster;
        }
    }

    public List<DS_SalesArea> DS_SalesAreas
    {
        get
        {
            List<DS_SalesArea> result = new List<DS_SalesArea>();

            List<SBO_EnosixCustomer_Detail.SALES_DATA> salesList = this.cDetail.SALES_DATA.getAsList();
            Integer salesTot = salesList.size();
            for (Integer salesCnt = 0 ; salesCnt < salesTot ; salesCnt++)
            {
                SBO_EnosixCustomer_Detail.SALES_DATA item = salesList[salesCnt];
                result.add(new CustomerCreateSalesAreas(this, item));
            }

            return result;
        }
    }

    @testVisible
    class CustomerCreateCompanyCode implements DS_CompanyCode
    {
        private CTRL_CustomerCreateUpdate parent;
        private SBO_EnosixCustomer_Detail.COMPANY_DATA companyData;

        public CustomerCreateCompanyCode(CTRL_CustomerCreateUpdate parent, 
            SBO_EnosixCustomer_Detail.COMPANY_DATA companyData)
        {
            this.parent = parent;
            this.companyData = companyData;
        }

        public SBO_EnosixCustomer_Detail.COMPANY_DATA getCOMPANY_DATA()
        {
            return this.companyData;
        }

        public RFC_SD_GET_SHIP_INFO.RESULT getShipInfo()
        {
            return this.parent.shippingMaster;
        }
    }

    public List<DS_CompanyCode> CompanyCodes
    {
        get
        {
            List<DS_CompanyCode> result = new List<DS_CompanyCode>();

            List<SBO_EnosixCustomer_Detail.COMPANY_DATA> compList = this.cDetail.COMPANY_DATA.getAsList();
            Integer compTot = compList.size();
            for (Integer compCnt = 0 ; compCnt < compTot ; compCnt++)
            {
                SBO_EnosixCustomer_Detail.COMPANY_DATA item = compList[compCnt];
                result.add(new CustomerCreateCompanyCode(this, item));
            }

            return result;
        }
    }

    SBO_EnosixCustomer_Detail.EnosixCustomer createCustomerDetail(Account account, String caseId)
    {
        SBO_EnosixCustomer_Detail.EnosixCustomer result = new SBO_EnosixCustomer_Detail.EnosixCustomer();

        // Account to SAP Customer Mapping
        result.City = account.BillingCity;
        result.Name = account.Name;
        String billingStreet = account.BillingStreet;
        if (String.isNotBlank(billingStreet))
        {
            if (billingStreet.indexOf(' ') >= 0)
            {
                result.HouseNumber = billingStreet.subString(0, billingStreet.indexOf(' '));
                result.Street = billingStreet.subString(billingStreet.indexOf(' ') + 1);
            }
            else
            {
                result.Street = billingStreet;
            }
        }
        result.TelephoneNumber = account.Phone;
        result.PostalCode = account.BillingPostalCode;

        result.Country = UTIL_ViewHelper.getValueForSelectOptionByValueOrLabel(this.CountryOptions,
            String.isEmpty(this.account.BillingCountry) ? 'US' : this.account.BillingCountry);
        // result.Country = UTIL_ViewHelper.getValueForSelectOptionByValueOrLabel(this.CountryOptions,
        //     String.isEmpty(this.account.BillingCountryCode) ? 'US' : this.account.BillingCountryCode);
        if (String.isEmpty(result.Country))
        {
            result.Country = 'US';
        }

        result.Region = UTIL_ViewHelper.getValueForSelectOptionByValueOrLabel(
            this.getRegionOptionsForCountry(result.Country),
            account.BillingState
        );

        result.SearchTerm1 = account.Name;
        if (caseId != null)
        {
            // If we have a case ID, this is a Return Order customer
            result = commandInitForReturn(result);
        }
        else if (null != addPartnerToId)
        {
            //Partner being added to an existing customer
            result = commandInitForShipTo(result);
        }
        else
        {
            // Normal order customer
            result = new SBO_EnosixCustomer_Detail().initialize(result);
        }

        SBO_EnosixCustomer_Detail.SALES_DATA salesData = new SBO_EnosixCustomer_Detail.SALES_DATA();
        result.SALES_DATA.add(salesData);
        SBO_EnosixCustomer_Detail.USER_DEFINED ud = new SBO_EnosixCustomer_Detail.USER_DEFINED();
        ud.FIELD = 'SF_RECORD_TYPE';
        //ud.VALUE = this.account.RecordType.Name;
        result.USER_DEFINED.clear();
        result.USER_DEFINED.add(ud);

        // This is a work around for a page flow issue:
        // - On init, updating the customer detail causes DS_SalesAreas to change
        // which causes the CMP_SalesAreas component to redraw, which in turn calls
        // this controller's updateDetail() method, calling commandApplyEdits().
        //
        // The problem is that the commandApplyEdits command again changes DS_SalesAreas,
        // which should refresh the component display again, but it does not.
        // To work around this, we just call commandApplyEdits() here, earlier in
        // the page cycle to make sure the screen renders the proper data.

        result = commandApplyEdits(result);
        return result;
    }

    @testVisible
    SBO_EnosixCustomer_Detail.EnosixCustomer callCommand(String command, 
        SBO_EnosixCustomer_Detail.EnosixCustomer customer)
    {
        SBO_EnosixCustomer_Detail EnosixCustomer_Detail = new SBO_EnosixCustomer_Detail();

        if (null != customer) 
        {
            customer.CustomerNumber =  string.isNotEmpty(customer.CustomerNumber) ? customer.CustomerNumber : '';
        }

        SBO_EnosixCustomer_Detail.EnosixCustomer result = 
            EnosixCustomer_Detail.command(command, getCustomerRecord(customer,C_DETAIL_TYPE));

        if (!result.isSuccess())
        {
            UTIL_ViewHelper.displayResultMessages(result.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
        }

        return result;
    }

    @testVisible
    SBO_EnosixCustomer_Detail.EnosixCustomer commandApplyEdits(SBO_EnosixCustomer_Detail.EnosixCustomer customer)
    {
        return callCommand('CMD_APPLY_EDITS', customer);
    }

    @testVisible
    SBO_EnosixCustomer_Detail.EnosixCustomer commandInitForReturn(SBO_EnosixCustomer_Detail.EnosixCustomer customer)
    {
        return callCommand('CMD_INIT_FOR_RETURN', customer);
    }

    @testVisible
    SBO_EnosixCustomer_Detail.EnosixCustomer commandInitForShipTo(SBO_EnosixCustomer_Detail.EnosixCustomer customer)
    {
        return callCommand('CMD_INIT_FOR_SHIP_TO', customer);
    }

    public List<SelectOption> CountryOptions
    {
        get
        {
            List<SelectOption> result = new List<SelectOption>();
            AddCountries(result, this.countries.ET_OUTPUT_List);
            UTIL_ViewHelper.sortOptionsByLabel(result);
            return result;
        }
    }

    public List<SelectOption> RegionOptions
    {
        get
        {
            return getRegionOptionsForCountry(NewCustomer.Country);
        }
    }

    private List<SelectOption> getRegionOptionsForCountry(String country)
    {
        List<SelectOption> result = new List<SelectOption>();
        AddRegionsForCountry(result, this.countries.ET_REGIONS_List, country);
        UTIL_ViewHelper.sortOptionsByLabel(result);
        if (result != null && result.size() > 0)
        {
            result.add(0, new SelectOption('', 'Select One'));
        }
        return result;
    }

    public List<SelectOption> BusinessPartnerCategoryOptions
    {
        get
        {
            List<SelectOption> result = new List<SelectOption>();

            if (null != this.bpRoleTypes)
            {
                List<RFC_SD_GET_BP_ROLE_TYPE.ET_BP_CATEGORY> bpCatList = this.bpRoleTypes.ET_BP_CATEGORY_List;
                Integer bpCatTot = bpCatList.size();
                for (Integer bpCatCnt = 0 ; bpCatCnt < bpCatTot ; bpCatCnt++)
                {
                    RFC_SD_GET_BP_ROLE_TYPE.ET_BP_CATEGORY bpCat = bpCatList[bpCatCnt];
                    result.add(new SelectOption(bpCat.Category, bpCat.Description == null ? bpCat.Category : bpCat.Description));
                }
            }
            result.sort();
            return result;
        }
    }

    public List<SelectOption> BusinessPartnerTypeOptions
    {
        get
        {
            List<SelectOption> result = new List<SelectOption>();

            if (null != this.bpRoleTypes)
            {
                List<RFC_SD_GET_BP_ROLE_TYPE.ET_BP_TYPE> bpTypeList = this.bpRoleTypes.ET_BP_TYPE_List;
                Integer bpTypeTot = bpTypeList.size();
                for (Integer bpTypeCnt = 0 ; bpTypeCnt < bpTypeTot ; bpTypeCnt++)
                {
                    RFC_SD_GET_BP_ROLE_TYPE.ET_BP_TYPE bpType = bpTypeList[bpTypeCnt];
                    if (UTIL_Customer.allowedClientTypes.contains(bpType.FieldType)
                        || UTIL_Customer.allowedClientTypes.contains('*'))
                    {
                        result.add(new SelectOption(
                            bpType.FieldType, 
                            bpType.Description == null ? bpType.FieldType : bpType.Description));
                    }
                }
            }
            result.sort();
            return result;
        }
    }

    public List<SelectOption> BPRoleGroups
    {
        get
        {
            List<SelectOption> result = new List<SelectOption>();
            result.add(new SelectOption('', 'Select a Value'));
            AddBPRoleGroups(result, this.bpRoleTypes.ET_BP_ROLE_GROUP_List);
            return result;
        }
    }

    public void updateDetail()
    {
        try
        {
            this.cDetail = setCustomerRecord(this.commandApplyEdits(this.cDetail), C_DETAIL_TYPE);
        }
        catch (Exception e)
        {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, e.getMessage()));
        }
    }

    public Boolean ValidateFields()
    {
        Boolean result = true;

        if (String.isBlank(NewCustomer.Name))
        {
            result = false;
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Name is required'));
        }

        if ('1' == NewCustomer.BusinessPartnerCategory && String.isBlank(NewCustomer.Name2))
        {
            result = false;
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Name2 is required'));
        }

        if (String.isBlank(NewCustomer.Street))
        {
            result = false;
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Street is required'));
        }

        if (String.isBlank(NewCustomer.City))
        {
            result = false;
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'City is required'));
        }

        if (String.isBlank(NewCustomer.Region))
        {
            result = false;
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Region is required'));
        }

        if (String.isBlank(NewCustomer.PostalCode))
        {
            result = false;
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'PostalCode is required'));
        }

        if (String.isBlank(NewCustomer.CustomerAccountGroup))
        {
            // Currently, SAP should be defaulting it to this value anyway,
            // but we'll be explicit here anyway. Just in case.
            NewCustomer.CustomerAccountGroup = '0001';
        }

        return result;
    }

    static void displayException(Exception e)
    {
        if (null == e) return;

        ApexPages.Message message = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage());

        ApexPages.addMessage(message);
    }

    public PageReference actionReturnToCustomer()
    {
        logCallouts('actionReturnToCustomer');
        return redirectToCustomerDetail(this.parentCustomer);
    }

    /**
    * action called by the Add SAP Partner to Customer button
    */
    public PageReference actionAddSAPPartner()
    {
        logCallouts('actionAddSAPPartner');
        if (!ValidateFields()) return null;

        SBO_EnosixCustomer_Detail sbo = new SBO_EnosixCustomer_Detail();
        SBO_EnosixCustomer_Detail.EnosixCustomer result = null;

        try
        {
            SBO_EnosixCustomer_Detail.EnosixCustomer customer = getCustomerRecord(this.cDetail,C_DETAIL_TYPE);
            if (null != customer) {
                customer.CustomerNumber =  string.isNotEmpty(customer.CustomerNumber) ? customer.CustomerNumber : '';
            }
            result = sbo.save(customer);
            this.newShipToNum = result.CustomerNumber;
        }
        catch (Exception e)
        {
            displayException(e);
            return null;
        }

        if (!result.isSuccess())
        {
            UTIL_ViewHelper.displayResultMessages(result.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
            return null;
        }

        // Update the displayed customer information
        List<SBO_EnosixCustomer_Detail.SALES_DATA> salesData = new List<SBO_EnosixCustomer_Detail.SALES_DATA>();
        this.cDetail.SALES_DATA.copyTo(salesData);
        this.cDetail = setCustomerRecord(result, C_DETAIL_TYPE);
        List<SBO_EnosixCustomer_Detail.SALES_DATA> salesData2 = new List<SBO_EnosixCustomer_Detail.SALES_DATA>();
        this.cDetail.SALES_DATA.copyTo(salesData2);
        Integer salesTot1 = salesData.size();
        Integer salesTot2 = salesData2.size();
        for (Integer salesCnt1 = 0 ; salesCnt1 < salesTot1 ; salesCnt1++)
        {
            SBO_EnosixCustomer_Detail.SALES_DATA saleData = salesData[salesCnt1];
            boolean saleDataFound = false;
            for (Integer salesCnt2 = 0 ; salesCnt2 < salesTot2 ; salesCnt2++)
            {
                SBO_EnosixCustomer_Detail.SALES_DATA saleData2 = salesData2[salesCnt2];
                if (saleData.SalesOrganization == saleData2.SalesOrganization &&
                    saleData.DistributionChannel == saleData2.DistributionChannel &&
                    saleData.Division == saleData2.Division)
                {
                    saleDataFound = true;
                    break;
                }
            }

            if (!saleDataFound)
            {
                cDetail.SALES_DATA.add(saleData);
            }
        }

        if (!addPartnerToCustomer(this.parentCustomer, this.cDetail, UTIL_Customer.SHIP_TO_PARTNER_CODE))
        {
            ApexPages.addMessage(new Apexpages.Message(
                ApexPages.Severity.ERROR, 'Add partner to customer failed'));
            return null;
        }

        try
        {
            result = sbo.save(getCustomerRecord(this.parentCustomer,PARENT_CUSTOMER_TYPE));
        }
        catch (Exception e)
        {
            displayException(e);
            return null;
        }

        UTIL_ViewHelper.displayResultMessages(result.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
        if (!result.isSuccess())
        {
            return null;
        }

        SBO_EnosixCustomer_Detail.EnosixCustomer customerRecord = getCustomerRecord(this.cDetail, C_DETAIL_TYPE);

        return redirectToPartnerSearch(this.account.Id);
    }

    /**
     * create new SAP Customer # for this account
     */
    public PageReference createSAPCustomer()
    {
        logCallouts('createSAPCustomer');
        if (!ValidateFields()) return null;

        SBO_EnosixCustomer_Detail sbo = new SBO_EnosixCustomer_Detail();
        try
        {
            SBO_EnosixCustomer_Detail.EnosixCustomer customer = getCustomerRecord(this.cDetail,C_DETAIL_TYPE);
            if (null != customer) {
                customer.CustomerNumber =  string.isNotEmpty(customer.CustomerNumber) ? customer.CustomerNumber : '';
            }
            SBO_EnosixCustomer_Detail.EnosixCustomer result = sbo.save(customer);

            UTIL_ViewHelper.displayResultMessages(result.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);

            if (result.isSuccess())
            {
                List<SBO_EnosixCustomer_Detail.SALES_DATA> salesData = this.cDetail.SALES_DATA.getAsList();
                this.cDetail = setCustomerRecord(result, C_DETAIL_TYPE);

                if (this.cDetail.SALES_DATA.size() == 0)
                {
                    this.cDetail.SALES_DATA.addAll(salesData);
                }

                UTIL_SFAccount.setAccountCustomerNumber(this.account, this.cDetail.CustomerNumber);
                upsert(this.account);

                //redirect to customer Detail
                return UTIL_Customer.redirectToDisplayCustomer();
            }
        }
        catch (Exception e)
        {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, e.getMessage()));
        }
        return null;
    }

    @testVisible
    private static PageReference redirectToCustomerDetail(SBO_EnosixCustomer_Detail.EnosixCustomer customer)
    {
        UTIL_PageState.current.sapCustomerId = customer.CustomerNumber;
        return UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_CustomerDetail, UTIL_PageState.current);
    }

    @testVisible
    private static PageReference redirectToPartnerSearch(String accountId)
    {
        UTIL_PageState.current.sfAccountId = accountId;
        return UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_PartnerSearch, UTIL_PageState.current);
    }

    public PageReference redirectToOrderPage()
    {
        logCallouts('redirectToOrderPage');
        if (String.isNotBlank(this.newShipToNum))
        {
            UTIL_PageState.current.sapShipToNum = this.newShipToNum;
        }

        return UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_OrderCreateUpdate, UTIL_PageState.current);
    }

    public PageReference redirectToQuotePage()
    {
        logCallouts('redirectToQuotePage');
        if (String.isNotBlank(this.newShipToNum))
        {
            UTIL_PageState.current.sapShipToNum = this.newShipToNum;
        }

        return UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_QuoteCreateUpdate, UTIL_PageState.current);
    }

    public PageReference redirectToOppPage()
    {
        logCallouts('redirectToOppPage');
        if (String.isNotBlank(this.newShipToNum))
        {
            UTIL_PageState.current.sapShipToNum = this.newShipToNum;
        }

        return UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_OpportunityQuotePricing, UTIL_PageState.current);
    }

    public PageReference gotoCase()
    {
        logCallouts('gotoCase');
        return UTIL_PageFlow.redirectTo('/' + this.caseId, null);
    }

    public PageReference gotoAccounts()
    {
        logCallouts('gotoAccounts');
        return UTIL_PageFlow.redirectTo('/001/o', null);
    }

    @testVisible
    private static SBO_EnosixCustomer_Detail.SALES_DATA findMatchingSalesArea(
        SBO_EnosixCustomer_Detail.EnosixCustomer customer,
        SBO_EnosixCustomer_Detail.EnosixCustomer newPartner)
    {
        SBO_EnosixCustomer_Detail.SALES_DATA result = null;
        List<SBO_EnosixCustomer_Detail.SALES_DATA> custSalesList = customer.SALES_DATA.getAsList();
        Integer salesTot1 = custSalesList.size();
        List<SBO_EnosixCustomer_Detail.SALES_DATA> partnerSalesList = newPartner.SALES_DATA.getAsList();
        Integer salesTot2 = partnerSalesList.size();
        for (Integer salesCnt1 = 0 ; salesCnt1 < salesTot1 ; salesCnt1++)
        {
            SBO_EnosixCustomer_Detail.SALES_DATA customerSalesArea = custSalesList[salesCnt1];
            for (Integer salesCnt2 = 0 ; salesCnt2 < salesTot2 ; salesCnt2++)
            {
                SBO_EnosixCustomer_Detail.SALES_DATA partnerSalesArea = partnerSalesList[salesCnt2];
                if (customerSalesArea.SalesOrganization == partnerSalesArea.SalesOrganization &&
                    customerSalesArea.DistributionChannel == partnerSalesArea.DistributionChannel &&
                    customerSalesArea.Division == partnerSalesArea.Division)
                {
                    result = customerSalesArea;
                    break;
                }
            }

            if (result != null) break; 
        }

        return result;
    }

    @testVisible
    private static Boolean addPartnerToCustomer(
        SBO_EnosixCustomer_Detail.EnosixCustomer customer,
        SBO_EnosixCustomer_Detail.EnosixCustomer newPartner,
        String function)
    {
        SBO_EnosixCustomer_Detail.PARTNERS partner = new SBO_EnosixCustomer_Detail.PARTNERS();

        SBO_EnosixCustomer_Detail.SALES_DATA salesArea = findMatchingSalesArea(customer, newPartner);
        if (null == salesArea)
        {
            ApexPages.addMessage(new Apexpages.Message(
                ApexPages.Severity.ERROR, 'No matching sales area for partner.'));
            return false;
        }

        clearCustomerCollections(customer);
        customer.SALES_DATA.add(salesArea);

        partner.SalesOrganization = salesArea.SalesOrganization;
        partner.DistributionChannel = salesArea.DistributionChannel;
        partner.Division = salesArea.Division;
        partner.PartnerFunction = function;
        partner.PartnerNumber = newPartner.CustomerNumber;
        partner.PartnerName = newPartner.Name;

        customer.PARTNERS.add(partner);

        return true;
    }

    // clearCustomerCollections()
    //
    // Remove collections when adding partner to customer
    // avoid extra processing
    private static void clearCustomerCollections(SBO_EnosixCustomer_Detail.EnosixCustomer customer)
    {
        if (customer.COMPANY_DATA.size() > 0) customer.COMPANY_DATA.clear();
        if (customer.SALES_DATA.size() > 0) customer.SALES_DATA.clear();
        if (customer.PAYMENT_DATA.size() > 0) customer.PAYMENT_DATA.clear();
        if (customer.PARTNERS.size() > 0) customer.PARTNERS.clear();
        if (customer.SALES_TEXT.size() > 0) customer.SALES_TEXT.clear();
        if (customer.USER_DEFINED.size() > 0) customer.USER_DEFINED.clear();
        if (customer.CONTACTS.size() > 0) customer.CONTACTS.clear();
    }

    public PageReference actionUpdateSapCustomer()
    {
        logCallouts('actionUpdateSapCustomer');
        PageReference result = null;
        SBO_EnosixCustomer_Detail sbo = new SBO_EnosixCustomer_Detail();
        try
        {
            if (null != this.cDetail) {
                this.cDetail.CustomerNumber =  string.isNotEmpty(this.cDetail.CustomerNumber) ? this.cDetail.CustomerNumber : '';
            }
            SBO_EnosixCustomer_Detail.EnosixCustomer saveResult = sbo.save(this.cDetail);
            UTIL_ViewHelper.displayResultMessages(saveResult.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);

            if (saveResult.isSuccess())
            {
                this.cDetail = setCustomerRecord(saveResult, C_DETAIL_TYPE);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'SAP Customer Updated'));
            }
        }
        catch (Exception e)
        {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, e.getMessage()));
        }
        return actionDisplaySapCustomer();
    }

    public PageReference actionDisplaySapCustomer()
    {
        logCallouts('actionDisplaySapCustomer');
        return UTIL_Customer.redirectToDisplayCustomer();
    }

    @testVisible
    private static void AddBPRoleGroups(List<SelectOption> result, 
        List<RFC_SD_GET_BP_ROLE_TYPE.ET_BP_ROLE_GROUP> roleGroups)
    {
        Set<string> values = new Set<string>();
        Integer roleTot = roleGroups.size();
        for (Integer roleCnt = 0 ; roleCnt < roleTot ; roleCnt++)
        {
            RFC_SD_GET_BP_ROLE_TYPE.ET_BP_ROLE_GROUP roleGroup = roleGroups[roleCnt];
            if (String.isNotBlank(roleGroup.RLTGR) && !values.contains(roleGroup.RLTGR))
            {
                result.add(new SelectOption(
                    roleGroup.RLTGR, roleGroup.RLTGRTXT == null ? roleGroup.RLTGR : roleGroup.RLTGRTXT));
                values.add(roleGroup.RLTGR);
            }
        }
    }
    @testVisible
    private static void AddCountries(List<SelectOption> result, List<RFC_SD_GET_COUNTRIES.ET_OUTPUT> countries)
    {
        Integer countryTot = countries.size();
        for (Integer countryCnt = 0 ; countryCnt < countryTot ; countryCnt++)
        {
            RFC_SD_GET_COUNTRIES.ET_OUTPUT country = countries[countryCnt];
            if (String.isNotEmpty(country.LAND1))
            {
                result.add(new SelectOption(
                    country.LAND1, String.isEmpty(country.LANDX) ? country.LAND1 : country.LANDX));
            }            
        }
    }

    @testVisible
    private static void AddRegionsForCountry(
        List<SelectOption> result, List<RFC_SD_GET_COUNTRIES.ET_REGIONS> regions, String selectedCountry)
    {
        Integer regionTot = regions.size();
        for (Integer regionCnt = 0 ; regionCnt < regionTot ; regionCnt++)
        {
            RFC_SD_GET_COUNTRIES.ET_REGIONS region = regions[regionCnt];
            if (selectedCountry == region.LAND1 && string.isNotBlank(region.REGIO))
            {
                result.add(new SelectOption(
                    region.REGIO, String.isEmpty(region.BEZEI) ? region.REGIO : region.BEZEI));                                
            }
        }
    }
}