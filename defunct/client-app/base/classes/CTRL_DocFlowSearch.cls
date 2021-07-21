public with sharing class CTRL_DocFlowSearch
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_DocFlowSearch.class);

    public List<SBO_EnosixSalesDocFlow_Search.SEARCHRESULT> searchResults {get; private set;}

    public String salesDocNum {get; set;}
    public String customerPoNum {get; set;}
    public String docCategory {get; set;}
    public String accountId {get; set;}
    public Boolean isClassic
    {
        get {return (UserInfo.getUiThemeDisplayed() == 'Theme3');}
    }

    // ctor
    public CTRL_DocFlowSearch()
    {
        salesDocNum = UTIL_PageState.current.sapDocNum;
        customerPoNum = ApexPages.currentPage().getParameters().get('poNumber');
        accountId = UTIL_PageState.current.sfAccountId;
        // if it's set, do immediate search
        if (salesDocNum != null)
        {
            search();
        }
    }

    // Doc Category dropdown
    private transient RFC_SD_GET_DOC_CATEG_VALUES.RESULT t_docCategoryValues;
    public RFC_SD_GET_DOC_CATEG_VALUES.RESULT docCategoryValues
    {
        get
        {
            if (null == t_docCategoryValues)
            {
                RFC_SD_GET_DOC_CATEG_VALUES rfc = new RFC_SD_GET_DOC_CATEG_VALUES();
                t_docCategoryValues = rfc.execute();

                if (!t_docCategoryValues.isSuccess())
                {
                    UTIL_ViewHelper.displayResultMessages(t_docCategoryValues.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
                }
            }
            return t_docCategoryValues;
        }
    }

    public List<SelectOption> docCategoryOptions
    {
        get
        {
            List<SelectOption> result = new List<SelectOption>();

            if (null != this.docCategoryValues)
            {
                List <RFC_SD_GET_DOC_CATEG_VALUES.ET_VALUES> catList = this.docCategoryValues.ET_VALUES_List;
                Integer catTot = catList.size();
                for (Integer catCnt = 0 ; catCnt < catTot ; catCnt++)
                {
                    RFC_SD_GET_DOC_CATEG_VALUES.ET_VALUES cat = catList[catCnt];
                    System.debug('cat: ' + cat.VBTYP + ': ' + cat.VBTYP_TEXT);
                    if (null != cat.VBTYP && null != cat.VBTYP_TEXT)
                    {
                        result.add(new SelectOption(cat.VBTYP, cat.VBTYP_TEXT));
                    }
                }
            }
            return result;
        }
    }

    public void search()
    {
        SBO_EnosixSalesDocFlow_Search sbo = new SBO_EnosixSalesDocFlow_Search();
        SBO_EnosixSalesDocFlow_Search.EnosixSalesDocFlow_SC searchContext = 
            new SBO_EnosixSalesDocFlow_Search.EnosixSalesDocFlow_SC();
        if (null != salesDocNum)
        {
            searchContext.SEARCHPARAMS.SalesDocument = salesDocNum;
        }
        if (null != customerPoNum)
        {
            searchContext.SEARCHPARAMS.CustomerPONumber = customerPoNum;
        }
        searchContext.SEARCHPARAMS.DocumentCategory = docCategory;
        searchContext.SEARCHPARAMS.X_PrecedingDocuments = true;
        searchContext.SEARCHPARAMS.X_SubsequentDocuments = true;

        // execute search and fill searchResults property
        searchContext = sbo.search(searchContext);
        SBO_EnosixSalesDocFlow_Search.EnosixSalesDocFlow_SR result = searchContext.result;
        if (!result.isSuccess())
        {
            searchResults = new SBO_EnosixSalesDocFlow_Search.SEARCHRESULT[0];
            UTIL_ViewHelper.displayResultMessages(result.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
            System.debug('Search failed');
        }
        else
        {
            searchResults = result.getResults();
        	System.debug('Search success - docs found: ' + searchResults.size());
        }
    }

    // make sure this matches all the selectedDocCategory values below
    public String validLinkCategories { get { return 'CHIMJTB'; } }

    public PageReference gotoDetailPage()
    {
        String selectedDocCategory = System.currentPageReference().getParameters().get('selectedDocCategory');
        String selectedDocNum = System.currentPageReference().getParameters().get('selectedDocNum');

        String page = null;

        // order
        if (selectedDocCategory == 'C')
        {
            UTIL_PageState.current.sapOrderNum = selectedDocNum;
            page = UTIL_PageFlow.VFP_OrderDetail;
        }
        // return order
        if (selectedDocCategory == 'H' || selectedDocCategory == 'I')
        {
            UTIL_PageState.current.sapRmaId = selectedDocNum;
            page = UTIL_PageFlow.VFP_ReturnOrderDetail;
        }
        // invoice
        else if (selectedDocCategory == 'M')
        {
            UTIL_PageState.current.sapInvoiceNum = selectedDocNum;
            page = UTIL_PageFlow.VFP_InvoiceDetail;
        }
        // delivery
        else if (selectedDocCategory == 'J' || selectedDocCategory == 'T')
        {
            UTIL_PageState.current.sapDeliveryNum = selectedDocNum;
            page = UTIL_PageFlow.VFP_DeliveryDetail;
        }
        // quotation
        else if (selectedDocCategory == 'B')
        {
            UTIL_PageState.current.sapQuoteId = selectedDocNum;
            page = UTIL_PageFlow.VFP_QuoteDetail;
        }

        return UTIL_PageFlow.redirectTo(page, UTIL_PageState.current);
    }
}