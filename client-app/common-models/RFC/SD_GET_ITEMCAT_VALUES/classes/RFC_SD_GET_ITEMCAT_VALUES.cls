/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:50:36 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class RFC_SD_GET_ITEMCAT_VALUES extends ensxsdk.EnosixFramework.RFC
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('RFC_SD_GET_ITEMCAT_VALUES_Meta', new Type[] {
            RFC_SD_GET_ITEMCAT_VALUES.RESULT.class
            , RFC_SD_GET_ITEMCAT_VALUES.ET_VALUES.class
            } 
        );
    }

    public RFC_SD_GET_ITEMCAT_VALUES()
    {
        super('/ENSX/SD_GET_ITEMCAT_VALUES', RFC_SD_GET_ITEMCAT_VALUES.RESULT.class);
    }

    public override Type getType() { return RFC_SD_GET_ITEMCAT_VALUES.class; }

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
                'ET_VALUES' => RFC_SD_GET_ITEMCAT_VALUES.ET_VALUES.class
            });	
        }
        
        public override Type getType() { return RFC_SD_GET_ITEMCAT_VALUES.RESULT.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_ITEMCAT_VALUES.registerReflectionInfo();
        }

        @AuraEnabled public List<ET_VALUES> ET_VALUES_List
    {
        get 
        {
            List<ET_VALUES> results = new List<ET_VALUES>();
            this.getCollection(RFC_SD_GET_ITEMCAT_VALUES.ET_VALUES.class).copyTo(results);
            return results;
        }
    }
        @AuraEnabled public String IV_AUART
        { 
            get { return this.getString ('IV_AUART'); } 
            set { this.Set (value, 'IV_AUART'); }
        }

        @AuraEnabled public String IV_LANGU
        { 
            get { return this.getString ('IV_LANGU'); } 
            set { this.Set (value, 'IV_LANGU'); }
        }

        @AuraEnabled public String IV_MATNR
        { 
            get { return this.getString ('IV_MATNR'); } 
            set { this.Set (value, 'IV_MATNR'); }
        }

        @AuraEnabled public String IV_UEPST
        { 
            get { return this.getString ('IV_UEPST'); } 
            set { this.Set (value, 'IV_UEPST'); }
        }

        @AuraEnabled public String IV_VKORG
        { 
            get { return this.getString ('IV_VKORG'); } 
            set { this.Set (value, 'IV_VKORG'); }
        }

        @AuraEnabled public String IV_VTWEG
        { 
            get { return this.getString ('IV_VTWEG'); } 
            set { this.Set (value, 'IV_VTWEG'); }
        }

    	
    }
    public class ET_VALUES extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_VALUES()
        {
            super('ET_VALUES', new Map<string,type>());
        }

        public override Type getType() { return RFC_SD_GET_ITEMCAT_VALUES.ET_VALUES.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_ITEMCAT_VALUES.registerReflectionInfo();
        }

                    @AuraEnabled public String VALUE
        { 
            get { return this.getString ('VALUE'); } 
            set { this.Set (value, 'VALUE'); }
        }

        @AuraEnabled public String DESCRIPTION
        { 
            get { return this.getString ('DESCRIPTION'); } 
            set { this.Set (value, 'DESCRIPTION'); }
        }

            
        }
}