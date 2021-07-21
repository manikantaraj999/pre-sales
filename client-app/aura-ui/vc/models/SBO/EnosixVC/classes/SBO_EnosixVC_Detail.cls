/// enosiX Inc. Generated Apex Model
/// Generated On: 8/6/2020 1:10:19 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class SBO_EnosixVC_Detail extends ensxsdk.EnosixFramework.DetailSBO
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('SBO_EnosixVC_Detail_Meta', new Type[] {
            SBO_EnosixVC_Detail.EnosixVC.class
            , SBO_EnosixVC_Detail.CHARACTERISTICS.class
            , SBO_EnosixVC_Detail.ALLOWEDVALUES.class
            , SBO_EnosixVC_Detail.SELECTEDVALUES.class
            } 
        );
    }

    public SBO_EnosixVC_Detail()
    {
        super('EnosixVC', SBO_EnosixVC_Detail.EnosixVC.class);
    }

    public override Type getType() { return SBO_EnosixVC_Detail.class; }

    public EnosixVC initialize(EnosixVC obj)
    {
        return (EnosixVC)this.executeInitialize(obj);
    }
    
    public EnosixVC getDetail(object key)
    {
        return (EnosixVC)this.executeGetDetail(key);
    }
    
    public EnosixVC save(EnosixVC obj)
    {
        return (EnosixVC) this.executeSave(obj);
    }

    public EnosixVC command(string command, EnosixVC obj)
    {
        return (EnosixVC) this.executeCommand(command, obj);
    }
    
    public with sharing class EnosixVC extends ensxsdk.EnosixFramework.DetailObject
    {
        public EnosixVC()
        {
            super('HEADER', new Map<string,type>
                {
                    'CHARACTERISTICS' => SBO_EnosixVC_Detail.CHARACTERISTICS_COLLECTION.class
                    ,'ALLOWEDVALUES' => SBO_EnosixVC_Detail.ALLOWEDVALUES_COLLECTION.class
                    ,'SELECTEDVALUES' => SBO_EnosixVC_Detail.SELECTEDVALUES_COLLECTION.class
                });	
        }

        public override Type getType() { return SBO_EnosixVC_Detail.EnosixVC.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixVC_Detail.registerReflectionInfo();
        }

                @AuraEnabled public String Material
        { 
            get { return this.getString ('MATNR'); } 
            set { this.Set (value, 'MATNR'); }
        }

        @AuraEnabled public String ConfigInstance
        { 
            get { return this.getString ('INSTANCE'); } 
            set { this.Set (value, 'INSTANCE'); }
        }

        @AuraEnabled public String ObjectKey
        { 
            get { return this.getString ('OBJKEY'); } 
            set { this.Set (value, 'OBJKEY'); }
        }

        @AuraEnabled public Date ConfigDate
        { 
            get { return this.getDate ('CFG_DATE'); } 
            set { this.Set (value, 'CFG_DATE'); }
        }

        @AuraEnabled public Boolean CalculatePrice
        { 
            get { return this.getBoolean('CALCULATE_PRICE'); } 
            set { this.setBoolean(value, 'CALCULATE_PRICE'); }
        }

        @AuraEnabled public Boolean ConfigurationIsValid
        { 
            get { return this.getBoolean('CONFIG_VALID'); } 
            set { this.setBoolean(value, 'CONFIG_VALID'); }
        }

        @AuraEnabled public String SalesDocumentType
        { 
            get { return this.getString ('AUART'); } 
            set { this.Set (value, 'AUART'); }
        }

        @AuraEnabled public String SalesOrganization
        { 
            get { return this.getString ('VKORG'); } 
            set { this.Set (value, 'VKORG'); }
        }

        @AuraEnabled public String DistributionChannel
        { 
            get { return this.getString ('VTWEG'); } 
            set { this.Set (value, 'VTWEG'); }
        }

        @AuraEnabled public String Division
        { 
            get { return this.getString ('SPART'); } 
            set { this.Set (value, 'SPART'); }
        }

        @AuraEnabled public String SoldToParty
        { 
            get { return this.getString ('KUNAG'); } 
            set { this.Set (value, 'KUNAG'); }
        }

        @AuraEnabled public String ShipToParty
        { 
            get { return this.getString ('KUNWE'); } 
            set { this.Set (value, 'KUNWE'); }
        }

        @AuraEnabled public String Plant
        { 
            get { return this.getString ('WERKS'); } 
            set { this.Set (value, 'WERKS'); }
        }

        @AuraEnabled public Decimal NetItemPrice
        { 
            get { return this.getDecimal ('NETPR'); } 
            set { this.Set (value, 'NETPR'); }
        }

        @AuraEnabled public Decimal CostInDocCurrency
        { 
            get { return this.getDecimal ('WAVWR'); } 
            set { this.Set (value, 'WAVWR'); }
        }

        @AuraEnabled public String SalesDocumentCurrency
        { 
            get { return this.getString ('WAERK'); } 
            set { this.Set (value, 'WAERK'); }
        }

        @AuraEnabled public Decimal OrderQuantity
        { 
            get { return this.getDecimal ('KWMENG'); } 
            set { this.Set (value, 'KWMENG'); }
        }

        @AuraEnabled public String SalesUnit
        { 
            get { return this.getString ('VRKME'); } 
            set { this.Set (value, 'VRKME'); }
        }

        @AuraEnabled public String ConfigurationInternal
        { 
            get { return this.getString ('CFG_HANDLE'); } 
            set { this.Set (value, 'CFG_HANDLE'); }
        }

        @AuraEnabled public String NextLevelMaterial
        { 
            get { return this.getString ('MATNR_LEVEL2'); } 
            set { this.Set (value, 'MATNR_LEVEL2'); }
        }

        @AuraEnabled public CHARACTERISTICS_COLLECTION CHARACTERISTICS
        {
            get 
            { 
                return (CHARACTERISTICS_COLLECTION)this.getCollection(SBO_EnosixVC_Detail.CHARACTERISTICS_COLLECTION.class); 
            }
        }

                @AuraEnabled public ALLOWEDVALUES_COLLECTION ALLOWEDVALUES
        {
            get 
            { 
                return (ALLOWEDVALUES_COLLECTION)this.getCollection(SBO_EnosixVC_Detail.ALLOWEDVALUES_COLLECTION.class); 
            }
        }

                @AuraEnabled public SELECTEDVALUES_COLLECTION SELECTEDVALUES
        {
            get 
            { 
                return (SELECTEDVALUES_COLLECTION)this.getCollection(SBO_EnosixVC_Detail.SELECTEDVALUES_COLLECTION.class); 
            }
        }

            }

    //Write child objects
        public class CHARACTERISTICS extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixVC_Detail.CHARACTERISTICS.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixVC_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'ATINN' };
    
            return keyFields;
        }

                @AuraEnabled public String CharacteristicID
        { 
            get { return this.getString ('ATINN'); } 
            set { this.Set (value, 'ATINN'); }
        }

        @AuraEnabled public String CharacteristicName
        { 
            get { return this.getString ('ATNAM'); } 
            set { this.Set (value, 'ATNAM'); }
        }

        @AuraEnabled public String CharacteristicDescription
        { 
            get { return this.getString ('ATBEZ'); } 
            set { this.Set (value, 'ATBEZ'); }
        }

        @AuraEnabled public String Required
        { 
            get { return this.getString ('FLREQ'); } 
            set { this.Set (value, 'FLREQ'); }
        }

        @AuraEnabled public String Inherited
        { 
            get { return this.getString ('FLINH'); } 
            set { this.Set (value, 'FLINH'); }
        }

        @AuraEnabled public String ValuesAssigned
        { 
            get { return this.getString ('FLASS'); } 
            set { this.Set (value, 'FLASS'); }
        }

        @AuraEnabled public String DataType
        { 
            get { return this.getString ('ATFOR'); } 
            set { this.Set (value, 'ATFOR'); }
        }

        @AuraEnabled public Boolean SingleValue
        { 
            get { return this.getBoolean('ATEIN'); } 
            set { this.setBoolean(value, 'ATEIN'); }
        }

        @AuraEnabled public String ValueRequired
        { 
            get { return this.getString ('ATERF'); } 
            set { this.Set (value, 'ATERF'); }
        }

        @AuraEnabled public String IntervalsAllowed
        { 
            get { return this.getString ('ATINT'); } 
            set { this.Set (value, 'ATINT'); }
        }

        @AuraEnabled public String AdditionalValues
        { 
            get { return this.getString ('ATSON'); } 
            set { this.Set (value, 'ATSON'); }
        }

        @AuraEnabled public String NotToBeDisplayed
        { 
            get { return this.getString ('ATVIE'); } 
            set { this.Set (value, 'ATVIE'); }
        }

        @AuraEnabled public String NoEntryAllowed
        { 
            get { return this.getString ('ATINP'); } 
            set { this.Set (value, 'ATINP'); }
        }

        @AuraEnabled public String NumericCharacter
        { 
            get { return this.getString ('ANZST'); } 
            set { this.Set (value, 'ANZST'); }
        }

        @AuraEnabled public String NumericCharacter1
        { 
            get { return this.getString ('ANZDZ'); } 
            set { this.Set (value, 'ANZDZ'); }
        }

        @AuraEnabled public Boolean ValueWithPlusOrMinus
        { 
            get { return this.getBoolean('ATVOR'); } 
            set { this.setBoolean(value, 'ATVOR'); }
        }

        @AuraEnabled public String NumericCharacter2
        { 
            get { return this.getString ('ATDIM'); } 
            set { this.Set (value, 'ATDIM'); }
        }

        @AuraEnabled public String ExponentDisplayFormat
        { 
            get { return this.getString ('ATDEX'); } 
            set { this.Set (value, 'ATDEX'); }
        }

        @AuraEnabled public String ValueWithTemplate
        { 
            get { return this.getString ('ATSCH'); } 
            set { this.Set (value, 'ATSCH'); }
        }

        @AuraEnabled public String DisplayTemplate
        { 
            get { return this.getString ('ATVSC'); } 
            set { this.Set (value, 'ATVSC'); }
        }

        @AuraEnabled public Boolean CaseSensitive
        { 
            get { return this.getBoolean('ATKLE'); } 
            set { this.setBoolean(value, 'ATKLE'); }
        }

        @AuraEnabled public String UnitOfMeasure
        { 
            get { return this.getString ('MSEHI'); } 
            set { this.Set (value, 'MSEHI'); }
        }

        @AuraEnabled public String ExternalUnitOfMeasure
        { 
            get { return this.getString ('MSEH6'); } 
            set { this.Set (value, 'MSEH6'); }
        }

        @AuraEnabled public String DisplayAllowedValues
        { 
            get { return this.getString ('ATWRD'); } 
            set { this.Set (value, 'ATWRD'); }
        }

        @AuraEnabled public String UnformattedEntryControl
        { 
            get { return this.getString ('ATFOD'); } 
            set { this.Set (value, 'ATFOD'); }
        }

        @AuraEnabled public String GroupName
        { 
            get { return this.getString ('GRNAM'); } 
            set { this.Set (value, 'GRNAM'); }
        }

        @AuraEnabled public String GroupText
        { 
            get { return this.getString ('GRTXT'); } 
            set { this.Set (value, 'GRTXT'); }
        }

        @AuraEnabled public String SequenceNumber
        { 
            get { return this.getString ('SEQNO'); } 
            set { this.Set (value, 'SEQNO'); }
        }

        @AuraEnabled public Boolean FrequentlyUsed
        { 
            get { return this.getBoolean('FREQ_USED'); } 
            set { this.setBoolean(value, 'FREQ_USED'); }
        }

        @AuraEnabled public Boolean Process
        { 
            get { return this.getBoolean('PROCESS'); } 
            set { this.setBoolean(value, 'PROCESS'); }
        }

    }
    public class CHARACTERISTICS_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public CHARACTERISTICS_COLLECTION()
        {
            super('CHARACTERISTICS', SBO_EnosixVC_Detail.CHARACTERISTICS.class, null);
        }

        @AuraEnabled public List<SBO_EnosixVC_Detail.CHARACTERISTICS> getAsList()
        {
            return (List<SBO_EnosixVC_Detail.CHARACTERISTICS>)this.buildList(List<SBO_EnosixVC_Detail.CHARACTERISTICS>.class);
        }
    }
    public class ALLOWEDVALUES extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixVC_Detail.ALLOWEDVALUES.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixVC_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'ATINN','ATWRT' };
    
            return keyFields;
        }

                @AuraEnabled public String CharacteristicID
        { 
            get { return this.getString ('ATINN'); } 
            set { this.Set (value, 'ATINN'); }
        }

        @AuraEnabled public String CharacteristicName
        { 
            get { return this.getString ('ATNAM'); } 
            set { this.Set (value, 'ATNAM'); }
        }

        @AuraEnabled public String CharacteristicValue
        { 
            get { return this.getString ('ATWRT'); } 
            set { this.Set (value, 'ATWRT'); }
        }

        @AuraEnabled public String CharacteristicValueDescription
        { 
            get { return this.getString ('ATWTB'); } 
            set { this.Set (value, 'ATWTB'); }
        }

        @AuraEnabled public String FloatingPointValueFrom
        { 
            get { return this.getString ('ATFLV'); } 
            set { this.Set (value, 'ATFLV'); }
        }

        @AuraEnabled public String FloatingPointValueFromUOM
        { 
            get { return this.getString ('ATAWE'); } 
            set { this.Set (value, 'ATAWE'); }
        }

        @AuraEnabled public String FloatingPointValueTo
        { 
            get { return this.getString ('ATFLB'); } 
            set { this.Set (value, 'ATFLB'); }
        }

        @AuraEnabled public String FloatingPointValueToUOM
        { 
            get { return this.getString ('ATAW1'); } 
            set { this.Set (value, 'ATAW1'); }
        }

        @AuraEnabled public String ValueDependencyCode
        { 
            get { return this.getString ('ATCOD'); } 
            set { this.Set (value, 'ATCOD'); }
        }

        @AuraEnabled public String ToleranceFrom
        { 
            get { return this.getString ('ATTLV'); } 
            set { this.Set (value, 'ATTLV'); }
        }

        @AuraEnabled public String ToleranceTo
        { 
            get { return this.getString ('ATTLB'); } 
            set { this.Set (value, 'ATTLB'); }
        }

        @AuraEnabled public String ToeranceAsPercentage
        { 
            get { return this.getString ('ATPRZ'); } 
            set { this.Set (value, 'ATPRZ'); }
        }

        @AuraEnabled public String IncrementWithInterval
        { 
            get { return this.getString ('ATINC'); } 
            set { this.Set (value, 'ATINC'); }
        }

    }
    public class ALLOWEDVALUES_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public ALLOWEDVALUES_COLLECTION()
        {
            super('ALLOWEDVALUES', SBO_EnosixVC_Detail.ALLOWEDVALUES.class, null);
        }

        @AuraEnabled public List<SBO_EnosixVC_Detail.ALLOWEDVALUES> getAsList()
        {
            return (List<SBO_EnosixVC_Detail.ALLOWEDVALUES>)this.buildList(List<SBO_EnosixVC_Detail.ALLOWEDVALUES>.class);
        }
    }
    public class SELECTEDVALUES extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixVC_Detail.SELECTEDVALUES.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixVC_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'ATINN','ATWRT' };
    
            return keyFields;
        }

                @AuraEnabled public String CharacteristicID
        { 
            get { return this.getString ('ATINN'); } 
            set { this.Set (value, 'ATINN'); }
        }

        @AuraEnabled public String CharacteristicName
        { 
            get { return this.getString ('ATNAM'); } 
            set { this.Set (value, 'ATNAM'); }
        }

        @AuraEnabled public String CharacteristicValue
        { 
            get { return this.getString ('ATWRT'); } 
            set { this.Set (value, 'ATWRT'); }
        }

        @AuraEnabled public String CharacteristicValueDescription
        { 
            get { return this.getString ('ATWTB'); } 
            set { this.Set (value, 'ATWTB'); }
        }

        @AuraEnabled public Decimal FloatingPointValueFrom
        { 
            get { return this.getDecimal ('ATFLV'); } 
            set { this.Set (value, 'ATFLV'); }
        }

        @AuraEnabled public String FloatingPointValueFromUOM
        { 
            get { return this.getString ('ATAWE'); } 
            set { this.Set (value, 'ATAWE'); }
        }

        @AuraEnabled public Decimal FloatingPointValueTo
        { 
            get { return this.getDecimal ('ATFLB'); } 
            set { this.Set (value, 'ATFLB'); }
        }

        @AuraEnabled public String FloatingPointValueToUOM
        { 
            get { return this.getString ('ATAW1'); } 
            set { this.Set (value, 'ATAW1'); }
        }

        @AuraEnabled public Boolean UserModified
        { 
            get { return this.getBoolean('USERMOD'); } 
            set { this.setBoolean(value, 'USERMOD'); }
        }

    }
    public class SELECTEDVALUES_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public SELECTEDVALUES_COLLECTION()
        {
            super('SELECTEDVALUES', SBO_EnosixVC_Detail.SELECTEDVALUES.class, null);
        }

        @AuraEnabled public List<SBO_EnosixVC_Detail.SELECTEDVALUES> getAsList()
        {
            return (List<SBO_EnosixVC_Detail.SELECTEDVALUES>)this.buildList(List<SBO_EnosixVC_Detail.SELECTEDVALUES>.class);
        }
    }
}