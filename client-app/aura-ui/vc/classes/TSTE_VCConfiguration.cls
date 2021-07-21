@isTest
public class TSTE_VCConfiguration
{
    @isTest static void testGetConfigurationFromSBOModel ()
    {
        Test.startTest();
        SBO_EnosixVC_Detail.EnosixVC enosixVc = new SBO_EnosixVC_Detail.EnosixVC();
        enosixVc.Material = 'Material';
        ENSX_VCConfiguration ensxVcConfiguration = ENSX_VCConfiguration.getConfigurationFromSBOModel(enosixVc);
        System.assert(ensxVcConfiguration.MaterialId == 'Material');
        Test.stopTest();
    }

    @isTest static void testGetSBOModelFromConfig ()
    {
        Test.startTest();
        ENSX_VCConfiguration ensxVcConfiguration = new ENSX_VCConfiguration();
        ENSX_VCCharacteristicValues ensxVcCharacteristicValue = new ENSX_VCCharacteristicValues();
        ensxVcConfiguration.SelectedValues = new List<ENSX_VCCharacteristicValues>();
        ensxVcConfiguration.SelectedValues.add(ensxVcCharacteristicValue);
        ENSX_VCCharacteristic ensxVcCharacteristic = new ENSX_VCCharacteristic();
        ensxVcCharacteristic.PossibleValues = new List<ENSX_VCCharacteristicValues>();
        ensxVcCharacteristic.PossibleValues.add(ensxVcCharacteristicValue);
        ensxVcConfiguration.Characteristics = new List<ENSX_VCCharacteristic>();
        ensxVcConfiguration.Characteristics.add(ensxVcCharacteristic);
        ensxVcConfiguration.PricingConfiguration = new ENSX_VCPricingConfiguration();
        ensxVcConfiguration.MaterialId = 'MaterialId';
        ensxVcConfiguration.ConfigurationIsValid = true;
        SBO_EnosixVC_Detail.EnosixVC enosixVc = ENSX_VCConfiguration.getSBOModelFromConfig(ensxVcConfiguration, true);
        System.assert(enosixVc.Material == 'MaterialId');
        Test.stopTest();
    }

    @isTest static void testGetCharacteristicsFromSBOModel ()
    {
        Test.startTest();
        SBO_EnosixVC_Detail.EnosixVC enosixVc = new SBO_EnosixVC_Detail.EnosixVC();
        SBO_EnosixVC_Detail.CHARACTERISTICS characteristic = new SBO_EnosixVC_Detail.CHARACTERISTICS();
        enosixVc.CHARACTERISTICS.add(characteristic);
        List<ENSX_VCCharacteristic> testList = ENSX_VCConfiguration.getCharacteristicsFromSBOModel(enosixVc);
        System.assert(testList.size() == 1);
        Test.stopTest();
    }

    @isTest static void testGetSelectedValuesFromSBOModel ()
    {
        Test.startTest();
        SBO_EnosixVC_Detail.EnosixVC enosixVc = new SBO_EnosixVC_Detail.EnosixVC();
        SBO_EnosixVC_Detail.SELECTEDVALUES selectedValue = new SBO_EnosixVC_Detail.SELECTEDVALUES();
        enosixVc.SELECTEDVALUES.add(selectedValue);
        List<ENSX_VCCharacteristicValues> testList = ENSX_VCConfiguration.getSelectedValuesFromSBOModel(enosixVc);
        System.assert(testList.size() == 1);
        Test.stopTest();
    }
}
