@isTest

public class TSTC_VC_Characteristics_Detail
{
    public class MOC_EnosixVC_Detail implements ensxsdk.EnosixFramework.DetailSBOGetMock,
            ensxsdk.EnosixFramework.DetailSBOSaveMock, ensxsdk.EnosixFramework.DetailSBOCommandMock,
            ensxsdk.EnosixFramework.DetailSBOInitMock
    {
        public boolean success = true;
        public boolean throwException = false;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        public void setThrowException(boolean throwException)
        {
            this.throwException = throwException;
        }

        public ensxsdk.EnosixFramework.DetailObject executeGetDetail(object key)
        {
            if (throwException)
            {
                throw new CalloutException();
            }
            SBO_EnosixVC_Detail.EnosixVC result = new SBO_EnosixVC_Detail.EnosixVC();
            result.setSuccess(success);
            return result;
        }

        public ensxsdk.EnosixFramework.DetailObject executeSave(ensxsdk.EnosixFramework.DetailObject obj)
        {
            if (throwException)
            {
                throw new CalloutException();
            }
            SBO_EnosixVC_Detail.EnosixVC result = (SBO_EnosixVC_Detail.EnosixVC) obj;
            result.setSuccess(success);
            return result;
        }

        public ensxsdk.EnosixFramework.DetailObject executeCommand(string command, ensxsdk.EnosixFramework.DetailObject obj)
        {
            if (throwException)
            {
                throw new CalloutException();
            }
            SBO_EnosixVC_Detail.EnosixVC result = (SBO_EnosixVC_Detail.EnosixVC) obj;
            SBO_EnosixVC_Detail.CHARACTERISTICS characteristic = new SBO_EnosixVC_Detail.CHARACTERISTICS();
            characteristic.CharacteristicName = 'CharacteristicName';
            characteristic.NotToBeDisplayed = '';
            result.CHARACTERISTICS.add(characteristic);
            result.setSuccess(success);
            return result;
        }

        public  ensxsdk.EnosixFramework.DetailObject executeInitialize(ensxsdk.EnosixFramework.DetailObject  initialState)
        {
            if (throwException)
            {
                throw new CalloutException();
            }
            SBO_EnosixVC_Detail.EnosixVC result = new SBO_EnosixVC_Detail.EnosixVC();
            result.setSuccess(success);
            return result;
        }

        public  ensxsdk.EnosixFramework.DetailObject executeInitializeFromData(ensxsdk.EnosixFramework.DetailObject  initialState)
        {
            if (throwException)
            {
                throw new CalloutException();
            }
            SBO_EnosixVC_Detail.EnosixVC result = new SBO_EnosixVC_Detail.EnosixVC();
            result.setSuccess(success);
            return result;
        }
    }


    public class MOC_EnosixQuote_Detail implements ensxsdk.EnosixFramework.DetailSBOGetMock,
            ensxsdk.EnosixFramework.DetailSBOSaveMock, ensxsdk.EnosixFramework.DetailSBOCommandMock,
            ensxsdk.EnosixFramework.DetailSBOInitMock
    {
        public boolean success = true;
        public boolean throwException = false;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        public void setThrowException(boolean throwException)
        {
            this.throwException = throwException;
        }

        public ensxsdk.EnosixFramework.DetailObject executeGetDetail(object key)
        {
            if (this.throwException)
            {
                throw new CalloutException();
            }
            SBO_EnosixQuote_Detail.EnosixQuote result = new SBO_EnosixQuote_Detail.EnosixQuote();
            SBO_EnosixQuote_Detail.ITEMS item = new SBO_EnosixQuote_Detail.ITEMS();
            item.ItemNumber = 'itemnumber';
            result.ITEMS.add(item);
            SBO_EnosixQuote_Detail.ITEMS_TEXT itemText1 = new SBO_EnosixQuote_Detail.ITEMS_TEXT();
            itemText1.ItemNumber = 'itemnumber';
            itemText1.TextID = 'Z991';
            itemText1.Text = 'Text';
            result.ITEMS_TEXT.add(itemText1);
            SBO_EnosixQuote_Detail.ITEMS_TEXT itemText2 = new SBO_EnosixQuote_Detail.ITEMS_TEXT();
            itemText2.ItemNumber = 'itemnumber';
            itemText2.TextID = 'Z992';
            itemText2.Text = 'Text';
            result.ITEMS_TEXT.add(itemText2);
            SBO_EnosixQuote_Detail.ITEMS_TEXT itemText3 = new SBO_EnosixQuote_Detail.ITEMS_TEXT();
            itemText3.ItemNumber = 'itemnumber';
            itemText3.TextID = 'Z993';
            itemText3.Text = 'Text';
            result.ITEMS_TEXT.add(itemText3);
            SBO_EnosixQuote_Detail.ITEMS_TEXT itemText4 = new SBO_EnosixQuote_Detail.ITEMS_TEXT();
            itemText4.ItemNumber = 'itemnumber';
            itemText4.TextID = 'Z994';
            itemText4.Text = 'Text';
            result.ITEMS_TEXT.add(itemText4);
            SBO_EnosixQuote_Detail.PARTNERS partner = new SBO_EnosixQuote_Detail.PARTNERS();
            partner.PartnerFunction = UTIL_Customer.SHIP_TO_PARTNER_CODE;
            partner.CustomerNumber = 'CustomerNumber';
            partner.PartnerName = 'PartnerName';
            partner.PartnerName2 = 'PartnerName2';
            partner.HouseNumber = 'HouseNumber';
            partner.Street = 'Street';
            partner.City = 'City';
            partner.Country = 'Country';
            result.PARTNERS.add(partner);
            SBO_EnosixQuote_Detail.ITEMS_SCHEDULE schedule = new SBO_EnosixQuote_Detail.ITEMS_SCHEDULE();
            schedule.ItemNumber = 'itemnumber';
            result.ITEMS_SCHEDULE.add(schedule);
            SBO_EnosixQuote_Detail.CONDITIONS condition = new SBO_EnosixQuote_Detail.CONDITIONS();
            condition.ConditionItemNumber = 'itemnumber';
            result.CONDITIONS.add(condition);
            SBO_EnosixQuote_Detail.ITEMS_CONFIG itemCondition = new SBO_EnosixQuote_Detail.ITEMS_CONFIG();
            itemCondition.ItemNumber = 'itemnumber';
            itemCondition.CharacteristicName = 'CharacteristicName';
            result.ITEMS_CONFIG.add(itemCondition);
            result.setSuccess(success);
            return result;
        }

        public ensxsdk.EnosixFramework.DetailObject executeSave(ensxsdk.EnosixFramework.DetailObject obj)
        {
            SBO_EnosixQuote_Detail.EnosixQuote result = new SBO_EnosixQuote_Detail.EnosixQuote();
            result.setSuccess(success);
            return result;
        }

        public ensxsdk.EnosixFramework.DetailObject executeCommand(string command, ensxsdk.EnosixFramework.DetailObject obj)
        {
            SBO_EnosixQuote_Detail.EnosixQuote result = new SBO_EnosixQuote_Detail.EnosixQuote();
            result.setSuccess(success);
            return result;
        }

        public  ensxsdk.EnosixFramework.DetailObject executeInitialize(ensxsdk.EnosixFramework.DetailObject  initialState)
        {
            SBO_EnosixQuote_Detail.EnosixQuote result = new SBO_EnosixQuote_Detail.EnosixQuote();
            result.setSuccess(success);
            return result;
        }
    }


    @isTest
    public static void test_logger()
    {
        ensxsdk.Logger logger = UTIL_VC_PricingAndConfiguration.logger;
    }


    @isTest
    public static void testGetVC_Characteristics_Detail()
    {

        MOC_EnosixQuote_Detail mockQuoteDetail = new MOC_EnosixQuote_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixQuote_Detail.class,mockQuoteDetail);

        MOC_EnosixVC_Detail mocEnosixVCDetail = new MOC_EnosixVC_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixVC_Detail.class, mocEnosixVCDetail);

        Test.startTest();

        CTRL_VC_Characteristics_Detail.getVC_Characteristics_Detail(null,null,'itemnumber');

        Test.stopTest();
    }




    @isTest static void testProccessAndLogVCConfiguration ()
    {
        MOC_EnosixVC_Detail mocEnosixVCDetail = new MOC_EnosixVC_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixVC_Detail.class, mocEnosixVCDetail);

        Test.startTest();
        DS_VCMaterialConfiguration config = CTRL_VC_Characteristics_Detail.proccessAndLogVCConfiguration(null,
            null);
        config = CTRL_VC_Characteristics_Detail.proccessAndLogVCConfiguration(new SBO_EnosixVC_Detail.EnosixVC(),
            new List<DS_VCCharacteristicValues>());
        Test.stopTest();
    }


    @isTest static void testConvertTo_CharacteristicsValues()
    {
        Test.startTest();

        List<DS_VCCharacteristicValues> testList = CTRL_VC_Characteristics_Detail.convertTo_CharacteristicValues(null);

        Test.stopTest();

    }

}