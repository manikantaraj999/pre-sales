/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:50:36 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class RFC_SD_GET_BP_ROLE_TYPE extends ensxsdk.EnosixFramework.RFC
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('RFC_SD_GET_BP_ROLE_TYPE_Meta', new Type[] {
            RFC_SD_GET_BP_ROLE_TYPE.RESULT.class
            , RFC_SD_GET_BP_ROLE_TYPE.ET_BP_CATEGORY.class
            , RFC_SD_GET_BP_ROLE_TYPE.ET_BP_ROLE.class
            , RFC_SD_GET_BP_ROLE_TYPE.ET_BP_ROLE_GROUP.class
            , RFC_SD_GET_BP_ROLE_TYPE.ET_BP_TYPE.class
            } 
        );
    }

    public RFC_SD_GET_BP_ROLE_TYPE()
    {
        super('/ENSX/SD_GET_BP_ROLE_TYPE', RFC_SD_GET_BP_ROLE_TYPE.RESULT.class);
    }

    public override Type getType() { return RFC_SD_GET_BP_ROLE_TYPE.class; }

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
                'ET_BP_CATEGORY' => RFC_SD_GET_BP_ROLE_TYPE.ET_BP_CATEGORY.class
        ,'ET_BP_ROLE' => RFC_SD_GET_BP_ROLE_TYPE.ET_BP_ROLE.class
        ,'ET_BP_ROLE_GROUP' => RFC_SD_GET_BP_ROLE_TYPE.ET_BP_ROLE_GROUP.class
        ,'ET_BP_TYPE' => RFC_SD_GET_BP_ROLE_TYPE.ET_BP_TYPE.class
            });	
        }
        
        public override Type getType() { return RFC_SD_GET_BP_ROLE_TYPE.RESULT.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_BP_ROLE_TYPE.registerReflectionInfo();
        }

        @AuraEnabled public List<ET_BP_CATEGORY> ET_BP_CATEGORY_List
    {
        get 
        {
            List<ET_BP_CATEGORY> results = new List<ET_BP_CATEGORY>();
            this.getCollection(RFC_SD_GET_BP_ROLE_TYPE.ET_BP_CATEGORY.class).copyTo(results);
            return results;
        }
    }
    @AuraEnabled public List<ET_BP_ROLE> ET_BP_ROLE_List
    {
        get 
        {
            List<ET_BP_ROLE> results = new List<ET_BP_ROLE>();
            this.getCollection(RFC_SD_GET_BP_ROLE_TYPE.ET_BP_ROLE.class).copyTo(results);
            return results;
        }
    }
    @AuraEnabled public List<ET_BP_ROLE_GROUP> ET_BP_ROLE_GROUP_List
    {
        get 
        {
            List<ET_BP_ROLE_GROUP> results = new List<ET_BP_ROLE_GROUP>();
            this.getCollection(RFC_SD_GET_BP_ROLE_TYPE.ET_BP_ROLE_GROUP.class).copyTo(results);
            return results;
        }
    }
    @AuraEnabled public List<ET_BP_TYPE> ET_BP_TYPE_List
    {
        get 
        {
            List<ET_BP_TYPE> results = new List<ET_BP_TYPE>();
            this.getCollection(RFC_SD_GET_BP_ROLE_TYPE.ET_BP_TYPE.class).copyTo(results);
            return results;
        }
    }
        @AuraEnabled public String IV_CID
        { 
            get { return this.getString ('IV_CID'); } 
            set { this.Set (value, 'IV_CID'); }
        }

    	
    }
    public class ET_BP_CATEGORY extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_BP_CATEGORY()
        {
            super('ET_BP_CATEGORY', new Map<string,type>());
        }

        public override Type getType() { return RFC_SD_GET_BP_ROLE_TYPE.ET_BP_CATEGORY.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_BP_ROLE_TYPE.registerReflectionInfo();
        }

                    @AuraEnabled public String Category
        { 
            get { return this.getString ('DOMVALUE'); } 
            set { this.Set (value, 'DOMVALUE'); }
        }

        @AuraEnabled public String Description
        { 
            get { return this.getString ('DDTEXT'); } 
            set { this.Set (value, 'DDTEXT'); }
        }

            
        }
    public class ET_BP_ROLE extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_BP_ROLE()
        {
            super('ET_BP_ROLE', new Map<string,type>());
        }

        public override Type getType() { return RFC_SD_GET_BP_ROLE_TYPE.ET_BP_ROLE.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_BP_ROLE_TYPE.registerReflectionInfo();
        }

                    @AuraEnabled public String Role
        { 
            get { return this.getString ('RLTYP'); } 
            set { this.Set (value, 'RLTYP'); }
        }

        @AuraEnabled public Boolean ForPerson
        { 
            get { return this.getBoolean('XPERS'); } 
            set { this.setBoolean(value, 'XPERS'); }
        }

        @AuraEnabled public Boolean ForOrg
        { 
            get { return this.getBoolean('XORG'); } 
            set { this.setBoolean(value, 'XORG'); }
        }

        @AuraEnabled public Boolean ForGroup
        { 
            get { return this.getBoolean('XGROUP'); } 
            set { this.setBoolean(value, 'XGROUP'); }
        }

        @AuraEnabled public String Description
        { 
            get { return this.getString ('RLTITL'); } 
            set { this.Set (value, 'RLTITL'); }
        }

            
        }
    public class ET_BP_ROLE_GROUP extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_BP_ROLE_GROUP()
        {
            super('ET_BP_ROLE_GROUP', new Map<string,type>());
        }

        public override Type getType() { return RFC_SD_GET_BP_ROLE_TYPE.ET_BP_ROLE_GROUP.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_BP_ROLE_TYPE.registerReflectionInfo();
        }

                    @AuraEnabled public String RLTGR
        { 
            get { return this.getString ('RLTGR'); } 
            set { this.Set (value, 'RLTGR'); }
        }

        @AuraEnabled public String RLTGRTXT
        { 
            get { return this.getString ('RLTGRTXT'); } 
            set { this.Set (value, 'RLTGRTXT'); }
        }

            
        }
    public class ET_BP_TYPE extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_BP_TYPE()
        {
            super('ET_BP_TYPE', new Map<string,type>());
        }

        public override Type getType() { return RFC_SD_GET_BP_ROLE_TYPE.ET_BP_TYPE.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_BP_ROLE_TYPE.registerReflectionInfo();
        }

                    @AuraEnabled public String FieldType
        { 
            get { return this.getString ('BPKIND'); } 
            set { this.Set (value, 'BPKIND'); }
        }

        @AuraEnabled public String Description
        { 
            get { return this.getString ('TEXT40'); } 
            set { this.Set (value, 'TEXT40'); }
        }

            
        }
}