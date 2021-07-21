/*
*Test class for UTIL_SFProduct
*/
@isTest
private class TSTU_SFProduct
{
    @isTest
    static void test_getProductById()
    {
        Product2 prod = TSTU_SFTestObject.createTestProduct2();
        TSTU_SFTestObject.upsertWithRetry(prod);

        Test.startTest();
        Product2 fetched1 = UTIL_SFProduct.getProductById(prod.Id);
        Product2 fetched2 = UTIL_SFProduct.getProductById(prod.Id, new List<String> { 'Name', '', null });
        Product2 fetched3 = UTIL_SFProduct.getProductById(null);
        Test.stopTest();

        System.assertEquals(prod.Name, fetched1.Name);
        System.assertEquals(prod.Id, fetched1.Id);

        System.assertEquals(prod.Name, fetched2.Name);
        System.assertEquals(prod.Id, fetched2.Id);

        System.assertEquals(null, fetched3);
    }

    @isTest
    static void test_isProductLinkedToMaterial()
    {

        List<Product2> newProdList = new List<Product2>();

        Product2 prod = TSTU_SFTestObject.createTestProduct2();
        newProdList.add(prod);

        Product2 prod2 = TSTU_SFTestObject.createTestProduct2();
        prod2.put(UTIL_SFProduct.MaterialFieldName, null);
        newProdList.add(prod2);

        TSTU_SFTestObject.upsertWithRetry(newProdList);

        System.assertEquals(false, UTIL_SFProduct.isProductLinkedToMaterial(null));
        System.assertEquals(false, UTIL_SFProduct.isProductLinkedToMaterialByProductId(null));
        System.assert(UTIL_SFProduct.isProductLinkedToMaterial(prod));
        System.assertEquals(false, UTIL_SFProduct.isProductLinkedToMaterial(prod2));
    }

    @isTest
    static void test_getProductByMaterialNumber()
    {
        Product2 prod = TSTU_SFTestObject.createTestProduct2();
        TSTU_SFTestObject.upsertWithRetry(prod);

        Product2 fetched1 = UTIL_SFProduct.getProductByMaterialNumber((String) prod.get(UTIL_SFProduct.MaterialFieldName));

        System.assertEquals(prod.Id, fetched1.Id);
    }

    @isTest
    static void test_getValueFromProductField()
    {
        Product2 prod = TSTU_SFTestObject.createTestProduct2();
        UTIL_SFProduct.getValueFromProductField(null, '', 'Error');
        UTIL_SFProduct.getValueFromProductField(prod, 'BadFieldName', 'Error');
        UTIL_SFProduct.getValueFromProductField(prod, 'Name', 'Error');
        prod.Name = null;
        UTIL_SFProduct.getValueFromProductField(prod, 'Name', 'Error');
    }

    @isTest
    static void test_setProductMaterialNumber()
    {
        Product2 prod = TSTU_SFTestObject.createTestProduct2();
        TSTU_SFTestObject.upsertWithRetry(prod);

        UTIL_SFProduct.setProductMaterialNumber(prod, '1234');

        System.assertEquals('1234', prod.get(UTIL_SFProduct.MaterialFieldName));
    }

    @isTest
    static void test_getProductByFields() {
        Product2 product = TSTU_SFTestObject.createTestProduct2();
        TSTU_SFTestObject.upsertWithRetry(product);
        string sField = 'Name';
        List<String> vals = new List<String> {product.Name};
        List<STring> fields = new List<String> {
            'name',
            'productcode',
            'description'};
        Map<Id, Product2> prods = UTIL_SFProduct.getProductsByField(sField, vals, fields);
    }
}
