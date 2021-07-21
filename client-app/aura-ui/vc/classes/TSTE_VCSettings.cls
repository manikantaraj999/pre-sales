@isTest
public class TSTE_VCSettings
{
    @isTest static void testClassVariables ()
    {
        Test.startTest();
        ENSX_VCSettings ensxVcSettings = new ENSX_VCSettings();
        ensxVcSettings.RequiredOnlyDefaultToggle = false;
        ensxVcSettings.DisplayManualRunVCButton = false;
        ensxVcSettings.CanChangeSettings = false;
        ensxVcSettings.DisplayCost = true;
        ensxVcSettings.DisplayPrice = true;
        ensxVcSettings.FetchConfigurationFrequency = 'FetchConfigurationFrequency';
        ensxVcSettings.FetchConfigurationFrequencyPossibilities = null;
        ensxVcSettings.textAllowedValuesLabelRegex = 'textAllowedValuesLabelRegex';
        ensxVcSettings.numberAllowedValuesLabelRegex = 'numberAllowedValuesLabelRegex';
        ensxVcSettings.dateAllowedValuesLabelRegex = 'dateAllowedValuesLabelRegex';
        System.assert(ensxVcSettings.FetchConfigurationFrequency == 'FetchConfigurationFrequency');
        Test.stopTest();
    }
}
