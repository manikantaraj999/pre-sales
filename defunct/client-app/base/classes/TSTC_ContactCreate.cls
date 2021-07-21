@isTest
public with sharing class TSTC_ContactCreate
{
    public static Contact contact;
    public class MOC_EnosixCustomer_Detail implements ensxsdk.EnosixFramework.DetailSBOGetMock,
        ensxsdk.EnosixFramework.DetailSBOSaveMock
    {
        public boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        public ensxsdk.EnosixFramework.DetailObject executeGetDetail(object key)
        {
            SBO_EnosixCustomer_Detail.EnosixCustomer result = new SBO_EnosixCustomer_Detail.EnosixCustomer();
            result.CustomerNumber = '0045683';
            result.Name = 'Mock Customer';

            List<SBO_EnosixCustomer_Detail.CONTACTS> listContacts = new List<SBO_EnosixCustomer_Detail.CONTACTS>();
            for (Integer contactCnt = 1; contactCnt <= 2; contactCnt++)
            {
                SBO_EnosixCustomer_Detail.CONTACTS sboContact = new SBO_EnosixCustomer_Detail.CONTACTS();
                sboContact.ContactPersonNumber = '000' + String.valueOf(contactCnt);
                sboContact.Name = 'Contact' + String.valueOf(contactCnt);
                listContacts.add(sboContact);
            }

            result.CONTACTS.addAll(listContacts);
            result.setSuccess(this.success);
            return result;
        }

        public ensxsdk.EnosixFramework.DetailObject executeSave(ensxsdk.EnosixFramework.DetailObject obj)
        {
            SBO_EnosixCustomer_Detail.EnosixCustomer result = new SBO_EnosixCustomer_Detail.EnosixCustomer();
            result.CustomerNumber = '0045683';
            result.Name = 'Mock Customer';
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

            RFC_SD_GET_COUNTRIES.ET_OUTPUT country = new RFC_SD_GET_COUNTRIES.ET_OUTPUT();
            country.LAND1 = 'US';
            country.LANDX = 'USA';
            result.getCollection(RFC_SD_GET_COUNTRIES.ET_OUTPUT.class).add(country);

            RFC_SD_GET_COUNTRIES.ET_REGIONS region = new RFC_SD_GET_COUNTRIES.ET_REGIONS();
            region.LAND1 = 'US';
            region.REGIO = 'NY';
            region.BEZEI = 'NY';
            result.getCollection(RFC_SD_GET_COUNTRIES.ET_REGIONS.class).add(region);

            result.setSuccess(this.success);
            return result;
        }
    }

    public static testMethod void test_ContactInit()
    {
        MOC_EnosixCustomer_Detail mocEnosixCustomerDetail = new MOC_EnosixCustomer_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustomer_Detail.class, mocEnosixCustomerDetail);
        MOC_RFC_SD_GET_COUNTRIES mocRfcSdGetCountries = new MOC_RFC_SD_GET_COUNTRIES();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_COUNTRIES.class, mocRfcSdGetCountries);

        UTIL_AppSettings.resourceJson = '{"CTRL_ContactCreate.Logging": true}';
        createExistingContact();
        Test.startTest();
        CTRL_ContactCreate controller = new CTRL_ContactCreate();
        List<SelectOption> countryOptions = controller.countryOptions;
        controller.newContact.Country = 'US';
        List<SelectOption> regionOptions = controller.regionOptions;
        controller.returnToContact();
        controller.returnToContactList();
        controller.customerNumber = '';
        controller.isAllowedCreation(null);
        Boolean hasAccount = controller.hasAccount;
        contact.put(UTIL_SFContact.ContactFieldName,'12345');
        TSTU_SFTestObject.upsertWithRetry(contact);
        controller = new CTRL_ContactCreate();
        mocRfcSdGetCountries.setSuccess(false);
        regionOptions = controller.regionOptions;
        List<RFC_SD_GET_COUNTRIES.ET_OUTPUT> countries = controller.countries;
        Boolean isClassic = controller.isClassic;
        mocEnosixCustomerDetail.setSuccess(false);
        controller.getSAPCustomerDetail('test');
        Test.stopTest();
    }

    public static testMethod void test_ContactCreateSuccess()
    {
        MOC_EnosixCustomer_Detail mocEnosixCustomerDetail = new MOC_EnosixCustomer_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustomer_Detail.class, mocEnosixCustomerDetail);
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_COUNTRIES.class, new MOC_RFC_SD_GET_COUNTRIES());

        createExistingContact();
        Test.startTest();
        CTRL_ContactCreate controller = new CTRL_ContactCreate();
        controller.newContact.Country = 'US';
        controller.createContact();
        Test.stopTest();
    }

    public static testMethod void test_ContactCreateFailure()
    {
        MOC_EnosixCustomer_Detail mocEnosixCustomerDetail = new MOC_EnosixCustomer_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixCustomer_Detail.class, mocEnosixCustomerDetail);
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_COUNTRIES.class, new MOC_RFC_SD_GET_COUNTRIES());

        createExistingContact();
        Test.startTest();
        CTRL_ContactCreate controller = new CTRL_ContactCreate();
        controller.newContact.Country = 'US';
        mocEnosixCustomerDetail.setSuccess(false);
        controller.createContact();
        Test.stopTest();
    }

    private static void createExistingContact()
    {
        Account acct = TSTU_SFTestObject.createTestAccount();
        acct.Name = 'Test Account';
        acct.put(UTIL_SFAccount.CustomerFieldName,'12345');
        TSTU_SFTestObject.upsertWithRetry(acct);

        contact = TSTU_SFTestObject.createTestContact(acct);
        contact.FirstName = 'Test';
        contact.LastName = 'Contact';
        contact.Email = 'test@email.com';
        contact.MailingStreet = '543 St';
        contact.MailingCity = 'New York';
        contact.MailingState = 'New York';
        contact.MailingPostalCode = '34534';
        contact.MailingCountry = 'United States';
        TSTU_SFTestObject.upsertWithRetry(contact);

        UTIL_PageState.current.sfContactId = String.valueOf(contact.Id);
    }
}