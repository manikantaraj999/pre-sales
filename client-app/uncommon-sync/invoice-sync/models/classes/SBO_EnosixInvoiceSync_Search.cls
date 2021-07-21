/// enosiX Inc. Generated Apex Model
/// Generated On: 2/18/2019 5:30:54 PM
/// SAP Host: From REST Service On: https://app-speed-4607-dev-ed.cs11.my.salesforce.com
/// CID: From REST Service On: https://app-speed-4607-dev-ed.cs11.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class SBO_EnosixInvoiceSync_Search extends ensxsdk.EnosixFramework.SearchSBO 
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('SBO_EnosixInvoiceSync_Search_Meta', new Type[] {
            SBO_EnosixInvoiceSync_Search.EnosixInvoiceSync_SC.class
            , SBO_EnosixInvoiceSync_Search.EnosixInvoiceSync_SR.class
            , SBO_EnosixInvoiceSync_Search.SEARCHRESULT.class
            , SBO_EnosixInvoiceSync_Search.SEARCHPARAMS.class
            , SBO_EnosixInvoiceSync_Search.SEARCHRESULT.class
            } 
        );
    }

    public SBO_EnosixInvoiceSync_Search() 
    {
        super('EnosixInvoiceSync', SBO_EnosixInvoiceSync_Search.EnosixInvoiceSync_SC.class, SBO_EnosixInvoiceSync_Search.EnosixInvoiceSync_SR.class);
    }
    
    public override Type getType() { return SBO_EnosixInvoiceSync_Search.class; }

    public EnosixInvoiceSync_SC search(EnosixInvoiceSync_SC sc) 
    {
        return (EnosixInvoiceSync_SC)super.executeSearch(sc);
    }

    public EnosixInvoiceSync_SC initialize(EnosixInvoiceSync_SC sc) 
    {
        return (EnosixInvoiceSync_SC)super.executeInitialize(sc);
    }

    public class EnosixInvoiceSync_SC extends ensxsdk.EnosixFramework.SearchContext 
    { 		
        public EnosixInvoiceSync_SC() 
        {		
            super(new Map<string,type>		
                {		
                    'SEARCHPARAMS' => SBO_EnosixInvoiceSync_Search.SEARCHPARAMS.class		
                });		
        }

        public override Type getType() { return SBO_EnosixInvoiceSync_Search.EnosixInvoiceSync_SC.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixInvoiceSync_Search.registerReflectionInfo();
        }

        public EnosixInvoiceSync_SR result { get { return (EnosixInvoiceSync_SR)baseResult; } }


        @AuraEnabled public SBO_EnosixInvoiceSync_Search.SEARCHPARAMS SEARCHPARAMS 
        {
            get
            {
                return (SBO_EnosixInvoiceSync_Search.SEARCHPARAMS)this.getStruct(SBO_EnosixInvoiceSync_Search.SEARCHPARAMS.class);
            }
        }
        
        }

    public class EnosixInvoiceSync_SR extends ensxsdk.EnosixFramework.SearchResult 
    {
        public EnosixInvoiceSync_SR() 
        {
            super(new Map<string,type>{'SEARCHRESULT' => SBO_EnosixInvoiceSync_Search.SEARCHRESULT.class } );
        }
        
        public ensxsdk.EnosixFramework.FrameworkCollection SearchResults
        {
            get { return super.getCollection(SBO_EnosixInvoiceSync_Search.SEARCHRESULT.class); }
        }
        
        public List<SEARCHRESULT> getResults() 
        {
            List<SEARCHRESULT> results = new List<SEARCHRESULT>();
            SearchResults.copyTo(results);
            return results;
        }

        public override Type getType() { return SBO_EnosixInvoiceSync_Search.EnosixInvoiceSync_SR.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixInvoiceSync_Search.registerReflectionInfo();
        }
    }

    public class SEARCHPARAMS extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixInvoiceSync_Search.SEARCHPARAMS.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixInvoiceSync_Search.registerReflectionInfo();
        }
        @AuraEnabled public Date DateFrom
        { 
            get { return this.getDate ('DATE_FROM'); } 
            set { this.Set (value, 'DATE_FROM'); }
        }

        @AuraEnabled public Boolean X_INITIALLOAD
        { 
            get { return this.getBoolean('X_INITIALLOAD'); } 
            set { this.setBoolean(value, 'X_INITIALLOAD'); }
        }

        @AuraEnabled public Date DateTo
        { 
            get { return this.getDate ('DATE_TO'); } 
            set { this.Set (value, 'DATE_TO'); }
        }

    }

    public class SEARCHRESULT extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixInvoiceSync_Search.SEARCHRESULT.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixInvoiceSync_Search.registerReflectionInfo();
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

        @AuraEnabled public String BillingCategory
        { 
            get { return this.getString ('FKTYP'); } 
            set { this.Set (value, 'FKTYP'); }
        }

        @AuraEnabled public String CompanyCode
        { 
            get { return this.getString ('BUKRS'); } 
            set { this.Set (value, 'BUKRS'); }
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

        @AuraEnabled public String AccountingDocumentNumber
        { 
            get { return this.getString ('BELNR'); } 
            set { this.Set (value, 'BELNR'); }
        }

        @AuraEnabled public Date BillingDate
        { 
            get { return this.getDate ('FKDAT'); } 
            set { this.Set (value, 'FKDAT'); }
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

        @AuraEnabled public String ReferenceDocumentNumber
        { 
            get { return this.getString ('XBLNR'); } 
            set { this.Set (value, 'XBLNR'); }
        }

        @AuraEnabled public String ShippingConditions
        { 
            get { return this.getString ('VSBED'); } 
            set { this.Set (value, 'VSBED'); }
        }

        @AuraEnabled public String Country
        { 
            get { return this.getString ('LAND1'); } 
            set { this.Set (value, 'LAND1'); }
        }

        @AuraEnabled public String Region
        { 
            get { return this.getString ('REGIO'); } 
            set { this.Set (value, 'REGIO'); }
        }

        @AuraEnabled public String FiscalYear
        { 
            get { return this.getString ('GJAHR'); } 
            set { this.Set (value, 'GJAHR'); }
        }

    }

    public class SEARCHRESULT_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public SEARCHRESULT_COLLECTION()
        {
            super('SEARCHRESULT', SBO_EnosixInvoiceSync_Search.SEARCHRESULT.class, null);
        }

        public List<SBO_EnosixInvoiceSync_Search.SEARCHRESULT> getAsList()
        {
            return (List<SBO_EnosixInvoiceSync_Search.SEARCHRESULT>)this.buildList(List<SBO_EnosixInvoiceSync_Search.SEARCHRESULT>.class);
        }
    }


}