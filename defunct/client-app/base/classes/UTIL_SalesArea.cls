/* utility class for Sales Area information */
public class UTIL_SalesArea
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_SalesArea.class);

	// getSalesAreaMaster()
	//
	// Gets the sales area master data from RFC
	public static RFC_SD_GET_SALES_AREAS.RESULT getSalesAreaMaster()
	{
		RFC_SD_GET_SALES_AREAS rfc = new RFC_SD_GET_SALES_AREAS();
		RFC_SD_GET_SALES_AREAS.RESULT result = rfc.execute();
		UTIL_Error.displayResultErrors(result);
		return result;
	}

	public static boolean isSales_Area(object item)
	{
		return item instanceof RFC_SD_GET_SALES_AREAS.SalesAreas;
	}

	public static RFC_SD_GET_SALES_AREAS.SalesAreas asSales_Area(object item)
	{
		return (RFC_SD_GET_SALES_AREAS.SalesAreas)item;
	}

	public class SalesOrganizationAndDistributionChannelAndDivisions_OptionBuilder extends UTIL_SelectOption.OptionBuilder
	{
		public override String getItemValue(object item)
		{
			return ((SBO_EnosixCustomer_Detail.SALES_DATA)item).SalesOrganization + '/' +
				((SBO_EnosixCustomer_Detail.SALES_DATA)item).DistributionChannel + '/' +
				((SBO_EnosixCustomer_Detail.SALES_DATA)item).Division;
		}

		public override String getItemDescription(object item)
		{
			String description =
				String.format(
					UTIL_SelectOption.dropDownDescriptionFormat,
					new String[]{((SBO_EnosixCustomer_Detail.SALES_DATA)item).SalesOrganization,
					((SBO_EnosixCustomer_Detail.SALES_DATA)item).SalesOrganizationName});

			description += ' / ' +
				String.format(UTIL_SelectOption.dropDownDescriptionFormat,
					new String[]{((SBO_EnosixCustomer_Detail.SALES_DATA)item).DistributionChannel,
					((SBO_EnosixCustomer_Detail.SALES_DATA)item).DistributionChannelName});

			description += ' / ' +
				String.format(UTIL_SelectOption.dropDownDescriptionFormat,
					new String[]{((SBO_EnosixCustomer_Detail.SALES_DATA)item).Division,
					((SBO_EnosixCustomer_Detail.SALES_DATA)item).DivisionName});

			return description;
		}

		//This dropdown only needs to display the description for the Label
		public override String getItemLabel(object item)
		{
			//Comment out this block for debugging
			return getItemDescription(item);
		}
  	}

	public class SalesOrganization_OptionBuilder extends UTIL_SelectOption.OptionBuilder
	{
		Boolean isFiltered = true;

		public SalesOrganization_OptionBuilder ()
		{
			this(true);
		}

		public SalesOrganization_OptionBuilder (Boolean isFiltered)
		{
			this.isFiltered = isFiltered;
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

	//Provides methods for restricting the distribution channel
	//and Division options. Both of those have a restriction
	//based upon the currently selected sales area.
	public interface DistributionChannel_Filter
	{
		String getSelectedSalesOrganization();
	}

	public class DistributionChannel_OptionBuilder extends UTIL_SelectOption.OptionBuilder
	{
		private DistributionChannel_Filter filter;

		public DistributionChannel_OptionBuilder (DistributionChannel_Filter filter)
		{
			this.filter = filter;
		}

		public override Boolean isItemDisplayed(object item)
		{
			if (isSales_Area(item))
			{
				String salesOrg = filter.getSelectedSalesOrganization();
				String itemOrg = asSales_Area(item).SalesOrganization;
				return salesOrg != null && salesOrg.equals( itemOrg );
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

	//Provides methods for restricting the division drop down lists
	//Division is restricted both by the currently selected distribution channel
	//and the sales area. (see super interface.)
	public interface Division_Filter extends DistributionChannel_Filter
	{
		String getSelectedDistributionChannel();
	}

	public class Division_OptionBuilder extends UTIL_SelectOption.OptionBuilder
	{
		private Division_Filter filter;

		public Division_OptionBuilder (Division_Filter filter)
		{
			this.filter = filter;
		}

		public override boolean isItemDisplayed(object item)
		{
			if (isSales_Area(item))
			{

				string salesOrg = filter.getSelectedSalesOrganization();
				string itemOrg = asSales_Area(item).SalesOrganization;
				string salesChannel = filter.getSelectedDistributionChannel();
				string itemChannel = asSales_Area(item).DistributionChannel;
				string division = asSales_Area(item).Division;

				return salesOrg != null && salesOrg.equals( itemOrg ) &&
					salesChannel != null && salesChannel.equals( itemChannel );
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
}