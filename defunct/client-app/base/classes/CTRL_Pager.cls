public class CTRL_Pager
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_Pager.class);

    public UTIL_PagingOptionsWrapper pagingOptionsWrapper { get; set; }
    public I_SearchController parentController { get; set; }
    public ApexPages.Action actionOnPaging { get; set; }

    public ensxsdk.EnosixFramework.SearchPaging pagingOptions
    {
        get
        {
            return this.pagingOptionsWrapper.pagingOptions;
        }
    }

    public List<SelectOption> pageSizeOptions
    {
        get
        {
            List<SelectOption> result = new List<SelectOption>();
            result.add(new SelectOption('5', '5'));
            result.add(new SelectOption('10', '10'));
            result.add(new SelectOption('25', '25'));
            result.add(new SelectOption('50', '50'));
            result.add(new SelectOption('100', '100'));
            result.add(new SelectOption('200', '200'));
            return result;
        }
    }

    public void actionGoToPage()
    {
        Integer pageNumber = Integer.valueOf(System.currentPageReference().getParameters().get('pageNumber'));
        pagingOptions.pageNumber = pageNumber;
        this.parentController.runSearch();
    }

    // update number of records to display per page then reset to first page
    public void actionUpdatePageSize()
    {
        Integer pageSize = Integer.valueOf(System.currentPageReference().getParameters().get('pageSize'));
        pagingOptions.pageSize = pageSize;
        pagingOptions.pageNumber = 1;
        this.parentController.runSearch();
    }

    public Boolean disablePrev
    {
        get
        {
           return pagingOptions.pageNumber <= 1;
        }
    }

    public Boolean disableNext
    {
        get
        {
            return pagingOptions.pageNumber == totalPages;
        }
    }

    public Integer totalPages
    {
        get
        {
            return pagingOptions.totalRecords > 0 ? Integer.valueOf(Math.ceil(Double.valueOf(pagingOptions.totalRecords) / Double.valueOf(pagingOptions.pageSize))) : 0;
        }
    }
}