public with sharing class CTRL_ContactCreate
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_ContactCreate.class);

    public Boolean isLogging
    {
        get
        {
            return (Boolean)UTIL_AppSettings.getValue('CTRL_ContactCreate.Logging', false);
        }
    }

    public void logCallouts(String location)
    {
        if (isLogging)
        {
            logger.enterVfpConstructor(location, null);
        }
    }    

    private SBO_EnosixCustomer_Detail.EnosixCustomer customerDetail { get; private set; }
    public SBO_EnosixCustomer_Detail.CONTACTS newContact { get; set; }
    public String contactId { get; private set; }
    public Boolean canCreateContact { get; private set; }
    public String accountId { get; private set; }
    public Account account { get; private set; }

    public Boolean hasAccount { get { return String.isNotBlank(UTIL_PageState.current.sfAccountId); } }
    public Boolean isClassic
    {
        get {return (UserInfo.getUiThemeDisplayed() == 'Theme3');}
    }

    @testVisible
    public String customerNumber { get; private set; }

    // ctor()
    public CTRL_ContactCreate()
    {
        logCallouts('CTRL_ContactCreate');
        newContact = new SBO_EnosixCustomer_Detail.CONTACTS();
        this.contactId = UTIL_PageState.current.sfContactId;
        this.customerNumber = UTIL_PageState.current.sapCustomerId;
        this.accountId = UTIL_PageState.current.sfAccountId;

        init();
    }

    public void init()
    {
        Contact contact = new Contact();
        if (String.isNotBlank(this.contactId))
        {
            contact = UTIL_ObjectLookups.getContactById(this.contactId);
            this.accountId = contact.AccountId;
        }
        if (String.isNotBlank(this.accountId))
        {
            this.account = UTIL_SFAccount.getAccountById(this.accountid);
        }
        if (String.isBlank(this.customerNumber) && this.account != null)
        {
            this.customerNumber = (String) this.account.get(UTIL_SFAccount.CustomerFieldName);
        }
        this.canCreateContact = isAllowedCreation(contact);
        if (this.canCreateContact) getSAPCustomerDetail(this.customerNumber);

        if (this.canCreateContact)
        {
            mapContactToSAPContact(contact);
            this.newContact.Country = UTIL_ViewHelper.getValueForSelectOptionLabel(this.countryOptions, 'United States');
        }
    }

    @testVisible
    private Boolean isAllowedCreation(Contact contact)
    {
        Boolean isAllowed = true;
        if (String.isBlank(this.customerNumber))
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Cannot find Customer Number'));
            isAllowed = false;
        }
        if (null != contact)
        {
            if (String.isNotBlank((String) contact.get(UTIL_SFContact.ContactFieldName)))
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'SAP contact number already exist'));
                isAllowed = false;
            }
        }
        return isAllowed;
    }

    // getSAPCustomerDetail()
    //
    // Get the customer detail
    @testVisible
    private void getSAPCustomerDetail(String customerNumber)
    {
        SBO_EnosixCustomer_Detail sbo = new SBO_EnosixCustomer_Detail();
        SBO_EnosixCustomer_Detail.EnosixCustomer result = sbo.getDetail(customerNumber);

        if (result.isSuccess())
        {
            this.customerDetail = result;
            this.canCreateContact = true;
        }
        else 
        {
            UTIL_ViewHelper.displayResultMessages(result.getMessages(), ensxsdk.EnosixFramework.MessageType.ERROR);
            this.canCreateContact = false;
        }    
    }

    // mapContactToSAPContact()
    //
    // Map the Contact data from SF to SAP
    private void mapContactToSAPContact(Contact contact)
    {
        Address addr = contact.MailingAddress;
        this.newContact.FirstName = contact.FirstName;
        this.newContact.LastName = contact.LastName;
        this.newContact.Name = contact.Name;
        this.newContact.EMailAddress = contact.Email;
        this.newContact.TelephoneNumber = contact.Phone;
        if (null != addr)
        {
            this.newContact.Street = addr.Street;
            this.newContact.City = addr.City;
            this.newContact.PostalCode = addr.PostalCode;
            this.newContact.Region = addr.State;
            this.newContact.Country = addr.Country;
        }
    }

    // createContact()
    //
    // Method for creating contact to SAP
    public void createContact()
    {
        logCallouts('createContact');
        if (validateContactForm(this.newContact))
        {
            // Due to SAP user sales data restrictions need to clear company and sales data
            this.customerDetail.COMPANY_DATA.clear();
            this.customerDetail.SALES_DATA.clear();
            // Any Contacts in the CONTACTS collection
            // Must be cleared before creating a new one
            // Can only create ONE new contact at a time
            this.customerDetail.CONTACTS.clear();
            this.customerDetail.CONTACTS.add(this.newContact);

            SBO_EnosixCustomer_Detail sbo = new SBO_EnosixCustomer_Detail();
            SBO_EnosixCustomer_Detail.EnosixCustomer result = sbo.save(this.customerDetail);

            if (!result.isSuccess())
            {
                System.debug('Failed to save new contact: ' + result);
                UTIL_ViewHelper.displayResultMessages(result.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
            }
            else
            {
                this.canCreateContact = false;
                UTIL_ViewHelper.displayResultMessages(result.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);

                // Execute the getDetail() method to retrieve the newly created contact
                SBO_EnosixCustomer_Detail.EnosixCustomer newResultDetail = sbo.getDetail(this.customerDetail);
                List<SBO_EnosixCustomer_Detail.CONTACTS> contactsDetailList = new List<SBO_EnosixCustomer_Detail.CONTACTS>();
                newResultDetail.CONTACTS.copyTo(contactsDetailList);
                this.newContact = contactsDetailList.get(contactsDetailList.size() - 1);
                upsertSFContactInfo();
            }
        }
    }

    // validateContactForm()
    //
    // Validate contact before it does a save
    private Boolean validateContactForm(SBO_EnosixCustomer_Detail.CONTACTS currentContact)
    {
        Boolean validated = true;

        validated &= UTIL_ViewHelper.validateStringPropertyIsNotBlank(currentContact.LastName, 'Last Name');
        validated &= UTIL_ViewHelper.validateStringPropertyIsNotBlank(currentContact.City, 'City');
        validated &= UTIL_ViewHelper.validateStringPropertyIsNotBlank(currentContact.PostalCode, 'Postal Code');
        validated &= UTIL_ViewHelper.validateStringPropertyIsNotBlank(currentContact.Region, 'Region');
        validated &= UTIL_ViewHelper.validateStringPropertyIsNotBlank(currentContact.Country, 'Country');

        return validated;
    }

    // upsertSFContactInfo()
    //
    // Insert or update contact info in SF
    private void upsertSFContactInfo()
    {
        Contact contact = new Contact();
        if (String.isNotBlank(this.contactId))
        {
            contact.Id = Id.valueOf(this.contactId);
        }
        contact.put(UTIL_SFContact.ContactFieldName, this.newContact.ContactPersonNumber.replaceFirst('^0+(?!$)',''));
        contact.FirstName = this.newContact.FirstName;
        contact.LastName = String.isNotBlank(this.newContact.LastName) ? this.newContact.LastName : this.newContact.Name;
        contact.Email = this.newContact.EMailAddress;
        contact.Phone = this.newContact.TelephoneNumber;
        contact.MailingStreet = this.newContact.Street;
        contact.MailingCity = this.newContact.City;
        contact.MailingState = this.newContact.Region;
        contact.MailingPostalCode = this.newContact.PostalCode;
        contact.MailingCountry = this.newContact.Country;

        try
        {
            upsert contact;
            this.contactId = String.valueOf(contact.Id);
        }
        catch (Exception ex)
        {
            System.debug('Exception upserting contact: ' + ex);
        }
    }

    // Return to Contact detail page
    public PageReference returnToContact()
    {
        return new PageReference('/' + this.contactId);
    }

    // Return to Contact List VFP Page
    public PageReference returnToContactList()
    {
        return UTIL_PageFlow.redirectTo(UTIL_PageFlow.VFP_ContactList, UTIL_PageState.current);
    }

    /*
    *
    * RFC Options for countries and regions
    *
    */
    private transient List<RFC_SD_GET_COUNTRIES.ET_OUTPUT> t_countries;
    @testVisible
    List<RFC_SD_GET_COUNTRIES.ET_OUTPUT> countries
    {
        get
        {
            if (null == t_countries)
            {
                RFC_SD_GET_COUNTRIES rfc = new RFC_SD_GET_COUNTRIES();
                RFC_SD_GET_COUNTRIES.RESULT result = rfc.execute();
                if (!result.isSuccess())
                {
                    UTIL_ViewHelper.displayResultMessages(result.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
                }
                t_countries = result.ET_OUTPUT_List;
            }
            return t_countries;
        }
    }

    public List<SelectOption> countryOptions
    {
        get
        {
            List<SelectOption> options = new List<SelectOption>();
            List<RFC_SD_GET_COUNTRIES.ET_OUTPUT> countryList = this.countries;
            Integer countryTot = countryList.size();
            for (Integer countryCnt = 0 ; countryCnt < countryTot ; countryCnt++)
            {
                RFC_SD_GET_COUNTRIES.ET_OUTPUT country = countryList[countryCnt];
                options.add(new SelectOption(country.LAND1, country.LANDX));
            }
            UTIL_ViewHelper.sortOptionsByLabel(options);
            return options;
        }
    }

    public List<SelectOption> regionOptions
    {
        get
        {
            return getRegionOptionsForCountry(newContact.Country);
        }
    }

    private List<SelectOption> getRegionOptionsForCountry(String country)
    {
        List<SelectOption> result = new List<SelectOption>();
        RFC_SD_GET_COUNTRIES rfc = new RFC_SD_GET_COUNTRIES();
        RFC_SD_GET_COUNTRIES.RESULT countries = rfc.execute();
        if (!countries.isSuccess())
        {
            UTIL_ViewHelper.displayResultMessages(countries.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
        }
        else
        {
            List<RFC_SD_GET_COUNTRIES.ET_REGIONS> regionList = countries.ET_REGIONS_List;
            Integer regionTot = regionList.size();
            for (Integer regionCnt = 0 ; regionCnt < regionTot ; regionCnt++)
            {
                RFC_SD_GET_COUNTRIES.ET_REGIONS region = regionList[regionCnt];
                if (country == region.LAND1 && string.isNotBlank(region.REGIO))
                {
                    result.add(new SelectOption(region.REGIO, region.BEZEI));
                }
            }
        }
        UTIL_ViewHelper.sortOptionsByLabel(result);
        if (result != null && result.size() > 0)
        {
            result.add(0, new SelectOption('', 'Select One...'));
        }
        return result;
    }
}