/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:50:36 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class RFC_MM_GET_PLANT_VALUES_S4 extends ensxsdk.EnosixFramework.RFC
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('RFC_MM_GET_PLANT_VALUES_S4_Meta', new Type[] {
            RFC_MM_GET_PLANT_VALUES_S4.RESULT.class
            , RFC_MM_GET_PLANT_VALUES_S4.ET_OUTPUT.class
            } 
        );
    }

    public RFC_MM_GET_PLANT_VALUES_S4()
    {
        super('/ENSX/MM_GET_PLANT_VALUES_S4', RFC_MM_GET_PLANT_VALUES_S4.RESULT.class);
    }

    public override Type getType() { return RFC_MM_GET_PLANT_VALUES_S4.class; }

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
                'ET_OUTPUT' => RFC_MM_GET_PLANT_VALUES_S4.ET_OUTPUT.class
            });	
        }
        
        public override Type getType() { return RFC_MM_GET_PLANT_VALUES_S4.RESULT.class; }

        public override void registerReflectionForClass()
        {
            RFC_MM_GET_PLANT_VALUES_S4.registerReflectionInfo();
        }

        @AuraEnabled public List<ET_OUTPUT> ET_OUTPUT_List
    {
        get 
        {
            List<ET_OUTPUT> results = new List<ET_OUTPUT>();
            this.getCollection(RFC_MM_GET_PLANT_VALUES_S4.ET_OUTPUT.class).copyTo(results);
            return results;
        }
    }
    	
    }
    public class ET_OUTPUT extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_OUTPUT()
        {
            super('ET_OUTPUT', new Map<string,type>());
        }

        public override Type getType() { return RFC_MM_GET_PLANT_VALUES_S4.ET_OUTPUT.class; }

        public override void registerReflectionForClass()
        {
            RFC_MM_GET_PLANT_VALUES_S4.registerReflectionInfo();
        }

                    @AuraEnabled public String Plant
        { 
            get { return this.getString ('WERKS'); } 
            set { this.Set (value, 'WERKS'); }
        }

        @AuraEnabled public String PlantName
        { 
            get { return this.getString ('WERKS_NAME'); } 
            set { this.Set (value, 'WERKS_NAME'); }
        }

            
        }
}