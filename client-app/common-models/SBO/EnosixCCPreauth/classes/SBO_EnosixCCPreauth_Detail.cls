/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class SBO_EnosixCCPreauth_Detail extends ensxsdk.EnosixFramework.DetailSBO
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('SBO_EnosixCCPreauth_Detail_Meta', new Type[] {
            SBO_EnosixCCPreauth_Detail.EnosixCCPreauth.class
            , SBO_EnosixCCPreauth_Detail.RESPONSE.class
            } 
        );
    }

    public SBO_EnosixCCPreauth_Detail()
    {
        super('EnosixCCPreauth', SBO_EnosixCCPreauth_Detail.EnosixCCPreauth.class);
    }

    public override Type getType() { return SBO_EnosixCCPreauth_Detail.class; }

    public EnosixCCPreauth initialize(EnosixCCPreauth obj)
    {
        return (EnosixCCPreauth)this.executeInitialize(obj);
    }
    
    public EnosixCCPreauth getDetail(object key)
    {
        return (EnosixCCPreauth)this.executeGetDetail(key);
    }
    
    public EnosixCCPreauth save(EnosixCCPreauth obj)
    {
        return (EnosixCCPreauth) this.executeSave(obj);
    }

    public EnosixCCPreauth command(string command, EnosixCCPreauth obj)
    {
        return (EnosixCCPreauth) this.executeCommand(command, obj);
    }
    
    public with sharing class EnosixCCPreauth extends ensxsdk.EnosixFramework.DetailObject
    {
        public EnosixCCPreauth()
        {
            super('HEADER', new Map<string,type>
                {
                    'RESPONSE' => SBO_EnosixCCPreauth_Detail.RESPONSE.class
                });	
        }

        public override Type getType() { return SBO_EnosixCCPreauth_Detail.EnosixCCPreauth.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixCCPreauth_Detail.registerReflectionInfo();
        }

                @AuraEnabled public String CreditCardNumber
        { 
            get { return this.getString ('CCNUM'); } 
            set { this.Set (value, 'CCNUM'); }
        }

        @AuraEnabled public String CardVerificationValue
        { 
            get { return this.getString ('CVVAL'); } 
            set { this.Set (value, 'CVVAL'); }
        }

        @AuraEnabled public Decimal AmountToBeAuthorized
        { 
            get { return this.getDecimal ('AUTWV'); } 
            set { this.Set (value, 'AUTWV'); }
        }

        @AuraEnabled public String FieldCurrency
        { 
            get { return this.getString ('CCWAE'); } 
            set { this.Set (value, 'CCWAE'); }
        }

        @AuraEnabled public String CardType
        { 
            get { return this.getString ('CCINS'); } 
            set { this.Set (value, 'CCINS'); }
        }

        @AuraEnabled public String CadholderName
        { 
            get { return this.getString ('CCNAME'); } 
            set { this.Set (value, 'CCNAME'); }
        }

        @AuraEnabled public Date ValidToDate
        { 
            get { return this.getDate ('DATBI'); } 
            set { this.Set (value, 'DATBI'); }
        }


        @AuraEnabled public SBO_EnosixCCPreauth_Detail.RESPONSE RESPONSE 
        {
            get
            {
                return (SBO_EnosixCCPreauth_Detail.RESPONSE)this.getStruct(SBO_EnosixCCPreauth_Detail.RESPONSE.class);
            }
        }
        
        }

    //Write child objects
        public class RESPONSE extends ensxsdk.EnosixFramework.ValueObject 
    {
        public override Type getType() { return SBO_EnosixCCPreauth_Detail.RESPONSE.class; }

        public override void registerReflectionForClass()
        {
            SBO_EnosixCCPreauth_Detail.registerReflectionInfo();
        }

        public override List<string> getKeyFields()
        {
            List<string> keyFields = new List<string>{ 'EnosixObjKey' };
    
            return keyFields;
        }

                @AuraEnabled public String AuthorizationResponse
        { 
            get { return this.getString ('REACT'); } 
            set { this.Set (value, 'REACT'); }
        }

        @AuraEnabled public Decimal AuthorizedAmount
        { 
            get { return this.getDecimal ('AUTWR'); } 
            set { this.Set (value, 'AUTWR'); }
        }

        @AuraEnabled public String AuthorizationNumber
        { 
            get { return this.getString ('AUNUM'); } 
            set { this.Set (value, 'AUNUM'); }
        }

        @AuraEnabled public String AuthorizationReferenceCode
        { 
            get { return this.getString ('AUTRA'); } 
            set { this.Set (value, 'AUTRA'); }
        }

        @AuraEnabled public String ResultCode
        { 
            get { return this.getString ('RCRSP'); } 
            set { this.Set (value, 'RCRSP'); }
        }

        @AuraEnabled public String ResultCodeText
        { 
            get { return this.getString ('RTEXT'); } 
            set { this.Set (value, 'RTEXT'); }
        }

        @AuraEnabled public String CVVResultCode
        { 
            get { return this.getString ('RCCVV'); } 
            set { this.Set (value, 'RCCVV'); }
        }

    }
}