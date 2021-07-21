/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class SBO_EnosixPartner_Search extends ensxsdk.EnosixFramework.SearchSBO 
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('SBO_EnosixPartner_Search_Meta', new Type[] {
            SBO_EnosixPartner_Search.EnosixPartner_SC.class
            , SBO_EnosixPartner_Search.EnosixPartner_SR.class
            , SBO_EnosixPartner_Search.SEARCHRESULT.class
            , SBO_EnosixPartner_Search.SEARCHPARAMS.class
            , SBO_EnosixPartner_Search.SEARCHRESULT.class
            } 
        );
    }

    public SBO_EnosixPartner_Search() 
    {
        super('EnosixPartner', SBO_EnosixPartner_Search.EnosixPartner_SC.class, SBO_EnosixPartner_Search.EnosixPartner_SR.class);
    }
    
    public override Type getType() { return SBO_EnosixPartner_Search.class; }

    public EnosixPartner_SC search(EnosixPartner_SC sc) 
    {
        return (EnosixPartner_SC)super.executeSearch(sc);
    }

    public EnosixPartner_SC initialize(EnosixPartner_SC sc) 
    {
        return (EnosixPartner_SC)super.executeInitialize(sc);
    }

    public class EnosixPartner_SC extends ensxsdk.EnosixFramework.SearchContext 
    { 		
        public EnosixPartner_SC() 
        {		
            super(new Map<string,type>		
                {		
                    'SEARCHPARAMS' => SBO_EnosixPartner_Search.SEARCHPARAMS.class		
                });		
        }

        public override Type getType() { return SBO_EnosixPartner_Search.EnosixPartner_SC.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixPartner_Search.registerReflectionInfo();
        }

        public EnosixPartner_SR result { get { return (EnosixPartner_SR)baseResult; } }


        @AuraEnabled public SBO_EnosixPartner_Search.SEARCHPARAMS SEARCHPARAMS 
        {
            get
            {
                return (SBO_EnosixPartner_Search.SEARCHPARAMS)this.getStruct(SBO_EnosixPartner_Search.SEARCHPARAMS.class);
            }
        }
        
        }

    public class EnosixPartner_SR extends ensxsdk.EnosixFramework.SearchResult 
    {
        public EnosixPartner_SR() 
        {
            super(new Map<string,type>{'SEARCHRESULT' => SBO_EnosixPartner_Search.SEARCHRESULT.class } );
        }
        
        public ensxsdk.EnosixFramework.FrameworkCollection SearchResults
        {
            get { return super.getCollection(SBO_EnosixPartner_Search.SEARCHRESULT.class); }
        }
        
        public List<SEARCHRESULT> getResults() 
        {
            List<SEARCHRESULT> results = new List<SEARCHRESULT>();
            SearchResults.copyTo(results);
            return results;
        }

        public override Type getType() { return SBO_EnosixPartner_Search.EnosixPartner_SR.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixPartner_Search.registerReflectionInfo();
        }
    }

    public class SEARCHPARAMS extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixPartner_Search.SEARCHPARAMS.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixPartner_Search.registerReflectionInfo();
        }
        @AuraEnabled public String CustomerNumber
        { 
            get { return this.getString ('KUNNR'); } 
            set { this.Set (value, 'KUNNR'); }
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

        @AuraEnabled public String PartnerFunction
        { 
            get { return this.getString ('PARVW'); } 
            set { this.Set (value, 'PARVW'); }
        }

    }

    public class SEARCHRESULT extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixPartner_Search.SEARCHRESULT.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixPartner_Search.registerReflectionInfo();
        }
        @AuraEnabled public String SalesOrganization
        { 
            get { return this.getString ('VKORG'); } 
            set { this.Set (value, 'VKORG'); }
        }

        @AuraEnabled public String SalesOrganizationName
        { 
            get { return this.getString ('VKORG_VTEXT'); } 
            set { this.Set (value, 'VKORG_VTEXT'); }
        }

        @AuraEnabled public String DistributionChannel
        { 
            get { return this.getString ('VTWEG'); } 
            set { this.Set (value, 'VTWEG'); }
        }

        @AuraEnabled public String DistributionChannelName
        { 
            get { return this.getString ('VTWEG_VTEXT'); } 
            set { this.Set (value, 'VTWEG_VTEXT'); }
        }

        @AuraEnabled public String Division
        { 
            get { return this.getString ('SPART'); } 
            set { this.Set (value, 'SPART'); }
        }

        @AuraEnabled public String DivisionName
        { 
            get { return this.getString ('SPART_VTEXT'); } 
            set { this.Set (value, 'SPART_VTEXT'); }
        }

        @AuraEnabled public String PartnerFunction
        { 
            get { return this.getString ('PARVW'); } 
            set { this.Set (value, 'PARVW'); }
        }

        @AuraEnabled public String PartnerFunctionName
        { 
            get { return this.getString ('PARVW_VTEXT'); } 
            set { this.Set (value, 'PARVW_VTEXT'); }
        }

        @AuraEnabled public String PartnerNumber
        { 
            get { return this.getString ('PARTNER_NUM'); } 
            set { this.Set (value, 'PARTNER_NUM'); }
        }

        @AuraEnabled public String PartnerName
        { 
            get { return this.getString ('PARTNER_NAME'); } 
            set { this.Set (value, 'PARTNER_NAME'); }
        }

        @AuraEnabled public String VendorNumber
        { 
            get { return this.getString ('VENDOR_NUM'); } 
            set { this.Set (value, 'VENDOR_NUM'); }
        }

        @AuraEnabled public String VendorName
        { 
            get { return this.getString ('VENDOR_NAME'); } 
            set { this.Set (value, 'VENDOR_NAME'); }
        }

        @AuraEnabled public String ContactNumber
        { 
            get { return this.getString ('CONTACT_NUM'); } 
            set { this.Set (value, 'CONTACT_NUM'); }
        }

        @AuraEnabled public String ContactFirstName
        { 
            get { return this.getString ('CONTACT_FNAME'); } 
            set { this.Set (value, 'CONTACT_FNAME'); }
        }

        @AuraEnabled public String ContactLastName
        { 
            get { return this.getString ('CONTACT_LNAME'); } 
            set { this.Set (value, 'CONTACT_LNAME'); }
        }

        @AuraEnabled public String PersonnelNumber
        { 
            get { return this.getString ('PERSONNEL_NUM'); } 
            set { this.Set (value, 'PERSONNEL_NUM'); }
        }

        @AuraEnabled public String PersonnelFirstName
        { 
            get { return this.getString ('PERSONNEL_FNAME'); } 
            set { this.Set (value, 'PERSONNEL_FNAME'); }
        }

        @AuraEnabled public String PersonnelLastName
        { 
            get { return this.getString ('PERSONNEL_LNAME'); } 
            set { this.Set (value, 'PERSONNEL_LNAME'); }
        }

        @AuraEnabled public String HouseNumber
        { 
            get { return this.getString ('HOUSE_NUM1'); } 
            set { this.Set (value, 'HOUSE_NUM1'); }
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

        @AuraEnabled public Boolean DefaultPartner
        { 
            get { return this.getBoolean('DEFPA'); } 
            set { this.setBoolean(value, 'DEFPA'); }
        }

    }

    public class SEARCHRESULT_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public SEARCHRESULT_COLLECTION()
        {
            super('SEARCHRESULT', SBO_EnosixPartner_Search.SEARCHRESULT.class, null);
        }

        public List<SBO_EnosixPartner_Search.SEARCHRESULT> getAsList()
        {
            return (List<SBO_EnosixPartner_Search.SEARCHRESULT>)this.buildList(List<SBO_EnosixPartner_Search.SEARCHRESULT>.class);
        }
    }


}