/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class SBO_EnosixXiIntercept_Detail extends ensxsdk.EnosixFramework.DetailSBO
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('SBO_EnosixXiIntercept_Detail_Meta', new Type[] {
            SBO_EnosixXiIntercept_Detail.EnosixXiIntercept.class
            , SBO_EnosixXiIntercept_Detail.RESPONSE.class
            , SBO_EnosixXiIntercept_Detail.CMPI_LOOKUP.class
            , SBO_EnosixXiIntercept_Detail.CMPI_AUTHENTICATE.class
            , SBO_EnosixXiIntercept_Detail.FIELDS.class
            , SBO_EnosixXiIntercept_Detail.PAYMENT_TYPES.class
            } 
        );
    }

    public SBO_EnosixXiIntercept_Detail()
    {
        super('EnosixXiIntercept', SBO_EnosixXiIntercept_Detail.EnosixXiIntercept.class);
    }

    public override Type getType() { return SBO_EnosixXiIntercept_Detail.class; }

    public EnosixXiIntercept initialize(EnosixXiIntercept obj)
    {
        return (EnosixXiIntercept)this.executeInitialize(obj);
    }
    
    public EnosixXiIntercept getDetail(object key)
    {
        return (EnosixXiIntercept)this.executeGetDetail(key);
    }
    
    public EnosixXiIntercept save(EnosixXiIntercept obj)
    {
        return (EnosixXiIntercept) this.executeSave(obj);
    }

    public EnosixXiIntercept command(string command, EnosixXiIntercept obj)
    {
        return (EnosixXiIntercept) this.executeCommand(command, obj);
    }
    
    public with sharing class EnosixXiIntercept extends ensxsdk.EnosixFramework.DetailObject
    {
        public EnosixXiIntercept()
        {
            super('HEADER', new Map<string,type>
                {
                    'RESPONSE' => SBO_EnosixXiIntercept_Detail.RESPONSE.class
                    ,'CMPI_LOOKUP' => SBO_EnosixXiIntercept_Detail.CMPI_LOOKUP.class
                    ,'CMPI_AUTHENTICATE' => SBO_EnosixXiIntercept_Detail.CMPI_AUTHENTICATE.class
                    ,'FIELDS' => SBO_EnosixXiIntercept_Detail.FIELDS_COLLECTION.class
                    ,'PAYMENT_TYPES' => SBO_EnosixXiIntercept_Detail.PAYMENT_TYPES_COLLECTION.class
                });	
        }

        public override Type getType() { return SBO_EnosixXiIntercept_Detail.EnosixXiIntercept.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixXiIntercept_Detail.registerReflectionInfo();
        }

                @AuraEnabled public String MerchantGUID
        { 
            get { return this.getString ('MERCHANTGUID'); } 
            set { this.Set (value, 'MERCHANTGUID'); }
        }

        @AuraEnabled public String AccessToken
        { 
            get { return this.getString ('ACCESSTOKEN'); } 
            set { this.Set (value, 'ACCESSTOKEN'); }
        }

        @AuraEnabled public String Signature
        { 
            get { return this.getString ('SIGNATURE'); } 
            set { this.Set (value, 'SIGNATURE'); }
        }

        @AuraEnabled public String StatusCode
        { 
            get { return this.getString ('STATUSCODE'); } 
            set { this.Set (value, 'STATUSCODE'); }
        }

        @AuraEnabled public String Message
        { 
            get { return this.getString ('MESSAGE'); } 
            set { this.Set (value, 'MESSAGE'); }
        }

        @AuraEnabled public String XiInterceptURL
        { 
            get { return this.getString ('XIURL'); } 
            set { this.Set (value, 'XIURL'); }
        }

        @AuraEnabled public String Key
        { 
            get { return this.getString ('KEY'); } 
            set { this.Set (value, 'KEY'); }
        }

        @AuraEnabled public String CreditCardNumber
        { 
            get { return this.getString ('CCNUM'); } 
            set { this.Set (value, 'CCNUM'); }
        }

        @AuraEnabled public String CreditCardHolder
        { 
            get { return this.getString ('CCNAM'); } 
            set { this.Set (value, 'CCNAM'); }
        }

        @AuraEnabled public String ValidToMonth
        { 
            get { return this.getString ('VALTM'); } 
            set { this.Set (value, 'VALTM'); }
        }

        @AuraEnabled public String ValidToYear
        { 
            get { return this.getString ('VALTY'); } 
            set { this.Set (value, 'VALTY'); }
        }

        @AuraEnabled public Boolean CardVerificationValue
        { 
            get { return this.getBoolean('CCSCD'); } 
            set { this.setBoolean(value, 'CCSCD'); }
        }

        @AuraEnabled public String HostUri
        { 
            get { return this.getString ('HOSTURI'); } 
            set { this.Set (value, 'HOSTURI'); }
        }

        @AuraEnabled public String CSSUri
        { 
            get { return this.getString ('CSSURI'); } 
            set { this.Set (value, 'CSSURI'); }
        }


        @AuraEnabled public SBO_EnosixXiIntercept_Detail.RESPONSE RESPONSE 
        {
            get
            {
                return (SBO_EnosixXiIntercept_Detail.RESPONSE)this.getStruct(SBO_EnosixXiIntercept_Detail.RESPONSE.class);
            }
        }
        
    
        @AuraEnabled public SBO_EnosixXiIntercept_Detail.CMPI_LOOKUP CMPI_LOOKUP 
        {
            get
            {
                return (SBO_EnosixXiIntercept_Detail.CMPI_LOOKUP)this.getStruct(SBO_EnosixXiIntercept_Detail.CMPI_LOOKUP.class);
            }
        }
        
    
        @AuraEnabled public SBO_EnosixXiIntercept_Detail.CMPI_AUTHENTICATE CMPI_AUTHENTICATE 
        {
            get
            {
                return (SBO_EnosixXiIntercept_Detail.CMPI_AUTHENTICATE)this.getStruct(SBO_EnosixXiIntercept_Detail.CMPI_AUTHENTICATE.class);
            }
        }
        
            @AuraEnabled public FIELDS_COLLECTION FIELDS
        {
            get 
            { 
                return (FIELDS_COLLECTION)this.getCollection(SBO_EnosixXiIntercept_Detail.FIELDS_COLLECTION.class); 
            }
        }

                @AuraEnabled public PAYMENT_TYPES_COLLECTION PAYMENT_TYPES
        {
            get 
            { 
                return (PAYMENT_TYPES_COLLECTION)this.getCollection(SBO_EnosixXiIntercept_Detail.PAYMENT_TYPES_COLLECTION.class); 
            }
        }

            }

    //Write child objects
        public class RESPONSE extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixXiIntercept_Detail.RESPONSE.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixXiIntercept_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'EnosixObjKey' };
    
            return keyFields;
        }

                @AuraEnabled public String StatusCode
        { 
            get { return this.getString ('STATUSCODE'); } 
            set { this.Set (value, 'STATUSCODE'); }
        }

        @AuraEnabled public String Message
        { 
            get { return this.getString ('MESSAGE'); } 
            set { this.Set (value, 'MESSAGE'); }
        }

        @AuraEnabled public String CreditCardNumber
        { 
            get { return this.getString ('CCNUM'); } 
            set { this.Set (value, 'CCNUM'); }
        }

        @AuraEnabled public String PaymetricCardType
        { 
            get { return this.getString ('CARD_TYPE'); } 
            set { this.Set (value, 'CARD_TYPE'); }
        }

        @AuraEnabled public String CreditCardHolder
        { 
            get { return this.getString ('CCNAM'); } 
            set { this.Set (value, 'CCNAM'); }
        }

        @AuraEnabled public String ValidToMonth
        { 
            get { return this.getString ('VALTM'); } 
            set { this.Set (value, 'VALTM'); }
        }

        @AuraEnabled public String ValidToYear
        { 
            get { return this.getString ('VALTY'); } 
            set { this.Set (value, 'VALTY'); }
        }

        @AuraEnabled public String CardVerificationValue
        { 
            get { return this.getString ('CCSCD'); } 
            set { this.Set (value, 'CCSCD'); }
        }

        @AuraEnabled public String SAPCardType
        { 
            get { return this.getString ('SAP_CARD_TYPE'); } 
            set { this.Set (value, 'SAP_CARD_TYPE'); }
        }

    }
    public class CMPI_LOOKUP extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixXiIntercept_Detail.CMPI_LOOKUP.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixXiIntercept_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'EnosixObjKey' };
    
            return keyFields;
        }

                @AuraEnabled public String ErrorNo
        { 
            get { return this.getString ('ERRORNO'); } 
            set { this.Set (value, 'ERRORNO'); }
        }

        @AuraEnabled public String ErrorDescription
        { 
            get { return this.getString ('ERRORDESC'); } 
            set { this.Set (value, 'ERRORDESC'); }
        }

        @AuraEnabled public String Secure3DECIFlag
        { 
            get { return this.getString ('ECIFLG'); } 
            set { this.Set (value, 'ECIFLG'); }
        }

        @AuraEnabled public String AvailabilityStatus
        { 
            get { return this.getString ('ENROLLED'); } 
            set { this.Set (value, 'ENROLLED'); }
        }

        @AuraEnabled public String CentinelTransactionID
        { 
            get { return this.getString ('TRANSACTIONID'); } 
            set { this.Set (value, 'TRANSACTIONID'); }
        }

        @AuraEnabled public String CentinelOrderID
        { 
            get { return this.getString ('ORDERID'); } 
            set { this.Set (value, 'ORDERID'); }
        }

        @AuraEnabled public String EncodedPaymentRequest
        { 
            get { return this.getString ('PAYLOAD'); } 
            set { this.Set (value, 'PAYLOAD'); }
        }

        @AuraEnabled public String RedirectURL
        { 
            get { return this.getString ('ACSURL'); } 
            set { this.Set (value, 'ACSURL'); }
        }

    }
    public class CMPI_AUTHENTICATE extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixXiIntercept_Detail.CMPI_AUTHENTICATE.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixXiIntercept_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'EnosixObjKey' };
    
            return keyFields;
        }

                @AuraEnabled public String Secure3DECIFlag
        { 
            get { return this.getString ('ECIFLG'); } 
            set { this.Set (value, 'ECIFLG'); }
        }

        @AuraEnabled public String ParesStatus
        { 
            get { return this.getString ('PARESSTATUS'); } 
            set { this.Set (value, 'PARESSTATUS'); }
        }

        @AuraEnabled public String SignatureVerification
        { 
            get { return this.getString ('SIGNVERI'); } 
            set { this.Set (value, 'SIGNVERI'); }
        }

        @AuraEnabled public String CardinallXID
        { 
            get { return this.getString ('XID'); } 
            set { this.Set (value, 'XID'); }
        }

        @AuraEnabled public String ErrorNo
        { 
            get { return this.getString ('ERRORNO'); } 
            set { this.Set (value, 'ERRORNO'); }
        }

        @AuraEnabled public String ErrorDescription
        { 
            get { return this.getString ('ERRORDESC'); } 
            set { this.Set (value, 'ERRORDESC'); }
        }

        @AuraEnabled public String Secure3DCAVV
        { 
            get { return this.getString ('CAVV'); } 
            set { this.Set (value, 'CAVV'); }
        }

    }
    public class FIELDS extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixXiIntercept_Detail.FIELDS.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixXiIntercept_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'NAME' };
    
            return keyFields;
        }

                @AuraEnabled public String Name
        { 
            get { return this.getString ('NAME'); } 
            set { this.Set (value, 'NAME'); }
        }

        @AuraEnabled public String Value
        { 
            get { return this.getString ('VALUE'); } 
            set { this.Set (value, 'VALUE'); }
        }

    }
    public class FIELDS_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public FIELDS_COLLECTION()
        {
            super('FIELDS', SBO_EnosixXiIntercept_Detail.FIELDS.class, null);
        }

        @AuraEnabled public List<SBO_EnosixXiIntercept_Detail.FIELDS> getAsList()
        {
            return (List<SBO_EnosixXiIntercept_Detail.FIELDS>)this.buildList(List<SBO_EnosixXiIntercept_Detail.FIELDS>.class);
        }
    }
    public class PAYMENT_TYPES extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixXiIntercept_Detail.PAYMENT_TYPES.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixXiIntercept_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'TYPE','VALUE' };
    
            return keyFields;
        }

                @AuraEnabled public String PaymentType
        { 
            get { return this.getString ('TYPE'); } 
            set { this.Set (value, 'TYPE'); }
        }

        @AuraEnabled public String Value
        { 
            get { return this.getString ('VALUE'); } 
            set { this.Set (value, 'VALUE'); }
        }

        @AuraEnabled public String Text
        { 
            get { return this.getString ('TEXT'); } 
            set { this.Set (value, 'TEXT'); }
        }

    }
    public class PAYMENT_TYPES_COLLECTION extends ensxsdk.EnosixFramework.FrameworkCollection
    {
        public PAYMENT_TYPES_COLLECTION()
        {
            super('PAYMENT_TYPES', SBO_EnosixXiIntercept_Detail.PAYMENT_TYPES.class, null);
        }

        @AuraEnabled public List<SBO_EnosixXiIntercept_Detail.PAYMENT_TYPES> getAsList()
        {
            return (List<SBO_EnosixXiIntercept_Detail.PAYMENT_TYPES>)this.buildList(List<SBO_EnosixXiIntercept_Detail.PAYMENT_TYPES>.class);
        }
    }
}