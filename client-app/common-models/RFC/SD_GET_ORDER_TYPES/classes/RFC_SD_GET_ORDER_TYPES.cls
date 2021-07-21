/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:50:36 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class RFC_SD_GET_ORDER_TYPES extends ensxsdk.EnosixFramework.RFC
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('RFC_SD_GET_ORDER_TYPES_Meta', new Type[] {
            RFC_SD_GET_ORDER_TYPES.RESULT.class
            , RFC_SD_GET_ORDER_TYPES.IT_MAT.class
            , RFC_SD_GET_ORDER_TYPES.ET_ITEM_CAT.class
            , RFC_SD_GET_ORDER_TYPES.ET_MAT_ITEM_CAT.class
            , RFC_SD_GET_ORDER_TYPES.ET_VALUES.class
            } 
        );
    }

    public RFC_SD_GET_ORDER_TYPES()
    {
        super('/ENSX/SD_GET_ORDER_TYPES', RFC_SD_GET_ORDER_TYPES.RESULT.class);
    }

    public override Type getType() { return RFC_SD_GET_ORDER_TYPES.class; }

    public RESULT PARAMS
    {
        get { return (RESULT)this.getParameterContext(); }
    }

    public RESULT execute()
    {
        return (RESULT)this.executeFunction();
    }
    
    public class RESULT extends ensxsdk.EnosixFramework.FunctionObject
    {    	
        public RESULT()
        {
            super(new Map<string,type>
            {
                'IT_MAT' => RFC_SD_GET_ORDER_TYPES.IT_MAT.class
        ,'ET_ITEM_CAT' => RFC_SD_GET_ORDER_TYPES.ET_ITEM_CAT.class
        ,'ET_MAT_ITEM_CAT' => RFC_SD_GET_ORDER_TYPES.ET_MAT_ITEM_CAT.class
        ,'ET_VALUES' => RFC_SD_GET_ORDER_TYPES.ET_VALUES.class
            });	
        }
        
        public override Type getType() { return RFC_SD_GET_ORDER_TYPES.RESULT.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_ORDER_TYPES.registerReflectionInfo();
        }

        @AuraEnabled public List<IT_MAT> IT_MAT_List
    {
        get 
        {
            List<IT_MAT> results = new List<IT_MAT>();
            this.getCollection(RFC_SD_GET_ORDER_TYPES.IT_MAT.class).copyTo(results);
            return results;
        }
    }
    @AuraEnabled public List<ET_ITEM_CAT> ET_ITEM_CAT_List
    {
        get 
        {
            List<ET_ITEM_CAT> results = new List<ET_ITEM_CAT>();
            this.getCollection(RFC_SD_GET_ORDER_TYPES.ET_ITEM_CAT.class).copyTo(results);
            return results;
        }
    }
    @AuraEnabled public List<ET_MAT_ITEM_CAT> ET_MAT_ITEM_CAT_List
    {
        get 
        {
            List<ET_MAT_ITEM_CAT> results = new List<ET_MAT_ITEM_CAT>();
            this.getCollection(RFC_SD_GET_ORDER_TYPES.ET_MAT_ITEM_CAT.class).copyTo(results);
            return results;
        }
    }
    @AuraEnabled public List<ET_VALUES> ET_VALUES_List
    {
        get 
        {
            List<ET_VALUES> results = new List<ET_VALUES>();
            this.getCollection(RFC_SD_GET_ORDER_TYPES.ET_VALUES.class).copyTo(results);
            return results;
        }
    }
        @AuraEnabled public String IV_AUART
        { 
            get { return this.getString ('IV_AUART'); } 
            set { this.Set (value, 'IV_AUART'); }
        }

        @AuraEnabled public String IV_BOPROCESS
        { 
            get { return this.getString ('IV_BOPROCESS'); } 
            set { this.Set (value, 'IV_BOPROCESS'); }
        }

        @AuraEnabled public String IV_BOTYPE
        { 
            get { return this.getString ('IV_BOTYPE'); } 
            set { this.Set (value, 'IV_BOTYPE'); }
        }

        @AuraEnabled public String IV_CID
        { 
            get { return this.getString ('IV_CID'); } 
            set { this.Set (value, 'IV_CID'); }
        }

        @AuraEnabled public String IV_LANGU
        { 
            get { return this.getString ('IV_LANGU'); } 
            set { this.Set (value, 'IV_LANGU'); }
        }

        @AuraEnabled public String IV_MAT
        { 
            get { return this.getString ('IV_MAT'); } 
            set { this.Set (value, 'IV_MAT'); }
        }

        @AuraEnabled public String IV_USERNAME
        { 
            get { return this.getString ('IV_USERNAME'); } 
            set { this.Set (value, 'IV_USERNAME'); }
        }

        @AuraEnabled public String IV_VKORG
        { 
            get { return this.getString ('IV_VKORG'); } 
            set { this.Set (value, 'IV_VKORG'); }
        }

        @AuraEnabled public String IV_VTWEG
        { 
            get { return this.getString ('IV_VTWEG'); } 
            set { this.Set (value, 'IV_VTWEG'); }
        }

    	
    }
    public class IT_MAT extends ensxsdk.EnosixFramework.ValueObject
    {
        public IT_MAT()
        {
            super('IT_MAT', new Map<string,type>());
        }

        public override Type getType() { return RFC_SD_GET_ORDER_TYPES.IT_MAT.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_ORDER_TYPES.registerReflectionInfo();
        }

                    @AuraEnabled public String MaterialNumber
        { 
            get { return this.getString ('MATNR'); } 
            set { this.Set (value, 'MATNR'); }
        }

            
        }
    public class ET_ITEM_CAT extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_ITEM_CAT()
        {
            super('ET_ITEM_CAT', new Map<string,type>());
        }

        public override Type getType() { return RFC_SD_GET_ORDER_TYPES.ET_ITEM_CAT.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_ORDER_TYPES.registerReflectionInfo();
        }

                    @AuraEnabled public String DocumentType
        { 
            get { return this.getString ('AUART'); } 
            set { this.Set (value, 'AUART'); }
        }

        @AuraEnabled public String SalesItemCategory
        { 
            get { return this.getString ('PSTYV'); } 
            set { this.Set (value, 'PSTYV'); }
        }

        @AuraEnabled public String MTPOS
        { 
            get { return this.getString ('MTPOS'); } 
            set { this.Set (value, 'MTPOS'); }
        }

            
        }
    public class ET_MAT_ITEM_CAT extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_MAT_ITEM_CAT()
        {
            super('ET_MAT_ITEM_CAT', new Map<string,type>());
        }

        public override Type getType() { return RFC_SD_GET_ORDER_TYPES.ET_MAT_ITEM_CAT.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_ORDER_TYPES.registerReflectionInfo();
        }

                    @AuraEnabled public String MaterialNumber
        { 
            get { return this.getString ('MATNR'); } 
            set { this.Set (value, 'MATNR'); }
        }

        @AuraEnabled public String PSTVY
        { 
            get { return this.getString ('PSTVY'); } 
            set { this.Set (value, 'PSTVY'); }
        }

            
        }
    public class ET_VALUES extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_VALUES()
        {
            super('ET_VALUES', new Map<string,type>());
        }

        public override Type getType() { return RFC_SD_GET_ORDER_TYPES.ET_VALUES.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_ORDER_TYPES.registerReflectionInfo();
        }

                    @AuraEnabled public String VALUE
        { 
            get { return this.getString ('VALUE'); } 
            set { this.Set (value, 'VALUE'); }
        }

        @AuraEnabled public String DESCRIPTION
        { 
            get { return this.getString ('DESCRIPTION'); } 
            set { this.Set (value, 'DESCRIPTION'); }
        }

            
        }
}