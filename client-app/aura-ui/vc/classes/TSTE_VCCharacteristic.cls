@isTest
public class TSTE_VCCharacteristic
{
    @isTest static void testGetControlForCharacteristic ()
    {
        Test.startTest();
        SBO_EnosixVC_Detail.CHARACTERISTICS characteristics = new SBO_EnosixVC_Detail.CHARACTERISTICS();
        String testString = ENSX_VCCharacteristic.getControlForCharacteristic(characteristics,0,false);
        System.assert(testString == 'ShortText');
        characteristics.DataType = 'Char';
        testString = ENSX_VCCharacteristic.getControlForCharacteristic(characteristics,1,true);
        System.assert(testString == 'RadioGroup');
        testString = ENSX_VCCharacteristic.getControlForCharacteristic(characteristics,1,false);
        System.assert(testString == 'InputPicklist');
        characteristics.DataType = 'Int';
        testString = ENSX_VCCharacteristic.getControlForCharacteristic(characteristics,0,false);
        System.assert(testString == 'Number');
        characteristics.DataType = 'NUM';
        testString = ENSX_VCCharacteristic.getControlForCharacteristic(characteristics,0,false);
        System.assert(testString == 'Number');
        characteristics.DataType = 'Date';
        testString = ENSX_VCCharacteristic.getControlForCharacteristic(characteristics,0,false);
        System.assert(testString == 'Date');
        Test.stopTest();
    }

    @isTest static void testGetValueDescriptionForValueId ()
    {
        Test.startTest();
        SBO_EnosixVC_Detail.EnosixVC enosixVC = new SBO_EnosixVC_Detail.EnosixVC();
        SBO_EnosixVC_Detail.ALLOWEDVALUES allowedValue = new SBO_EnosixVC_Detail.ALLOWEDVALUES();
        allowedValue.CharacteristicValue = 'CharacteristicValue';
        allowedValue.CharacteristicValueDescription = 'CharacteristicValueDescription';
        enosixVC.ALLOWEDVALUES.add(allowedValue);
        String testString = ENSX_VCCharacteristic.getValueDescriptionForValueId(enosixVC,'CharacteristicValue');
        System.assert(testString == 'CharacteristicValueDescription');
        Test.stopTest();
    }

    @isTest static void testGetCharacteristicDescriptionForValueId ()
    {
        Test.startTest();
        SBO_EnosixVC_Detail.EnosixVC enosixVC = new SBO_EnosixVC_Detail.EnosixVC();
        SBO_EnosixVC_Detail.CHARACTERISTICS characteristic = new SBO_EnosixVC_Detail.CHARACTERISTICS();
        characteristic.CharacteristicId = 'CharacteristicId';
        characteristic.CharacteristicDescription = 'CharacteristicDescription';
        enosixVC.CHARACTERISTICS.add(characteristic);
        String testString = ENSX_VCCharacteristic.getCharacteristicDescriptionForValueId(enosixVC,'CharacteristicId');
        System.assert(testString == 'CharacteristicDescription');
        Test.stopTest();
    }

    @isTest static void testGetCharacteristicForSBOModel ()
    {
        Test.startTest();
        SBO_EnosixVC_Detail.EnosixVC enosixVc = new SBO_EnosixVC_Detail.EnosixVC();
        SBO_EnosixVC_Detail.ALLOWEDVALUES allowedValue = new SBO_EnosixVC_Detail.ALLOWEDVALUES();
        allowedValue.CharacteristicID = 'CharacteristicID';
        allowedValue.CharacteristicValue = 'CharacteristicValue';
        allowedValue.CharacteristicValueDescription = 'CharacteristicValueDescription';
        SBO_EnosixVC_Detail.CHARACTERISTICS characteristic = new SBO_EnosixVC_Detail.CHARACTERISTICS();
        characteristic.CharacteristicID = 'CharacteristicID';
        characteristic.CharacteristicDescription = 'CharacteristicDescription';
        characteristic.CharacteristicName = 'CharacteristicName';
        enosixVc.ALLOWEDVALUES.add(allowedValue);
        SBO_EnosixVC_Detail.SELECTEDVALUES selectedValue = new SBO_EnosixVC_Detail.SELECTEDVALUES();
        selectedValue.CharacteristicID = 'CharacteristicID';
        selectedValue.CharacteristicValue = 'CharacteristicValue';
        enosixVc.SELECTEDVALUES.add(selectedValue);
        ENSX_VCCharacteristic testCharacteristic = ENSX_VCCharacteristic.getCharacteristicForSBOModel(enosixVc, characteristic);
        System.assert(testCharacteristic.CharacteristicName == 'CharacteristicName');
        Test.stopTest();
    }

    @isTest static void testGetSBOModelCharacteristicForCharacteristic ()
    {
        Test.startTest();
        ENSX_VCCharacteristic ensxVcCharacteristic = new ENSX_VCCharacteristic();
        ensxVcCharacteristic.CharacteristicName = 'CharacteristicName';
        SBO_EnosixVC_Detail.CHARACTERISTICS testCharacteristic = ENSX_VCCharacteristic.getSBOModelCharacteristicForCharacteristic(ensxVcCharacteristic);
        System.assert(testCharacteristic.CharacteristicName == 'CharacteristicName');
        Test.stopTest();
    }

    @isTest static void testGetSBOAllowedValuesFromPossibleValues ()
    {
        Test.startTest();
        ENSX_VCCharacteristic vcCharacteristic = new ENSX_VCCharacteristic();
        vcCharacteristic.PossibleValues = new List<ENSX_VCCharacteristicValues>();
        ENSX_VCCharacteristicValues characteristicValue = new ENSX_VCCharacteristicValues();
        characteristicValue.Value = 'Value';
        characteristicValue.CharacteristicId = 'CharacteristicId';
        vcCharacteristic.PossibleValues.add(characteristicValue);
        List<SBO_EnosixVC_Detail.ALLOWEDVALUES> testList = ENSX_VCCharacteristic.getSBOAllowedValuesFromPossibleValues(vcCharacteristic);
        System.assert(testList[0].CharacteristicValue == 'Value');
        Test.stopTest();
    }
}
