public with sharing class UTIL_MaterialSyncBatch
    implements Database.Batchable<Object>,
    Database.AllowsCallouts,
    Database.Stateful,
    I_ParameterizedSync
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_MaterialSyncBatch.class);
    public void logCallouts(String location)
    {
        if ((Boolean)UTIL_AppSettings.getValue(BatchClassName.subString(5), 'Logging', false))
        {
            logger.enterVfpConstructor(location, null);
        }
    }

    // jobInfo contains debug information persisted across contexts since start(),
    // execute(), and finish() all run in separate contexts with separate debug logs
    private List<String> jobInfo = new List<String>();
    
    // In this case, we will store the largest change date/time as the param
    private UTIL_SyncHelper.LastSync fromLastSync = new UTIL_SyncHelper.LastSync();
    private static String ObjectType = 'Product2';

    @TestVisible
    private static String SFSyncKeyField = UTIL_SFProduct.MaterialFieldName;
    @TestVisible
    private static String BatchClassName = 'UTIL_MaterialSyncBatch';
    private static String ScheduleClassName = 'UTIL_MaterialSyncSchedule';
    private static Map<String, Schema.SObjectType> globalObjects; 
    private static String cpqObject = 'sbqq__quote__c';

    /* I_ParameterizedSync methods - setBatchParam() */
    public void setBatchParam(Object value)
    {
        this.fromLastSync = (UTIL_SyncHelper.LastSync) value;
    }
    /* end I_ParameterizedSync methods */

    // Sync Filter collections
    // Get the filters from the AppSettings
    private static List<String> materialTypes 
    {
        get
        {
            return (List<String>)UTIL_AppSettings.getList(
                BatchClassName.subString(5), 'MaterialTypes', String.class, new List<String>{});
        }
    }
    private static List<String> materialGroups 
    {
        get
        {
            return (List<String>)UTIL_AppSettings.getList(
                BatchClassName.subString(5), 'MaterialGroups', String.class, new List<String>{});
        }
    }
    private static List<String> materialDivisions
    {
        get
        {
            return (List<String>)UTIL_AppSettings.getList(
                BatchClassName.subString(5), 'Divisions', String.class, new List<String>{});
        }
    }
    // End Sync filter collections

    /* Database.Batchable methods start(), execute(), and finish() */
    // start()
    //
    // Calls SBO and returns search results of update materials
    public List<Object> start(Database.BatchableContext context)
    {
        logCallouts(BatchClassName + '.start');
        System.debug(context.getJobId() + ' started');

        SBO_EnosixMatSync_Search sbo = new SBO_EnosixMatSync_Search();

        this.fromLastSync = UTIL_SyncHelper.getLastSyncFromTable(
            ScheduleClassName,
            this.fromLastSync);

        this.fromLastSync.pageNumber = this.fromLastSync.pageNumber + 1;

        if (this.fromLastSync.retryCnt == -1)
        {
            UTIL_SyncHelper.resetPage(this.fromLastSync, (Integer) UTIL_AppSettings.getValue(
                BatchClassName.subString(5), 'SAPPageSize', 
                9999));
        }

        SBO_EnosixMatSync_Search.EnosixMatSync_SC searchContext = buildSearchContext(this.fromLastSync);

        this.jobInfo.add('fromLastSync:' + this.fromLastSync.toString());
        System.debug('fromLastSync:' + this.fromLastSync.toString());

        // Execute the search
        SBO_EnosixMatSync_Search.EnosixMatSync_SR result;
        try
        {
            sbo.search(searchContext);
            result = searchContext.result;
        }
        catch (Exception ex)
        {
            return UTIL_SyncHelper.checkRetry(this.fromLastSync, ex, this.jobInfo);
        }

        // Write any response messages to the debug log
        String errorMessage = UTIL_SyncHelper.buildErrorMessage(BatchClassName, result.getMessages());

        if (!result.isSuccess())
        {
            return UTIL_SyncHelper.checkRetry(this.fromLastSync, new UTIL_SyncHelper.SyncException(errorMessage), this.jobInfo);
        }

        List<Object> searchResults = result.getResults();
        System.debug('Result size: ' + searchResults.size());

        // let finish() know to queue up another instance
        this.fromLastSync.isAnotherBatchNeeded = searchResults.size() > 0;
        this.fromLastSync.retryCnt = -1;

        this.jobInfo.add('searchResultsSize:' + searchResults.size());
        this.jobInfo.add('fromLastSync:' + this.fromLastSync.toString());

        return searchResults;
    }

    private static SBO_EnosixMatSync_Search.EnosixMatSync_SC buildSearchContext (UTIL_SyncHelper.LastSync fromLastSync)
    {
        SBO_EnosixMatSync_Search.EnosixMatSync_SC searchContext = new SBO_EnosixMatSync_Search.EnosixMatSync_SC();
        if (fromLastSync.lastSyncDate != null)
        {
            searchContext.SEARCHPARAMS.DateFrom = fromLastSync.lastSyncDate;
        }

        searchContext.pagingOptions.pageSize = fromLastSync.pageSize;
        searchContext.pagingOptions.pageNumber = fromLastSync.pageNumber;

        Integer mtTot = materialTypes.size();
        if (mtTot > 0)
        {    
            for (Integer mtCnt = 0 ; mtCnt < mtTot ; mtCnt++)
            {
                String matType = materialTypes[mtCnt];
                SBO_EnosixMatSync_Search.MATERIAL_TYPE newMatType = new SBO_EnosixMatSync_Search.MATERIAL_TYPE();
                newMatType.MaterialType = matType;
                searchContext.MATERIAL_TYPE.add(newMatType);
            }
        }

        Integer mgTot = materialGroups.size();
        if (mgTot > 0)
        {    
            for (Integer mgCnt = 0 ; mgCnt < mgTot ; mgCnt++)
            {
                String matGroup = materialGroups[mgCnt];
                SBO_EnosixMatSync_Search.MATERIAL_GROUP newMatGroup = new SBO_EnosixMatSync_Search.MATERIAL_GROUP();
                newMatGroup.MaterialGroup = matGroup;
                searchContext.MATERIAL_GROUP.add(newMatGroup);
            }
        }

        Integer mdTot = materialDivisions.size();
        if (mdTot > 0)
        {    
            for (Integer mdCnt = 0 ; mdCnt < mdTot ; mdCnt++)
            {
                String division = materialDivisions[mdCnt];
                SBO_EnosixMatSync_Search.DIVISION newDivision = new SBO_EnosixMatSync_Search.DIVISION();
                newDivision.Division = division;
                searchContext.DIVISION.add(newDivision);
            }
        }

        return searchContext;
    }

    // execute()
    //
    // Given the updated search results, does the work of updating the object table.
    public void execute(
        Database.BatchableContext context,
        List<Object> searchResults)
    {
        logCallouts(BatchClassName + '.execute');
        System.debug(context.getJobId() + ' executing');

        if (null == searchResults || 0 == searchResults.size()) return;
        if (null == globalObjects) globalObjects = Schema.getGlobalDescribe();
        Schema.SObjectType cpqObjectType = globalObjects.get(cpqObject);

        List<SObject> errors = new List<SObject>();
        Set<String> configurableProductIds = new Set<String>();
        Map<String, Object> searchResultMap = createObjectKeyMap(searchResults);

        // First, update matching existing objects
        List<SObject> currentObjectList = UTIL_SyncHelper.getCurrentObjects(ObjectType, SFSyncKeyField, searchResultMap.keySet());
        List<SObject> updateObjectList = updateExistingObjects(searchResultMap, currentObjectList, errors, configurableProductIds);
        List<SObject> insertObjectList = createNewObjects(searchResultMap, currentObjectList, errors, configurableProductIds);
        Set<String> savedIdSet = new Set<String>();

        UTIL_SyncHelper.insertUpdateResults(ObjectType, 'Update', errors, savedIdSet, updateObjectList, BatchClassName, SFSyncKeyField);
        UTIL_SyncHelper.insertUpdateResults(ObjectType, 'Insert', errors, savedIdSet, insertObjectList, BatchClassName, SFSyncKeyField);

        if (null != cpqObjectType)
        {
            Integer iolTot = insertObjectList.size();
            for (Integer iolCnt = 0 ; iolCnt < iolTot ; iolCnt++)
            {
                // Add the new Product Ids for Configurable Materials to the Set
                Product2 prod = (Product2) insertObjectList[iolCnt];
                if ((Boolean) prod.get('SBQQ__ExternallyConfigurable__c')) configurableProductIds.add(prod.Id);
            }
        }

        List<String> savedIdList = new List<String>(savedIdSet);
        Integer savedIdTot = savedIdList.size();
        if (savedIdTot > 0)
        {
            Id pricebookId = UTIL_Pricebook.getStandardPriceBookId();
            List<PricebookEntry> pbEntryList = Database.Query(
                'SELECT Product2Id, Id, Name, UnitPrice, IsActive, Pricebook2Id FROM PricebookEntry ' +
                'WHERE Pricebook2Id =: pricebookId AND Product2Id IN :savedIdSet');
            Map<String,PricebookEntry> savedPbeMap = new Map<String,PricebookEntry>();
            Integer pbeTot = pbEntryList.size();
            for (Integer pbeCnt = 0 ; pbeCnt < pbeTot ; pbeCnt++) savedPbeMap.put(pbEntryList[pbeCnt].Product2Id, pbEntryList[pbeCnt]);
            List<PricebookEntry> insertPBEList = new List<PricebookEntry>();
            List<PricebookEntry> updatePBEList = new List<PricebookEntry>();
            for (Integer savedIdCnt = 0 ; savedIdCnt < savedIdTot ; savedIdCnt++)
            {
                String savedId = savedIdList[savedIdCnt];
                PricebookEntry pbe = savedPbeMap.containsKey(savedId) ? savedPbeMap.get(savedId) : null;
                if(pbe == null || !pbe.isActive)
                {
                    if (pbe == null) pbe = new PricebookEntry();
                    pbe.isActive = true;
                    pbe.UnitPrice = 0;
                    pbe.UseStandardPrice = false;
                    if (pbe.Id == null)
                    {
                        pbe.Pricebook2Id = pricebookId;
                        if (!Test.isRunningTest()) pbe.Product2Id = savedId;
                        insertPBEList.add(pbe);
                    }
                    else
                    {
                        updatePBEList.add(pbe);
                    }
                }
            }
            UTIL_SyncHelper.insertUpdateResults('PriceBookEntry', 'Insert', errors, savedIdSet, insertPBEList, BatchClassName, null);
            UTIL_SyncHelper.insertUpdateResults('PriceBookEntry', 'Update', errors, savedIdSet, updatePBEList, BatchClassName, null);
        }

        List<String> configList = new List<String>(configurableProductIds);
        Integer configTot = configList.size();
        if (null != cpqObjectType && configTot > 0)
        {
            // Insert a Product feature for Products that are configurable
            // Insert only if there are no product features for the configurable material
            List<SObject> currentProductFeatures = Database.query(
                'SELECT Id, SBQQ__ConfiguredSKU__c FROM SBQQ__ProductFeature__c WHERE SBQQ__ConfiguredSKU__c IN :configurableProductIds');

            Set<String> currentProductFeaturesProductId = new Set<String>();
            Integer currTot = currentProductFeatures.size();
            for (Integer currCnt = 0 ; currCnt < currTot ; currCnt++)
            {
                currentProductFeaturesProductId.add((String) currentProductFeatures[currCnt].get('SBQQ__ConfiguredSKU__c'));
            }

            List<SObject> newProductFeatures = new List<SObject>();
            for (Integer configCnt = 0 ; configCnt < configTot ; configCnt++)
            {
                String productId = configList[configCnt];
                if (!currentProductFeaturesProductId.contains(productId)) 
                {
                    SObject newProductFeature = globalObjects.get('sbqq__productfeature__c').newSObject();
                    newProductFeature.put('Name', 'SAP BoM');
                    newProductFeature.put('SBQQ__Number__c', 1);
                    newProductFeature.put('SBQQ__MinOptionCount__c', 0);
                    newProductFeature.put('SBQQ__OptionSelectionMethod__c', 'Dynamic');
                    newProductFeature.put('SBQQ__ConfiguredSKU__c', productId);
                    newProductFeatures.add(newProductFeature);
                }
            }
            
            UTIL_SyncHelper.insertUpdateResults('SBQQ__ProductFeature__c', 'Insert', errors, savedIdSet, newProductFeatures, BatchClassName, null);            
        }

        UTIL_SyncHelper.insertUpdateResults('Error', 'Insert', errors, savedIdSet, errors, BatchClassName, null);
    }

    // finish()
    //
    // queues up another batch when isAnotherBatchNeeded is true
    public void finish(Database.BatchableContext context)
    {
        logCallouts(BatchClassName + '.finish');
        System.debug(context.getJobId() + ' finished');
        UTIL_SyncHelper.printJobInfo(this.jobInfo);
        if (this.fromLastSync.retryCnt >= 0)
        {
            System.debug('Retry=' + this.fromLastSync.retryCnt + ' ' + System.Now());
        }

        UTIL_SyncHelper.launchAnotherBatchIfNeeded(
            this.fromLastSync.isAnotherBatchNeeded, ScheduleClassName, this.fromLastSync);
    }

    private SBO_EnosixMatSync_Search.SEARCHRESULT getSboResult(Object searchResult)
    {
        return (SBO_EnosixMatSync_Search.SEARCHRESULT) searchResult;
    }

    // createObjectKeyMap()
    //
    // create map of product key / search result.
    private Map<String, Object> createObjectKeyMap(
        List<Object> searchResults)
    {
        Map<String, Object> result =
            new Map<String, Object>();

        Integer srTot = searchResults.size();
        for (Integer srCnt = 0 ; srCnt < srTot ; srCnt++)
        {
            Object searchResult = searchResults[srCnt];
            String key = getSboKey(searchResult);
            if (String.isNotEmpty(key))
            {
                result.put(key, searchResult);
            }            
        }

        return result;
    }

    private List<SObject> updateExistingObjects(
        Map<String, Object> searchResultMap,
        List<SObject> currentObjectList,
        List<SObject> errors,
        Set<String> configurableProductIds)
    {
        List<SObject> updateObjectList = new List<SObject>();

        Integer coTot = currentObjectList.size();
        for (Integer coCnt = 0 ; coCnt < coTot ; coCnt++)
        {
            SObject currentObject = currentObjectList[coCnt];
            String syncKey = (String) currentObject.get(SFSyncKeyField);
            Object searchResult = searchResultMap.get(syncKey);

            // Updates fields and adds to objectList list for later commit
            syncObject(currentObject, searchResult, errors, updateObjectList, configurableProductIds);
        }

        System.debug('Existing Object Size: ' + updateObjectList.size());

        return updateObjectList;
    }

    private List<SObject> createNewObjects(
        Map<String, Object> searchResultMap,
        List<SObject> currentObjectList,
        List<SObject> errors,
        Set<String> configurableProductIds)
    {
        Set<String> existingObjectSyncKeys = new Set<String>();

        Integer coTot = currentObjectList.size();
        for (Integer coCnt = 0 ; coCnt < coTot ; coCnt++)
        {
            SObject currentObject = currentObjectList[coCnt];
            String syncKey = (String) currentObject.get(SFSyncKeyField);
            existingObjectSyncKeys.add(syncKey);
        }

        List<SObject> newObjectList = new List<SObject>();

        List<Object> srList = searchResultMap.values();
        Integer srTot = srList.size();
        for (Integer srCnt = 0 ; srCnt < srTot ; srCnt++)
        {
            Object searchResult = srList[srCnt];
            if (!existingObjectSyncKeys.contains(getSboKey(searchResult)))
            {
                syncObject(null, searchResult, errors, newObjectList, configurableProductIds);
            }
        }

        System.debug('New Object Size: ' + newObjectList.size());

        return newObjectList;
    }

    private void syncObject(
        SObject currentObject,
        Object searchResult,
        List<SObject> errors,
        List<SObject> objectList,
        Set<String> configurableProductIds)
    {
        SBO_EnosixMatSync_Search.SEARCHRESULT sboResult = getSboResult(searchResult);
        if (currentObject == null)
        {
            if (sboResult.DeleteIndicator == 'X')
            {
                return;
            }
            currentObject = new Product2();
        }
        Product2 prod = (Product2) currentObject;
        String key = getSboKey(searchResult);
        prod.put(SFSyncKeyField,key);
        prod.isActive = sboResult.DeleteIndicator != 'X';
        prod.Name = sboResult.MaterialDescription;
        if (String.isEmpty(prod.Name)) prod.Name = key;
        prod.FLD_Configurable_Material__c = sboResult.ConfigurableMaterial == 'X';

        // This is for CPQ
        if (null != globalObjects.get(cpqObject))
        {
            prod.put('SBQQ__ExternallyConfigurable__c', prod.FLD_Configurable_Material__c);
            if (prod.FLD_Configurable_Material__c && prod.Id != null) configurableProductIds.add(prod.Id);
            prod.put('SBQQ__ConfigurationType__c', prod.FLD_Configurable_Material__c ? 'Required' : '');
            prod.put('SBQQ__ConfigurationEvent__c', prod.FLD_Configurable_Material__c ? 'Always' : '');
        }
        
        prod.FLD_Material_Type__c = sboResult.MaterialType;
        prod.FLD_Material_Type_Description__c = sboResult.MaterialTypeDescription;
        prod.FLD_Division__c = sboResult.Division;
        prod.FLD_Division_Description__c = sboResult.DivisionDescription;
        prod.FLD_Material_Group__c = sboResult.MaterialGroup;
        prod.FLD_Material_Group_Description__c = sboResult.MaterialGroupDescription;
        prod.QuantityUnitOfMeasure = sboResult.BaseUnitOfMeasure;
        prod.FLD_Sales_Unit__c = sboResult.SalesUnit;
        prod.FLD_Sales_Organization__c = sboResult.SalesOrganization;
        prod.FLD_Distribution_Channel__c = sboResult.DistributionChannel;
        prod.FLD_Dist_Chain_Status__c = sboResult.DistChainStatus;
        prod.FLD_Dist_Chain_Status_Date__c = sboResult.DistChainStatusDate;
        prod.FLD_Weight_Unit__c = sboResult.WeightUnit;
        objectList.add(prod);
    }

    private String getSboKey(Object searchResult)
    {
        SBO_EnosixMatSync_Search.SEARCHRESULT sboResult = getSboResult(searchResult);
        return sboResult == null ? '' : sboResult.Material;
    }

    public static Integer getTotalRecordCount () 
    {
        return getRecordCount(true);
    }

    public static Integer getNextIncrementalRecordCount () 
    {
        return getRecordCount(false);
    }

    private static Integer getRecordCount(Boolean totalRecCount) 
    {
        new ensxsdk.Logger(null);
        UTIL_SyncHelper.LastSync fromLastSync = new UTIL_SyncHelper.LastSync();
        if (!totalRecCount)
        {
            fromLastSync = UTIL_SyncHelper.getLastSyncFromTable(ScheduleClassName, fromLastSync);
        }
        fromLastSync.pageSize = 1;
        fromLastSync.pageNumber = 1;

        SBO_EnosixMatSync_Search.EnosixMatSync_SC searchContext = buildSearchContext(fromLastSync);
        SBO_EnosixMatSync_Search sbo = new SBO_EnosixMatSync_Search();
        sbo.search(searchContext);
        System.debug(searchContext.result.isSuccess());
        System.debug(searchContext.pagingOptions.totalRecords);

        return searchContext.pagingOptions.totalRecords;
    }
}