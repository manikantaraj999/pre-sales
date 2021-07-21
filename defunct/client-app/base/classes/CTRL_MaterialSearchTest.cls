public with sharing class CTRL_MaterialSearchTest implements CB_MaterialSearchReceiver
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_MaterialSearchTest.class);

    public List<CTRL_MaterialSearch.MaterialSearchResult> searchResults { get; set; }
    public CB_MaterialSearchReceiver receiver { get; set; }
    public List<string> defaultMaterialTypes { get; set; }

    public CTRL_MaterialSearchTest()
    {
        defaultMaterialTypes = (List<String>)UTIL_AppSettings.getList(
                'Order.DefaultMaterialTypes', String.class, new List<String>{ 'FERT' });
        receiver = this;
    }

    public void onReceiveMaterialSearchResults(string id, List<CTRL_MaterialSearch.MaterialSearchResult> results)
    {
        this.searchResults = results;
        System.debug('receiving Material Search Results ');
    }
}