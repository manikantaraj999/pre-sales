/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class SBO_EnosixVendor_Search extends ensxsdk.EnosixFramework.SearchSBO 
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('SBO_EnosixVendor_Search_Meta', new Type[] {
            SBO_EnosixVendor_Search.EnosixVendor_SC.class
            , SBO_EnosixVendor_Search.EnosixVendor_SR.class
            , SBO_EnosixVendor_Search.SEARCHRESULT.class
            , SBO_EnosixVendor_Search.VENDOR.class
            , SBO_EnosixVendor_Search.SEARCHRESULT.class
            } 
        );
    }

    public SBO_EnosixVendor_Search() 
    {
        super('EnosixVendor', SBO_EnosixVendor_Search.EnosixVendor_SC.class, SBO_EnosixVendor_Search.EnosixVendor_SR.class);
    }
    
    public override Type getType() { return SBO_EnosixVendor_Search.class; }

    public EnosixVendor_SC search(EnosixVendor_SC sc) 
    {
        return (EnosixVendor_SC)super.executeSearch(sc);
    }

    public EnosixVendor_SC initialize(EnosixVendor_SC sc) 
    {
        return (EnosixVendor_SC)super.executeInitialize(sc);
    }

    public class EnosixVendor_SC extends ensxsdk.EnosixFramework.SearchContext 
    { 		
        public EnosixVendor_SC() 
        {		
            super(new Map<string,type>		
                {		
                    'VENDOR' => SBO_EnosixVendor_Search.VENDOR.class		
                });		
        }

        public override Type getType() { return SBO_EnosixVendor_Search.EnosixVendor_SC.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixVendor_Search.registerReflectionInfo();
        }

        public EnosixVendor_SR result { get { return (EnosixVendor_SR)baseResult; } }


        @AuraEnabled public SBO_EnosixVendor_Search.VENDOR VENDOR 
        {
            get
            {
                return (SBO_EnosixVendor_Search.VENDOR)this.getStruct(SBO_EnosixVendor_Search.VENDOR.class);
            }
        }
        
        }

    public class EnosixVendor_SR extends ensxsdk.EnosixFramework.SearchResult 
    {
        public EnosixVendor_SR() 
        {
            super(new Map<string,type>{'SEARCHRESULT' => SBO_EnosixVendor_Search.SEARCHRESULT.class } );
        }
        
        public ensxsdk.EnosixFramework.FrameworkCollection SearchResults
        {
            get { return super.getCollection(SBO_EnosixVendor_Search.SEARCHRESULT.class); }
        }
        
        public List<SEARCHRESULT> getResults() 
        {
            List<SEARCHRESULT> results = new List<SEARCHRESULT>();
            SearchResults.copyTo(results);
            return results;
        }

        public override Type getType() { return SBO_EnosixVendor_Search.EnosixVendor_SR.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixVendor_Search.registerReflectionInfo();
        }
    }

    public class VENDOR extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixVendor_Search.VENDOR.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixVendor_Search.registerReflectionInfo();
        }
        @AuraEnabled public String FromVendor
        { 
            get { return this.getString ('LIFNR_FROM'); } 
            set { this.Set (value, 'LIFNR_FROM'); }
        }

        @AuraEnabled public String ToVendor
        { 
            get { return this.getString ('LIFNR_TO'); } 
            set { this.Set (value, 'LIFNR_TO'); }
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

    }

    public class SEARCHRESULT extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixVendor_Search.SEARCHRESULT.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixVendor_Search.registerReflectionInfo();
        }
        @AuraEnabled public String Vendor
        { 
            get { return this.getString ('LIFNR'); } 
            set { this.Set (value, 'LIFNR'); }
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

        @AuraEnabled public String Street
        { 
            get { return this.getString ('STREET'); } 
            set { this.Set (value, 'STREET'); }
        }

        @AuraEnabled public String City
        { 
            get { return this.getString ('CITY1'); } 
            set { this.Set (value, 'CITY1'); }
        }

        @AuraEnabled public String PostalCode
        { 
            get { return this.getString ('POST_CODE1'); } 
            set { this.Set (value, 'POST_CODE1'); }
        }

        @AuraEnabled public String Region
        { 
            get { return this.getString ('REGION'); } 
            set { this.Set (value, 'REGION'); }
        }

        @AuraEnabled public String Country
        { 
            get { return this.getString ('COUNTRY'); } 
            set { this.Set (value, 'COUNTRY'); }
        }

        @AuraEnabled public String POBox
        { 
            get { return this.getString ('PO_BOX'); } 
            set { this.Set (value, 'PO_BOX'); }
        }

        @AuraEnabled public String TelephoneNumber
        { 
            get { return this.getString ('TEL_NUMBER'); } 
            set { this.Set (value, 'TEL_NUMBER'); }
        }

        @AuraEnabled public String VendorAccountGroup
        { 
            get { return this.getString ('KTOKK'); } 
            set { this.Set (value, 'KTOKK'); }
        }

        @AuraEnabled public String Language
        { 
            get { return this.getString ('SPRAS'); } 
            set { this.Set (value, 'SPRAS'); }
        }

        @AuraEnabled public String EmailAddress
        { 
            get { return this.getString ('EMAIL_ADDRESS'); } 
            set { this.Set (value, 'EMAIL_ADDRESS'); }
        }

    }

    public class SEARCHRESULT_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public SEARCHRESULT_COLLECTION()
        {
            super('SEARCHRESULT', SBO_EnosixVendor_Search.SEARCHRESULT.class, null);
        }

        public List<SBO_EnosixVendor_Search.SEARCHRESULT> getAsList()
        {
            return (List<SBO_EnosixVendor_Search.SEARCHRESULT>)this.buildList(List<SBO_EnosixVendor_Search.SEARCHRESULT>.class);
        }
    }


}