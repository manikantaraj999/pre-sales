/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:50:36 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class RFC_SD_GET_SHIP_INFO extends ensxsdk.EnosixFramework.RFC
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('RFC_SD_GET_SHIP_INFO_Meta', new Type[] {
            RFC_SD_GET_SHIP_INFO.RESULT.class
            , RFC_SD_GET_SHIP_INFO.ET_FREIGHT_TERMS.class
            , RFC_SD_GET_SHIP_INFO.ET_PAY_TERMS.class
            , RFC_SD_GET_SHIP_INFO.ET_SHIP_COND.class
            } 
        );
    }

    public RFC_SD_GET_SHIP_INFO()
    {
        super('/ENSX/SD_GET_SHIP_INFO', RFC_SD_GET_SHIP_INFO.RESULT.class);
    }

    public override Type getType() { return RFC_SD_GET_SHIP_INFO.class; }

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
                'ET_FREIGHT_TERMS' => RFC_SD_GET_SHIP_INFO.ET_FREIGHT_TERMS.class
        ,'ET_PAY_TERMS' => RFC_SD_GET_SHIP_INFO.ET_PAY_TERMS.class
        ,'ET_SHIP_COND' => RFC_SD_GET_SHIP_INFO.ET_SHIP_COND.class
            });	
        }
        
        public override Type getType() { return RFC_SD_GET_SHIP_INFO.RESULT.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_SHIP_INFO.registerReflectionInfo();
        }

        @AuraEnabled public List<ET_FREIGHT_TERMS> ET_FREIGHT_TERMS_List
    {
        get 
        {
            List<ET_FREIGHT_TERMS> results = new List<ET_FREIGHT_TERMS>();
            this.getCollection(RFC_SD_GET_SHIP_INFO.ET_FREIGHT_TERMS.class).copyTo(results);
            return results;
        }
    }
    @AuraEnabled public List<ET_PAY_TERMS> ET_PAY_TERMS_List
    {
        get 
        {
            List<ET_PAY_TERMS> results = new List<ET_PAY_TERMS>();
            this.getCollection(RFC_SD_GET_SHIP_INFO.ET_PAY_TERMS.class).copyTo(results);
            return results;
        }
    }
    @AuraEnabled public List<ET_SHIP_COND> ET_SHIP_COND_List
    {
        get 
        {
            List<ET_SHIP_COND> results = new List<ET_SHIP_COND>();
            this.getCollection(RFC_SD_GET_SHIP_INFO.ET_SHIP_COND.class).copyTo(results);
            return results;
        }
    }
        @AuraEnabled public Boolean FREIGHT_TERMS
        { 
            get { return this.getBoolean('FREIGHT_TERMS'); } 
            set { this.setBoolean(value, 'FREIGHT_TERMS'); }
        }

        @AuraEnabled public Boolean PAY_TERMS
        { 
            get { return this.getBoolean('PAY_TERMS'); } 
            set { this.setBoolean(value, 'PAY_TERMS'); }
        }

        @AuraEnabled public Boolean SHIP_COND
        { 
            get { return this.getBoolean('SHIP_COND'); } 
            set { this.setBoolean(value, 'SHIP_COND'); }
        }

    	
    }
    public class ET_FREIGHT_TERMS extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_FREIGHT_TERMS()
        {
            super('ET_FREIGHT_TERMS', new Map<string,type>());
        }

        public override Type getType() { return RFC_SD_GET_SHIP_INFO.ET_FREIGHT_TERMS.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_SHIP_INFO.registerReflectionInfo();
        }

                    @AuraEnabled public String INCO1
        { 
            get { return this.getString ('INCO1'); } 
            set { this.Set (value, 'INCO1'); }
        }

        @AuraEnabled public String BEZEI
        { 
            get { return this.getString ('BEZEI'); } 
            set { this.Set (value, 'BEZEI'); }
        }

            
        }
    public class ET_PAY_TERMS extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_PAY_TERMS()
        {
            super('ET_PAY_TERMS', new Map<string,type>());
        }

        public override Type getType() { return RFC_SD_GET_SHIP_INFO.ET_PAY_TERMS.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_SHIP_INFO.registerReflectionInfo();
        }

                    @AuraEnabled public String ZTERM
        { 
            get { return this.getString ('ZTERM'); } 
            set { this.Set (value, 'ZTERM'); }
        }

        @AuraEnabled public String VTEXT
        { 
            get { return this.getString ('VTEXT'); } 
            set { this.Set (value, 'VTEXT'); }
        }

            
        }
    public class ET_SHIP_COND extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_SHIP_COND()
        {
            super('ET_SHIP_COND', new Map<string,type>());
        }

        public override Type getType() { return RFC_SD_GET_SHIP_INFO.ET_SHIP_COND.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_SHIP_INFO.registerReflectionInfo();
        }

                    @AuraEnabled public String ShippingConditions
        { 
            get { return this.getString ('VSBED'); } 
            set { this.Set (value, 'VSBED'); }
        }

        @AuraEnabled public String VTEXT
        { 
            get { return this.getString ('VTEXT'); } 
            set { this.Set (value, 'VTEXT'); }
        }

            
        }
}