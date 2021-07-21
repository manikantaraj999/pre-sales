/// enosiX Inc. Generated Apex Model
/// Generated On: 2/14/2019 12:08:50 PM
/// SAP Host: From REST Service On: https://customer-speed-3702-dev-ed.cs1.my.salesforce.com
/// CID: From REST Service On: https://customer-speed-3702-dev-ed.cs1.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class SBO_EnosixSalesDocSync_Search extends ensxsdk.EnosixFramework.SearchSBO 
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('SBO_EnosixSalesDocSync_Search_Meta', new Type[] {
            SBO_EnosixSalesDocSync_Search.EnosixSalesDocSync_SC.class
            , SBO_EnosixSalesDocSync_Search.EnosixSalesDocSync_SR.class
            , SBO_EnosixSalesDocSync_Search.SEARCHRESULT.class
            , SBO_EnosixSalesDocSync_Search.SEARCHPARAMS.class
            , SBO_EnosixSalesDocSync_Search.DOC_TYPE.class
            , SBO_EnosixSalesDocSync_Search.SEARCHRESULT.class
            } 
        );
    }

    public SBO_EnosixSalesDocSync_Search() 
    {
        super('EnosixSalesDocSync', SBO_EnosixSalesDocSync_Search.EnosixSalesDocSync_SC.class, SBO_EnosixSalesDocSync_Search.EnosixSalesDocSync_SR.class);
    }
    
    public override Type getType() { return SBO_EnosixSalesDocSync_Search.class; }

    public EnosixSalesDocSync_SC search(EnosixSalesDocSync_SC sc) 
    {
        return (EnosixSalesDocSync_SC)super.executeSearch(sc);
    }

    public EnosixSalesDocSync_SC initialize(EnosixSalesDocSync_SC sc) 
    {
        return (EnosixSalesDocSync_SC)super.executeInitialize(sc);
    }

    public class EnosixSalesDocSync_SC extends ensxsdk.EnosixFramework.SearchContext 
    { 		
        public EnosixSalesDocSync_SC() 
        {		
            super(new Map<string,type>		
                {		
                    'SEARCHPARAMS' => SBO_EnosixSalesDocSync_Search.SEARCHPARAMS.class
                    ,'DOC_TYPE' => SBO_EnosixSalesDocSync_Search.DOC_TYPE_COLLECTION.class		
                });		
        }

        public override Type getType() { return SBO_EnosixSalesDocSync_Search.EnosixSalesDocSync_SC.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixSalesDocSync_Search.registerReflectionInfo();
        }

        public EnosixSalesDocSync_SR result { get { return (EnosixSalesDocSync_SR)baseResult; } }


        @AuraEnabled public SBO_EnosixSalesDocSync_Search.SEARCHPARAMS SEARCHPARAMS 
        {
            get
            {
                return (SBO_EnosixSalesDocSync_Search.SEARCHPARAMS)this.getStruct(SBO_EnosixSalesDocSync_Search.SEARCHPARAMS.class);
            }
        }
        
            @AuraEnabled public DOC_TYPE_COLLECTION DOC_TYPE
        {
            get 
            { 
                return (DOC_TYPE_COLLECTION)this.getCollection(SBO_EnosixSalesDocSync_Search.DOC_TYPE_COLLECTION.class); 
            }
        }

            }

    public class EnosixSalesDocSync_SR extends ensxsdk.EnosixFramework.SearchResult 
    {
        public EnosixSalesDocSync_SR() 
        {
            super(new Map<string,type>{'SEARCHRESULT' => SBO_EnosixSalesDocSync_Search.SEARCHRESULT.class } );
        }
        
        public ensxsdk.EnosixFramework.FrameworkCollection SearchResults
        {
            get { return super.getCollection(SBO_EnosixSalesDocSync_Search.SEARCHRESULT.class); }
        }
        
        public List<SEARCHRESULT> getResults() 
        {
            List<SEARCHRESULT> results = new List<SEARCHRESULT>();
            SearchResults.copyTo(results);
            return results;
        }

        public override Type getType() { return SBO_EnosixSalesDocSync_Search.EnosixSalesDocSync_SR.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixSalesDocSync_Search.registerReflectionInfo();
        }
    }

    public class SEARCHPARAMS extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixSalesDocSync_Search.SEARCHPARAMS.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixSalesDocSync_Search.registerReflectionInfo();
        }
        @AuraEnabled public Date DateFrom
        { 
            get { return this.getDate ('DATE_FROM'); } 
            set { this.Set (value, 'DATE_FROM'); }
        }

        @AuraEnabled public Boolean InitialLoad
        { 
            get { return this.getBoolean('X_INITIALLOAD'); } 
            set { this.setBoolean(value, 'X_INITIALLOAD'); }
        }

        @AuraEnabled public String TransactionGroup
        { 
            get { return this.getString ('TRVOG'); } 
            set { this.Set (value, 'TRVOG'); }
        }

    }

public class DOC_TYPE extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixSalesDocSync_Search.DOC_TYPE.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixSalesDocSync_Search.registerReflectionInfo();
        }
        @AuraEnabled public String SalesDocumentType
        { 
            get { return this.getString ('AUART'); } 
            set { this.Set (value, 'AUART'); }
        }

    }

    public class DOC_TYPE_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public DOC_TYPE_COLLECTION()
        {
            super('DOC_TYPE', SBO_EnosixSalesDocSync_Search.DOC_TYPE.class, null);
        }

        public List<SBO_EnosixSalesDocSync_Search.DOC_TYPE> getAsList()
        {
            return (List<SBO_EnosixSalesDocSync_Search.DOC_TYPE>)this.buildList(List<SBO_EnosixSalesDocSync_Search.DOC_TYPE>.class);
        }
    }

    public class SEARCHRESULT extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixSalesDocSync_Search.SEARCHRESULT.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixSalesDocSync_Search.registerReflectionInfo();
        }
        @AuraEnabled public String SalesDocument
        { 
            get { return this.getString ('VBELN'); } 
            set { this.Set (value, 'VBELN'); }
        }

        @AuraEnabled public String CustomerNumber
        { 
            get { return this.getString ('KUNNR'); } 
            set { this.Set (value, 'KUNNR'); }
        }

        @AuraEnabled public String CustomerName
        { 
            get { return this.getString ('KUNNR_NAME'); } 
            set { this.Set (value, 'KUNNR_NAME'); }
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

        @AuraEnabled public Date RequestedDeliveryDate
        { 
            get { return this.getDate ('VDATU'); } 
            set { this.Set (value, 'VDATU'); }
        }

        @AuraEnabled public Date CreateDate
        { 
            get { return this.getDate ('ERDAT'); } 
            set { this.Set (value, 'ERDAT'); }
        }

        @AuraEnabled public String CreatedBy
        { 
            get { return this.getString ('ERNAM'); } 
            set { this.Set (value, 'ERNAM'); }
        }

        @AuraEnabled public String CustomerPurchaseOrderNumber
        { 
            get { return this.getString ('BSTKD'); } 
            set { this.Set (value, 'BSTKD'); }
        }

        @AuraEnabled public Date CustomerPurchaseOrderDate
        { 
            get { return this.getDate ('BSTDK'); } 
            set { this.Set (value, 'BSTDK'); }
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

        @AuraEnabled public String TransactionGroup
        { 
            get { return this.getString ('TRVOG'); } 
            set { this.Set (value, 'TRVOG'); }
        }

        @AuraEnabled public String DeliveryBlock
        { 
            get { return this.getString ('LIFSK'); } 
            set { this.Set (value, 'LIFSK'); }
        }

        @AuraEnabled public String BillingBlock
        { 
            get { return this.getString ('FAKSK'); } 
            set { this.Set (value, 'FAKSK'); }
        }

        @AuraEnabled public String TermsofPaymentKey
        { 
            get { return this.getString ('ZTERM'); } 
            set { this.Set (value, 'ZTERM'); }
        }

        @AuraEnabled public String IncotermsPart1
        { 
            get { return this.getString ('INCO1'); } 
            set { this.Set (value, 'INCO1'); }
        }

        @AuraEnabled public String IncotermsPart2
        { 
            get { return this.getString ('INCO2'); } 
            set { this.Set (value, 'INCO2'); }
        }

    }

    public class SEARCHRESULT_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public SEARCHRESULT_COLLECTION()
        {
            super('SEARCHRESULT', SBO_EnosixSalesDocSync_Search.SEARCHRESULT.class, null);
        }

        public List<SBO_EnosixSalesDocSync_Search.SEARCHRESULT> getAsList()
        {
            return (List<SBO_EnosixSalesDocSync_Search.SEARCHRESULT>)this.buildList(List<SBO_EnosixSalesDocSync_Search.SEARCHRESULT>.class);
        }
    }


}