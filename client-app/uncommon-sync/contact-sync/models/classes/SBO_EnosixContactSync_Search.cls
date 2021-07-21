/// enosiX Inc. Generated Apex Model
/// Generated On: 2/18/2019 5:30:54 PM
/// SAP Host: From REST Service On: https://app-speed-4607-dev-ed.cs11.my.salesforce.com
/// CID: From REST Service On: https://app-speed-4607-dev-ed.cs11.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class SBO_EnosixContactSync_Search extends ensxsdk.EnosixFramework.SearchSBO 
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('SBO_EnosixContactSync_Search_Meta', new Type[] {
            SBO_EnosixContactSync_Search.EnosixContactSync_SC.class
            , SBO_EnosixContactSync_Search.EnosixContactSync_SR.class
            , SBO_EnosixContactSync_Search.SEARCHRESULT.class
            , SBO_EnosixContactSync_Search.SEARCHPARAMS.class
            , SBO_EnosixContactSync_Search.SEARCHRESULT.class
            } 
        );
    }

    public SBO_EnosixContactSync_Search() 
    {
        super('EnosixContactSync', SBO_EnosixContactSync_Search.EnosixContactSync_SC.class, SBO_EnosixContactSync_Search.EnosixContactSync_SR.class);
    }
    
    public override Type getType() { return SBO_EnosixContactSync_Search.class; }

    public EnosixContactSync_SC search(EnosixContactSync_SC sc) 
    {
        return (EnosixContactSync_SC)super.executeSearch(sc);
    }

    public EnosixContactSync_SC initialize(EnosixContactSync_SC sc) 
    {
        return (EnosixContactSync_SC)super.executeInitialize(sc);
    }

    public class EnosixContactSync_SC extends ensxsdk.EnosixFramework.SearchContext 
    { 		
        public EnosixContactSync_SC() 
        {		
            super(new Map<string,type>		
                {		
                    'SEARCHPARAMS' => SBO_EnosixContactSync_Search.SEARCHPARAMS.class		
                });		
        }

        public override Type getType() { return SBO_EnosixContactSync_Search.EnosixContactSync_SC.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixContactSync_Search.registerReflectionInfo();
        }

        public EnosixContactSync_SR result { get { return (EnosixContactSync_SR)baseResult; } }


        @AuraEnabled public SBO_EnosixContactSync_Search.SEARCHPARAMS SEARCHPARAMS 
        {
            get
            {
                return (SBO_EnosixContactSync_Search.SEARCHPARAMS)this.getStruct(SBO_EnosixContactSync_Search.SEARCHPARAMS.class);
            }
        }
        
        }

    public class EnosixContactSync_SR extends ensxsdk.EnosixFramework.SearchResult 
    {
        public EnosixContactSync_SR() 
        {
            super(new Map<string,type>{'SEARCHRESULT' => SBO_EnosixContactSync_Search.SEARCHRESULT.class } );
        }
        
        public ensxsdk.EnosixFramework.FrameworkCollection SearchResults
        {
            get { return super.getCollection(SBO_EnosixContactSync_Search.SEARCHRESULT.class); }
        }
        
        public List<SEARCHRESULT> getResults() 
        {
            List<SEARCHRESULT> results = new List<SEARCHRESULT>();
            SearchResults.copyTo(results);
            return results;
        }

        public override Type getType() { return SBO_EnosixContactSync_Search.EnosixContactSync_SR.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixContactSync_Search.registerReflectionInfo();
        }
    }

    public class SEARCHPARAMS extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixContactSync_Search.SEARCHPARAMS.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixContactSync_Search.registerReflectionInfo();
        }
        @AuraEnabled public Date DateFrom
        { 
            get { return this.getDate ('DATE_FROM'); } 
            set { this.Set (value, 'DATE_FROM'); }
        }

        @AuraEnabled public Boolean InitialLoad
        { 
            get { return this.getBoolean('X_INITIALLOAD'); } 
            set { this.setBoolean(value, 'X_INITIALLOAD'); }
        }

    }

    public class SEARCHRESULT extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixContactSync_Search.SEARCHRESULT.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixContactSync_Search.registerReflectionInfo();
        }
        @AuraEnabled public String ContactPersonNumber
        { 
            get { return this.getString ('CONTACT_PERSON'); } 
            set { this.Set (value, 'CONTACT_PERSON'); }
        }

        @AuraEnabled public String CustomerNumber
        { 
            get { return this.getString ('CUSTOMER_NUMBER'); } 
            set { this.Set (value, 'CUSTOMER_NUMBER'); }
        }

        @AuraEnabled public String Name
        { 
            get { return this.getString ('FIRST_NAME'); } 
            set { this.Set (value, 'FIRST_NAME'); }
        }

        @AuraEnabled public String Name2
        { 
            get { return this.getString ('LAST_NAME'); } 
            set { this.Set (value, 'LAST_NAME'); }
        }

        @AuraEnabled public String TelephoneNumber
        { 
            get { return this.getString ('TEL_NUMBER'); } 
            set { this.Set (value, 'TEL_NUMBER'); }
        }

        @AuraEnabled public String FaxNumber
        { 
            get { return this.getString ('FAX_NUMBER'); } 
            set { this.Set (value, 'FAX_NUMBER'); }
        }

        @AuraEnabled public String Email
        { 
            get { return this.getString ('EMAIL'); } 
            set { this.Set (value, 'EMAIL'); }
        }

        @AuraEnabled public String Department
        { 
            get { return this.getString ('DEPARTMENT'); } 
            set { this.Set (value, 'DEPARTMENT'); }
        }

        @AuraEnabled public String MobileNumber
        { 
            get { return this.getString ('MOB_NUMBER'); } 
            set { this.Set (value, 'MOB_NUMBER'); }
        }

        @AuraEnabled public String Title
        { 
            get { return this.getString ('TITLE'); } 
            set { this.Set (value, 'TITLE'); }
        }

        @AuraEnabled public String Salutation
        { 
            get { return this.getString ('SALUTATION'); } 
            set { this.Set (value, 'SALUTATION'); }
        }

        @AuraEnabled public Date ChangeDate
        { 
            get { return this.getDate ('UDATE'); } 
            set { this.Set (value, 'UDATE'); }
        }

        @AuraEnabled public Time ChangeTime
        { 
            get { return this.getTime ('UTIME'); } 
            set { this.Set (value, 'UTIME'); }
        }

    }

    public class SEARCHRESULT_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public SEARCHRESULT_COLLECTION()
        {
            super('SEARCHRESULT', SBO_EnosixContactSync_Search.SEARCHRESULT.class, null);
        }

        public List<SBO_EnosixContactSync_Search.SEARCHRESULT> getAsList()
        {
            return (List<SBO_EnosixContactSync_Search.SEARCHRESULT>)this.buildList(List<SBO_EnosixContactSync_Search.SEARCHRESULT>.class);
        }
    }


}