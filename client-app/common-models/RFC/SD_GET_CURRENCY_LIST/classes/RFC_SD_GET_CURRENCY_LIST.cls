/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:50:36 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class RFC_SD_GET_CURRENCY_LIST extends ensxsdk.EnosixFramework.RFC
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('RFC_SD_GET_CURRENCY_LIST_Meta', new Type[] {
            RFC_SD_GET_CURRENCY_LIST.RESULT.class
            , RFC_SD_GET_CURRENCY_LIST.ET_CURRENCY.class
            } 
        );
    }

    public RFC_SD_GET_CURRENCY_LIST()
    {
        super('/ENSX/SD_GET_CURRENCY_LIST', RFC_SD_GET_CURRENCY_LIST.RESULT.class);
    }

    public override Type getType() { return RFC_SD_GET_CURRENCY_LIST.class; }

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
                'ET_CURRENCY' => RFC_SD_GET_CURRENCY_LIST.ET_CURRENCY.class
            });	
        }
        
        public override Type getType() { return RFC_SD_GET_CURRENCY_LIST.RESULT.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_CURRENCY_LIST.registerReflectionInfo();
        }

        @AuraEnabled public List<ET_CURRENCY> ET_CURRENCY_List
    {
        get 
        {
            List<ET_CURRENCY> results = new List<ET_CURRENCY>();
            this.getCollection(RFC_SD_GET_CURRENCY_LIST.ET_CURRENCY.class).copyTo(results);
            return results;
        }
    }
    	
    }
    public class ET_CURRENCY extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_CURRENCY()
        {
            super('ET_CURRENCY', new Map<string,type>());
        }

        public override Type getType() { return RFC_SD_GET_CURRENCY_LIST.ET_CURRENCY.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_CURRENCY_LIST.registerReflectionInfo();
        }

                    @AuraEnabled public String FieldCurrency
        { 
            get { return this.getString ('WAERS'); } 
            set { this.Set (value, 'WAERS'); }
        }

        @AuraEnabled public String LTEXT
        { 
            get { return this.getString ('LTEXT'); } 
            set { this.Set (value, 'LTEXT'); }
        }

        @AuraEnabled public String KTEXT
        { 
            get { return this.getString ('KTEXT'); } 
            set { this.Set (value, 'KTEXT'); }
        }

            
        }
}