/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class SBO_SFCIMaterial_Search extends ensxsdk.EnosixFramework.SearchSBO 
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('SBO_SFCIMaterial_Search_Meta', new Type[] {
            SBO_SFCIMaterial_Search.SFCIMaterial_SC.class
            , SBO_SFCIMaterial_Search.SFCIMaterial_SR.class
            , SBO_SFCIMaterial_Search.SEARCHRESULT.class
            , SBO_SFCIMaterial_Search.SEARCHPARAMS.class
            , SBO_SFCIMaterial_Search.MATERIAL_TYPE.class
            , SBO_SFCIMaterial_Search.CUSTOM.class
            , SBO_SFCIMaterial_Search.SEARCHRESULT.class
            } 
        );
    }

    public SBO_SFCIMaterial_Search() 
    {
        super('SFCIMaterial', SBO_SFCIMaterial_Search.SFCIMaterial_SC.class, SBO_SFCIMaterial_Search.SFCIMaterial_SR.class);
    }
    
    public override Type getType() { return SBO_SFCIMaterial_Search.class; }

    public SFCIMaterial_SC search(SFCIMaterial_SC sc) 
    {
        return (SFCIMaterial_SC)super.executeSearch(sc);
    }

    public SFCIMaterial_SC initialize(SFCIMaterial_SC sc) 
    {
        return (SFCIMaterial_SC)super.executeInitialize(sc);
    }

    public class SFCIMaterial_SC extends ensxsdk.EnosixFramework.SearchContext 
    { 		
        public SFCIMaterial_SC() 
        {		
            super(new Map<string,type>		
                {		
                    'SEARCHPARAMS' => SBO_SFCIMaterial_Search.SEARCHPARAMS.class
                    ,'MATERIAL_TYPE' => SBO_SFCIMaterial_Search.MATERIAL_TYPE_COLLECTION.class
                    ,'CUSTOM' => SBO_SFCIMaterial_Search.CUSTOM_COLLECTION.class		
                });		
        }

        public override Type getType() { return SBO_SFCIMaterial_Search.SFCIMaterial_SC.class; }

        public override void registerReflectionForClass()
        {
            SBO_SFCIMaterial_Search.registerReflectionInfo();
        }

        public SFCIMaterial_SR result { get { return (SFCIMaterial_SR)baseResult; } }


        @AuraEnabled public SBO_SFCIMaterial_Search.SEARCHPARAMS SEARCHPARAMS 
        {
            get
            {
                return (SBO_SFCIMaterial_Search.SEARCHPARAMS)this.getStruct(SBO_SFCIMaterial_Search.SEARCHPARAMS.class);
            }
        }
        
            @AuraEnabled public MATERIAL_TYPE_COLLECTION MATERIAL_TYPE
        {
            get 
            { 
                return (MATERIAL_TYPE_COLLECTION)this.getCollection(SBO_SFCIMaterial_Search.MATERIAL_TYPE_COLLECTION.class); 
            }
        }

                @AuraEnabled public CUSTOM_COLLECTION CUSTOM
        {
            get 
            { 
                return (CUSTOM_COLLECTION)this.getCollection(SBO_SFCIMaterial_Search.CUSTOM_COLLECTION.class); 
            }
        }

            }

    public class SFCIMaterial_SR extends ensxsdk.EnosixFramework.SearchResult 
    {
        public SFCIMaterial_SR() 
        {
            super(new Map<string,type>{'SEARCHRESULT' => SBO_SFCIMaterial_Search.SEARCHRESULT.class } );
        }
        
        public ensxsdk.EnosixFramework.FrameworkCollection SearchResults
        {
            get { return super.getCollection(SBO_SFCIMaterial_Search.SEARCHRESULT.class); }
        }
        
        public List<SEARCHRESULT> getResults() 
        {
            List<SEARCHRESULT> results = new List<SEARCHRESULT>();
            SearchResults.copyTo(results);
            return results;
        }

        public override Type getType() { return SBO_SFCIMaterial_Search.SFCIMaterial_SR.class; }

        public override void registerReflectionForClass()
        {
            SBO_SFCIMaterial_Search.registerReflectionInfo();
        }
    }

    public class SEARCHPARAMS extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_SFCIMaterial_Search.SEARCHPARAMS.class; }

        public override void registerReflectionForClass()
        {
            SBO_SFCIMaterial_Search.registerReflectionInfo();
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

        @AuraEnabled public String MaterialGroup
        { 
            get { return this.getString ('MATKL'); } 
            set { this.Set (value, 'MATKL'); }
        }

        @AuraEnabled public String ProductHierarchy
        { 
            get { return this.getString ('PRODH'); } 
            set { this.Set (value, 'PRODH'); }
        }

        @AuraEnabled public String CrossPlantMaterialStatus
        { 
            get { return this.getString ('MSTAE'); } 
            set { this.Set (value, 'MSTAE'); }
        }

        @AuraEnabled public Date FromCreatedDate
        { 
            get { return this.getDate ('ERSDA_FR'); } 
            set { this.Set (value, 'ERSDA_FR'); }
        }

        @AuraEnabled public Date ToCreatedDate
        { 
            get { return this.getDate ('ERSDA_TO'); } 
            set { this.Set (value, 'ERSDA_TO'); }
        }

        @AuraEnabled public Date FromLastChangeDate
        { 
            get { return this.getDate ('LAEDA_FR'); } 
            set { this.Set (value, 'LAEDA_FR'); }
        }

        @AuraEnabled public Date ToLastChangeDate
        { 
            get { return this.getDate ('LAEDA_TO'); } 
            set { this.Set (value, 'LAEDA_TO'); }
        }

        @AuraEnabled public Boolean NoSalesDataFlag
        { 
            get { return this.getBoolean('SALES_FLAG'); } 
            set { this.setBoolean(value, 'SALES_FLAG'); }
        }

    }

public class MATERIAL_TYPE extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_SFCIMaterial_Search.MATERIAL_TYPE.class; }

        public override void registerReflectionForClass()
        {
            SBO_SFCIMaterial_Search.registerReflectionInfo();
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
            super('MATERIAL_TYPE', SBO_SFCIMaterial_Search.MATERIAL_TYPE.class, null);
        }

        public List<SBO_SFCIMaterial_Search.MATERIAL_TYPE> getAsList()
        {
            return (List<SBO_SFCIMaterial_Search.MATERIAL_TYPE>)this.buildList(List<SBO_SFCIMaterial_Search.MATERIAL_TYPE>.class);
        }
    }

public class CUSTOM extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_SFCIMaterial_Search.CUSTOM.class; }

        public override void registerReflectionForClass()
        {
            SBO_SFCIMaterial_Search.registerReflectionInfo();
        }
        @AuraEnabled public String FIELD
        { 
            get { return this.getString ('FIELD'); } 
            set { this.Set (value, 'FIELD'); }
        }

        @AuraEnabled public String VALUE
        { 
            get { return this.getString ('VALUE'); } 
            set { this.Set (value, 'VALUE'); }
        }

    }

    public class CUSTOM_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public CUSTOM_COLLECTION()
        {
            super('CUSTOM', SBO_SFCIMaterial_Search.CUSTOM.class, null);
        }

        public List<SBO_SFCIMaterial_Search.CUSTOM> getAsList()
        {
            return (List<SBO_SFCIMaterial_Search.CUSTOM>)this.buildList(List<SBO_SFCIMaterial_Search.CUSTOM>.class);
        }
    }

    public class SEARCHRESULT extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_SFCIMaterial_Search.SEARCHRESULT.class; }

        public override void registerReflectionForClass()
        {
            SBO_SFCIMaterial_Search.registerReflectionInfo();
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

        @AuraEnabled public String MaterialType
        { 
            get { return this.getString ('MTART'); } 
            set { this.Set (value, 'MTART'); }
        }

        @AuraEnabled public String MaterialTypeDescription
        { 
            get { return this.getString ('MTART_MTBEZ'); } 
            set { this.Set (value, 'MTART_MTBEZ'); }
        }

        @AuraEnabled public String MaterialGroup
        { 
            get { return this.getString ('MATKL'); } 
            set { this.Set (value, 'MATKL'); }
        }

        @AuraEnabled public String MaterialGroupDescription
        { 
            get { return this.getString ('WGBEZ'); } 
            set { this.Set (value, 'WGBEZ'); }
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

        @AuraEnabled public String ProductHierarchy
        { 
            get { return this.getString ('PRODH'); } 
            set { this.Set (value, 'PRODH'); }
        }

        @AuraEnabled public String ProductHierarchyDescription
        { 
            get { return this.getString ('PRODH_TEXT'); } 
            set { this.Set (value, 'PRODH_TEXT'); }
        }

        @AuraEnabled public String CrossPlantMaterialStatus
        { 
            get { return this.getString ('MSTAE'); } 
            set { this.Set (value, 'MSTAE'); }
        }

        @AuraEnabled public String MaterialStatusDescription
        { 
            get { return this.getString ('MTSTB'); } 
            set { this.Set (value, 'MTSTB'); }
        }

        @AuraEnabled public Date CreatedDate
        { 
            get { return this.getDate ('ERSDA'); } 
            set { this.Set (value, 'ERSDA'); }
        }

        @AuraEnabled public Date LastChangeDate
        { 
            get { return this.getDate ('LAEDA'); } 
            set { this.Set (value, 'LAEDA'); }
        }

        @AuraEnabled public String BaseUnitOfMeasure
        { 
            get { return this.getString ('MEINS'); } 
            set { this.Set (value, 'MEINS'); }
        }

        @AuraEnabled public String BaseUoMDescription
        { 
            get { return this.getString ('MEINS_TEXT'); } 
            set { this.Set (value, 'MEINS_TEXT'); }
        }

        @AuraEnabled public String CUSTOM01
        { 
            get { return this.getString ('CUSTOM01'); } 
            set { this.Set (value, 'CUSTOM01'); }
        }

        @AuraEnabled public String CUSTOM02
        { 
            get { return this.getString ('CUSTOM02'); } 
            set { this.Set (value, 'CUSTOM02'); }
        }

        @AuraEnabled public String CUSTOM03
        { 
            get { return this.getString ('CUSTOM03'); } 
            set { this.Set (value, 'CUSTOM03'); }
        }

        @AuraEnabled public String CUSTOM04
        { 
            get { return this.getString ('CUSTOM04'); } 
            set { this.Set (value, 'CUSTOM04'); }
        }

        @AuraEnabled public String CUSTOM05
        { 
            get { return this.getString ('CUSTOM05'); } 
            set { this.Set (value, 'CUSTOM05'); }
        }

        @AuraEnabled public String CUSTOM06
        { 
            get { return this.getString ('CUSTOM06'); } 
            set { this.Set (value, 'CUSTOM06'); }
        }

        @AuraEnabled public String CUSTOM07
        { 
            get { return this.getString ('CUSTOM07'); } 
            set { this.Set (value, 'CUSTOM07'); }
        }

        @AuraEnabled public String CUSTOM08
        { 
            get { return this.getString ('CUSTOM08'); } 
            set { this.Set (value, 'CUSTOM08'); }
        }

        @AuraEnabled public String CUSTOM09
        { 
            get { return this.getString ('CUSTOM09'); } 
            set { this.Set (value, 'CUSTOM09'); }
        }

        @AuraEnabled public String CUSTOM10
        { 
            get { return this.getString ('CUSTOM10'); } 
            set { this.Set (value, 'CUSTOM10'); }
        }

    }

    public class SEARCHRESULT_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public SEARCHRESULT_COLLECTION()
        {
            super('SEARCHRESULT', SBO_SFCIMaterial_Search.SEARCHRESULT.class, null);
        }

        public List<SBO_SFCIMaterial_Search.SEARCHRESULT> getAsList()
        {
            return (List<SBO_SFCIMaterial_Search.SEARCHRESULT>)this.buildList(List<SBO_SFCIMaterial_Search.SEARCHRESULT>.class);
        }
    }


}