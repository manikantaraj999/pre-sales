public class CTRL_SalesDocCreateUpdate
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_SalesDocCreateUpdate.class);

    @AuraEnabled
    public static UTIL_Aura.Response initSFObject(String recordId, String sapDocType)
    {
        logger.enterAura('initSFObject', new Map<String, Object>{
            'recordId' => recordId,
            'sapDocType' => sapDocType
        });

        UTIL_SalesDoc.SFObject result = UTIL_SalesDoc.getSFObjectInfo(recordId, sapDocType);

        return UTIL_Aura.createResponse(result);
    }

    @AuraEnabled
    public static UTIL_Aura.Response initSalesDocDetailFromSFObject(DS_Document_Detail salesDocDetail,
        UTIL_SalesDoc.SFObject sfObject, DS_SalesDocAppSettings appSettings)
    {
        logger.enterAura('initSalesDocDetailFromSFObject', new Map<String, Object>{
            'salesDocDetail' => salesDocDetail,
            'sfObject' => sfObject,
            'appSettings' => appSettings
        });

        try
        {
            DS_Document_Detail newSalesDocDetail = UTIL_SalesDoc.mapSalesDocDetailFromSFObject(salesDocDetail, sfObject, appSettings);
            if (newSalesDocDetail != null) salesDocDetail = newSalesDocDetail;
        }
        catch (Exception ex)
        {
            UTIL_PageMessages.addExceptionMessage(ex);
            return UTIL_Aura.createResponse(null);
        }

        return UTIL_Aura.createResponse(salesDocDetail);
    }

    @AuraEnabled
    public static UTIL_Aura.Response getSalesDocDetail(String salesDocNumber, DS_SalesDocAppSettings appSettings,
        UTIL_SalesDoc.SFObject sfObject)
    {
        logger.enterAura('getSalesDocDetail', new Map<String, Object>{
            'salesDocNumber' => salesDocNumber,
            'appSettings' => appSettings,
            'sfObject' => sfObject
        });

        ensxsdk.EnosixFramework.DetailSBO sbo = initializeSBODetail(appSettings.SBODetailType);
        DS_Document_Detail salesDocDetail = new DS_Document_Detail();

        try
        {
            ensxsdk.EnosixFramework.DetailObject result = sbo.executeGetDetail(salesDocNumber);
            UTIL_Document_Detail.convertToObject(result, salesDocDetail, true, appSettings);

            SObject sfSObject = sfObject.sfMainObject;

            if (sfSObject != null && sfObject.sfLineItems != null)
            {
                Integer solTot = sfObject.sfLineItems.size();
                Integer itemTot = salesDocDetail.ITEMS.size();
                for (Integer solCnt = 0 ; solCnt < solTot ; solCnt++)
                {
                    SObject sfsObjectLine = sfObject.sfLineItems[solCnt];
                    String itemNumber = UTIL_SFSObjectDoc.getItemNumber(sfSObject, sfsObjectLine);
                    boolean isFound = false;
                    string materialNumber = UTIL_SFSObjectDoc.getMaterial(sfSObject, sfsObjectLine);
                    for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
                    {
                        DS_Document_Detail.ITEMS item = salesDocDetail.ITEMS[itemCnt];
                        if (itemNumber != null && 
                            itemNumber.replaceFirst('^0+(?!$)', '') == item.ItemNumber.replaceFirst('^0+(?!$)', '') && 
                            materialNumber == item.Material)
                        {
                            item.SFId = sfsObjectLine.Id;
                            break;
                        }                    
                    }
                }
            }

            UTIL_PageMessages.addFrameworkMessages(result.getMessages());
        }
        catch (Exception ex)
        {
            UTIL_PageMessages.addExceptionMessage(ex);
            return UTIL_Aura.createResponse(null);
        }

        return UTIL_Aura.createResponse(salesDocDetail);
    }

    @AuraEnabled
    public static UTIL_Aura.Response getCustomerDetail(String customerNumber)
    {
        logger.enterAura('getCustomerDetail', new Map<String, Object>{
            'customerNumber' => customerNumber
        });

        SBO_EnosixCustomer_Detail.EnosixCustomer customerDetail = new SBO_EnosixCustomer_Detail.EnosixCustomer();
        SBO_EnosixCustomer_Detail sbo = new SBO_EnosixCustomer_Detail();

        try
        {
            customerDetail = sbo.getDetail(customerNumber);
        }
        catch (Exception ex)
        {
            UTIL_PageMessages.addExceptionMessage(ex);
            return UTIL_Aura.createResponse(null);
        }

        return UTIL_Aura.createResponse(customerDetail);
    }

    @AuraEnabled
    public static UTIL_Aura.Response getShipInfo()
    {        
        logger.enterAura('getShipInfo', null);
        
        RFC_SD_GET_SHIP_INFO.RESULT result = new RFC_SD_GET_SHIP_INFO.RESULT();
        try
        {           
            result = UTIL_ShippingInfo.getShippingMaster();
        }
        catch (Exception ex)
        {
            UTIL_PageMessages.addExceptionMessage(ex);
            return UTIL_Aura.createResponse(null);
        }

        return UTIL_Aura.createResponse(result);
    }

    @AuraEnabled
    public static UTIL_Aura.Response getPricingStat()
    {        
        logger.enterAura('getPricingStat', null);

        RFC_SD_GET_PRICING_STAT.RESULT result;
        try
        {
            RFC_SD_GET_PRICING_STAT rfc = new RFC_SD_GET_PRICING_STAT();            
            result = rfc.execute();
        }        
        catch (Exception ex)
        {
            UTIL_PageMessages.addExceptionMessage(ex);
            return UTIL_Aura.createResponse(null);
        }

        return UTIL_Aura.createResponse(result);
    }

    @AuraEnabled
    public static UTIL_Aura.Response getGroupOffice()
    {        
        logger.enterAura('getGroupOffice', null);

        RFC_SD_GET_GROUP_OFFICE.RESULT result;
        try
        {
            RFC_SD_GET_GROUP_OFFICE rfc = new RFC_SD_GET_GROUP_OFFICE();            
            result = rfc.execute();
        }        
        catch (Exception ex)
        {
            UTIL_PageMessages.addExceptionMessage(ex);
            return UTIL_Aura.createResponse(null);
        }

        return UTIL_Aura.createResponse(result);
    }

    @AuraEnabled
    public static UTIL_Aura.Response getConditionTypes(Boolean isHeader, String pricingProcedure)
    {
        logger.enterAura('getConditionTypes', new Map<String, Object>{
            'isHeader' => isHeader,
            'pricingProcedure' => pricingProcedure
        });

        RFC_SD_GET_CONDITION_TYPES.RESULT result;
        try
        {
            RFC_SD_GET_CONDITION_TYPES rfc = new RFC_SD_GET_CONDITION_TYPES();
            rfc.PARAMS.IV_HEADER = isHeader ? 'B' : 'A';
            rfc.PARAMS.IV_KALSM = pricingProcedure;            
            result = rfc.execute();
        }        
        catch (Exception ex)
        {
            UTIL_PageMessages.addExceptionMessage(ex);
            return UTIL_Aura.createResponse(null);
        }

        return UTIL_Aura.createResponse(result);
    }

    @AuraEnabled
    public static UTIL_Aura.Response getRejectionReasons()
    {
        logger.enterAura('getRejectionReasons', null);

        RFC_SD_GET_REJECTION_REASONS.RESULT result;
        try
        {
            RFC_SD_GET_REJECTION_REASONS rfc = new RFC_SD_GET_REJECTION_REASONS();            
            result = rfc.execute();
        }
        catch (Exception ex)
        {
            UTIL_PageMessages.addExceptionMessage(ex);
            return UTIL_Aura.createResponse(null);
        }

        return UTIL_Aura.createResponse(result);
    }

    @AuraEnabled
    public static UTIL_Aura.Response getBillingPlans()
    {
        logger.enterAura('getBillingPlans', null);

        RFC_SD_GET_PERIO.RESULT result;
        try
        {
            RFC_SD_GET_PERIO rfc = new RFC_SD_GET_PERIO();            
            result = rfc.execute();
        }
        catch (Exception ex)
        {
            UTIL_PageMessages.addExceptionMessage(ex);
            return UTIL_Aura.createResponse(null);
        }

        return UTIL_Aura.createResponse(result);
    }

    @AuraEnabled
    public static UTIL_Aura.Response getCountries()
    {
        logger.enterAura('getCountries', null);

        RFC_SD_GET_COUNTRIES.RESULT result;
        try
        {
            RFC_SD_GET_COUNTRIES rfc = new RFC_SD_GET_COUNTRIES();
            result = rfc.execute();
        }
        catch (Exception ex)
        {
            UTIL_PageMessages.addExceptionMessage(ex);
            return UTIL_Aura.createResponse(null);
        }

        return UTIL_Aura.createResponse(result);
    }

    @AuraEnabled
    public static UTIL_Aura.Response getItemCategories(DS_Document_Detail.SALES salesDetail, String material)
    {
        logger.enterAura('getItemCategories', null);

        RFC_SD_GET_ITEMCAT_VALUES.RESULT result;
        try
        {
            RFC_SD_GET_ITEMCAT_VALUES rfc = new RFC_SD_GET_ITEMCAT_VALUES();            
            rfc.PARAMS.IV_AUART = salesDetail.SalesDocumentType;
            rfc.PARAMS.IV_VKORG = salesDetail.SalesOrganization;
            rfc.PARAMS.IV_VTWEG = salesDetail.DistributionChannel;
            rfc.PARAMS.IV_MATNR = material;
            result = rfc.execute();
        }
        catch (Exception ex)
        {
            UTIL_PageMessages.addExceptionMessage(ex);
            return UTIL_Aura.createResponse(null);
        }

        return UTIL_Aura.createResponse(result);
    }

    @AuraEnabled
    public static UTIL_Aura.Response validateProductsInSalesforce(List<String> materials, String pricebookId)
    {
        logger.enterAura('validateProductsInSalesforce', new Map<String, Object>{
            'materials' => materials,
            'pricebookId' => pricebookId
        });

        Set<String> materialNumbers = new Set<String>(materials);

        Map<String, PricebookEntry> materialNumberPbe = new Map<String, PricebookEntry>();

        try
        {
            UTIL_SalesDoc.validateMaterials(materialNumbers, pricebookId, materialNumberPbe);
        }
        catch (UTIL_SalesDoc.MissingMaterialsException ex) 
        {
            UTIL_PageMessages.addExceptionMessage(ex);
        }
        catch (Exception ex)
        {
            UTIL_PageMessages.addExceptionMessage(ex);
        }

        return UTIL_Aura.createResponse(materialNumberPbe.keySet());
    }    

    @AuraEnabled
    public static UTIL_Aura.Response getMaterialsDetail(List<String> materials, String salesOrg, String distChannel)
    {
        logger.enterAura('getMaterialsDetail', new Map<String, Object>{
            'materials' => materials,
            'salesOrg' => salesOrg,
            'distChannel' => distChannel
        });

        Map<String, MaterialDetail> materialsDetail = new Map<String, MaterialDetail>();
        SBO_EnosixMaterial_Detail sbo = new SBO_EnosixMaterial_Detail();
        SBO_EnosixMaterial_Detail.EnosixMaterial result = new SBO_EnosixMaterial_Detail.EnosixMaterial();
        
        Integer matTot = materials.size();
        for (Integer matCnt = 0 ; matCnt < matTot ; matCnt++)
        {        
            String material = materials[matCnt];    
            try
            {                
                result = sbo.getDetail(material);

                if (result.isSuccess() != null && !result.isSuccess()) {
                    UTIL_PageMessages.addFrameworkMessages(result.getMessages());
                    continue;
                }
                MaterialDetail matDetail = new MaterialDetail(result.MaterialDescription, result.BASIC_DATA_2.ConfigurableMaterial);

                List<SBO_EnosixMaterial_Detail.PLANT_DATA> plantList = result.PLANT_DATA.getAsList();
                Integer plantTot = plantList.size();
                for (Integer plantCnt = 0 ; plantCnt < plantTot ; plantCnt++)
                {         
                    SBO_EnosixMaterial_Detail.PLANT_DATA plant = plantList[plantCnt];           
                    MaterialPlant newPlant = new MaterialPlant();
                    newPlant.Plant = plant.Plant;
                    newPlant.PlantName = plant.Name;
                    newPlant.SalesOrganization = plant.SalesOrganization;
                    newPlant.DistributionChannel = plant.DistributionChannel;
                    matDetail.Plants.add(newPlant);
                }

                materialsDetail.put(material, matDetail);
            }
            catch(Exception ex)
            {
                System.debug('Invalid Material: ' + ex);
            }
        }

        return UTIL_Aura.createResponse(materialsDetail);
    }

    // Simple object for Material Detail
    public class MaterialDetail {

        public MaterialDetail(String MaterialDescription, Boolean ConfigurableMaterial) 
        {
            this.MaterialDescription = MaterialDescription;
            this.ConfigurableMaterial = ConfigurableMaterial;
            this.Plants = new List<MaterialPlant>();
        }

        @AuraEnabled public String MaterialDescription { get; set; }
        @AuraEnabled public Boolean ConfigurableMaterial { get; set; }
        @AuraEnabled public List<MaterialPlant> Plants { get; set; }
    }

    public class MaterialPlant {
        @AuraEnabled public String Plant { get; set; }
        @AuraEnabled public String PlantName { get; set; }
        @AuraEnabled public String SalesOrganization { get; set; }
        @AuraEnabled public String DistributionChannel { get; set; }
    }

    @AuraEnabled
    public static UTIL_Aura.Response getReferenceDocument(String salesDocNumber, DS_SalesDocAppSettings appSettings)
    {
        logger.enterAura('getReferenceDocument', new Map<String, Object>{
            'salesDocNumber' => salesDocNumber,
            'appSettings' => appSettings
        });

        ensxsdk.EnosixFramework.DetailSBO sbo = initializeSBODetail(appSettings.SBODetailType);
        DS_Document_Detail salesDocDetail = new DS_Document_Detail();

        try
        {
            ensxsdk.EnosixFramework.DetailObject result = UTIL_Document_Detail.buildSBOForReference(
                salesDocNumber, appSettings.DefaultDocType, appSettings.SBODetailType);

            String referenceCommand = UTIL_Document_Detail.getReferenceDocumentCommand(appSettings.SBODetailType);

            result = sbo.executeCommand(referenceCommand, result);

            if (result.isSuccess()) {
                UTIL_Document_Detail.convertToObject(result, salesDocDetail, true, appSettings);
            }

            UTIL_PageMessages.addFrameworkMessages(result.getMessages());
        }
        catch (Exception ex)
        {
            UTIL_PageMessages.addExceptionMessage(ex);
            return UTIL_Aura.createResponse(null);
        }

        return UTIL_Aura.createResponse(salesDocDetail);
    }

    @AuraEnabled
    public static UTIL_Aura.Response simulateSalesDoc(DS_Document_Detail salesDocDetail, DS_SalesDocAppSettings appSettings)
    {
        // Log size can be too big
        logger.enterAura('simulateSalesDoc', new Map<String, Object>{
            'salesDocDetail' => salesDocDetail,
            'appSettings' => appSettings
        });

        ensxsdk.EnosixFramework.DetailSBO sbo = initializeSBODetail(appSettings.SBODetailType);

        try
        {
            Integer startCpu = Limits.getCpuTime();
            Integer startHeap = Limits.getHeapSize();
            System.debug('Start getCpuTime(): '+ startCpu);
            System.debug('Start getHeapSize(): '+ startHeap);

            if (salesDocDetail == null) salesDocDetail = new DS_Document_Detail();
            ensxsdk.EnosixFramework.DetailObject result = UTIL_Document_Detail.convertToSBO(null, salesDocDetail, false, appSettings);
            String simulateCommand = UTIL_Document_Detail.getSimulateCommand(appSettings.SBODetailType);

            DateTime startTimer = System.now();
            System.debug('Start Timer: '+ startTimer);

            result = sbo.executeCommand(simulateCommand, result);

            DateTime endTimer = System.now();
            System.debug('End Timer: '+ endTimer);
            System.debug('MilliSecond Simulate: ' + (endTimer.getTime() - startTimer.getTime()));

            if (result.isSuccess()) {
                UTIL_Document_Detail.convertToObject(result, salesDocDetail, false, appSettings);
            }

            UTIL_PageMessages.addFrameworkMessages(result.getMessages());

            Integer endCpu = Limits.getCpuTime();
            Integer endHeap = Limits.getHeapSize();
            System.debug('End getHeapSize(): '+ endHeap);
            System.debug('End getCpuTime(): '+ endCpu);
            System.debug('Heap diff: ' + (endHeap - startHeap));
            System.debug('CPU diff: ' + (endCpu - startCpu));
        }
        catch (Exception ex)
        {
            UTIL_PageMessages.addExceptionMessage(ex);
        }

        return UTIL_Aura.createResponse(salesDocDetail);
    }

    @AuraEnabled
    public static UTIL_Aura.Response saveToSObject(UTIL_SalesDoc.SFObject sfObject, DS_Document_Detail salesDocDetail, Boolean updateLineItems)
    {
        logger.enterAura('createSAPDocument', new Map<String, Object>{
            'sfObject' => sfObject,
            'salesDocDetail' => salesDocDetail,
            'updateLineItems' => updateLineItems
        });

        Boolean isSuccess = true;
        try
        {
            UTIL_SalesDoc.saveHeaderAndLineItems(sfObject, salesDocDetail, '', updateLineItems);
        }
        catch (Exception ex)
        {
            isSuccess = false;
            UTIL_PageMessages.addExceptionMessage(ex);
        }
        return UTIL_Aura.createResponse(isSuccess);
    }

    @AuraEnabled
    public static UTIL_Aura.Response createSAPDocument(UTIL_SalesDoc.SFObject sfObject,
        DS_Document_Detail salesDocDetail, DS_SalesDocAppSettings appSettings)
    {
        // Log size can be too big
        logger.enterAura('createSAPDocument', new Map<String, Object>{
            'sfObject' => sfObject,
            'salesDocDetail' => salesDocDetail,
            'appSettings' => appSettings
        });

        if (salesDocDetail == null) return UTIL_Aura.createResponse(null);

        ensxsdk.EnosixFramework.DetailSBO sbo = initializeSBODetail(appSettings.SBODetailType);

        try
        {
            Integer startCpu = Limits.getCpuTime();
            Integer startHeap = Limits.getHeapSize();
            System.debug('Start getCpuTime(): '+ startCpu);
            System.debug('Start getHeapSize(): '+ startHeap);

            ensxsdk.EnosixFramework.DetailObject result = UTIL_Document_Detail.convertToSBO(null, salesDocDetail, false, appSettings);

            DateTime startTimer = System.now();
            System.debug('Start Timer: '+ startTimer);

            result = sbo.executeSave(result);

            DateTime endTimer = System.now();
            System.debug('End Timer: '+ endTimer);
            System.debug('MilliSecond Create: ' + (endTimer.getTime() - startTimer.getTime()));

            UTIL_Document_Detail.convertToObject(result, salesDocDetail, false, appSettings);
            UTIL_PageMessages.addFrameworkMessages(result.getMessages());

            if (salesDocDetail.IsSuccess && sfObject.initFromSObject)
            {
                UTIL_SalesDoc.saveHeaderAndLineItems(sfObject, salesDocDetail, appSettings.SAPDocType, appSettings.updateLineItems);
            }

            Integer endCpu = Limits.getCpuTime();
            Integer endHeap = Limits.getHeapSize();
            System.debug('End getHeapSize(): '+ endHeap);
            System.debug('End getCpuTime(): '+ endCpu);
            System.debug('Heap diff: ' + (endHeap - startHeap));
            System.debug('CPU diff: ' + (endCpu - startCpu));
        }
        catch (Exception ex)
        {
            UTIL_PageMessages.addExceptionMessage(ex);
        }

        return UTIL_Aura.createResponse(salesDocDetail);
    }

    @AuraEnabled
    public static UTIL_Aura.Response updateSAPDocument(UTIL_SalesDoc.SFObject sfObject,
        DS_Document_Detail salesDocDetail, DS_SalesDocAppSettings appSettings)
    {
        // Log size can be too big
        logger.enterAura('updateSAPDocument', new Map<String, Object>{
            'sfObject' => sfObject,
            'salesDocDetail' => salesDocDetail,
            'appSettings' => appSettings
        });

        ensxsdk.EnosixFramework.DetailSBO sbo = initializeSBODetail(appSettings.SBODetailType);

        try
        {
            Integer startCpu = Limits.getCpuTime();
            Integer startHeap = Limits.getHeapSize();
            System.debug('Start getCpuTime(): '+ startCpu);
            System.debug('Start getHeapSize(): '+ startHeap);

            ensxsdk.EnosixFramework.DetailObject result = sbo.executeGetDetail(salesDocDetail.SalesDocument);
            result = UTIL_Document_Detail.removeAllConditions(result, appSettings.SBODetailType);
            result = UTIL_Document_Detail.convertToSBO(result, salesDocDetail, true, appSettings);

            // Need to call Simulate before update because there are new added items
            if (salesDocDetail.callSimulateBeforeUpdate == true) {
                System.debug('Calling simulate before update');
                String simulateCommand = UTIL_Document_Detail.getSimulateCommand(appSettings.SBODetailType);
                result = sbo.executeCommand(simulateCommand, result);
                result = UTIL_Document_Detail.updateTextFields(result, salesDocDetail, appSettings.SBODetailType);
            }

            DateTime startTimer = System.now();
            System.debug('Start Timer: '+ startTimer);

            result = sbo.executeSave(result);

            DateTime endTimer = System.now();
            System.debug('End Timer: '+ endTimer);
            System.debug('MilliSecond Updated: ' + (endTimer.getTime() - startTimer.getTime()));

            UTIL_Document_Detail.convertToObject(result, salesDocDetail, false, appSettings);
            UTIL_PageMessages.addFrameworkMessages(result.getMessages());

            if (salesDocDetail.IsSuccess && sfObject.initFromSObject)
            {
                UTIL_SalesDoc.saveHeaderAndLineItems(sfObject, salesDocDetail, appSettings.SAPDocType, appSettings.updateLineItems);
            }

            Integer endCpu = Limits.getCpuTime();
            Integer endHeap = Limits.getHeapSize();
            System.debug('End getHeapSize(): '+ endHeap);
            System.debug('End getCpuTime(): '+ endCpu);
            System.debug('Heap diff: ' + (endHeap - startHeap));
            System.debug('CPU diff: ' + (endCpu - startCpu));
        }
        catch (Exception ex)
        {
            UTIL_PageMessages.addExceptionMessage(ex);
        }

        return UTIL_Aura.createResponse(salesDocDetail);
    }

    private static ensxsdk.EnosixFramework.DetailSBO initializeSBODetail(String sboDetailType)
    {
        String className = 'SBO_Enosix' + sboDetailType + '_Detail';
        System.Type detailType = Type.forName(className);
        return (ensxsdk.EnosixFramework.DetailSBO) detailType.newInstance();
    }
}