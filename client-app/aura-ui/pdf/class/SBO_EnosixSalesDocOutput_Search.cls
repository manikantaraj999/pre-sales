/// enosiX Inc. Generated Apex Model
/// Generated On: 3/12/2020 1:37:06 PM
/// SAP Host: From REST Service On: https://data-efficiency-235-dev-ed.cs26.my.salesforce.com
/// CID: From REST Service On: https://data-efficiency-235-dev-ed.cs26.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class SBO_EnosixSalesDocOutput_Search extends ensxsdk.EnosixFramework.SearchSBO 
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('SBO_EnosixSalesDocOutput_Search_Meta', new Type[] {
            SBO_EnosixSalesDocOutput_Search.EnosixSalesDocOutput_SC.class
            , SBO_EnosixSalesDocOutput_Search.EnosixSalesDocOutput_SR.class
            , SBO_EnosixSalesDocOutput_Search.SEARCHRESULT.class
            , SBO_EnosixSalesDocOutput_Search.SEARCHPARAMS.class
            , SBO_EnosixSalesDocOutput_Search.OUTPUT_TYPE.class
            , SBO_EnosixSalesDocOutput_Search.SEARCHRESULT.class
            } 
        );
    }

    public SBO_EnosixSalesDocOutput_Search() 
    {
        super('EnosixSalesDocOutput', SBO_EnosixSalesDocOutput_Search.EnosixSalesDocOutput_SC.class, SBO_EnosixSalesDocOutput_Search.EnosixSalesDocOutput_SR.class);
    }
    
    public override Type getType() { return SBO_EnosixSalesDocOutput_Search.class; }

    public EnosixSalesDocOutput_SC search(EnosixSalesDocOutput_SC sc) 
    {
        return (EnosixSalesDocOutput_SC)super.executeSearch(sc);
    }

    public EnosixSalesDocOutput_SC initialize(EnosixSalesDocOutput_SC sc) 
    {
        return (EnosixSalesDocOutput_SC)super.executeInitialize(sc);
    }

    public class EnosixSalesDocOutput_SC extends ensxsdk.EnosixFramework.SearchContext 
    { 		
        public EnosixSalesDocOutput_SC() 
        {		
            super(new Map<string,type>		
                {		
                    'SEARCHPARAMS' => SBO_EnosixSalesDocOutput_Search.SEARCHPARAMS.class
                    ,'OUTPUT_TYPE' => SBO_EnosixSalesDocOutput_Search.OUTPUT_TYPE_COLLECTION.class		
                });		
        }

        public override Type getType() { return SBO_EnosixSalesDocOutput_Search.EnosixSalesDocOutput_SC.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixSalesDocOutput_Search.registerReflectionInfo();
        }

        public EnosixSalesDocOutput_SR result { get { return (EnosixSalesDocOutput_SR)baseResult; } }


        @AuraEnabled public SBO_EnosixSalesDocOutput_Search.SEARCHPARAMS SEARCHPARAMS 
        {
            get
            {
                return (SBO_EnosixSalesDocOutput_Search.SEARCHPARAMS)this.getStruct(SBO_EnosixSalesDocOutput_Search.SEARCHPARAMS.class);
            }
        }
        
            @AuraEnabled public OUTPUT_TYPE_COLLECTION OUTPUT_TYPE
        {
            get 
            { 
                return (OUTPUT_TYPE_COLLECTION)this.getCollection(SBO_EnosixSalesDocOutput_Search.OUTPUT_TYPE_COLLECTION.class); 
            }
        }

            }

    public class EnosixSalesDocOutput_SR extends ensxsdk.EnosixFramework.SearchResult 
    {
        public EnosixSalesDocOutput_SR() 
        {
            super(new Map<string,type>{'SEARCHRESULT' => SBO_EnosixSalesDocOutput_Search.SEARCHRESULT.class } );
        }
        
        public ensxsdk.EnosixFramework.FrameworkCollection SearchResults
        {
            get { return super.getCollection(SBO_EnosixSalesDocOutput_Search.SEARCHRESULT.class); }
        }
        
        public List<SEARCHRESULT> getResults() 
        {
            List<SEARCHRESULT> results = new List<SEARCHRESULT>();
            SearchResults.copyTo(results);
            return results;
        }

        public override Type getType() { return SBO_EnosixSalesDocOutput_Search.EnosixSalesDocOutput_SR.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixSalesDocOutput_Search.registerReflectionInfo();
        }
    }

    public class SEARCHPARAMS extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixSalesDocOutput_Search.SEARCHPARAMS.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixSalesDocOutput_Search.registerReflectionInfo();
        }
        @AuraEnabled public String SalesDocument
        { 
            get { return this.getString ('VBELN'); } 
            set { this.Set (value, 'VBELN'); }
        }

        @AuraEnabled public String OutputApplication
        { 
            get { return this.getString ('KAPPL'); } 
            set { this.Set (value, 'KAPPL'); }
        }

    }

public class OUTPUT_TYPE extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixSalesDocOutput_Search.OUTPUT_TYPE.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixSalesDocOutput_Search.registerReflectionInfo();
        }
        @AuraEnabled public String ConditionType
        { 
            get { return this.getString ('KSCHL'); } 
            set { this.Set (value, 'KSCHL'); }
        }

        @AuraEnabled public Boolean X_GetPDF
        { 
            get { return this.getBoolean('X_GET_PDF'); } 
            set { this.setBoolean(value, 'X_GET_PDF'); }
        }

    }

    public class OUTPUT_TYPE_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public OUTPUT_TYPE_COLLECTION()
        {
            super('OUTPUT_TYPE', SBO_EnosixSalesDocOutput_Search.OUTPUT_TYPE.class, null);
        }

        public List<SBO_EnosixSalesDocOutput_Search.OUTPUT_TYPE> getAsList()
        {
            return (List<SBO_EnosixSalesDocOutput_Search.OUTPUT_TYPE>)this.buildList(List<SBO_EnosixSalesDocOutput_Search.OUTPUT_TYPE>.class);
        }
    }

    public class SEARCHRESULT extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixSalesDocOutput_Search.SEARCHRESULT.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixSalesDocOutput_Search.registerReflectionInfo();
        }
        @AuraEnabled public String SalesDocument
        { 
            get { return this.getString ('VBELN'); } 
            set { this.Set (value, 'VBELN'); }
        }

        @AuraEnabled public String ConditionType
        { 
            get { return this.getString ('KSCHL'); } 
            set { this.Set (value, 'KSCHL'); }
        }

        @AuraEnabled public String ConditionTypeDescription
        { 
            get { return this.getString ('KSCHL_TEXT'); } 
            set { this.Set (value, 'KSCHL_TEXT'); }
        }

        @AuraEnabled public String Language
        { 
            get { return this.getString ('SPRAS'); } 
            set { this.Set (value, 'SPRAS'); }
        }

        @AuraEnabled public String PDFB64String
        { 
            get { return this.getString ('PDF_B64STR'); } 
            set { this.Set (value, 'PDF_B64STR'); }
        }

    }

    public class SEARCHRESULT_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public SEARCHRESULT_COLLECTION()
        {
            super('SEARCHRESULT', SBO_EnosixSalesDocOutput_Search.SEARCHRESULT.class, null);
        }

        public List<SBO_EnosixSalesDocOutput_Search.SEARCHRESULT> getAsList()
        {
            return (List<SBO_EnosixSalesDocOutput_Search.SEARCHRESULT>)this.buildList(List<SBO_EnosixSalesDocOutput_Search.SEARCHRESULT>.class);
        }
    }


}