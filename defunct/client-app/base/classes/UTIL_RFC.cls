public with sharing class UTIL_RFC
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_RFC.class);
    
    // getDocTypeMaster()
    //
    // Get the document type master from the RFC
    // Return the result    
    public static RFC_SD_GET_DOC_TYPE_VALUES.RESULT getDocTypeMaster()
    {
        RFC_SD_GET_DOC_TYPE_VALUES rfc = new RFC_SD_GET_DOC_TYPE_VALUES();
        RFC_SD_GET_DOC_TYPE_VALUES.RESULT result = rfc.execute();

        if (!result.isSuccess())
        {
            UTIL_ViewHelper.displayResultMessages(result.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO); 
        }

        return result;
    }

    // getOrderTypes()
    //
    // Gets all of the available order types for a specific business object.    
    public static RFC_SD_GET_ORDER_TYPES.RESULT getOrderTypes(string businessObjectType)
    {
        RFC_SD_GET_ORDER_TYPES rfc = new RFC_SD_GET_ORDER_TYPES();
        rfc.Params.IV_BOTYPE = businessObjectType;
        RFC_SD_GET_ORDER_TYPES.RESULT result = rfc.execute();

        if (!result.isSuccess())
        {
            UTIL_ViewHelper.displayResultMessages(result.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
        }

        return result;
    }

    // AddDocTypesOfCategory()
    //
    // Add the list of doc types to the selectoptions        
    public static void AddDocTypesOfCategory(List<SelectOption> result, List<RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT> docTypes,
        List<string> documentCategories, List<string> documentTypes)
    {
        Set<string> values = new Set<string>();
        Integer docTypeTot1 = docTypes.size();
        Integer docCatTot = documentCategories.size();
        Integer docTypeTot2 = documentTypes.size();
        for (Integer docTypeCnt1 = 0 ; docTypeCnt1 < docTypeTot1 ; docTypeCnt1++)
        {
            RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT docType = docTypes[docTypeCnt1];
            if (string.isNotBlank(docType.DocumentType) && string.isNotBlank(docType.BEZEI))
            {
                boolean include = true;
                if (null != documentCategories && documentCategories.size() > 0)
                {

                    include = false;
                    for (Integer docCatCnt = 0 ; docCatCnt < docCatTot ; docCatCnt++)
                    {
                        string docCat = documentCategories[docCatCnt];
                        if (null != docType.VBTYP && ('*' == docCat || docType.VBTYP.equalsIgnoreCase(docCat)))
                        {
                            include = true;
                            break;
                        }
                    }
                }

                if (!include) continue;

                if (null != documentTypes && documentTypes.size() > 0)
                {
                    include = false;
                    for (Integer docTypeCnt2 = 0 ; docTypeCnt2 < docTypeTot2 ; docTypeCnt2++) 
                    {
                        string docTp = documentTypes[docTypeCnt2];
                        if (null != docType.DocumentType && ('*' == docTp || docType.DocumentType.equalsIgnoreCase(docTp)))
                        {
                            include = true;
                            break;
                        }
                    }
                }

                if (!include) continue;

                string description = string.format('{0} - {1}', new string[]{
                    docType.DocumentType, docType.BEZEI});
                result.add(new SelectOption(docType.DocumentType, description));
                values.add(docType.DocumentType);
            }
        }
    }

    // getConditionGroups()
    //
    // Get the condition groups from the RFC
    // Return the list of Condition groups
    public static List<RFC_SD_GET_CONDITION_GROUP.ET_COND_GROUP> getConditionGroups()
    {
        List<RFC_SD_GET_CONDITION_GROUP.ET_COND_GROUP> conditionGroups = new List<RFC_SD_GET_CONDITION_GROUP.ET_COND_GROUP>();
        RFC_SD_GET_CONDITION_GROUP rfc = new RFC_SD_GET_CONDITION_GROUP();
        RFC_SD_GET_CONDITION_GROUP.RESULT result = rfc.execute();

        if (result.ET_COND_GROUP_List.size() > 0)
        {
            conditionGroups = result.ET_COND_GROUP_List;
        }

        return conditionGroups;
    }

    public class ItemCategoryOptionBuilder extends UTIL_SelectOption.OptionBuilder
    {
        public override string getItemValue(object item)
        {
            return ((RFC_SD_GET_ITEMCAT_VALUES.ET_VALUES)item).VALUE;
        }

        public override string getItemDescription(object item)
        {
            return ((RFC_SD_GET_ITEMCAT_VALUES.ET_VALUES)item).DESCRIPTION;
        }

        public override string getItemLabel(object item)
        {
            return string.format('{0} - {1}', new string[]{getItemValue(item), getItemDescription(item)});
        }
    }

    // filterItemCategories()
    //
    // Filters a list of item categories    
    public static List<RFC_SD_GET_ORDER_TYPES.ET_ITEM_CAT> filterItemCategories(
        RFC_SD_GET_ORDER_TYPES.RESULT orderTypeMaster, string orderType)
    {
        List<RFC_SD_GET_ORDER_TYPES.ET_ITEM_CAT> filteredList =
            new List<RFC_SD_GET_ORDER_TYPES.ET_ITEM_CAT>();

        if (null != orderTypeMaster)
        {
            List<RFC_SD_GET_ORDER_TYPES.ET_ITEM_CAT> icList = orderTypeMaster.ET_ITEM_CAT_List;
            Integer icTot = icList.size();
            for (Integer icCnt = 0 ; icCnt < icTot ; icCnt++)
            {
                RFC_SD_GET_ORDER_TYPES.ET_ITEM_CAT itemCategory = icList[icCnt];
                if (itemCategory.DocumentType == orderType)
                {
                    if (UTIL_Order.allowedItemCategoriesByOrderType.containsKey(orderType))
                    {
                        // If not * or SalesItemCategory, skip.
                        Set<String> cat = UTIL_Order.allowedItemCategoriesByOrderType.get(orderType);
                        if (cat.contains('*') || cat.contains(itemCategory.SalesItemCategory))
                        {
                            filteredList.add(itemCategory);
                        }
                    }
                    else
                    {
                        filteredList.add(itemCategory);
                    }
                }
            }
        }

        return filteredList;
    }
}