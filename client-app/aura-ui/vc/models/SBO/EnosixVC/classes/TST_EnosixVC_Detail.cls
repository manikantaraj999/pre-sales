/// enosiX Inc. Generated Apex Model
/// Generated On: 8/6/2020 1:10:19 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
public with sharing class TST_EnosixVC_Detail
{
    public class MockSBO_EnosixVC_Detail implements
        ensxsdk.EnosixFramework.DetailSBOInitMock,
        ensxsdk.EnosixFramework.DetailSBOCommandMock,
        ensxsdk.EnosixFramework.DetailSBOGetMock,
        ensxsdk.EnosixFramework.DetailSBOSaveMock
    {
        public ensxsdk.EnosixFramework.DetailObject executeInitialize(ensxsdk.EnosixFramework.DetailObject initialState) { return null; }
        public ensxsdk.EnosixFramework.DetailObject executeCommand(String command, ensxsdk.EnosixFramework.DetailObject obj) { return null; }
        public ensxsdk.EnosixFramework.DetailObject executeGetDetail(object key) { return null; }
        public ensxsdk.EnosixFramework.DetailObject executeSave(ensxsdk.EnosixFramework.DetailObject obj) { return null; }
    }

    @isTest
    static void testSBO()
    {
        SBO_EnosixVC_Detail sbo = new SBO_EnosixVC_Detail();
        ensxsdk.EnosixFramework.setMock(SBO_EnosixVC_Detail.class, new MockSBO_EnosixVC_Detail());
        System.assertEquals(null, sbo.initialize(null));
        System.assertEquals(null, sbo.command(null, null));
        System.assertEquals(null, sbo.getDetail(null));
        System.assertEquals(null, sbo.save(null));
    }

    @isTest
    static void testEnosixVC()
    {
        SBO_EnosixVC_Detail.EnosixVC result = new SBO_EnosixVC_Detail.EnosixVC();
        System.assertEquals(SBO_EnosixVC_Detail.EnosixVC.class, result.getType(), 'getType() does not match object type.');

        result.registerReflectionForClass();

        result.Material = 'X';
        System.assertEquals('X', result.Material);

        result.ConfigInstance = 'X';
        System.assertEquals('X', result.ConfigInstance);

        result.ObjectKey = 'X';
        System.assertEquals('X', result.ObjectKey);

        result.ConfigDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), result.ConfigDate);

        result.CalculatePrice = true;
        System.assertEquals(true, result.CalculatePrice);

        result.ConfigurationIsValid = true;
        System.assertEquals(true, result.ConfigurationIsValid);

        result.SalesDocumentType = 'X';
        System.assertEquals('X', result.SalesDocumentType);

        result.SalesOrganization = 'X';
        System.assertEquals('X', result.SalesOrganization);

        result.DistributionChannel = 'X';
        System.assertEquals('X', result.DistributionChannel);

        result.Division = 'X';
        System.assertEquals('X', result.Division);

        result.SoldToParty = 'X';
        System.assertEquals('X', result.SoldToParty);

        result.ShipToParty = 'X';
        System.assertEquals('X', result.ShipToParty);

        result.Plant = 'X';
        System.assertEquals('X', result.Plant);

        result.NetItemPrice = 1.5;
        System.assertEquals(1.5, result.NetItemPrice);

        result.CostInDocCurrency = 1.5;
        System.assertEquals(1.5, result.CostInDocCurrency);

        result.SalesDocumentCurrency = 'X';
        System.assertEquals('X', result.SalesDocumentCurrency);

        result.OrderQuantity = 1.5;
        System.assertEquals(1.5, result.OrderQuantity);

        result.SalesUnit = 'X';
        System.assertEquals('X', result.SalesUnit);

        result.ConfigurationInternal = 'X';
        System.assertEquals('X', result.ConfigurationInternal);

        result.NextLevelMaterial = 'X';
        System.assertEquals('X', result.NextLevelMaterial);

        //Test child collections
        System.assertNotEquals(null,result.CHARACTERISTICS.getAsList());
        System.assertNotEquals(null,result.ALLOWEDVALUES.getAsList());
        System.assertNotEquals(null,result.SELECTEDVALUES.getAsList());
    }

    @isTest
    static void testCHARACTERISTICS()
    {
        SBO_EnosixVC_Detail.CHARACTERISTICS childObj = new SBO_EnosixVC_Detail.CHARACTERISTICS();
        System.assertEquals(SBO_EnosixVC_Detail.CHARACTERISTICS.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.CharacteristicID = 'X';
        System.assertEquals('X', childObj.CharacteristicID);

        childObj.CharacteristicName = 'X';
        System.assertEquals('X', childObj.CharacteristicName);

        childObj.CharacteristicDescription = 'X';
        System.assertEquals('X', childObj.CharacteristicDescription);

        childObj.Required = 'X';
        System.assertEquals('X', childObj.Required);

        childObj.Inherited = 'X';
        System.assertEquals('X', childObj.Inherited);

        childObj.ValuesAssigned = 'X';
        System.assertEquals('X', childObj.ValuesAssigned);

        childObj.DataType = 'X';
        System.assertEquals('X', childObj.DataType);

        childObj.SingleValue = true;
        System.assertEquals(true, childObj.SingleValue);

        childObj.ValueRequired = 'X';
        System.assertEquals('X', childObj.ValueRequired);

        childObj.IntervalsAllowed = 'X';
        System.assertEquals('X', childObj.IntervalsAllowed);

        childObj.AdditionalValues = 'X';
        System.assertEquals('X', childObj.AdditionalValues);

        childObj.NotToBeDisplayed = 'X';
        System.assertEquals('X', childObj.NotToBeDisplayed);

        childObj.NoEntryAllowed = 'X';
        System.assertEquals('X', childObj.NoEntryAllowed);

        childObj.NumericCharacter = 'X';
        System.assertEquals('X', childObj.NumericCharacter);

        childObj.NumericCharacter1 = 'X';
        System.assertEquals('X', childObj.NumericCharacter1);

        childObj.ValueWithPlusOrMinus = true;
        System.assertEquals(true, childObj.ValueWithPlusOrMinus);

        childObj.NumericCharacter2 = 'X';
        System.assertEquals('X', childObj.NumericCharacter2);

        childObj.ExponentDisplayFormat = 'X';
        System.assertEquals('X', childObj.ExponentDisplayFormat);

        childObj.ValueWithTemplate = 'X';
        System.assertEquals('X', childObj.ValueWithTemplate);

        childObj.DisplayTemplate = 'X';
        System.assertEquals('X', childObj.DisplayTemplate);

        childObj.CaseSensitive = true;
        System.assertEquals(true, childObj.CaseSensitive);

        childObj.UnitOfMeasure = 'X';
        System.assertEquals('X', childObj.UnitOfMeasure);

        childObj.ExternalUnitOfMeasure = 'X';
        System.assertEquals('X', childObj.ExternalUnitOfMeasure);

        childObj.DisplayAllowedValues = 'X';
        System.assertEquals('X', childObj.DisplayAllowedValues);

        childObj.UnformattedEntryControl = 'X';
        System.assertEquals('X', childObj.UnformattedEntryControl);

        childObj.GroupName = 'X';
        System.assertEquals('X', childObj.GroupName);

        childObj.GroupText = 'X';
        System.assertEquals('X', childObj.GroupText);

        childObj.SequenceNumber = 'X';
        System.assertEquals('X', childObj.SequenceNumber);

        childObj.FrequentlyUsed = true;
        System.assertEquals(true, childObj.FrequentlyUsed);

        childObj.Process = true;
        System.assertEquals(true, childObj.Process);

        List<string> keyFields = new List<string>{ 'ATINN' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testALLOWEDVALUES()
    {
        SBO_EnosixVC_Detail.ALLOWEDVALUES childObj = new SBO_EnosixVC_Detail.ALLOWEDVALUES();
        System.assertEquals(SBO_EnosixVC_Detail.ALLOWEDVALUES.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.CharacteristicID = 'X';
        System.assertEquals('X', childObj.CharacteristicID);

        childObj.CharacteristicName = 'X';
        System.assertEquals('X', childObj.CharacteristicName);

        childObj.CharacteristicValue = 'X';
        System.assertEquals('X', childObj.CharacteristicValue);

        childObj.CharacteristicValueDescription = 'X';
        System.assertEquals('X', childObj.CharacteristicValueDescription);

        childObj.FloatingPointValueFrom = 'X';
        System.assertEquals('X', childObj.FloatingPointValueFrom);

        childObj.FloatingPointValueFromUOM = 'X';
        System.assertEquals('X', childObj.FloatingPointValueFromUOM);

        childObj.FloatingPointValueTo = 'X';
        System.assertEquals('X', childObj.FloatingPointValueTo);

        childObj.FloatingPointValueToUOM = 'X';
        System.assertEquals('X', childObj.FloatingPointValueToUOM);

        childObj.ValueDependencyCode = 'X';
        System.assertEquals('X', childObj.ValueDependencyCode);

        childObj.ToleranceFrom = 'X';
        System.assertEquals('X', childObj.ToleranceFrom);

        childObj.ToleranceTo = 'X';
        System.assertEquals('X', childObj.ToleranceTo);

        childObj.ToeranceAsPercentage = 'X';
        System.assertEquals('X', childObj.ToeranceAsPercentage);

        childObj.IncrementWithInterval = 'X';
        System.assertEquals('X', childObj.IncrementWithInterval);

        List<string> keyFields = new List<string>{ 'ATINN','ATWRT' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
    @isTest
    static void testSELECTEDVALUES()
    {
        SBO_EnosixVC_Detail.SELECTEDVALUES childObj = new SBO_EnosixVC_Detail.SELECTEDVALUES();
        System.assertEquals(SBO_EnosixVC_Detail.SELECTEDVALUES.class,childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.CharacteristicID = 'X';
        System.assertEquals('X', childObj.CharacteristicID);

        childObj.CharacteristicName = 'X';
        System.assertEquals('X', childObj.CharacteristicName);

        childObj.CharacteristicValue = 'X';
        System.assertEquals('X', childObj.CharacteristicValue);

        childObj.CharacteristicValueDescription = 'X';
        System.assertEquals('X', childObj.CharacteristicValueDescription);

        childObj.FloatingPointValueFrom = 1.5;
        System.assertEquals(1.5, childObj.FloatingPointValueFrom);

        childObj.FloatingPointValueFromUOM = 'X';
        System.assertEquals('X', childObj.FloatingPointValueFromUOM);

        childObj.FloatingPointValueTo = 1.5;
        System.assertEquals(1.5, childObj.FloatingPointValueTo);

        childObj.FloatingPointValueToUOM = 'X';
        System.assertEquals('X', childObj.FloatingPointValueToUOM);

        childObj.UserModified = true;
        System.assertEquals(true, childObj.UserModified);

        List<string> keyFields = new List<string>{ 'ATINN','ATWRT' };
    
        List<string> keys = childObj.getKeyFields();
        for(Integer i = 0; i < keys.size(); i++)
        {
            system.assertEquals(keyFields[i],keys[i]);
        }
    }
}
