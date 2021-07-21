/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class SBO_EnosixCustomer_Search extends ensxsdk.EnosixFramework.SearchSBO 
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('SBO_EnosixCustomer_Search_Meta', new Type[] {
            SBO_EnosixCustomer_Search.EnosixCustomer_SC.class
            , SBO_EnosixCustomer_Search.EnosixCustomer_SR.class
            , SBO_EnosixCustomer_Search.SEARCHRESULT.class
            , SBO_EnosixCustomer_Search.SEARCHPARAMS.class
            , SBO_EnosixCustomer_Search.CONTACT_PERSON.class
            , SBO_EnosixCustomer_Search.SEARCHRESULT.class
            } 
        );
    }

    public SBO_EnosixCustomer_Search() 
    {
        super('EnosixCustomer', SBO_EnosixCustomer_Search.EnosixCustomer_SC.class, SBO_EnosixCustomer_Search.EnosixCustomer_SR.class);
    }
    
    public override Type getType() { return SBO_EnosixCustomer_Search.class; }

    public EnosixCustomer_SC search(EnosixCustomer_SC sc) 
    {
        return (EnosixCustomer_SC)super.executeSearch(sc);
    }

    public EnosixCustomer_SC initialize(EnosixCustomer_SC sc) 
    {
        return (EnosixCustomer_SC)super.executeInitialize(sc);
    }

    public class EnosixCustomer_SC extends ensxsdk.EnosixFramework.SearchContext 
    { 		
        public EnosixCustomer_SC() 
        {		
            super(new Map<string,type>		
                {		
                    'SEARCHPARAMS' => SBO_EnosixCustomer_Search.SEARCHPARAMS.class
                    ,'CONTACT_PERSON' => SBO_EnosixCustomer_Search.CONTACT_PERSON.class		
                });		
        }

        public override Type getType() { return SBO_EnosixCustomer_Search.EnosixCustomer_SC.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixCustomer_Search.registerReflectionInfo();
        }

        public EnosixCustomer_SR result { get { return (EnosixCustomer_SR)baseResult; } }


        @AuraEnabled public SBO_EnosixCustomer_Search.SEARCHPARAMS SEARCHPARAMS 
        {
            get
            {
                return (SBO_EnosixCustomer_Search.SEARCHPARAMS)this.getStruct(SBO_EnosixCustomer_Search.SEARCHPARAMS.class);
            }
        }
        
    
        @AuraEnabled public SBO_EnosixCustomer_Search.CONTACT_PERSON CONTACT_PERSON 
        {
            get
            {
                return (SBO_EnosixCustomer_Search.CONTACT_PERSON)this.getStruct(SBO_EnosixCustomer_Search.CONTACT_PERSON.class);
            }
        }
        
        }

    public class EnosixCustomer_SR extends ensxsdk.EnosixFramework.SearchResult 
    {
        public EnosixCustomer_SR() 
        {
            super(new Map<string,type>{'SEARCHRESULT' => SBO_EnosixCustomer_Search.SEARCHRESULT.class } );
        }
        
        public ensxsdk.EnosixFramework.FrameworkCollection SearchResults
        {
            get { return super.getCollection(SBO_EnosixCustomer_Search.SEARCHRESULT.class); }
        }
        
        public List<SEARCHRESULT> getResults() 
        {
            List<SEARCHRESULT> results = new List<SEARCHRESULT>();
            SearchResults.copyTo(results);
            return results;
        }

        public override Type getType() { return SBO_EnosixCustomer_Search.EnosixCustomer_SR.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixCustomer_Search.registerReflectionInfo();
        }
    }

    public class SEARCHPARAMS extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixCustomer_Search.SEARCHPARAMS.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixCustomer_Search.registerReflectionInfo();
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

        @AuraEnabled public String CountryKey
        { 
            get { return this.getString ('COUNTRY'); } 
            set { this.Set (value, 'COUNTRY'); }
        }

        @AuraEnabled public String TelephoneNO
        { 
            get { return this.getString ('TEL_NUMBER'); } 
            set { this.Set (value, 'TEL_NUMBER'); }
        }

        @AuraEnabled public String EMailAddress
        { 
            get { return this.getString ('EMAIL_ADDRESS'); } 
            set { this.Set (value, 'EMAIL_ADDRESS'); }
        }

    }

public class CONTACT_PERSON extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixCustomer_Search.CONTACT_PERSON.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixCustomer_Search.registerReflectionInfo();
        }
        @AuraEnabled public String BusinessPartnerFrom
        { 
            get { return this.getString ('PARNR_FROM'); } 
            set { this.Set (value, 'PARNR_FROM'); }
        }

        @AuraEnabled public String BusinessPartnerTo
        { 
            get { return this.getString ('PARNR_TO'); } 
            set { this.Set (value, 'PARNR_TO'); }
        }

        @AuraEnabled public String LastName
        { 
            get { return this.getString ('MC_NAME1'); } 
            set { this.Set (value, 'MC_NAME1'); }
        }

        @AuraEnabled public String FirstName
        { 
            get { return this.getString ('MC_NAME2'); } 
            set { this.Set (value, 'MC_NAME2'); }
        }

        @AuraEnabled public String ContactPersonFlag
        { 
            get { return this.getString ('FLAG'); } 
            set { this.Set (value, 'FLAG'); }
        }

        @AuraEnabled public String SalesEmployeeFlag
        { 
            get { return this.getString ('PERNR_FLAG'); } 
            set { this.Set (value, 'PERNR_FLAG'); }
        }

        @AuraEnabled public String CustomerNumber
        { 
            get { return this.getString ('KUNNR'); } 
            set { this.Set (value, 'KUNNR'); }
        }

    }

    public class SEARCHRESULT extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixCustomer_Search.SEARCHRESULT.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixCustomer_Search.registerReflectionInfo();
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

        @AuraEnabled public String CountryKey
        { 
            get { return this.getString ('COUNTRY'); } 
            set { this.Set (value, 'COUNTRY'); }
        }

        @AuraEnabled public String POBox
        { 
            get { return this.getString ('PO_BOX'); } 
            set { this.Set (value, 'PO_BOX'); }
        }

        @AuraEnabled public String TelephoneNO
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

        @AuraEnabled public String EMailAddress
        { 
            get { return this.getString ('EMAIL_ADDRESS'); } 
            set { this.Set (value, 'EMAIL_ADDRESS'); }
        }

    }

    public class SEARCHRESULT_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public SEARCHRESULT_COLLECTION()
        {
            super('SEARCHRESULT', SBO_EnosixCustomer_Search.SEARCHRESULT.class, null);
        }

        public List<SBO_EnosixCustomer_Search.SEARCHRESULT> getAsList()
        {
            return (List<SBO_EnosixCustomer_Search.SEARCHRESULT>)this.buildList(List<SBO_EnosixCustomer_Search.SEARCHRESULT>.class);
        }
    }


}