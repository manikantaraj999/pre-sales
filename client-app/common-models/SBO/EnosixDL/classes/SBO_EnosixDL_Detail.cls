/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class SBO_EnosixDL_Detail extends ensxsdk.EnosixFramework.DetailSBO
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('SBO_EnosixDL_Detail_Meta', new Type[] {
            SBO_EnosixDL_Detail.EnosixDL.class
            , SBO_EnosixDL_Detail.PARTNERS.class
            , SBO_EnosixDL_Detail.CUSTOMER.class
            , SBO_EnosixDL_Detail.ITEMS.class
            , SBO_EnosixDL_Detail.HU.class
            , SBO_EnosixDL_Detail.HU_ITEMS.class
            , SBO_EnosixDL_Detail.HEADER_TEXTS.class
            , SBO_EnosixDL_Detail.ITEMS_TEXT.class
            , SBO_EnosixDL_Detail.DOC_ACTION.class
            , SBO_EnosixDL_Detail.ITEMS_ACTION.class
            } 
        );
    }

    public SBO_EnosixDL_Detail()
    {
        super('EnosixDL', SBO_EnosixDL_Detail.EnosixDL.class);
    }

    public override Type getType() { return SBO_EnosixDL_Detail.class; }

    public EnosixDL initialize(EnosixDL obj)
    {
        return (EnosixDL)this.executeInitialize(obj);
    }
    
    public EnosixDL getDetail(object key)
    {
        return (EnosixDL)this.executeGetDetail(key);
    }
    
    public EnosixDL save(EnosixDL obj)
    {
        return (EnosixDL) this.executeSave(obj);
    }

    public EnosixDL command(string command, EnosixDL obj)
    {
        return (EnosixDL) this.executeCommand(command, obj);
    }
    
    public with sharing class EnosixDL extends ensxsdk.EnosixFramework.DetailObject
    {
        public EnosixDL()
        {
            super('HEADER', new Map<string,type>
                {
                    'PARTNERS' => SBO_EnosixDL_Detail.PARTNERS_COLLECTION.class
                    ,'CUSTOMER' => SBO_EnosixDL_Detail.CUSTOMER.class
                    ,'ITEMS' => SBO_EnosixDL_Detail.ITEMS_COLLECTION.class
                    ,'HU' => SBO_EnosixDL_Detail.HU_COLLECTION.class
                    ,'HU_ITEMS' => SBO_EnosixDL_Detail.HU_ITEMS_COLLECTION.class
                    ,'HEADER_TEXTS' => SBO_EnosixDL_Detail.HEADER_TEXTS_COLLECTION.class
                    ,'ITEMS_TEXT' => SBO_EnosixDL_Detail.ITEMS_TEXT_COLLECTION.class
                    ,'DOC_ACTION' => SBO_EnosixDL_Detail.DOC_ACTION.class
                    ,'ITEMS_ACTION' => SBO_EnosixDL_Detail.ITEMS_ACTION_COLLECTION.class
                });	
        }

        public override Type getType() { return SBO_EnosixDL_Detail.EnosixDL.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixDL_Detail.registerReflectionInfo();
        }

                @AuraEnabled public String Delivery
        { 
            get { return this.getString ('VBELN'); } 
            set { this.Set (value, 'VBELN'); }
        }

        @AuraEnabled public String Truck
        { 
            get { return this.getString ('TRAID'); } 
            set { this.Set (value, 'TRAID'); }
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

        @AuraEnabled public String LoadingPoint
        { 
            get { return this.getString ('LSTEL'); } 
            set { this.Set (value, 'LSTEL'); }
        }

        @AuraEnabled public String LoadingPointText
        { 
            get { return this.getString ('LSTEL_VTEXT'); } 
            set { this.Set (value, 'LSTEL_VTEXT'); }
        }

        @AuraEnabled public String UnloadingPoint
        { 
            get { return this.getString ('ABLAD'); } 
            set { this.Set (value, 'ABLAD'); }
        }

        @AuraEnabled public String Route
        { 
            get { return this.getString ('ROUTE'); } 
            set { this.Set (value, 'ROUTE'); }
        }

        @AuraEnabled public String RouteText
        { 
            get { return this.getString ('ROUTE_TEXT'); } 
            set { this.Set (value, 'ROUTE_TEXT'); }
        }

        @AuraEnabled public String BillofLading
        { 
            get { return this.getString ('BOLNR'); } 
            set { this.Set (value, 'BOLNR'); }
        }

        @AuraEnabled public Date CreateDate
        { 
            get { return this.getDate ('ERDAT'); } 
            set { this.Set (value, 'ERDAT'); }
        }

        @AuraEnabled public Date DeliveryDate
        { 
            get { return this.getDate ('LFDAT'); } 
            set { this.Set (value, 'LFDAT'); }
        }

        @AuraEnabled public Date PGIDate
        { 
            get { return this.getDate ('WADAT_IST'); } 
            set { this.Set (value, 'WADAT_IST'); }
        }

        @AuraEnabled public String DeliveryType
        { 
            get { return this.getString ('LFART'); } 
            set { this.Set (value, 'LFART'); }
        }

        @AuraEnabled public String DeliveryTypeText
        { 
            get { return this.getString ('LFART_TEXT'); } 
            set { this.Set (value, 'LFART_TEXT'); }
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

        @AuraEnabled public String ShippingConditions
        { 
            get { return this.getString ('VSBED'); } 
            set { this.Set (value, 'VSBED'); }
        }

        @AuraEnabled public String ShipConditionText
        { 
            get { return this.getString ('VSBED_TEXT'); } 
            set { this.Set (value, 'VSBED_TEXT'); }
        }

        @AuraEnabled public String DeliveryPriority
        { 
            get { return this.getString ('LPRIO'); } 
            set { this.Set (value, 'LPRIO'); }
        }

        @AuraEnabled public String DeliveryPriorityText
        { 
            get { return this.getString ('LPRIO_TEXT'); } 
            set { this.Set (value, 'LPRIO_TEXT'); }
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

        @AuraEnabled public String DeliveryBlock
        { 
            get { return this.getString ('LIFSK'); } 
            set { this.Set (value, 'LIFSK'); }
        }

        @AuraEnabled public String DeliveryStatus
        { 
            get { return this.getString ('DELV_STAT'); } 
            set { this.Set (value, 'DELV_STAT'); }
        }

        @AuraEnabled public PARTNERS_COLLECTION PARTNERS
        {
            get 
            { 
                return (PARTNERS_COLLECTION)this.getCollection(SBO_EnosixDL_Detail.PARTNERS_COLLECTION.class); 
            }
        }

        
        @AuraEnabled public SBO_EnosixDL_Detail.CUSTOMER CUSTOMER 
        {
            get
            {
                return (SBO_EnosixDL_Detail.CUSTOMER)this.getStruct(SBO_EnosixDL_Detail.CUSTOMER.class);
            }
        }
        
            @AuraEnabled public ITEMS_COLLECTION ITEMS
        {
            get 
            { 
                return (ITEMS_COLLECTION)this.getCollection(SBO_EnosixDL_Detail.ITEMS_COLLECTION.class); 
            }
        }

                @AuraEnabled public HU_COLLECTION HU
        {
            get 
            { 
                return (HU_COLLECTION)this.getCollection(SBO_EnosixDL_Detail.HU_COLLECTION.class); 
            }
        }

                @AuraEnabled public HU_ITEMS_COLLECTION HU_ITEMS
        {
            get 
            { 
                return (HU_ITEMS_COLLECTION)this.getCollection(SBO_EnosixDL_Detail.HU_ITEMS_COLLECTION.class); 
            }
        }

                @AuraEnabled public HEADER_TEXTS_COLLECTION HEADER_TEXTS
        {
            get 
            { 
                return (HEADER_TEXTS_COLLECTION)this.getCollection(SBO_EnosixDL_Detail.HEADER_TEXTS_COLLECTION.class); 
            }
        }

                @AuraEnabled public ITEMS_TEXT_COLLECTION ITEMS_TEXT
        {
            get 
            { 
                return (ITEMS_TEXT_COLLECTION)this.getCollection(SBO_EnosixDL_Detail.ITEMS_TEXT_COLLECTION.class); 
            }
        }

        
        @AuraEnabled public SBO_EnosixDL_Detail.DOC_ACTION DOC_ACTION 
        {
            get
            {
                return (SBO_EnosixDL_Detail.DOC_ACTION)this.getStruct(SBO_EnosixDL_Detail.DOC_ACTION.class);
            }
        }
        
            @AuraEnabled public ITEMS_ACTION_COLLECTION ITEMS_ACTION
        {
            get 
            { 
                return (ITEMS_ACTION_COLLECTION)this.getCollection(SBO_EnosixDL_Detail.ITEMS_ACTION_COLLECTION.class); 
            }
        }

            }

    //Write child objects
        public class PARTNERS extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixDL_Detail.PARTNERS.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixDL_Detail.registerReflectionInfo();
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

    }
    public class PARTNERS_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public PARTNERS_COLLECTION()
        {
            super('PARTNERS', SBO_EnosixDL_Detail.PARTNERS.class, null);
        }

        @AuraEnabled public List<SBO_EnosixDL_Detail.PARTNERS> getAsList()
        {
            return (List<SBO_EnosixDL_Detail.PARTNERS>)this.buildList(List<SBO_EnosixDL_Detail.PARTNERS>.class);
        }
    }
    public class CUSTOMER extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixDL_Detail.CUSTOMER.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixDL_Detail.registerReflectionInfo();
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

        @AuraEnabled public String Name
        { 
            get { return this.getString ('NAME1'); } 
            set { this.Set (value, 'NAME1'); }
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

        @AuraEnabled public String Region
        { 
            get { return this.getString ('REGION'); } 
            set { this.Set (value, 'REGION'); }
        }

        @AuraEnabled public String PostalCode
        { 
            get { return this.getString ('POST_CODE1'); } 
            set { this.Set (value, 'POST_CODE1'); }
        }

        @AuraEnabled public Integer OpenDeliveries
        { 
            get { return this.getInteger ('NUM_DELVS'); } 
            set { this.Set (value, 'NUM_DELVS'); }
        }

    }
    public class ITEMS extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixDL_Detail.ITEMS.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixDL_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'POSNR' };
    
            return keyFields;
        }

                @AuraEnabled public String DeliveryItem
        { 
            get { return this.getString ('POSNR'); } 
            set { this.Set (value, 'POSNR'); }
        }

        @AuraEnabled public String Material
        { 
            get { return this.getString ('MATNR'); } 
            set { this.Set (value, 'MATNR'); }
        }

        @AuraEnabled public String MaterialDescription
        { 
            get { return this.getString ('MAKTX'); } 
            set { this.Set (value, 'MAKTX'); }
        }

        @AuraEnabled public Decimal DeliveryQuantity
        { 
            get { return this.getDecimal ('LFIMG'); } 
            set { this.Set (value, 'LFIMG'); }
        }

        @AuraEnabled public Decimal PickedQuantity
        { 
            get { return this.getDecimal ('PIKMG'); } 
            set { this.Set (value, 'PIKMG'); }
        }

        @AuraEnabled public String SalesUnit
        { 
            get { return this.getString ('VRKME'); } 
            set { this.Set (value, 'VRKME'); }
        }

        @AuraEnabled public String SalesUOMText
        { 
            get { return this.getString ('VRKME_MSEHT'); } 
            set { this.Set (value, 'VRKME_MSEHT'); }
        }

        @AuraEnabled public String BaseUnitOfMeasure
        { 
            get { return this.getString ('MEINS'); } 
            set { this.Set (value, 'MEINS'); }
        }

        @AuraEnabled public String UOMText
        { 
            get { return this.getString ('MEINS_MSEHT'); } 
            set { this.Set (value, 'MEINS_MSEHT'); }
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

        @AuraEnabled public String CustomerPurchaseOrderNumber
        { 
            get { return this.getString ('BSTKD'); } 
            set { this.Set (value, 'BSTKD'); }
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

        @AuraEnabled public String MaterialType
        { 
            get { return this.getString ('MTART'); } 
            set { this.Set (value, 'MTART'); }
        }

        @AuraEnabled public String MaterialGroup
        { 
            get { return this.getString ('MATKL'); } 
            set { this.Set (value, 'MATKL'); }
        }

        @AuraEnabled public String ProductHierarchy
        { 
            get { return this.getString ('PRODH'); } 
            set { this.Set (value, 'PRODH'); }
        }

        @AuraEnabled public String StorageLocation
        { 
            get { return this.getString ('LGORT'); } 
            set { this.Set (value, 'LGORT'); }
        }

        @AuraEnabled public String BatchNumber
        { 
            get { return this.getString ('CHARG'); } 
            set { this.Set (value, 'CHARG'); }
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

        @AuraEnabled public Decimal NetItemPrice
        { 
            get { return this.getDecimal ('NETPR'); } 
            set { this.Set (value, 'NETPR'); }
        }

        @AuraEnabled public Decimal NetOrderValue
        { 
            get { return this.getDecimal ('NETWR'); } 
            set { this.Set (value, 'NETWR'); }
        }

        @AuraEnabled public Decimal Netweight
        { 
            get { return this.getDecimal ('NTGEW'); } 
            set { this.Set (value, 'NTGEW'); }
        }

        @AuraEnabled public Decimal GrossWeight
        { 
            get { return this.getDecimal ('BRGEW'); } 
            set { this.Set (value, 'BRGEW'); }
        }

        @AuraEnabled public String WeightUnit
        { 
            get { return this.getString ('GEWEI'); } 
            set { this.Set (value, 'GEWEI'); }
        }

        @AuraEnabled public String SalesOrder
        { 
            get { return this.getString ('VGBEL'); } 
            set { this.Set (value, 'VGBEL'); }
        }

        @AuraEnabled public String SalesOrderItem
        { 
            get { return this.getString ('VGPOS'); } 
            set { this.Set (value, 'VGPOS'); }
        }

        @AuraEnabled public String LoadingGroup
        { 
            get { return this.getString ('LADGR'); } 
            set { this.Set (value, 'LADGR'); }
        }

        @AuraEnabled public String TransportationGroup
        { 
            get { return this.getString ('TRAGR'); } 
            set { this.Set (value, 'TRAGR'); }
        }

        @AuraEnabled public String StorageType
        { 
            get { return this.getString ('LGTYP'); } 
            set { this.Set (value, 'LGTYP'); }
        }

        @AuraEnabled public String StorageBin
        { 
            get { return this.getString ('LGPLA'); } 
            set { this.Set (value, 'LGPLA'); }
        }

        @AuraEnabled public String MovementType
        { 
            get { return this.getString ('BWART'); } 
            set { this.Set (value, 'BWART'); }
        }

        @AuraEnabled public Boolean BatchManagmentRequired
        { 
            get { return this.getBoolean('XCHPF'); } 
            set { this.setBoolean(value, 'XCHPF'); }
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

        @AuraEnabled public String SpecialStockInd
        { 
            get { return this.getString ('SOBKZ'); } 
            set { this.Set (value, 'SOBKZ'); }
        }

        @AuraEnabled public Decimal CumulBatchQuantity
        { 
            get { return this.getDecimal ('KCMENG'); } 
            set { this.Set (value, 'KCMENG'); }
        }

        @AuraEnabled public String HigerLevelBatchSplitItem
        { 
            get { return this.getString ('UECHA'); } 
            set { this.Set (value, 'UECHA'); }
        }

        @AuraEnabled public String InspectionLot
        { 
            get { return this.getString ('QPLOS'); } 
            set { this.Set (value, 'QPLOS'); }
        }

        @AuraEnabled public String QtyInInspectionStock
        { 
            get { return this.getString ('INSMK'); } 
            set { this.Set (value, 'INSMK'); }
        }

        @AuraEnabled public String ReservationNumber
        { 
            get { return this.getString ('RSNUM'); } 
            set { this.Set (value, 'RSNUM'); }
        }

        @AuraEnabled public String ReservationItem
        { 
            get { return this.getString ('RSPOS'); } 
            set { this.Set (value, 'RSPOS'); }
        }

        @AuraEnabled public Decimal NumeratorConvSalesToSKU
        { 
            get { return this.getDecimal ('UMVKZ'); } 
            set { this.Set (value, 'UMVKZ'); }
        }

        @AuraEnabled public Decimal DenominatorConvSalesToSKU
        { 
            get { return this.getDecimal ('UMVKN'); } 
            set { this.Set (value, 'UMVKN'); }
        }

        @AuraEnabled public Decimal ConversionSalesToBaseUOM
        { 
            get { return this.getDecimal ('UMREV'); } 
            set { this.Set (value, 'UMREV'); }
        }

        @AuraEnabled public String PickingStatus
        { 
            get { return this.getString ('KOSTA'); } 
            set { this.Set (value, 'KOSTA'); }
        }

        @AuraEnabled public String PackingStatus
        { 
            get { return this.getString ('PKSTA'); } 
            set { this.Set (value, 'PKSTA'); }
        }

        @AuraEnabled public String ProofofDelivery
        { 
            get { return this.getString ('PDSTA'); } 
            set { this.Set (value, 'PDSTA'); }
        }

    }
    public class ITEMS_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public ITEMS_COLLECTION()
        {
            super('ITEMS', SBO_EnosixDL_Detail.ITEMS.class, null);
        }

        @AuraEnabled public List<SBO_EnosixDL_Detail.ITEMS> getAsList()
        {
            return (List<SBO_EnosixDL_Detail.ITEMS>)this.buildList(List<SBO_EnosixDL_Detail.ITEMS>.class);
        }
    }
    public class HU extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixDL_Detail.HU.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixDL_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'VENUM' };
    
            return keyFields;
        }

                @AuraEnabled public String IntHUNumber
        { 
            get { return this.getString ('VENUM'); } 
            set { this.Set (value, 'VENUM'); }
        }

        @AuraEnabled public String HUContentDescription
        { 
            get { return this.getString ('INHALT'); } 
            set { this.Set (value, 'INHALT'); }
        }

        @AuraEnabled public String ExtHUID
        { 
            get { return this.getString ('EXIDV'); } 
            set { this.Set (value, 'EXIDV'); }
        }

        @AuraEnabled public String ExtHUIDType
        { 
            get { return this.getString ('EXIDA'); } 
            set { this.Set (value, 'EXIDA'); }
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

        @AuraEnabled public String LoadingPoint
        { 
            get { return this.getString ('LSTEL'); } 
            set { this.Set (value, 'LSTEL'); }
        }

        @AuraEnabled public String LoadingPointText
        { 
            get { return this.getString ('LSTEL_VTEXT'); } 
            set { this.Set (value, 'LSTEL_VTEXT'); }
        }

        @AuraEnabled public String HUStatus
        { 
            get { return this.getString ('STATUS'); } 
            set { this.Set (value, 'STATUS'); }
        }

        @AuraEnabled public String HUStatusDescription
        { 
            get { return this.getString ('STATUS_VTEXT'); } 
            set { this.Set (value, 'STATUS_VTEXT'); }
        }

        @AuraEnabled public Decimal GrossWeight
        { 
            get { return this.getDecimal ('BRGEW'); } 
            set { this.Set (value, 'BRGEW'); }
        }

        @AuraEnabled public Decimal Netweight
        { 
            get { return this.getDecimal ('NTGEW'); } 
            set { this.Set (value, 'NTGEW'); }
        }

        @AuraEnabled public Decimal HUAllowedWeight
        { 
            get { return this.getDecimal ('MAGEW'); } 
            set { this.Set (value, 'MAGEW'); }
        }

        @AuraEnabled public Decimal TareWeight
        { 
            get { return this.getDecimal ('TARAG'); } 
            set { this.Set (value, 'TARAG'); }
        }

        @AuraEnabled public String WeightUnit
        { 
            get { return this.getString ('GEWEI'); } 
            set { this.Set (value, 'GEWEI'); }
        }

        @AuraEnabled public String CreatedBy
        { 
            get { return this.getString ('ERNAM'); } 
            set { this.Set (value, 'ERNAM'); }
        }

        @AuraEnabled public Date CreateDate
        { 
            get { return this.getDate ('ERDAT'); } 
            set { this.Set (value, 'ERDAT'); }
        }

        @AuraEnabled public Time EntryTime
        { 
            get { return this.getTime ('ERUHR'); } 
            set { this.Set (value, 'ERUHR'); }
        }

        @AuraEnabled public String SortField
        { 
            get { return this.getString ('SORTL'); } 
            set { this.Set (value, 'SORTL'); }
        }

        @AuraEnabled public String PackagingMaterial
        { 
            get { return this.getString ('VHILM'); } 
            set { this.Set (value, 'VHILM'); }
        }

        @AuraEnabled public String PackagingMaterialDescritpion
        { 
            get { return this.getString ('VHILM_MAKTX'); } 
            set { this.Set (value, 'VHILM_MAKTX'); }
        }

        @AuraEnabled public String LengthWidthHeightUOM
        { 
            get { return this.getString ('MEABM'); } 
            set { this.Set (value, 'MEABM'); }
        }

        @AuraEnabled public String PackingMaterialType
        { 
            get { return this.getString ('VHART'); } 
            set { this.Set (value, 'VHART'); }
        }

        @AuraEnabled public String MaterialGroupPackagingMaterials
        { 
            get { return this.getString ('MAGRV'); } 
            set { this.Set (value, 'MAGRV'); }
        }

        @AuraEnabled public String Plant
        { 
            get { return this.getString ('WERKS'); } 
            set { this.Set (value, 'WERKS'); }
        }

        @AuraEnabled public String StorageLocation
        { 
            get { return this.getString ('LGORT'); } 
            set { this.Set (value, 'LGORT'); }
        }

        @AuraEnabled public String GlobalUniqueID
        { 
            get { return this.getString ('HANDLE'); } 
            set { this.Set (value, 'HANDLE'); }
        }

    }
    public class HU_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public HU_COLLECTION()
        {
            super('HU', SBO_EnosixDL_Detail.HU.class, null);
        }

        @AuraEnabled public List<SBO_EnosixDL_Detail.HU> getAsList()
        {
            return (List<SBO_EnosixDL_Detail.HU>)this.buildList(List<SBO_EnosixDL_Detail.HU>.class);
        }
    }
    public class HU_ITEMS extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixDL_Detail.HU_ITEMS.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixDL_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'VENUM','VEPOS' };
    
            return keyFields;
        }

                @AuraEnabled public String IntHUNumber
        { 
            get { return this.getString ('VENUM'); } 
            set { this.Set (value, 'VENUM'); }
        }

        @AuraEnabled public String HUItem
        { 
            get { return this.getString ('VEPOS'); } 
            set { this.Set (value, 'VEPOS'); }
        }

        @AuraEnabled public String HUContentType
        { 
            get { return this.getString ('VELIN'); } 
            set { this.Set (value, 'VELIN'); }
        }

        @AuraEnabled public String Delivery
        { 
            get { return this.getString ('VBELN'); } 
            set { this.Set (value, 'VBELN'); }
        }

        @AuraEnabled public String DeliveryItem
        { 
            get { return this.getString ('POSNR'); } 
            set { this.Set (value, 'POSNR'); }
        }

        @AuraEnabled public String SDDocumentCategory
        { 
            get { return this.getString ('VBTYP'); } 
            set { this.Set (value, 'VBTYP'); }
        }

        @AuraEnabled public String LowerLevelHU
        { 
            get { return this.getString ('UNVEL'); } 
            set { this.Set (value, 'UNVEL'); }
        }

        @AuraEnabled public Decimal HUItemQuantity
        { 
            get { return this.getDecimal ('VEMNG'); } 
            set { this.Set (value, 'VEMNG'); }
        }

        @AuraEnabled public String HUItemUOM
        { 
            get { return this.getString ('VEMEH'); } 
            set { this.Set (value, 'VEMEH'); }
        }

        @AuraEnabled public String HUUOMText
        { 
            get { return this.getString ('VEMEH_MSEHT'); } 
            set { this.Set (value, 'VEMEH_MSEHT'); }
        }

        @AuraEnabled public String Material
        { 
            get { return this.getString ('MATNR'); } 
            set { this.Set (value, 'MATNR'); }
        }

        @AuraEnabled public String MaterialDescription
        { 
            get { return this.getString ('MAKTX'); } 
            set { this.Set (value, 'MAKTX'); }
        }

        @AuraEnabled public String CustomerPart
        { 
            get { return this.getString ('P_MATERIAL'); } 
            set { this.Set (value, 'P_MATERIAL'); }
        }

        @AuraEnabled public String CustomerPartDescription
        { 
            get { return this.getString ('P_MAKTX'); } 
            set { this.Set (value, 'P_MAKTX'); }
        }

        @AuraEnabled public String BatchNumber
        { 
            get { return this.getString ('CHARG'); } 
            set { this.Set (value, 'CHARG'); }
        }

        @AuraEnabled public String Plant
        { 
            get { return this.getString ('WERKS'); } 
            set { this.Set (value, 'WERKS'); }
        }

        @AuraEnabled public String StorageLocation
        { 
            get { return this.getString ('LGORT'); } 
            set { this.Set (value, 'LGORT'); }
        }

        @AuraEnabled public String StockCategory
        { 
            get { return this.getString ('BESTQ'); } 
            set { this.Set (value, 'BESTQ'); }
        }

        @AuraEnabled public String SpecialStockInd
        { 
            get { return this.getString ('SOBKZ'); } 
            set { this.Set (value, 'SOBKZ'); }
        }

        @AuraEnabled public String SpecialStockNumber
        { 
            get { return this.getString ('SONUM'); } 
            set { this.Set (value, 'SONUM'); }
        }

        @AuraEnabled public String InspectionLot
        { 
            get { return this.getString ('QPLOS'); } 
            set { this.Set (value, 'QPLOS'); }
        }

        @AuraEnabled public String SerialNumberProfile
        { 
            get { return this.getString ('SERAIL'); } 
            set { this.Set (value, 'SERAIL'); }
        }

        @AuraEnabled public String ItemCategory
        { 
            get { return this.getString ('PSTYV'); } 
            set { this.Set (value, 'PSTYV'); }
        }

        @AuraEnabled public Date GoodsReceiptDate
        { 
            get { return this.getDate ('WDATU'); } 
            set { this.Set (value, 'WDATU'); }
        }

        @AuraEnabled public Date ShelfLifeExpirationDate
        { 
            get { return this.getDate ('VFDAT'); } 
            set { this.Set (value, 'VFDAT'); }
        }

        @AuraEnabled public Boolean HUTenativeAssignment
        { 
            get { return this.getBoolean('XCHAR'); } 
            set { this.setBoolean(value, 'XCHAR'); }
        }

    }
    public class HU_ITEMS_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public HU_ITEMS_COLLECTION()
        {
            super('HU_ITEMS', SBO_EnosixDL_Detail.HU_ITEMS.class, null);
        }

        @AuraEnabled public List<SBO_EnosixDL_Detail.HU_ITEMS> getAsList()
        {
            return (List<SBO_EnosixDL_Detail.HU_ITEMS>)this.buildList(List<SBO_EnosixDL_Detail.HU_ITEMS>.class);
        }
    }
    public class HEADER_TEXTS extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixDL_Detail.HEADER_TEXTS.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixDL_Detail.registerReflectionInfo();
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
    public class HEADER_TEXTS_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public HEADER_TEXTS_COLLECTION()
        {
            super('HEADER_TEXTS', SBO_EnosixDL_Detail.HEADER_TEXTS.class, null);
        }

        @AuraEnabled public List<SBO_EnosixDL_Detail.HEADER_TEXTS> getAsList()
        {
            return (List<SBO_EnosixDL_Detail.HEADER_TEXTS>)this.buildList(List<SBO_EnosixDL_Detail.HEADER_TEXTS>.class);
        }
    }
    public class ITEMS_TEXT extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixDL_Detail.ITEMS_TEXT.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixDL_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'POSNR','TDID','TDSPRAS' };
    
            return keyFields;
        }

                @AuraEnabled public String DeliveryItem
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
            super('ITEMS_TEXT', SBO_EnosixDL_Detail.ITEMS_TEXT.class, null);
        }

        @AuraEnabled public List<SBO_EnosixDL_Detail.ITEMS_TEXT> getAsList()
        {
            return (List<SBO_EnosixDL_Detail.ITEMS_TEXT>)this.buildList(List<SBO_EnosixDL_Detail.ITEMS_TEXT>.class);
        }
    }
    public class DOC_ACTION extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixDL_Detail.DOC_ACTION.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixDL_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'EnosixObjKey' };
    
            return keyFields;
        }

                @AuraEnabled public Boolean ChangeDelivery
        { 
            get { return this.getBoolean('X_CHANGE'); } 
            set { this.setBoolean(value, 'X_CHANGE'); }
        }

        @AuraEnabled public Boolean PickDelivery
        { 
            get { return this.getBoolean('X_PICK'); } 
            set { this.setBoolean(value, 'X_PICK'); }
        }

        @AuraEnabled public Boolean PackDelivery
        { 
            get { return this.getBoolean('X_PACK'); } 
            set { this.setBoolean(value, 'X_PACK'); }
        }

        @AuraEnabled public Boolean PostGoodsIssue
        { 
            get { return this.getBoolean('X_PGI'); } 
            set { this.setBoolean(value, 'X_PGI'); }
        }

        @AuraEnabled public String CopyPickedQtyToDelveryQty
        { 
            get { return this.getString ('X_KOMUE'); } 
            set { this.Set (value, 'X_KOMUE'); }
        }

        @AuraEnabled public Boolean ProofofDelivery
        { 
            get { return this.getBoolean('X_POD'); } 
            set { this.setBoolean(value, 'X_POD'); }
        }

    }
    public class ITEMS_ACTION extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixDL_Detail.ITEMS_ACTION.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixDL_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'POSNR' };
    
            return keyFields;
        }

                @AuraEnabled public String DeliveryItem
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

    }
    public class ITEMS_ACTION_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public ITEMS_ACTION_COLLECTION()
        {
            super('ITEMS_ACTION', SBO_EnosixDL_Detail.ITEMS_ACTION.class, null);
        }

        @AuraEnabled public List<SBO_EnosixDL_Detail.ITEMS_ACTION> getAsList()
        {
            return (List<SBO_EnosixDL_Detail.ITEMS_ACTION>)this.buildList(List<SBO_EnosixDL_Detail.ITEMS_ACTION>.class);
        }
    }
}