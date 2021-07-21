/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class SBO_EnosixMaterial_Search extends ensxsdk.EnosixFramework.SearchSBO 
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('SBO_EnosixMaterial_Search_Meta', new Type[] {
            SBO_EnosixMaterial_Search.EnosixMaterial_SC.class
            , SBO_EnosixMaterial_Search.EnosixMaterial_SR.class
            , SBO_EnosixMaterial_Search.SEARCHRESULT.class
            , SBO_EnosixMaterial_Search.SEARCHPARAMS.class
            , SBO_EnosixMaterial_Search.MATERIAL_TYPE.class
            , SBO_EnosixMaterial_Search.PRODUCT_ATTRIB.class
            , SBO_EnosixMaterial_Search.SEARCHRESULT.class
            } 
        );
    }

    public SBO_EnosixMaterial_Search() 
    {
        super('EnosixMaterial', SBO_EnosixMaterial_Search.EnosixMaterial_SC.class, SBO_EnosixMaterial_Search.EnosixMaterial_SR.class);
    }
    
    public override Type getType() { return SBO_EnosixMaterial_Search.class; }

    public EnosixMaterial_SC search(EnosixMaterial_SC sc) 
    {
        return (EnosixMaterial_SC)super.executeSearch(sc);
    }

    public EnosixMaterial_SC initialize(EnosixMaterial_SC sc) 
    {
        return (EnosixMaterial_SC)super.executeInitialize(sc);
    }

    public class EnosixMaterial_SC extends ensxsdk.EnosixFramework.SearchContext 
    { 		
        public EnosixMaterial_SC() 
        {		
            super(new Map<string,type>		
                {		
                    'SEARCHPARAMS' => SBO_EnosixMaterial_Search.SEARCHPARAMS.class
                    ,'MATERIAL_TYPE' => SBO_EnosixMaterial_Search.MATERIAL_TYPE_COLLECTION.class
                    ,'PRODUCT_ATTRIB' => SBO_EnosixMaterial_Search.PRODUCT_ATTRIB_COLLECTION.class		
                });		
        }

        public override Type getType() { return SBO_EnosixMaterial_Search.EnosixMaterial_SC.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixMaterial_Search.registerReflectionInfo();
        }

        public EnosixMaterial_SR result { get { return (EnosixMaterial_SR)baseResult; } }


        @AuraEnabled public SBO_EnosixMaterial_Search.SEARCHPARAMS SEARCHPARAMS 
        {
            get
            {
                return (SBO_EnosixMaterial_Search.SEARCHPARAMS)this.getStruct(SBO_EnosixMaterial_Search.SEARCHPARAMS.class);
            }
        }
        
            @AuraEnabled public MATERIAL_TYPE_COLLECTION MATERIAL_TYPE
        {
            get 
            { 
                return (MATERIAL_TYPE_COLLECTION)this.getCollection(SBO_EnosixMaterial_Search.MATERIAL_TYPE_COLLECTION.class); 
            }
        }

                @AuraEnabled public PRODUCT_ATTRIB_COLLECTION PRODUCT_ATTRIB
        {
            get 
            { 
                return (PRODUCT_ATTRIB_COLLECTION)this.getCollection(SBO_EnosixMaterial_Search.PRODUCT_ATTRIB_COLLECTION.class); 
            }
        }

            }

    public class EnosixMaterial_SR extends ensxsdk.EnosixFramework.SearchResult 
    {
        public EnosixMaterial_SR() 
        {
            super(new Map<string,type>{'SEARCHRESULT' => SBO_EnosixMaterial_Search.SEARCHRESULT.class } );
        }
        
        public ensxsdk.EnosixFramework.FrameworkCollection SearchResults
        {
            get { return super.getCollection(SBO_EnosixMaterial_Search.SEARCHRESULT.class); }
        }
        
        public List<SEARCHRESULT> getResults() 
        {
            List<SEARCHRESULT> results = new List<SEARCHRESULT>();
            SearchResults.copyTo(results);
            return results;
        }

        public override Type getType() { return SBO_EnosixMaterial_Search.EnosixMaterial_SR.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixMaterial_Search.registerReflectionInfo();
        }
    }

    public class SEARCHPARAMS extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixMaterial_Search.SEARCHPARAMS.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixMaterial_Search.registerReflectionInfo();
        }
        @AuraEnabled public String MaterialNumberFrom
        { 
            get { return this.getString ('MATNR_FR'); } 
            set { this.Set (value, 'MATNR_FR'); }
        }

        @AuraEnabled public String MaterialNumberTo
        { 
            get { return this.getString ('MATNR_TO'); } 
            set { this.Set (value, 'MATNR_TO'); }
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

        @AuraEnabled public Date FromCreateDate
        { 
            get { return this.getDate ('ERSDA_FR'); } 
            set { this.Set (value, 'ERSDA_FR'); }
        }

        @AuraEnabled public Date ToCreateDate
        { 
            get { return this.getDate ('ERSDA_TO'); } 
            set { this.Set (value, 'ERSDA_TO'); }
        }

        @AuraEnabled public Date FromChangeDate
        { 
            get { return this.getDate ('LAEDA_FR'); } 
            set { this.Set (value, 'LAEDA_FR'); }
        }

        @AuraEnabled public Date ToChangeDate
        { 
            get { return this.getDate ('LAEDA_TO'); } 
            set { this.Set (value, 'LAEDA_TO'); }
        }

    }

public class MATERIAL_TYPE extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixMaterial_Search.MATERIAL_TYPE.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixMaterial_Search.registerReflectionInfo();
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
            super('MATERIAL_TYPE', SBO_EnosixMaterial_Search.MATERIAL_TYPE.class, null);
        }

        public List<SBO_EnosixMaterial_Search.MATERIAL_TYPE> getAsList()
        {
            return (List<SBO_EnosixMaterial_Search.MATERIAL_TYPE>)this.buildList(List<SBO_EnosixMaterial_Search.MATERIAL_TYPE>.class);
        }
    }

public class PRODUCT_ATTRIB extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixMaterial_Search.PRODUCT_ATTRIB.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixMaterial_Search.registerReflectionInfo();
        }
        @AuraEnabled public String ProductAttribute
        { 
            get { return this.getString ('PRODUCT_ATTRIB'); } 
            set { this.Set (value, 'PRODUCT_ATTRIB'); }
        }

    }

    public class PRODUCT_ATTRIB_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public PRODUCT_ATTRIB_COLLECTION()
        {
            super('PRODUCT_ATTRIB', SBO_EnosixMaterial_Search.PRODUCT_ATTRIB.class, null);
        }

        public List<SBO_EnosixMaterial_Search.PRODUCT_ATTRIB> getAsList()
        {
            return (List<SBO_EnosixMaterial_Search.PRODUCT_ATTRIB>)this.buildList(List<SBO_EnosixMaterial_Search.PRODUCT_ATTRIB>.class);
        }
    }

    public class SEARCHRESULT extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixMaterial_Search.SEARCHRESULT.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixMaterial_Search.registerReflectionInfo();
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

        @AuraEnabled public Date CreationDate
        { 
            get { return this.getDate ('ERSDA'); } 
            set { this.Set (value, 'ERSDA'); }
        }

        @AuraEnabled public Date ChangeDate
        { 
            get { return this.getDate ('LAEDA'); } 
            set { this.Set (value, 'LAEDA'); }
        }

        @AuraEnabled public String AlternateUnitOfMeasure
        { 
            get { return this.getString ('MEINH'); } 
            set { this.Set (value, 'MEINH'); }
        }

        @AuraEnabled public Decimal NumeratorForConversion
        { 
            get { return this.getDecimal ('UMREZ'); } 
            set { this.Set (value, 'UMREZ'); }
        }

        @AuraEnabled public Decimal DenominatorForConversion
        { 
            get { return this.getDecimal ('UMREN'); } 
            set { this.Set (value, 'UMREN'); }
        }

        @AuraEnabled public Decimal Quotient
        { 
            get { return this.getDecimal ('QUOTIENT'); } 
            set { this.Set (value, 'QUOTIENT'); }
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

        @AuraEnabled public Boolean ConfigurableMaterial
        { 
            get { return this.getBoolean('KZKFG'); } 
            set { this.setBoolean(value, 'KZKFG'); }
        }

    }

    public class SEARCHRESULT_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public SEARCHRESULT_COLLECTION()
        {
            super('SEARCHRESULT', SBO_EnosixMaterial_Search.SEARCHRESULT.class, null);
        }

        public List<SBO_EnosixMaterial_Search.SEARCHRESULT> getAsList()
        {
            return (List<SBO_EnosixMaterial_Search.SEARCHRESULT>)this.buildList(List<SBO_EnosixMaterial_Search.SEARCHRESULT>.class);
        }
    }


}