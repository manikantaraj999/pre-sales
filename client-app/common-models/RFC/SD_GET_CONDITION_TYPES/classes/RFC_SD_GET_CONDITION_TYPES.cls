/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:50:36 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class RFC_SD_GET_CONDITION_TYPES extends ensxsdk.EnosixFramework.RFC
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('RFC_SD_GET_CONDITION_TYPES_Meta', new Type[] {
            RFC_SD_GET_CONDITION_TYPES.RESULT.class
            , RFC_SD_GET_CONDITION_TYPES.ET_CONDITIONS.class
            } 
        );
    }

    public RFC_SD_GET_CONDITION_TYPES()
    {
        super('/ENSX/SD_GET_CONDITION_TYPES', RFC_SD_GET_CONDITION_TYPES.RESULT.class);
    }

    public override Type getType() { return RFC_SD_GET_CONDITION_TYPES.class; }

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
                'ET_CONDITIONS' => RFC_SD_GET_CONDITION_TYPES.ET_CONDITIONS.class
            });	
        }
        
        public override Type getType() { return RFC_SD_GET_CONDITION_TYPES.RESULT.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_CONDITION_TYPES.registerReflectionInfo();
        }

        @AuraEnabled public List<ET_CONDITIONS> ET_CONDITIONS_List
    {
        get 
        {
            List<ET_CONDITIONS> results = new List<ET_CONDITIONS>();
            this.getCollection(RFC_SD_GET_CONDITION_TYPES.ET_CONDITIONS.class).copyTo(results);
            return results;
        }
    }
        @AuraEnabled public String IV_HEADER
        { 
            get { return this.getString ('IV_HEADER'); } 
            set { this.Set (value, 'IV_HEADER'); }
        }

        @AuraEnabled public String IV_KALSM
        { 
            get { return this.getString ('IV_KALSM'); } 
            set { this.Set (value, 'IV_KALSM'); }
        }

        @AuraEnabled public String IV_KAPPL
        { 
            get { return this.getString ('IV_KAPPL'); } 
            set { this.Set (value, 'IV_KAPPL'); }
        }

    	
    }
    public class ET_CONDITIONS extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_CONDITIONS()
        {
            super('ET_CONDITIONS', new Map<string,type>());
        }

        public override Type getType() { return RFC_SD_GET_CONDITION_TYPES.ET_CONDITIONS.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_CONDITION_TYPES.registerReflectionInfo();
        }

                    @AuraEnabled public String ConditionType
        { 
            get { return this.getString ('KSCHL'); } 
            set { this.Set (value, 'KSCHL'); }
        }

        @AuraEnabled public String KSCHL_TEXT
        { 
            get { return this.getString ('KSCHL_TEXT'); } 
            set { this.Set (value, 'KSCHL_TEXT'); }
        }

        @AuraEnabled public String KRECH
        { 
            get { return this.getString ('KRECH'); } 
            set { this.Set (value, 'KRECH'); }
        }

        @AuraEnabled public String KRECH_TEXT
        { 
            get { return this.getString ('KRECH_TEXT'); } 
            set { this.Set (value, 'KRECH_TEXT'); }
        }

            
        }
}