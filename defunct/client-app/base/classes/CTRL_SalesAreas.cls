public with sharing class CTRL_SalesAreas
    implements UTIL_SalesArea.DistributionChannel_Filter, UTIL_SalesArea.Division_Filter
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_SalesAreas.class);

    @testVisible
	private DS_SalesArea DataSource;

    public Boolean isPartnerMode { get; set; }

    public boolean isPaymentTermsEditEnabled
    {
        get
        {
            return (Boolean)UTIL_AppSettings.getValue('Customer.IsPaymentTermsEditEnabled', true);
        }
    }

    public String SalesOrganizationAndDistributionChannelAndDivision
    {
        get
        {
            if (null == SalesOrganizationAndDistributionChannelAndDivision)
            {
                SalesOrganizationAndDistributionChannelAndDivision = 
                    UTIL_ViewHelper.pickFirst(SalesOrganizationAndDistributionChannelAndDivisions);
            }
            return SalesOrganizationAndDistributionChannelAndDivision;
        }
        set
        {
            SalesOrganizationAndDistributionChannelAndDivision = value;
            String[] salesAreaValues = value.split('/');
            if (salesAreaValues.size() > 2)
            {
                SalesData.SalesOrganization = salesAreaValues[0];
                SalesData.DistributionChannel = salesAreaValues[1];
                SalesData.Division = salesAreaValues[2];
            }
        }
    }

    @testVisible
	Transient boolean hasUpdated = false;

	public void setMyDataSource(DS_SalesArea value)
    {
        if (this.hasUpdated==null)
        {
            this.hasUpdated=false;
        }
        if (this.DataSource==null)
        {
	        this.DataSource = value;
            updateSalesArea();
        }
        else if (value != null)
        {
           this.DataSource = value;
        }
    }

    public DS_SalesArea getMyDataSource()
    {
        return this.DataSource;
    }

    public void updateSalesArea()
    {
        if (string.isBlank(this.SalesData.SalesOrganization))
        {
        	this.SalesData.SalesOrganization = UTIL_ViewHelper.pickFirst(SalesOrganizations);
        }

        //Set the correct Distribution Channel
        List<SelectOption> distChannelOptions = this.DistributionChannels;
        if (distChannelOptions.size() > 0)
        {
            Boolean isDistChannelSet = false;
            Integer dcTot = distChannelOptions.size();
            for (Integer dcCnt = 0 ; dcCnt < dcTot ; dcCnt++)
            {
                SelectOption option = distChannelOptions[dcCnt];
                if (option.getValue() == this.SalesData.DistributionChannel)
                {
                    isDistChannelSet = true;
                    break;
                }
            }
            if (!isDistChannelSet) this.SalesData.DistributionChannel = UTIL_ViewHelper.pickFirst(distChannelOptions);
        }

        // Set the correct Division
        List<SelectOption> divisionOptions = this.Divisions;
        if (divisionOptions.size() > 0)
        {
            Boolean isDivisionSet = false;
            Integer dTot = divisionOptions.size();
            for (Integer dCnt = 0 ; dCnt < dTot ; dCnt++)
            {
                SelectOption option = divisionOptions[dCnt];
                if (option.getValue() == this.SalesData.Division)
                {
                    isDivisionSet = true;
                    break;
                }
            }
            if (!isDivisionSet) this.SalesData.Division = UTIL_ViewHelper.pickFirst(divisionOptions);
        }

        if (string.isBlank(this.SalesOrganizationAndDistributionChannelAndDivision))
        {
            String defaultValue = UTIL_ViewHelper.pickFirst(SalesOrganizationAndDistributionChannelAndDivisions);
            if (defaultValue != null && defaultValue.length() > 0)
            {
        	   this.SalesOrganizationAndDistributionChannelAndDivision = defaultValue;
            }
        }

        if (string.isBlank(this.SalesData.SalesGroup))
        {
         	this.SalesData.SalesGroup = UTIL_ViewHelper.pickFirst(SalesGroups);
        }
        if (string.isBlank(this.SalesData.PriceGroup))
        {
        	this.SalesData.PriceGroup = UTIL_ViewHelper.pickFirst(PriceGroups);
        }

        if (string.isBlank(this.SalesData.PriceListType))
	    {
        	this.SalesData.PriceListType = UTIL_ViewHelper.pickFirst(PriceLists);
        }

        if (string.isBlank(this.SalesData.CustomerPricingProcedure))
	    {
        	this.SalesData.CustomerPricingProcedure = UTIL_ViewHelper.pickFirst(PriceProcedures);
        }

        if (string.isBlank(this.SalesData.PriceGroup)) {
        	this.SalesData.PriceGroup = UTIL_ViewHelper.pickFirst(PriceGroups);
        }

        if (string.isBlank(this.SalesData.ShippingConditions))
        {
        	this.SalesData.ShippingConditions = UTIL_ViewHelper.pickFirst(ShippingConditions);
        }

        if (string.isBlank(this.SalesData.TermsofPaymentKey))
        {
        	this.SalesData.TermsofPaymentKey = UTIL_ViewHelper.pickFirst(PaymentTerms);
        }
        if(null!=this.dataSource && this.hasUpdated!=null && !this.hasUpdated)
        {
            this.dataSource.updateSalesArea(this.SalesData);
            hasUpdated= true;
        }
    }

    public string getSelectedSalesOrganization()
    {
    	return this.SalesData.SalesOrganization;
    }

    public string getSelectedDistributionChannel()
    {
    	return this.SalesData.DistributionChannel;
    }

    private boolean checkSource()
    {
    	if (null == this.DataSource)
        {
    	    return false;
    	}
    	return true;
    }

    public List<SBO_EnosixCustomer_Detail.SALES_DATA> ParentCustomerSalesArea
    {
    	get
        {
    		if (checkSource())
            {
    			return this.DataSource.getParentCustomerSalesAreas();
    		}
    		return new List<SBO_EnosixCustomer_Detail.SALES_DATA>();
    	}
    }
    public RFC_SD_GET_SALES_AREAS.RESULT SalesAreaMaster
    {
    	get
        {
    	    if (checkSource())
            {
    	        return this.DataSource.getSalesAreas();
    	    }
    	    return new RFC_SD_GET_SALES_AREAS.RESULT();
    	}
    }

    public RFC_SD_GET_GROUP_OFFICE.RESULT GroupOfficeMaster
    {
    	get
        {
    	    if (checkSource())
            {
    	        return this.DataSource.getGroupOffice();
    	    }
    	    return new RFC_SD_GET_GROUP_OFFICE.RESULT();
    	}
    }

    public RFC_SD_GET_PRICING_STAT.RESULT PricingMaster
    {
    	get
        {
    	    if (checkSource())
            {
    	        return this.DataSource.getPricingStat();
    	    }
    	    return new RFC_SD_GET_PRICING_STAT.RESULT();
    	}
    }

    public RFC_SD_GET_SHIP_INFO.RESULT ShippingMaster
    {
    	get
        {
    	    if (checkSource())
            {
    	        return this.DataSource.getShipInfo();
    	    }
    	    return new RFC_SD_GET_SHIP_INFO.RESULT();
    	}
    }

    public SBO_EnosixCustomer_Detail.SALES_DATA SalesData
    {
    	get
        {
    	    if (checkSource())
            {
    	        return this.DataSource.getSALES_DATA();
    	    }
    	    return new SBO_EnosixCustomer_Detail.SALES_DATA();
    	}
    }

    @testVisible
    private static string dropDownDescriptionFormat
    {
        get
        {
            return UTIL_SelectOption.dropDownDescriptionFormat;
        }
    }

    public List<SelectOption> SalesOrganizationAndDistributionChannelAndDivisions
    {
      	get
        {
    		List<SelectOption> result = UTIL_SelectOption.buildOptionsFromList(
    				new UTIL_SalesArea.SalesOrganizationAndDistributionChannelAndDivisions_OptionBuilder(),
    				this.ParentCustomerSalesArea
    		);
            return UTIL_SelectOption.getOptionsByUniqueValue(result);
        }
    }

	public List<SelectOption> SalesOrganizations
    {
      	get
        {
    		List<SelectOption> result = UTIL_SelectOption.buildOptionsFromList(
    				new UTIL_SalesArea.SalesOrganization_OptionBuilder(),
    				this.SalesAreaMaster.SalesAreas_List
    		);
            return UTIL_SelectOption.getOptionsByUniqueValue(result);
        }
    }

    public List<SelectOption> DistributionChannels
    {
        get
        {
            List<SelectOption> result = UTIL_SelectOption.buildOptionsFromList(
                new UTIL_SalesArea.DistributionChannel_OptionBuilder(this),
                this.SalesAreaMaster.SalesAreas_List);
            return UTIL_SelectOption.getOptionsByUniqueValue(result);
        }
    }

    public List<SelectOption> Divisions
    {
        get
        {
            List<SelectOption> result = UTIL_SelectOption.buildOptionsFromList(
                new UTIL_SalesArea.Division_OptionBuilder(this),
                this.SalesAreaMaster.SalesAreas_List);
            return UTIL_SelectOption.getOptionsByUniqueValue(result);
        }
    }

    public List<SelectOption> SalesOffices
    {
        get
        {
            List<SelectOption> result = new List<SelectOption>();

            if (checkSource())
            {
            	AddSalesOffice(result, this.GroupOfficeMaster.ET_SALES_OFFICE_List,
            		this.SalesData.SalesOrganization, this.SalesData.DistributionChannel, this.SalesData.Division);
            }

            return UTIL_SelectOption.getOptionsByUniqueValue(result);
        }
    }

    public List<SelectOption> SalesGroups
    {
        get
        {
            List<SelectOption> result = new List<SelectOption>();

            if (checkSource())
            {
            	AddSalesGroups(result, this.GroupOfficeMaster.ET_SALES_GROUP_List,
            		this.SalesData.SalesOffice);
            }

            return UTIL_SelectOption.getOptionsByUniqueValue(result);
        }
    }

    public List<SelectOption> SalesDistricts
    {
        get
        {
            List<SelectOption> result = new List<SelectOption>();
            result.add(new SelectOption('', '(Default)'));
            if (checkSource())
            {
            	AddSalesDistricts(result, this.GroupOfficeMaster.ET_SALES_DISTRICT_List);
            }

            return UTIL_SelectOption.getOptionsByUniqueValue(result);
        }
    }

    public List<SelectOption> PriceLists
    {
        get
        {
            List<SelectOption> result = new List<SelectOption>();

            if (checkSource())
            {
            	AddPriceList(result, this.PricingMaster.ET_CUST_PRICE_LIST_List);
            }

            return UTIL_SelectOption.getOptionsByUniqueValue(result);
        }
    }

    public List<SelectOption> PriceProcedures
    {
        get
        {
            List<SelectOption> result = new List<SelectOption>();

            if (checkSource())
            {
            	AddPriceProcedure(result, this.PricingMaster.ET_CUST_PRICE_PROC_List);
            }

            return UTIL_SelectOption.getOptionsByUniqueValue(result);
        }
    }

    public List<SelectOption> PriceGroups
    {
        get
        {
            List<SelectOption> result = new List<SelectOption>();

            if (checkSource())
            {
            	AddPriceGroup(result, this.PricingMaster.ET_CUST_PRICE_GRP_List);
            }

            return UTIL_SelectOption.getOptionsByUniqueValue(result);
        }
    }

    public List<SelectOption> PaymentTerms
    {
        get
        {
            List<SelectOption> result = new List<SelectOption>();

            if (checkSource())
            {
            	AddPaymentTerms(result, this.ShippingMaster.ET_PAY_TERMS_List);
            }

            return UTIL_SelectOption.getOptionsByUniqueValue(result);
        }
    }

    public List<SelectOption> ShippingConditions
    {
        get
        {
            List<SelectOption> result = new List<SelectOption>();

            if (checkSource())
            {
            	AddShippingConditions(result, this.ShippingMaster.ET_SHIP_COND_List);
            }

            return UTIL_SelectOption.getOptionsByUniqueValue(result);
        }
    }

    @testVisible
    private static void AddSalesOffice(List<SelectOption> result, List<RFC_SD_GET_GROUP_OFFICE.ET_SALES_OFFICE> offices,
    	string salesOrganization, string distributionChannel, string division)
    {
    	Set<string> values = new Set<string>();
        Integer offTot = offices.size();
    	for (Integer offCnt = 0 ; offCnt < offTot ; offCnt++)
        {
            RFC_SD_GET_GROUP_OFFICE.ET_SALES_OFFICE office = offices[offCnt];
            if (!  values.contains(office.VKBUR)
            	&& office.SalesOrganization.equalsIgnoreCase(salesOrganization)
            	&& office.DistributionChannel.equalsIgnoreCase(distributionChannel)
            	&& office.Division.equalsIgnoreCase(division)
                && (true || 'NTL' == office.VKBUR || 'STD' == office.VKBUR)
            	)
            {
                    string description = string.format(dropDownDescriptionFormat, new string[]{office.VKBUR, office.BEZEI});
                 result.add(new SelectOption(office.VKBUR, description));
                 values.add(office.VKBUR);
            }
        }
    }

    @testVisible
    private static void AddSalesGroups(List<SelectOption> result, List<RFC_SD_GET_GROUP_OFFICE.ET_SALES_GROUP> salesGroups,
    	string salesOffice)
    {
    	Set<string> values = new Set<string>();
        Integer sgTot = salesGroups.size();
    	for (Integer sgCnt = 0 ; sgCnt < sgTot ; sgCnt++)
        {
            RFC_SD_GET_GROUP_OFFICE.ET_SALES_GROUP salesGroup = salesGroups[sgCnt];
            if (!values.contains(salesGroup.SalesGroup) &&  salesGroup.VKBUR.equalsIgnoreCase(salesOffice)  )
            {
                string description = string.format(dropDownDescriptionFormat, new string[]{salesGroup.SalesGroup, salesGroup.BEZEI});
                result.add(new SelectOption(salesGroup.SalesGroup, description));
                values.add(salesGroup.SalesGroup);
            }
        }
    }

    @testVisible
    private static void AddSalesDistricts(List<SelectOption> result, List<RFC_SD_GET_GROUP_OFFICE.ET_SALES_DISTRICT> districts)
    {
    	Set<string> values = new Set<string>();
        Integer dTot = districts.size();
    	for (Integer dCnt = 0 ; dCnt < dTot ; dCnt++)
        {
            RFC_SD_GET_GROUP_OFFICE.ET_SALES_DISTRICT district = districts[dCnt];
            if (!values.contains(district.BZIRK))
            {
                string description = string.format(dropDownDescriptionFormat, new string[]{district.BZIRK, district.BZTXT});
                result.add(new SelectOption(district.BZIRK, description));
                values.add(district.BZIRK);
            }
        }
    }

    @testVisible
    private static void AddPriceList(List<SelectOption> result, List<RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_LIST> prices )
    {
    	Set<string> values = new Set<string>();
        Integer pTot = prices.size();
    	for (Integer pCnt = 0 ; pCnt < pTot ; pCnt++)
        {
            RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_LIST price = prices[pCnt];
            if (!values.contains(price.PLTYP))
            {
                 string description = string.format(dropDownDescriptionFormat, new string[]{price.PLTYP, price.PTEXT});
                 result.add(new SelectOption(price.PLTYP, description));
                 values.add(price.PLTYP);
            }
        }
    }

    @testVisible
    private static void AddPriceProcedure(List<SelectOption> result, List<RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_PROC> priceProcedures )
    {
    	Set<string> values = new Set<string>();
        Integer pTot = priceProcedures.size();
    	for (Integer pCnt = 0 ; pCnt < pTot ; pCnt++)
        {
            RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_PROC priceProcedure = priceProcedures[pCnt];
            if (!values.contains(priceProcedure.KALKS))
            {
                 string description = string.format(dropDownDescriptionFormat, new string[]{priceProcedure.KALKS, priceProcedure.VTEXT});
                 result.add(new SelectOption(priceProcedure.KALKS, description));
                 values.add(priceProcedure.KALKS);
            }
        }
    }

    @testVisible
    private static void AddPriceGroup(List<SelectOption> result, List<RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_GRP> priceGroups )
    {
    	Set<string> values = new Set<string>();
        Integer pgTot = priceGroups.size();
    	for (Integer pgCnt = 0 ; pgCnt < pgTot ; pgCnt++)
        {
            RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_GRP priceGroup = priceGroups[pgCnt];
            if (!values.contains(priceGroup.KONDA))
            {
                 string description = string.format(dropDownDescriptionFormat, new string[]{priceGroup.KONDA, priceGroup.VTEXT});
                 result.add(new SelectOption(priceGroup.KONDA, description));
                 values.add(priceGroup.KONDA);
            }
        }
    }

    @testVisible

    private static void AddPaymentTerms(List<SelectOption> result, List<RFC_SD_GET_SHIP_INFO.ET_PAY_TERMS> paymentTerms )
    {
    	Set<string> values = new Set<string>();
        Integer termTot = paymentTerms.size();
    	for (Integer termCnt = 0 ; termCnt < termTot ; termCnt++)
        {
            RFC_SD_GET_SHIP_INFO.ET_PAY_TERMS paymentTerm = paymentTerms[termCnt];
            if (string.isNotBlank( paymentTerm.ZTERM ) && string.isNotBlank(paymentTerm.VTEXT ) && !values.contains(paymentTerm.ZTERM))
            {
                 string description = string.format(dropDownDescriptionFormat, new string[]{paymentTerm.ZTERM, paymentTerm.VTEXT});
                 result.add(new SelectOption(paymentTerm.ZTERM, description));
                 values.add(paymentTerm.ZTERM);
            }
        }
    }

    @testVisible
    private static void AddShippingConditions(List<SelectOption> result, List<RFC_SD_GET_SHIP_INFO.ET_SHIP_COND> shippingConditions )
    {
    	Set<string> values = new Set<string>();
        Integer scTot = shippingConditions.size();
    	for (Integer scCnt = 0 ; scCnt < scTot ; scCnt++)
        {
            RFC_SD_GET_SHIP_INFO.ET_SHIP_COND shippingCondition = shippingConditions[scCnt];
            if (!values.contains(shippingCondition.ShippingConditions))
            {
                 string description = string.format(dropDownDescriptionFormat, new string[]{shippingCondition.ShippingConditions, shippingCondition.VTEXT});
                 result.add(new SelectOption(shippingCondition.ShippingConditions, description));
                 values.add(shippingCondition.ShippingConditions);
            }
        }
    }
}