@isTest
public class TSTD_SalesDocAppSettings
{
    @isTest public static void test_appSettings()
    {
        DS_SalesDocAppSettings appSettings = buildAppSettings();
    }

    public static DS_SalesDocAppSettings buildAppSettings()
    {
        DS_SalesDocAppSettings appSettings = new DS_SalesDocAppSettings();
        appSettings.itemNumberIncrement = 10;
        appSettings.autoSimulate = new Map<String, Boolean>();
        appSettings.enableConfiguration = true;
        appSettings.enableBoMItemEdit = false;
        appSettings.SAPDocType = 'Quote';
        appSettings.DefaultDocType = 'OR';
        appSettings.updateLineItems = true;
        DS_SalesDocAppSettings.DocumentType documentType = new DS_SalesDocAppSettings.DocumentType();
        documentType.id = 'OR';
        documentType.label = 'TEST';
        appSettings.DocTypes = new List<DS_SalesDocAppSettings.DocumentType>{documentType};
        DS_SalesDocAppSettings.DocumentSetting documentSetting = new DS_SalesDocAppSettings.DocumentSetting();
        DS_SalesDocAppSettings.PartnerSetting partnerSetting = new DS_SalesDocAppSettings.PartnerSetting();
        partnerSetting.PartnerFunction = 'SH';
        partnerSetting.PartnerFunctionName = 'TEST';
        partnerSetting.ComponentType = 'Component';
        partnerSetting.SearchType = 'Partner';
        partnerSetting.autoSearch = true;
        partnerSetting.allowSearch = true;
        partnerSetting.allowAddressOverride = true;
        DS_SalesDocAppSettings.PartnerSetting partnerSetting2 = new DS_SalesDocAppSettings.PartnerSetting();
        partnerSetting2.PartnerFunction = 'SP';
        partnerSetting2.PartnerFunctionName = 'TEST';
        partnerSetting2.ComponentType = 'Component';
        partnerSetting2.SearchType = 'Partner';
        partnerSetting2.autoSearch = true;
        documentSetting.PartnerPickers = new List<DS_SalesDocAppSettings.PartnerSetting>{partnerSetting, partnerSetting2};
        documentSetting.Texts = new Map<String, String>{
            '0001' => 'TEST'
        };
        appSettings.Header = documentSetting;
        appSettings.Item = documentSetting;
        return appSettings;
    }
}