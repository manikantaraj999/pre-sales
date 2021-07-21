/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:50:36 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class RFC_SD_GET_PERIO extends ensxsdk.EnosixFramework.RFC
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('RFC_SD_GET_PERIO_Meta', new Type[] {
            RFC_SD_GET_PERIO.RESULT.class
            , RFC_SD_GET_PERIO.OUTPUT.class
            } 
        );
    }

    public RFC_SD_GET_PERIO()
    {
        super('/ENSX/SD_GET_PERIO', RFC_SD_GET_PERIO.RESULT.class);
    }

    public override Type getType() { return RFC_SD_GET_PERIO.class; }

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
                'OUTPUT' => RFC_SD_GET_PERIO.OUTPUT.class
            });	
        }
        
        public override Type getType() { return RFC_SD_GET_PERIO.RESULT.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_PERIO.registerReflectionInfo();
        }

        @AuraEnabled public List<OUTPUT> OUTPUT_List
    {
        get 
        {
            List<OUTPUT> results = new List<OUTPUT>();
            this.getCollection(RFC_SD_GET_PERIO.OUTPUT.class).copyTo(results);
            return results;
        }
    }
    	
    }
    public class OUTPUT extends ensxsdk.EnosixFramework.ValueObject
    {
        public OUTPUT()
        {
            super('OUTPUT', new Map<string,type>());
        }

        public override Type getType() { return RFC_SD_GET_PERIO.OUTPUT.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_PERIO.registerReflectionInfo();
        }

                    @AuraEnabled public String PERIO
        { 
            get { return this.getString ('PERIO'); } 
            set { this.Set (value, 'PERIO'); }
        }

        @AuraEnabled public String BEZEICH
        { 
            get { return this.getString ('BEZEICH'); } 
            set { this.Set (value, 'BEZEICH'); }
        }

            
        }
}