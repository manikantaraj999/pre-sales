/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class SBO_EnosixQuote_Search extends ensxsdk.EnosixFramework.SearchSBO 
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('SBO_EnosixQuote_Search_Meta', new Type[] {
            SBO_EnosixQuote_Search.EnosixQuote_SC.class
            , SBO_EnosixQuote_Search.EnosixQuote_SR.class
            , SBO_EnosixQuote_Search.SEARCHRESULT.class
            , SBO_EnosixQuote_Search.SEARCHPARAMS.class
            , SBO_EnosixQuote_Search.SEARCHRESULT.class
            } 
        );
    }

    public SBO_EnosixQuote_Search() 
    {
        super('EnosixQuote', SBO_EnosixQuote_Search.EnosixQuote_SC.class, SBO_EnosixQuote_Search.EnosixQuote_SR.class);
    }
    
    public override Type getType() { return SBO_EnosixQuote_Search.class; }

    public EnosixQuote_SC search(EnosixQuote_SC sc) 
    {
        return (EnosixQuote_SC)super.executeSearch(sc);
    }

    public EnosixQuote_SC initialize(EnosixQuote_SC sc) 
    {
        return (EnosixQuote_SC)super.executeInitialize(sc);
    }

    public class EnosixQuote_SC extends ensxsdk.EnosixFramework.SearchContext 
    { 		
        public EnosixQuote_SC() 
        {		
            super(new Map<string,type>		
                {		
                    'SEARCHPARAMS' => SBO_EnosixQuote_Search.SEARCHPARAMS.class		
                });		
        }

        public override Type getType() { return SBO_EnosixQuote_Search.EnosixQuote_SC.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixQuote_Search.registerReflectionInfo();
        }

        public EnosixQuote_SR result { get { return (EnosixQuote_SR)baseResult; } }


        @AuraEnabled public SBO_EnosixQuote_Search.SEARCHPARAMS SEARCHPARAMS 
        {
            get
            {
                return (SBO_EnosixQuote_Search.SEARCHPARAMS)this.getStruct(SBO_EnosixQuote_Search.SEARCHPARAMS.class);
            }
        }
        
        }

    public class EnosixQuote_SR extends ensxsdk.EnosixFramework.SearchResult 
    {
        public EnosixQuote_SR() 
        {
            super(new Map<string,type>{'SEARCHRESULT' => SBO_EnosixQuote_Search.SEARCHRESULT.class } );
        }
        
        public ensxsdk.EnosixFramework.FrameworkCollection SearchResults
        {
            get { return super.getCollection(SBO_EnosixQuote_Search.SEARCHRESULT.class); }
        }
        
        public List<SEARCHRESULT> getResults() 
        {
            List<SEARCHRESULT> results = new List<SEARCHRESULT>();
            SearchResults.copyTo(results);
            return results;
        }

        public override Type getType() { return SBO_EnosixQuote_Search.EnosixQuote_SR.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixQuote_Search.registerReflectionInfo();
        }
    }

    public class SEARCHPARAMS extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixQuote_Search.SEARCHPARAMS.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixQuote_Search.registerReflectionInfo();
        }
        @AuraEnabled public String FromSalesDocumentNumber
        { 
            get { return this.getString ('VBELN_FR'); } 
            set { this.Set (value, 'VBELN_FR'); }
        }

        @AuraEnabled public String ToSalesDocumentNumber
        { 
            get { return this.getString ('VBELN_TO'); } 
            set { this.Set (value, 'VBELN_TO'); }
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

        @AuraEnabled public String CustomerPONumber
        { 
            get { return this.getString ('BSTNK'); } 
            set { this.Set (value, 'BSTNK'); }
        }

        @AuraEnabled public String Material
        { 
            get { return this.getString ('MATNR'); } 
            set { this.Set (value, 'MATNR'); }
        }

        @AuraEnabled public String SalesDocumentType
        { 
            get { return this.getString ('AUART'); } 
            set { this.Set (value, 'AUART'); }
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

        @AuraEnabled public Boolean OpenOnly
        { 
            get { return this.getBoolean('X_OPENONLY'); } 
            set { this.setBoolean(value, 'X_OPENONLY'); }
        }

        @AuraEnabled public Boolean CompletedOnly
        { 
            get { return this.getBoolean('X_COMPLETEDONLY'); } 
            set { this.setBoolean(value, 'X_COMPLETEDONLY'); }
        }

        @AuraEnabled public String Username
        { 
            get { return this.getString ('USERNAME'); } 
            set { this.Set (value, 'USERNAME'); }
        }

        @AuraEnabled public String SalesDocumentVersionNumber
        { 
            get { return this.getString ('VSNMR_V'); } 
            set { this.Set (value, 'VSNMR_V'); }
        }

        @AuraEnabled public String YourReference
        { 
            get { return this.getString ('IHREZ'); } 
            set { this.Set (value, 'IHREZ'); }
        }

        @AuraEnabled public String ShipToPurchaseOrderNumber
        { 
            get { return this.getString ('BSTKD_E'); } 
            set { this.Set (value, 'BSTKD_E'); }
        }

        @AuraEnabled public String ShipToName
        { 
            get { return this.getString ('SHIP_TO_NAME'); } 
            set { this.Set (value, 'SHIP_TO_NAME'); }
        }

        @AuraEnabled public String SoldToName
        { 
            get { return this.getString ('SOLD_TO_NAME'); } 
            set { this.Set (value, 'SOLD_TO_NAME'); }
        }

    }

    public class SEARCHRESULT extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixQuote_Search.SEARCHRESULT.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixQuote_Search.registerReflectionInfo();
        }
        @AuraEnabled public String SalesDocument
        { 
            get { return this.getString ('VBELN'); } 
            set { this.Set (value, 'VBELN'); }
        }

        @AuraEnabled public String CustomerPONumber
        { 
            get { return this.getString ('BSTNK'); } 
            set { this.Set (value, 'BSTNK'); }
        }

        @AuraEnabled public Date CreateDate
        { 
            get { return this.getDate ('ERDAT'); } 
            set { this.Set (value, 'ERDAT'); }
        }

        @AuraEnabled public String SalesDocumentType
        { 
            get { return this.getString ('AUART'); } 
            set { this.Set (value, 'AUART'); }
        }

        @AuraEnabled public String SalesDocumentTypeDescription
        { 
            get { return this.getString ('AUART_TEXT'); } 
            set { this.Set (value, 'AUART_TEXT'); }
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

        @AuraEnabled public String SoldToCity
        { 
            get { return this.getString ('KUNAG_CITY1'); } 
            set { this.Set (value, 'KUNAG_CITY1'); }
        }

        @AuraEnabled public String SoldToRegion
        { 
            get { return this.getString ('KUNAG_REGION'); } 
            set { this.Set (value, 'KUNAG_REGION'); }
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

        @AuraEnabled public String ShipToCity
        { 
            get { return this.getString ('KUNWE_CITY1'); } 
            set { this.Set (value, 'KUNWE_CITY1'); }
        }

        @AuraEnabled public String ShipToRegion
        { 
            get { return this.getString ('KUNWE_REGION'); } 
            set { this.Set (value, 'KUNWE_REGION'); }
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

        @AuraEnabled public String QuoteStatus
        { 
            get { return this.getString ('QUOTESTATUS'); } 
            set { this.Set (value, 'QUOTESTATUS'); }
        }

        @AuraEnabled public String SalesDocumentVersionNumber
        { 
            get { return this.getString ('VSNMR_V'); } 
            set { this.Set (value, 'VSNMR_V'); }
        }

        @AuraEnabled public String YourReference
        { 
            get { return this.getString ('IHREZ'); } 
            set { this.Set (value, 'IHREZ'); }
        }

        @AuraEnabled public String ShipToPurchaseOrderNumber
        { 
            get { return this.getString ('BSTKD_E'); } 
            set { this.Set (value, 'BSTKD_E'); }
        }

    }

    public class SEARCHRESULT_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public SEARCHRESULT_COLLECTION()
        {
            super('SEARCHRESULT', SBO_EnosixQuote_Search.SEARCHRESULT.class, null);
        }

        public List<SBO_EnosixQuote_Search.SEARCHRESULT> getAsList()
        {
            return (List<SBO_EnosixQuote_Search.SEARCHRESULT>)this.buildList(List<SBO_EnosixQuote_Search.SEARCHRESULT>.class);
        }
    }


}