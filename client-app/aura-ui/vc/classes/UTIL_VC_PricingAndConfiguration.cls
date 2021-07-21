global class UTIL_VC_PricingAndConfiguration
{
    @testVisible
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_VC_PricingAndConfiguration.class);

    public static String getProductIdForSAPMaterialNumber(string sapMaterialNumber)
    {
        String productId = null;
        Product2 prod = UTIL_SFProduct.getProductByMaterialNumber(sapMaterialNumber);
        if(prod != null)
        {
            productId = prod.Id;
        }
        return productId;
    }
    public static String getSAPMaterialNumberFromProductId(String productId)
    {
        String productMaterialNumber = null;
        if (String.isNotEmpty(productId)) {
            Product2 pdt = UTIL_SFProduct.getProductById(productId);
            productMaterialNumber = UTIL_SFProduct.getMaterialNumberFromProduct(pdt);
        }
        return productMaterialNumber;
    }

    public static String stripLeadingZeros(String s)
    {
        if (s.length()<=1)
            return s;

        return s.replaceFirst('^0+','');
    }

     public static ENSX_VCConfiguration getInitialConfigFromMaterialAndPricing(String material,ENSX_VCPricingConfiguration pricing)
    {
        return null;
//         SBO_EnosixVC_Detail sbo = new SBO_EnosixVC_Detail();
//         SBO_EnosixVC_Detail.EnosixVC config = sbo.getDetail(material);
//         ApplyPricingConfigurationToSBO(config, pricing);
//         config = sbo.command('CMD_INITIALIZE', config);

//         System.debug('init config=' + config);

//         UTIL_PageMessages.addFrameworkMessages(config.getMessages());

//         ENSX_VCConfiguration serializableCfg = ENSX_VCConfiguration.getConfigurationFromSBOModel(config);
//         return serializableCfg;
    }

    /// Takes a material number, a pricing configuration and any custom kingspan settings.
    /// We use the pricing configuration for the moment since it wraps up in a nice little package all of the
    /// Sales Area information we need, and for kingspan the way they do their defaults is based
    /// in part upon their sales area information.
    public static DS_VCMaterialConfiguration getInitialConfigFromMaterialAndPricingAndCustomConfig(String material
        , ENSX_VCPricingConfiguration pricing)
    {
        logger.enter('getInitialConfigFromMaterialAndPricingAndCustomConfig', new Map<String, Object> {
            'material' => material,
            'pricing' => pricing
        });
        DS_VCMaterialConfiguration returnValue =  null;
        try
        {
            SBO_EnosixVC_Detail.EnosixVC config = new SBO_EnosixVC_Detail.EnosixVC();

            config.Material = material;
            // The pricing config is a carrier for most of the sales area information that is
            // needed by kingspan to properly return which VC options are available.
            config = applyPricingConfigurationToSBO(config, pricing);

            returnValue = execCmd('CMD_INITIALIZE', config, pricing.SessionData);
            if (!returnValue.isSuccess) returnValue = null;
        }
        catch(Exception ex)
        {
            logger.log(LoggingLevel.ERROR, 'There was an exception thrown when attempting to getInitialConfigFromMaterialAndPricingAndCustomConfig', ex);
        }
        finally
        {
            logger.exit();
        }
        return returnValue;
    }

    // Long term this needs a cleaner refactor. I'd like to remove some of these ENSX classes
    // They don't mesh with our current naming strategy and wind up being more wonky serialization
    // wrappers than actually useful utility classes. --MWK 5-14-2018
    @testVisible
    public static SBO_EnosixVC_Detail.EnosixVC applyPricingConfigurationToSBO(SBO_EnosixVC_Detail.EnosixVC sboConfig, ENSX_VCPricingConfiguration pricingConfiguration)
    {
        if (null !=  PricingConfiguration)
        {
            // We're disabling all pricing calculation at this point. The "Pricing Configuration" is still
            // the object that is a carrier for all of the header info. --MWK 7-27-2018
            sboConfig.CalculatePrice = false;

            // Corollary of new DS_VCMaterialConfiguration(SBO_EnosixVC_Detail.EnosixVC)
            // when you make a change here, also make the corresponding change there

            sboConfig.ConfigDate = pricingConfiguration.ConfigDate != null ? pricingConfiguration.ConfigDate : Date.today();

            if (null != pricingConfiguration.EnosixObjKey) sboConfig.set(pricingConfiguration.EnosixObjKey, 'EnosixObjKey');

            if (null != pricingConfiguration.ConfigInstance) sboConfig.ConfigInstance = pricingConfiguration.ConfigInstance;
            if (null != pricingConfiguration.ConfigurationInternal) sboConfig.ConfigurationInternal = pricingConfiguration.ConfigurationInternal;
            if (null != pricingConfiguration.DistributionChannel) sboConfig.DistributionChannel = pricingConfiguration.DistributionChannel;
            if (null != pricingConfiguration.Division) sboConfig.Division = pricingConfiguration.Division;
            if (null != pricingConfiguration.Material) sboConfig.Material = pricingConfiguration.Material;
            if (null != pricingConfiguration.ObjectKey) sboConfig.ObjectKey = pricingConfiguration.ObjectKey;
            if (null != pricingConfiguration.OrderQuantity) sboConfig.OrderQuantity = pricingConfiguration.OrderQuantity;
            if (null != pricingConfiguration.Plant) sboConfig.Plant = pricingConfiguration.Plant;
            if (null != pricingConfiguration.SalesDocumentCurrency) sboConfig.SalesDocumentCurrency = pricingConfiguration.SalesDocumentCurrency;
            if (String.isEmpty(sboConfig.SalesDocumentType)) sboConfig.SalesDocumentType = (String)UTIL_AppSettings.getValue(UTIL_AppSettings.VC, 'DefaultSalesDocType', '');
            if (null != pricingConfiguration.SalesDocumentType) sboConfig.SalesDocumentType = pricingConfiguration.SalesDocumentType;
            if (null != pricingConfiguration.SalesOrganization) sboConfig.SalesOrganization = pricingConfiguration.SalesOrganization;
            if (null != pricingConfiguration.SalesUnit) sboConfig.SalesUnit = pricingConfiguration.SalesUnit;
            if (null != pricingConfiguration.SoldToParty) sboConfig.SoldToParty = pricingConfiguration.SoldToParty;
            if (null != pricingConfiguration.ShipToParty) sboConfig.ShipToParty = pricingConfiguration.ShipToParty;
        }

        return sboConfig;
    }

    /// Initializes a VC configuration from an existing BOM
    public static DS_VCMaterialConfiguration getInitializedConfigSBOModelFromBOM(string material, ENSX_VCPricingConfiguration pricing, List<DS_VCCharacteristicValues> BOM)
    {
        SBO_EnosixVC_Detail sbo = new SBO_EnosixVC_Detail();
        SBO_EnosixVC_Detail.EnosixVC config = new SBO_EnosixVC_Detail.EnosixVC();

        config.Material = material;
        // The pricing config is a carrier for most of the sales area information that is
        // needed by kingspan to properly return which VC options are available.
        config = applyPricingConfigurationToSBO(config, pricing);

        Integer bomTot = BOM.size();
        for (Integer bomCnt = 0 ; bomCnt < bomTot ; bomCnt++)
        {
            DS_VCCharacteristicValues selectedValue = BOM[bomCnt];
            SBO_EnosixVC_Detail.SELECTEDVALUES val = selectedValue.getSBOASelectedValuesForModel();
            config.SELECTEDVALUES.add(val);
        }
        
        DS_VCMaterialConfiguration returnValue = execCmd('CMD_INITIALIZE_FROM_DATA', config, pricing.SessionData);
        if (!returnValue.isSuccess) returnValue = null;
        return returnValue;
    }

    public static DS_VCMaterialConfiguration proccessAndLogVCConfiguration(
        DS_VCMaterialConfiguration config
        , List<DS_VCCharacteristicValues> selectedValues)
    { 
        return proccessAndLogVCConfiguration(config, selectedValues, new List<String>()); 
    }

    public static DS_VCMaterialConfiguration proccessAndLogVCConfiguration(
        DS_VCMaterialConfiguration config
        , List<DS_VCCharacteristicValues> selectedValues
        , List<String> characteristics)
    {
        SBO_EnosixVC_Detail.EnosixVC sboConfig = config.convertToSBO(selectedValues);
        Integer charTot = characteristics.size();
        for (Integer charCnt = 0 ; charCnt < charTot ; charCnt++) 
        {
            string characteristic = characteristics[charCnt];
            SBO_EnosixVC_Detail.CHARACTERISTICS c = new SBO_EnosixVC_Detail.CHARACTERISTICS();
            c.CharacteristicName = characteristic;
            sboConfig.CHARACTERISTICS.add(c);
        }
        return execCmd('CMD_PROCESS', sboConfig, config.SessionData);
    }

    @testVisible
    private static DS_VCMaterialConfiguration execCmd(String command, SBO_EnosixVC_Detail.EnosixVC sboConfig, String requestSessionData) 
    {
        SBO_EnosixVC_Detail sbo = new SBO_EnosixVC_Detail();
        if (true == UseSession) 
        {
            SessionData = requestSessionData;
            SBO_EnosixVC_Detail.EnosixVC testConfig = new SBO_EnosixVC_Detail.EnosixVC();
            if (Test.isRunningTest())
            {
                testConfig.setSuccess(true);
                SBO_EnosixVC_Detail.CHARACTERISTICS characteristic = new SBO_EnosixVC_Detail.CHARACTERISTICS();
                characteristic.CharacteristicName = 'CharacteristicName';
                characteristic.CharacteristicDescription = 'CharacteristicDescription';
                testConfig.CHARACTERISTICS.add(characteristic);
                SBO_EnosixVC_Detail.ALLOWEDVALUES allowedValue = new SBO_EnosixVC_Detail.ALLOWEDVALUES();
                allowedValue.CharacteristicName = 'CharacteristicName';
                allowedValue.CharacteristicValue = 'CharacteristicName';
                allowedValue.CharacteristicValueDescription = 'CharacteristicName';
                testConfig.ALLOWEDVALUES.add(allowedValue);
            }
            sboConfig = Test.isRunningTest() ? testConfig : (SBO_EnosixVC_Detail.EnosixVC)executeCommand(sbo, sboConfig, command);
        } 
        else 
        {
            sboConfig = sbo.command(command, sboConfig);
        }

        DS_VCMaterialConfiguration result = new DS_VCMaterialConfiguration(sboConfig);
        result.isSuccess = true;
        if(!sboConfig.isSuccess())
        {
            result.isSuccess = false;
            sboConfig.ConfigurationIsValid = false;
        }
        UTIL_PageMessages.addFrameworkMessages(sboConfig.getMessages());
        result.SessionData = SessionData;

        HttpRequest request = createCloseRequest();

        String endPoint = request.getEndpoint();
        String namedCredentialName = endPoint.startsWith('callout:') ? endPoint.substring(8).split('\\?')[0] : null;
        NamedCredential namedCred = namedCredentialName == null ? null : [SELECT DeveloperName, Endpoint From NamedCredential Where DeveloperName = :namedCredentialName Limit 1];
        endPoint = namedCred == null ? endPoint : endPoint.replace('callout:' + namedCredentialName, namedCred.Endpoint);

        HttpCloseReqquest httpClose = new HttpCloseReqquest();
        httpClose.Cookie = request.getHeader('Cookie');
        httpClose.BodyDocument = request.getBodyDocument().toXmlString();
        httpClose.Endpoint = endPoint;
        httpClose.Method = request.getMethod();
        httpClose.Client = request.getHeader('Client');
        httpClose.ContentType = request.getHeader('Content-Type');
        result.HttpCloseReqquest = JSON.serialize(httpClose);
        return result;
    }

    private class HttpCloseReqquest
    {
        public String Cookie { get; private set; }
        public String BodyDocument { get; private set; }
        public String Endpoint { get; private set; }
        public String Method { get; private set; }
        public String Client { get; private set; }
        public String ContentType { get; private set; }
    }

    // MUCK for initialize and command outside of framework with session support.

    public static Boolean UseSession = (Boolean)UTIL_AppSettings.getValue(UTIL_AppSettings.VC, 'UseSapSession', false);
    @testVisible
    private static Map<String,String> headers  { get; set; }

    public static String SessionData 
    {
        get
        {
            return null == headers ? null : EncodingUtil.base64Encode(Blob.valueOf(JSON.serialize(headers, true)));
        }
        set 
        {
            headers = String.isBlank(value) ? null : (Map<String,String>)JSON.deserialize(EncodingUtil.base64Decode(value).toString(), Map<String,String>.class);
        }
    }

/* Toggle sdk v1.2 (//*) vs v1.3 (/*) dependency by adding or removing the first slash on this line
    // sdk v1.2: Allow above code to compile while targeting sdk v1.2
    public static ensxsdk.EnosixFramework.DetailObject executeCommand(ensxsdk.EnosixFramework.DetailSBO sbo, ensxsdk.EnosixFramework.DetailObject obj, String command){
        return null;
    }
/*/ // sdk v1.3: Framework is opened up so code outside the Framework can add SAP session support
    public static void closeSession(String sd) 
    {
        logger.debug('closeSession: ' + sd);
        // The try/catch here is designed to allow this to be a fire-and-forget operation
        try 
        {
            if (String.isNotBlank(sd)) 
            {
                System.enqueueJob(new AsyncCloseSession(sd));
            }
        } 
        catch (Exception ex) 
        {
            logger.warn('closeSession', ex);
        }
    }

    private class AsyncCloseSession implements Queueable, Database.AllowsCallouts 
    {
        private String sessData;
        AsyncCloseSession(String sd) 
        {
            sessData = sd;
        }
        public void execute(QueueableContext context) 
        {
            // Close the session by doing any request with sessionLogoff=true.
            // Here we are ironically calling "login" to in essence do a logout.
            SessionData = sessData;
            httpSend(createCloseRequest(),
                // traceInfo
                new Map<String,String>
                {
                    'Operation' => 'Login',
                    'SBO' => ''
                }
            );
        }
    }

    @testVisible
    private static HttpRequest createCloseRequest()
    {
        return createRequest(
                new Map<String, object> { 'function'=>'login' },
                new Map<String, object>{ 'I_LICENSEKEY' => '' },
                new map<String, String>(),
                // sessionLogoff
                true
            );
    }

    @testVisible
    private static String getObjectKey(ensxsdk.EnosixFramework.ValueObject obj) 
    {
        if (null != obj) 
        {
            return obj.getString('EnosixObjKey');
        }
        return '';
    }

    @testVisible
    private static boolean isInitialKey(String businessObjectKey) 
    {
        return String.isBlank(businessObjectKey) || businessObjectKey.startsWith('INIT:') || businessObjectKey.startsWith('NEW:');
    }

    @testVisible
    private static string getBusinessObjectName(ensxsdk.EnosixFramework.DetailSBO detailSBO) 
    {
        //return detailObj.businessObjectName;
        return detailSBO.getBusinessObjectName();
    }

    private static HttpRequest createRequest(Map<String, Object> requestArguments, Map<String, Object>  requestParameters, Map<String, String> serilizationAttributes) 
    {
        return createRequest(requestArguments, requestParameters, serilizationAttributes, false);
    }

    private static HttpRequest createRequest(Map<String, Object> requestArguments, Map<String, Object>  requestParameters, Map<String, String> serilizationAttributes, Boolean sessionLogoff) 
    {
        HttpRequest request = ensxsdk.EnosixFramework.createRequest(requestArguments, requestParameters, serilizationAttributes);

        if (true == UseSession) 
        {
            // Remove session cancel flag from url. This will enable sessions and should recieve session cookie headers
            request.setEndpoint( request.getEndpoint().replace('sap-sessioncmd=cancel&', '') );

            if (true == sessionLogoff) 
            {
                // Remove session cancel flag from url. This will enable sessions and should recieve session cookie headers
                request.setEndpoint( request.getEndpoint() + '&sap-sessioncmd=logoff' );
            }

            if (null != headers) 
            {
                String cookieHeader = '';

                List<string> keyList = new List<string>(headers.keySet());
                Integer keyTot = keyList.size();
                for (Integer keyCnt = 0 ; keyCnt < keyTot ; keyCnt++) 
                {
                    string key = keyList[keyCnt];
                    if (cookieHeader.length() > 0) 
                    {
                        cookieHeader += ';';
                    }
                    cookieHeader = cookieHeader + key + '=' + headers.get(key);
                }

                if (cookieHeader.length() > 0) 
                {
                    request.setHeader('Cookie', cookieHeader); 

                    System.debug(LoggingLevel.ERROR, 'Using SAP Session: Cookie: ' + cookieHeader);
                }
            }
        }

        return request;
    }

    @testVisible
    private static void deserializeObject(ensxsdk.EnosixFramework.ValueObject valueObject, object data) 
    { 
        ensxsdk.EnosixFramework.deserializeObject(valueObject, data);
    }

    @testVisible
    static HttpResponse httpSend(HttpRequest request, Map<String,String> traceInfo) 
    {
        Long httpStart = SW();
        HttpResponse testReponse = new HttpResponse();
        if (Test.isRunningTest())
        {
            testReponse.setHeader('Set-Cookie','test=test;');
        }
        HttpResponse response = Test.isRunningTest() ? testReponse : ensxsdk.EnosixFramework.httpSend(request, traceInfo);
        Long httpEnd = SW();

        System.debug('ensxsdk.EnosixFramework.httpSend ' + (httpEnd - httpStart) + 'ms');

        if (null != response && true == UseSession) 
        {
            if (null == headers) 
            {
                headers = new Map<String,String>();
            }

            List<string> keyList = response.getHeaderKeys();
            Integer keyTot = keyList.size();
            for (Integer keyCnt = 0 ; keyCnt < keyTot ; keyCnt++) 
            {
                string key = keyList[keyCnt];
                System.debug('Server Header: ' + key);
                System.debug(response.getHeader(key));
                if ('Set-Cookie' == key) 
                {
                    List<String> values = response.getHeader(key).split(';(?!\\s)');
                    Integer valueTot = values.size();
                    for (Integer valueCnt = 0 ; valueCnt < valueTot ; valueCnt++) 
                    {
                        String value = values[valueCnt];
                        Matcher cookieMatcher = setCookiePattern.matcher(value);
                        if (cookieMatcher.matches()) 
                        {
                            String cookieName = cookieMatcher.group(1);
                            String cookieValue = cookieMatcher.group(2).substringBefore(';');
                            headers.put(cookieName, cookieValue);
                            //System.debug('Captured Cookie: "' + cookieMatcher.group(1) + '" 2-"' + cookieMatcher.group(2) + '" 3-"' + cookieMatcher.group(3) + '"');
                            System.debug('Captured Cookie: "' + cookieName + '"="' + cookieValue + '"');
                        }
                    }
                    
                }
            }
        }

        return response;
    }

    static Pattern setCookiePattern = Pattern.compile('(.*?)=((.*?)[;,]|.*$)');

    private static Map<String,String> traceInfo  { get; set; }

    private static HttpRequest startExecuteInitialize(ensxsdk.EnosixFramework.DetailSBO sbo, ensxsdk.EnosixFramework.DetailObject initialState)
    {
        System.assertNotEquals(null, sbo, 'DetailSBO sbo required');
        System.assertNotEquals(null, initialState, 'DetailObject initialState required');

        string businessObjectName = getBusinessObjectName(sbo);

        Map<String, String> attributes = new map<String, String>();

        Map<String, Object> parameters = new Map<String, Object>
        {
            'I_TYPE' => businessObjectName,
            'I_INPUT' => initialState
        };

        traceInfo = new Map<String,String>
        {
            'Operation' => 'ExecuteInitialize',
            'SBO' => businessObjectName
        };

        HttpRequest request = createRequest(new Map<String, object>
            {
                'function'=>'busobj_initialize'
            }, parameters, attributes);

        return request;
    }

    static HttpRequest startExecuteCommand(ensxsdk.EnosixFramework.DetailSBO sbo, String command, ensxsdk.EnosixFramework.DetailObject obj) 
    {
        System.assertNotEquals(null, sbo, 'DetailSBO sbo required');
        System.assert(!String.isBlank( command ), 'Expected command name.');
        System.assertNotEquals(null, obj, 'DetailObject obj required');

        String businessObjectKey = getObjectKey(obj);
        string businessObjectName = getBusinessObjectName(sbo);

        map<String, String> attributes = new map<String, String>();

        if ( isInitialKey(businessObjectKey) )
        {
            attributes.put('tablerowstate', 'inserted');  // Set all rows to insert
        }

        Map<String, Object> parameters = new Map<String, Object>
            {
                'I_KEY' => businessObjectKey,
                'I_TYPE' => businessObjectName,
                'I_NOVALIDATION' => 'X',
                'I_COMMAND' => command,
                'I_INPUT' => obj
            };

        traceInfo = new Map<String,String>
            {
                'Operation' => 'ExecuteCommand',
                'SBO' => businessObjectName,
                'Command' => command
            };

        HttpRequest request = createRequest(new Map<String, object>
            {
                'function'=>'busobj_command'
            }, parameters, attributes);

        return request;
    }

    private static ensxsdk.EnosixFramework.DetailObject processResult(ensxsdk.EnosixFramework.DetailSBO sbo, HttpResponse response)
    {
        System.assertNotEquals(null, sbo, 'DetailSBO sbo required');
        System.assertNotEquals(null, response, ' HttpResponse response required');

        Type sboType = sbo.getBusinessObjectType();
        ensxsdk.EnosixFramework.DetailObject result = (ensxsdk.EnosixFramework.DetailObject)sboType.newInstance();

        Long startTimer = SW();

        if (!Test.isRunningTest()) deserializeObject(result, response);

        Long endTimer = SW();

        System.debug('ensxsdk.EnosixFramework.deserializeObject ' + (endTimer - startTimer) + 'ms');

        return result;
    }

    public static ensxsdk.EnosixFramework.DetailObject executeInitialize(ensxsdk.EnosixFramework.DetailSBO sbo, ensxsdk.EnosixFramework.DetailObject initialState)
    {
        return processResult(sbo, httpSend(startExecuteInitialize(sbo, initialState), traceInfo));
    }

    public static ensxsdk.EnosixFramework.DetailObject executeCommand(ensxsdk.EnosixFramework.DetailSBO sbo, ensxsdk.EnosixFramework.DetailObject obj, String command)
    {
        return processResult(sbo, httpSend(startExecuteCommand(sbo, command, obj), traceInfo));
    }

    private static Long SW() { return datetime.now().getTime(); }
}