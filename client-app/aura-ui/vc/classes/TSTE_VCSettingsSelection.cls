@isTest
public class TSTE_VCSettingsSelection
{
    @isTest static void testClassVariables ()
    {
        Test.startTest();
        ENSX_VCSettingsSelection ensxVcSettingsSelection = new ENSX_VCSettingsSelection();
        ensxVcSettingsSelection.Value = 'Value';
        ensxVcSettingsSelection.ValueDescription = 'ValueDescription';
        System.assert(ensxVcSettingsSelection.Value == 'Value');
        Test.stopTest();
    }
}
