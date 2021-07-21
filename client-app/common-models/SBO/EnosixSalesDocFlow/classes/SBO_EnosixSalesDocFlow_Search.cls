/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class SBO_EnosixSalesDocFlow_Search extends ensxsdk.EnosixFramework.SearchSBO 
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('SBO_EnosixSalesDocFlow_Search_Meta', new Type[] {
            SBO_EnosixSalesDocFlow_Search.EnosixSalesDocFlow_SC.class
            , SBO_EnosixSalesDocFlow_Search.EnosixSalesDocFlow_SR.class
            , SBO_EnosixSalesDocFlow_Search.SEARCHRESULT.class
            , SBO_EnosixSalesDocFlow_Search.SEARCHPARAMS.class
            , SBO_EnosixSalesDocFlow_Search.SEARCHRESULT.class
            } 
        );
    }

    public SBO_EnosixSalesDocFlow_Search() 
    {
        super('EnosixSalesDocFlow', SBO_EnosixSalesDocFlow_Search.EnosixSalesDocFlow_SC.class, SBO_EnosixSalesDocFlow_Search.EnosixSalesDocFlow_SR.class);
    }
    
    public override Type getType() { return SBO_EnosixSalesDocFlow_Search.class; }

    public EnosixSalesDocFlow_SC search(EnosixSalesDocFlow_SC sc) 
    {
        return (EnosixSalesDocFlow_SC)super.executeSearch(sc);
    }

    public EnosixSalesDocFlow_SC initialize(EnosixSalesDocFlow_SC sc) 
    {
        return (EnosixSalesDocFlow_SC)super.executeInitialize(sc);
    }

    public class EnosixSalesDocFlow_SC extends ensxsdk.EnosixFramework.SearchContext 
    { 		
        public EnosixSalesDocFlow_SC() 
        {		
            super(new Map<string,type>		
                {		
                    'SEARCHPARAMS' => SBO_EnosixSalesDocFlow_Search.SEARCHPARAMS.class		
                });		
        }

        public override Type getType() { return SBO_EnosixSalesDocFlow_Search.EnosixSalesDocFlow_SC.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixSalesDocFlow_Search.registerReflectionInfo();
        }

        public EnosixSalesDocFlow_SR result { get { return (EnosixSalesDocFlow_SR)baseResult; } }


        @AuraEnabled public SBO_EnosixSalesDocFlow_Search.SEARCHPARAMS SEARCHPARAMS 
        {
            get
            {
                return (SBO_EnosixSalesDocFlow_Search.SEARCHPARAMS)this.getStruct(SBO_EnosixSalesDocFlow_Search.SEARCHPARAMS.class);
            }
        }
        
        }

    public class EnosixSalesDocFlow_SR extends ensxsdk.EnosixFramework.SearchResult 
    {
        public EnosixSalesDocFlow_SR() 
        {
            super(new Map<string,type>{'SEARCHRESULT' => SBO_EnosixSalesDocFlow_Search.SEARCHRESULT.class } );
        }
        
        public ensxsdk.EnosixFramework.FrameworkCollection SearchResults
        {
            get { return super.getCollection(SBO_EnosixSalesDocFlow_Search.SEARCHRESULT.class); }
        }
        
        public List<SEARCHRESULT> getResults() 
        {
            List<SEARCHRESULT> results = new List<SEARCHRESULT>();
            SearchResults.copyTo(results);
            return results;
        }

        public override Type getType() { return SBO_EnosixSalesDocFlow_Search.EnosixSalesDocFlow_SR.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixSalesDocFlow_Search.registerReflectionInfo();
        }
    }

    public class SEARCHPARAMS extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixSalesDocFlow_Search.SEARCHPARAMS.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixSalesDocFlow_Search.registerReflectionInfo();
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

        @AuraEnabled public String DocumentCategory
        { 
            get { return this.getString ('VBTYP'); } 
            set { this.Set (value, 'VBTYP'); }
        }

        @AuraEnabled public Boolean X_PrecedingDocuments
        { 
            get { return this.getBoolean('X_PRECEDING'); } 
            set { this.setBoolean(value, 'X_PRECEDING'); }
        }

        @AuraEnabled public Boolean X_SubsequentDocuments
        { 
            get { return this.getBoolean('X_SUBSEQUENT'); } 
            set { this.setBoolean(value, 'X_SUBSEQUENT'); }
        }

    }

    public class SEARCHRESULT extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixSalesDocFlow_Search.SEARCHRESULT.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixSalesDocFlow_Search.registerReflectionInfo();
        }
        @AuraEnabled public String SalesDocument
        { 
            get { return this.getString ('VBELN'); } 
            set { this.Set (value, 'VBELN'); }
        }

        @AuraEnabled public String ItemNumber
        { 
            get { return this.getString ('POSNR'); } 
            set { this.Set (value, 'POSNR'); }
        }

        @AuraEnabled public String DocumentCategory
        { 
            get { return this.getString ('VBTYP'); } 
            set { this.Set (value, 'VBTYP'); }
        }

        @AuraEnabled public String DocumentCategoryText
        { 
            get { return this.getString ('VBTYP_TEXT'); } 
            set { this.Set (value, 'VBTYP_TEXT'); }
        }

        @AuraEnabled public String CustomerNumber
        { 
            get { return this.getString ('KUNNR'); } 
            set { this.Set (value, 'KUNNR'); }
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

        @AuraEnabled public Date DateChanged
        { 
            get { return this.getDate ('AEDAT'); } 
            set { this.Set (value, 'AEDAT'); }
        }

        @AuraEnabled public String ChangedBy
        { 
            get { return this.getString ('AENAM'); } 
            set { this.Set (value, 'AENAM'); }
        }

        @AuraEnabled public Boolean X_PrecedingDocuments
        { 
            get { return this.getBoolean('X_PRECEDING'); } 
            set { this.setBoolean(value, 'X_PRECEDING'); }
        }

        @AuraEnabled public Boolean X_SubsequentDocuments
        { 
            get { return this.getBoolean('X_SUBSEQUENT'); } 
            set { this.setBoolean(value, 'X_SUBSEQUENT'); }
        }

        @AuraEnabled public String DocumentStatus
        { 
            get { return this.getString ('STATUS'); } 
            set { this.Set (value, 'STATUS'); }
        }

    }

    public class SEARCHRESULT_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public SEARCHRESULT_COLLECTION()
        {
            super('SEARCHRESULT', SBO_EnosixSalesDocFlow_Search.SEARCHRESULT.class, null);
        }

        public List<SBO_EnosixSalesDocFlow_Search.SEARCHRESULT> getAsList()
        {
            return (List<SBO_EnosixSalesDocFlow_Search.SEARCHRESULT>)this.buildList(List<SBO_EnosixSalesDocFlow_Search.SEARCHRESULT>.class);
        }
    }


}