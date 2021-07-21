/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class SBO_EnosixInvoice_Search extends ensxsdk.EnosixFramework.SearchSBO 
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('SBO_EnosixInvoice_Search_Meta', new Type[] {
            SBO_EnosixInvoice_Search.EnosixInvoice_SC.class
            , SBO_EnosixInvoice_Search.EnosixInvoice_SR.class
            , SBO_EnosixInvoice_Search.SEARCHRESULT.class
            , SBO_EnosixInvoice_Search.SEARCHPARAMS.class
            , SBO_EnosixInvoice_Search.SEARCHRESULT.class
            } 
        );
    }

    public SBO_EnosixInvoice_Search() 
    {
        super('EnosixInvoice', SBO_EnosixInvoice_Search.EnosixInvoice_SC.class, SBO_EnosixInvoice_Search.EnosixInvoice_SR.class);
    }
    
    public override Type getType() { return SBO_EnosixInvoice_Search.class; }

    public EnosixInvoice_SC search(EnosixInvoice_SC sc) 
    {
        return (EnosixInvoice_SC)super.executeSearch(sc);
    }

    public EnosixInvoice_SC initialize(EnosixInvoice_SC sc) 
    {
        return (EnosixInvoice_SC)super.executeInitialize(sc);
    }

    public class EnosixInvoice_SC extends ensxsdk.EnosixFramework.SearchContext 
    { 		
        public EnosixInvoice_SC() 
        {		
            super(new Map<string,type>		
                {		
                    'SEARCHPARAMS' => SBO_EnosixInvoice_Search.SEARCHPARAMS.class		
                });		
        }

        public override Type getType() { return SBO_EnosixInvoice_Search.EnosixInvoice_SC.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixInvoice_Search.registerReflectionInfo();
        }

        public EnosixInvoice_SR result { get { return (EnosixInvoice_SR)baseResult; } }


        @AuraEnabled public SBO_EnosixInvoice_Search.SEARCHPARAMS SEARCHPARAMS 
        {
            get
            {
                return (SBO_EnosixInvoice_Search.SEARCHPARAMS)this.getStruct(SBO_EnosixInvoice_Search.SEARCHPARAMS.class);
            }
        }
        
        }

    public class EnosixInvoice_SR extends ensxsdk.EnosixFramework.SearchResult 
    {
        public EnosixInvoice_SR() 
        {
            super(new Map<string,type>{'SEARCHRESULT' => SBO_EnosixInvoice_Search.SEARCHRESULT.class } );
        }
        
        public ensxsdk.EnosixFramework.FrameworkCollection SearchResults
        {
            get { return super.getCollection(SBO_EnosixInvoice_Search.SEARCHRESULT.class); }
        }
        
        public List<SEARCHRESULT> getResults() 
        {
            List<SEARCHRESULT> results = new List<SEARCHRESULT>();
            SearchResults.copyTo(results);
            return results;
        }

        public override Type getType() { return SBO_EnosixInvoice_Search.EnosixInvoice_SR.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixInvoice_Search.registerReflectionInfo();
        }
    }

    public class SEARCHPARAMS extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixInvoice_Search.SEARCHPARAMS.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixInvoice_Search.registerReflectionInfo();
        }
        @AuraEnabled public String FromBillingDocumentNumber
        { 
            get { return this.getString ('VBELN_FR'); } 
            set { this.Set (value, 'VBELN_FR'); }
        }

        @AuraEnabled public String ToBillingDocumentNumber
        { 
            get { return this.getString ('VBELN_TO'); } 
            set { this.Set (value, 'VBELN_TO'); }
        }

        @AuraEnabled public String SalesOrganization
        { 
            get { return this.getString ('VKORG'); } 
            set { this.Set (value, 'VKORG'); }
        }

        @AuraEnabled public String Payer
        { 
            get { return this.getString ('KUNRG'); } 
            set { this.Set (value, 'KUNRG'); }
        }

        @AuraEnabled public String SoldToParty
        { 
            get { return this.getString ('KUNAG'); } 
            set { this.Set (value, 'KUNAG'); }
        }

        @AuraEnabled public String BillingType
        { 
            get { return this.getString ('FKART'); } 
            set { this.Set (value, 'FKART'); }
        }

        @AuraEnabled public Date FromBillingDate
        { 
            get { return this.getDate ('FKDAT_FR'); } 
            set { this.Set (value, 'FKDAT_FR'); }
        }

        @AuraEnabled public Date ToBillingDate
        { 
            get { return this.getDate ('FKDAT_TO'); } 
            set { this.Set (value, 'FKDAT_TO'); }
        }

        @AuraEnabled public Date FromCreateDate
        { 
            get { return this.getDate ('ERDAT_FR'); } 
            set { this.Set (value, 'ERDAT_FR'); }
        }

        @AuraEnabled public Date ToCreateDate
        { 
            get { return this.getDate ('ERDAT_TO'); } 
            set { this.Set (value, 'ERDAT_TO'); }
        }

        @AuraEnabled public String CreatedBy
        { 
            get { return this.getString ('ERNAM'); } 
            set { this.Set (value, 'ERNAM'); }
        }

    }

    public class SEARCHRESULT extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixInvoice_Search.SEARCHRESULT.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixInvoice_Search.registerReflectionInfo();
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

        @AuraEnabled public Decimal NetOrderValue
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

    }

    public class SEARCHRESULT_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public SEARCHRESULT_COLLECTION()
        {
            super('SEARCHRESULT', SBO_EnosixInvoice_Search.SEARCHRESULT.class, null);
        }

        public List<SBO_EnosixInvoice_Search.SEARCHRESULT> getAsList()
        {
            return (List<SBO_EnosixInvoice_Search.SEARCHRESULT>)this.buildList(List<SBO_EnosixInvoice_Search.SEARCHRESULT>.class);
        }
    }


}