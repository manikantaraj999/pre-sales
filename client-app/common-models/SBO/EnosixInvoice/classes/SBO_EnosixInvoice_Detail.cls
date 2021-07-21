/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class SBO_EnosixInvoice_Detail extends ensxsdk.EnosixFramework.DetailSBO
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('SBO_EnosixInvoice_Detail_Meta', new Type[] {
            SBO_EnosixInvoice_Detail.EnosixInvoice.class
            , SBO_EnosixInvoice_Detail.ITEMS.class
            , SBO_EnosixInvoice_Detail.CONDITIONS.class
            } 
        );
    }

    public SBO_EnosixInvoice_Detail()
    {
        super('EnosixInvoice', SBO_EnosixInvoice_Detail.EnosixInvoice.class);
    }

    public override Type getType() { return SBO_EnosixInvoice_Detail.class; }

    public EnosixInvoice initialize(EnosixInvoice obj)
    {
        return (EnosixInvoice)this.executeInitialize(obj);
    }
    
    public EnosixInvoice getDetail(object key)
    {
        return (EnosixInvoice)this.executeGetDetail(key);
    }
    
    public EnosixInvoice save(EnosixInvoice obj)
    {
        return (EnosixInvoice) this.executeSave(obj);
    }

    public EnosixInvoice command(string command, EnosixInvoice obj)
    {
        return (EnosixInvoice) this.executeCommand(command, obj);
    }
    
    public with sharing class EnosixInvoice extends ensxsdk.EnosixFramework.DetailObject
    {
        public EnosixInvoice()
        {
            super('HEADER', new Map<string,type>
                {
                    'ITEMS' => SBO_EnosixInvoice_Detail.ITEMS_COLLECTION.class
                    ,'CONDITIONS' => SBO_EnosixInvoice_Detail.CONDITIONS_COLLECTION.class
                });	
        }

        public override Type getType() { return SBO_EnosixInvoice_Detail.EnosixInvoice.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixInvoice_Detail.registerReflectionInfo();
        }

                @AuraEnabled public String BillingDocument
        { 
            get { return this.getString ('VBELN'); } 
            set { this.Set (value, 'VBELN'); }
        }

        @AuraEnabled public String BillingType
        { 
            get { return this.getString ('FKART'); } 
            set { this.Set (value, 'FKART'); }
        }

        @AuraEnabled public String BillingTypeDescription
        { 
            get { return this.getString ('FKART_TEXT'); } 
            set { this.Set (value, 'FKART_TEXT'); }
        }

        @AuraEnabled public String CompanyCode
        { 
            get { return this.getString ('BUKRS'); } 
            set { this.Set (value, 'BUKRS'); }
        }

        @AuraEnabled public String CompanyCodeName
        { 
            get { return this.getString ('BUKRS_TEXT'); } 
            set { this.Set (value, 'BUKRS_TEXT'); }
        }

        @AuraEnabled public String SalesOrganization
        { 
            get { return this.getString ('VKORG'); } 
            set { this.Set (value, 'VKORG'); }
        }

        @AuraEnabled public String SalesOrgDescription
        { 
            get { return this.getString ('VKORG_TEXT'); } 
            set { this.Set (value, 'VKORG_TEXT'); }
        }

        @AuraEnabled public Date BillingDate
        { 
            get { return this.getDate ('FKDAT'); } 
            set { this.Set (value, 'FKDAT'); }
        }

        @AuraEnabled public Date ShipDate
        { 
            get { return this.getDate ('WADAT'); } 
            set { this.Set (value, 'WADAT'); }
        }

        @AuraEnabled public String SalesOrderNumber
        { 
            get { return this.getString ('AUBEL'); } 
            set { this.Set (value, 'AUBEL'); }
        }

        @AuraEnabled public String Payer
        { 
            get { return this.getString ('KUNRG'); } 
            set { this.Set (value, 'KUNRG'); }
        }

        @AuraEnabled public String PayerName
        { 
            get { return this.getString ('KUNRG_NAME'); } 
            set { this.Set (value, 'KUNRG_NAME'); }
        }

        @AuraEnabled public String SoldToParty
        { 
            get { return this.getString ('KUNAG'); } 
            set { this.Set (value, 'KUNAG'); }
        }

        @AuraEnabled public String SoldToName
        { 
            get { return this.getString ('KUNAG_NAME'); } 
            set { this.Set (value, 'KUNAG_NAME'); }
        }

        @AuraEnabled public String ShipToParty
        { 
            get { return this.getString ('KUNWE'); } 
            set { this.Set (value, 'KUNWE'); }
        }

        @AuraEnabled public String ShipToName
        { 
            get { return this.getString ('KUNWE_NAME'); } 
            set { this.Set (value, 'KUNWE_NAME'); }
        }

        @AuraEnabled public String TrackingNumber
        { 
            get { return this.getString ('BOLNR'); } 
            set { this.Set (value, 'BOLNR'); }
        }

        @AuraEnabled public String PaymentMethod
        { 
            get { return this.getString ('ZLSCH'); } 
            set { this.Set (value, 'ZLSCH'); }
        }

        @AuraEnabled public String PaymentMethodDescription
        { 
            get { return this.getString ('ZLSCH_TEXT'); } 
            set { this.Set (value, 'ZLSCH_TEXT'); }
        }

        @AuraEnabled public String TermsofPaymentKey
        { 
            get { return this.getString ('ZTERM'); } 
            set { this.Set (value, 'ZTERM'); }
        }

        @AuraEnabled public String TermsOfPaymentKeyDesc
        { 
            get { return this.getString ('ZTERM_TEXT'); } 
            set { this.Set (value, 'ZTERM_TEXT'); }
        }

        @AuraEnabled public Decimal NetOrderValue
        { 
            get { return this.getDecimal ('NETWR'); } 
            set { this.Set (value, 'NETWR'); }
        }

        @AuraEnabled public Decimal TaxAmount
        { 
            get { return this.getDecimal ('MWSBK'); } 
            set { this.Set (value, 'MWSBK'); }
        }

        @AuraEnabled public String SalesDocumentCurrency
        { 
            get { return this.getString ('WAERK'); } 
            set { this.Set (value, 'WAERK'); }
        }

        @AuraEnabled public String CreatedBy
        { 
            get { return this.getString ('ERNAM'); } 
            set { this.Set (value, 'ERNAM'); }
        }

        @AuraEnabled public Date CreateDate
        { 
            get { return this.getDate ('ERDAT'); } 
            set { this.Set (value, 'ERDAT'); }
        }

        @AuraEnabled public String BillingStatus
        { 
            get { return this.getString ('FKSTK'); } 
            set { this.Set (value, 'FKSTK'); }
        }

        @AuraEnabled public String BillingStatusDescription
        { 
            get { return this.getString ('FKSTK_TEXT'); } 
            set { this.Set (value, 'FKSTK_TEXT'); }
        }

        @AuraEnabled public ITEMS_COLLECTION ITEMS
        {
            get 
            { 
                return (ITEMS_COLLECTION)this.getCollection(SBO_EnosixInvoice_Detail.ITEMS_COLLECTION.class); 
            }
        }

                @AuraEnabled public CONDITIONS_COLLECTION CONDITIONS
        {
            get 
            { 
                return (CONDITIONS_COLLECTION)this.getCollection(SBO_EnosixInvoice_Detail.CONDITIONS_COLLECTION.class); 
            }
        }

            }

    //Write child objects
        public class ITEMS extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixInvoice_Detail.ITEMS.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixInvoice_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'POSNR' };
    
            return keyFields;
        }

                @AuraEnabled public String ItemNumber
        { 
            get { return this.getString ('POSNR'); } 
            set { this.Set (value, 'POSNR'); }
        }

        @AuraEnabled public String Material
        { 
            get { return this.getString ('MATNR'); } 
            set { this.Set (value, 'MATNR'); }
        }

        @AuraEnabled public String ItemDescription
        { 
            get { return this.getString ('ARKTX'); } 
            set { this.Set (value, 'ARKTX'); }
        }

        @AuraEnabled public Decimal BillingQuantity
        { 
            get { return this.getDecimal ('FKIMG'); } 
            set { this.Set (value, 'FKIMG'); }
        }

        @AuraEnabled public String SalesUnit
        { 
            get { return this.getString ('VRKME'); } 
            set { this.Set (value, 'VRKME'); }
        }

        @AuraEnabled public String Plant
        { 
            get { return this.getString ('WERKS'); } 
            set { this.Set (value, 'WERKS'); }
        }

        @AuraEnabled public String PlantDescription
        { 
            get { return this.getString ('WERKS_TEXT'); } 
            set { this.Set (value, 'WERKS_TEXT'); }
        }

        @AuraEnabled public Decimal NetItemValue
        { 
            get { return this.getDecimal ('NETWR'); } 
            set { this.Set (value, 'NETWR'); }
        }

        @AuraEnabled public Decimal TaxAmount
        { 
            get { return this.getDecimal ('MWSBP'); } 
            set { this.Set (value, 'MWSBP'); }
        }

        @AuraEnabled public String SalesDocumentCurrency
        { 
            get { return this.getString ('WAERK'); } 
            set { this.Set (value, 'WAERK'); }
        }

    }
    public class ITEMS_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public ITEMS_COLLECTION()
        {
            super('ITEMS', SBO_EnosixInvoice_Detail.ITEMS.class, null);
        }

        @AuraEnabled public List<SBO_EnosixInvoice_Detail.ITEMS> getAsList()
        {
            return (List<SBO_EnosixInvoice_Detail.ITEMS>)this.buildList(List<SBO_EnosixInvoice_Detail.ITEMS>.class);
        }
    }
    public class CONDITIONS extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixInvoice_Detail.CONDITIONS.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixInvoice_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'KPOSN','KSCHL' };
    
            return keyFields;
        }

                @AuraEnabled public String ConditionItemNumber
        { 
            get { return this.getString ('KPOSN'); } 
            set { this.Set (value, 'KPOSN'); }
        }

        @AuraEnabled public String ConditionType
        { 
            get { return this.getString ('KSCHL'); } 
            set { this.Set (value, 'KSCHL'); }
        }

        @AuraEnabled public Date ConditionPricingDate
        { 
            get { return this.getDate ('KDATU'); } 
            set { this.Set (value, 'KDATU'); }
        }

        @AuraEnabled public Decimal ConditionBaseValue
        { 
            get { return this.getDecimal ('KAWRT'); } 
            set { this.Set (value, 'KAWRT'); }
        }

        @AuraEnabled public Decimal Rate
        { 
            get { return this.getDecimal ('KBETR'); } 
            set { this.Set (value, 'KBETR'); }
        }

        @AuraEnabled public String CurrencyKey
        { 
            get { return this.getString ('WAERS'); } 
            set { this.Set (value, 'WAERS'); }
        }

        @AuraEnabled public Decimal ConditionExchangeRate
        { 
            get { return this.getDecimal ('KKURS'); } 
            set { this.Set (value, 'KKURS'); }
        }

    }
    public class CONDITIONS_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public CONDITIONS_COLLECTION()
        {
            super('CONDITIONS', SBO_EnosixInvoice_Detail.CONDITIONS.class, null);
        }

        @AuraEnabled public List<SBO_EnosixInvoice_Detail.CONDITIONS> getAsList()
        {
            return (List<SBO_EnosixInvoice_Detail.CONDITIONS>)this.buildList(List<SBO_EnosixInvoice_Detail.CONDITIONS>.class);
        }
    }
}