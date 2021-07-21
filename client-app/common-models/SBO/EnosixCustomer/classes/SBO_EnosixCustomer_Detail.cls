/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class SBO_EnosixCustomer_Detail extends ensxsdk.EnosixFramework.DetailSBO
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('SBO_EnosixCustomer_Detail_Meta', new Type[] {
            SBO_EnosixCustomer_Detail.EnosixCustomer.class
            , SBO_EnosixCustomer_Detail.COMPANY_DATA.class
            , SBO_EnosixCustomer_Detail.SALES_DATA.class
            , SBO_EnosixCustomer_Detail.PAYMENT_DATA.class
            , SBO_EnosixCustomer_Detail.PARTNERS.class
            , SBO_EnosixCustomer_Detail.CREDIT.class
            , SBO_EnosixCustomer_Detail.SALES_TEXT.class
            , SBO_EnosixCustomer_Detail.USER_DEFINED.class
            , SBO_EnosixCustomer_Detail.CONTACTS.class
            , SBO_EnosixCustomer_Detail.TAX_CLASSIFICATION.class
            } 
        );
    }

    public SBO_EnosixCustomer_Detail()
    {
        super('EnosixCustomer', SBO_EnosixCustomer_Detail.EnosixCustomer.class);
    }

    public override Type getType() { return SBO_EnosixCustomer_Detail.class; }

    public EnosixCustomer initialize(EnosixCustomer obj)
    {
        return (EnosixCustomer)this.executeInitialize(obj);
    }
    
    public EnosixCustomer getDetail(object key)
    {
        return (EnosixCustomer)this.executeGetDetail(key);
    }
    
    public EnosixCustomer save(EnosixCustomer obj)
    {
        return (EnosixCustomer) this.executeSave(obj);
    }

    public EnosixCustomer command(string command, EnosixCustomer obj)
    {
        return (EnosixCustomer) this.executeCommand(command, obj);
    }
    
    public with sharing class EnosixCustomer extends ensxsdk.EnosixFramework.DetailObject
    {
        public EnosixCustomer()
        {
            super('GENERAL_DATA', new Map<string,type>
                {
                    'COMPANY_DATA' => SBO_EnosixCustomer_Detail.COMPANY_DATA_COLLECTION.class
                    ,'SALES_DATA' => SBO_EnosixCustomer_Detail.SALES_DATA_COLLECTION.class
                    ,'PAYMENT_DATA' => SBO_EnosixCustomer_Detail.PAYMENT_DATA_COLLECTION.class
                    ,'PARTNERS' => SBO_EnosixCustomer_Detail.PARTNERS_COLLECTION.class
                    ,'CREDIT' => SBO_EnosixCustomer_Detail.CREDIT.class
                    ,'SALES_TEXT' => SBO_EnosixCustomer_Detail.SALES_TEXT_COLLECTION.class
                    ,'USER_DEFINED' => SBO_EnosixCustomer_Detail.USER_DEFINED_COLLECTION.class
                    ,'CONTACTS' => SBO_EnosixCustomer_Detail.CONTACTS_COLLECTION.class
                    ,'TAX_CLASSIFICATION' => SBO_EnosixCustomer_Detail.TAX_CLASSIFICATION_COLLECTION.class
                });	
        }

        public override Type getType() { return SBO_EnosixCustomer_Detail.EnosixCustomer.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixCustomer_Detail.registerReflectionInfo();
        }

                @AuraEnabled public String CustomerNumber
        { 
            get { return this.getString ('KUNNR'); } 
            set { this.Set (value, 'KUNNR'); }
        }

        @AuraEnabled public String BPRole
        { 
            get { return this.getString ('BP_ROLE'); } 
            set { this.Set (value, 'BP_ROLE'); }
        }

        @AuraEnabled public String BPRoleDescription
        { 
            get { return this.getString ('BP_ROLE_TEXT'); } 
            set { this.Set (value, 'BP_ROLE_TEXT'); }
        }

        @AuraEnabled public String BusinessPartnerCategory
        { 
            get { return this.getString ('PARTNER_CATEG'); } 
            set { this.Set (value, 'PARTNER_CATEG'); }
        }

        @AuraEnabled public String BusinessPartnerCategoryDescription
        { 
            get { return this.getString ('PARTNERCATEG_TEXT'); } 
            set { this.Set (value, 'PARTNERCATEG_TEXT'); }
        }

        @AuraEnabled public String BusinessPartnerType
        { 
            get { return this.getString ('PARTNER_TYPE'); } 
            set { this.Set (value, 'PARTNER_TYPE'); }
        }

        @AuraEnabled public String BusinessPartnerTypeDescription
        { 
            get { return this.getString ('PARTNERTY_TEXT'); } 
            set { this.Set (value, 'PARTNERTY_TEXT'); }
        }

        @AuraEnabled public String BusinessPartnerGrouping
        { 
            get { return this.getString ('BU_GROUP'); } 
            set { this.Set (value, 'BU_GROUP'); }
        }

        @AuraEnabled public String BusinessPartnerGroupingDesc
        { 
            get { return this.getString ('BU_GROUP_TEXT'); } 
            set { this.Set (value, 'BU_GROUP_TEXT'); }
        }

        @AuraEnabled public String Title
        { 
            get { return this.getString ('TITLE'); } 
            set { this.Set (value, 'TITLE'); }
        }

        @AuraEnabled public String TitleName
        { 
            get { return this.getString ('TITLE_TEXT'); } 
            set { this.Set (value, 'TITLE_TEXT'); }
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

        @AuraEnabled public String SearchTerm1
        { 
            get { return this.getString ('SORT1'); } 
            set { this.Set (value, 'SORT1'); }
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

        @AuraEnabled public String CountryKey
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

        @AuraEnabled public String POBoxPostalCode
        { 
            get { return this.getString ('POST_CODE2'); } 
            set { this.Set (value, 'POST_CODE2'); }
        }

        @AuraEnabled public String CompanyPostalCode
        { 
            get { return this.getString ('POST_CODE3'); } 
            set { this.Set (value, 'POST_CODE3'); }
        }

        @AuraEnabled public String Language
        { 
            get { return this.getString ('LANGU'); } 
            set { this.Set (value, 'LANGU'); }
        }

        @AuraEnabled public String LanguageDesc
        { 
            get { return this.getString ('LANGU_SPTXT'); } 
            set { this.Set (value, 'LANGU_SPTXT'); }
        }

        @AuraEnabled public String TelephoneNO
        { 
            get { return this.getString ('TEL_NUMBER'); } 
            set { this.Set (value, 'TEL_NUMBER'); }
        }

        @AuraEnabled public String TelephoneNumberExtension
        { 
            get { return this.getString ('TEL_EXTENS'); } 
            set { this.Set (value, 'TEL_EXTENS'); }
        }

        @AuraEnabled public String MobileNumber
        { 
            get { return this.getString ('MOB_NUMBER'); } 
            set { this.Set (value, 'MOB_NUMBER'); }
        }

        @AuraEnabled public String FaxNumber
        { 
            get { return this.getString ('FAX_NUMBER'); } 
            set { this.Set (value, 'FAX_NUMBER'); }
        }

        @AuraEnabled public String FaxNumberExtension
        { 
            get { return this.getString ('FAX_EXTENS'); } 
            set { this.Set (value, 'FAX_EXTENS'); }
        }

        @AuraEnabled public String EMailAddress
        { 
            get { return this.getString ('SMTP_ADDR'); } 
            set { this.Set (value, 'SMTP_ADDR'); }
        }

        @AuraEnabled public String TimeZone
        { 
            get { return this.getString ('TIME_ZONE'); } 
            set { this.Set (value, 'TIME_ZONE'); }
        }

        @AuraEnabled public String TimeZoneText
        { 
            get { return this.getString ('TIME_ZONE_TEXT'); } 
            set { this.Set (value, 'TIME_ZONE_TEXT'); }
        }

        @AuraEnabled public String TransportationZone
        { 
            get { return this.getString ('TRANSPZONE'); } 
            set { this.Set (value, 'TRANSPZONE'); }
        }

        @AuraEnabled public String TransportationZoneDescription
        { 
            get { return this.getString ('TRANSPZONE_VTEXT'); } 
            set { this.Set (value, 'TRANSPZONE_VTEXT'); }
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

        @AuraEnabled public COMPANY_DATA_COLLECTION COMPANY_DATA
        {
            get 
            { 
                return (COMPANY_DATA_COLLECTION)this.getCollection(SBO_EnosixCustomer_Detail.COMPANY_DATA_COLLECTION.class); 
            }
        }

                @AuraEnabled public SALES_DATA_COLLECTION SALES_DATA
        {
            get 
            { 
                return (SALES_DATA_COLLECTION)this.getCollection(SBO_EnosixCustomer_Detail.SALES_DATA_COLLECTION.class); 
            }
        }

                @AuraEnabled public PAYMENT_DATA_COLLECTION PAYMENT_DATA
        {
            get 
            { 
                return (PAYMENT_DATA_COLLECTION)this.getCollection(SBO_EnosixCustomer_Detail.PAYMENT_DATA_COLLECTION.class); 
            }
        }

                @AuraEnabled public PARTNERS_COLLECTION PARTNERS
        {
            get 
            { 
                return (PARTNERS_COLLECTION)this.getCollection(SBO_EnosixCustomer_Detail.PARTNERS_COLLECTION.class); 
            }
        }

        
        @AuraEnabled public SBO_EnosixCustomer_Detail.CREDIT CREDIT 
        {
            get
            {
                return (SBO_EnosixCustomer_Detail.CREDIT)this.getStruct(SBO_EnosixCustomer_Detail.CREDIT.class);
            }
        }
        
            @AuraEnabled public SALES_TEXT_COLLECTION SALES_TEXT
        {
            get 
            { 
                return (SALES_TEXT_COLLECTION)this.getCollection(SBO_EnosixCustomer_Detail.SALES_TEXT_COLLECTION.class); 
            }
        }

                @AuraEnabled public USER_DEFINED_COLLECTION USER_DEFINED
        {
            get 
            { 
                return (USER_DEFINED_COLLECTION)this.getCollection(SBO_EnosixCustomer_Detail.USER_DEFINED_COLLECTION.class); 
            }
        }

                @AuraEnabled public CONTACTS_COLLECTION CONTACTS
        {
            get 
            { 
                return (CONTACTS_COLLECTION)this.getCollection(SBO_EnosixCustomer_Detail.CONTACTS_COLLECTION.class); 
            }
        }

                @AuraEnabled public TAX_CLASSIFICATION_COLLECTION TAX_CLASSIFICATION
        {
            get 
            { 
                return (TAX_CLASSIFICATION_COLLECTION)this.getCollection(SBO_EnosixCustomer_Detail.TAX_CLASSIFICATION_COLLECTION.class); 
            }
        }

            }

    //Write child objects
        public class COMPANY_DATA extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixCustomer_Detail.COMPANY_DATA.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixCustomer_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'BUKRS' };
    
            return keyFields;
        }

                @AuraEnabled public String CompanyCode
        { 
            get { return this.getString ('BUKRS'); } 
            set { this.Set (value, 'BUKRS'); }
        }

        @AuraEnabled public String CompanyCodeDescription
        { 
            get { return this.getString ('BUKRS_TEXT'); } 
            set { this.Set (value, 'BUKRS_TEXT'); }
        }

        @AuraEnabled public String ReconciliationAccount
        { 
            get { return this.getString ('AKONT'); } 
            set { this.Set (value, 'AKONT'); }
        }

        @AuraEnabled public String TermsofPaymentKey
        { 
            get { return this.getString ('ZTERM'); } 
            set { this.Set (value, 'ZTERM'); }
        }

        @AuraEnabled public String TermsOfPaymentDescription
        { 
            get { return this.getString ('ZTERM_TEXT'); } 
            set { this.Set (value, 'ZTERM_TEXT'); }
        }

    }
    public class COMPANY_DATA_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public COMPANY_DATA_COLLECTION()
        {
            super('COMPANY_DATA', SBO_EnosixCustomer_Detail.COMPANY_DATA.class, null);
        }

        @AuraEnabled public List<SBO_EnosixCustomer_Detail.COMPANY_DATA> getAsList()
        {
            return (List<SBO_EnosixCustomer_Detail.COMPANY_DATA>)this.buildList(List<SBO_EnosixCustomer_Detail.COMPANY_DATA>.class);
        }
    }
    public class SALES_DATA extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixCustomer_Detail.SALES_DATA.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixCustomer_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'VKORG','VTWEG','SPART' };
    
            return keyFields;
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

        @AuraEnabled public String SalesDistrict
        { 
            get { return this.getString ('BZIRK'); } 
            set { this.Set (value, 'BZIRK'); }
        }

        @AuraEnabled public String SalesDistrictName
        { 
            get { return this.getString ('BZIRK_TEXT'); } 
            set { this.Set (value, 'BZIRK_TEXT'); }
        }

        @AuraEnabled public String SalesOffice
        { 
            get { return this.getString ('VKBUR'); } 
            set { this.Set (value, 'VKBUR'); }
        }

        @AuraEnabled public String SalesOfficeName
        { 
            get { return this.getString ('VKBUR_TEXT'); } 
            set { this.Set (value, 'VKBUR_TEXT'); }
        }

        @AuraEnabled public String SalesGroup
        { 
            get { return this.getString ('VKGRP'); } 
            set { this.Set (value, 'VKGRP'); }
        }

        @AuraEnabled public String SalesGroupName
        { 
            get { return this.getString ('VKGRP_TEXT'); } 
            set { this.Set (value, 'VKGRP_TEXT'); }
        }

        @AuraEnabled public String DeliveryPlant
        { 
            get { return this.getString ('VWERK'); } 
            set { this.Set (value, 'VWERK'); }
        }

        @AuraEnabled public String DeliveryPlantName
        { 
            get { return this.getString ('VWERK_TEXT'); } 
            set { this.Set (value, 'VWERK_TEXT'); }
        }

        @AuraEnabled public String PriceGroup
        { 
            get { return this.getString ('KONDA'); } 
            set { this.Set (value, 'KONDA'); }
        }

        @AuraEnabled public String PriceGroupDescription
        { 
            get { return this.getString ('KONDA_TEXT'); } 
            set { this.Set (value, 'KONDA_TEXT'); }
        }

        @AuraEnabled public String CustomerPricingProcedure
        { 
            get { return this.getString ('KALKS'); } 
            set { this.Set (value, 'KALKS'); }
        }

        @AuraEnabled public String CustomerPricProcedureDesc
        { 
            get { return this.getString ('KALKS_TEXT'); } 
            set { this.Set (value, 'KALKS_TEXT'); }
        }

        @AuraEnabled public String PriceListType
        { 
            get { return this.getString ('PLTYP'); } 
            set { this.Set (value, 'PLTYP'); }
        }

        @AuraEnabled public String PriceListTypeDescription
        { 
            get { return this.getString ('PLTYP_TEXT'); } 
            set { this.Set (value, 'PLTYP_TEXT'); }
        }

        @AuraEnabled public String StatisticsGroup
        { 
            get { return this.getString ('VERSG'); } 
            set { this.Set (value, 'VERSG'); }
        }

        @AuraEnabled public String StatisticsGroupDescription
        { 
            get { return this.getString ('VERSG_TEXT'); } 
            set { this.Set (value, 'VERSG_TEXT'); }
        }

        @AuraEnabled public String ShippingConditions
        { 
            get { return this.getString ('VSBED'); } 
            set { this.Set (value, 'VSBED'); }
        }

        @AuraEnabled public String ShippingConditionDescription
        { 
            get { return this.getString ('VSBED_TEXT'); } 
            set { this.Set (value, 'VSBED_TEXT'); }
        }

        @AuraEnabled public Boolean CompleteDeliveryDefined
        { 
            get { return this.getBoolean('AUTLF'); } 
            set { this.setBoolean(value, 'AUTLF'); }
        }

        @AuraEnabled public String PartialDelivery
        { 
            get { return this.getString ('KZTLF'); } 
            set { this.Set (value, 'KZTLF'); }
        }

        @AuraEnabled public Decimal MaximumNoOfPartialDelivery
        { 
            get { return this.getDecimal ('MAX_PARTIAL_DEL'); } 
            set { this.Set (value, 'MAX_PARTIAL_DEL'); }
        }

        @AuraEnabled public String AccountAssignmentGroup
        { 
            get { return this.getString ('KTGRD'); } 
            set { this.Set (value, 'KTGRD'); }
        }

        @AuraEnabled public String AccountAssignmentGroupDescription
        { 
            get { return this.getString ('KTGRD_TEXT'); } 
            set { this.Set (value, 'KTGRD_TEXT'); }
        }

        @AuraEnabled public String TermsofPaymentKey
        { 
            get { return this.getString ('ZTERM'); } 
            set { this.Set (value, 'ZTERM'); }
        }

        @AuraEnabled public String TermsOfPaymentDescription
        { 
            get { return this.getString ('ZTERM_TEXT'); } 
            set { this.Set (value, 'ZTERM_TEXT'); }
        }

        @AuraEnabled public String CurrencyKey
        { 
            get { return this.getString ('WAERS'); } 
            set { this.Set (value, 'WAERS'); }
        }

        @AuraEnabled public String TaxClassification
        { 
            get { return this.getString ('TAXKD'); } 
            set { this.Set (value, 'TAXKD'); }
        }

        @AuraEnabled public String TaxClassificationDescription
        { 
            get { return this.getString ('TAXKD_TEXT'); } 
            set { this.Set (value, 'TAXKD_TEXT'); }
        }

        @AuraEnabled public String CustomerGroup1
        { 
            get { return this.getString ('KVGR1'); } 
            set { this.Set (value, 'KVGR1'); }
        }

        @AuraEnabled public String CustomerGroup1Name
        { 
            get { return this.getString ('KVGR1_TEXT'); } 
            set { this.Set (value, 'KVGR1_TEXT'); }
        }

        @AuraEnabled public String CustomerBlock
        { 
            get { return this.getString ('AUFSD'); } 
            set { this.Set (value, 'AUFSD'); }
        }

        @AuraEnabled public String IncotermsPart1
        { 
            get { return this.getString ('INCO1'); } 
            set { this.Set (value, 'INCO1'); }
        }

        @AuraEnabled public String IncotermsPart2
        { 
            get { return this.getString ('INCO2'); } 
            set { this.Set (value, 'INCO2'); }
        }

    }
    public class SALES_DATA_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public SALES_DATA_COLLECTION()
        {
            super('SALES_DATA', SBO_EnosixCustomer_Detail.SALES_DATA.class, null);
        }

        @AuraEnabled public List<SBO_EnosixCustomer_Detail.SALES_DATA> getAsList()
        {
            return (List<SBO_EnosixCustomer_Detail.SALES_DATA>)this.buildList(List<SBO_EnosixCustomer_Detail.SALES_DATA>.class);
        }
    }
    public class PAYMENT_DATA extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixCustomer_Detail.PAYMENT_DATA.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixCustomer_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'CCARD_ID' };
    
            return keyFields;
        }

                @AuraEnabled public String PaymentCardID
        { 
            get { return this.getString ('CCARD_ID'); } 
            set { this.Set (value, 'CCARD_ID'); }
        }

        @AuraEnabled public String PaymentCardType
        { 
            get { return this.getString ('CCINS'); } 
            set { this.Set (value, 'CCINS'); }
        }

        @AuraEnabled public String PaymentCardTypeDesc
        { 
            get { return this.getString ('CCINS_TEXT'); } 
            set { this.Set (value, 'CCINS_TEXT'); }
        }

        @AuraEnabled public String CardNumber
        { 
            get { return this.getString ('CCNUM'); } 
            set { this.Set (value, 'CCNUM'); }
        }

        @AuraEnabled public Boolean DefaultPaymentCard
        { 
            get { return this.getBoolean('CCDEF'); } 
            set { this.setBoolean(value, 'CCDEF'); }
        }

        @AuraEnabled public String CreditCardName
        { 
            get { return this.getString ('CREDITCARDNAME'); } 
            set { this.Set (value, 'CREDITCARDNAME'); }
        }

        @AuraEnabled public String CardHolderName
        { 
            get { return this.getString ('CCNAM'); } 
            set { this.Set (value, 'CCNAM'); }
        }

        @AuraEnabled public String CardCategory
        { 
            get { return this.getString ('CCTYP'); } 
            set { this.Set (value, 'CCTYP'); }
        }

        @AuraEnabled public String CardCategoryDescription
        { 
            get { return this.getString ('CCTYP_TEXT'); } 
            set { this.Set (value, 'CCTYP_TEXT'); }
        }

        @AuraEnabled public Date ValidFromDate
        { 
            get { return this.getDate ('DATAB'); } 
            set { this.Set (value, 'DATAB'); }
        }

        @AuraEnabled public Date ValidToDate
        { 
            get { return this.getDate ('DATBI'); } 
            set { this.Set (value, 'DATBI'); }
        }

        @AuraEnabled public Boolean X_RemoveCard
        { 
            get { return this.getBoolean('X_CARD_DELETE'); } 
            set { this.setBoolean(value, 'X_CARD_DELETE'); }
        }

    }
    public class PAYMENT_DATA_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public PAYMENT_DATA_COLLECTION()
        {
            super('PAYMENT_DATA', SBO_EnosixCustomer_Detail.PAYMENT_DATA.class, null);
        }

        @AuraEnabled public List<SBO_EnosixCustomer_Detail.PAYMENT_DATA> getAsList()
        {
            return (List<SBO_EnosixCustomer_Detail.PAYMENT_DATA>)this.buildList(List<SBO_EnosixCustomer_Detail.PAYMENT_DATA>.class);
        }
    }
    public class PARTNERS extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixCustomer_Detail.PARTNERS.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixCustomer_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'VKORG','VTWEG','SPART','PARVW','PARTNER_NUM','VENDOR_NUM','CONTACT_NUM' };
    
            return keyFields;
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

        @AuraEnabled public String CountryKey
        { 
            get { return this.getString ('COUNTRY'); } 
            set { this.Set (value, 'COUNTRY'); }
        }

        @AuraEnabled public Boolean DEFPA
        { 
            get { return this.getBoolean('DEFPA'); } 
            set { this.setBoolean(value, 'DEFPA'); }
        }

    }
    public class PARTNERS_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public PARTNERS_COLLECTION()
        {
            super('PARTNERS', SBO_EnosixCustomer_Detail.PARTNERS.class, null);
        }

        @AuraEnabled public List<SBO_EnosixCustomer_Detail.PARTNERS> getAsList()
        {
            return (List<SBO_EnosixCustomer_Detail.PARTNERS>)this.buildList(List<SBO_EnosixCustomer_Detail.PARTNERS>.class);
        }
    }
    public class CREDIT extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixCustomer_Detail.CREDIT.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixCustomer_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'EnosixObjKey' };
    
            return keyFields;
        }

                @AuraEnabled public Decimal CreditLimit
        { 
            get { return this.getDecimal ('CREDIT_LIMIT'); } 
            set { this.Set (value, 'CREDIT_LIMIT'); }
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

        @AuraEnabled public Boolean CreditManagmentBlock
        { 
            get { return this.getBoolean('XBLOCKED'); } 
            set { this.setBoolean(value, 'XBLOCKED'); }
        }

        @AuraEnabled public Date ValidToDate
        { 
            get { return this.getDate ('LIMIT_VALID_DATE'); } 
            set { this.Set (value, 'LIMIT_VALID_DATE'); }
        }

        @AuraEnabled public Date ChangeDate
        { 
            get { return this.getDate ('LIMIT_CHG_DATE'); } 
            set { this.Set (value, 'LIMIT_CHG_DATE'); }
        }

        @AuraEnabled public String CreditAnalyst
        { 
            get { return this.getString ('COORDINATOR'); } 
            set { this.Set (value, 'COORDINATOR'); }
        }

        @AuraEnabled public String CustomerCreditGroup
        { 
            get { return this.getString ('CUST_GROUP'); } 
            set { this.Set (value, 'CUST_GROUP'); }
        }

        @AuraEnabled public Date ResubmissionDate
        { 
            get { return this.getDate ('FOLLOW_UP_DT'); } 
            set { this.Set (value, 'FOLLOW_UP_DT'); }
        }

        @AuraEnabled public Decimal CalculatedCreditLimit
        { 
            get { return this.getDecimal ('CRED_LIM_CALC'); } 
            set { this.Set (value, 'CRED_LIM_CALC'); }
        }

        @AuraEnabled public Boolean SpecialAttentionRequired
        { 
            get { return this.getBoolean('XCRITICAL'); } 
            set { this.setBoolean(value, 'XCRITICAL'); }
        }

        @AuraEnabled public Boolean LimitIsZero
        { 
            get { return this.getBoolean('X_LIMIT_ZERO'); } 
            set { this.setBoolean(value, 'X_LIMIT_ZERO'); }
        }

        @AuraEnabled public String CreditBlockReason
        { 
            get { return this.getString ('BLOCK_REASON'); } 
            set { this.Set (value, 'BLOCK_REASON'); }
        }

        @AuraEnabled public Decimal CreditLimitRequested
        { 
            get { return this.getDecimal ('CRED_LIM_REQ'); } 
            set { this.Set (value, 'CRED_LIM_REQ'); }
        }

        @AuraEnabled public Boolean AutomaticLimitRequest
        { 
            get { return this.getBoolean('AUTOMATIC_REQ'); } 
            set { this.setBoolean(value, 'AUTOMATIC_REQ'); }
        }

        @AuraEnabled public Date RequestedValidToDate
        { 
            get { return this.getDate ('LIM_VAL_DATE_REQ'); } 
            set { this.Set (value, 'LIM_VAL_DATE_REQ'); }
        }

        @AuraEnabled public Date RequestDate
        { 
            get { return this.getDate ('REQ_DATE'); } 
            set { this.Set (value, 'REQ_DATE'); }
        }

    }
    public class SALES_TEXT extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixCustomer_Detail.SALES_TEXT.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixCustomer_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'VKORG','VTWEG','SPART','TDID','TDSPRAS','TDTEXT','LTEXT','KZLTX','TEXT' };
    
            return keyFields;
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

        @AuraEnabled public String TextID
        { 
            get { return this.getString ('TDID'); } 
            set { this.Set (value, 'TDID'); }
        }

        @AuraEnabled public String TextLanguage
        { 
            get { return this.getString ('TDSPRAS'); } 
            set { this.Set (value, 'TDSPRAS'); }
        }

        @AuraEnabled public String TextIDDescription
        { 
            get { return this.getString ('TDTEXT'); } 
            set { this.Set (value, 'TDTEXT'); }
        }

        @AuraEnabled public String FirstLine
        { 
            get { return this.getString ('LTEXT'); } 
            set { this.Set (value, 'LTEXT'); }
        }

        @AuraEnabled public Boolean MoreTextExists
        { 
            get { return this.getBoolean('KZLTX'); } 
            set { this.setBoolean(value, 'KZLTX'); }
        }

        @AuraEnabled public String Text
        { 
            get { return this.getString ('TEXT'); } 
            set { this.Set (value, 'TEXT'); }
        }

    }
    public class SALES_TEXT_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public SALES_TEXT_COLLECTION()
        {
            super('SALES_TEXT', SBO_EnosixCustomer_Detail.SALES_TEXT.class, null);
        }

        @AuraEnabled public List<SBO_EnosixCustomer_Detail.SALES_TEXT> getAsList()
        {
            return (List<SBO_EnosixCustomer_Detail.SALES_TEXT>)this.buildList(List<SBO_EnosixCustomer_Detail.SALES_TEXT>.class);
        }
    }
    public class USER_DEFINED extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixCustomer_Detail.USER_DEFINED.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixCustomer_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'FIELD' };
    
            return keyFields;
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
    public class USER_DEFINED_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public USER_DEFINED_COLLECTION()
        {
            super('USER_DEFINED', SBO_EnosixCustomer_Detail.USER_DEFINED.class, null);
        }

        @AuraEnabled public List<SBO_EnosixCustomer_Detail.USER_DEFINED> getAsList()
        {
            return (List<SBO_EnosixCustomer_Detail.USER_DEFINED>)this.buildList(List<SBO_EnosixCustomer_Detail.USER_DEFINED>.class);
        }
    }
    public class CONTACTS extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixCustomer_Detail.CONTACTS.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixCustomer_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'PARNR' };
    
            return keyFields;
        }

                @AuraEnabled public String ContactPersonNumber
        { 
            get { return this.getString ('PARNR'); } 
            set { this.Set (value, 'PARNR'); }
        }

        @AuraEnabled public String FirstName
        { 
            get { return this.getString ('NAMEV'); } 
            set { this.Set (value, 'NAMEV'); }
        }

        @AuraEnabled public String LastName
        { 
            get { return this.getString ('LNAME'); } 
            set { this.Set (value, 'LNAME'); }
        }

        @AuraEnabled public String Name
        { 
            get { return this.getString ('NAME1'); } 
            set { this.Set (value, 'NAME1'); }
        }

        @AuraEnabled public String VIPPartner
        { 
            get { return this.getString ('PAVIP'); } 
            set { this.Set (value, 'PAVIP'); }
        }

        @AuraEnabled public String DepartmentNumber
        { 
            get { return this.getString ('ABTNR'); } 
            set { this.Set (value, 'ABTNR'); }
        }

        @AuraEnabled public String Function
        { 
            get { return this.getString ('PAFKT'); } 
            set { this.Set (value, 'PAFKT'); }
        }

        @AuraEnabled public String Authority
        { 
            get { return this.getString ('PARVO'); } 
            set { this.Set (value, 'PARVO'); }
        }

        @AuraEnabled public String HigherPartner
        { 
            get { return this.getString ('KTONR'); } 
            set { this.Set (value, 'KTONR'); }
        }

        @AuraEnabled public String SalesEmployee
        { 
            get { return this.getString ('VRTNR'); } 
            set { this.Set (value, 'VRTNR'); }
        }

        @AuraEnabled public String Gender
        { 
            get { return this.getString ('PARGE'); } 
            set { this.Set (value, 'PARGE'); }
        }

        @AuraEnabled public Date DateOfBirth
        { 
            get { return this.getDate ('GBDAT'); } 
            set { this.Set (value, 'GBDAT'); }
        }

        @AuraEnabled public String MaritalStatus
        { 
            get { return this.getString ('FAMST'); } 
            set { this.Set (value, 'FAMST'); }
        }

        @AuraEnabled public String CallFrequency
        { 
            get { return this.getString ('BRYTH'); } 
            set { this.Set (value, 'BRYTH'); }
        }

        @AuraEnabled public String BuyingHabits
        { 
            get { return this.getString ('AKVER'); } 
            set { this.Set (value, 'AKVER'); }
        }

        @AuraEnabled public String Notes
        { 
            get { return this.getString ('PARAU'); } 
            set { this.Set (value, 'PARAU'); }
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

        @AuraEnabled public String CountryKey
        { 
            get { return this.getString ('COUNTRY'); } 
            set { this.Set (value, 'COUNTRY'); }
        }

        @AuraEnabled public String CountryName
        { 
            get { return this.getString ('COUNTRY_LANDX'); } 
            set { this.Set (value, 'COUNTRY_LANDX'); }
        }

        @AuraEnabled public String TimeZone
        { 
            get { return this.getString ('TIME_ZONE'); } 
            set { this.Set (value, 'TIME_ZONE'); }
        }

        @AuraEnabled public String TimeZoneText
        { 
            get { return this.getString ('TIME_ZONE_TEXT'); } 
            set { this.Set (value, 'TIME_ZONE_TEXT'); }
        }

        @AuraEnabled public String TransportationZone
        { 
            get { return this.getString ('TRANSPZONE'); } 
            set { this.Set (value, 'TRANSPZONE'); }
        }

        @AuraEnabled public String TransportationZoneDescription
        { 
            get { return this.getString ('TRANSPZONE_VTEXT'); } 
            set { this.Set (value, 'TRANSPZONE_VTEXT'); }
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

        @AuraEnabled public String CompanyPostalCode
        { 
            get { return this.getString ('POST_CODE3'); } 
            set { this.Set (value, 'POST_CODE3'); }
        }

        @AuraEnabled public String Language
        { 
            get { return this.getString ('LANGU'); } 
            set { this.Set (value, 'LANGU'); }
        }

        @AuraEnabled public String LanguageDesc
        { 
            get { return this.getString ('LANGU_SPTXT'); } 
            set { this.Set (value, 'LANGU_SPTXT'); }
        }

        @AuraEnabled public String TelephoneNO
        { 
            get { return this.getString ('TEL_NUMBER'); } 
            set { this.Set (value, 'TEL_NUMBER'); }
        }

        @AuraEnabled public String TelephoneNumberExtension
        { 
            get { return this.getString ('TEL_EXTENS'); } 
            set { this.Set (value, 'TEL_EXTENS'); }
        }

        @AuraEnabled public String MobileNumber
        { 
            get { return this.getString ('MOB_NUMBER'); } 
            set { this.Set (value, 'MOB_NUMBER'); }
        }

        @AuraEnabled public String FaxNumber
        { 
            get { return this.getString ('FAX_NUMBER'); } 
            set { this.Set (value, 'FAX_NUMBER'); }
        }

        @AuraEnabled public String FaxNumberExtension
        { 
            get { return this.getString ('FAX_EXTENS'); } 
            set { this.Set (value, 'FAX_EXTENS'); }
        }

        @AuraEnabled public String EMailAddress
        { 
            get { return this.getString ('SMTP_ADDR'); } 
            set { this.Set (value, 'SMTP_ADDR'); }
        }

        @AuraEnabled public String DefaultCommunicationMethod
        { 
            get { return this.getString ('DEFLT_COMM'); } 
            set { this.Set (value, 'DEFLT_COMM'); }
        }

        @AuraEnabled public String DefaultCommunicationMethodDescription
        { 
            get { return this.getString ('DEFLT_COMM_TEXT'); } 
            set { this.Set (value, 'DEFLT_COMM_TEXT'); }
        }

        @AuraEnabled public String Extension1
        { 
            get { return this.getString ('EXTENSION1'); } 
            set { this.Set (value, 'EXTENSION1'); }
        }

        @AuraEnabled public String Extension2
        { 
            get { return this.getString ('EXTENSION2'); } 
            set { this.Set (value, 'EXTENSION2'); }
        }

        @AuraEnabled public String AddressNotes
        { 
            get { return this.getString ('REMARK'); } 
            set { this.Set (value, 'REMARK'); }
        }

    }
    public class CONTACTS_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public CONTACTS_COLLECTION()
        {
            super('CONTACTS', SBO_EnosixCustomer_Detail.CONTACTS.class, null);
        }

        @AuraEnabled public List<SBO_EnosixCustomer_Detail.CONTACTS> getAsList()
        {
            return (List<SBO_EnosixCustomer_Detail.CONTACTS>)this.buildList(List<SBO_EnosixCustomer_Detail.CONTACTS>.class);
        }
    }
    public class TAX_CLASSIFICATION extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixCustomer_Detail.TAX_CLASSIFICATION.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixCustomer_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'ALAND','COUNTRY_LANDX','TATYP','VTEXT','TAXKD','TAXKD_TEXT' };
    
            return keyFields;
        }

                @AuraEnabled public String CountryCode
        { 
            get { return this.getString ('ALAND'); } 
            set { this.Set (value, 'ALAND'); }
        }

        @AuraEnabled public String CountryName
        { 
            get { return this.getString ('COUNTRY_LANDX'); } 
            set { this.Set (value, 'COUNTRY_LANDX'); }
        }

        @AuraEnabled public String TaxCategory
        { 
            get { return this.getString ('TATYP'); } 
            set { this.Set (value, 'TATYP'); }
        }

        @AuraEnabled public String TaxCategoryName
        { 
            get { return this.getString ('VTEXT'); } 
            set { this.Set (value, 'VTEXT'); }
        }

        @AuraEnabled public String TaxClassification
        { 
            get { return this.getString ('TAXKD'); } 
            set { this.Set (value, 'TAXKD'); }
        }

        @AuraEnabled public String TaxClassificationDescription
        { 
            get { return this.getString ('TAXKD_TEXT'); } 
            set { this.Set (value, 'TAXKD_TEXT'); }
        }

    }
    public class TAX_CLASSIFICATION_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public TAX_CLASSIFICATION_COLLECTION()
        {
            super('TAX_CLASSIFICATION', SBO_EnosixCustomer_Detail.TAX_CLASSIFICATION.class, null);
        }

        @AuraEnabled public List<SBO_EnosixCustomer_Detail.TAX_CLASSIFICATION> getAsList()
        {
            return (List<SBO_EnosixCustomer_Detail.TAX_CLASSIFICATION>)this.buildList(List<SBO_EnosixCustomer_Detail.TAX_CLASSIFICATION>.class);
        }
    }
}