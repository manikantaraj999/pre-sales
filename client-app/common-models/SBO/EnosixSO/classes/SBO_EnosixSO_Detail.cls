/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class SBO_EnosixSO_Detail extends ensxsdk.EnosixFramework.DetailSBO
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('SBO_EnosixSO_Detail_Meta', new Type[] {
            SBO_EnosixSO_Detail.EnosixSO.class
            , SBO_EnosixSO_Detail.SALES.class
            , SBO_EnosixSO_Detail.SHIPPING.class
            , SBO_EnosixSO_Detail.BILLING.class
            , SBO_EnosixSO_Detail.ACCOUNTING.class
            , SBO_EnosixSO_Detail.CONDITIONS.class
            , SBO_EnosixSO_Detail.ACCOUNT_ASSIGNMENT.class
            , SBO_EnosixSO_Detail.PARTNERS.class
            , SBO_EnosixSO_Detail.TEXTS.class
            , SBO_EnosixSO_Detail.ORDERDATA.class
            , SBO_EnosixSO_Detail.STATUS.class
            , SBO_EnosixSO_Detail.ADDITIONAL_DATA_A.class
            , SBO_EnosixSO_Detail.ITEMS.class
            , SBO_EnosixSO_Detail.ITEMS_SCHEDULE.class
            , SBO_EnosixSO_Detail.ITEMS_TEXT.class
            , SBO_EnosixSO_Detail.MATERIAL_UOM.class
            , SBO_EnosixSO_Detail.CCARD.class
            , SBO_EnosixSO_Detail.ITEMS_ACTION.class
            , SBO_EnosixSO_Detail.ORDER_ACTION.class
            , SBO_EnosixSO_Detail.ITEMS_CONFIG.class
            , SBO_EnosixSO_Detail.INCOMPLETION_LOG.class
            } 
        );
    }

    public SBO_EnosixSO_Detail()
    {
        super('EnosixSO', SBO_EnosixSO_Detail.EnosixSO.class);
    }

    public override Type getType() { return SBO_EnosixSO_Detail.class; }

    public EnosixSO initialize(EnosixSO obj)
    {
        return (EnosixSO)this.executeInitialize(obj);
    }
    
    public EnosixSO getDetail(object key)
    {
        return (EnosixSO)this.executeGetDetail(key);
    }
    
    public EnosixSO save(EnosixSO obj)
    {
        return (EnosixSO) this.executeSave(obj);
    }

    public EnosixSO command(string command, EnosixSO obj)
    {
        return (EnosixSO) this.executeCommand(command, obj);
    }
    
    public with sharing class EnosixSO extends ensxsdk.EnosixFramework.DetailObject
    {
        public EnosixSO()
        {
            super('HEADER', new Map<string,type>
                {
                    'SALES' => SBO_EnosixSO_Detail.SALES.class
                    ,'SHIPPING' => SBO_EnosixSO_Detail.SHIPPING.class
                    ,'BILLING' => SBO_EnosixSO_Detail.BILLING.class
                    ,'ACCOUNTING' => SBO_EnosixSO_Detail.ACCOUNTING.class
                    ,'CONDITIONS' => SBO_EnosixSO_Detail.CONDITIONS_COLLECTION.class
                    ,'ACCOUNT_ASSIGNMENT' => SBO_EnosixSO_Detail.ACCOUNT_ASSIGNMENT.class
                    ,'PARTNERS' => SBO_EnosixSO_Detail.PARTNERS_COLLECTION.class
                    ,'TEXTS' => SBO_EnosixSO_Detail.TEXTS_COLLECTION.class
                    ,'ORDERDATA' => SBO_EnosixSO_Detail.ORDERDATA.class
                    ,'STATUS' => SBO_EnosixSO_Detail.STATUS.class
                    ,'ADDITIONAL_DATA_A' => SBO_EnosixSO_Detail.ADDITIONAL_DATA_A.class
                    ,'ITEMS' => SBO_EnosixSO_Detail.ITEMS_COLLECTION.class
                    ,'ITEMS_SCHEDULE' => SBO_EnosixSO_Detail.ITEMS_SCHEDULE_COLLECTION.class
                    ,'ITEMS_TEXT' => SBO_EnosixSO_Detail.ITEMS_TEXT_COLLECTION.class
                    ,'MATERIAL_UOM' => SBO_EnosixSO_Detail.MATERIAL_UOM_COLLECTION.class
                    ,'CCARD' => SBO_EnosixSO_Detail.CCARD_COLLECTION.class
                    ,'ITEMS_ACTION' => SBO_EnosixSO_Detail.ITEMS_ACTION_COLLECTION.class
                    ,'ORDER_ACTION' => SBO_EnosixSO_Detail.ORDER_ACTION.class
                    ,'ITEMS_CONFIG' => SBO_EnosixSO_Detail.ITEMS_CONFIG_COLLECTION.class
                    ,'INCOMPLETION_LOG' => SBO_EnosixSO_Detail.INCOMPLETION_LOG_COLLECTION.class
                });	
        }

        public override Type getType() { return SBO_EnosixSO_Detail.EnosixSO.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixSO_Detail.registerReflectionInfo();
        }

                @AuraEnabled public String SalesDocument
        { 
            get { return this.getString ('VBELN'); } 
            set { this.Set (value, 'VBELN'); }
        }

        @AuraEnabled public String SoldToParty
        { 
            get { return this.getString ('KUNAG'); } 
            set { this.Set (value, 'KUNAG'); }
        }

        @AuraEnabled public String SoldToPartyText
        { 
            get { return this.getString ('KUNAG_TXTPA'); } 
            set { this.Set (value, 'KUNAG_TXTPA'); }
        }

        @AuraEnabled public String CustomerPurchaseOrderNumber
        { 
            get { return this.getString ('BSTKD'); } 
            set { this.Set (value, 'BSTKD'); }
        }

        @AuraEnabled public Date CustomerPurchaseOrderDate
        { 
            get { return this.getDate ('BSTDK'); } 
            set { this.Set (value, 'BSTDK'); }
        }

        @AuraEnabled public Decimal NetOrderValue
        { 
            get { return this.getDecimal ('NETWR'); } 
            set { this.Set (value, 'NETWR'); }
        }

        @AuraEnabled public Decimal TaxAmount
        { 
            get { return this.getDecimal ('MWSBP'); } 
            set { this.Set (value, 'MWSBP'); }
        }

        @AuraEnabled public String SalesDocumentCurrency
        { 
            get { return this.getString ('WAERK'); } 
            set { this.Set (value, 'WAERK'); }
        }

        @AuraEnabled public String BillingPlan
        { 
            get { return this.getString ('RPLNR'); } 
            set { this.Set (value, 'RPLNR'); }
        }

        @AuraEnabled public String ReferenceDocument
        { 
            get { return this.getString ('REF_DOC'); } 
            set { this.Set (value, 'REF_DOC'); }
        }

        @AuraEnabled public String ReferenceDocumentCategory
        { 
            get { return this.getString ('REFDOC_CAT'); } 
            set { this.Set (value, 'REFDOC_CAT'); }
        }

        @AuraEnabled public String DocumentCategory
        { 
            get { return this.getString ('VBTYP'); } 
            set { this.Set (value, 'VBTYP'); }
        }

        @AuraEnabled public String DocumentCategoryDescription
        { 
            get { return this.getString ('VBTYP_TEXT'); } 
            set { this.Set (value, 'VBTYP_TEXT'); }
        }

        @AuraEnabled public String TransactionGroup
        { 
            get { return this.getString ('TRVOG'); } 
            set { this.Set (value, 'TRVOG'); }
        }

        @AuraEnabled public String TransactionGroupDescription
        { 
            get { return this.getString ('TRVOG_TEXT'); } 
            set { this.Set (value, 'TRVOG_TEXT'); }
        }


        @AuraEnabled public SBO_EnosixSO_Detail.SALES SALES 
        {
            get
            {
                return (SBO_EnosixSO_Detail.SALES)this.getStruct(SBO_EnosixSO_Detail.SALES.class);
            }
        }
        
    
        @AuraEnabled public SBO_EnosixSO_Detail.SHIPPING SHIPPING 
        {
            get
            {
                return (SBO_EnosixSO_Detail.SHIPPING)this.getStruct(SBO_EnosixSO_Detail.SHIPPING.class);
            }
        }
        
    
        @AuraEnabled public SBO_EnosixSO_Detail.BILLING BILLING 
        {
            get
            {
                return (SBO_EnosixSO_Detail.BILLING)this.getStruct(SBO_EnosixSO_Detail.BILLING.class);
            }
        }
        
    
        @AuraEnabled public SBO_EnosixSO_Detail.ACCOUNTING ACCOUNTING 
        {
            get
            {
                return (SBO_EnosixSO_Detail.ACCOUNTING)this.getStruct(SBO_EnosixSO_Detail.ACCOUNTING.class);
            }
        }
        
            @AuraEnabled public CONDITIONS_COLLECTION CONDITIONS
        {
            get 
            { 
                return (CONDITIONS_COLLECTION)this.getCollection(SBO_EnosixSO_Detail.CONDITIONS_COLLECTION.class); 
            }
        }

        
        @AuraEnabled public SBO_EnosixSO_Detail.ACCOUNT_ASSIGNMENT ACCOUNT_ASSIGNMENT 
        {
            get
            {
                return (SBO_EnosixSO_Detail.ACCOUNT_ASSIGNMENT)this.getStruct(SBO_EnosixSO_Detail.ACCOUNT_ASSIGNMENT.class);
            }
        }
        
            @AuraEnabled public PARTNERS_COLLECTION PARTNERS
        {
            get 
            { 
                return (PARTNERS_COLLECTION)this.getCollection(SBO_EnosixSO_Detail.PARTNERS_COLLECTION.class); 
            }
        }

                @AuraEnabled public TEXTS_COLLECTION TEXTS
        {
            get 
            { 
                return (TEXTS_COLLECTION)this.getCollection(SBO_EnosixSO_Detail.TEXTS_COLLECTION.class); 
            }
        }

        
        @AuraEnabled public SBO_EnosixSO_Detail.ORDERDATA ORDERDATA 
        {
            get
            {
                return (SBO_EnosixSO_Detail.ORDERDATA)this.getStruct(SBO_EnosixSO_Detail.ORDERDATA.class);
            }
        }
        
    
        @AuraEnabled public SBO_EnosixSO_Detail.STATUS STATUS 
        {
            get
            {
                return (SBO_EnosixSO_Detail.STATUS)this.getStruct(SBO_EnosixSO_Detail.STATUS.class);
            }
        }
        
    
        @AuraEnabled public SBO_EnosixSO_Detail.ADDITIONAL_DATA_A ADDITIONAL_DATA_A 
        {
            get
            {
                return (SBO_EnosixSO_Detail.ADDITIONAL_DATA_A)this.getStruct(SBO_EnosixSO_Detail.ADDITIONAL_DATA_A.class);
            }
        }
        
            @AuraEnabled public ITEMS_COLLECTION ITEMS
        {
            get 
            { 
                return (ITEMS_COLLECTION)this.getCollection(SBO_EnosixSO_Detail.ITEMS_COLLECTION.class); 
            }
        }

                @AuraEnabled public ITEMS_SCHEDULE_COLLECTION ITEMS_SCHEDULE
        {
            get 
            { 
                return (ITEMS_SCHEDULE_COLLECTION)this.getCollection(SBO_EnosixSO_Detail.ITEMS_SCHEDULE_COLLECTION.class); 
            }
        }

                @AuraEnabled public ITEMS_TEXT_COLLECTION ITEMS_TEXT
        {
            get 
            { 
                return (ITEMS_TEXT_COLLECTION)this.getCollection(SBO_EnosixSO_Detail.ITEMS_TEXT_COLLECTION.class); 
            }
        }

                @AuraEnabled public MATERIAL_UOM_COLLECTION MATERIAL_UOM
        {
            get 
            { 
                return (MATERIAL_UOM_COLLECTION)this.getCollection(SBO_EnosixSO_Detail.MATERIAL_UOM_COLLECTION.class); 
            }
        }

                @AuraEnabled public CCARD_COLLECTION CCARD
        {
            get 
            { 
                return (CCARD_COLLECTION)this.getCollection(SBO_EnosixSO_Detail.CCARD_COLLECTION.class); 
            }
        }

                @AuraEnabled public ITEMS_ACTION_COLLECTION ITEMS_ACTION
        {
            get 
            { 
                return (ITEMS_ACTION_COLLECTION)this.getCollection(SBO_EnosixSO_Detail.ITEMS_ACTION_COLLECTION.class); 
            }
        }

        
        @AuraEnabled public SBO_EnosixSO_Detail.ORDER_ACTION ORDER_ACTION 
        {
            get
            {
                return (SBO_EnosixSO_Detail.ORDER_ACTION)this.getStruct(SBO_EnosixSO_Detail.ORDER_ACTION.class);
            }
        }
        
            @AuraEnabled public ITEMS_CONFIG_COLLECTION ITEMS_CONFIG
        {
            get 
            { 
                return (ITEMS_CONFIG_COLLECTION)this.getCollection(SBO_EnosixSO_Detail.ITEMS_CONFIG_COLLECTION.class); 
            }
        }

                @AuraEnabled public INCOMPLETION_LOG_COLLECTION INCOMPLETION_LOG
        {
            get 
            { 
                return (INCOMPLETION_LOG_COLLECTION)this.getCollection(SBO_EnosixSO_Detail.INCOMPLETION_LOG_COLLECTION.class); 
            }
        }

            }

    //Write child objects
        public class SALES extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixSO_Detail.SALES.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixSO_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'EnosixObjKey' };
    
            return keyFields;
        }

                @AuraEnabled public String SalesDocumentType
        { 
            get { return this.getString ('AUART'); } 
            set { this.Set (value, 'AUART'); }
        }

        @AuraEnabled public String SalesDocumentTypeDescription
        { 
            get { return this.getString ('AUART_TEXT'); } 
            set { this.Set (value, 'AUART_TEXT'); }
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

        @AuraEnabled public String SalesGroup
        { 
            get { return this.getString ('VKGRP'); } 
            set { this.Set (value, 'VKGRP'); }
        }

        @AuraEnabled public String SalesGroupName
        { 
            get { return this.getString ('VKGRP_BEZEI'); } 
            set { this.Set (value, 'VKGRP_BEZEI'); }
        }

        @AuraEnabled public String SalesOffice
        { 
            get { return this.getString ('VKBUR'); } 
            set { this.Set (value, 'VKBUR'); }
        }

        @AuraEnabled public String SalesOfficeName
        { 
            get { return this.getString ('VKBUR_BEZEI'); } 
            set { this.Set (value, 'VKBUR_BEZEI'); }
        }

        @AuraEnabled public Date CreateDate
        { 
            get { return this.getDate ('ERDAT'); } 
            set { this.Set (value, 'ERDAT'); }
        }

        @AuraEnabled public Time EntryTime
        { 
            get { return this.getTime ('ERZET'); } 
            set { this.Set (value, 'ERZET'); }
        }

        @AuraEnabled public String CreatedBy
        { 
            get { return this.getString ('ERNAM'); } 
            set { this.Set (value, 'ERNAM'); }
        }

        @AuraEnabled public Date ValidFrom
        { 
            get { return this.getDate ('ANGDT'); } 
            set { this.Set (value, 'ANGDT'); }
        }

        @AuraEnabled public Date ValidTo
        { 
            get { return this.getDate ('BNDDT'); } 
            set { this.Set (value, 'BNDDT'); }
        }

        @AuraEnabled public String SalesDocumentVersionNumber
        { 
            get { return this.getString ('VSNMR_V'); } 
            set { this.Set (value, 'VSNMR_V'); }
        }

        @AuraEnabled public Date WarrantyDate
        { 
            get { return this.getDate ('GWLDT'); } 
            set { this.Set (value, 'GWLDT'); }
        }

        @AuraEnabled public String OrderReason
        { 
            get { return this.getString ('AUGRU'); } 
            set { this.Set (value, 'AUGRU'); }
        }

        @AuraEnabled public String OrderReasonDescription
        { 
            get { return this.getString ('AUGRU_BEZEI'); } 
            set { this.Set (value, 'AUGRU_BEZEI'); }
        }

        @AuraEnabled public String AgreedDeliveryTime
        { 
            get { return this.getString ('DELCO'); } 
            set { this.Set (value, 'DELCO'); }
        }

        @AuraEnabled public String AgreedDeliveryTimeDescription
        { 
            get { return this.getString ('DELCO_BEZEI'); } 
            set { this.Set (value, 'DELCO_BEZEI'); }
        }

        @AuraEnabled public String SalesDocumentCurrency
        { 
            get { return this.getString ('WAERK'); } 
            set { this.Set (value, 'WAERK'); }
        }

        @AuraEnabled public Decimal ExchangeRatePriceDetermination
        { 
            get { return this.getDecimal ('KURSK'); } 
            set { this.Set (value, 'KURSK'); }
        }

        @AuraEnabled public Date DateforPricingExchangeRate
        { 
            get { return this.getDate ('PRSDT'); } 
            set { this.Set (value, 'PRSDT'); }
        }

        @AuraEnabled public String PricingProcedureInPricing
        { 
            get { return this.getString ('KALSM'); } 
            set { this.Set (value, 'KALSM'); }
        }

        @AuraEnabled public String PricingProcedureInPricingDesc
        { 
            get { return this.getString ('KALSM_VTEXT'); } 
            set { this.Set (value, 'KALSM_VTEXT'); }
        }

        @AuraEnabled public String CustomerGroup
        { 
            get { return this.getString ('KDGRP'); } 
            set { this.Set (value, 'KDGRP'); }
        }

        @AuraEnabled public String CustomerGroupName
        { 
            get { return this.getString ('KDGRP_KTEXT'); } 
            set { this.Set (value, 'KDGRP_KTEXT'); }
        }

        @AuraEnabled public String PriceListType
        { 
            get { return this.getString ('PLTYP'); } 
            set { this.Set (value, 'PLTYP'); }
        }

        @AuraEnabled public String PriceListTypeText
        { 
            get { return this.getString ('PLTYP_PTEXT'); } 
            set { this.Set (value, 'PLTYP_PTEXT'); }
        }

        @AuraEnabled public String UsageIndicator
        { 
            get { return this.getString ('ABRVW'); } 
            set { this.Set (value, 'ABRVW'); }
        }

        @AuraEnabled public String UsageIndicatorDescription
        { 
            get { return this.getString ('ABRVW_BEZEI'); } 
            set { this.Set (value, 'ABRVW_BEZEI'); }
        }

        @AuraEnabled public String PriceGroup
        { 
            get { return this.getString ('KONDA'); } 
            set { this.Set (value, 'KONDA'); }
        }

        @AuraEnabled public String PriceGroupDescription
        { 
            get { return this.getString ('KONDA_VTEXT'); } 
            set { this.Set (value, 'KONDA_VTEXT'); }
        }

        @AuraEnabled public String SalesDistrict
        { 
            get { return this.getString ('BZIRK'); } 
            set { this.Set (value, 'BZIRK'); }
        }

        @AuraEnabled public String SalesDistrictName
        { 
            get { return this.getString ('BZTXT'); } 
            set { this.Set (value, 'BZTXT'); }
        }

        @AuraEnabled public Date RequestedDeliveryDate
        { 
            get { return this.getDate ('VDATU'); } 
            set { this.Set (value, 'VDATU'); }
        }

        @AuraEnabled public String DeliveryBlock
        { 
            get { return this.getString ('LIFSK'); } 
            set { this.Set (value, 'LIFSK'); }
        }

        @AuraEnabled public String DeliveryBlockDescription
        { 
            get { return this.getString ('LIFSK_VTEXT'); } 
            set { this.Set (value, 'LIFSK_VTEXT'); }
        }

        @AuraEnabled public String BillingBlock
        { 
            get { return this.getString ('FAKSK'); } 
            set { this.Set (value, 'FAKSK'); }
        }

        @AuraEnabled public String BillingBlockDescription
        { 
            get { return this.getString ('FAKSK_VTEXT'); } 
            set { this.Set (value, 'FAKSK_VTEXT'); }
        }

        @AuraEnabled public String TermsofPaymentKey
        { 
            get { return this.getString ('ZTERM'); } 
            set { this.Set (value, 'ZTERM'); }
        }

        @AuraEnabled public String TermsofPaymentKeyDescription
        { 
            get { return this.getString ('ZTERM_VTEXT'); } 
            set { this.Set (value, 'ZTERM_VTEXT'); }
        }

        @AuraEnabled public String IncotermsPart1
        { 
            get { return this.getString ('INCO1'); } 
            set { this.Set (value, 'INCO1'); }
        }

        @AuraEnabled public String IncotermsPart1Description
        { 
            get { return this.getString ('INCO1_BEZEI'); } 
            set { this.Set (value, 'INCO1_BEZEI'); }
        }

        @AuraEnabled public String IncotermsPart2
        { 
            get { return this.getString ('INCO2'); } 
            set { this.Set (value, 'INCO2'); }
        }

    }
    public class SHIPPING extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixSO_Detail.SHIPPING.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixSO_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'EnosixObjKey' };
    
            return keyFields;
        }

                @AuraEnabled public String ShipToParty
        { 
            get { return this.getString ('KUNWE'); } 
            set { this.Set (value, 'KUNWE'); }
        }

        @AuraEnabled public String ShipToPartyText
        { 
            get { return this.getString ('KUNWE_TXTPA'); } 
            set { this.Set (value, 'KUNWE_TXTPA'); }
        }

        @AuraEnabled public String UnloadingPoint
        { 
            get { return this.getString ('ABLAD'); } 
            set { this.Set (value, 'ABLAD'); }
        }

        @AuraEnabled public String ReceivingPoint
        { 
            get { return this.getString ('EMPST'); } 
            set { this.Set (value, 'EMPST'); }
        }

        @AuraEnabled public String DepartmentNumber
        { 
            get { return this.getString ('ABTNR'); } 
            set { this.Set (value, 'ABTNR'); }
        }

        @AuraEnabled public String DepartmentNumberDescription
        { 
            get { return this.getString ('ABTNR_VTEXT'); } 
            set { this.Set (value, 'ABTNR_VTEXT'); }
        }

        @AuraEnabled public String DeliveryBlock
        { 
            get { return this.getString ('LIFSK'); } 
            set { this.Set (value, 'LIFSK'); }
        }

        @AuraEnabled public String DeliveryBlockDescription
        { 
            get { return this.getString ('LIFSK_VTEXT'); } 
            set { this.Set (value, 'LIFSK_VTEXT'); }
        }

        @AuraEnabled public String ShippingConditions
        { 
            get { return this.getString ('VSBED'); } 
            set { this.Set (value, 'VSBED'); }
        }

        @AuraEnabled public String ShippingConditionsDescription
        { 
            get { return this.getString ('VSBED_VTEXT'); } 
            set { this.Set (value, 'VSBED_VTEXT'); }
        }

        @AuraEnabled public String DangerousGoodsMngmntProfile
        { 
            get { return this.getString ('PROLI'); } 
            set { this.Set (value, 'PROLI'); }
        }

        @AuraEnabled public String DangerousGoodsMngmntProfDesc
        { 
            get { return this.getString ('PROBZ'); } 
            set { this.Set (value, 'PROBZ'); }
        }

        @AuraEnabled public String MeansofTransportType
        { 
            get { return this.getString ('TRATY'); } 
            set { this.Set (value, 'TRATY'); }
        }

        @AuraEnabled public String MeansofTransportTypDescription
        { 
            get { return this.getString ('TRATY_VTEXT'); } 
            set { this.Set (value, 'TRATY_VTEXT'); }
        }

        @AuraEnabled public String MeansofTransport
        { 
            get { return this.getString ('TRMTYP'); } 
            set { this.Set (value, 'TRMTYP'); }
        }

        @AuraEnabled public String MeansofTransportDescription
        { 
            get { return this.getString ('TRMTYP_MAKTX'); } 
            set { this.Set (value, 'TRMTYP_MAKTX'); }
        }

        @AuraEnabled public Boolean RelevantforPODprocessing
        { 
            get { return this.getBoolean('PODKZ'); } 
            set { this.setBoolean(value, 'PODKZ'); }
        }

        @AuraEnabled public Boolean CompleteDeliveryDefined
        { 
            get { return this.getBoolean('AUTLF'); } 
            set { this.setBoolean(value, 'AUTLF'); }
        }

        @AuraEnabled public Boolean OrderCombinationIndicator
        { 
            get { return this.getBoolean('KZAZU'); } 
            set { this.setBoolean(value, 'KZAZU'); }
        }

        @AuraEnabled public String DocumentContainsDangerousGoods
        { 
            get { return this.getString ('CONT_DG'); } 
            set { this.Set (value, 'CONT_DG'); }
        }

        @AuraEnabled public String ShippingType
        { 
            get { return this.getString ('VSART'); } 
            set { this.Set (value, 'VSART'); }
        }

        @AuraEnabled public String ShippingTypeDescription
        { 
            get { return this.getString ('VSART_BEZEI'); } 
            set { this.Set (value, 'VSART_BEZEI'); }
        }

        @AuraEnabled public String SpecialProcessing
        { 
            get { return this.getString ('SDABW'); } 
            set { this.Set (value, 'SDABW'); }
        }

        @AuraEnabled public String SpecialProcessingDescription
        { 
            get { return this.getString ('SDABW_BEZEI'); } 
            set { this.Set (value, 'SDABW_BEZEI'); }
        }

        @AuraEnabled public Decimal TotalWeight
        { 
            get { return this.getDecimal ('BTGEW'); } 
            set { this.Set (value, 'BTGEW'); }
        }

        @AuraEnabled public String WeightUnit
        { 
            get { return this.getString ('GEWEI'); } 
            set { this.Set (value, 'GEWEI'); }
        }

        @AuraEnabled public Decimal Netweight
        { 
            get { return this.getDecimal ('NTGEW'); } 
            set { this.Set (value, 'NTGEW'); }
        }

        @AuraEnabled public Decimal Volume
        { 
            get { return this.getDecimal ('VOLUM'); } 
            set { this.Set (value, 'VOLUM'); }
        }

        @AuraEnabled public String VolumeUnit
        { 
            get { return this.getString ('VOLEH'); } 
            set { this.Set (value, 'VOLEH'); }
        }

    }
    public class BILLING extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixSO_Detail.BILLING.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixSO_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'EnosixObjKey' };
    
            return keyFields;
        }

                @AuraEnabled public String Payer
        { 
            get { return this.getString ('KUNRG'); } 
            set { this.Set (value, 'KUNRG'); }
        }

        @AuraEnabled public String PayerDisplayText
        { 
            get { return this.getString ('KUNRG_TXTPA'); } 
            set { this.Set (value, 'KUNRG_TXTPA'); }
        }

        @AuraEnabled public String IncotermsPart1
        { 
            get { return this.getString ('INCO1'); } 
            set { this.Set (value, 'INCO1'); }
        }

        @AuraEnabled public String IncotermsPart1Description
        { 
            get { return this.getString ('INCO1_BEZEI'); } 
            set { this.Set (value, 'INCO1_BEZEI'); }
        }

        @AuraEnabled public String IncotermsPart2
        { 
            get { return this.getString ('INCO2'); } 
            set { this.Set (value, 'INCO2'); }
        }

        @AuraEnabled public Date FixedValueDate
        { 
            get { return this.getDate ('VALDT'); } 
            set { this.Set (value, 'VALDT'); }
        }

        @AuraEnabled public String TermsofPaymentKey
        { 
            get { return this.getString ('ZTERM'); } 
            set { this.Set (value, 'ZTERM'); }
        }

        @AuraEnabled public String TermsofPaymentKeyDescription
        { 
            get { return this.getString ('ZTERM_VTEXT'); } 
            set { this.Set (value, 'ZTERM_VTEXT'); }
        }

        @AuraEnabled public String AdditionalValueDays
        { 
            get { return this.getString ('VALTG'); } 
            set { this.Set (value, 'VALTG'); }
        }

        @AuraEnabled public String BillingBlock
        { 
            get { return this.getString ('FAKSK'); } 
            set { this.Set (value, 'FAKSK'); }
        }

        @AuraEnabled public String BillingBlockDescription
        { 
            get { return this.getString ('FAKSK_VTEXT'); } 
            set { this.Set (value, 'FAKSK_VTEXT'); }
        }

        @AuraEnabled public String InvoiceDates
        { 
            get { return this.getString ('PERFK'); } 
            set { this.Set (value, 'PERFK'); }
        }

        @AuraEnabled public String InvoiceDatesText
        { 
            get { return this.getString ('PERFK_LTEXT'); } 
            set { this.Set (value, 'PERFK_LTEXT'); }
        }

        @AuraEnabled public Date BillingDate
        { 
            get { return this.getDate ('FKDAT'); } 
            set { this.Set (value, 'FKDAT'); }
        }

        @AuraEnabled public String CompanyCodeToBeBilled
        { 
            get { return this.getString ('BUKRS_VF'); } 
            set { this.Set (value, 'BUKRS_VF'); }
        }

        @AuraEnabled public String CompanyCodeToBeBilledText
        { 
            get { return this.getString ('BUKRS_VF_LTEXT'); } 
            set { this.Set (value, 'BUKRS_VF_LTEXT'); }
        }

        @AuraEnabled public Date DateOnWhichServicesRendered
        { 
            get { return this.getDate ('FBUDA'); } 
            set { this.Set (value, 'FBUDA'); }
        }

        @AuraEnabled public String AlternativeTaxClassification
        { 
            get { return this.getString ('TAXK1'); } 
            set { this.Set (value, 'TAXK1'); }
        }

        @AuraEnabled public String AltTaxClassificationDescription
        { 
            get { return this.getString ('TAXK1_VTEXT'); } 
            set { this.Set (value, 'TAXK1_VTEXT'); }
        }

        @AuraEnabled public String TaxDepartureCountry
        { 
            get { return this.getString ('LANDTX'); } 
            set { this.Set (value, 'LANDTX'); }
        }

        @AuraEnabled public String TaxDepartureCountryName
        { 
            get { return this.getString ('LANDTX_LANDX'); } 
            set { this.Set (value, 'LANDTX_LANDX'); }
        }

        @AuraEnabled public String TaxDestinationCountry
        { 
            get { return this.getString ('STCEG_L'); } 
            set { this.Set (value, 'STCEG_L'); }
        }

        @AuraEnabled public String TaxDestinationCountryName
        { 
            get { return this.getString ('STCEG_L_LANDX'); } 
            set { this.Set (value, 'STCEG_L_LANDX'); }
        }

        @AuraEnabled public Boolean TriangularDeal
        { 
            get { return this.getBoolean('XEGDR'); } 
            set { this.setBoolean(value, 'XEGDR'); }
        }

        @AuraEnabled public String PaymentGuaranteeProcedure
        { 
            get { return this.getString ('ABSSC'); } 
            set { this.Set (value, 'ABSSC'); }
        }

        @AuraEnabled public String PaymentGuaranteeProcedureDesc
        { 
            get { return this.getString ('ABSSC_BEZEI'); } 
            set { this.Set (value, 'ABSSC_BEZEI'); }
        }

        @AuraEnabled public String InternalfinancialDocNumber
        { 
            get { return this.getString ('LCNUM'); } 
            set { this.Set (value, 'LCNUM'); }
        }

        @AuraEnabled public Decimal DepreciationPercentage
        { 
            get { return this.getDecimal ('AKPRZ'); } 
            set { this.Set (value, 'AKPRZ'); }
        }

    }
    public class ACCOUNTING extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixSO_Detail.ACCOUNTING.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixSO_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'EnosixObjKey' };
    
            return keyFields;
        }

                @AuraEnabled public String AccountAssignmentGroup
        { 
            get { return this.getString ('KTGRD'); } 
            set { this.Set (value, 'KTGRD'); }
        }

        @AuraEnabled public String AccountAssignmentGroupDesc
        { 
            get { return this.getString ('KTGRD_VTEXT'); } 
            set { this.Set (value, 'KTGRD_VTEXT'); }
        }

        @AuraEnabled public String PaymentMethod
        { 
            get { return this.getString ('ZLSCH'); } 
            set { this.Set (value, 'ZLSCH'); }
        }

        @AuraEnabled public String PaymentMethodDescription
        { 
            get { return this.getString ('ZLSCH_TEXT2'); } 
            set { this.Set (value, 'ZLSCH_TEXT2'); }
        }

        @AuraEnabled public String PostingPeriod
        { 
            get { return this.getString ('POPER'); } 
            set { this.Set (value, 'POPER'); }
        }

        @AuraEnabled public String FiscalYear
        { 
            get { return this.getString ('GJAHR'); } 
            set { this.Set (value, 'GJAHR'); }
        }

        @AuraEnabled public String AssignmentNumber
        { 
            get { return this.getString ('ZUONR'); } 
            set { this.Set (value, 'ZUONR'); }
        }

        @AuraEnabled public Decimal ExchangeRateforFIpostings
        { 
            get { return this.getDecimal ('KURRF'); } 
            set { this.Set (value, 'KURRF'); }
        }

        @AuraEnabled public String DunningKey
        { 
            get { return this.getString ('MSCHL'); } 
            set { this.Set (value, 'MSCHL'); }
        }

        @AuraEnabled public String DunningKeyText
        { 
            get { return this.getString ('MSCHL_TEXT1'); } 
            set { this.Set (value, 'MSCHL_TEXT1'); }
        }

        @AuraEnabled public String DunningBlock
        { 
            get { return this.getString ('MANSP'); } 
            set { this.Set (value, 'MANSP'); }
        }

        @AuraEnabled public String DunningBlockText
        { 
            get { return this.getString ('MANSP_TEXT1'); } 
            set { this.Set (value, 'MANSP_TEXT1'); }
        }

        @AuraEnabled public String ReferenceDocumentNumber
        { 
            get { return this.getString ('XBLNR'); } 
            set { this.Set (value, 'XBLNR'); }
        }

    }
    public class CONDITIONS extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixSO_Detail.CONDITIONS.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixSO_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'KPOSN','STUNR','ZAEHK','KSCHL' };
    
            return keyFields;
        }

                @AuraEnabled public String ConditionNumber
        { 
            get { return this.getString ('KNUMV'); } 
            set { this.Set (value, 'KNUMV'); }
        }

        @AuraEnabled public String ConditionItemNumber
        { 
            get { return this.getString ('KPOSN'); } 
            set { this.Set (value, 'KPOSN'); }
        }

        @AuraEnabled public String StepNumber
        { 
            get { return this.getString ('STUNR'); } 
            set { this.Set (value, 'STUNR'); }
        }

        @AuraEnabled public String ConditionCounter
        { 
            get { return this.getString ('ZAEHK'); } 
            set { this.Set (value, 'ZAEHK'); }
        }

        @AuraEnabled public String ConditionType
        { 
            get { return this.getString ('KSCHL'); } 
            set { this.Set (value, 'KSCHL'); }
        }

        @AuraEnabled public String ConditionTypeName
        { 
            get { return this.getString ('KSCHL_VTEXT'); } 
            set { this.Set (value, 'KSCHL_VTEXT'); }
        }

        @AuraEnabled public Decimal Rate
        { 
            get { return this.getDecimal ('KBETR'); } 
            set { this.Set (value, 'KBETR'); }
        }

        @AuraEnabled public String RateUnit
        { 
            get { return this.getString ('KOEIN'); } 
            set { this.Set (value, 'KOEIN'); }
        }

        @AuraEnabled public Decimal ConditionPricingUnit
        { 
            get { return this.getDecimal ('KPEIN'); } 
            set { this.Set (value, 'KPEIN'); }
        }

        @AuraEnabled public String ConditionUnit
        { 
            get { return this.getString ('KMEIN'); } 
            set { this.Set (value, 'KMEIN'); }
        }

        @AuraEnabled public Decimal ConditionValue
        { 
            get { return this.getDecimal ('KWERT'); } 
            set { this.Set (value, 'KWERT'); }
        }

        @AuraEnabled public String CurrencyKey
        { 
            get { return this.getString ('WAERS'); } 
            set { this.Set (value, 'WAERS'); }
        }

        @AuraEnabled public Decimal CondValueforCumulationFields
        { 
            get { return this.getDecimal ('KWERT_K'); } 
            set { this.Set (value, 'KWERT_K'); }
        }

        @AuraEnabled public String CondCurrencyforCumulationFlds
        { 
            get { return this.getString ('KWAEH'); } 
            set { this.Set (value, 'KWAEH'); }
        }

        @AuraEnabled public Boolean ConditionStatistics
        { 
            get { return this.getBoolean('KSTAT'); } 
            set { this.setBoolean(value, 'KSTAT'); }
        }

        @AuraEnabled public String CalculationType
        { 
            get { return this.getString ('KRECH'); } 
            set { this.Set (value, 'KRECH'); }
        }

        @AuraEnabled public String ManualEntries
        { 
            get { return this.getString ('KMANU'); } 
            set { this.Set (value, 'KMANU'); }
        }

        @AuraEnabled public String ConditionControl
        { 
            get { return this.getString ('KSTEU'); } 
            set { this.Set (value, 'KSTEU'); }
        }

        @AuraEnabled public String KHERK
        { 
            get { return this.getString ('KHERK'); } 
            set { this.Set (value, 'KHERK'); }
        }

    }
    public class CONDITIONS_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public CONDITIONS_COLLECTION()
        {
            super('CONDITIONS', SBO_EnosixSO_Detail.CONDITIONS.class, null);
        }

        @AuraEnabled public List<SBO_EnosixSO_Detail.CONDITIONS> getAsList()
        {
            return (List<SBO_EnosixSO_Detail.CONDITIONS>)this.buildList(List<SBO_EnosixSO_Detail.CONDITIONS>.class);
        }
    }
    public class ACCOUNT_ASSIGNMENT extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixSO_Detail.ACCOUNT_ASSIGNMENT.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixSO_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'EnosixObjKey' };
    
            return keyFields;
        }

                @AuraEnabled public String BusinessArea
        { 
            get { return this.getString ('GSBER'); } 
            set { this.Set (value, 'GSBER'); }
        }

        @AuraEnabled public String WBSElementInternal
        { 
            get { return this.getString ('PS_PSP_PNR'); } 
            set { this.Set (value, 'PS_PSP_PNR'); }
        }

        @AuraEnabled public String WBSElement
        { 
            get { return this.getString ('POSID'); } 
            set { this.Set (value, 'POSID'); }
        }

        @AuraEnabled public String WBSElementDescription
        { 
            get { return this.getString ('POST1'); } 
            set { this.Set (value, 'POST1'); }
        }

    }
    public class PARTNERS extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixSO_Detail.PARTNERS.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixSO_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'PARVW','KUNNR','LIFNR','PERNR','PARNR' };
    
            return keyFields;
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

        @AuraEnabled public String CustomerNumber
        { 
            get { return this.getString ('KUNNR'); } 
            set { this.Set (value, 'KUNNR'); }
        }

        @AuraEnabled public String Vendor
        { 
            get { return this.getString ('LIFNR'); } 
            set { this.Set (value, 'LIFNR'); }
        }

        @AuraEnabled public String PersonnelNumber
        { 
            get { return this.getString ('PERNR'); } 
            set { this.Set (value, 'PERNR'); }
        }

        @AuraEnabled public String ContactPersonNumber
        { 
            get { return this.getString ('PARNR'); } 
            set { this.Set (value, 'PARNR'); }
        }

        @AuraEnabled public String PartnerName
        { 
            get { return this.getString ('NAME1'); } 
            set { this.Set (value, 'NAME1'); }
        }

        @AuraEnabled public String PartnerName2
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

        @AuraEnabled public String District
        { 
            get { return this.getString ('DISTRICT'); } 
            set { this.Set (value, 'DISTRICT'); }
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

        @AuraEnabled public String TelephoneNumber
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

        @AuraEnabled public String ItemNumber
        { 
            get { return this.getString ('POSNR'); } 
            set { this.Set (value, 'POSNR'); }
        }

    }
    public class PARTNERS_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public PARTNERS_COLLECTION()
        {
            super('PARTNERS', SBO_EnosixSO_Detail.PARTNERS.class, null);
        }

        @AuraEnabled public List<SBO_EnosixSO_Detail.PARTNERS> getAsList()
        {
            return (List<SBO_EnosixSO_Detail.PARTNERS>)this.buildList(List<SBO_EnosixSO_Detail.PARTNERS>.class);
        }
    }
    public class TEXTS extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixSO_Detail.TEXTS.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixSO_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'TDID','TDSPRAS' };
    
            return keyFields;
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

        @AuraEnabled public String Text
        { 
            get { return this.getString ('TEXT'); } 
            set { this.Set (value, 'TEXT'); }
        }

    }
    public class TEXTS_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public TEXTS_COLLECTION()
        {
            super('TEXTS', SBO_EnosixSO_Detail.TEXTS.class, null);
        }

        @AuraEnabled public List<SBO_EnosixSO_Detail.TEXTS> getAsList()
        {
            return (List<SBO_EnosixSO_Detail.TEXTS>)this.buildList(List<SBO_EnosixSO_Detail.TEXTS>.class);
        }
    }
    public class ORDERDATA extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixSO_Detail.ORDERDATA.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixSO_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'EnosixObjKey' };
    
            return keyFields;
        }

                @AuraEnabled public String CustomerPurchaseOrderNumber
        { 
            get { return this.getString ('BSTKD'); } 
            set { this.Set (value, 'BSTKD'); }
        }

        @AuraEnabled public Date CustomerPurchaseOrderDate
        { 
            get { return this.getDate ('BSTDK'); } 
            set { this.Set (value, 'BSTDK'); }
        }

        @AuraEnabled public String CustomerPurchaseOrderType
        { 
            get { return this.getString ('BSARK'); } 
            set { this.Set (value, 'BSARK'); }
        }

        @AuraEnabled public String PurchaseOrderNumberSupplement
        { 
            get { return this.getString ('BSTZD'); } 
            set { this.Set (value, 'BSTZD'); }
        }

        @AuraEnabled public Date LastCustomerContactDate
        { 
            get { return this.getDate ('MAHDT'); } 
            set { this.Set (value, 'MAHDT'); }
        }

        @AuraEnabled public Decimal NumberOfContactsFromCustomer
        { 
            get { return this.getDecimal ('MAHZA'); } 
            set { this.Set (value, 'MAHZA'); }
        }

        @AuraEnabled public String OrdererName
        { 
            get { return this.getString ('BNAME'); } 
            set { this.Set (value, 'BNAME'); }
        }

        @AuraEnabled public String CollectiveNumber
        { 
            get { return this.getString ('SUBMI'); } 
            set { this.Set (value, 'SUBMI'); }
        }

        @AuraEnabled public String YourReference
        { 
            get { return this.getString ('IHREZ'); } 
            set { this.Set (value, 'IHREZ'); }
        }

        @AuraEnabled public String TelephoneNumber
        { 
            get { return this.getString ('TELF1'); } 
            set { this.Set (value, 'TELF1'); }
        }

        @AuraEnabled public String ShipToPurchaseOrderNumber
        { 
            get { return this.getString ('BSTKD_E'); } 
            set { this.Set (value, 'BSTKD_E'); }
        }

        @AuraEnabled public Date ShipToPODate
        { 
            get { return this.getDate ('BSTDK_E'); } 
            set { this.Set (value, 'BSTDK_E'); }
        }

        @AuraEnabled public String ShipToPurchaseOrderType
        { 
            get { return this.getString ('BSARK_E'); } 
            set { this.Set (value, 'BSARK_E'); }
        }

        @AuraEnabled public String ShipToCharacter
        { 
            get { return this.getString ('IHREZ_E'); } 
            set { this.Set (value, 'IHREZ_E'); }
        }

    }
    public class STATUS extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixSO_Detail.STATUS.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixSO_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'EnosixObjKey' };
    
            return keyFields;
        }

                @AuraEnabled public String OverallStatusDescription
        { 
            get { return this.getString ('GBSTA_BEZ'); } 
            set { this.Set (value, 'GBSTA_BEZ'); }
        }

        @AuraEnabled public String RejectionStatusDescription
        { 
            get { return this.getString ('ABSTA_BEZ'); } 
            set { this.Set (value, 'ABSTA_BEZ'); }
        }

        @AuraEnabled public String DeliveryStatusDescription
        { 
            get { return this.getString ('LFSTA_BEZ'); } 
            set { this.Set (value, 'LFSTA_BEZ'); }
        }

        @AuraEnabled public String CreditStatusDescription
        { 
            get { return this.getString ('CMGST_BEZ'); } 
            set { this.Set (value, 'CMGST_BEZ'); }
        }

        @AuraEnabled public String OveralBlockedStatusDescription
        { 
            get { return this.getString ('SPSTG_BEZ'); } 
            set { this.Set (value, 'SPSTG_BEZ'); }
        }

        @AuraEnabled public String DataCompleteDescription
        { 
            get { return this.getString ('UVALL_BEZ'); } 
            set { this.Set (value, 'UVALL_BEZ'); }
        }

        @AuraEnabled public String HeaderDeliveryDataCompleteDesc
        { 
            get { return this.getString ('UVVLK_BEZ'); } 
            set { this.Set (value, 'UVVLK_BEZ'); }
        }

        @AuraEnabled public String HeaderBillingCompleteDesc
        { 
            get { return this.getString ('UVFAK_BEZ'); } 
            set { this.Set (value, 'UVFAK_BEZ'); }
        }

        @AuraEnabled public String ItemDataCompleteDesc
        { 
            get { return this.getString ('UVALS_BEZ'); } 
            set { this.Set (value, 'UVALS_BEZ'); }
        }

        @AuraEnabled public String ItemDeliveryDataCompleteDesc
        { 
            get { return this.getString ('UVVLS_BEZ'); } 
            set { this.Set (value, 'UVVLS_BEZ'); }
        }

        @AuraEnabled public String ItemBillingDataCompleteDesc
        { 
            get { return this.getString ('UVFAS_BEZ'); } 
            set { this.Set (value, 'UVFAS_BEZ'); }
        }

    }
    public class ADDITIONAL_DATA_A extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixSO_Detail.ADDITIONAL_DATA_A.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixSO_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'EnosixObjKey' };
    
            return keyFields;
        }

                @AuraEnabled public String CustomerGroup1
        { 
            get { return this.getString ('KVGR1'); } 
            set { this.Set (value, 'KVGR1'); }
        }

        @AuraEnabled public String CustomerGroup1Description
        { 
            get { return this.getString ('KVGR1_BEZEI'); } 
            set { this.Set (value, 'KVGR1_BEZEI'); }
        }

        @AuraEnabled public String CustomerGroup2
        { 
            get { return this.getString ('KVGR2'); } 
            set { this.Set (value, 'KVGR2'); }
        }

        @AuraEnabled public String CustomerGroup2Description
        { 
            get { return this.getString ('KVGR2_BEZEI'); } 
            set { this.Set (value, 'KVGR2_BEZEI'); }
        }

        @AuraEnabled public String CustomerGroup3
        { 
            get { return this.getString ('KVGR3'); } 
            set { this.Set (value, 'KVGR3'); }
        }

        @AuraEnabled public String CustomerGroup3Description
        { 
            get { return this.getString ('KVGR3_BEZEI'); } 
            set { this.Set (value, 'KVGR3_BEZEI'); }
        }

        @AuraEnabled public String CustomerGroup4
        { 
            get { return this.getString ('KVGR4'); } 
            set { this.Set (value, 'KVGR4'); }
        }

        @AuraEnabled public String CustomerGroup4Description
        { 
            get { return this.getString ('KVGR4_BEZEI'); } 
            set { this.Set (value, 'KVGR4_BEZEI'); }
        }

        @AuraEnabled public String CustomerGroup5
        { 
            get { return this.getString ('KVGR5'); } 
            set { this.Set (value, 'KVGR5'); }
        }

        @AuraEnabled public String CustomerGroup5Description
        { 
            get { return this.getString ('KVGR5_BEZEI'); } 
            set { this.Set (value, 'KVGR5_BEZEI'); }
        }

        @AuraEnabled public String CustomerConditionGroup1
        { 
            get { return this.getString ('KDKG1'); } 
            set { this.Set (value, 'KDKG1'); }
        }

        @AuraEnabled public String CustomerConditionGroup1Description
        { 
            get { return this.getString ('KDKG1_VTEXT'); } 
            set { this.Set (value, 'KDKG1_VTEXT'); }
        }

        @AuraEnabled public String CustomerConditionGroup2
        { 
            get { return this.getString ('KDKG2'); } 
            set { this.Set (value, 'KDKG2'); }
        }

        @AuraEnabled public String CustomerConditionGroup2Description
        { 
            get { return this.getString ('KDKG2_VTEXT'); } 
            set { this.Set (value, 'KDKG2_VTEXT'); }
        }

        @AuraEnabled public String CustomerConditionGroup3
        { 
            get { return this.getString ('KDKG3'); } 
            set { this.Set (value, 'KDKG3'); }
        }

        @AuraEnabled public String CustomerConditionGroup3Description
        { 
            get { return this.getString ('KDKG3_VTEXT'); } 
            set { this.Set (value, 'KDKG3_VTEXT'); }
        }

        @AuraEnabled public String CustomerConditionGroup4
        { 
            get { return this.getString ('KDKG4'); } 
            set { this.Set (value, 'KDKG4'); }
        }

        @AuraEnabled public String CustomerConditionGroup4Description
        { 
            get { return this.getString ('KDKG4_VTEXT'); } 
            set { this.Set (value, 'KDKG4_VTEXT'); }
        }

        @AuraEnabled public String CustomerConditionGroup5
        { 
            get { return this.getString ('KDKG5'); } 
            set { this.Set (value, 'KDKG5'); }
        }

        @AuraEnabled public String CustomerConditionGroup5Description
        { 
            get { return this.getString ('KDKG5_VTEXT'); } 
            set { this.Set (value, 'KDKG5_VTEXT'); }
        }

    }
    public class ITEMS extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixSO_Detail.ITEMS.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixSO_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'POSNR' };
    
            return keyFields;
        }

                @AuraEnabled public String ItemNumber
        { 
            get { return this.getString ('POSNR'); } 
            set { this.Set (value, 'POSNR'); }
        }

        @AuraEnabled public String Material
        { 
            get { return this.getString ('MATNR'); } 
            set { this.Set (value, 'MATNR'); }
        }

        @AuraEnabled public Decimal OrderQuantity
        { 
            get { return this.getDecimal ('KWMENG'); } 
            set { this.Set (value, 'KWMENG'); }
        }

        @AuraEnabled public String SalesUnit
        { 
            get { return this.getString ('VRKME'); } 
            set { this.Set (value, 'VRKME'); }
        }

        @AuraEnabled public String SalesUnitDescription
        { 
            get { return this.getString ('VRKME_TXDIM'); } 
            set { this.Set (value, 'VRKME_TXDIM'); }
        }

        @AuraEnabled public Decimal TaxAmount
        { 
            get { return this.getDecimal ('MWSBP'); } 
            set { this.Set (value, 'MWSBP'); }
        }

        @AuraEnabled public String ItemDescription
        { 
            get { return this.getString ('ARKTX'); } 
            set { this.Set (value, 'ARKTX'); }
        }

        @AuraEnabled public String CustomerMaterialNumber
        { 
            get { return this.getString ('KDMAT'); } 
            set { this.Set (value, 'KDMAT'); }
        }

        @AuraEnabled public String ItemCategory
        { 
            get { return this.getString ('PSTYV'); } 
            set { this.Set (value, 'PSTYV'); }
        }

        @AuraEnabled public String ItemCategoryDescription
        { 
            get { return this.getString ('PSTYV_VTEXT'); } 
            set { this.Set (value, 'PSTYV_VTEXT'); }
        }

        @AuraEnabled public String DangerousGoodsIndicator
        { 
            get { return this.getString ('PROFL'); } 
            set { this.Set (value, 'PROFL'); }
        }

        @AuraEnabled public String HigherLevelItemNumber
        { 
            get { return this.getString ('UEPOS'); } 
            set { this.Set (value, 'UEPOS'); }
        }

        @AuraEnabled public Date ScheduleLineDate
        { 
            get { return this.getDate ('ETDAT'); } 
            set { this.Set (value, 'ETDAT'); }
        }

        @AuraEnabled public String Plant
        { 
            get { return this.getString ('WERKS'); } 
            set { this.Set (value, 'WERKS'); }
        }

        @AuraEnabled public String PlantName
        { 
            get { return this.getString ('WERKS_NAME'); } 
            set { this.Set (value, 'WERKS_NAME'); }
        }

        @AuraEnabled public String BatchNumber
        { 
            get { return this.getString ('CHARG'); } 
            set { this.Set (value, 'CHARG'); }
        }

        @AuraEnabled public String ConditionType
        { 
            get { return this.getString ('KSCHL'); } 
            set { this.Set (value, 'KSCHL'); }
        }

        @AuraEnabled public Decimal Rate
        { 
            get { return this.getDecimal ('KBETR'); } 
            set { this.Set (value, 'KBETR'); }
        }

        @AuraEnabled public String RateUnit
        { 
            get { return this.getString ('KOEIN'); } 
            set { this.Set (value, 'KOEIN'); }
        }

        @AuraEnabled public Decimal NetItemPrice
        { 
            get { return this.getDecimal ('NETPR'); } 
            set { this.Set (value, 'NETPR'); }
        }

        @AuraEnabled public Decimal ConditionPricingUnit
        { 
            get { return this.getDecimal ('KPEIN'); } 
            set { this.Set (value, 'KPEIN'); }
        }

        @AuraEnabled public String ConditionUnit
        { 
            get { return this.getString ('KMEIN'); } 
            set { this.Set (value, 'KMEIN'); }
        }

        @AuraEnabled public String ConditionUnitDescription
        { 
            get { return this.getString ('KMEIN_TXDIM'); } 
            set { this.Set (value, 'KMEIN_TXDIM'); }
        }

        @AuraEnabled public Decimal NetOrderValue
        { 
            get { return this.getDecimal ('NETWR'); } 
            set { this.Set (value, 'NETWR'); }
        }

        @AuraEnabled public String SalesDocumentCurrency
        { 
            get { return this.getString ('WAERK'); } 
            set { this.Set (value, 'WAERK'); }
        }

        @AuraEnabled public Decimal ConditionScaleQuantity
        { 
            get { return this.getDecimal ('KSTBS'); } 
            set { this.Set (value, 'KSTBS'); }
        }

        @AuraEnabled public String ReasonForRejection
        { 
            get { return this.getString ('ABGRU'); } 
            set { this.Set (value, 'ABGRU'); }
        }

        @AuraEnabled public String CustomerPurchaseOrderNumber
        { 
            get { return this.getString ('BSTKD'); } 
            set { this.Set (value, 'BSTKD'); }
        }

        @AuraEnabled public String CustomerPurchaseOrderItemNumber
        { 
            get { return this.getString ('POSEX'); } 
            set { this.Set (value, 'POSEX'); }
        }

        @AuraEnabled public String DeliveryBlockStatus
        { 
            get { return this.getString ('LSSTA'); } 
            set { this.Set (value, 'LSSTA'); }
        }

        @AuraEnabled public String DeliveryBlockStatusDescription
        { 
            get { return this.getString ('LSSTA_BEZ'); } 
            set { this.Set (value, 'LSSTA_BEZ'); }
        }

        @AuraEnabled public String BillingBlockStatus
        { 
            get { return this.getString ('FSSTA'); } 
            set { this.Set (value, 'FSSTA'); }
        }

        @AuraEnabled public String BillingBlockStatusDescription
        { 
            get { return this.getString ('FSSTA_BEZ'); } 
            set { this.Set (value, 'FSSTA_BEZ'); }
        }

        @AuraEnabled public String AgreedDeliveryTime
        { 
            get { return this.getString ('DELCO'); } 
            set { this.Set (value, 'DELCO'); }
        }

        @AuraEnabled public String AgreedDeliveryTimeDescription
        { 
            get { return this.getString ('DELCO_BEZEI'); } 
            set { this.Set (value, 'DELCO_BEZEI'); }
        }

        @AuraEnabled public String Materialgroup1
        { 
            get { return this.getString ('MVGR1'); } 
            set { this.Set (value, 'MVGR1'); }
        }

        @AuraEnabled public String Materialgroup1Description
        { 
            get { return this.getString ('MVGR1_BEZEI'); } 
            set { this.Set (value, 'MVGR1_BEZEI'); }
        }

        @AuraEnabled public String Materialgroup2
        { 
            get { return this.getString ('MVGR2'); } 
            set { this.Set (value, 'MVGR2'); }
        }

        @AuraEnabled public String Materialgroup2Description
        { 
            get { return this.getString ('MVGR2_BEZEI'); } 
            set { this.Set (value, 'MVGR2_BEZEI'); }
        }

        @AuraEnabled public String Materialgroup3
        { 
            get { return this.getString ('MVGR3'); } 
            set { this.Set (value, 'MVGR3'); }
        }

        @AuraEnabled public String Materialgroup3Description
        { 
            get { return this.getString ('MVGR3_BEZEI'); } 
            set { this.Set (value, 'MVGR3_BEZEI'); }
        }

        @AuraEnabled public String Materialgroup4
        { 
            get { return this.getString ('MVGR4'); } 
            set { this.Set (value, 'MVGR4'); }
        }

        @AuraEnabled public String Materialgroup4Description
        { 
            get { return this.getString ('MVGR4_BEZEI'); } 
            set { this.Set (value, 'MVGR4_BEZEI'); }
        }

        @AuraEnabled public String Materialgroup5
        { 
            get { return this.getString ('MVGR5'); } 
            set { this.Set (value, 'MVGR5'); }
        }

        @AuraEnabled public String Materialgroup5Description
        { 
            get { return this.getString ('MVGR5_BEZEI'); } 
            set { this.Set (value, 'MVGR5_BEZEI'); }
        }

        @AuraEnabled public String CustomerConditionGroup1
        { 
            get { return this.getString ('KDKG1'); } 
            set { this.Set (value, 'KDKG1'); }
        }

        @AuraEnabled public String CustomerConditionGroup1Description
        { 
            get { return this.getString ('KDKG1_VTEXT'); } 
            set { this.Set (value, 'KDKG1_VTEXT'); }
        }

        @AuraEnabled public String CustomerConditionGroup2
        { 
            get { return this.getString ('KDKG2'); } 
            set { this.Set (value, 'KDKG2'); }
        }

        @AuraEnabled public String CustomerConditionGroup2Description
        { 
            get { return this.getString ('KDKG2_VTEXT'); } 
            set { this.Set (value, 'KDKG2_VTEXT'); }
        }

        @AuraEnabled public String CustomerConditionGroup3
        { 
            get { return this.getString ('KDKG3'); } 
            set { this.Set (value, 'KDKG3'); }
        }

        @AuraEnabled public String CustomerConditionGroup3Description
        { 
            get { return this.getString ('KDKG3_VTEXT'); } 
            set { this.Set (value, 'KDKG3_VTEXT'); }
        }

        @AuraEnabled public String CustomerConditionGroup4
        { 
            get { return this.getString ('KDKG4'); } 
            set { this.Set (value, 'KDKG4'); }
        }

        @AuraEnabled public String CustomerConditionGroup4Description
        { 
            get { return this.getString ('KDKG4_VTEXT'); } 
            set { this.Set (value, 'KDKG4_VTEXT'); }
        }

        @AuraEnabled public String CustomerConditionGroup5
        { 
            get { return this.getString ('KDKG5'); } 
            set { this.Set (value, 'KDKG5'); }
        }

        @AuraEnabled public String CustomerConditionGroup5Description
        { 
            get { return this.getString ('KDKG5_VTEXT'); } 
            set { this.Set (value, 'KDKG5_VTEXT'); }
        }

        @AuraEnabled public String ProductHierarchy
        { 
            get { return this.getString ('PRODH'); } 
            set { this.Set (value, 'PRODH'); }
        }

        @AuraEnabled public String MaterialGroupHierarchy1
        { 
            get { return this.getString ('WGRU1'); } 
            set { this.Set (value, 'WGRU1'); }
        }

        @AuraEnabled public String MaterialGroupHierarchy2
        { 
            get { return this.getString ('WGRU2'); } 
            set { this.Set (value, 'WGRU2'); }
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

        @AuraEnabled public String WBSElementInternal
        { 
            get { return this.getString ('PS_PSP_PNR'); } 
            set { this.Set (value, 'PS_PSP_PNR'); }
        }

        @AuraEnabled public String WBSElement
        { 
            get { return this.getString ('POSID'); } 
            set { this.Set (value, 'POSID'); }
        }

        @AuraEnabled public String WBSElementDescription
        { 
            get { return this.getString ('POST1'); } 
            set { this.Set (value, 'POST1'); }
        }

        @AuraEnabled public String OrderNumber
        { 
            get { return this.getString ('AUFNR'); } 
            set { this.Set (value, 'AUFNR'); }
        }

        @AuraEnabled public String ProfitCenter
        { 
            get { return this.getString ('PRCTR'); } 
            set { this.Set (value, 'PRCTR'); }
        }

        @AuraEnabled public String MaterialPricingGroup
        { 
            get { return this.getString ('KONDM'); } 
            set { this.Set (value, 'KONDM'); }
        }

        @AuraEnabled public String MaterialPricingGroupDescription
        { 
            get { return this.getString ('KONDM_VTEXT'); } 
            set { this.Set (value, 'KONDM_VTEXT'); }
        }

        @AuraEnabled public String CustomerGroup
        { 
            get { return this.getString ('KDGRP'); } 
            set { this.Set (value, 'KDGRP'); }
        }

        @AuraEnabled public String CustomerGroupName
        { 
            get { return this.getString ('KDGRP_KTEXT'); } 
            set { this.Set (value, 'KDGRP_KTEXT'); }
        }

        @AuraEnabled public String PriceGroup
        { 
            get { return this.getString ('KONDA'); } 
            set { this.Set (value, 'KONDA'); }
        }

        @AuraEnabled public String PriceGroupDescription
        { 
            get { return this.getString ('KONDA_VTEXT'); } 
            set { this.Set (value, 'KONDA_VTEXT'); }
        }

        @AuraEnabled public String PriceListType
        { 
            get { return this.getString ('PLTYP'); } 
            set { this.Set (value, 'PLTYP'); }
        }

        @AuraEnabled public String PriceListTypeText
        { 
            get { return this.getString ('PLTYP_PTEXT'); } 
            set { this.Set (value, 'PLTYP_PTEXT'); }
        }

        @AuraEnabled public String SalesDistrict
        { 
            get { return this.getString ('BZIRK'); } 
            set { this.Set (value, 'BZIRK'); }
        }

        @AuraEnabled public String SalesDistrictName
        { 
            get { return this.getString ('BZIRK_BZTXT'); } 
            set { this.Set (value, 'BZIRK_BZTXT'); }
        }

        @AuraEnabled public Date CustomerPurchaseOrderDate
        { 
            get { return this.getDate ('BSTDK'); } 
            set { this.Set (value, 'BSTDK'); }
        }

        @AuraEnabled public String CustomerPurchaseOrderType
        { 
            get { return this.getString ('BSARK'); } 
            set { this.Set (value, 'BSARK'); }
        }

        @AuraEnabled public String CustomerPurchaseOrderTypeDesc
        { 
            get { return this.getString ('BSARK_VTEXT'); } 
            set { this.Set (value, 'BSARK_VTEXT'); }
        }

        @AuraEnabled public String ShipToPurchaseOrderNumber
        { 
            get { return this.getString ('BSTKD_E'); } 
            set { this.Set (value, 'BSTKD_E'); }
        }

        @AuraEnabled public Date ShipToPODate
        { 
            get { return this.getDate ('BSTDK_E'); } 
            set { this.Set (value, 'BSTDK_E'); }
        }

        @AuraEnabled public String ShipToPurchaseOrderType
        { 
            get { return this.getString ('BSARK_E'); } 
            set { this.Set (value, 'BSARK_E'); }
        }

        @AuraEnabled public String ShipToPurchaseOrderTypeDesc
        { 
            get { return this.getString ('BSARK_E_VTEXT'); } 
            set { this.Set (value, 'BSARK_E_VTEXT'); }
        }

        @AuraEnabled public String ShipToPurchaseOrderItemNumber
        { 
            get { return this.getString ('POSEX_E'); } 
            set { this.Set (value, 'POSEX_E'); }
        }

        @AuraEnabled public String StorageLocation
        { 
            get { return this.getString ('LGORT'); } 
            set { this.Set (value, 'LGORT'); }
        }

        @AuraEnabled public String StorageLocationDescription
        { 
            get { return this.getString ('LGOBE'); } 
            set { this.Set (value, 'LGOBE'); }
        }

        @AuraEnabled public String DeliveryPriority
        { 
            get { return this.getString ('LPRIO'); } 
            set { this.Set (value, 'LPRIO'); }
        }

        @AuraEnabled public String DeliveryPriorityDescription
        { 
            get { return this.getString ('LPRIO_BEZEI'); } 
            set { this.Set (value, 'LPRIO_BEZEI'); }
        }

        @AuraEnabled public String ShippingPoint
        { 
            get { return this.getString ('VSTEL'); } 
            set { this.Set (value, 'VSTEL'); }
        }

        @AuraEnabled public String ShippingPointDescription
        { 
            get { return this.getString ('VSTEL_VTEXT'); } 
            set { this.Set (value, 'VSTEL_VTEXT'); }
        }

        @AuraEnabled public String PartialDelivery
        { 
            get { return this.getString ('KZTLF'); } 
            set { this.Set (value, 'KZTLF'); }
        }

        @AuraEnabled public String PartialDeliveryDescription
        { 
            get { return this.getString ('KZTLF_DDTEXT'); } 
            set { this.Set (value, 'KZTLF_DDTEXT'); }
        }

        @AuraEnabled public String Route
        { 
            get { return this.getString ('ROUTE'); } 
            set { this.Set (value, 'ROUTE'); }
        }

        @AuraEnabled public String RouteDescription
        { 
            get { return this.getString ('ROUTE_BEZEI'); } 
            set { this.Set (value, 'ROUTE_BEZEI'); }
        }

        @AuraEnabled public Decimal Netweight
        { 
            get { return this.getDecimal ('NTGEW'); } 
            set { this.Set (value, 'NTGEW'); }
        }

        @AuraEnabled public String WeightUnit
        { 
            get { return this.getString ('GEWEI'); } 
            set { this.Set (value, 'GEWEI'); }
        }

        @AuraEnabled public Decimal GrossWeight
        { 
            get { return this.getDecimal ('BRGEW'); } 
            set { this.Set (value, 'BRGEW'); }
        }

        @AuraEnabled public Decimal Volume
        { 
            get { return this.getDecimal ('VOLUM'); } 
            set { this.Set (value, 'VOLUM'); }
        }

        @AuraEnabled public String VolumeUnit
        { 
            get { return this.getString ('VOLEH'); } 
            set { this.Set (value, 'VOLEH'); }
        }

        @AuraEnabled public String IncotermsPart1
        { 
            get { return this.getString ('INCO1'); } 
            set { this.Set (value, 'INCO1'); }
        }

        @AuraEnabled public String IncotermsPart1Description
        { 
            get { return this.getString ('INCO1_BEZEI'); } 
            set { this.Set (value, 'INCO1_BEZEI'); }
        }

        @AuraEnabled public String IncotermsPart2
        { 
            get { return this.getString ('INCO2'); } 
            set { this.Set (value, 'INCO2'); }
        }

        @AuraEnabled public String TermsofPaymentKey
        { 
            get { return this.getString ('ZTERM'); } 
            set { this.Set (value, 'ZTERM'); }
        }

        @AuraEnabled public String TermsofPaymentKeyDescription
        { 
            get { return this.getString ('ZTERM_VTEXT'); } 
            set { this.Set (value, 'ZTERM_VTEXT'); }
        }

        @AuraEnabled public String BillingBlock
        { 
            get { return this.getString ('FAKSP'); } 
            set { this.Set (value, 'FAKSP'); }
        }

        @AuraEnabled public String BillingBlockDescription
        { 
            get { return this.getString ('FAKSP_VTEXT'); } 
            set { this.Set (value, 'FAKSP_VTEXT'); }
        }

        @AuraEnabled public String BillingRelevant
        { 
            get { return this.getString ('FKREL'); } 
            set { this.Set (value, 'FKREL'); }
        }

        @AuraEnabled public String BillingRelevantDescription
        { 
            get { return this.getString ('FKREL_DDTEXT'); } 
            set { this.Set (value, 'FKREL_DDTEXT'); }
        }

        @AuraEnabled public String BillingPlanInHeaderIndicator
        { 
            get { return this.getString ('KFREL'); } 
            set { this.Set (value, 'KFREL'); }
        }

        @AuraEnabled public String OverallStatusDescription
        { 
            get { return this.getString ('GBSTA_BEZ'); } 
            set { this.Set (value, 'GBSTA_BEZ'); }
        }

        @AuraEnabled public String DataCompleteDescription
        { 
            get { return this.getString ('UVALL_BEZ'); } 
            set { this.Set (value, 'UVALL_BEZ'); }
        }

        @AuraEnabled public Decimal ExchangeRatePriceDetermination
        { 
            get { return this.getDecimal ('KURSK'); } 
            set { this.Set (value, 'KURSK'); }
        }

        @AuraEnabled public Date DateforPricingExchangeRate
        { 
            get { return this.getDate ('PRSDT'); } 
            set { this.Set (value, 'PRSDT'); }
        }

        @AuraEnabled public String MaterialEntered
        { 
            get { return this.getString ('MATWA'); } 
            set { this.Set (value, 'MATWA'); }
        }

        @AuraEnabled public String UsageIndicator
        { 
            get { return this.getString ('VKAUS'); } 
            set { this.Set (value, 'VKAUS'); }
        }

        @AuraEnabled public String UsageIndicatorDescription
        { 
            get { return this.getString ('VKAUS_BEZEI'); } 
            set { this.Set (value, 'VKAUS_BEZEI'); }
        }

        @AuraEnabled public String PricingReferenceMaterial
        { 
            get { return this.getString ('PMATN'); } 
            set { this.Set (value, 'PMATN'); }
        }

        @AuraEnabled public String CostingSheet
        { 
            get { return this.getString ('KALSM_K'); } 
            set { this.Set (value, 'KALSM_K'); }
        }

        @AuraEnabled public String CostingSheetDescription
        { 
            get { return this.getString ('KALSM_K_VTEXT'); } 
            set { this.Set (value, 'KALSM_K_VTEXT'); }
        }

        @AuraEnabled public String Overheadkey
        { 
            get { return this.getString ('ZSCHL_K'); } 
            set { this.Set (value, 'ZSCHL_K'); }
        }

        @AuraEnabled public String ReceivingPoint
        { 
            get { return this.getString ('EMPST'); } 
            set { this.Set (value, 'EMPST'); }
        }

        @AuraEnabled public String DepartmentNumber
        { 
            get { return this.getString ('ABTNR'); } 
            set { this.Set (value, 'ABTNR'); }
        }

        @AuraEnabled public String DepartmentNumberDescription
        { 
            get { return this.getString ('ABTNR_VTEXT'); } 
            set { this.Set (value, 'ABTNR_VTEXT'); }
        }

        @AuraEnabled public Decimal MaxNumberOfPartialDeliveriesAllowed
        { 
            get { return this.getDecimal ('ANTLF'); } 
            set { this.Set (value, 'ANTLF'); }
        }

        @AuraEnabled public Decimal OverdeliveryToleranceLimit
        { 
            get { return this.getDecimal ('UEBTO'); } 
            set { this.Set (value, 'UEBTO'); }
        }

        @AuraEnabled public Decimal UnderdeliveryToleranceLimit
        { 
            get { return this.getDecimal ('UNTTO'); } 
            set { this.Set (value, 'UNTTO'); }
        }

        @AuraEnabled public Date FixedValueDate
        { 
            get { return this.getDate ('VALDT'); } 
            set { this.Set (value, 'VALDT'); }
        }

        @AuraEnabled public String AdditionalValueDays
        { 
            get { return this.getString ('VALTG'); } 
            set { this.Set (value, 'VALTG'); }
        }

        @AuraEnabled public String InvoiceDates
        { 
            get { return this.getString ('PERFK'); } 
            set { this.Set (value, 'PERFK'); }
        }

        @AuraEnabled public String InvoiceDatesText
        { 
            get { return this.getString ('PERFK_LTEXT'); } 
            set { this.Set (value, 'PERFK_LTEXT'); }
        }

        @AuraEnabled public Date BillingDate
        { 
            get { return this.getDate ('FKDAT'); } 
            set { this.Set (value, 'FKDAT'); }
        }

        @AuraEnabled public Date DateOnWhichServicesRendered
        { 
            get { return this.getDate ('FBUDA'); } 
            set { this.Set (value, 'FBUDA'); }
        }

        @AuraEnabled public String AccountAssignmentGroup
        { 
            get { return this.getString ('KTGRM'); } 
            set { this.Set (value, 'KTGRM'); }
        }

        @AuraEnabled public String AccountAssignmentGroupDescription
        { 
            get { return this.getString ('KTGRM_VTEXT'); } 
            set { this.Set (value, 'KTGRM_VTEXT'); }
        }

        @AuraEnabled public Decimal ComponentQuantity
        { 
            get { return this.getDecimal ('KMPMG'); } 
            set { this.Set (value, 'KMPMG'); }
        }

        @AuraEnabled public String BaseUnitOfMeasure
        { 
            get { return this.getString ('MEINS'); } 
            set { this.Set (value, 'MEINS'); }
        }

        @AuraEnabled public String IUIDRelevant
        { 
            get { return this.getString ('IUID_RELEVANT'); } 
            set { this.Set (value, 'IUID_RELEVANT'); }
        }

        @AuraEnabled public String DeliveryBlock
        { 
            get { return this.getString ('LIFSP'); } 
            set { this.Set (value, 'LIFSP'); }
        }

        @AuraEnabled public String DeliveryBlockDescription
        { 
            get { return this.getString ('LIFSP_VTEXT'); } 
            set { this.Set (value, 'LIFSP_VTEXT'); }
        }

        @AuraEnabled public String ItemReferenceDocument
        { 
            get { return this.getString ('VGBEL'); } 
            set { this.Set (value, 'VGBEL'); }
        }

        @AuraEnabled public String ItemReferenceDocumentItNumber
        { 
            get { return this.getString ('VGPOS'); } 
            set { this.Set (value, 'VGPOS'); }
        }

        @AuraEnabled public String ItemReferenceDocumentCtegory
        { 
            get { return this.getString ('VGTYP'); } 
            set { this.Set (value, 'VGTYP'); }
        }

        @AuraEnabled public Decimal CostInDocCurrency
        { 
            get { return this.getDecimal ('WAVWR'); } 
            set { this.Set (value, 'WAVWR'); }
        }

        @AuraEnabled public Boolean ConfigurableMaterial
        { 
            get { return this.getBoolean('KZKFG'); } 
            set { this.setBoolean(value, 'KZKFG'); }
        }

        @AuraEnabled public String AlternativeToItem
        { 
            get { return this.getString ('GRPOS'); } 
            set { this.Set (value, 'GRPOS'); }
        }

        @AuraEnabled public String BillOfMaterial
        { 
            get { return this.getString ('STLNR'); } 
            set { this.Set (value, 'STLNR'); }
        }

    }
    public class ITEMS_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public ITEMS_COLLECTION()
        {
            super('ITEMS', SBO_EnosixSO_Detail.ITEMS.class, null);
        }

        @AuraEnabled public List<SBO_EnosixSO_Detail.ITEMS> getAsList()
        {
            return (List<SBO_EnosixSO_Detail.ITEMS>)this.buildList(List<SBO_EnosixSO_Detail.ITEMS>.class);
        }
    }
    public class ITEMS_SCHEDULE extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixSO_Detail.ITEMS_SCHEDULE.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixSO_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'POSNR','ETENR' };
    
            return keyFields;
        }

                @AuraEnabled public String ItemNumber
        { 
            get { return this.getString ('POSNR'); } 
            set { this.Set (value, 'POSNR'); }
        }

        @AuraEnabled public String ScheduleLineNumber
        { 
            get { return this.getString ('ETENR'); } 
            set { this.Set (value, 'ETENR'); }
        }

        @AuraEnabled public Date ScheduleLineDate
        { 
            get { return this.getDate ('EDATU'); } 
            set { this.Set (value, 'EDATU'); }
        }

        @AuraEnabled public Decimal OrderQuantity
        { 
            get { return this.getDecimal ('WMENG'); } 
            set { this.Set (value, 'WMENG'); }
        }

        @AuraEnabled public Decimal RoundedQuantity
        { 
            get { return this.getDecimal ('CMENG'); } 
            set { this.Set (value, 'CMENG'); }
        }

        @AuraEnabled public Decimal ConfirmedQuantity
        { 
            get { return this.getDecimal ('BMENG'); } 
            set { this.Set (value, 'BMENG'); }
        }

        @AuraEnabled public String SalesUnit
        { 
            get { return this.getString ('VRKME'); } 
            set { this.Set (value, 'VRKME'); }
        }

        @AuraEnabled public String DeliveryBlock
        { 
            get { return this.getString ('LIFSP'); } 
            set { this.Set (value, 'LIFSP'); }
        }

        @AuraEnabled public String DeliveryBlockDescription
        { 
            get { return this.getString ('LIFSP_VTEXT'); } 
            set { this.Set (value, 'LIFSP_VTEXT'); }
        }

        @AuraEnabled public Decimal DeliveredQuantity
        { 
            get { return this.getDecimal ('VSMNG'); } 
            set { this.Set (value, 'VSMNG'); }
        }

        @AuraEnabled public String ScheduleLineCategory
        { 
            get { return this.getString ('ETTYP'); } 
            set { this.Set (value, 'ETTYP'); }
        }

        @AuraEnabled public String ScheduleLineCategoryDescription
        { 
            get { return this.getString ('ETTYP_VTEXT'); } 
            set { this.Set (value, 'ETTYP_VTEXT'); }
        }

        @AuraEnabled public String PurchaseRequisitionNumber
        { 
            get { return this.getString ('BANFN'); } 
            set { this.Set (value, 'BANFN'); }
        }

        @AuraEnabled public String PurchaseRequisitionItemNumber
        { 
            get { return this.getString ('BNFPO'); } 
            set { this.Set (value, 'BNFPO'); }
        }

    }
    public class ITEMS_SCHEDULE_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public ITEMS_SCHEDULE_COLLECTION()
        {
            super('ITEMS_SCHEDULE', SBO_EnosixSO_Detail.ITEMS_SCHEDULE.class, null);
        }

        @AuraEnabled public List<SBO_EnosixSO_Detail.ITEMS_SCHEDULE> getAsList()
        {
            return (List<SBO_EnosixSO_Detail.ITEMS_SCHEDULE>)this.buildList(List<SBO_EnosixSO_Detail.ITEMS_SCHEDULE>.class);
        }
    }
    public class ITEMS_TEXT extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixSO_Detail.ITEMS_TEXT.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixSO_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'POSNR','TDID','TDSPRAS' };
    
            return keyFields;
        }

                @AuraEnabled public String ItemNumber
        { 
            get { return this.getString ('POSNR'); } 
            set { this.Set (value, 'POSNR'); }
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

        @AuraEnabled public String Text
        { 
            get { return this.getString ('TEXT'); } 
            set { this.Set (value, 'TEXT'); }
        }

    }
    public class ITEMS_TEXT_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public ITEMS_TEXT_COLLECTION()
        {
            super('ITEMS_TEXT', SBO_EnosixSO_Detail.ITEMS_TEXT.class, null);
        }

        @AuraEnabled public List<SBO_EnosixSO_Detail.ITEMS_TEXT> getAsList()
        {
            return (List<SBO_EnosixSO_Detail.ITEMS_TEXT>)this.buildList(List<SBO_EnosixSO_Detail.ITEMS_TEXT>.class);
        }
    }
    public class MATERIAL_UOM extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixSO_Detail.MATERIAL_UOM.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixSO_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'MATNR','MEINH' };
    
            return keyFields;
        }

                @AuraEnabled public String Material
        { 
            get { return this.getString ('MATNR'); } 
            set { this.Set (value, 'MATNR'); }
        }

        @AuraEnabled public String AlternateUnitOfMeasure
        { 
            get { return this.getString ('MEINH'); } 
            set { this.Set (value, 'MEINH'); }
        }

    }
    public class MATERIAL_UOM_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public MATERIAL_UOM_COLLECTION()
        {
            super('MATERIAL_UOM', SBO_EnosixSO_Detail.MATERIAL_UOM.class, null);
        }

        @AuraEnabled public List<SBO_EnosixSO_Detail.MATERIAL_UOM> getAsList()
        {
            return (List<SBO_EnosixSO_Detail.MATERIAL_UOM>)this.buildList(List<SBO_EnosixSO_Detail.MATERIAL_UOM>.class);
        }
    }
    public class CCARD extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixSO_Detail.CCARD.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixSO_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'CC_TYPE','CC_NUMBER' };
    
            return keyFields;
        }

                @AuraEnabled public String BillingPlan
        { 
            get { return this.getString ('FPLNR'); } 
            set { this.Set (value, 'FPLNR'); }
        }

        @AuraEnabled public String BillingPlanItem
        { 
            get { return this.getString ('FPLTR'); } 
            set { this.Set (value, 'FPLTR'); }
        }

        @AuraEnabled public String CreditCardType
        { 
            get { return this.getString ('CC_TYPE'); } 
            set { this.Set (value, 'CC_TYPE'); }
        }

        @AuraEnabled public String CreditCardNumber
        { 
            get { return this.getString ('CC_NUMBER'); } 
            set { this.Set (value, 'CC_NUMBER'); }
        }

        @AuraEnabled public String PaymentCardSuffix
        { 
            get { return this.getString ('CC_SEQ_NO'); } 
            set { this.Set (value, 'CC_SEQ_NO'); }
        }

        @AuraEnabled public Date ValidToDate
        { 
            get { return this.getDate ('CC_VALID_T'); } 
            set { this.Set (value, 'CC_VALID_T'); }
        }

        @AuraEnabled public String CardholderName
        { 
            get { return this.getString ('CC_NAME'); } 
            set { this.Set (value, 'CC_NAME'); }
        }

        @AuraEnabled public Decimal BillAmount
        { 
            get { return this.getDecimal ('BILLAMOUNT'); } 
            set { this.Set (value, 'BILLAMOUNT'); }
        }

        @AuraEnabled public Decimal AuthorizedAmount
        { 
            get { return this.getDecimal ('AUTHAMOUNT'); } 
            set { this.Set (value, 'AUTHAMOUNT'); }
        }

        @AuraEnabled public String OrderCurrency
        { 
            get { return this.getString ('CURRENCY'); } 
            set { this.Set (value, 'CURRENCY'); }
        }

        @AuraEnabled public Date AuthorizationDate
        { 
            get { return this.getDate ('AUTH_DATE'); } 
            set { this.Set (value, 'AUTH_DATE'); }
        }

        @AuraEnabled public Time AuthorizationTime
        { 
            get { return this.getTime ('AUTH_TIME'); } 
            set { this.Set (value, 'AUTH_TIME'); }
        }

        @AuraEnabled public String AuthorizationNumber
        { 
            get { return this.getString ('AUTH_CC_NO'); } 
            set { this.Set (value, 'AUTH_CC_NO'); }
        }

        @AuraEnabled public Boolean Settlement
        { 
            get { return this.getBoolean('SETTLEMENT'); } 
            set { this.setBoolean(value, 'SETTLEMENT'); }
        }

        @AuraEnabled public String ClearingHouseAuthCode
        { 
            get { return this.getString ('CLEARING_REF'); } 
            set { this.Set (value, 'CLEARING_REF'); }
        }

        @AuraEnabled public String AuthorizationCheckResponse
        { 
            get { return this.getString ('CC_REACT'); } 
            set { this.Set (value, 'CC_REACT'); }
        }

        @AuraEnabled public String StatusFromExternalSystem
        { 
            get { return this.getString ('CC_STAT_EX'); } 
            set { this.Set (value, 'CC_STAT_EX'); }
        }

        @AuraEnabled public Boolean Preauthorization
        { 
            get { return this.getBoolean('PRE_AUTH'); } 
            set { this.setBoolean(value, 'PRE_AUTH'); }
        }

        @AuraEnabled public Boolean AmountChanged
        { 
            get { return this.getBoolean('AMOUNTCHAN'); } 
            set { this.setBoolean(value, 'AMOUNTCHAN'); }
        }

        @AuraEnabled public String AuthorizationType
        { 
            get { return this.getString ('AUTHORTYPE'); } 
            set { this.Set (value, 'AUTHORTYPE'); }
        }

        @AuraEnabled public String BillingPlanAuthorization
        { 
            get { return this.getString ('BP_AUTH'); } 
            set { this.Set (value, 'BP_AUTH'); }
        }

        @AuraEnabled public String ResultCode
        { 
            get { return this.getString ('CC_RESULT_CD'); } 
            set { this.Set (value, 'CC_RESULT_CD'); }
        }

        @AuraEnabled public String ResultText
        { 
            get { return this.getString ('CC_RESULT_TX'); } 
            set { this.Set (value, 'CC_RESULT_TX'); }
        }

    }
    public class CCARD_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public CCARD_COLLECTION()
        {
            super('CCARD', SBO_EnosixSO_Detail.CCARD.class, null);
        }

        @AuraEnabled public List<SBO_EnosixSO_Detail.CCARD> getAsList()
        {
            return (List<SBO_EnosixSO_Detail.CCARD>)this.buildList(List<SBO_EnosixSO_Detail.CCARD>.class);
        }
    }
    public class ITEMS_ACTION extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixSO_Detail.ITEMS_ACTION.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixSO_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'POSNR' };
    
            return keyFields;
        }

                @AuraEnabled public String ItemNumber
        { 
            get { return this.getString ('POSNR'); } 
            set { this.Set (value, 'POSNR'); }
        }

        @AuraEnabled public Boolean ItemChanged
        { 
            get { return this.getBoolean('X_ITEMCHANGED'); } 
            set { this.setBoolean(value, 'X_ITEMCHANGED'); }
        }

        @AuraEnabled public Boolean ItemDeleted
        { 
            get { return this.getBoolean('X_ITEMDELETED'); } 
            set { this.setBoolean(value, 'X_ITEMDELETED'); }
        }

        @AuraEnabled public Boolean ItemAdded
        { 
            get { return this.getBoolean('X_ITEMADDED'); } 
            set { this.setBoolean(value, 'X_ITEMADDED'); }
        }

        @AuraEnabled public Boolean PriceOverride
        { 
            get { return this.getBoolean('X_PRICEOVERRIDE'); } 
            set { this.setBoolean(value, 'X_PRICEOVERRIDE'); }
        }

    }
    public class ITEMS_ACTION_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public ITEMS_ACTION_COLLECTION()
        {
            super('ITEMS_ACTION', SBO_EnosixSO_Detail.ITEMS_ACTION.class, null);
        }

        @AuraEnabled public List<SBO_EnosixSO_Detail.ITEMS_ACTION> getAsList()
        {
            return (List<SBO_EnosixSO_Detail.ITEMS_ACTION>)this.buildList(List<SBO_EnosixSO_Detail.ITEMS_ACTION>.class);
        }
    }
    public class ORDER_ACTION extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixSO_Detail.ORDER_ACTION.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixSO_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'EnosixObjKey' };
    
            return keyFields;
        }

                @AuraEnabled public Boolean ReferenceFlag
        { 
            get { return this.getBoolean('X_CREATEORDER'); } 
            set { this.setBoolean(value, 'X_CREATEORDER'); }
        }

        @AuraEnabled public String ReferenceDocumentType
        { 
            get { return this.getString ('REF_DOC_TYPE'); } 
            set { this.Set (value, 'REF_DOC_TYPE'); }
        }

        @AuraEnabled public String ReferenceDocumentNumber
        { 
            get { return this.getString ('REF_DOC_NUMBER'); } 
            set { this.Set (value, 'REF_DOC_NUMBER'); }
        }

    }
    public class ITEMS_CONFIG extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixSO_Detail.ITEMS_CONFIG.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixSO_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'POSNR','MATNR','ATINN','ATNAM','ATBEZ','ATWRT','ATWTB' };
    
            return keyFields;
        }

                @AuraEnabled public String ItemNumber
        { 
            get { return this.getString ('POSNR'); } 
            set { this.Set (value, 'POSNR'); }
        }

        @AuraEnabled public String Material
        { 
            get { return this.getString ('MATNR'); } 
            set { this.Set (value, 'MATNR'); }
        }

        @AuraEnabled public String CharacteristicID
        { 
            get { return this.getString ('ATINN'); } 
            set { this.Set (value, 'ATINN'); }
        }

        @AuraEnabled public String CharacteristicName
        { 
            get { return this.getString ('ATNAM'); } 
            set { this.Set (value, 'ATNAM'); }
        }

        @AuraEnabled public String CharacteristicDescription
        { 
            get { return this.getString ('ATBEZ'); } 
            set { this.Set (value, 'ATBEZ'); }
        }

        @AuraEnabled public String CharacteristicValue
        { 
            get { return this.getString ('ATWRT'); } 
            set { this.Set (value, 'ATWRT'); }
        }

        @AuraEnabled public String CharacteristicValueDescription
        { 
            get { return this.getString ('ATWTB'); } 
            set { this.Set (value, 'ATWTB'); }
        }

    }
    public class ITEMS_CONFIG_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public ITEMS_CONFIG_COLLECTION()
        {
            super('ITEMS_CONFIG', SBO_EnosixSO_Detail.ITEMS_CONFIG.class, null);
        }

        @AuraEnabled public List<SBO_EnosixSO_Detail.ITEMS_CONFIG> getAsList()
        {
            return (List<SBO_EnosixSO_Detail.ITEMS_CONFIG>)this.buildList(List<SBO_EnosixSO_Detail.ITEMS_CONFIG>.class);
        }
    }
    public class INCOMPLETION_LOG extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixSO_Detail.INCOMPLETION_LOG.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixSO_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'MANDT','VBELN','POSNR','ETENR','PARVW','TDID','TBNAM','FDNAM','FEHGR','STATG','FDTXT' };
    
            return keyFields;
        }

                @AuraEnabled public String Client
        { 
            get { return this.getString ('MANDT'); } 
            set { this.Set (value, 'MANDT'); }
        }

        @AuraEnabled public String SalesDocument
        { 
            get { return this.getString ('VBELN'); } 
            set { this.Set (value, 'VBELN'); }
        }

        @AuraEnabled public String ItemNumber
        { 
            get { return this.getString ('POSNR'); } 
            set { this.Set (value, 'POSNR'); }
        }

        @AuraEnabled public String ScheduleLineNumber
        { 
            get { return this.getString ('ETENR'); } 
            set { this.Set (value, 'ETENR'); }
        }

        @AuraEnabled public String PartnerFunction
        { 
            get { return this.getString ('PARVW'); } 
            set { this.Set (value, 'PARVW'); }
        }

        @AuraEnabled public String TextID
        { 
            get { return this.getString ('TDID'); } 
            set { this.Set (value, 'TDID'); }
        }

        @AuraEnabled public String TableName
        { 
            get { return this.getString ('TBNAM'); } 
            set { this.Set (value, 'TBNAM'); }
        }

        @AuraEnabled public String FieldName
        { 
            get { return this.getString ('FDNAM'); } 
            set { this.Set (value, 'FDNAM'); }
        }

        @AuraEnabled public String IncompletionProcedure
        { 
            get { return this.getString ('FEHGR'); } 
            set { this.Set (value, 'FEHGR'); }
        }

        @AuraEnabled public String StatusGroup
        { 
            get { return this.getString ('STATG'); } 
            set { this.Set (value, 'STATG'); }
        }

        @AuraEnabled public String Description
        { 
            get { return this.getString ('FDTXT'); } 
            set { this.Set (value, 'FDTXT'); }
        }

    }
    public class INCOMPLETION_LOG_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public INCOMPLETION_LOG_COLLECTION()
        {
            super('INCOMPLETION_LOG', SBO_EnosixSO_Detail.INCOMPLETION_LOG.class, null);
        }

        @AuraEnabled public List<SBO_EnosixSO_Detail.INCOMPLETION_LOG> getAsList()
        {
            return (List<SBO_EnosixSO_Detail.INCOMPLETION_LOG>)this.buildList(List<SBO_EnosixSO_Detail.INCOMPLETION_LOG>.class);
        }
    }
}