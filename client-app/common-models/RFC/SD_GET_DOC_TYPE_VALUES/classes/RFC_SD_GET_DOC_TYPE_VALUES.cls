/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:50:36 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class RFC_SD_GET_DOC_TYPE_VALUES extends ensxsdk.EnosixFramework.RFC
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('RFC_SD_GET_DOC_TYPE_VALUES_Meta', new Type[] {
            RFC_SD_GET_DOC_TYPE_VALUES.RESULT.class
            , RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT.class
            } 
        );
    }

    public RFC_SD_GET_DOC_TYPE_VALUES()
    {
        super('/ENSX/SD_GET_DOC_TYPE_VALUES', RFC_SD_GET_DOC_TYPE_VALUES.RESULT.class);
    }

    public override Type getType() { return RFC_SD_GET_DOC_TYPE_VALUES.class; }

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
                'ET_OUTPUT' => RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT.class
            });	
        }
        
        public override Type getType() { return RFC_SD_GET_DOC_TYPE_VALUES.RESULT.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_DOC_TYPE_VALUES.registerReflectionInfo();
        }

        @AuraEnabled public List<ET_OUTPUT> ET_OUTPUT_List
    {
        get 
        {
            List<ET_OUTPUT> results = new List<ET_OUTPUT>();
            this.getCollection(RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT.class).copyTo(results);
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

        public override Type getType() { return RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT.class; }

        public override void registerReflectionForClass()
        {
            RFC_SD_GET_DOC_TYPE_VALUES.registerReflectionInfo();
        }

                    @AuraEnabled public String DocumentType
        { 
            get { return this.getString ('AUART'); } 
            set { this.Set (value, 'AUART'); }
        }

        @AuraEnabled public String BEZEI
        { 
            get { return this.getString ('BEZEI'); } 
            set { this.Set (value, 'BEZEI'); }
        }

        @AuraEnabled public String VBTYP
        { 
            get { return this.getString ('VBTYP'); } 
            set { this.Set (value, 'VBTYP'); }
        }

        @AuraEnabled public String VBTYP_TEXT
        { 
            get { return this.getString ('VBTYP_TEXT'); } 
            set { this.Set (value, 'VBTYP_TEXT'); }
        }

        @AuraEnabled public String INCPO
        { 
            get { return this.getString ('INCPO'); } 
            set { this.Set (value, 'INCPO'); }
        }

        @AuraEnabled public Boolean X_PONUM_REQUIRED
        { 
            get { return this.getBoolean('X_PONUM_REQUIRED'); } 
            set { this.setBoolean(value, 'X_PONUM_REQUIRED'); }
        }

            
        }
}