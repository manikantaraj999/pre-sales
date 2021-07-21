@isTest
public class TSTD_VCMaterialConfiguration
{
    @isTest static void test_DS_VCMaterialConfiguration ()
    {
        Test.startTest();
        SBO_EnosixVC_Detail.EnosixVC enosiXVC = new SBO_EnosixVC_Detail.EnosixVC();
        enosiXVC.Material = '001234';
        enosiXVC.CHARACTERISTICS.add(new SBO_EnosixVC_Detail.CHARACTERISTICS());
        enosiXVC.ALLOWEDVALUES.add(new SBO_EnosixVC_Detail.ALLOWEDVALUES());
        SBO_EnosixVC_Detail.SELECTEDVALUES selectedValue = new SBO_EnosixVC_Detail.SELECTEDVALUES();
        selectedValue.CharacteristicName = 'CharacteristicName';
        enosiXVC.SELECTEDVALUES.add(selectedValue);
        Product2 prod = TSTU_SFTestObject.createTestProduct2();
        TSTU_SFTestObject.upsertWithRetry(prod);

        DS_VCMaterialConfiguration dsVCMaterialConfiguration = new DS_VCMaterialConfiguration(null);
        dsVCMaterialConfiguration = new DS_VCMaterialConfiguration(enosiXVC);
        enosiXVC.Material = '00123456';
        dsVCMaterialConfiguration = new DS_VCMaterialConfiguration(enosiXVC);
        List<DS_VCCharacteristicValues> selectedValues = new List<DS_VCCharacteristicValues>();
        selectedValues.add(new DS_VCCharacteristicValues());
        dsVCMaterialConfiguration.indexedSelectedValues.put('1', new List<SBO_EnosixVC_Detail.SELECTEDVALUES>{selectedValue});
        dsVCMaterialConfiguration.convertToSBO(null);
        dsVCMaterialConfiguration.convertToSBO(selectedValues);
        dsVCMaterialConfiguration.prepIndexedCollections(null);
        dsVCMaterialConfiguration.prepIndexedCollections(enosiXVC);
        dsVCMaterialConfiguration.indexedSelectedValues.clear();
        dsVCMaterialConfiguration.getAllowedValuesFromSBOModel(null);
        dsVCMaterialConfiguration.getAllowedValuesFromSBOModel(enosiXVC);
        dsVCMaterialConfiguration.getSelectedValuesFromSBOModel(null);
        dsVCMaterialConfiguration.getSelectedValuesFromSBOModel(enosiXVC);
        Test.stopTest();
    }
}
