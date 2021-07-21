String host = URL.getOrgDomainUrl().getHost().toLowercase();
// This only works if MyDomain is enabled
if (host.endsWith('.my.salesforce.com')) {
    String my = host.split('\\.')[0];
    String ns = 'c'; // in the Template this all runs in the no-namespace 'c'
    String vf = 'https://' + my + '--' + ns + '.visualforce.com';
    System.debug(vf);

    String ecp = '/apex/VFP_enosiXExternalConfiguratorPlugin';
    List<SBQQ__CustomAction__c> updatedcustomActions = new List<SBQQ__CustomAction__c>();
    for (SBQQ__CustomAction__c customAction : [SELECT Id, SBQQ__URL__c FROM SBQQ__CustomAction__c]) {
        if (String.isNotBlank(customAction.SBQQ__URL__c) && customAction.SBQQ__URL__c.contains(ecp)) {
            System.debug(customAction.SBQQ__URL__c);
            customAction.SBQQ__URL__c = customAction.SBQQ__URL__c.replaceFirst('.*'+ecp, vf + ecp);
            updatedcustomActions.add(customAction);
            System.debug(customAction.SBQQ__URL__c);
        }
    }
    if (updatedcustomActions.size() > 0) {
        update updatedcustomActions;
    }
}
