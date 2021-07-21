/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class SBO_SFCICustomer_Search extends ensxsdk.EnosixFramework.SearchSBO 
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('SBO_SFCICustomer_Search_Meta', new Type[] {
            SBO_SFCICustomer_Search.SFCICustomer_SC.class
            , SBO_SFCICustomer_Search.SFCICustomer_SR.class
            , SBO_SFCICustomer_Search.SEARCHRESULT.class
            , SBO_SFCICustomer_Search.SEARCHPARAMS.class
            , SBO_SFCICustomer_Search.CONTACT_PERSON.class
            , SBO_SFCICustomer_Search.CUSTOM.class
            , SBO_SFCICustomer_Search.SEARCHRESULT.class
            } 
        );
    }

    public SBO_SFCICustomer_Search() 
    {
        super('SFCICustomer', SBO_SFCICustomer_Search.SFCICustomer_SC.class, SBO_SFCICustomer_Search.SFCICustomer_SR.class);
    }
    
    public override Type getType() { return SBO_SFCICustomer_Search.class; }

    public SFCICustomer_SC search(SFCICustomer_SC sc) 
    {
        return (SFCICustomer_SC)super.executeSearch(sc);
    }

    public SFCICustomer_SC initialize(SFCICustomer_SC sc) 
    {
        return (SFCICustomer_SC)super.executeInitialize(sc);
    }

    public class SFCICustomer_SC extends ensxsdk.EnosixFramework.SearchContext 
    { 		
        public SFCICustomer_SC() 
        {		
            super(new Map<string,type>		
                {		
                    'SEARCHPARAMS' => SBO_SFCICustomer_Search.SEARCHPARAMS.class
                    ,'CONTACT_PERSON' => SBO_SFCICustomer_Search.CONTACT_PERSON.class
                    ,'CUSTOM' => SBO_SFCICustomer_Search.CUSTOM_COLLECTION.class		
                });		
        }

        public override Type getType() { return SBO_SFCICustomer_Search.SFCICustomer_SC.class; }

        public override void registerReflectionForClass()
        {
            SBO_SFCICustomer_Search.registerReflectionInfo();
        }

        public SFCICustomer_SR result { get { return (SFCICustomer_SR)baseResult; } }


        @AuraEnabled public SBO_SFCICustomer_Search.SEARCHPARAMS SEARCHPARAMS 
        {
            get
            {
                return (SBO_SFCICustomer_Search.SEARCHPARAMS)this.getStruct(SBO_SFCICustomer_Search.SEARCHPARAMS.class);
            }
        }
        
    
        @AuraEnabled public SBO_SFCICustomer_Search.CONTACT_PERSON CONTACT_PERSON 
        {
            get
            {
                return (SBO_SFCICustomer_Search.CONTACT_PERSON)this.getStruct(SBO_SFCICustomer_Search.CONTACT_PERSON.class);
            }
        }
        
            @AuraEnabled public CUSTOM_COLLECTION CUSTOM
        {
            get 
            { 
                return (CUSTOM_COLLECTION)this.getCollection(SBO_SFCICustomer_Search.CUSTOM_COLLECTION.class); 
            }
        }

            }

    public class SFCICustomer_SR extends ensxsdk.EnosixFramework.SearchResult 
    {
        public SFCICustomer_SR() 
        {
            super(new Map<string,type>{'SEARCHRESULT' => SBO_SFCICustomer_Search.SEARCHRESULT.class } );
        }
        
        public ensxsdk.EnosixFramework.FrameworkCollection SearchResults
        {
            get { return super.getCollection(SBO_SFCICustomer_Search.SEARCHRESULT.class); }
        }
        
        public List<SEARCHRESULT> getResults() 
        {
            List<SEARCHRESULT> results = new List<SEARCHRESULT>();
            SearchResults.copyTo(results);
            return results;
        }

        public override Type getType() { return SBO_SFCICustomer_Search.SFCICustomer_SR.class; }

        public override void registerReflectionForClass()
        {
            SBO_SFCICustomer_Search.registerReflectionInfo();
        }
    }

    public class SEARCHPARAMS extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_SFCICustomer_Search.SEARCHPARAMS.class; }

        public override void registerReflectionForClass()
        {
            SBO_SFCICustomer_Search.registerReflectionInfo();
        }
        @AuraEnabled public String CustomerNumberFrom
        { 
            get { return this.getString ('KUNNR_FR'); } 
            set { this.Set (value, 'KUNNR_FR'); }
        }

        @AuraEnabled public String CustomerNumberTo
        { 
            get { return this.getString ('KUNNR_TO'); } 
            set { this.Set (value, 'KUNNR_TO'); }
        }

        @AuraEnabled public String CustomerName
        { 
            get { return this.getString ('MCOD1'); } 
            set { this.Set (value, 'MCOD1'); }
        }

        @AuraEnabled public String PostalCode
        { 
            get { return this.getString ('PSTLZ'); } 
            set { this.Set (value, 'PSTLZ'); }
        }

        @AuraEnabled public String City
        { 
            get { return this.getString ('CITY1'); } 
            set { this.Set (value, 'CITY1'); }
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

        @AuraEnabled public String TelephoneNumber
        { 
            get { return this.getString ('TEL_NUMBER'); } 
            set { this.Set (value, 'TEL_NUMBER'); }
        }

        @AuraEnabled public String EmailAddress
        { 
            get { return this.getString ('EMAIL_ADDRESS'); } 
            set { this.Set (value, 'EMAIL_ADDRESS'); }
        }

        @AuraEnabled public String CustomerAccountGroup
        { 
            get { return this.getString ('KTOKD'); } 
            set { this.Set (value, 'KTOKD'); }
        }

    }

public class CONTACT_PERSON extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_SFCICustomer_Search.CONTACT_PERSON.class; }

        public override void registerReflectionForClass()
        {
            SBO_SFCICustomer_Search.registerReflectionInfo();
        }
        @AuraEnabled public String PARNR_FROM
        { 
            get { return this.getString ('PARNR_FROM'); } 
            set { this.Set (value, 'PARNR_FROM'); }
        }

        @AuraEnabled public String PARNR_TO
        { 
            get { return this.getString ('PARNR_TO'); } 
            set { this.Set (value, 'PARNR_TO'); }
        }

        @AuraEnabled public String MC_NAME1
        { 
            get { return this.getString ('MC_NAME1'); } 
            set { this.Set (value, 'MC_NAME1'); }
        }

        @AuraEnabled public String MC_NAME2
        { 
            get { return this.getString ('MC_NAME2'); } 
            set { this.Set (value, 'MC_NAME2'); }
        }

    }

public class CUSTOM extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_SFCICustomer_Search.CUSTOM.class; }

        public override void registerReflectionForClass()
        {
            SBO_SFCICustomer_Search.registerReflectionInfo();
        }
        @AuraEnabled public String FIELD
        { 
            get { return this.getString ('FIELD'); } 
            set { this.Set (value, 'FIELD'); }
        }

        @AuraEnabled public String VALUE
        { 
            get { return this.getString ('VALUE'); } 
            set { this.Set (value, 'VALUE'); }
        }

    }

    public class CUSTOM_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public CUSTOM_COLLECTION()
        {
            super('CUSTOM', SBO_SFCICustomer_Search.CUSTOM.class, null);
        }

        public List<SBO_SFCICustomer_Search.CUSTOM> getAsList()
        {
            return (List<SBO_SFCICustomer_Search.CUSTOM>)this.buildList(List<SBO_SFCICustomer_Search.CUSTOM>.class);
        }
    }

    public class SEARCHRESULT extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_SFCICustomer_Search.SEARCHRESULT.class; }

        public override void registerReflectionForClass()
        {
            SBO_SFCICustomer_Search.registerReflectionInfo();
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

        @AuraEnabled public String RegionDescription
        { 
            get { return this.getString ('REGIO_BEZEI'); } 
            set { this.Set (value, 'REGIO_BEZEI'); }
        }

        @AuraEnabled public String Country
        { 
            get { return this.getString ('COUNTRY'); } 
            set { this.Set (value, 'COUNTRY'); }
        }

        @AuraEnabled public String CountryName
        { 
            get { return this.getString ('COUNTRY_LANDX'); } 
            set { this.Set (value, 'COUNTRY_LANDX'); }
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

        @AuraEnabled public String Language
        { 
            get { return this.getString ('LANGU'); } 
            set { this.Set (value, 'LANGU'); }
        }

        @AuraEnabled public Decimal CreditLimit
        { 
            get { return this.getDecimal ('KLIMK'); } 
            set { this.Set (value, 'KLIMK'); }
        }

        @AuraEnabled public Decimal CreditAvailable
        { 
            get { return this.getDecimal ('CREDIT_AVAIL'); } 
            set { this.Set (value, 'CREDIT_AVAIL'); }
        }

        @AuraEnabled public String CurrencyKey
        { 
            get { return this.getString ('WAERS'); } 
            set { this.Set (value, 'WAERS'); }
        }

        @AuraEnabled public String EmailAddress
        { 
            get { return this.getString ('EMAIL_ADDRESS'); } 
            set { this.Set (value, 'EMAIL_ADDRESS'); }
        }

        @AuraEnabled public String CustomerAccountGroup
        { 
            get { return this.getString ('KTOKD'); } 
            set { this.Set (value, 'KTOKD'); }
        }

        @AuraEnabled public String AccountGroupName
        { 
            get { return this.getString ('KTOKD_TEXT'); } 
            set { this.Set (value, 'KTOKD_TEXT'); }
        }

        @AuraEnabled public String CUSTOM01
        { 
            get { return this.getString ('CUSTOM01'); } 
            set { this.Set (value, 'CUSTOM01'); }
        }

        @AuraEnabled public String CUSTOM02
        { 
            get { return this.getString ('CUSTOM02'); } 
            set { this.Set (value, 'CUSTOM02'); }
        }

        @AuraEnabled public String CUSTOM03
        { 
            get { return this.getString ('CUSTOM03'); } 
            set { this.Set (value, 'CUSTOM03'); }
        }

        @AuraEnabled public String CUSTOM04
        { 
            get { return this.getString ('CUSTOM04'); } 
            set { this.Set (value, 'CUSTOM04'); }
        }

        @AuraEnabled public String CUSTOM05
        { 
            get { return this.getString ('CUSTOM05'); } 
            set { this.Set (value, 'CUSTOM05'); }
        }

        @AuraEnabled public String CUSTOM06
        { 
            get { return this.getString ('CUSTOM06'); } 
            set { this.Set (value, 'CUSTOM06'); }
        }

        @AuraEnabled public String CUSTOM07
        { 
            get { return this.getString ('CUSTOM07'); } 
            set { this.Set (value, 'CUSTOM07'); }
        }

        @AuraEnabled public String CUSTOM08
        { 
            get { return this.getString ('CUSTOM08'); } 
            set { this.Set (value, 'CUSTOM08'); }
        }

        @AuraEnabled public String CUSTOM09
        { 
            get { return this.getString ('CUSTOM09'); } 
            set { this.Set (value, 'CUSTOM09'); }
        }

        @AuraEnabled public String CUSTOM10
        { 
            get { return this.getString ('CUSTOM10'); } 
            set { this.Set (value, 'CUSTOM10'); }
        }

    }

    public class SEARCHRESULT_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public SEARCHRESULT_COLLECTION()
        {
            super('SEARCHRESULT', SBO_SFCICustomer_Search.SEARCHRESULT.class, null);
        }

        public List<SBO_SFCICustomer_Search.SEARCHRESULT> getAsList()
        {
            return (List<SBO_SFCICustomer_Search.SEARCHRESULT>)this.buildList(List<SBO_SFCICustomer_Search.SEARCHRESULT>.class);
        }
    }


}