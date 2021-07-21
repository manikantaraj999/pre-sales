@isTest
public with sharing class TSTU_Aura
{
    @isTest
    public static void test_setSearchContextPagingOptions()
    {
        Test.startTest();
        Map<String, Object> pagingOptions = new Map<String, Object>();
        pagingOptions.put('pageSize', '10');
        pagingOptions.put('pageNumber', '1');
        UTIL_Aura.setSearchContextPagingOptions(new SearchContextTest(), pagingOptions);
    }

    public class SearchContextTest extends ensxsdk.EnosixFramework.SearchContext
    {
        public SearchContextTest()
        {
            super(new Map<string, type>());
        }
        public override Type getType() { return SearchContextTest.class; }
    }

    @isTest
    public static void test_createResponse()
    {
        Test.startTest();
        Object data = 1;
        Object pagingOptions = 2;
        UTIL_PageMessages.addMessage(null, null);
        UTIL_Aura.Response response1 = UTIL_Aura.createResponse(data, pagingOptions);
        String namespacePrefix = response1.namespacePrefix;
        UTIL_Aura.Response response2 = UTIL_Aura.createResponse(data);
        Test.stopTest();

        System.assertEquals(1, response1.data);
        System.assertEquals(2, response1.pagingOptions);
        System.assertEquals(UTIL_Namespace.namespacePrefix, response1.namespacePrefix);
        System.assertNotEquals(null, response1.messages);
        System.assertEquals(1, response1.messages.size());
        System.assertEquals(null, response1.messages[0].message);

        System.assertEquals(1, response2.data);
        System.assertEquals(null, response2.pagingOptions);
        System.assertNotEquals(null, response2.messages);
        System.assertEquals(0, response2.messages.size());
    }
}