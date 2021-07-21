/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:50:36 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class RFC_SD_GET_GROUP_OFFICE extends ensxsdk.EnosixFramework.RFC
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('RFC_SD_GET_GROUP_OFFICE_Meta', new Type[] {
            RFC_SD_GET_GROUP_OFFICE.RESULT.class
            , RFC_SD_GET_GROUP_OFFICE.ET_SALES_DISTRICT.class
            , RFC_SD_GET_GROUP_OFFICE.ET_SALES_GROUP.class
            , RFC_SD_GET_GROUP_OFFICE.ET_SALES_OFFICE.class
            } 
        );
    }

    public RFC_SD_GET_GROUP_OFFICE()
    {
        super('/ENSX/SD_GET_GROUP_OFFICE', RFC_SD_GET_GROUP_OFFICE.RESULT.class);
    }

    public override Type getType() { return RFC_SD_GET_GROUP_OFFICE.class; }

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
                'ET_SALES_DISTRICT' => RFC_SD_GET_GROUP_OFFICE.ET_SALES_DISTRICT.class
        ,'ET_SALES_GROUP' => RFC_SD_GET_GROUP_OFFICE.ET_SALES_GROUP.class
        ,'ET_SALES_OFFICE' => RFC_SD_GET_GROUP_OFFICE.ET_SALES_OFFICE.class
            });	
        }
        
        public override Type getType() { return RFC_SD_GET_GROUP_OFFICE.RESULT.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_GROUP_OFFICE.registerReflectionInfo();
        }

        @AuraEnabled public List<ET_SALES_DISTRICT> ET_SALES_DISTRICT_List
    {
        get 
        {
            List<ET_SALES_DISTRICT> results = new List<ET_SALES_DISTRICT>();
            this.getCollection(RFC_SD_GET_GROUP_OFFICE.ET_SALES_DISTRICT.class).copyTo(results);
            return results;
        }
    }
    @AuraEnabled public List<ET_SALES_GROUP> ET_SALES_GROUP_List
    {
        get 
        {
            List<ET_SALES_GROUP> results = new List<ET_SALES_GROUP>();
            this.getCollection(RFC_SD_GET_GROUP_OFFICE.ET_SALES_GROUP.class).copyTo(results);
            return results;
        }
    }
    @AuraEnabled public List<ET_SALES_OFFICE> ET_SALES_OFFICE_List
    {
        get 
        {
            List<ET_SALES_OFFICE> results = new List<ET_SALES_OFFICE>();
            this.getCollection(RFC_SD_GET_GROUP_OFFICE.ET_SALES_OFFICE.class).copyTo(results);
            return results;
        }
    }
        @AuraEnabled public Boolean SALES_DISTRICT
        { 
            get { return this.getBoolean('SALES_DISTRICT'); } 
            set { this.setBoolean(value, 'SALES_DISTRICT'); }
        }

        @AuraEnabled public Boolean SALES_GROUP
        { 
            get { return this.getBoolean('SALES_GROUP'); } 
            set { this.setBoolean(value, 'SALES_GROUP'); }
        }

        @AuraEnabled public Boolean SALES_OFFICE
        { 
            get { return this.getBoolean('SALES_OFFICE'); } 
            set { this.setBoolean(value, 'SALES_OFFICE'); }
        }

    	
    }
    public class ET_SALES_DISTRICT extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_SALES_DISTRICT()
        {
            super('ET_SALES_DISTRICT', new Map<string,type>());
        }

        public override Type getType() { return RFC_SD_GET_GROUP_OFFICE.ET_SALES_DISTRICT.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_GROUP_OFFICE.registerReflectionInfo();
        }

                    @AuraEnabled public String BZIRK
        { 
            get { return this.getString ('BZIRK'); } 
            set { this.Set (value, 'BZIRK'); }
        }

        @AuraEnabled public String BZTXT
        { 
            get { return this.getString ('BZTXT'); } 
            set { this.Set (value, 'BZTXT'); }
        }

            
        }
    public class ET_SALES_GROUP extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_SALES_GROUP()
        {
            super('ET_SALES_GROUP', new Map<string,type>());
        }

        public override Type getType() { return RFC_SD_GET_GROUP_OFFICE.ET_SALES_GROUP.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_GROUP_OFFICE.registerReflectionInfo();
        }

                    @AuraEnabled public String VKBUR
        { 
            get { return this.getString ('VKBUR'); } 
            set { this.Set (value, 'VKBUR'); }
        }

        @AuraEnabled public String SalesGroup
        { 
            get { return this.getString ('VKGRP'); } 
            set { this.Set (value, 'VKGRP'); }
        }

        @AuraEnabled public String BEZEI
        { 
            get { return this.getString ('BEZEI'); } 
            set { this.Set (value, 'BEZEI'); }
        }

            
        }
    public class ET_SALES_OFFICE extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_SALES_OFFICE()
        {
            super('ET_SALES_OFFICE', new Map<string,type>());
        }

        public override Type getType() { return RFC_SD_GET_GROUP_OFFICE.ET_SALES_OFFICE.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_GROUP_OFFICE.registerReflectionInfo();
        }

                    @AuraEnabled public String SalesOrganization
        { 
            get { return this.getString ('VKORG'); } 
            set { this.Set (value, 'VKORG'); }
        }

        @AuraEnabled public String DistributionChannel
        { 
            get { return this.getString ('VTWEG'); } 
            set { this.Set (value, 'VTWEG'); }
        }

        @AuraEnabled public String Division
        { 
            get { return this.getString ('SPART'); } 
            set { this.Set (value, 'SPART'); }
        }

        @AuraEnabled public String VKBUR
        { 
            get { return this.getString ('VKBUR'); } 
            set { this.Set (value, 'VKBUR'); }
        }

        @AuraEnabled public String BEZEI
        { 
            get { return this.getString ('BEZEI'); } 
            set { this.Set (value, 'BEZEI'); }
        }

            
        }
}