/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class SBO_EnosixDL_Search extends ensxsdk.EnosixFramework.SearchSBO 
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('SBO_EnosixDL_Search_Meta', new Type[] {
            SBO_EnosixDL_Search.EnosixDL_SC.class
            , SBO_EnosixDL_Search.EnosixDL_SR.class
            , SBO_EnosixDL_Search.SEARCHRESULT.class
            , SBO_EnosixDL_Search.SEARCHPARAMS.class
            , SBO_EnosixDL_Search.SEARCHRESULT.class
            } 
        );
    }

    public SBO_EnosixDL_Search() 
    {
        super('EnosixDL', SBO_EnosixDL_Search.EnosixDL_SC.class, SBO_EnosixDL_Search.EnosixDL_SR.class);
    }
    
    public override Type getType() { return SBO_EnosixDL_Search.class; }

    public EnosixDL_SC search(EnosixDL_SC sc) 
    {
        return (EnosixDL_SC)super.executeSearch(sc);
    }

    public EnosixDL_SC initialize(EnosixDL_SC sc) 
    {
        return (EnosixDL_SC)super.executeInitialize(sc);
    }

    public class EnosixDL_SC extends ensxsdk.EnosixFramework.SearchContext 
    { 		
        public EnosixDL_SC() 
        {		
            super(new Map<string,type>		
                {		
                    'SEARCHPARAMS' => SBO_EnosixDL_Search.SEARCHPARAMS.class		
                });		
        }

        public override Type getType() { return SBO_EnosixDL_Search.EnosixDL_SC.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixDL_Search.registerReflectionInfo();
        }

        public EnosixDL_SR result { get { return (EnosixDL_SR)baseResult; } }


        @AuraEnabled public SBO_EnosixDL_Search.SEARCHPARAMS SEARCHPARAMS 
        {
            get
            {
                return (SBO_EnosixDL_Search.SEARCHPARAMS)this.getStruct(SBO_EnosixDL_Search.SEARCHPARAMS.class);
            }
        }
        
        }

    public class EnosixDL_SR extends ensxsdk.EnosixFramework.SearchResult 
    {
        public EnosixDL_SR() 
        {
            super(new Map<string,type>{'SEARCHRESULT' => SBO_EnosixDL_Search.SEARCHRESULT.class } );
        }
        
        public ensxsdk.EnosixFramework.FrameworkCollection SearchResults
        {
            get { return super.getCollection(SBO_EnosixDL_Search.SEARCHRESULT.class); }
        }
        
        public List<SEARCHRESULT> getResults() 
        {
            List<SEARCHRESULT> results = new List<SEARCHRESULT>();
            SearchResults.copyTo(results);
            return results;
        }

        public override Type getType() { return SBO_EnosixDL_Search.EnosixDL_SR.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixDL_Search.registerReflectionInfo();
        }
    }

    public class SEARCHPARAMS extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixDL_Search.SEARCHPARAMS.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixDL_Search.registerReflectionInfo();
        }
        @AuraEnabled public String Route
        { 
            get { return this.getString ('ROUTE'); } 
            set { this.Set (value, 'ROUTE'); }
        }

        @AuraEnabled public String Truck
        { 
            get { return this.getString ('TRAID'); } 
            set { this.Set (value, 'TRAID'); }
        }

        @AuraEnabled public Date FromCreateDate
        { 
            get { return this.getDate ('ERDAT_FR'); } 
            set { this.Set (value, 'ERDAT_FR'); }
        }

        @AuraEnabled public Date ToCreateDate
        { 
            get { return this.getDate ('ERDAT_TO'); } 
            set { this.Set (value, 'ERDAT_TO'); }
        }

        @AuraEnabled public Date DeliveryDateFrom
        { 
            get { return this.getDate ('LFDAT_FR'); } 
            set { this.Set (value, 'LFDAT_FR'); }
        }

        @AuraEnabled public Date DeliveryDateTo
        { 
            get { return this.getDate ('LFDAT_TO'); } 
            set { this.Set (value, 'LFDAT_TO'); }
        }

        @AuraEnabled public String DeliveryFrom
        { 
            get { return this.getString ('VBELN_FR'); } 
            set { this.Set (value, 'VBELN_FR'); }
        }

        @AuraEnabled public String DeliveryTo
        { 
            get { return this.getString ('VBELN_TO'); } 
            set { this.Set (value, 'VBELN_TO'); }
        }

        @AuraEnabled public String SoldToParty
        { 
            get { return this.getString ('KUNAG'); } 
            set { this.Set (value, 'KUNAG'); }
        }

        @AuraEnabled public String ShipToParty
        { 
            get { return this.getString ('KUNWE'); } 
            set { this.Set (value, 'KUNWE'); }
        }

        @AuraEnabled public String DeliveryType
        { 
            get { return this.getString ('LFART'); } 
            set { this.Set (value, 'LFART'); }
        }

        @AuraEnabled public String ShippingPoint
        { 
            get { return this.getString ('VSTEL'); } 
            set { this.Set (value, 'VSTEL'); }
        }

        @AuraEnabled public String ShippingConditions
        { 
            get { return this.getString ('VSBED'); } 
            set { this.Set (value, 'VSBED'); }
        }

        @AuraEnabled public String DeliveryPriority
        { 
            get { return this.getString ('LPRIO'); } 
            set { this.Set (value, 'LPRIO'); }
        }

        @AuraEnabled public String BillofLading
        { 
            get { return this.getString ('BOLNR'); } 
            set { this.Set (value, 'BOLNR'); }
        }

        @AuraEnabled public Date PGIDateFrom
        { 
            get { return this.getDate ('WADAT_FR'); } 
            set { this.Set (value, 'WADAT_FR'); }
        }

        @AuraEnabled public Date PGIDateTo
        { 
            get { return this.getDate ('WADAT_TO'); } 
            set { this.Set (value, 'WADAT_TO'); }
        }

        @AuraEnabled public String Username
        { 
            get { return this.getString ('USERNAME'); } 
            set { this.Set (value, 'USERNAME'); }
        }

        @AuraEnabled public Boolean Open
        { 
            get { return this.getBoolean('X_OPEN'); } 
            set { this.setBoolean(value, 'X_OPEN'); }
        }

        @AuraEnabled public Boolean Picked
        { 
            get { return this.getBoolean('X_PICKED'); } 
            set { this.setBoolean(value, 'X_PICKED'); }
        }

        @AuraEnabled public Boolean Packed
        { 
            get { return this.getBoolean('X_PACKED'); } 
            set { this.setBoolean(value, 'X_PACKED'); }
        }

        @AuraEnabled public Boolean PGIed
        { 
            get { return this.getBoolean('X_PGIED'); } 
            set { this.setBoolean(value, 'X_PGIED'); }
        }

    }

    public class SEARCHRESULT extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixDL_Search.SEARCHRESULT.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixDL_Search.registerReflectionInfo();
        }
        @AuraEnabled public String Delivery
        { 
            get { return this.getString ('VBELN'); } 
            set { this.Set (value, 'VBELN'); }
        }

        @AuraEnabled public String Route
        { 
            get { return this.getString ('ROUTE'); } 
            set { this.Set (value, 'ROUTE'); }
        }

        @AuraEnabled public String Truck
        { 
            get { return this.getString ('TRAID'); } 
            set { this.Set (value, 'TRAID'); }
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

        @AuraEnabled public String SoldToName
        { 
            get { return this.getString ('KUNAG_NAME'); } 
            set { this.Set (value, 'KUNAG_NAME'); }
        }

        @AuraEnabled public String SoldToCity
        { 
            get { return this.getString ('KUNAG_CITY1'); } 
            set { this.Set (value, 'KUNAG_CITY1'); }
        }

        @AuraEnabled public String SoldToRegion
        { 
            get { return this.getString ('KUNAG_REGION'); } 
            set { this.Set (value, 'KUNAG_REGION'); }
        }

        @AuraEnabled public String ShipToParty
        { 
            get { return this.getString ('KUNWE'); } 
            set { this.Set (value, 'KUNWE'); }
        }

        @AuraEnabled public String ShipToName
        { 
            get { return this.getString ('KUNWE_NAME'); } 
            set { this.Set (value, 'KUNWE_NAME'); }
        }

        @AuraEnabled public String ShipToCity
        { 
            get { return this.getString ('KUNWE_CITY1'); } 
            set { this.Set (value, 'KUNWE_CITY1'); }
        }

        @AuraEnabled public String ShipToRegion
        { 
            get { return this.getString ('KUNWE_REGION'); } 
            set { this.Set (value, 'KUNWE_REGION'); }
        }

        @AuraEnabled public String ShippingPoint
        { 
            get { return this.getString ('VSTEL'); } 
            set { this.Set (value, 'VSTEL'); }
        }

        @AuraEnabled public String ShippingConditions
        { 
            get { return this.getString ('VSBED'); } 
            set { this.Set (value, 'VSBED'); }
        }

        @AuraEnabled public String DeliveryPriority
        { 
            get { return this.getString ('LPRIO'); } 
            set { this.Set (value, 'LPRIO'); }
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

        @AuraEnabled public String DeliveryStatus
        { 
            get { return this.getString ('DELV_STAT'); } 
            set { this.Set (value, 'DELV_STAT'); }
        }

    }

    public class SEARCHRESULT_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public SEARCHRESULT_COLLECTION()
        {
            super('SEARCHRESULT', SBO_EnosixDL_Search.SEARCHRESULT.class, null);
        }

        public List<SBO_EnosixDL_Search.SEARCHRESULT> getAsList()
        {
            return (List<SBO_EnosixDL_Search.SEARCHRESULT>)this.buildList(List<SBO_EnosixDL_Search.SEARCHRESULT>.class);
        }
    }


}