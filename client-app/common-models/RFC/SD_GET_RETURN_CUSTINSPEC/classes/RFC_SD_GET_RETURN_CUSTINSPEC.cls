/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:50:36 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class RFC_SD_GET_RETURN_CUSTINSPEC extends ensxsdk.EnosixFramework.RFC
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('RFC_SD_GET_RETURN_CUSTINSPEC_Meta', new Type[] {
            RFC_SD_GET_RETURN_CUSTINSPEC.RESULT.class
            , RFC_SD_GET_RETURN_CUSTINSPEC.ET_CUST_INSPECTION.class
            , RFC_SD_GET_RETURN_CUSTINSPEC.ET_ORDER_REASON.class
            , RFC_SD_GET_RETURN_CUSTINSPEC.ET_REFUND_TYPE.class
            , RFC_SD_GET_RETURN_CUSTINSPEC.ET_RETURN_REASON.class
            } 
        );
    }

    public RFC_SD_GET_RETURN_CUSTINSPEC()
    {
        super('/ENSX/SD_GET_RETURN_CUSTINSPEC', RFC_SD_GET_RETURN_CUSTINSPEC.RESULT.class);
    }

    public override Type getType() { return RFC_SD_GET_RETURN_CUSTINSPEC.class; }

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
                'ET_CUST_INSPECTION' => RFC_SD_GET_RETURN_CUSTINSPEC.ET_CUST_INSPECTION.class
        ,'ET_ORDER_REASON' => RFC_SD_GET_RETURN_CUSTINSPEC.ET_ORDER_REASON.class
        ,'ET_REFUND_TYPE' => RFC_SD_GET_RETURN_CUSTINSPEC.ET_REFUND_TYPE.class
        ,'ET_RETURN_REASON' => RFC_SD_GET_RETURN_CUSTINSPEC.ET_RETURN_REASON.class
            });	
        }
        
        public override Type getType() { return RFC_SD_GET_RETURN_CUSTINSPEC.RESULT.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_RETURN_CUSTINSPEC.registerReflectionInfo();
        }

        @AuraEnabled public List<ET_CUST_INSPECTION> ET_CUST_INSPECTION_List
    {
        get 
        {
            List<ET_CUST_INSPECTION> results = new List<ET_CUST_INSPECTION>();
            this.getCollection(RFC_SD_GET_RETURN_CUSTINSPEC.ET_CUST_INSPECTION.class).copyTo(results);
            return results;
        }
    }
    @AuraEnabled public List<ET_ORDER_REASON> ET_ORDER_REASON_List
    {
        get 
        {
            List<ET_ORDER_REASON> results = new List<ET_ORDER_REASON>();
            this.getCollection(RFC_SD_GET_RETURN_CUSTINSPEC.ET_ORDER_REASON.class).copyTo(results);
            return results;
        }
    }
    @AuraEnabled public List<ET_REFUND_TYPE> ET_REFUND_TYPE_List
    {
        get 
        {
            List<ET_REFUND_TYPE> results = new List<ET_REFUND_TYPE>();
            this.getCollection(RFC_SD_GET_RETURN_CUSTINSPEC.ET_REFUND_TYPE.class).copyTo(results);
            return results;
        }
    }
    @AuraEnabled public List<ET_RETURN_REASON> ET_RETURN_REASON_List
    {
        get 
        {
            List<ET_RETURN_REASON> results = new List<ET_RETURN_REASON>();
            this.getCollection(RFC_SD_GET_RETURN_CUSTINSPEC.ET_RETURN_REASON.class).copyTo(results);
            return results;
        }
    }
    	
    }
    public class ET_CUST_INSPECTION extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_CUST_INSPECTION()
        {
            super('ET_CUST_INSPECTION', new Map<string,type>());
        }

        public override Type getType() { return RFC_SD_GET_RETURN_CUSTINSPEC.ET_CUST_INSPECTION.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_RETURN_CUSTINSPEC.registerReflectionInfo();
        }

                    @AuraEnabled public String CODE
        { 
            get { return this.getString ('CODE'); } 
            set { this.Set (value, 'CODE'); }
        }

        @AuraEnabled public String CODE_TEXT
        { 
            get { return this.getString ('CODE_TEXT'); } 
            set { this.Set (value, 'CODE_TEXT'); }
        }

            
        }
    public class ET_ORDER_REASON extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_ORDER_REASON()
        {
            super('ET_ORDER_REASON', new Map<string,type>());
        }

        public override Type getType() { return RFC_SD_GET_RETURN_CUSTINSPEC.ET_ORDER_REASON.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_RETURN_CUSTINSPEC.registerReflectionInfo();
        }

                    @AuraEnabled public String AUGRU
        { 
            get { return this.getString ('AUGRU'); } 
            set { this.Set (value, 'AUGRU'); }
        }

        @AuraEnabled public String BEZEI
        { 
            get { return this.getString ('BEZEI'); } 
            set { this.Set (value, 'BEZEI'); }
        }

            
        }
    public class ET_REFUND_TYPE extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_REFUND_TYPE()
        {
            super('ET_REFUND_TYPE', new Map<string,type>());
        }

        public override Type getType() { return RFC_SD_GET_RETURN_CUSTINSPEC.ET_REFUND_TYPE.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_RETURN_CUSTINSPEC.registerReflectionInfo();
        }

                    @AuraEnabled public String REFUND_TYPE
        { 
            get { return this.getString ('REFUND_TYPE'); } 
            set { this.Set (value, 'REFUND_TYPE'); }
        }

        @AuraEnabled public String REFUND_TYPE_TEXT
        { 
            get { return this.getString ('REFUND_TYPE_TEXT'); } 
            set { this.Set (value, 'REFUND_TYPE_TEXT'); }
        }

            
        }
    public class ET_RETURN_REASON extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_RETURN_REASON()
        {
            super('ET_RETURN_REASON', new Map<string,type>());
        }

        public override Type getType() { return RFC_SD_GET_RETURN_CUSTINSPEC.ET_RETURN_REASON.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_RETURN_CUSTINSPEC.registerReflectionInfo();
        }

                    @AuraEnabled public String RET_REASON
        { 
            get { return this.getString ('RET_REASON'); } 
            set { this.Set (value, 'RET_REASON'); }
        }

        @AuraEnabled public String BEZEI
        { 
            get { return this.getString ('BEZEI'); } 
            set { this.Set (value, 'BEZEI'); }
        }

            
        }
}