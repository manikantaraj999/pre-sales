List<SBQQ__ProductFeature__c> newProductFeatures = new List<SBQQ__ProductFeature__c>();
List<Product2> products = [
    SELECT Id
    FROM Product2
    WHERE FLD_Configurable_Material__c = true
    AND SBQQ__ExternallyConfigurable__c != true
];
for (Product2 p : products) {
    p.SBQQ__ExternallyConfigurable__c = true;
    if (p.SBQQ__ExternallyConfigurable__c)
    {
        p.SBQQ__ConfigurationType__c = 'Required';
        p.SBQQ__ConfigurationEvent__c = 'Always';
    }
    p.SBQQ__HidePriceInSearchResults__c = true;
    newProductFeatures.add(new SBQQ__ProductFeature__c(
        Name = 'SAP BoM',
        SBQQ__Number__c = 1,
        SBQQ__MinOptionCount__c = 0,
        SBQQ__OptionSelectionMethod__c = 'Dynamic',
        SBQQ__ConfiguredSKU__c = p.Id
    ));

}
upsert products;
insert newProductFeatures;
