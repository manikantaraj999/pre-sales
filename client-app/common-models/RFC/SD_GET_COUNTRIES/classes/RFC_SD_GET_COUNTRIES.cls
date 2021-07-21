/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:50:36 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class RFC_SD_GET_COUNTRIES extends ensxsdk.EnosixFramework.RFC
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('RFC_SD_GET_COUNTRIES_Meta', new Type[] {
            RFC_SD_GET_COUNTRIES.RESULT.class
            , RFC_SD_GET_COUNTRIES.ET_OUTPUT.class
            , RFC_SD_GET_COUNTRIES.ET_REGIONS.class
            } 
        );
    }

    public RFC_SD_GET_COUNTRIES()
    {
        super('/ENSX/SD_GET_COUNTRIES', RFC_SD_GET_COUNTRIES.RESULT.class);
    }

    public override Type getType() { return RFC_SD_GET_COUNTRIES.class; }

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
                'ET_OUTPUT' => RFC_SD_GET_COUNTRIES.ET_OUTPUT.class
        ,'ET_REGIONS' => RFC_SD_GET_COUNTRIES.ET_REGIONS.class
            });	
        }
        
        public override Type getType() { return RFC_SD_GET_COUNTRIES.RESULT.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_COUNTRIES.registerReflectionInfo();
        }

        @AuraEnabled public List<ET_OUTPUT> ET_OUTPUT_List
    {
        get 
        {
            List<ET_OUTPUT> results = new List<ET_OUTPUT>();
            this.getCollection(RFC_SD_GET_COUNTRIES.ET_OUTPUT.class).copyTo(results);
            return results;
        }
    }
    @AuraEnabled public List<ET_REGIONS> ET_REGIONS_List
    {
        get 
        {
            List<ET_REGIONS> results = new List<ET_REGIONS>();
            this.getCollection(RFC_SD_GET_COUNTRIES.ET_REGIONS.class).copyTo(results);
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

        public override Type getType() { return RFC_SD_GET_COUNTRIES.ET_OUTPUT.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_COUNTRIES.registerReflectionInfo();
        }

                    @AuraEnabled public String MANDT
        { 
            get { return this.getString ('MANDT'); } 
            set { this.Set (value, 'MANDT'); }
        }

        @AuraEnabled public String SPRAS
        { 
            get { return this.getString ('SPRAS'); } 
            set { this.Set (value, 'SPRAS'); }
        }

        @AuraEnabled public String LAND1
        { 
            get { return this.getString ('LAND1'); } 
            set { this.Set (value, 'LAND1'); }
        }

        @AuraEnabled public String LANDX
        { 
            get { return this.getString ('LANDX'); } 
            set { this.Set (value, 'LANDX'); }
        }

        @AuraEnabled public String NATIO
        { 
            get { return this.getString ('NATIO'); } 
            set { this.Set (value, 'NATIO'); }
        }

        @AuraEnabled public String LANDX50
        { 
            get { return this.getString ('LANDX50'); } 
            set { this.Set (value, 'LANDX50'); }
        }

        @AuraEnabled public String NATIO50
        { 
            get { return this.getString ('NATIO50'); } 
            set { this.Set (value, 'NATIO50'); }
        }

        @AuraEnabled public String PRQ_SPREGT
        { 
            get { return this.getString ('PRQ_SPREGT'); } 
            set { this.Set (value, 'PRQ_SPREGT'); }
        }

            
        }
    public class ET_REGIONS extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_REGIONS()
        {
            super('ET_REGIONS', new Map<string,type>());
        }

        public override Type getType() { return RFC_SD_GET_COUNTRIES.ET_REGIONS.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_COUNTRIES.registerReflectionInfo();
        }

                    @AuraEnabled public String LAND1
        { 
            get { return this.getString ('LAND1'); } 
            set { this.Set (value, 'LAND1'); }
        }

        @AuraEnabled public String REGIO
        { 
            get { return this.getString ('REGIO'); } 
            set { this.Set (value, 'REGIO'); }
        }

        @AuraEnabled public String BEZEI
        { 
            get { return this.getString ('BEZEI'); } 
            set { this.Set (value, 'BEZEI'); }
        }

            
        }
}