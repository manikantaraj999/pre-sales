@isTest
public class TSTC_GeneratePDF 
{
    public class MOC_EnosixSalesDocOutput_Search implements ensxsdk.EnosixFramework.SearchSBOSearchMock
	{
        private boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        private boolean throwException = false;

        public void setThrowException(boolean throwException)
        {
            this.throwException = throwException;
        }

        private boolean returnRecord = true;

        public void setReturnRecord(boolean returnRecord)
        {
            this.returnRecord = returnRecord;
        }

		public ensxsdk.EnosixFramework.SearchContext executeSearch(ensxsdk.EnosixFramework.SearchContext searchContext) 
		{
            SBO_EnosixSalesDocOutput_Search.EnosixSalesDocOutput_SR search_result = new SBO_EnosixSalesDocOutput_Search.EnosixSalesDocOutput_SR();

            if (throwException)
            {
                throw new CalloutException();
            }

			SBO_EnosixSalesDocOutput_Search.SEARCHRESULT result = new SBO_EnosixSalesDocOutput_Search.SEARCHRESULT();			
			result.SalesDocument = '111';
            result.ConditionType = 'ZZZ';
            result.ConditionTypeDescription = 'ZZZ';
            result.Language = 'EN';
            result.PDFB64String = '00110101';

			search_result.setSuccess(this.success);
			searchContext.baseResult = search_result;
			return searchContext;
        }
	}

    @isTest
    public static void test_getDocumentsList()
    {
        MOC_EnosixSalesDocOutput_Search mockSboEnosixSalesDocOutputSearch = new MOC_EnosixSalesDocOutput_Search();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixSalesDocOutput_Search.class, mockSboEnosixSalesDocOutputSearch);

        Test.startTest();
        UTIL_Aura.Response response = CTRL_GeneratePDF.getDocumentsList('222', '');
        mockSboEnosixSalesDocOutputSearch.setThrowException(true);
        response = CTRL_GeneratePDF.getDocumentsList('222', 'ZZZ');
        Test.stopTest();
    }
}