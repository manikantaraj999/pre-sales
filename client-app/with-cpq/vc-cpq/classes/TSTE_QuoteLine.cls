@isTest
public class TSTE_QuoteLine
{
    @isTest static void testAttributes ()
    {
        Test.startTest();
        ENSX_QuoteLine testObj = new ENSX_QuoteLine();
        String Product = testObj.Product;
        String ItemNumber = testObj.ItemNumber;
        String PricebookEntry = testObj.PricebookEntry;
        String SAPMaterialNumber = testObj.SAPMaterialNumber;
        Integer ParentLineItem = testObj.ParentLineItem;
        Integer LineItem = testObj.LineItem;
        Decimal Quantity = testObj.Quantity;
        Decimal ListPrice = testObj.ListPrice;
        Decimal NetPrice = testObj.NetPrice;
        Decimal NetCost = testObj.NetCost;
        Decimal NetWeight = testObj.NetWeight;
        Decimal UnitCost = testObj.UnitCost;
        Decimal CostPrice = testObj.CostPrice;
        String Plant = testObj.Plant;
        String Description = testObj.Description;
        Decimal DiscountPercent = testObj.DiscountPercent;
        Date ATPDate = testObj.ATPDate;
        String itemJSON = testObj.itemJSON;
        Boolean IsProductFeature = testObj.IsProductFeature;
        ENSX_ItemConfiguration ItemConfiguration = testObj.ItemConfiguration;
        String RealProductId = testObj.RealProductId;
        String RealPricebookEntryId = testObj.RealPricebookEntryId;
        Object debug = testObj.debug;
        Map<String,Object> rec = testObj.record;
        String recordJsonObject = testObj.recordJSON;
        Test.stopTest();
    }
}
