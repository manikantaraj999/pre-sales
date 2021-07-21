/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:50:36 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class RFC_MM_GET_PROD_HIERARCHY extends ensxsdk.EnosixFramework.RFC
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('RFC_MM_GET_PROD_HIERARCHY_Meta', new Type[] {
            RFC_MM_GET_PROD_HIERARCHY.RESULT.class
            , RFC_MM_GET_PROD_HIERARCHY.ET_MATERIAL_TYPE.class
            , RFC_MM_GET_PROD_HIERARCHY.ET_PRODUCT_ATTRIB.class
            , RFC_MM_GET_PROD_HIERARCHY.ET_PROD_HIERARCHY.class
            } 
        );
    }

    public RFC_MM_GET_PROD_HIERARCHY()
    {
        super('/ENSX/MM_GET_PROD_HIERARCHY', RFC_MM_GET_PROD_HIERARCHY.RESULT.class);
    }

    public override Type getType() { return RFC_MM_GET_PROD_HIERARCHY.class; }

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
                'ET_MATERIAL_TYPE' => RFC_MM_GET_PROD_HIERARCHY.ET_MATERIAL_TYPE.class
        ,'ET_PRODUCT_ATTRIB' => RFC_MM_GET_PROD_HIERARCHY.ET_PRODUCT_ATTRIB.class
        ,'ET_PROD_HIERARCHY' => RFC_MM_GET_PROD_HIERARCHY.ET_PROD_HIERARCHY.class
            });	
        }
        
        public override Type getType() { return RFC_MM_GET_PROD_HIERARCHY.RESULT.class; }

        public override void registerReflectionForClass()
        {
            RFC_MM_GET_PROD_HIERARCHY.registerReflectionInfo();
        }

        @AuraEnabled public List<ET_MATERIAL_TYPE> ET_MATERIAL_TYPE_List
    {
        get 
        {
            List<ET_MATERIAL_TYPE> results = new List<ET_MATERIAL_TYPE>();
            this.getCollection(RFC_MM_GET_PROD_HIERARCHY.ET_MATERIAL_TYPE.class).copyTo(results);
            return results;
        }
    }
    @AuraEnabled public List<ET_PRODUCT_ATTRIB> ET_PRODUCT_ATTRIB_List
    {
        get 
        {
            List<ET_PRODUCT_ATTRIB> results = new List<ET_PRODUCT_ATTRIB>();
            this.getCollection(RFC_MM_GET_PROD_HIERARCHY.ET_PRODUCT_ATTRIB.class).copyTo(results);
            return results;
        }
    }
    @AuraEnabled public List<ET_PROD_HIERARCHY> ET_PROD_HIERARCHY_List
    {
        get 
        {
            List<ET_PROD_HIERARCHY> results = new List<ET_PROD_HIERARCHY>();
            this.getCollection(RFC_MM_GET_PROD_HIERARCHY.ET_PROD_HIERARCHY.class).copyTo(results);
            return results;
        }
    }
        @AuraEnabled public String IV_LEVEL_NUMBER
        { 
            get { return this.getString ('IV_LEVEL_NUMBER'); } 
            set { this.Set (value, 'IV_LEVEL_NUMBER'); }
        }

    	
    }
    public class ET_MATERIAL_TYPE extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_MATERIAL_TYPE()
        {
            super('ET_MATERIAL_TYPE', new Map<string,type>());
        }

        public override Type getType() { return RFC_MM_GET_PROD_HIERARCHY.ET_MATERIAL_TYPE.class; }

        public override void registerReflectionForClass()
        {
            RFC_MM_GET_PROD_HIERARCHY.registerReflectionInfo();
        }

                    @AuraEnabled public String MTART
        { 
            get { return this.getString ('MTART'); } 
            set { this.Set (value, 'MTART'); }
        }

        @AuraEnabled public String MTBEZ
        { 
            get { return this.getString ('MTBEZ'); } 
            set { this.Set (value, 'MTBEZ'); }
        }

            
        }
    public class ET_PRODUCT_ATTRIB extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_PRODUCT_ATTRIB()
        {
            super('ET_PRODUCT_ATTRIB', new Map<string,type>());
        }

        public override Type getType() { return RFC_MM_GET_PROD_HIERARCHY.ET_PRODUCT_ATTRIB.class; }

        public override void registerReflectionForClass()
        {
            RFC_MM_GET_PROD_HIERARCHY.registerReflectionInfo();
        }

                    @AuraEnabled public String PRODUCT_ATTRIB
        { 
            get { return this.getString ('PRODUCT_ATTRIB'); } 
            set { this.Set (value, 'PRODUCT_ATTRIB'); }
        }

            
        }
    public class ET_PROD_HIERARCHY extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_PROD_HIERARCHY()
        {
            super('ET_PROD_HIERARCHY', new Map<string,type>());
        }

        public override Type getType() { return RFC_MM_GET_PROD_HIERARCHY.ET_PROD_HIERARCHY.class; }

        public override void registerReflectionForClass()
        {
            RFC_MM_GET_PROD_HIERARCHY.registerReflectionInfo();
        }

                    @AuraEnabled public String PRODH
        { 
            get { return this.getString ('PRODH'); } 
            set { this.Set (value, 'PRODH'); }
        }

        @AuraEnabled public String STUFE
        { 
            get { return this.getString ('STUFE'); } 
            set { this.Set (value, 'STUFE'); }
        }

        @AuraEnabled public String VTEXT
        { 
            get { return this.getString ('VTEXT'); } 
            set { this.Set (value, 'VTEXT'); }
        }

            
        }
}