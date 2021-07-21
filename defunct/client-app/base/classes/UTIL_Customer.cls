public with sharing class UTIL_Customer
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_Customer.class);

    public static final string SOLD_TO_PARTNER_CODE = 'SP';
    public static final string SHIP_TO_PARTNER_CODE = 'SH';
    public static final string CARRIER_PARTNER_CODE = 'CR';
    public static final string PAYER_PARTNER_CODE = 'PY';
    public static final string BILL_TO_PARTNER_CODE = 'BP';
    
    public class CustomerNotFoundException extends Exception 
    { 
        private List<ensxsdk.EnosixFramework.Message> messages {get;set;}
        private string customerNumber {get; set;}

        public CustomerNotFoundException(string customerNumber, List<ensxsdk.EnosixFramework.Message> messages)
        {
            this.messages = messages;
            this.customerNumber = customerNumber;
        }

        public override String getMessage()
        {
            return String.format(System.Label.LBL_SAP_Get_Customer_Error, new String[]{customerNumber});
        }

        public List<ensxsdk.EnosixFramework.Message> getSAPMessages()
        {
            return messages;
        }
    }

    public static Set<string> allowedClientTypes
    {
        get
        {
            return (Set<String>)UTIL_AppSettings.getSet(
                'Customer.AllowedClientTypes', String.class, new Set<String>{'*'});
        }
    }

    public static SBO_EnosixCustomer_Detail.EnosixCustomer getCustomerByNumber(String id)
    {
        SBO_EnosixCustomer_Detail sbo = new SBO_EnosixCustomer_Detail();
        SBO_EnosixCustomer_Detail.EnosixCustomer result = sbo.getDetail(id);

        if (!result.isSuccess())
        {
        	UTIL_ViewHelper.displayResultMessages(
                result.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
            // throw new CustomerNotFoundException(customerNumber, result.getMessages());
            return null;
        }

        return result;
    }

    // Helper method to save customer record. Returns updated customer if successful,
    // otherwise displays errors and returns null
    public static SBO_EnosixCustomer_Detail.EnosixCustomer saveCustomer(
        SBO_EnosixCustomer_Detail.EnosixCustomer customer)
    {
        SBO_EnosixCustomer_Detail sbo = new SBO_EnosixCustomer_Detail();
        SBO_EnosixCustomer_Detail.EnosixCustomer result = null;

        try
        {
            result = sbo.save(customer);
        }
        catch (Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            return null;
        }

        if (!result.isSuccess())
        {
            UTIL_ViewHelper.displayResultMessages(
                result.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
            return null;
        }

        return result;
    }

    public static PageReference redirectToEditCustomer()
    {
        return UTIL_PageFlow.redirectTo(
            UTIL_PageFlow.VFP_CustomerCreateUpdate, UTIL_PageState.current);
    }

    public static PageReference redirectToDisplayCustomer()
    {
        return UTIL_PageFlow.redirectTo(
            UTIL_PageFlow.VFP_CustomerDetail, UTIL_PageState.current);
    }

    public static PageReference redirectToCreateCustomer()
    {
        return UTIL_PageFlow.redirectTo(
            UTIL_PageFlow.VFP_CustomerCreateUpdate, UTIL_PageState.current);
    }
   
    public static SBO_SFCIPartner_Search.SEARCHRESULT getPartnerFromCustomer(
        SBO_EnosixCustomer_Detail.EnosixCustomer customer, string function)
    {
        SBO_SFCIPartner_Search.SEARCHRESULT result = null;

        if (null != customer)
        {
            List<SBO_SFCIPartner_Search.SEARCHRESULT> partners = getPartners(customer);

            Integer resultTot = partners.size();
            for (Integer resultCnt = 0 ; resultCnt < resultTot ; resultCnt++)
            {         
                SBO_SFCIPartner_Search.SEARCHRESULT partner = partners[resultCnt];   
                if (function == partner.PartnerFunction)
                {
                    result = partner;
                    break;
                }
            }
        }

        return result;
    }

    public static List<SBO_SFCIPartner_Search.SEARCHRESULT> getCustomerPartners(
        SBO_EnosixCustomer_Detail.EnosixCustomer customer, string function)
    {
        List<SBO_SFCIPartner_Search.SEARCHRESULT> result = new List<SBO_SFCIPartner_Search.SEARCHRESULT>();
        List<SBO_SFCIPartner_Search.SEARCHRESULT> partners = getPartners(customer);

        Integer resultTot = partners.size();
        for (Integer resultCnt = 0 ; resultCnt < resultTot ; resultCnt++)
        {         
            SBO_SFCIPartner_Search.SEARCHRESULT partner = partners[resultCnt];   
            if (function == partner.PartnerFunction)
            {
                result.add(partner);
            }
        }

        return result;
    }

    private static String sboEnosixPartnerSearchCustomerNumber;
    private static List<SBO_SFCIPartner_Search.SEARCHRESULT> sboEnosixPartnerReturn;
    @testVisible
    private static List<SBO_SFCIPartner_Search.SEARCHRESULT> getPartners(SBO_EnosixCustomer_Detail.EnosixCustomer customer)
    {
        List<SBO_SFCIPartner_Search.SEARCHRESULT> partners = new List<SBO_SFCIPartner_Search.SEARCHRESULT>();
        if (sboEnosixPartnerSearchCustomerNumber == null || sboEnosixPartnerSearchCustomerNumber != customer.CustomerNumber)
        {
            SBO_SFCIPartner_Search.SFCIPartner_SC searchContext = new SBO_SFCIPartner_Search.SFCIPartner_SC();
            SBO_SFCIPartner_Search sbo = new SBO_SFCIPartner_Search();
            searchContext.SEARCHPARAMS.CustomerNumber = customer.CustomerNumber;
            searchContext.pagingOptions.pageSize = 999999999;
            sbo.search(searchContext);
            SBO_SFCIPartner_Search.SFCIPartner_SR searchResults = searchContext.result;
            if (!searchResults.isSuccess())
            {
                System.debug('Failed searching for partners');
                return partners;
            }
            sboEnosixPartnerSearchCustomerNumber = customer.CustomerNumber;
            partners = searchResults.getResults();
            sboEnosixPartnerReturn = partners;
        }
        else
        {
            partners = sboEnosixPartnerReturn;
        }
        return partners;
    }

    public static void AddPartners(List<SelectOption> result, List<SBO_SFCIPartner_Search.SEARCHRESULT> partners,
            string salesOrganization, string distributionChannel, string division)
    {
        List<SelectOption> tmpList = UTIL_SelectOption.buildOptionsFromList(
                new Partner_OptionBuilder(salesOrganization, distributionChannel, division),
                partners, false);

        result.addAll(UTIL_SelectOption.getOptionsByUniqueValue(tmpList));
    }

    @testVisible
    private class Partner_OptionBuilder extends UTIL_SelectOption.OptionBuilder
	{
        String salesOrganization;
        String distributionChannel;
        String division;

		public Partner_OptionBuilder (String salesOrganization, String distributionChannel, String division)
		{
            this.salesOrganization = salesOrganization;
            this.distributionChannel = distributionChannel;
            this.division = division;
		}

        public override boolean isItemDisplayed(object item)
		{
			if (isPartner(item))
			{
                SBO_SFCIPartner_Search.SEARCHRESULT partner = asPartner(item);

				return (string.isNotBlank(partner.PartnerNumber) &&
                    this.salesOrganization == partner.salesOrganization &&
                    this.distributionChannel == partner.DistributionChannel &&
                    this.division == partner.Division);
			}
			return super.isItemDisplayed(item);
		}

		public override String getItemValue(object item)
		{
			if (isPartner(item))
			{
				return asPartner(item).PartnerNumber;
			}
			return super.getItemValue(item);
		}

		public override String getItemDescription(object item)
		{
			if (isPartner(item))
			{
				return asPartner(item).PartnerName;
			}
			return super.getItemDescription(item);
		}

		//This dropdown only needs to display the description for the Label
		public override String getItemLabel(object item)
		{
			//Comment out this block for debugging
			if(isPartner(item))
			{
				return String.format(
					UTIL_SelectOption.dropDownDescriptionFormat,
					new String[]{getItemValue(item), getItemDescription(item)});
			}
			return super.getItemLabel(item);
		}
	}

    private static boolean isPartner(object item)
	{
		return item instanceof SBO_SFCIPartner_Search.SEARCHRESULT;
	}

    private static SBO_SFCIPartner_Search.SEARCHRESULT asPartner(object item)
	{
		return (SBO_SFCIPartner_Search.SEARCHRESULT)item;
	}

    public static List<SBO_EnosixCustomer_Detail.SALES_DATA> getSalesDataListFromCustomer(SBO_EnosixCustomer_Detail.EnosixCustomer customer)
    {
        List<SBO_EnosixCustomer_Detail.SALES_DATA> result = new List<SBO_EnosixCustomer_Detail.SALES_DATA>();
        if (null != customer)
        {
            customer.SALES_DATA.copyTo(result);
        }
        return result;
    }

    public static void AddSalesOrganizations(List<SelectOption> result, List<SBO_EnosixCustomer_Detail.SALES_DATA> areas)
    {
        List<SelectOption> tmpList = UTIL_SelectOption.buildOptionsFromList(
                new SalesOrganization_OptionBuilder(),
                areas, false);
        result.addAll(UTIL_SelectOption.getOptionsByUniqueValue(tmpList));
    }

    public class SalesOrganization_OptionBuilder extends UTIL_SelectOption.OptionBuilder
	{
		public SalesOrganization_OptionBuilder ()
		{
		}

        public override String getItemValue(object item)
		{
			if (isSales_Area(item))
			{
				return asSales_Area(item).SalesOrganization;
			}
			return super.getItemValue(item);
		}

		public override String getItemDescription(object item)
		{
			if (isSales_Area(item))
			{
				return asSales_Area(item).SalesOrganizationName;
			}
			return super.getItemDescription(item);
		}

		//This dropdown only needs to display the description for the Label
		public override String getItemLabel(object item)
		{
			//Comment out this block for debugging
			if(isSales_Area(item))
			{
				return String.format(
					UTIL_SelectOption.dropDownDescriptionFormat,
					new String[]{getItemValue(item), getItemDescription(item)});
			}
			return super.getItemLabel(item);
		}
	}

    public static boolean isSales_Area(object item)
	{
		return item instanceof SBO_EnosixCustomer_Detail.SALES_DATA;
	}

	public static SBO_EnosixCustomer_Detail.SALES_DATA asSales_Area(object item)
	{
		return (SBO_EnosixCustomer_Detail.SALES_DATA)item;
	}

    public static void AddDistributionChannels(List<SelectOption> result, 
        List<SBO_EnosixCustomer_Detail.SALES_DATA> areas, string salesOrganization)
    {
        List<SelectOption> tmpList = UTIL_SelectOption.buildOptionsFromList(
                new DistributionChannel_OptionBuilder(salesOrganization),
                areas, false);

        result.addAll(UTIL_SelectOption.getOptionsByUniqueValue(tmpList));
    }

    public class DistributionChannel_OptionBuilder extends UTIL_SelectOption.OptionBuilder
	{
		String salesOrganization;

		public DistributionChannel_OptionBuilder (String salesOrganization)
		{
			this.salesOrganization = salesOrganization;
		}

		public override Boolean isItemDisplayed(object item)
		{
			if (isSales_Area(item))
			{
				String itemOrg = asSales_Area(item).SalesOrganization;
				return this.salesOrganization == itemOrg;
			}

			return super.isItemDisplayed(item);
		}

		public override String getItemValue(object item)
		{
			if (isSales_Area(item))
			{
				return asSales_Area(item).DistributionChannel;
			}
			return super.getItemValue(item);
		}

		public override String getItemDescription(object item)
		{
			if (isSales_Area(item))
			{
				return asSales_Area(item).DistributionChannelName;
			}
			return super.getItemDescription(item);
		}

		//This dropdown only needs to display the description for the Label
		public override String getItemLabel(object item)
		{
			//Comment out this block for debugging
			if (isSales_Area(item))
			{
				return String.format(
					UTIL_SelectOption.dropDownDescriptionFormat,
					new String[]{getItemValue(item), getItemDescription(item)});
			}
			return super.getItemLabel(item);
		}
	}

    public static void AddDistributionDivisions(List<SelectOption> result, 
        List<SBO_EnosixCustomer_Detail.SALES_DATA> areas, string salesOrganization, string distributionChannel)
    {
        List<SelectOption> tmpList = UTIL_SelectOption.buildOptionsFromList(
                new DistributionDivisions_OptionBuilder(salesOrganization, distributionChannel),
                areas, false);

        result.addAll(UTIL_SelectOption.getOptionsByUniqueValue(tmpList));
    }

    public class DistributionDivisions_OptionBuilder extends UTIL_SelectOption.OptionBuilder
	{
        String salesOrganization;
        String distributionChannel;

		public DistributionDivisions_OptionBuilder (String salesOrganization, String distributionChannel)
		{
			this.salesOrganization = salesOrganization;
            this.distributionChannel = distributionChannel;
		}

		public override boolean isItemDisplayed(object item)
		{
			if (isSales_Area(item))
			{

				string itemOrg = asSales_Area(item).SalesOrganization;
				string itemChannel = asSales_Area(item).DistributionChannel;

				return this.salesOrganization == itemOrg && this.distributionChannel == itemChannel;
			}
			return super.isItemDisplayed(item);
		}

		public override String getItemValue(object item)
		{
			if (isSales_Area(item))
			{
				return asSales_Area(item).Division;
			}
			return super.getItemValue(item);
		}

		public override String getItemDescription(object item)
		{
			if (isSales_Area(item))
			{
				return asSales_Area(item).DivisionName;
			}
			return super.getItemDescription(item);
		}

		//This dropdown only needs to display the description for the Label
		public override String getItemLabel(object item)
		{
			//Comment out this block for debugging
			if(isSales_Area(item))
			{
				return String.format(
					UTIL_SelectOption.dropDownDescriptionFormat,
					new String[]{getItemValue(item), getItemDescription(item)});
			}
			return super.getItemLabel(item);
		}
	}

    public static UTIL_SelectOption.OptionBuilder getCustomerConditionOptionBuilder1()
    {
        return (UTIL_SelectOption.OptionBuilder) UTIL_AppSettings.getInstance(
            'Order.CustomerConditionGroupBuilder1', CustomerConditonOptionBuilder.class);
    }

    public static UTIL_SelectOption.OptionBuilder getCustomerConditionOptionBuilder2()
    {
        return (UTIL_SelectOption.OptionBuilder) UTIL_AppSettings.getInstance(
            'Order.CustomerConditionGroupBuilder2', CustomerConditonOptionBuilder.class);
    }

    public virtual class CustomerConditonOptionBuilder extends UTIL_SelectOption.OptionBuilder
    {
        public override string getItemValue(object item)
        {
            return ((RFC_SD_GET_CONDITION_GROUP.ET_COND_GROUP)item).KDKGR;
        }

        public override string getItemDescription(object item)
        {
            return ((RFC_SD_GET_CONDITION_GROUP.ET_COND_GROUP)item).VTEXT;
        }

        public override string getItemLabel(object item)
        {
            return getItemDescription(item);
        }
    }
}