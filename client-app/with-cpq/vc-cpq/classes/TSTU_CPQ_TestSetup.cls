@isTest public with sharing class TSTU_CPQ_TestSetup {

    public static Account createAccount(String customerNumber) {
        Account account = TSTU_SFTestObject.createTestAccount();
        account.Name = 'Mock Account';
        account.AccountNumber = customerNumber;
        account.BillingCity = 'Toledo';
        account.BillingStreet = '1234 Test St';
        account.BillingState = 'Ohio';
        // account.BillingStateCode = 'OH';
        account.BillingPostalCode = '43613';
        account.BillingCountry = 'United States';
        // account.BillingCountryCode = 'US';
        account.put(UTIL_SFAccount.CustomerFieldName, customerNumber);
        TSTU_SFTestObject.upsertWithRetry(account);

        return account;
    }

    public static SBQQ__Quote__c createQuote() {
        SBQQ.TriggerControl.disable();
        SBQQ__Quote__c quote = TSTU_SFCPQQuote.createTestQuote();
        quote.SBQQ__Key__c = 'Mock Quote';
        quote.FLD_Ship_To_Number__c = 'ShipTo';
        TSTU_SFTestObject.upsertWithRetry(quote);
        
        Product2 product = createProduct2();
        
        SBQQ__QuoteLine__c quoteLine = TSTU_SFCPQQuote.createTestQuoteLine();
        quoteLine.SBQQ__Quote__c = quote.Id;
        quoteLine.SBQQ__Product__c = product.Id;
        quoteLine.SBQQ__Quantity__c = 1;
        quoteLine.SBQQ__ListPrice__c = 20.00;
        quoteLine.SBQQ__Description__c = 'TEST DESC';
        TSTU_SFTestObject.upsertWithRetry(quoteLine);

        return quote;
    }

    public static SBQQ__QuoteLine__c createQuoteLine() {
        SBQQ.TriggerControl.disable();
        SBQQ__Quote__c quote = TSTU_SFCPQQuote.createTestQuote();
        quote.SBQQ__Key__c = 'Mock Quote';
        TSTU_SFTestObject.upsertWithRetry(quote);
        
        Product2 product = createProduct2();
        
        SBQQ__QuoteLine__c quoteLine = TSTU_SFCPQQuote.createTestQuoteLine();
        quoteLine.SBQQ__Quote__c = quote.Id;
        quoteLine.SBQQ__Product__c = product.Id;
        quoteLine.SBQQ__Quantity__c = 1;
        quoteLine.SBQQ__ListPrice__c = 20.00;
        quoteLine.SBQQ__Description__c = 'TEST DESC';
        TSTU_SFTestObject.upsertWithRetry(quoteLine);
        TSTU_SFTestObject.upsertWithRetry(quote);

        return quoteLine;
    }

    public static List<SObject> createAccountQuoteLinked() {
        Account account = createAccount('TEST');

        SBQQ__Quote__c quote = createQuote();
        quote.SBQQ__Account__c = account.Id;
        TSTU_SFTestObject.upsertWithRetry(quote);

        return new List<SObject> { account, quote };
    }

    public static Product2 createProduct2() {
        Product2 product = TSTU_SFTestObject.createTestProduct2();
        TSTU_SFTestObject.upsertWithRetry(product);
        return product;
    }

    public static Address createAddress() {
        Account a = createAccount('TEST');
        a = [SELECT BillingAddress FROM Account WHERE Id = :a.Id];
        return (Address)a.get('BillingAddress');
    }

}