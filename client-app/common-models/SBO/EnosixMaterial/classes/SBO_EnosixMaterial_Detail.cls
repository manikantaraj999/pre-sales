/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class SBO_EnosixMaterial_Detail extends ensxsdk.EnosixFramework.DetailSBO
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('SBO_EnosixMaterial_Detail_Meta', new Type[] {
            SBO_EnosixMaterial_Detail.EnosixMaterial.class
            , SBO_EnosixMaterial_Detail.BASIC_DATA_1.class
            , SBO_EnosixMaterial_Detail.BASIC_DATA_2.class
            , SBO_EnosixMaterial_Detail.PLANT_DATA.class
            } 
        );
    }

    public SBO_EnosixMaterial_Detail()
    {
        super('EnosixMaterial', SBO_EnosixMaterial_Detail.EnosixMaterial.class);
    }

    public override Type getType() { return SBO_EnosixMaterial_Detail.class; }

    public EnosixMaterial initialize(EnosixMaterial obj)
    {
        return (EnosixMaterial)this.executeInitialize(obj);
    }
    
    public EnosixMaterial getDetail(object key)
    {
        return (EnosixMaterial)this.executeGetDetail(key);
    }
    
    public EnosixMaterial save(EnosixMaterial obj)
    {
        return (EnosixMaterial) this.executeSave(obj);
    }

    public EnosixMaterial command(string command, EnosixMaterial obj)
    {
        return (EnosixMaterial) this.executeCommand(command, obj);
    }
    
    public with sharing class EnosixMaterial extends ensxsdk.EnosixFramework.DetailObject
    {
        public EnosixMaterial()
        {
            super('HEADER', new Map<string,type>
                {
                    'BASIC_DATA_1' => SBO_EnosixMaterial_Detail.BASIC_DATA_1.class
                    ,'BASIC_DATA_2' => SBO_EnosixMaterial_Detail.BASIC_DATA_2.class
                    ,'PLANT_DATA' => SBO_EnosixMaterial_Detail.PLANT_DATA_COLLECTION.class
                });	
        }

        public override Type getType() { return SBO_EnosixMaterial_Detail.EnosixMaterial.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixMaterial_Detail.registerReflectionInfo();
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

        @AuraEnabled public String MaterialDescriptionUpperCase
        { 
            get { return this.getString ('MAKTG'); } 
            set { this.Set (value, 'MAKTG'); }
        }


        @AuraEnabled public SBO_EnosixMaterial_Detail.BASIC_DATA_1 BASIC_DATA_1 
        {
            get
            {
                return (SBO_EnosixMaterial_Detail.BASIC_DATA_1)this.getStruct(SBO_EnosixMaterial_Detail.BASIC_DATA_1.class);
            }
        }
        
    
        @AuraEnabled public SBO_EnosixMaterial_Detail.BASIC_DATA_2 BASIC_DATA_2 
        {
            get
            {
                return (SBO_EnosixMaterial_Detail.BASIC_DATA_2)this.getStruct(SBO_EnosixMaterial_Detail.BASIC_DATA_2.class);
            }
        }
        
            @AuraEnabled public PLANT_DATA_COLLECTION PLANT_DATA
        {
            get 
            { 
                return (PLANT_DATA_COLLECTION)this.getCollection(SBO_EnosixMaterial_Detail.PLANT_DATA_COLLECTION.class); 
            }
        }

            }

    //Write child objects
        public class BASIC_DATA_1 extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixMaterial_Detail.BASIC_DATA_1.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixMaterial_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'EnosixObjKey' };
    
            return keyFields;
        }

                @AuraEnabled public String Material
        { 
            get { return this.getString ('MATNR'); } 
            set { this.Set (value, 'MATNR'); }
        }

        @AuraEnabled public String BaseUnitOfMeasure
        { 
            get { return this.getString ('MEINS'); } 
            set { this.Set (value, 'MEINS'); }
        }

        @AuraEnabled public String OldMaterialNumber
        { 
            get { return this.getString ('BISMT'); } 
            set { this.Set (value, 'BISMT'); }
        }

        @AuraEnabled public String Division
        { 
            get { return this.getString ('SPART'); } 
            set { this.Set (value, 'SPART'); }
        }

        @AuraEnabled public String AllocationDeterminationProcedure
        { 
            get { return this.getString ('KOSCH'); } 
            set { this.Set (value, 'KOSCH'); }
        }

        @AuraEnabled public String CrossPlantMaterialStatus
        { 
            get { return this.getString ('MSTAE'); } 
            set { this.Set (value, 'MSTAE'); }
        }

        @AuraEnabled public Boolean OverrideChangeNumbers
        { 
            get { return this.getBoolean('KZEFF'); } 
            set { this.setBoolean(value, 'KZEFF'); }
        }

        @AuraEnabled public String MaterialGroup
        { 
            get { return this.getString ('MATKL'); } 
            set { this.Set (value, 'MATKL'); }
        }

        @AuraEnabled public String ExternalMaterialGroup
        { 
            get { return this.getString ('EXTWG'); } 
            set { this.Set (value, 'EXTWG'); }
        }

        @AuraEnabled public String Laboratory
        { 
            get { return this.getString ('LABOR'); } 
            set { this.Set (value, 'LABOR'); }
        }

        @AuraEnabled public Date CrossPlantStatusValidDate
        { 
            get { return this.getDate ('MSTDE'); } 
            set { this.Set (value, 'MSTDE'); }
        }

        @AuraEnabled public String GeneralItemCategoryGroup
        { 
            get { return this.getString ('MTPOS_MARA'); } 
            set { this.Set (value, 'MTPOS_MARA'); }
        }

        @AuraEnabled public String AuthorizationGroup
        { 
            get { return this.getString ('BEGRU'); } 
            set { this.Set (value, 'BEGRU'); }
        }

        @AuraEnabled public Decimal GrossWeight
        { 
            get { return this.getDecimal ('BRGEW'); } 
            set { this.Set (value, 'BRGEW'); }
        }

        @AuraEnabled public String WeightUnit
        { 
            get { return this.getString ('GEWEI'); } 
            set { this.Set (value, 'GEWEI'); }
        }

        @AuraEnabled public Decimal Netweight
        { 
            get { return this.getDecimal ('NTGEW'); } 
            set { this.Set (value, 'NTGEW'); }
        }

        @AuraEnabled public Decimal Volume
        { 
            get { return this.getDecimal ('VOLUM'); } 
            set { this.Set (value, 'VOLUM'); }
        }

        @AuraEnabled public String VolumeUnit
        { 
            get { return this.getString ('VOLEH'); } 
            set { this.Set (value, 'VOLEH'); }
        }

        @AuraEnabled public String SizeDimensions
        { 
            get { return this.getString ('GROES'); } 
            set { this.Set (value, 'GROES'); }
        }

        @AuraEnabled public String ArticleNumber
        { 
            get { return this.getString ('EAN11'); } 
            set { this.Set (value, 'EAN11'); }
        }

        @AuraEnabled public String InternationalArticleNumber
        { 
            get { return this.getString ('NUMTP'); } 
            set { this.Set (value, 'NUMTP'); }
        }

        @AuraEnabled public String MaterialGroupPackagingMaterials
        { 
            get { return this.getString ('MAGRV'); } 
            set { this.Set (value, 'MAGRV'); }
        }

        @AuraEnabled public String ReferenceMaterialPackedInSameWay
        { 
            get { return this.getString ('RMATP'); } 
            set { this.Set (value, 'RMATP'); }
        }

    }
    public class BASIC_DATA_2 extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixMaterial_Detail.BASIC_DATA_2.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixMaterial_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'EnosixObjKey' };
    
            return keyFields;
        }

                @AuraEnabled public String ANSIISODescription
        { 
            get { return this.getString ('NORMT'); } 
            set { this.Set (value, 'NORMT'); }
        }

        @AuraEnabled public Boolean CADIndicator
        { 
            get { return this.getBoolean('CADKZ'); } 
            set { this.setBoolean(value, 'CADKZ'); }
        }

        @AuraEnabled public String BasicMaterial
        { 
            get { return this.getString ('WRKST'); } 
            set { this.Set (value, 'WRKST'); }
        }

        @AuraEnabled public String IntrastatDataTransportMedium
        { 
            get { return this.getString ('MEDIUM'); } 
            set { this.Set (value, 'MEDIUM'); }
        }

        @AuraEnabled public String DangerousGoodsIndicator
        { 
            get { return this.getString ('PROFL'); } 
            set { this.Set (value, 'PROFL'); }
        }

        @AuraEnabled public String DangerousGoodsPackagingStatus
        { 
            get { return this.getString ('DG_PACK_STATUS'); } 
            set { this.Set (value, 'DG_PACK_STATUS'); }
        }

        @AuraEnabled public String PackagingCode
        { 
            get { return this.getString ('PACKCODE'); } 
            set { this.Set (value, 'PACKCODE'); }
        }

        @AuraEnabled public Boolean EnvironmentallyRelevant
        { 
            get { return this.getBoolean('KZUMW'); } 
            set { this.setBoolean(value, 'KZUMW'); }
        }

        @AuraEnabled public String InBulkIndicator
        { 
            get { return this.getString ('ILOOS'); } 
            set { this.Set (value, 'ILOOS'); }
        }

        @AuraEnabled public String HighlyViscousIndicator
        { 
            get { return this.getString ('IHIVI'); } 
            set { this.Set (value, 'IHIVI'); }
        }

        @AuraEnabled public String NonDMSDocumentNumber
        { 
            get { return this.getString ('ZEINR'); } 
            set { this.Set (value, 'ZEINR'); }
        }

        @AuraEnabled public String NonDMSDocumentType
        { 
            get { return this.getString ('ZEIAR'); } 
            set { this.Set (value, 'ZEIAR'); }
        }

        @AuraEnabled public String NonDMSDocumentVersion
        { 
            get { return this.getString ('ZEIVR'); } 
            set { this.Set (value, 'ZEIVR'); }
        }

        @AuraEnabled public String NonDMSDocumentPageNumber
        { 
            get { return this.getString ('BLATT'); } 
            set { this.Set (value, 'BLATT'); }
        }

        @AuraEnabled public String NonDMSDocumentChangeNumber
        { 
            get { return this.getString ('AESZN'); } 
            set { this.Set (value, 'AESZN'); }
        }

        @AuraEnabled public String NonDMSDocumentPageFormat
        { 
            get { return this.getString ('ZEIFO'); } 
            set { this.Set (value, 'ZEIFO'); }
        }

        @AuraEnabled public String NonDMSDocumentNumberOfSheets
        { 
            get { return this.getString ('BLANZ'); } 
            set { this.Set (value, 'BLANZ'); }
        }

        @AuraEnabled public String CrossPlantConfigurableMaterial
        { 
            get { return this.getString ('SATNR'); } 
            set { this.Set (value, 'SATNR'); }
        }

        @AuraEnabled public Boolean ConfigurableMaterial
        { 
            get { return this.getBoolean('KZKFG'); } 
            set { this.setBoolean(value, 'KZKFG'); }
        }

        @AuraEnabled public Boolean GlobalDataSyncIndicator
        { 
            get { return this.getBoolean('GDS_RELEVANT'); } 
            set { this.setBoolean(value, 'GDS_RELEVANT'); }
        }

    }
    public class PLANT_DATA extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixMaterial_Detail.PLANT_DATA.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixMaterial_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'WERKS','VKORG','VTWEG' };
    
            return keyFields;
        }

                @AuraEnabled public String Plant
        { 
            get { return this.getString ('WERKS'); } 
            set { this.Set (value, 'WERKS'); }
        }

        @AuraEnabled public String Name
        { 
            get { return this.getString ('NAME1'); } 
            set { this.Set (value, 'NAME1'); }
        }

        @AuraEnabled public String SalesOrganization
        { 
            get { return this.getString ('VKORG'); } 
            set { this.Set (value, 'VKORG'); }
        }

        @AuraEnabled public String SalesOrgDescription
        { 
            get { return this.getString ('VKORG_TEXT'); } 
            set { this.Set (value, 'VKORG_TEXT'); }
        }

        @AuraEnabled public String DistributionChannel
        { 
            get { return this.getString ('VTWEG'); } 
            set { this.Set (value, 'VTWEG'); }
        }

        @AuraEnabled public String DistributionChannelDescription
        { 
            get { return this.getString ('VTWEG_TEXT'); } 
            set { this.Set (value, 'VTWEG_TEXT'); }
        }

    }
    public class PLANT_DATA_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public PLANT_DATA_COLLECTION()
        {
            super('PLANT_DATA', SBO_EnosixMaterial_Detail.PLANT_DATA.class, null);
        }

        @AuraEnabled public List<SBO_EnosixMaterial_Detail.PLANT_DATA> getAsList()
        {
            return (List<SBO_EnosixMaterial_Detail.PLANT_DATA>)this.buildList(List<SBO_EnosixMaterial_Detail.PLANT_DATA>.class);
        }
    }
}