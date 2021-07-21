public with sharing class UTIL_CPQ_Setup
{
    public String customScriptName = 'enosix_sap_simulation';
    public String staticresourceCodeName = 'enosix_sap_simulation';
    public String staticresourceTranspiledCodeName = 'enosix_sap_simulation_transpiled';

    // Quote.SAP_Configuration__c must be maintained via Apex, and thus MUST NOT be included in the CPQ JSON model
    // Need to add Quote fields which are needed to be selected and included in the model passed into the simulation.
    public Set<String> quoteFields = new Set<String>{'FLD_SAP_Simulation_Error__c'};
    // QuoteLine must be included in the CPQ JSON model and is maintained by the QCP / EC via JavaScript
    // Need to add QuoteLine fields which are needed to be selected and included in the model passed into the simulation.
    public Set<String> quoteLineFields = new Set<String>{'SAP_Configuration__c'};

    public ScriptConfig config = new ScriptConfig();

    public class ScriptConfig {
        public Boolean DEBUG = true;
        public Boolean resequenceQuoteLines = true;
        public String quoteSimulationEnabledField = 'FLD_enosixPricingSimulationEnabled__c';
        public String quoteLineSimulationEnabledField = 'FLD_enosixPricingSimulationEnabled__c';
        public String enosixSapSimulationApexService = '/ensxCPQQuoteCalculationService';
        public Set<String> requestQuoteRecordFields = new Set<String>{};
        public Map<String,String> requestQuoteFieldMapping = new Map<String,String>{};
        public Set<String> requestQuoteLineRecordFields = new Set<String>{};
        public Map<String,String> requestQuoteLineFieldMapping = new Map<String,String>{};
        public String instanceUrl;
    }

    public static void installCustomScript()
    {
        getFromAppSettings().installThisCustomScript();
    }

    private static UTIL_CPQ_Setup cpqSetup = null;

    public static UTIL_CPQ_Setup getFromAppSettings()
    {
        if (cpqSetup == null) {
            cpqSetup = (UTIL_CPQ_Setup)UTIL_AppSettings.getSObject(UTIL_AppSettings.CPQ, 'UTIL_CPQ_Setup', UTIL_CPQ_Setup.class, new UTIL_CPQ_Setup());
        }
        return cpqSetup;
    }

    public void installThisCustomScript()
    {
        if (null != config) {
            config.instanceUrl = URL.getOrgDomainUrl().toExternalForm().toLowercase();
        }
        upsertCustomScript(
            customScriptName,
            applyConfig(UTIL_StaticResource.getStringResourceContents(staticresourceCodeName),config),
            applyConfig(UTIL_StaticResource.getStringResourceContents(staticresourceTranspiledCodeName),config)
        );
    }

    private String applyConfig(String code, ScriptConfig config)
    {
        return code.replace('{/*ENOSIXCONFIG*/}', JSON.serialize(config));
    }

    private void upsertCustomScript(String customScriptName, String code, String transpiledCode)
    {
        SBQQ__CustomScript__c customScript = new SBQQ__CustomScript__c(
            Name = customScriptName
        );
        // obtain existing record if it exists
        List<SBQQ__CustomScript__c> existingCustomScript = [SELECT Id FROM SBQQ__CustomScript__c WHERE Name = :customScriptName];
        if (existingCustomScript.size() > 0) {
            customScript = existingCustomScript.get(0);
        }
        customScript.SBQQ__Code__c = code;
        customScript.SBQQ__TranspiledCode__c = transpiledCode + '\n//# sourceURL='+staticresourceTranspiledCodeName;

        customScript.SBQQ__QuoteFields__c = String.join(new List<String>(quoteFields), '\n');
        customScript.SBQQ__QuoteLineFields__c = String.join(new List<String>(quoteLineFields), '\n');

        upsert customScript;
    }
}