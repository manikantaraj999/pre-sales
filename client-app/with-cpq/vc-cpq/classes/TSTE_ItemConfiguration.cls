@isTest
public class TSTE_ItemConfiguration
{
    @isTest static void testAttributes ()
    {
        Test.startTest();
        ENSX_ItemConfiguration testObj = new ENSX_ItemConfiguration();
        String materialNumber = testObj.materialNumber;
        String plant = testObj.plant;
        String SalesDocumentCurrency = testObj.SalesDocumentCurrency;
        Decimal OrderQuantity = testObj.OrderQuantity;
        List<ENSX_Characteristic> selectedCharacteristics = testObj.selectedCharacteristics;
        Test.stopTest();
    }
}
