// sfdx force:apex:execute -f data/generatePriceBookEntries.apex
// in our scratch orgs there is exactly two Pricebooks, the Standard one and the Wearables one
Pricebook2 stdPricebook = [SELECT Id, IsActive FROM Pricebook2 WHERE IsStandard=true LIMIT 1];
if (true != stdPricebook.IsActive) {
    stdPricebook.IsActive = true;
    update stdPricebook;
}
Id stdId = stdPricebook.Id;
Id pbId = ([SELECT Id FROM Pricebook2 WHERE Name='Wearables Price Book' LIMIT 1]).Id;

// truncate PriceBookEntry, however scratch orgs have orphaned records with blank names
// and Salesforce chokes with an unknown exception if we attempt to delete them
// also the non-standard pricebook entries must be deleted prior to deleting the standard pricebook entries
DELETE [SELECT Id FROM PriceBookEntry where name != '' and Pricebook2Id = :pbId];
DELETE [SELECT Id FROM PriceBookEntry where name != '' and Pricebook2Id = :stdId];

// populate PriceBookEntry
List<PriceBookEntry> standardEntries = new List<PriceBookEntry>();
List<PriceBookEntry> wearablesEntries = new List<PriceBookEntry>();
for (Product2 p : [SELECT Id FROM Product2]) {
    standardEntries.add(new PriceBookEntry(Pricebook2Id=stdId,Product2Id=p.Id,UnitPrice=0,UseStandardPrice=false,IsActive=true));
    wearablesEntries.add(new PriceBookEntry(Pricebook2Id=pbId,Product2Id=p.Id,UnitPrice=0,UseStandardPrice=false,IsActive=true));
}
upsert standardEntries;
upsert wearablesEntries;