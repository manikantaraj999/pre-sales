/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:50:36 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class RFC_SD_GET_PRICING_STAT extends ensxsdk.EnosixFramework.RFC
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('RFC_SD_GET_PRICING_STAT_Meta', new Type[] {
            RFC_SD_GET_PRICING_STAT.RESULT.class
            , RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_GRP.class
            , RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_LIST.class
            , RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_PROC.class
            , RFC_SD_GET_PRICING_STAT.ET_CUST_STAT_GROUP.class
            } 
        );
    }

    public RFC_SD_GET_PRICING_STAT()
    {
        super('/ENSX/SD_GET_PRICING_STAT', RFC_SD_GET_PRICING_STAT.RESULT.class);
    }

    public override Type getType() { return RFC_SD_GET_PRICING_STAT.class; }

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
                'ET_CUST_PRICE_GRP' => RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_GRP.class
        ,'ET_CUST_PRICE_LIST' => RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_LIST.class
        ,'ET_CUST_PRICE_PROC' => RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_PROC.class
        ,'ET_CUST_STAT_GROUP' => RFC_SD_GET_PRICING_STAT.ET_CUST_STAT_GROUP.class
            });	
        }
        
        public override Type getType() { return RFC_SD_GET_PRICING_STAT.RESULT.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_PRICING_STAT.registerReflectionInfo();
        }

        @AuraEnabled public List<ET_CUST_PRICE_GRP> ET_CUST_PRICE_GRP_List
    {
        get 
        {
            List<ET_CUST_PRICE_GRP> results = new List<ET_CUST_PRICE_GRP>();
            this.getCollection(RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_GRP.class).copyTo(results);
            return results;
        }
    }
    @AuraEnabled public List<ET_CUST_PRICE_LIST> ET_CUST_PRICE_LIST_List
    {
        get 
        {
            List<ET_CUST_PRICE_LIST> results = new List<ET_CUST_PRICE_LIST>();
            this.getCollection(RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_LIST.class).copyTo(results);
            return results;
        }
    }
    @AuraEnabled public List<ET_CUST_PRICE_PROC> ET_CUST_PRICE_PROC_List
    {
        get 
        {
            List<ET_CUST_PRICE_PROC> results = new List<ET_CUST_PRICE_PROC>();
            this.getCollection(RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_PROC.class).copyTo(results);
            return results;
        }
    }
    @AuraEnabled public List<ET_CUST_STAT_GROUP> ET_CUST_STAT_GROUP_List
    {
        get 
        {
            List<ET_CUST_STAT_GROUP> results = new List<ET_CUST_STAT_GROUP>();
            this.getCollection(RFC_SD_GET_PRICING_STAT.ET_CUST_STAT_GROUP.class).copyTo(results);
            return results;
        }
    }
        @AuraEnabled public Boolean PRICE_GRP
        { 
            get { return this.getBoolean('PRICE_GRP'); } 
            set { this.setBoolean(value, 'PRICE_GRP'); }
        }

        @AuraEnabled public Boolean PRICE_LIST
        { 
            get { return this.getBoolean('PRICE_LIST'); } 
            set { this.setBoolean(value, 'PRICE_LIST'); }
        }

        @AuraEnabled public Boolean PRICE_PROC
        { 
            get { return this.getBoolean('PRICE_PROC'); } 
            set { this.setBoolean(value, 'PRICE_PROC'); }
        }

        @AuraEnabled public Boolean STAT_GRP
        { 
            get { return this.getBoolean('STAT_GRP'); } 
            set { this.setBoolean(value, 'STAT_GRP'); }
        }

    	
    }
    public class ET_CUST_PRICE_GRP extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_CUST_PRICE_GRP()
        {
            super('ET_CUST_PRICE_GRP', new Map<string,type>());
        }

        public override Type getType() { return RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_GRP.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_PRICING_STAT.registerReflectionInfo();
        }

                    @AuraEnabled public String KONDA
        { 
            get { return this.getString ('KONDA'); } 
            set { this.Set (value, 'KONDA'); }
        }

        @AuraEnabled public String VTEXT
        { 
            get { return this.getString ('VTEXT'); } 
            set { this.Set (value, 'VTEXT'); }
        }

            
        }
    public class ET_CUST_PRICE_LIST extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_CUST_PRICE_LIST()
        {
            super('ET_CUST_PRICE_LIST', new Map<string,type>());
        }

        public override Type getType() { return RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_LIST.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_PRICING_STAT.registerReflectionInfo();
        }

                    @AuraEnabled public String PLTYP
        { 
            get { return this.getString ('PLTYP'); } 
            set { this.Set (value, 'PLTYP'); }
        }

        @AuraEnabled public String PTEXT
        { 
            get { return this.getString ('PTEXT'); } 
            set { this.Set (value, 'PTEXT'); }
        }

            
        }
    public class ET_CUST_PRICE_PROC extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_CUST_PRICE_PROC()
        {
            super('ET_CUST_PRICE_PROC', new Map<string,type>());
        }

        public override Type getType() { return RFC_SD_GET_PRICING_STAT.ET_CUST_PRICE_PROC.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_PRICING_STAT.registerReflectionInfo();
        }

                    @AuraEnabled public String KALKS
        { 
            get { return this.getString ('KALKS'); } 
            set { this.Set (value, 'KALKS'); }
        }

        @AuraEnabled public String VTEXT
        { 
            get { return this.getString ('VTEXT'); } 
            set { this.Set (value, 'VTEXT'); }
        }

            
        }
    public class ET_CUST_STAT_GROUP extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_CUST_STAT_GROUP()
        {
            super('ET_CUST_STAT_GROUP', new Map<string,type>());
        }

        public override Type getType() { return RFC_SD_GET_PRICING_STAT.ET_CUST_STAT_GROUP.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_PRICING_STAT.registerReflectionInfo();
        }

                    @AuraEnabled public String STGKU
        { 
            get { return this.getString ('STGKU'); } 
            set { this.Set (value, 'STGKU'); }
        }

        @AuraEnabled public String BEZEI20
        { 
            get { return this.getString ('BEZEI20'); } 
            set { this.Set (value, 'BEZEI20'); }
        }

            
        }
}