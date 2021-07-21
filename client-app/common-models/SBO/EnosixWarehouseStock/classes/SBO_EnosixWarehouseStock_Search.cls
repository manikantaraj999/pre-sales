/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class SBO_EnosixWarehouseStock_Search extends ensxsdk.EnosixFramework.SearchSBO 
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('SBO_EnosixWarehouseStock_Search_Meta', new Type[] {
            SBO_EnosixWarehouseStock_Search.EnosixWarehouseStock_SC.class
            , SBO_EnosixWarehouseStock_Search.EnosixWarehouseStock_SR.class
            , SBO_EnosixWarehouseStock_Search.SEARCHRESULT.class
            , SBO_EnosixWarehouseStock_Search.SEARCHPARAMS.class
            , SBO_EnosixWarehouseStock_Search.MATERIALSEARCH.class
            , SBO_EnosixWarehouseStock_Search.MATDESCSEARCH.class
            , SBO_EnosixWarehouseStock_Search.PLANTSEARCH.class
            , SBO_EnosixWarehouseStock_Search.STORAGELOCSEARCH.class
            , SBO_EnosixWarehouseStock_Search.BATCHSEARCH.class
            , SBO_EnosixWarehouseStock_Search.MATERIALTYSEARCH.class
            , SBO_EnosixWarehouseStock_Search.MATERIALGRPSEARCH.class
            , SBO_EnosixWarehouseStock_Search.SPECIALSTKTYSEARCH.class
            , SBO_EnosixWarehouseStock_Search.POSTINGDTSEARCH.class
            , SBO_EnosixWarehouseStock_Search.MOVEMENTTYSEARCH.class
            , SBO_EnosixWarehouseStock_Search.SEARCHRESULT.class
            } 
        );
    }

    public SBO_EnosixWarehouseStock_Search() 
    {
        super('EnosixWarehouseStock', SBO_EnosixWarehouseStock_Search.EnosixWarehouseStock_SC.class, SBO_EnosixWarehouseStock_Search.EnosixWarehouseStock_SR.class);
    }
    
    public override Type getType() { return SBO_EnosixWarehouseStock_Search.class; }

    public EnosixWarehouseStock_SC search(EnosixWarehouseStock_SC sc) 
    {
        return (EnosixWarehouseStock_SC)super.executeSearch(sc);
    }

    public EnosixWarehouseStock_SC initialize(EnosixWarehouseStock_SC sc) 
    {
        return (EnosixWarehouseStock_SC)super.executeInitialize(sc);
    }

    public class EnosixWarehouseStock_SC extends ensxsdk.EnosixFramework.SearchContext 
    { 		
        public EnosixWarehouseStock_SC() 
        {		
            super(new Map<string,type>		
                {		
                    'SEARCHPARAMS' => SBO_EnosixWarehouseStock_Search.SEARCHPARAMS.class
                    ,'MATERIALSEARCH' => SBO_EnosixWarehouseStock_Search.MATERIALSEARCH_COLLECTION.class
                    ,'MATDESCSEARCH' => SBO_EnosixWarehouseStock_Search.MATDESCSEARCH_COLLECTION.class
                    ,'PLANTSEARCH' => SBO_EnosixWarehouseStock_Search.PLANTSEARCH_COLLECTION.class
                    ,'STORAGELOCSEARCH' => SBO_EnosixWarehouseStock_Search.STORAGELOCSEARCH_COLLECTION.class
                    ,'BATCHSEARCH' => SBO_EnosixWarehouseStock_Search.BATCHSEARCH_COLLECTION.class
                    ,'MATERIALTYSEARCH' => SBO_EnosixWarehouseStock_Search.MATERIALTYSEARCH_COLLECTION.class
                    ,'MATERIALGRPSEARCH' => SBO_EnosixWarehouseStock_Search.MATERIALGRPSEARCH_COLLECTION.class
                    ,'SPECIALSTKTYSEARCH' => SBO_EnosixWarehouseStock_Search.SPECIALSTKTYSEARCH_COLLECTION.class
                    ,'POSTINGDTSEARCH' => SBO_EnosixWarehouseStock_Search.POSTINGDTSEARCH_COLLECTION.class
                    ,'MOVEMENTTYSEARCH' => SBO_EnosixWarehouseStock_Search.MOVEMENTTYSEARCH_COLLECTION.class		
                });		
        }

        public override Type getType() { return SBO_EnosixWarehouseStock_Search.EnosixWarehouseStock_SC.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixWarehouseStock_Search.registerReflectionInfo();
        }

        public EnosixWarehouseStock_SR result { get { return (EnosixWarehouseStock_SR)baseResult; } }


        @AuraEnabled public SBO_EnosixWarehouseStock_Search.SEARCHPARAMS SEARCHPARAMS 
        {
            get
            {
                return (SBO_EnosixWarehouseStock_Search.SEARCHPARAMS)this.getStruct(SBO_EnosixWarehouseStock_Search.SEARCHPARAMS.class);
            }
        }
        
            @AuraEnabled public MATERIALSEARCH_COLLECTION MATERIALSEARCH
        {
            get 
            { 
                return (MATERIALSEARCH_COLLECTION)this.getCollection(SBO_EnosixWarehouseStock_Search.MATERIALSEARCH_COLLECTION.class); 
            }
        }

                @AuraEnabled public MATDESCSEARCH_COLLECTION MATDESCSEARCH
        {
            get 
            { 
                return (MATDESCSEARCH_COLLECTION)this.getCollection(SBO_EnosixWarehouseStock_Search.MATDESCSEARCH_COLLECTION.class); 
            }
        }

                @AuraEnabled public PLANTSEARCH_COLLECTION PLANTSEARCH
        {
            get 
            { 
                return (PLANTSEARCH_COLLECTION)this.getCollection(SBO_EnosixWarehouseStock_Search.PLANTSEARCH_COLLECTION.class); 
            }
        }

                @AuraEnabled public STORAGELOCSEARCH_COLLECTION STORAGELOCSEARCH
        {
            get 
            { 
                return (STORAGELOCSEARCH_COLLECTION)this.getCollection(SBO_EnosixWarehouseStock_Search.STORAGELOCSEARCH_COLLECTION.class); 
            }
        }

                @AuraEnabled public BATCHSEARCH_COLLECTION BATCHSEARCH
        {
            get 
            { 
                return (BATCHSEARCH_COLLECTION)this.getCollection(SBO_EnosixWarehouseStock_Search.BATCHSEARCH_COLLECTION.class); 
            }
        }

                @AuraEnabled public MATERIALTYSEARCH_COLLECTION MATERIALTYSEARCH
        {
            get 
            { 
                return (MATERIALTYSEARCH_COLLECTION)this.getCollection(SBO_EnosixWarehouseStock_Search.MATERIALTYSEARCH_COLLECTION.class); 
            }
        }

                @AuraEnabled public MATERIALGRPSEARCH_COLLECTION MATERIALGRPSEARCH
        {
            get 
            { 
                return (MATERIALGRPSEARCH_COLLECTION)this.getCollection(SBO_EnosixWarehouseStock_Search.MATERIALGRPSEARCH_COLLECTION.class); 
            }
        }

                @AuraEnabled public SPECIALSTKTYSEARCH_COLLECTION SPECIALSTKTYSEARCH
        {
            get 
            { 
                return (SPECIALSTKTYSEARCH_COLLECTION)this.getCollection(SBO_EnosixWarehouseStock_Search.SPECIALSTKTYSEARCH_COLLECTION.class); 
            }
        }

                @AuraEnabled public POSTINGDTSEARCH_COLLECTION POSTINGDTSEARCH
        {
            get 
            { 
                return (POSTINGDTSEARCH_COLLECTION)this.getCollection(SBO_EnosixWarehouseStock_Search.POSTINGDTSEARCH_COLLECTION.class); 
            }
        }

                @AuraEnabled public MOVEMENTTYSEARCH_COLLECTION MOVEMENTTYSEARCH
        {
            get 
            { 
                return (MOVEMENTTYSEARCH_COLLECTION)this.getCollection(SBO_EnosixWarehouseStock_Search.MOVEMENTTYSEARCH_COLLECTION.class); 
            }
        }

            }

    public class EnosixWarehouseStock_SR extends ensxsdk.EnosixFramework.SearchResult 
    {
        public EnosixWarehouseStock_SR() 
        {
            super(new Map<string,type>{'SEARCHRESULT' => SBO_EnosixWarehouseStock_Search.SEARCHRESULT.class } );
        }
        
        public ensxsdk.EnosixFramework.FrameworkCollection SearchResults
        {
            get { return super.getCollection(SBO_EnosixWarehouseStock_Search.SEARCHRESULT.class); }
        }
        
        public List<SEARCHRESULT> getResults() 
        {
            List<SEARCHRESULT> results = new List<SEARCHRESULT>();
            SearchResults.copyTo(results);
            return results;
        }

        public override Type getType() { return SBO_EnosixWarehouseStock_Search.EnosixWarehouseStock_SR.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixWarehouseStock_Search.registerReflectionInfo();
        }
    }

    public class SEARCHPARAMS extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixWarehouseStock_Search.SEARCHPARAMS.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixWarehouseStock_Search.registerReflectionInfo();
        }
        @AuraEnabled public Boolean X_SpecialStock
        { 
            get { return this.getBoolean('X_SPECIALSTOCK'); } 
            set { this.setBoolean(value, 'X_SPECIALSTOCK'); }
        }

        @AuraEnabled public Boolean X_DisplayBatchStock
        { 
            get { return this.getBoolean('X_BATCH'); } 
            set { this.setBoolean(value, 'X_BATCH'); }
        }

        @AuraEnabled public Boolean X_DisplayNoZeroStockLines
        { 
            get { return this.getBoolean('X_NOZEROSTOCK'); } 
            set { this.setBoolean(value, 'X_NOZEROSTOCK'); }
        }

        @AuraEnabled public Integer MAXROWS
        { 
            get { return this.getInteger ('MAXROWS'); } 
            set { this.Set (value, 'MAXROWS'); }
        }

    }

public class MATERIALSEARCH extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixWarehouseStock_Search.MATERIALSEARCH.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixWarehouseStock_Search.registerReflectionInfo();
        }
        @AuraEnabled public String Sign
        { 
            get { return this.getString ('ENSX_SIGN'); } 
            set { this.Set (value, 'ENSX_SIGN'); }
        }

        @AuraEnabled public String Option
        { 
            get { return this.getString ('ENSX_OPTION'); } 
            set { this.Set (value, 'ENSX_OPTION'); }
        }

        @AuraEnabled public String Low
        { 
            get { return this.getString ('ENSX_LOW'); } 
            set { this.Set (value, 'ENSX_LOW'); }
        }

        @AuraEnabled public String High
        { 
            get { return this.getString ('ENSX_HIGH'); } 
            set { this.Set (value, 'ENSX_HIGH'); }
        }

    }

    public class MATERIALSEARCH_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public MATERIALSEARCH_COLLECTION()
        {
            super('MATERIALSEARCH', SBO_EnosixWarehouseStock_Search.MATERIALSEARCH.class, null);
        }

        public List<SBO_EnosixWarehouseStock_Search.MATERIALSEARCH> getAsList()
        {
            return (List<SBO_EnosixWarehouseStock_Search.MATERIALSEARCH>)this.buildList(List<SBO_EnosixWarehouseStock_Search.MATERIALSEARCH>.class);
        }
    }

public class MATDESCSEARCH extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixWarehouseStock_Search.MATDESCSEARCH.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixWarehouseStock_Search.registerReflectionInfo();
        }
        @AuraEnabled public String Sign
        { 
            get { return this.getString ('ENSX_SIGN'); } 
            set { this.Set (value, 'ENSX_SIGN'); }
        }

        @AuraEnabled public String Option
        { 
            get { return this.getString ('ENSX_OPTION'); } 
            set { this.Set (value, 'ENSX_OPTION'); }
        }

        @AuraEnabled public String Low
        { 
            get { return this.getString ('ENSX_LOW'); } 
            set { this.Set (value, 'ENSX_LOW'); }
        }

    }

    public class MATDESCSEARCH_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public MATDESCSEARCH_COLLECTION()
        {
            super('MATDESCSEARCH', SBO_EnosixWarehouseStock_Search.MATDESCSEARCH.class, null);
        }

        public List<SBO_EnosixWarehouseStock_Search.MATDESCSEARCH> getAsList()
        {
            return (List<SBO_EnosixWarehouseStock_Search.MATDESCSEARCH>)this.buildList(List<SBO_EnosixWarehouseStock_Search.MATDESCSEARCH>.class);
        }
    }

public class PLANTSEARCH extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixWarehouseStock_Search.PLANTSEARCH.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixWarehouseStock_Search.registerReflectionInfo();
        }
        @AuraEnabled public String Sign
        { 
            get { return this.getString ('ENSX_SIGN'); } 
            set { this.Set (value, 'ENSX_SIGN'); }
        }

        @AuraEnabled public String Option
        { 
            get { return this.getString ('ENSX_OPTION'); } 
            set { this.Set (value, 'ENSX_OPTION'); }
        }

        @AuraEnabled public String Low
        { 
            get { return this.getString ('ENSX_LOW'); } 
            set { this.Set (value, 'ENSX_LOW'); }
        }

        @AuraEnabled public String High
        { 
            get { return this.getString ('ENSX_HIGH'); } 
            set { this.Set (value, 'ENSX_HIGH'); }
        }

    }

    public class PLANTSEARCH_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public PLANTSEARCH_COLLECTION()
        {
            super('PLANTSEARCH', SBO_EnosixWarehouseStock_Search.PLANTSEARCH.class, null);
        }

        public List<SBO_EnosixWarehouseStock_Search.PLANTSEARCH> getAsList()
        {
            return (List<SBO_EnosixWarehouseStock_Search.PLANTSEARCH>)this.buildList(List<SBO_EnosixWarehouseStock_Search.PLANTSEARCH>.class);
        }
    }

public class STORAGELOCSEARCH extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixWarehouseStock_Search.STORAGELOCSEARCH.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixWarehouseStock_Search.registerReflectionInfo();
        }
        @AuraEnabled public String Sign
        { 
            get { return this.getString ('ENSX_SIGN'); } 
            set { this.Set (value, 'ENSX_SIGN'); }
        }

        @AuraEnabled public String Option
        { 
            get { return this.getString ('ENSX_OPTION'); } 
            set { this.Set (value, 'ENSX_OPTION'); }
        }

        @AuraEnabled public String Low
        { 
            get { return this.getString ('ENSX_LOW'); } 
            set { this.Set (value, 'ENSX_LOW'); }
        }

        @AuraEnabled public String High
        { 
            get { return this.getString ('ENSX_HIGH'); } 
            set { this.Set (value, 'ENSX_HIGH'); }
        }

    }

    public class STORAGELOCSEARCH_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public STORAGELOCSEARCH_COLLECTION()
        {
            super('STORAGELOCSEARCH', SBO_EnosixWarehouseStock_Search.STORAGELOCSEARCH.class, null);
        }

        public List<SBO_EnosixWarehouseStock_Search.STORAGELOCSEARCH> getAsList()
        {
            return (List<SBO_EnosixWarehouseStock_Search.STORAGELOCSEARCH>)this.buildList(List<SBO_EnosixWarehouseStock_Search.STORAGELOCSEARCH>.class);
        }
    }

public class BATCHSEARCH extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixWarehouseStock_Search.BATCHSEARCH.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixWarehouseStock_Search.registerReflectionInfo();
        }
        @AuraEnabled public String Sign
        { 
            get { return this.getString ('ENSX_SIGN'); } 
            set { this.Set (value, 'ENSX_SIGN'); }
        }

        @AuraEnabled public String Option
        { 
            get { return this.getString ('ENSX_OPTION'); } 
            set { this.Set (value, 'ENSX_OPTION'); }
        }

        @AuraEnabled public String Low
        { 
            get { return this.getString ('ENSX_LOW'); } 
            set { this.Set (value, 'ENSX_LOW'); }
        }

        @AuraEnabled public String High
        { 
            get { return this.getString ('ENSX_HIGH'); } 
            set { this.Set (value, 'ENSX_HIGH'); }
        }

    }

    public class BATCHSEARCH_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public BATCHSEARCH_COLLECTION()
        {
            super('BATCHSEARCH', SBO_EnosixWarehouseStock_Search.BATCHSEARCH.class, null);
        }

        public List<SBO_EnosixWarehouseStock_Search.BATCHSEARCH> getAsList()
        {
            return (List<SBO_EnosixWarehouseStock_Search.BATCHSEARCH>)this.buildList(List<SBO_EnosixWarehouseStock_Search.BATCHSEARCH>.class);
        }
    }

public class MATERIALTYSEARCH extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixWarehouseStock_Search.MATERIALTYSEARCH.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixWarehouseStock_Search.registerReflectionInfo();
        }
        @AuraEnabled public String Sign
        { 
            get { return this.getString ('ENSX_SIGN'); } 
            set { this.Set (value, 'ENSX_SIGN'); }
        }

        @AuraEnabled public String Option
        { 
            get { return this.getString ('ENSX_OPTION'); } 
            set { this.Set (value, 'ENSX_OPTION'); }
        }

        @AuraEnabled public String Low
        { 
            get { return this.getString ('ENSX_LOW'); } 
            set { this.Set (value, 'ENSX_LOW'); }
        }

        @AuraEnabled public String High
        { 
            get { return this.getString ('ENSX_HIGH'); } 
            set { this.Set (value, 'ENSX_HIGH'); }
        }

    }

    public class MATERIALTYSEARCH_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public MATERIALTYSEARCH_COLLECTION()
        {
            super('MATERIALTYSEARCH', SBO_EnosixWarehouseStock_Search.MATERIALTYSEARCH.class, null);
        }

        public List<SBO_EnosixWarehouseStock_Search.MATERIALTYSEARCH> getAsList()
        {
            return (List<SBO_EnosixWarehouseStock_Search.MATERIALTYSEARCH>)this.buildList(List<SBO_EnosixWarehouseStock_Search.MATERIALTYSEARCH>.class);
        }
    }

public class MATERIALGRPSEARCH extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixWarehouseStock_Search.MATERIALGRPSEARCH.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixWarehouseStock_Search.registerReflectionInfo();
        }
        @AuraEnabled public String Sign
        { 
            get { return this.getString ('ENSX_SIGN'); } 
            set { this.Set (value, 'ENSX_SIGN'); }
        }

        @AuraEnabled public String Option
        { 
            get { return this.getString ('ENSX_OPTION'); } 
            set { this.Set (value, 'ENSX_OPTION'); }
        }

        @AuraEnabled public String Low
        { 
            get { return this.getString ('ENSX_LOW'); } 
            set { this.Set (value, 'ENSX_LOW'); }
        }

        @AuraEnabled public String High
        { 
            get { return this.getString ('ENSX_HIGH'); } 
            set { this.Set (value, 'ENSX_HIGH'); }
        }

    }

    public class MATERIALGRPSEARCH_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public MATERIALGRPSEARCH_COLLECTION()
        {
            super('MATERIALGRPSEARCH', SBO_EnosixWarehouseStock_Search.MATERIALGRPSEARCH.class, null);
        }

        public List<SBO_EnosixWarehouseStock_Search.MATERIALGRPSEARCH> getAsList()
        {
            return (List<SBO_EnosixWarehouseStock_Search.MATERIALGRPSEARCH>)this.buildList(List<SBO_EnosixWarehouseStock_Search.MATERIALGRPSEARCH>.class);
        }
    }

public class SPECIALSTKTYSEARCH extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixWarehouseStock_Search.SPECIALSTKTYSEARCH.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixWarehouseStock_Search.registerReflectionInfo();
        }
        @AuraEnabled public String Sign
        { 
            get { return this.getString ('ENSX_SIGN'); } 
            set { this.Set (value, 'ENSX_SIGN'); }
        }

        @AuraEnabled public String Option
        { 
            get { return this.getString ('ENSX_OPTION'); } 
            set { this.Set (value, 'ENSX_OPTION'); }
        }

        @AuraEnabled public String Low
        { 
            get { return this.getString ('ENSX_LOW'); } 
            set { this.Set (value, 'ENSX_LOW'); }
        }

        @AuraEnabled public String High
        { 
            get { return this.getString ('ENSX_HIGH'); } 
            set { this.Set (value, 'ENSX_HIGH'); }
        }

    }

    public class SPECIALSTKTYSEARCH_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public SPECIALSTKTYSEARCH_COLLECTION()
        {
            super('SPECIALSTKTYSEARCH', SBO_EnosixWarehouseStock_Search.SPECIALSTKTYSEARCH.class, null);
        }

        public List<SBO_EnosixWarehouseStock_Search.SPECIALSTKTYSEARCH> getAsList()
        {
            return (List<SBO_EnosixWarehouseStock_Search.SPECIALSTKTYSEARCH>)this.buildList(List<SBO_EnosixWarehouseStock_Search.SPECIALSTKTYSEARCH>.class);
        }
    }

public class POSTINGDTSEARCH extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixWarehouseStock_Search.POSTINGDTSEARCH.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixWarehouseStock_Search.registerReflectionInfo();
        }
        @AuraEnabled public String Sign
        { 
            get { return this.getString ('ENSX_SIGN'); } 
            set { this.Set (value, 'ENSX_SIGN'); }
        }

        @AuraEnabled public String Option
        { 
            get { return this.getString ('ENSX_OPTION'); } 
            set { this.Set (value, 'ENSX_OPTION'); }
        }

        @AuraEnabled public Date Low
        { 
            get { return this.getDate ('ENSX_LOW'); } 
            set { this.Set (value, 'ENSX_LOW'); }
        }

        @AuraEnabled public Date High
        { 
            get { return this.getDate ('ENSX_HIGH'); } 
            set { this.Set (value, 'ENSX_HIGH'); }
        }

    }

    public class POSTINGDTSEARCH_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public POSTINGDTSEARCH_COLLECTION()
        {
            super('POSTINGDTSEARCH', SBO_EnosixWarehouseStock_Search.POSTINGDTSEARCH.class, null);
        }

        public List<SBO_EnosixWarehouseStock_Search.POSTINGDTSEARCH> getAsList()
        {
            return (List<SBO_EnosixWarehouseStock_Search.POSTINGDTSEARCH>)this.buildList(List<SBO_EnosixWarehouseStock_Search.POSTINGDTSEARCH>.class);
        }
    }

public class MOVEMENTTYSEARCH extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixWarehouseStock_Search.MOVEMENTTYSEARCH.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixWarehouseStock_Search.registerReflectionInfo();
        }
        @AuraEnabled public String Sign
        { 
            get { return this.getString ('ENSX_SIGN'); } 
            set { this.Set (value, 'ENSX_SIGN'); }
        }

        @AuraEnabled public String Option
        { 
            get { return this.getString ('ENSX_OPTION'); } 
            set { this.Set (value, 'ENSX_OPTION'); }
        }

        @AuraEnabled public String Low
        { 
            get { return this.getString ('ENSX_LOW'); } 
            set { this.Set (value, 'ENSX_LOW'); }
        }

        @AuraEnabled public String High
        { 
            get { return this.getString ('ENSX_HIGH'); } 
            set { this.Set (value, 'ENSX_HIGH'); }
        }

    }

    public class MOVEMENTTYSEARCH_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public MOVEMENTTYSEARCH_COLLECTION()
        {
            super('MOVEMENTTYSEARCH', SBO_EnosixWarehouseStock_Search.MOVEMENTTYSEARCH.class, null);
        }

        public List<SBO_EnosixWarehouseStock_Search.MOVEMENTTYSEARCH> getAsList()
        {
            return (List<SBO_EnosixWarehouseStock_Search.MOVEMENTTYSEARCH>)this.buildList(List<SBO_EnosixWarehouseStock_Search.MOVEMENTTYSEARCH>.class);
        }
    }

    public class SEARCHRESULT extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixWarehouseStock_Search.SEARCHRESULT.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixWarehouseStock_Search.registerReflectionInfo();
        }
        @AuraEnabled public String Material
        { 
            get { return this.getString ('MATNR'); } 
            set { this.Set (value, 'MATNR'); }
        }

        @AuraEnabled public String MaterialDescription
        { 
            get { return this.getString ('MAKTX'); } 
            set { this.Set (value, 'MAKTX'); }
        }

        @AuraEnabled public String Plant
        { 
            get { return this.getString ('WERKS'); } 
            set { this.Set (value, 'WERKS'); }
        }

        @AuraEnabled public String StorageLocation
        { 
            get { return this.getString ('LGORT'); } 
            set { this.Set (value, 'LGORT'); }
        }

        @AuraEnabled public String StorageLocationDescription
        { 
            get { return this.getString ('LGOBE'); } 
            set { this.Set (value, 'LGOBE'); }
        }

        @AuraEnabled public String MaterialType
        { 
            get { return this.getString ('MTART'); } 
            set { this.Set (value, 'MTART'); }
        }

        @AuraEnabled public String MaterialGroup
        { 
            get { return this.getString ('MATKL'); } 
            set { this.Set (value, 'MATKL'); }
        }

        @AuraEnabled public String SpecialStockInd
        { 
            get { return this.getString ('SOBKZ'); } 
            set { this.Set (value, 'SOBKZ'); }
        }

        @AuraEnabled public String ValuationofSpecialStock
        { 
            get { return this.getString ('KZBWS'); } 
            set { this.Set (value, 'KZBWS'); }
        }

        @AuraEnabled public String SpecialStockNumber
        { 
            get { return this.getString ('SSNUM'); } 
            set { this.Set (value, 'SSNUM'); }
        }

        @AuraEnabled public String DeletionFLag
        { 
            get { return this.getString ('LVORM'); } 
            set { this.Set (value, 'LVORM'); }
        }

        @AuraEnabled public String BatchNumber
        { 
            get { return this.getString ('CHARG'); } 
            set { this.Set (value, 'CHARG'); }
        }

        @AuraEnabled public String BaseUnitOfMeasure
        { 
            get { return this.getString ('MEINS'); } 
            set { this.Set (value, 'MEINS'); }
        }

        @AuraEnabled public String FieldCurrency
        { 
            get { return this.getString ('CURRENCY'); } 
            set { this.Set (value, 'CURRENCY'); }
        }

        @AuraEnabled public Decimal UnrestrictedStock
        { 
            get { return this.getDecimal ('UNRES_QUAN'); } 
            set { this.Set (value, 'UNRES_QUAN'); }
        }

        @AuraEnabled public Decimal UnrestrictedValue
        { 
            get { return this.getDecimal ('UNRES_VALUE'); } 
            set { this.Set (value, 'UNRES_VALUE'); }
        }

        @AuraEnabled public Decimal TransitTransferStock
        { 
            get { return this.getDecimal ('TRANSIT_QUAN'); } 
            set { this.Set (value, 'TRANSIT_QUAN'); }
        }

        @AuraEnabled public Decimal TransitTransferValue
        { 
            get { return this.getDecimal ('TRANSIT_VALUE'); } 
            set { this.Set (value, 'TRANSIT_VALUE'); }
        }

        @AuraEnabled public Decimal QualityInspectionStock
        { 
            get { return this.getDecimal ('QUALITY_QUAN'); } 
            set { this.Set (value, 'QUALITY_QUAN'); }
        }

        @AuraEnabled public Decimal QualityInspectionValue
        { 
            get { return this.getDecimal ('QUALITY_VALUE'); } 
            set { this.Set (value, 'QUALITY_VALUE'); }
        }

        @AuraEnabled public Decimal RestrictedStock
        { 
            get { return this.getDecimal ('RESTR_QUAN'); } 
            set { this.Set (value, 'RESTR_QUAN'); }
        }

        @AuraEnabled public Decimal RestrictedValue
        { 
            get { return this.getDecimal ('RESTR_VALUE'); } 
            set { this.Set (value, 'RESTR_VALUE'); }
        }

        @AuraEnabled public Decimal BlockedStock
        { 
            get { return this.getDecimal ('BLOCKED_QUAN'); } 
            set { this.Set (value, 'BLOCKED_QUAN'); }
        }

        @AuraEnabled public Decimal BlockedValue
        { 
            get { return this.getDecimal ('BLOCKED_VALUE'); } 
            set { this.Set (value, 'BLOCKED_VALUE'); }
        }

        @AuraEnabled public Decimal ReturnsStock
        { 
            get { return this.getDecimal ('RETURN_QUAN'); } 
            set { this.Set (value, 'RETURN_QUAN'); }
        }

        @AuraEnabled public Decimal ReturnsValue
        { 
            get { return this.getDecimal ('RETURN_VALUE'); } 
            set { this.Set (value, 'RETURN_VALUE'); }
        }

        @AuraEnabled public String SystemID
        { 
            get { return this.getString ('SYSTEM_ID'); } 
            set { this.Set (value, 'SYSTEM_ID'); }
        }

    }

    public class SEARCHRESULT_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public SEARCHRESULT_COLLECTION()
        {
            super('SEARCHRESULT', SBO_EnosixWarehouseStock_Search.SEARCHRESULT.class, null);
        }

        public List<SBO_EnosixWarehouseStock_Search.SEARCHRESULT> getAsList()
        {
            return (List<SBO_EnosixWarehouseStock_Search.SEARCHRESULT>)this.buildList(List<SBO_EnosixWarehouseStock_Search.SEARCHRESULT>.class);
        }
    }


}