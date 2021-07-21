public class UTIL_SFProduct
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_SFProduct.class);

    // The material number field on SF Product2 table
    private static String MaterialFieldNameSave = null;

    public static String MaterialFieldName
    {
        get
        {
            if (MaterialFieldNameSave == null) {
                MaterialFieldNameSave = '';
                try
                {
                    UTIL_MaterialMapping.MaterialMapping mapping = UTIL_MaterialMapping.getMapping();
                    MaterialFieldNameSave = mapping.materialNumber.productField;
                }
                catch(Exception ex) 
                { 
                    System.debug('Material Field Name not found'); 
                }
                MaterialFieldNameSave = String.isNotEmpty(MaterialFieldNameSave) ? MaterialFieldNameSave : (String)UTIL_AppSettings.getValue(UTIL_AppSettings.EnterpriseApp, 'Product.MaterialFieldName', 'ProductCode');
            }

            return MaterialFieldNameSave;
        }
    }

    public static Product2 getProductById(String value, List<String> fields)
    {
        return UTIL_SFProduct.getProductByField('Id', value, fields);
    }

    public static Product2 getProductById(String value)
    {
        return UTIL_SFProduct.getProductById(value, null);
    }

    public static Product2 getProductByMaterialNumber(String value, List<String> fields)
    {
        return UTIL_SFProduct.getProductByField(UTIL_SFProduct.MaterialFieldName, value, fields);
    }

    public static Product2 getProductByMaterialNumber(String value)
    {
        return UTIL_SFProduct.getProductByMaterialNumber(value, null);
    }

    public static Map<Id, Product2> getProductsByField(String selectField, List<String> values, List<String> fields){

        Map<Id, Product2> product2Id2Product = new Map<Id, Product2>();

        // These need to be lowercase so we can merge with `fields` var without duplicates
        // Duplicates cause SOQL exception
        Set<String> selectFields = new Set<String> {
            'name',
            'productcode',
            'description',
            'createddate',
            UTIL_SFProduct.MaterialFieldName.toLowerCase()
        };

        if (fields != null){
            Integer fieldTot = fields.size();
            for (Integer fieldCnt = 0 ; fieldCnt < fieldTot ; fieldCnt++)
            {
                String field = fields[fieldCnt];
                if (String.isNotBlank(field)){
                    selectFields.add(field.toLowerCase());
                }
            }
        }

        Map<String, Schema.SObjectField> fieldDefs = Schema.SObjectType.Product2.fields.getMap();
        Set<String> accessibleFields = getAccessibleFields(fieldDefs, selectFields);
        if (values.size() > 0){
            String query = 'SELECT ' +
                String.escapeSingleQuotes(String.join(new List<String>(accessibleFields), ', ')) +
                ' FROM Product2 WHERE ' +
                String.escapeSingleQuotes(selectField.toLowerCase()) +
                ' IN :values';
            product2Id2Product = new Map<Id, Product2>((List<Product2>) Database.query(query));
        }
        return product2Id2Product;
    }

    public static Product2 getProductByField(String selectField, String value, List<String> fields)
    {
        List<String> values = new List<String>();
        values.add(value);
        Map<Id, Product2> product2Id2Product = getProductsByField(selectField, values, fields);
        return product2Id2Product.values().size() > 0 ? product2Id2Product.values()[0] : null;
    }

    public static Boolean canUserSetMaterialNumber()
    {
        Map<String, Schema.SObjectField> fields = Schema.SObjectType.Product2.fields.getMap();
        return fields.get(UTIL_SFProduct.MaterialFieldName).getDescribe().isUpdateable();
    }

    public static String getMaterialNumberFromProduct(Product2 product)
    {
        String materialFieldName = UTIL_SFProduct.MaterialFieldName;
        return (String) product.get(materialFieldName);
    }

    public static void setProductMaterialNumber(Product2 product, String materialNumber)
    {
        if (canUserSetMaterialNumber())
        {
            String materialField = UTIL_SFProduct.MaterialFieldName;
            product.put(materialField, materialNumber);
        }
    }

    public static Boolean isProductLinkedToMaterial(Product2 product)
    {
        if (product == null) return false;
        return getMaterialNumberFromProduct(product) != null;
    }

    public static Boolean isProductLinkedToMaterialByProductId(String productId)
    {
        return isProductLinkedToMaterial(getProductById(productId));
    }

        /// Gets a value from a field on an opportunity
    public static Object getValueFromProductField(Product2 prod, string field, String warningMessageFormat)
    {
        String result = null;

        if (null == prod || String.isBlank(field))
        {
            return result;
        }

        Map<String, Schema.SObjectField> fields = Schema.SObjectType.Product2.fields.getMap();
        DescribeFieldResult fieldDef = fields.get(field) == null ? null : fields.get(field).getDescribe();
        if (fieldDef == null || !fieldDef.isAccessible())
        {
            String fieldLable = fieldDef == null ? 'Invalid Field' : fieldDef.getLabel();
            UTIL_PageMessages.addMessage(
                UTIL_PageMessages.WARNING,
                String.format(warningMessageFormat, new String[]{ fieldLable })
            );
            return result;
        }

        String productField = field.toLowerCase();
        Object value = prod.get(productField);

        if (null != value)
        {
            return String.valueOf(value);
        }

        return result;
    }

    private static Set<String> getAccessibleFields(Map<String, Schema.SObjectField> fieldDefs, Set<String> selectFields){
        Set<String> accessibleFields = new Set<String>();
        List<String> selectFieldsList = new List<String>(selectFields);
        Integer fieldTot = selectFieldsList.size();
        for (Integer fieldCnt = 0 ; fieldCnt < fieldTot ; fieldCnt++)
        {
            String field = selectFieldsList[fieldCnt];
            if (fieldDefs.get(field).getDescribe().isAccessible()){
                accessibleFields.add(field);
            }
        }
         return accessibleFields;
    }
}