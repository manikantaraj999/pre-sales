@isTest
public with sharing class TSTU_RFC
{
    public class MOC_RFC_SD_GET_DOC_TYPE_VALUES implements ensxsdk.EnosixFramework.RFCMock
    {
        private boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            RFC_SD_GET_DOC_TYPE_VALUES.RESULT result = new RFC_SD_GET_DOC_TYPE_VALUES.RESULT();
            RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT sditm = new RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT();
            sditm.DocumentType = 'SD';
            sditm.BEZEI = 'Standard';
            result.ET_OUTPUT_List.add(sditm);
            for (integer mocCnt = 0; mocCnt < 20; mocCnt++)
            {
                RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT out = new RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT();
                out.DocumentType = 'tst' + mocCnt;
                out.BEZEI = 'tst' + mocCnt;
                result.ET_OUTPUT_List.add(out);
            }
            result.setSuccess(this.success);
            return result;
        }
    }

    public class MOC_RFC_SD_GET_ORDER_TYPES implements ensxsdk.EnosixFramework.RFCMock
    {
        private boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            RFC_SD_GET_ORDER_TYPES.RESULT result = new RFC_SD_GET_ORDER_TYPES.RESULT();
            result.setSuccess(this.success);
            return result;
        }
    }

    public class MOC_RFC_SD_GET_CONDITION_GROUP implements ensxsdk.EnosixFramework.RFCMock
    {
        private boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            RFC_SD_GET_CONDITION_GROUP.RESULT result = new RFC_SD_GET_CONDITION_GROUP.RESULT();
            RFC_SD_GET_CONDITION_GROUP.ET_COND_GROUP et_cond_group = new RFC_SD_GET_CONDITION_GROUP.ET_COND_GROUP();
			result.getCollection(RFC_SD_GET_CONDITION_GROUP.ET_COND_GROUP.class).add(et_cond_group);
            result.setSuccess(this.success);
            return result;
        }
    }

    public class MockGetOrderCategoryRfc implements ensxsdk.EnosixFramework.RFCMock
    {
        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            RFC_SD_GET_ORDER_TYPES.RESULT result = new RFC_SD_GET_ORDER_TYPES.RESULT();

            RFC_SD_GET_ORDER_TYPES.ET_ITEM_CAT garbage = new RFC_SD_GET_ORDER_TYPES.ET_ITEM_CAT();
            garbage.DocumentType = 'foo';
            garbage.SalesItemCategory = 'bar';

            RFC_SD_GET_ORDER_TYPES.ET_ITEM_CAT ord = new RFC_SD_GET_ORDER_TYPES.ET_ITEM_CAT();
            ord.DocumentType = 'foo';
            ord.SalesItemCategory = 'widget';

            RFC_SD_GET_ORDER_TYPES.ET_ITEM_CAT qt = new RFC_SD_GET_ORDER_TYPES.ET_ITEM_CAT();
            qt.DocumentType = 'quote';
            qt.SalesItemCategory = 'widget';

            result.getCollection(RFC_SD_GET_ORDER_TYPES.ET_ITEM_CAT.class).add(garbage);
            result.getCollection(RFC_SD_GET_ORDER_TYPES.ET_ITEM_CAT.class).add(ord);
            result.getCollection(RFC_SD_GET_ORDER_TYPES.ET_ITEM_CAT.class).add(qt);
            result.setSuccess(true);

            return result;
        }
    }

    @isTest
    public static void test_getDocTypeMaster()
    {
        MOC_RFC_SD_GET_DOC_TYPE_VALUES mocRfc = new MOC_RFC_SD_GET_DOC_TYPE_VALUES();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_DOC_TYPE_VALUES.class, mocRfc);
        Test.startTest();

        UTIL_RFC.getDocTypeMaster();
        mocRfc.setSuccess(false);
        UTIL_RFC.getDocTypeMaster();

        Test.stopTest();
    }

    @isTest
    public static void test_getOrderTypes()
    {
        MOC_RFC_SD_GET_ORDER_TYPES mocRfc = new MOC_RFC_SD_GET_ORDER_TYPES();
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_ORDER_TYPES.class, mocRfc);
        Test.startTest();

        UTIL_RFC.getOrderTypes('');
        mocRfc.setSuccess(false);
        UTIL_RFC.getOrderTypes('');

        Test.stopTest();
    }

    @isTest
    static void test_AddDocTypesOfCategory()
    {
        Test.startTest();
        List<string> documentCategories = new string[]{'*'};
        List<string> documentTypes = new string[]{'*'};
        List<SelectOption> result = new List<SelectOption>();
        List<RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT> docTypes = new List<RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT>();
        RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT doctype = new RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT();
        doctype.DocumentType ='DocumentType';
        doctype.BEZEI='BEZEI';
        doctype.VBTYP = 'VBTYP';
        docTypes.add(docType);
        UTIL_RFC.AddDocTypesOfCategory(result,docTypes,documentCategories,documentTypes);
        Test.stopTest();
    }

    @isTest
    public static void test_getConditionGroups()
    {
        ensxsdk.EnosixFramework.setMock(RFC_SD_GET_CONDITION_GROUP.class, new MOC_RFC_SD_GET_CONDITION_GROUP());
        Test.startTest();
        UTIL_RFC.getConditionGroups();
        Test.stopTest();
    }

    @isTest
    static void test_ItemCategoryOptionBuilder()
    {
        Test.startTest();
        UTIL_RFC.ItemCategoryOptionBuilder optionBuilder = new UTIL_RFC.ItemCategoryOptionBuilder();
        optionBuilder.getItemValue(new RFC_SD_GET_ITEMCAT_VALUES.ET_VALUES());
        optionBuilder.getItemDescription(new RFC_SD_GET_ITEMCAT_VALUES.ET_VALUES());
        optionBuilder.getItemLabel(new RFC_SD_GET_ITEMCAT_VALUES.ET_VALUES());
        Test.stopTest();
    }

    @isTest
    static void test_filterItemCategoriesNoMatches()
    {
        UTIL_AppSettings.resourceJson = '{"Order.AllowedItemCategoriesByOrderType":{"foo":["bar"]}}';
        RFC_SD_GET_ORDER_TYPES.RESULT mockResult =
            (RFC_SD_GET_ORDER_TYPES.RESULT)(new MockGetOrderCategoryRfc()).executeFunction();

        Test.startTest();
        List<RFC_SD_GET_ORDER_TYPES.ET_ITEM_CAT> result = UTIL_RFC.filterItemCategories(
            mockResult, 'nomatch');
        Test.stopTest();

        System.assert(result.size() == 0);
    }

    @isTest
    static void test_filterItemCategoriesMatchesOne()
    {
        UTIL_AppSettings.resourceJson =
            '{"Order.AllowedItemCategoriesByOrderType":{"foo":["widget"]}}';
        RFC_SD_GET_ORDER_TYPES.RESULT mockResult =
            (RFC_SD_GET_ORDER_TYPES.RESULT)(new MockGetOrderCategoryRfc()).executeFunction();

        Test.startTest();
        List<RFC_SD_GET_ORDER_TYPES.ET_ITEM_CAT> result = UTIL_RFC.filterItemCategories(
            mockResult, 'foo');
        List<RFC_SD_GET_ORDER_TYPES.ET_ITEM_CAT> result2 = UTIL_RFC.filterItemCategories(
            mockResult, 'quote');
        Test.stopTest();

        System.assert(result.size() == 1);
    }

    @isTest
    static void test_filterItemCategoriesMatchesMultiple()
    {
        UTIL_AppSettings.resourceJson =
            '{"Order.AllowedItemCategoriesByOrderType":{"foo":["widget","bar"]}}';
        RFC_SD_GET_ORDER_TYPES.RESULT mockResult =
            (RFC_SD_GET_ORDER_TYPES.RESULT)(new MockGetOrderCategoryRfc()).executeFunction();

        Test.startTest();
        List<RFC_SD_GET_ORDER_TYPES.ET_ITEM_CAT> result = UTIL_RFC.filterItemCategories(
            mockResult, 'foo');
        Test.stopTest();

        System.assert(result.size() == 2);
    }

    @isTest
    static void test_filterItemCategoriesWildcard()
    {
        UTIL_AppSettings.resourceJson = '{"Order.AllowedItemCategoriesByOrderType":{"foo":["*"]}}';
        RFC_SD_GET_ORDER_TYPES.RESULT mockResult =
            (RFC_SD_GET_ORDER_TYPES.RESULT)(new MockGetOrderCategoryRfc()).executeFunction();

        Test.startTest();
        List<RFC_SD_GET_ORDER_TYPES.ET_ITEM_CAT> result = UTIL_RFC.filterItemCategories(
            mockResult, 'foo');
        Test.stopTest();

        System.assert(result.size() == 2);
    }
}