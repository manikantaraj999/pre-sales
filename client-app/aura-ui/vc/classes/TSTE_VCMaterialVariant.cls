@isTest
public class TSTE_VCMaterialVariant
{
    @isTest static void testClassVariables ()
    {
        Test.startTest();
        ENSX_VCMaterialVariant ensxVcMaterialVariant = new ENSX_VCMaterialVariant();
        ensxVcMaterialVariant.VariantDescription = 'VariantDescription';
        ensxVcMaterialVariant.VariantId = 'VariantId';
        ensxVcMaterialVariant.CharacteristicValues = null;
        System.assert(ensxVcMaterialVariant.VariantDescription == 'VariantDescription');
        Test.stopTest();
    }
}
