/// enosiX Inc. Generated Apex Model
/// Generated On: 7/10/2019 4:49:05 PM
/// SAP Host: From REST Service On: https://data-ruby-6848-dev-ed.cs1.my.salesforce.com
/// CID: From REST Service On: https://data-ruby-6848-dev-ed.cs1.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class SBO_EnosixCustSync_Search extends ensxsdk.EnosixFramework.SearchSBO 
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('SBO_EnosixCustSync_Search_Meta', new Type[] {
            SBO_EnosixCustSync_Search.EnosixCustSync_SC.class
            , SBO_EnosixCustSync_Search.EnosixCustSync_SR.class
            , SBO_EnosixCustSync_Search.SEARCHRESULT.class
            , SBO_EnosixCustSync_Search.SEARCHPARAMS.class
            , SBO_EnosixCustSync_Search.ACCOUNT_GROUPS.class
            , SBO_EnosixCustSync_Search.SEARCHRESULT.class
            } 
        );
    }

    public SBO_EnosixCustSync_Search() 
    {
        super('EnosixCustSync', SBO_EnosixCustSync_Search.EnosixCustSync_SC.class, SBO_EnosixCustSync_Search.EnosixCustSync_SR.class);
    }
    
    public override Type getType() { return SBO_EnosixCustSync_Search.class; }

    public EnosixCustSync_SC search(EnosixCustSync_SC sc) 
    {
        return (EnosixCustSync_SC)super.executeSearch(sc);
    }

    public EnosixCustSync_SC initialize(EnosixCustSync_SC sc) 
    {
        return (EnosixCustSync_SC)super.executeInitialize(sc);
    }

    public class EnosixCustSync_SC extends ensxsdk.EnosixFramework.SearchContext 
    { 		
        public EnosixCustSync_SC() 
        {		
            super(new Map<string,type>		
                {		
                    'SEARCHPARAMS' => SBO_EnosixCustSync_Search.SEARCHPARAMS.class
                    ,'ACCOUNT_GROUPS' => SBO_EnosixCustSync_Search.ACCOUNT_GROUPS_COLLECTION.class		
                });		
        }

        public override Type getType() { return SBO_EnosixCustSync_Search.EnosixCustSync_SC.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixCustSync_Search.registerReflectionInfo();
        }

        public EnosixCustSync_SR result { get { return (EnosixCustSync_SR)baseResult; } }


        @AuraEnabled public SBO_EnosixCustSync_Search.SEARCHPARAMS SEARCHPARAMS 
        {
            get
            {
                return (SBO_EnosixCustSync_Search.SEARCHPARAMS)this.getStruct(SBO_EnosixCustSync_Search.SEARCHPARAMS.class);
            }
        }
        
            @AuraEnabled public ACCOUNT_GROUPS_COLLECTION ACCOUNT_GROUPS
        {
            get 
            { 
                return (ACCOUNT_GROUPS_COLLECTION)this.getCollection(SBO_EnosixCustSync_Search.ACCOUNT_GROUPS_COLLECTION.class); 
            }
        }

            }

    public class EnosixCustSync_SR extends ensxsdk.EnosixFramework.SearchResult 
    {
        public EnosixCustSync_SR() 
        {
            super(new Map<string,type>{'SEARCHRESULT' => SBO_EnosixCustSync_Search.SEARCHRESULT.class } );
        }
        
        public ensxsdk.EnosixFramework.FrameworkCollection SearchResults
        {
            get { return super.getCollection(SBO_EnosixCustSync_Search.SEARCHRESULT.class); }
        }
        
        public List<SEARCHRESULT> getResults() 
        {
            List<SEARCHRESULT> results = new List<SEARCHRESULT>();
            SearchResults.copyTo(results);
            return results;
        }

        public override Type getType() { return SBO_EnosixCustSync_Search.EnosixCustSync_SR.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixCustSync_Search.registerReflectionInfo();
        }
    }

    public class SEARCHPARAMS extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixCustSync_Search.SEARCHPARAMS.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixCustSync_Search.registerReflectionInfo();
        }
        @AuraEnabled public Date DateFrom
        { 
            get { return this.getDate ('DATE_FROM'); } 
            set { this.Set (value, 'DATE_FROM'); }
        }

        @AuraEnabled public Date DateTo
        { 
            get { return this.getDate ('DATE_TO'); } 
            set { this.Set (value, 'DATE_TO'); }
        }

        @AuraEnabled public Boolean InitialLoad
        { 
            get { return this.getBoolean('X_INITIALLOAD'); } 
            set { this.setBoolean(value, 'X_INITIALLOAD'); }
        }

    }

public class ACCOUNT_GROUPS extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixCustSync_Search.ACCOUNT_GROUPS.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixCustSync_Search.registerReflectionInfo();
        }
        @AuraEnabled public String AccountGroup
        { 
            get { return this.getString ('KTOKD'); } 
            set { this.Set (value, 'KTOKD'); }
        }

    }

    public class ACCOUNT_GROUPS_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public ACCOUNT_GROUPS_COLLECTION()
        {
            super('ACCOUNT_GROUPS', SBO_EnosixCustSync_Search.ACCOUNT_GROUPS.class, null);
        }

        public List<SBO_EnosixCustSync_Search.ACCOUNT_GROUPS> getAsList()
        {
            return (List<SBO_EnosixCustSync_Search.ACCOUNT_GROUPS>)this.buildList(List<SBO_EnosixCustSync_Search.ACCOUNT_GROUPS>.class);
        }
    }

    public class SEARCHRESULT extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixCustSync_Search.SEARCHRESULT.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixCustSync_Search.registerReflectionInfo();
        }
        @AuraEnabled public String DeleteIndicator
        { 
            get { return this.getString ('LOEVM'); } 
            set { this.Set (value, 'LOEVM'); }
        }

        @AuraEnabled public String AccountGroup
        { 
            get { return this.getString ('KTOKD'); } 
            set { this.Set (value, 'KTOKD'); }
        }

        @AuraEnabled public String CustomerNumber
        { 
            get { return this.getString ('KUNNR'); } 
            set { this.Set (value, 'KUNNR'); }
        }

        @AuraEnabled public String Name
        { 
            get { return this.getString ('NAME1'); } 
            set { this.Set (value, 'NAME1'); }
        }

        @AuraEnabled public String Name2
        { 
            get { return this.getString ('NAME2'); } 
            set { this.Set (value, 'NAME2'); }
        }

        @AuraEnabled public String Name3
        { 
            get { return this.getString ('NAME3'); } 
            set { this.Set (value, 'NAME3'); }
        }

        @AuraEnabled public String Name4
        { 
            get { return this.getString ('NAME4'); } 
            set { this.Set (value, 'NAME4'); }
        }

        @AuraEnabled public String Street
        { 
            get { return this.getString ('STREET'); } 
            set { this.Set (value, 'STREET'); }
        }

        @AuraEnabled public String Street2
        { 
            get { return this.getString ('STR_SUPPL1'); } 
            set { this.Set (value, 'STR_SUPPL1'); }
        }

        @AuraEnabled public String Street3
        { 
            get { return this.getString ('STR_SUPPL2'); } 
            set { this.Set (value, 'STR_SUPPL2'); }
        }

        @AuraEnabled public String Street4
        { 
            get { return this.getString ('STR_SUPPL3'); } 
            set { this.Set (value, 'STR_SUPPL3'); }
        }

        @AuraEnabled public String AssetLocation
        { 
            get { return this.getString ('LOCATION'); } 
            set { this.Set (value, 'LOCATION'); }
        }

        @AuraEnabled public String HouseNumber
        { 
            get { return this.getString ('HOUSE_NUM1'); } 
            set { this.Set (value, 'HOUSE_NUM1'); }
        }

        @AuraEnabled public String PostalCode
        { 
            get { return this.getString ('POST_CODE1'); } 
            set { this.Set (value, 'POST_CODE1'); }
        }

        @AuraEnabled public String City
        { 
            get { return this.getString ('CITY1'); } 
            set { this.Set (value, 'CITY1'); }
        }

        @AuraEnabled public String Country
        { 
            get { return this.getString ('COUNTRY'); } 
            set { this.Set (value, 'COUNTRY'); }
        }

        @AuraEnabled public String Region
        { 
            get { return this.getString ('REGION'); } 
            set { this.Set (value, 'REGION'); }
        }

        @AuraEnabled public String POBox
        { 
            get { return this.getString ('PO_BOX'); } 
            set { this.Set (value, 'PO_BOX'); }
        }

        @AuraEnabled public String POBoxPostalCode
        { 
            get { return this.getString ('POST_CODE2'); } 
            set { this.Set (value, 'POST_CODE2'); }
        }

        @AuraEnabled public String TelephoneNumber
        { 
            get { return this.getString ('TEL_NUMBER'); } 
            set { this.Set (value, 'TEL_NUMBER'); }
        }

        @AuraEnabled public String EMailAddress
        { 
            get { return this.getString ('SMTP_ADDR'); } 
            set { this.Set (value, 'SMTP_ADDR'); }
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
            super('SEARCHRESULT', SBO_EnosixCustSync_Search.SEARCHRESULT.class, null);
        }

        public List<SBO_EnosixCustSync_Search.SEARCHRESULT> getAsList()
        {
            return (List<SBO_EnosixCustSync_Search.SEARCHRESULT>)this.buildList(List<SBO_EnosixCustSync_Search.SEARCHRESULT>.class);
        }
    }


}