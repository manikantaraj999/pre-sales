@isTest public class TSTU_VC_Perf {

   @isTest static void test_RunConfiguration()
   {
      ENSX_VCPricingConfiguration ensxVcPricingConfguration = new ENSX_VCPricingConfiguration();
      Map<String, String> values = new Map<String, String>();
      values.put('CharacteristicName','CharacteristicName');
      values.put('CharacteristicDescription','CharacteristicDescription');
      Test.startTest();
      UTIL_VC_Perf.RunConfiguration(ensxVcPricingConfguration, values);
      UTIL_VC_Perf.CreateValueForCharAndValue(new DS_VCMaterialConfiguration(new SBO_EnosixVC_Detail.EnosixVC()), null, null);
      DS_VCMaterialConfiguration newConfig = new DS_VCMaterialConfiguration(new SBO_EnosixVC_Detail.EnosixVC());
      SBO_EnosixVC_Detail.SELECTEDVALUES selectedValue = new SBO_EnosixVC_Detail.SELECTEDVALUES();
      newConfig.indexedSelectedValues.put('key', new List<SBO_EnosixVC_Detail.SELECTEDVALUES>{new SBO_EnosixVC_Detail.SELECTEDVALUES()});
      UTIL_VC_Perf.AssertSelectedValueSet(newConfig, 'key', 'value');
      Test.stopTest();
   }
}
