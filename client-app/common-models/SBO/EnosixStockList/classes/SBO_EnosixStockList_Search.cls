/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class SBO_EnosixStockList_Search extends ensxsdk.EnosixFramework.SearchSBO 
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('SBO_EnosixStockList_Search_Meta', new Type[] {
            SBO_EnosixStockList_Search.EnosixStockList_SC.class
            , SBO_EnosixStockList_Search.EnosixStockList_SR.class
            , SBO_EnosixStockList_Search.SEARCHRESULT.class
            , SBO_EnosixStockList_Search.SEARCHPARAMS.class
            , SBO_EnosixStockList_Search.SEARCHRESULT.class
            } 
        );
    }

    public SBO_EnosixStockList_Search() 
    {
        super('EnosixStockList', SBO_EnosixStockList_Search.EnosixStockList_SC.class, SBO_EnosixStockList_Search.EnosixStockList_SR.class);
    }
    
    public override Type getType() { return SBO_EnosixStockList_Search.class; }

    public EnosixStockList_SC search(EnosixStockList_SC sc) 
    {
        return (EnosixStockList_SC)super.executeSearch(sc);
    }

    public EnosixStockList_SC initialize(EnosixStockList_SC sc) 
    {
        return (EnosixStockList_SC)super.executeInitialize(sc);
    }

    public class EnosixStockList_SC extends ensxsdk.EnosixFramework.SearchContext 
    { 		
        public EnosixStockList_SC() 
        {		
            super(new Map<string,type>		
                {		
                    'SEARCHPARAMS' => SBO_EnosixStockList_Search.SEARCHPARAMS.class		
                });		
        }

        public override Type getType() { return SBO_EnosixStockList_Search.EnosixStockList_SC.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixStockList_Search.registerReflectionInfo();
        }

        public EnosixStockList_SR result { get { return (EnosixStockList_SR)baseResult; } }


        @AuraEnabled public SBO_EnosixStockList_Search.SEARCHPARAMS SEARCHPARAMS 
        {
            get
            {
                return (SBO_EnosixStockList_Search.SEARCHPARAMS)this.getStruct(SBO_EnosixStockList_Search.SEARCHPARAMS.class);
            }
        }
        
        }

    public class EnosixStockList_SR extends ensxsdk.EnosixFramework.SearchResult 
    {
        public EnosixStockList_SR() 
        {
            super(new Map<string,type>{'SEARCHRESULT' => SBO_EnosixStockList_Search.SEARCHRESULT.class } );
        }
        
        public ensxsdk.EnosixFramework.FrameworkCollection SearchResults
        {
            get { return super.getCollection(SBO_EnosixStockList_Search.SEARCHRESULT.class); }
        }
        
        public List<SEARCHRESULT> getResults() 
        {
            List<SEARCHRESULT> results = new List<SEARCHRESULT>();
            SearchResults.copyTo(results);
            return results;
        }

        public override Type getType() { return SBO_EnosixStockList_Search.EnosixStockList_SR.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixStockList_Search.registerReflectionInfo();
        }
    }

    public class SEARCHPARAMS extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixStockList_Search.SEARCHPARAMS.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixStockList_Search.registerReflectionInfo();
        }
        @AuraEnabled public String Material
        { 
            get { return this.getString ('MATNR'); } 
            set { this.Set (value, 'MATNR'); }
        }

        @AuraEnabled public String Plant
        { 
            get { return this.getString ('WERKS'); } 
            set { this.Set (value, 'WERKS'); }
        }

        @AuraEnabled public Date FromDate
        { 
            get { return this.getDate ('FROM_DT'); } 
            set { this.Set (value, 'FROM_DT'); }
        }

        @AuraEnabled public Date ToDate
        { 
            get { return this.getDate ('TO_DT'); } 
            set { this.Set (value, 'TO_DT'); }
        }

    }

    public class SEARCHRESULT extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixStockList_Search.SEARCHRESULT.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixStockList_Search.registerReflectionInfo();
        }
        @AuraEnabled public String Material
        { 
            get { return this.getString ('MATNR'); } 
            set { this.Set (value, 'MATNR'); }
        }

        @AuraEnabled public String Plant
        { 
            get { return this.getString ('WERKS'); } 
            set { this.Set (value, 'WERKS'); }
        }

        @AuraEnabled public Date ReceiptRequirementDate
        { 
            get { return this.getDate ('DAT00'); } 
            set { this.Set (value, 'DAT00'); }
        }

        @AuraEnabled public String MRPElement
        { 
            get { return this.getString ('DELB0'); } 
            set { this.Set (value, 'DELB0'); }
        }

        @AuraEnabled public String MRPElementData
        { 
            get { return this.getString ('EXTRA'); } 
            set { this.Set (value, 'EXTRA'); }
        }

        @AuraEnabled public Date ReschedulingDate
        { 
            get { return this.getDate ('UMDAT'); } 
            set { this.Set (value, 'UMDAT'); }
        }

        @AuraEnabled public Decimal QtyReceivedReserved
        { 
            get { return this.getDecimal ('MNG01'); } 
            set { this.Set (value, 'MNG01'); }
        }

        @AuraEnabled public Decimal AvailableQty
        { 
            get { return this.getDecimal ('MNG02'); } 
            set { this.Set (value, 'MNG02'); }
        }

        @AuraEnabled public Decimal AvailableQtyAfterAssignment
        { 
            get { return this.getDecimal ('RESV_QTY'); } 
            set { this.Set (value, 'RESV_QTY'); }
        }

        @AuraEnabled public String StorageLocation
        { 
            get { return this.getString ('LGORT'); } 
            set { this.Set (value, 'LGORT'); }
        }

    }

    public class SEARCHRESULT_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public SEARCHRESULT_COLLECTION()
        {
            super('SEARCHRESULT', SBO_EnosixStockList_Search.SEARCHRESULT.class, null);
        }

        public List<SBO_EnosixStockList_Search.SEARCHRESULT> getAsList()
        {
            return (List<SBO_EnosixStockList_Search.SEARCHRESULT>)this.buildList(List<SBO_EnosixStockList_Search.SEARCHRESULT>.class);
        }
    }


}