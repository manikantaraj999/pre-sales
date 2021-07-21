@isTest
public with sharing class TSTC_SAP_Sales_Doc_Actions
{
    public class MOC_EnosixSalesDocument_Detail implements ensxsdk.EnosixFramework.DetailSBOGetMock
    {
        public boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        private boolean throwException = false;

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

            SBO_EnosixSalesDocument_Detail.EnosixSalesDocument result = new SBO_EnosixSalesDocument_Detail.EnosixSalesDocument();
			result.setSuccess(this.success);
            return result;
        }
    }

    @isTest
    public static void test_getDetail()
    {
        MOC_EnosixSalesDocument_Detail moc = new MOC_EnosixSalesDocument_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixSalesDocument_Detail.class, moc);
        CTRL_SAP_Sales_Doc_Actions.getDetail('TEST');
        moc.setThrowException(true);
        CTRL_SAP_Sales_Doc_Actions.getDetail('TEST');
    }

    @isTest
    public static void test_getButtons()
    {
        String SFRecordId = testSetup();

        CTRL_SAP_Sales_Doc_Actions.getButtons(SFRecordId, '1111', 'Quote', true, true, true, true, true);
        CTRL_SAP_Sales_Doc_Actions.getButtons(SFRecordId, '1112', 'Order', false, true, true, true, true);
        Account acct = TSTU_SFTestObject.createTestAccount();
    	acct.Name='New Acct';
    	acct.BillingCity='Cincinnatti';
        acct.put(UTIL_SFAccount.CustomerFieldName,'CustNum');
    	TSTU_SFTestObject.upsertWithRetry(acct);
        CTRL_SAP_Sales_Doc_Actions.getButtons(acct.Id, 'bad number', 'bad type', false, true, true, true, true);
    }

    private static String testSetup()
    {
        Account acct = TSTU_SFTestObject.createTestAccount();
    	acct.Name='Acme';
    	acct.BillingCity='Cincinnatti';
        acct.put(UTIL_SFAccount.CustomerFieldName,'CustNum');
    	TSTU_SFTestObject.upsertWithRetry(acct);

        Id pricebookId = TSTU_SFTestObject.createTestPriceBook2();
        Opportunity opp = TSTU_SFTestObject.createTestOpportunity();
        opp.Name = 'Test Opp';
        opp.StageName ='Closed Won';
        opp.CloseDate = system.today();
        opp.AccountId = acct.Id;
        opp.put(UTIL_SFOpportunity.QuoteFieldName, '1111');
        opp.put(UTIL_SFOpportunity.OrderFieldName, '1112');
        opp.Pricebook2Id = pricebookId;
        TSTU_SFTestObject.upsertWithRetry(opp);
        return opp.Id;
    }
}