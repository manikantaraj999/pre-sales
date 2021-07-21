public class UTIL_PagingOptionsWrapper
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_PagingOptionsWrapper.class);

    @testVisible
    public ensxsdk.EnosixFramework.SearchPaging pagingOptions { get; private set; }

    public UTIL_PagingOptionsWrapper(ensxsdk.EnosixFramework.SearchPaging pagingOptions)
    {
        this.pagingOptions = pagingOptions;
    }
}