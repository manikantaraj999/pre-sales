/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:50:36 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class RFC_SD_GET_CONDITION_GROUP extends ensxsdk.EnosixFramework.RFC
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('RFC_SD_GET_CONDITION_GROUP_Meta', new Type[] {
            RFC_SD_GET_CONDITION_GROUP.RESULT.class
            , RFC_SD_GET_CONDITION_GROUP.ET_COND_GROUP.class
            } 
        );
    }

    public RFC_SD_GET_CONDITION_GROUP()
    {
        super('/ENSX/SD_GET_CONDITION_GROUP', RFC_SD_GET_CONDITION_GROUP.RESULT.class);
    }

    public override Type getType() { return RFC_SD_GET_CONDITION_GROUP.class; }

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
                'ET_COND_GROUP' => RFC_SD_GET_CONDITION_GROUP.ET_COND_GROUP.class
            });	
        }
        
        public override Type getType() { return RFC_SD_GET_CONDITION_GROUP.RESULT.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_CONDITION_GROUP.registerReflectionInfo();
        }

        @AuraEnabled public List<ET_COND_GROUP> ET_COND_GROUP_List
    {
        get 
        {
            List<ET_COND_GROUP> results = new List<ET_COND_GROUP>();
            this.getCollection(RFC_SD_GET_CONDITION_GROUP.ET_COND_GROUP.class).copyTo(results);
            return results;
        }
    }
    	
    }
    public class ET_COND_GROUP extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_COND_GROUP()
        {
            super('ET_COND_GROUP', new Map<string,type>());
        }

        public override Type getType() { return RFC_SD_GET_CONDITION_GROUP.ET_COND_GROUP.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_CONDITION_GROUP.registerReflectionInfo();
        }

                    @AuraEnabled public String KDKGR
        { 
            get { return this.getString ('KDKGR'); } 
            set { this.Set (value, 'KDKGR'); }
        }

        @AuraEnabled public String VTEXT
        { 
            get { return this.getString ('VTEXT'); } 
            set { this.Set (value, 'VTEXT'); }
        }

            
        }
}