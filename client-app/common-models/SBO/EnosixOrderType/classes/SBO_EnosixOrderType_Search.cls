/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class SBO_EnosixOrderType_Search extends ensxsdk.EnosixFramework.SearchSBO 
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('SBO_EnosixOrderType_Search_Meta', new Type[] {
            SBO_EnosixOrderType_Search.EnosixOrderType_SC.class
            , SBO_EnosixOrderType_Search.EnosixOrderType_SR.class
            , SBO_EnosixOrderType_Search.SEARCHRESULT.class
            , SBO_EnosixOrderType_Search.SEARCHPARAMS.class
            , SBO_EnosixOrderType_Search.SEARCHRESULT.class
            } 
        );
    }

    public SBO_EnosixOrderType_Search() 
    {
        super('EnosixOrderType', SBO_EnosixOrderType_Search.EnosixOrderType_SC.class, SBO_EnosixOrderType_Search.EnosixOrderType_SR.class);
    }
    
    public override Type getType() { return SBO_EnosixOrderType_Search.class; }

    public EnosixOrderType_SC search(EnosixOrderType_SC sc) 
    {
        return (EnosixOrderType_SC)super.executeSearch(sc);
    }

    public EnosixOrderType_SC initialize(EnosixOrderType_SC sc) 
    {
        return (EnosixOrderType_SC)super.executeInitialize(sc);
    }

    public class EnosixOrderType_SC extends ensxsdk.EnosixFramework.SearchContext 
    { 		
        public EnosixOrderType_SC() 
        {		
            super(new Map<string,type>		
                {		
                    'SEARCHPARAMS' => SBO_EnosixOrderType_Search.SEARCHPARAMS.class		
                });		
        }

        public override Type getType() { return SBO_EnosixOrderType_Search.EnosixOrderType_SC.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixOrderType_Search.registerReflectionInfo();
        }

        public EnosixOrderType_SR result { get { return (EnosixOrderType_SR)baseResult; } }


        @AuraEnabled public SBO_EnosixOrderType_Search.SEARCHPARAMS SEARCHPARAMS 
        {
            get
            {
                return (SBO_EnosixOrderType_Search.SEARCHPARAMS)this.getStruct(SBO_EnosixOrderType_Search.SEARCHPARAMS.class);
            }
        }
        
        }

    public class EnosixOrderType_SR extends ensxsdk.EnosixFramework.SearchResult 
    {
        public EnosixOrderType_SR() 
        {
            super(new Map<string,type>{'SEARCHRESULT' => SBO_EnosixOrderType_Search.SEARCHRESULT.class } );
        }
        
        public ensxsdk.EnosixFramework.FrameworkCollection SearchResults
        {
            get { return super.getCollection(SBO_EnosixOrderType_Search.SEARCHRESULT.class); }
        }
        
        public List<SEARCHRESULT> getResults() 
        {
            List<SEARCHRESULT> results = new List<SEARCHRESULT>();
            SearchResults.copyTo(results);
            return results;
        }

        public override Type getType() { return SBO_EnosixOrderType_Search.EnosixOrderType_SR.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixOrderType_Search.registerReflectionInfo();
        }
    }

    public class SEARCHPARAMS extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixOrderType_Search.SEARCHPARAMS.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixOrderType_Search.registerReflectionInfo();
        }
        @AuraEnabled public String SalesDocumentType
        { 
            get { return this.getString ('AUART'); } 
            set { this.Set (value, 'AUART'); }
        }

        @AuraEnabled public Boolean SO
        { 
            get { return this.getBoolean('SO'); } 
            set { this.setBoolean(value, 'SO'); }
        }

        @AuraEnabled public Boolean QT
        { 
            get { return this.getBoolean('QT'); } 
            set { this.setBoolean(value, 'QT'); }
        }

        @AuraEnabled public Boolean ARM
        { 
            get { return this.getBoolean('ARM'); } 
            set { this.setBoolean(value, 'ARM'); }
        }

    }

    public class SEARCHRESULT extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixOrderType_Search.SEARCHRESULT.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixOrderType_Search.registerReflectionInfo();
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

    }

    public class SEARCHRESULT_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public SEARCHRESULT_COLLECTION()
        {
            super('SEARCHRESULT', SBO_EnosixOrderType_Search.SEARCHRESULT.class, null);
        }

        public List<SBO_EnosixOrderType_Search.SEARCHRESULT> getAsList()
        {
            return (List<SBO_EnosixOrderType_Search.SEARCHRESULT>)this.buildList(List<SBO_EnosixOrderType_Search.SEARCHRESULT>.class);
        }
    }


}