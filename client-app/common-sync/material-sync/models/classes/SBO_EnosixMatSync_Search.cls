/// enosiX Inc. Generated Apex Model
/// Generated On: 8/13/2018 9:51:30 AM
/// SAP Host: From REST Service On: https://saas-platform-3158-dev-ed.cs24.my.salesforce.com
/// CID: From REST Service On: https://saas-platform-3158-dev-ed.cs24.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class SBO_EnosixMatSync_Search extends ensxsdk.EnosixFramework.SearchSBO 
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('SBO_EnosixMatSync_Search_Meta', new Type[] {
            SBO_EnosixMatSync_Search.EnosixMatSync_SC.class
            , SBO_EnosixMatSync_Search.EnosixMatSync_SR.class
            , SBO_EnosixMatSync_Search.SEARCHRESULT.class
            , SBO_EnosixMatSync_Search.SEARCHPARAMS.class
            , SBO_EnosixMatSync_Search.MATERIAL_TYPE.class
            , SBO_EnosixMatSync_Search.MATERIAL_GROUP.class
            , SBO_EnosixMatSync_Search.DIVISION.class
            , SBO_EnosixMatSync_Search.SEARCHRESULT.class
            } 
        );
    }

    public SBO_EnosixMatSync_Search() 
    {
        super('EnosixMatSync', SBO_EnosixMatSync_Search.EnosixMatSync_SC.class, SBO_EnosixMatSync_Search.EnosixMatSync_SR.class);
    }
    
    public override Type getType() { return SBO_EnosixMatSync_Search.class; }

    public EnosixMatSync_SC search(EnosixMatSync_SC sc) 
    {
        return (EnosixMatSync_SC)super.executeSearch(sc);
    }

    public EnosixMatSync_SC initialize(EnosixMatSync_SC sc) 
    {
        return (EnosixMatSync_SC)super.executeInitialize(sc);
    }

    public class EnosixMatSync_SC extends ensxsdk.EnosixFramework.SearchContext 
    { 		
        public EnosixMatSync_SC() 
        {		
            super(new Map<string,type>		
                {		
                    'SEARCHPARAMS' => SBO_EnosixMatSync_Search.SEARCHPARAMS.class
                    ,'MATERIAL_TYPE' => SBO_EnosixMatSync_Search.MATERIAL_TYPE_COLLECTION.class
                    ,'MATERIAL_GROUP' => SBO_EnosixMatSync_Search.MATERIAL_GROUP_COLLECTION.class
                    ,'DIVISION' => SBO_EnosixMatSync_Search.DIVISION_COLLECTION.class		
                });		
        }

        public override Type getType() { return SBO_EnosixMatSync_Search.EnosixMatSync_SC.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixMatSync_Search.registerReflectionInfo();
        }

        public EnosixMatSync_SR result { get { return (EnosixMatSync_SR)baseResult; } }


        @AuraEnabled public SBO_EnosixMatSync_Search.SEARCHPARAMS SEARCHPARAMS 
        {
            get
            {
                return (SBO_EnosixMatSync_Search.SEARCHPARAMS)this.getStruct(SBO_EnosixMatSync_Search.SEARCHPARAMS.class);
            }
        }
        
            @AuraEnabled public MATERIAL_TYPE_COLLECTION MATERIAL_TYPE
        {
            get 
            { 
                return (MATERIAL_TYPE_COLLECTION)this.getCollection(SBO_EnosixMatSync_Search.MATERIAL_TYPE_COLLECTION.class); 
            }
        }

                @AuraEnabled public MATERIAL_GROUP_COLLECTION MATERIAL_GROUP
        {
            get 
            { 
                return (MATERIAL_GROUP_COLLECTION)this.getCollection(SBO_EnosixMatSync_Search.MATERIAL_GROUP_COLLECTION.class); 
            }
        }

                @AuraEnabled public DIVISION_COLLECTION DIVISION
        {
            get 
            { 
                return (DIVISION_COLLECTION)this.getCollection(SBO_EnosixMatSync_Search.DIVISION_COLLECTION.class); 
            }
        }

            }

    public class EnosixMatSync_SR extends ensxsdk.EnosixFramework.SearchResult 
    {
        public EnosixMatSync_SR() 
        {
            super(new Map<string,type>{'SEARCHRESULT' => SBO_EnosixMatSync_Search.SEARCHRESULT.class } );
        }
        
        public ensxsdk.EnosixFramework.FrameworkCollection SearchResults
        {
            get { return super.getCollection(SBO_EnosixMatSync_Search.SEARCHRESULT.class); }
        }
        
        public List<SEARCHRESULT> getResults() 
        {
            List<SEARCHRESULT> results = new List<SEARCHRESULT>();
            SearchResults.copyTo(results);
            return results;
        }

        public override Type getType() { return SBO_EnosixMatSync_Search.EnosixMatSync_SR.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixMatSync_Search.registerReflectionInfo();
        }
    }

    public class SEARCHPARAMS extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixMatSync_Search.SEARCHPARAMS.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixMatSync_Search.registerReflectionInfo();
        }
        @AuraEnabled public Date DateFrom
        { 
            get { return this.getDate ('DATE_FROM'); } 
            set { this.Set (value, 'DATE_FROM'); }
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

    }

public class MATERIAL_TYPE extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixMatSync_Search.MATERIAL_TYPE.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixMatSync_Search.registerReflectionInfo();
        }
        @AuraEnabled public String MaterialType
        { 
            get { return this.getString ('MTART'); } 
            set { this.Set (value, 'MTART'); }
        }

    }

    public class MATERIAL_TYPE_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public MATERIAL_TYPE_COLLECTION()
        {
            super('MATERIAL_TYPE', SBO_EnosixMatSync_Search.MATERIAL_TYPE.class, null);
        }

        public List<SBO_EnosixMatSync_Search.MATERIAL_TYPE> getAsList()
        {
            return (List<SBO_EnosixMatSync_Search.MATERIAL_TYPE>)this.buildList(List<SBO_EnosixMatSync_Search.MATERIAL_TYPE>.class);
        }
    }

public class MATERIAL_GROUP extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixMatSync_Search.MATERIAL_GROUP.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixMatSync_Search.registerReflectionInfo();
        }
        @AuraEnabled public String MaterialGroup
        { 
            get { return this.getString ('MATKL'); } 
            set { this.Set (value, 'MATKL'); }
        }

    }

    public class MATERIAL_GROUP_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public MATERIAL_GROUP_COLLECTION()
        {
            super('MATERIAL_GROUP', SBO_EnosixMatSync_Search.MATERIAL_GROUP.class, null);
        }

        public List<SBO_EnosixMatSync_Search.MATERIAL_GROUP> getAsList()
        {
            return (List<SBO_EnosixMatSync_Search.MATERIAL_GROUP>)this.buildList(List<SBO_EnosixMatSync_Search.MATERIAL_GROUP>.class);
        }
    }

public class DIVISION extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixMatSync_Search.DIVISION.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixMatSync_Search.registerReflectionInfo();
        }
        @AuraEnabled public String Division
        { 
            get { return this.getString ('SPART'); } 
            set { this.Set (value, 'SPART'); }
        }

    }

    public class DIVISION_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public DIVISION_COLLECTION()
        {
            super('DIVISION', SBO_EnosixMatSync_Search.DIVISION.class, null);
        }

        public List<SBO_EnosixMatSync_Search.DIVISION> getAsList()
        {
            return (List<SBO_EnosixMatSync_Search.DIVISION>)this.buildList(List<SBO_EnosixMatSync_Search.DIVISION>.class);
        }
    }

    public class SEARCHRESULT extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixMatSync_Search.SEARCHRESULT.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixMatSync_Search.registerReflectionInfo();
        }
        @AuraEnabled public String DeleteIndicator
        { 
            get { return this.getString ('LVORM'); } 
            set { this.Set (value, 'LVORM'); }
        }

        @AuraEnabled public String ConfigurableMaterial
        { 
            get { return this.getString ('KZKFG'); } 
            set { this.Set (value, 'KZKFG'); }
        }

        @AuraEnabled public String MaterialType
        { 
            get { return this.getString ('MTART'); } 
            set { this.Set (value, 'MTART'); }
        }

        @AuraEnabled public String MaterialTypeDescription
        { 
            get { return this.getString ('MTART_TEXT'); } 
            set { this.Set (value, 'MTART_TEXT'); }
        }

        @AuraEnabled public String Division
        { 
            get { return this.getString ('SPART'); } 
            set { this.Set (value, 'SPART'); }
        }

        @AuraEnabled public String DivisionDescription
        { 
            get { return this.getString ('SPART_TEXT'); } 
            set { this.Set (value, 'SPART_TEXT'); }
        }

        @AuraEnabled public String MaterialGroup
        { 
            get { return this.getString ('MATKL'); } 
            set { this.Set (value, 'MATKL'); }
        }

        @AuraEnabled public String MaterialGroupDescription
        { 
            get { return this.getString ('MATKL_TEXT'); } 
            set { this.Set (value, 'MATKL_TEXT'); }
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

        @AuraEnabled public String BaseUnitOfMeasure
        { 
            get { return this.getString ('MEINS'); } 
            set { this.Set (value, 'MEINS'); }
        }

        @AuraEnabled public String SalesUnit
        { 
            get { return this.getString ('VRKME'); } 
            set { this.Set (value, 'VRKME'); }
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

        @AuraEnabled public String DistChainStatus
        { 
            get { return this.getString ('VMSTA'); } 
            set { this.Set (value, 'VMSTA'); }
        }

        @AuraEnabled public Date DistChainStatusDate
        { 
            get { return this.getDate ('VMSTD'); } 
            set { this.Set (value, 'VMSTD'); }
        }

        @AuraEnabled public String WeightUnit
        { 
            get { return this.getString ('GEWEI'); } 
            set { this.Set (value, 'GEWEI'); }
        }

    }

    public class SEARCHRESULT_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public SEARCHRESULT_COLLECTION()
        {
            super('SEARCHRESULT', SBO_EnosixMatSync_Search.SEARCHRESULT.class, null);
        }

        public List<SBO_EnosixMatSync_Search.SEARCHRESULT> getAsList()
        {
            return (List<SBO_EnosixMatSync_Search.SEARCHRESULT>)this.buildList(List<SBO_EnosixMatSync_Search.SEARCHRESULT>.class);
        }
    }


}