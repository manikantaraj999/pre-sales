@isTest
public class TSTE_Characteristic
{
    @isTest static void testAttributes ()
    {
        Test.startTest();
        ENSX_Characteristic testObj = new ENSX_Characteristic();
        String CharacteristicID = testObj.CharacteristicID;
        String CharacteristicName = testObj.CharacteristicName;
        String CharacteristicValue = testObj.CharacteristicValue;
        Test.stopTest();
    }
}
