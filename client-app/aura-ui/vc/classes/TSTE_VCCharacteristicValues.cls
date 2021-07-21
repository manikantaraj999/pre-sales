@isTest
public class TSTE_VCCharacteristicValues
{
    @isTest static void testGetSBOAllowedValuesForModel ()
    {
        Test.startTest();
        ENSX_VCCharacteristicValues characteristicValue = new ENSX_VCCharacteristicValues();
        characteristicValue.ValueDescription = 'ValueDescription';
        characteristicValue.Value = 'Value';
        characteristicValue.CharacteristicId = 'CharacteristicId';
        characteristicValue.CharacteristicDescription = 'CharacteristicDescription';
        SBO_EnosixVC_Detail.ALLOWEDVALUES allowedValue = ENSX_VCCharacteristicValues.getSBOAllowedValuesForModel(characteristicValue);
        System.assert(allowedValue.CharacteristicValueDescription == 'ValueDescription');
        Test.stopTest();
    }

    @isTest static void testGetSBOASelectedValuesForModel ()
    {
        Test.startTest();
        ENSX_VCCharacteristicValues characteristicValue = new ENSX_VCCharacteristicValues();
        characteristicValue.ValueDescription = 'ValueDescription';
        characteristicValue.Value = 'Value';
        characteristicValue.CharacteristicId = 'CharacteristicId';
        characteristicValue.CharacteristicDescription = 'CharacteristicDescription';
        SBO_EnosixVC_Detail.SELECTEDVALUES selectedValue = ENSX_VCCharacteristicValues.getSBOASelectedValuesForModel(characteristicValue);
        System.assert(selectedValue.CharacteristicValue == 'Value');
        Test.stopTest();
    }
}
