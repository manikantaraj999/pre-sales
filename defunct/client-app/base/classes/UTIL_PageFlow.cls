// This class is a helper class to make it easier to navigate between pages
public class UTIL_PageFlow
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_PageFlow.class);

    public static final String VFP_CreditCardEntryTest = 'VFP_CreditCardEntryTest';
    public static final String VFP_CustomerCreateUpdate = 'VFP_CustomerCreateUpdate';
    public static final String VFP_CustomerDetail = 'VFP_CustomerDetail';
    public static final String VFP_CustomerPaymentEntry = 'VFP_CustomerPaymentEntry';
    public static final String VFP_CustomerLink = 'VFP_CustomerLink';
    public static final String VFP_DeliveryDetail = 'VFP_DeliveryDetail';
    public static final String VFP_DeliverySearch = 'VFP_DeliverySearch';
    public static final String VFP_DocFlowSearch = 'VFP_DocFlowSearch';
    public static final String VFP_MaterialDetail = 'VFP_MaterialDetail';
    public static final String VFP_InventorySearch = 'VFP_InventorySearch';
    public static final String VFP_InvoiceDetail = 'VFP_InvoiceDetail';
    public static final String VFP_InvoiceSearch = 'VFP_InvoiceSearch';
    public static final String VFP_MaterialSearchTest = 'VFP_MaterialSearchTest';
    public static final String VFP_OppProdQuotePricingRedirect = 'VFP_OppProdQuotePricingRedirect';
    public static final String VFP_OpportunityQuotePricing = 'VFP_OpportunityQuotePricing';
    public static final String VFP_OpportunityQuotePricingRedirect = 'VFP_OpportunityQuotePricingRedirect';
    public static final String VFP_OrderCreateUpdate = 'VFP_OrderCreateUpdate';
    public static final String VFP_OrderDetail = 'VFP_OrderDetail';
    public static final String VFP_OrderSearch = 'VFP_OrderSearch';
    public static final String VFP_QuoteCreateUpdate = 'VFP_QuoteCreateUpdate';
    public static final String VFP_QuoteDetail = 'VFP_QuoteDetail';
    public static final String VFP_QuoteSearch = 'VFP_QuoteSearch';
    public static final String VFP_ReturnOrderDetail = 'VFP_ReturnOrderDetail';
    public static final String VFP_ReturnOrderSearch = 'VFP_ReturnOrderSearch';
    public static final String VFP_StockSearch = 'VFP_StockSearch';
    public static final String VFP_PartnerSearch = 'VFP_PartnerSearch';
    public static final String VFP_ContactCreate = 'VFP_ContactCreate';
    public static final String VFP_ContactList = 'VFP_ContactList';
    public static final String CMP_Sales_Doc_Flow_Wrapper = 'CMP_Sales_Doc_Flow_Wrapper';

    public static string pageString { get; set; }

    /*
        Dictionary of previously hard-coded values; to override values,
        use AppSettings as follows:
        UTIL_AppSettings.resourceJson =
        '{"Routes.ClientRoutes":{"VFP_CustomerPayment_Entry":"/apex/YourAlternatePage"}}';
    */
    private static Map<String,String> defaultRoutes =
        new Map<String, String>{
            VFP_CreditCardEntryTest => '/apex/VFP_CreditCardEntryTest',
            VFP_CustomerCreateUpdate => '/apex/VFP_CustomerCreateUpdate',
            VFP_CustomerDetail => '/apex/VFP_CustomerDetail',
            VFP_CustomerPaymentEntry => '/apex/VFP_CustomerPaymentEntry',
            VFP_CustomerLink => '/apex/VFP_CustomerLink',
            VFP_DeliveryDetail => '/apex/VFP_DeliveryDetail',
            VFP_DeliverySearch => '/apex/VFP_DeliverySearch',
            VFP_DocFlowSearch => '/apex/VFP_DocFlowSearch',
            VFP_MaterialDetail => '/apex/VFP_MaterialDetail',
            VFP_InventorySearch => '/apex/VFP_InventorySearch',
            VFP_InvoiceDetail => '/apex/VFP_InvoiceDetail',
            VFP_InvoiceSearch => '/apex/VFP_InvoiceSearch',
            VFP_MaterialSearchTest => '/apex/VFP_MaterialSearchTest',
            VFP_OppProdQuotePricingRedirect => '/apex/VFP_OppProdQuotePricingRedirect',
            VFP_OpportunityQuotePricing => '/apex/VFP_OpportunityQuotePricing',
            VFP_OpportunityQuotePricingRedirect => '/apex/VFP_OpportunityQuotePricingRedirect',
            VFP_OrderCreateUpdate => '/apex/VFP_OrderCreateUpdate',
            VFP_OrderDetail => '/apex/VFP_OrderDetail',
            VFP_OrderSearch => '/apex/VFP_OrderSearch',
            VFP_QuoteCreateUpdate => '/apex/VFP_QuoteCreateUpdate',
            VFP_QuoteDetail => '/apex/VFP_QuoteDetail',
            VFP_QuoteDetail => '/apex/VFP_QuoteDetail',
            VFP_QuoteSearch => '/apex/VFP_QuoteSearch',
            VFP_ReturnOrderDetail => '/apex/VFP_ReturnOrderDetail',
            VFP_ReturnOrderSearch => '/apex/VFP_ReturnOrderSearch',
            VFP_StockSearch => '/apex/VFP_StockSearch',
            VFP_PartnerSearch => '/apex/VFP_PartnerSearch',
            VFP_ContactCreate => '/apex/VFP_ContactCreate',
            VFP_ContactList => '/apex/VFP_ContactList',
            CMP_Sales_Doc_Flow_Wrapper => '/lightning/cmp/c__CMP_Sales_Doc_Flow_Wrapper'
        };

    /*
        redirectTo() - Return a fully configured PageReference to simplify navigation
        to another page while maintaining page state properties
        If pageName is null, return null which simplifies caller logic in some cases
    */
    public static PageReference redirectTo(String pageName, UTIL_PageState state)
    {
        PageReference result = null;

        if (null == pageName)
        {
            return null;
        }

        String pageURL = getPageURL(pageName);

        if (UTIL_PageFlow.isPageAvailable(pageURL))
        {
            result = new PageReference(pageURL);
            result.setRedirect(true);
            if (null != state)
            {
                result.getParameters().putAll(state.getPageParams());
            }
        }
        if (result == null) ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Page "' + pageURL + '" is not available. Navigation failed'));

        patchLightningParameters(result);

        return result;
    }

    /* returnToSavedPageOrDefault() - Constructs PageRefrence to return to the previous
        state as stored in the page state. If one isn't stored, go to the defaultPageName
        using the params from state.
        If no return state is stored, and defaultPageName is null, returns null
    */
    public static PageReference returnToSavedPageOrDefault(
        UTIL_PageState state, String defaultPageName)
    {
        if (null != state && null != state.ensxReturnToUrl)
        {
            PageReference page = new PageReference(state.ensxReturnToUrl);
            page.setRedirect(true);
            return page;
        }
        if (null != defaultPageName)
        {
            return UTIL_PageFlow.redirectTo(defaultPageName, state);
        }
        return null;
    }

    // TODO: Some sort of config check to see if customer gets the given page
    private static Boolean isPageAvailable(String pageName)
    {
        return true;
    }

    // Gets page URL from map defaultRoutes, checks appSettings to see if override exists
    public static string getPageURL(string thisRoute)
    {
         // Default value first
        pageString = defaultRoutes.get(thisRoute);

        // Check Customer appSetting map to determine if there's an override
        Map<String,String> clientRoutes = (Map<String,String>)UTIL_AppSettings.getMap('Routes.ClientRoutes', String.class, String.class, new Map<String,String>());

        if (clientRoutes.size() > 0)
        {
            string clientRoute = clientRoutes.get(thisRoute);
            if (clientRoute != null)
            {
                pageString = clientRoute;
            }
        }

        // Because there are places in the code where created URLs are passed instead of lookup strings
        if (pageString == null)
        {
            pageString = thisRoute;
        }

        return pageString;
    }

    static void patchLightningParameters(PageReference pageRef) 
    {
        if (null != pageRef && pageRef.getUrl().startsWith('/lightning/n')) {
            Map<String, String> params = pageRef.getParameters();
            Set<String> keys = params.keySet();

            List<String> keysList = new List<String>(keys);
            Integer keyTot = keysList.size();
            for (Integer keyCnt = 0 ; keyCnt < keyTot ; keyCnt++) {
                String key = keysList[keyCnt];
                if (!key.startsWith('c__')) {
                    String value = params.remove(key);
                    params.put('c__' + key, value);
                }
            }
        }
    }
}