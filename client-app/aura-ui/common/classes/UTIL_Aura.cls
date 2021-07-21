/// @description Unified response format for all AuraEnabled API requests
public with sharing class UTIL_Aura
{
    public static void setSearchContextPagingOptions(ensxsdk.EnosixFramework.SearchContext sc, Map<String, Object> pagingOptions)
    {
        if (pagingOptions != null)
        {
            sc.pagingOptions.pageSize = Integer.valueOf(pagingOptions.get('pageSize'));
            sc.pagingOptions.pageNumber = Integer.valueOf(pagingOptions.get('pageNumber'));
            // TODO: add support for sort order
        }
    }

    public static Response createResponse(Object data, Object pagingOptions)
    {
        Response r = new Response(data, pagingOptions, UTIL_PageMessages.messageList.clone());
        UTIL_PageMessages.messageList.clear();

        return r;
    }

    public static Response createResponse(Object data)
    {
        return createResponse(data, null);
    }

    public with sharing class Response
    {
        @AuraEnabled public Object data { get; private set; }
        @AuraEnabled public Object pagingOptions { get; private set; }
        @AuraEnabled public List<UTIL_PageMessages.Message> messages { get; private set; }
        @AuraEnabled public String namespacePrefix { get { return UTIL_Namespace.namespacePrefix; } }

        public Response(Object data, Object pagingOptions, List<UTIL_PageMessages.Message> messages)
        {
            this.data = data;
            this.pagingOptions = pagingOptions;
            this.messages = messages;
        }
    }
}