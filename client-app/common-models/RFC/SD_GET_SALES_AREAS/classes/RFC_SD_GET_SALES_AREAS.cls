/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:50:36 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class RFC_SD_GET_SALES_AREAS extends ensxsdk.EnosixFramework.RFC
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('RFC_SD_GET_SALES_AREAS_Meta', new Type[] {
            RFC_SD_GET_SALES_AREAS.RESULT.class
            , RFC_SD_GET_SALES_AREAS.SalesAreas.class
            } 
        );
    }

    public RFC_SD_GET_SALES_AREAS()
    {
        super('/ENSX/SD_GET_SALES_AREAS', RFC_SD_GET_SALES_AREAS.RESULT.class);
    }

    public override Type getType() { return RFC_SD_GET_SALES_AREAS.class; }

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
                'ET_SALES_AREA' => RFC_SD_GET_SALES_AREAS.SalesAreas.class
            });	
        }
        
        public override Type getType() { return RFC_SD_GET_SALES_AREAS.RESULT.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_SALES_AREAS.registerReflectionInfo();
        }

        @AuraEnabled public List<SalesAreas> SalesAreas_List
    {
        get 
        {
            List<SalesAreas> results = new List<SalesAreas>();
            this.getCollection(RFC_SD_GET_SALES_AREAS.SalesAreas.class).copyTo(results);
            return results;
        }
    }
    	
    }
    public class SalesAreas extends ensxsdk.EnosixFramework.ValueObject
    {
        public SalesAreas()
        {
            super('SalesAreas', new Map<string,type>());
        }

        public override Type getType() { return RFC_SD_GET_SALES_AREAS.SalesAreas.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_SALES_AREAS.registerReflectionInfo();
        }

                    @AuraEnabled public String SalesOrganization
        { 
            get { return this.getString ('VKORG'); } 
            set { this.Set (value, 'VKORG'); }
        }

        @AuraEnabled public String SalesOrganizationName
        { 
            get { return this.getString ('VKORG_TEXT'); } 
            set { this.Set (value, 'VKORG_TEXT'); }
        }

        @AuraEnabled public String DistributionChannel
        { 
            get { return this.getString ('VTWEG'); } 
            set { this.Set (value, 'VTWEG'); }
        }

        @AuraEnabled public String DistributionChannelName
        { 
            get { return this.getString ('VTWEG_TEXT'); } 
            set { this.Set (value, 'VTWEG_TEXT'); }
        }

        @AuraEnabled public String Division
        { 
            get { return this.getString ('SPART'); } 
            set { this.Set (value, 'SPART'); }
        }

        @AuraEnabled public String DivisionName
        { 
            get { return this.getString ('SPART_TEXT'); } 
            set { this.Set (value, 'SPART_TEXT'); }
        }

            
        }
}