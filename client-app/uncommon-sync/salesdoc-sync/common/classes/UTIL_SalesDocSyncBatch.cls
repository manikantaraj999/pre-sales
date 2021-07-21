public abstract class UTIL_SalesDocSyncBatch
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_SalesDocSyncBatch.class);
    public void logCallouts(String location)
    {
        if ((Boolean)UTIL_AppSettings.getValue(batchClassName.subString(5), 'Logging', false))
        {
            logger.enterVfpConstructor(location, null);
        }
    }

    // jobInfo contains debug information persisted across contexts since start(),
    // execute(), and finish() all run in separate contexts with separate debug logs
    private List<String> jobInfo = new List<String>();
    
    // In this case, we will store the largest change date/time as the param
    private UTIL_SyncHelper.LastSync fromLastSync = new UTIL_SyncHelper.LastSync();
    
    @TestVisible
    private static String SFSyncKeyField = 'Name';
    @TestVisible
    private String objectType;
    private String objectItemType;
    private String objectItemMasterField;
    private String objectItemMasterFieldReference;
    private String batchClassName;
    private String scheduleClassName;
    @TestVisible
    private String transactionGroup;

    public UTIL_SalesDocSyncBatch(String transactionGroup, String objectType, String objectItemType,
        String objectItemMasterField, String objectItemMasterFieldReference,
        String scheduleClassName, String batchClassName)
    {
        this.transactionGroup = transactionGroup;
        this.objectType = objectType;
        this.objectItemType = objectItemType;
        this.objectItemMasterField = objectItemMasterField;
        this.objectItemMasterFieldReference = objectItemMasterFieldReference;
        this.scheduleClassName = scheduleClassName;
        this.batchClassName = batchClassName;
        setDocTypes(batchClassName, 'DocTypes');
    }

    /* I_ParameterizedSync methods - setBatchParam() */
    public void setBatchParam(Object value)
    {
        this.fromLastSync = (UTIL_SyncHelper.LastSync) value;
    }

    /* end I_ParameterizedSync methods */
    private void setDocTypes(String batchClassName, String key)
    {
        this.docTypes = (List<String>)UTIL_AppSettings.getList(
                            batchClassName.subString(5), key, String.class, new List<String>{});
    }

    private List<String> docTypes { get; set; }

    // startBatch()
    //
    // Calls SBO and returns search results of update customers
    public virtual List<Object> startBatch(Database.BatchableContext context)
    {
        logCallouts(this.batchClassName + '.start');
        System.debug(context.getJobId() + ' started');

        if (String.isEmpty(this.transactionGroup))
        {
            return new List<Object>();
        }

        SBO_EnosixSalesDocSync_Search sbo = new SBO_EnosixSalesDocSync_Search();

        this.fromLastSync = UTIL_SyncHelper.getLastSyncFromTable(
            this.scheduleClassName,
            this.fromLastSync);

        this.fromLastSync.pageNumber = this.fromLastSync.pageNumber + 1;

        if (this.fromLastSync.retryCnt == -1)
        {
            UTIL_SyncHelper.resetPage(this.fromLastSync, (Integer) UTIL_AppSettings.getValue(
                this.batchClassName.subString(5), 'SAPPageSize',
                512));
        }

        SBO_EnosixSalesDocSync_Search.EnosixSalesDocSync_SC searchContext = buildSearchContext(this.fromLastSync, this.transactionGroup, this.docTypes);

        this.jobInfo.add('fromLastSync:' + this.fromLastSync.toString());
        System.debug('fromLastSync:' + this.fromLastSync.toString());

        // Execute the search
        SBO_EnosixSalesDocSync_Search.EnosixSalesDocSync_SR result;
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
        String errorMessage = UTIL_SyncHelper.buildErrorMessage(this.batchClassName, result.getMessages());

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

    private static SBO_EnosixSalesDocSync_Search.EnosixSalesDocSync_SC buildSearchContext (
        UTIL_SyncHelper.LastSync fromLastSync, 
        String transactionGroup,
        List<String> docTypes)
    {
        SBO_EnosixSalesDocSync_Search.EnosixSalesDocSync_SC searchContext = new SBO_EnosixSalesDocSync_Search.EnosixSalesDocSync_SC();

        if (fromLastSync.lastSyncDate != null)
        {
            searchContext.SEARCHPARAMS.DateFrom = fromLastSync.lastSyncDate;
        }
        else searchContext.SEARCHPARAMS.InitialLoad = true;

        searchContext.SEARCHPARAMS.TransactionGroup = transactionGroup;
        searchContext.pagingOptions.pageSize = fromLastSync.pageSize;
        searchContext.pagingOptions.pageNumber = fromLastSync.pageNumber;

        Integer dtTot = docTypes.size();
        if (dtTot > 0)
        {    
            for (Integer dtCnt = 0 ; dtCnt < dtTot ; dtCnt++)
            {
                String docType = docTypes[dtCnt];
                SBO_EnosixSalesDocSync_Search.DOC_TYPE newDocType = new SBO_EnosixSalesDocSync_Search.DOC_TYPE();
                newDocType.SalesDocumentType = docType;
                searchContext.DOC_TYPE.add(newDocType);
            }
        }

        return searchContext;
    }

    // executeBatch()
    //
    // Given the updated search results, does the work of updating the object table.
    public virtual void executeBatch(
        Database.BatchableContext context,
        List<Object> searchResults)
    {
        logCallouts(this.batchClassName + '.execute');
        System.debug(context.getJobId() + ' executing');

        if (null == searchResults || 0 == searchResults.size()) return;

        List<SObject> errors = new List<SObject>();
        Map<String, Object> searchResultMap = createObjectKeyMap(searchResults);

        // First, update matching existing objects
        List<SObject> currentObjectList = UTIL_SyncHelper.getCurrentObjects(
            this.objectType,
            SFSyncKeyField,
            searchResultMap.keySet());
        Map<String, SObject> currentObjectMap = new Map<String, SObject>();
        Integer coTot = currentObjectList.size();
        for (Integer coCnt = 0 ; coCnt < coTot ; coCnt++)
        {
            SObject currentObject = currentObjectList[coCnt];
            currentObjectMap.put((String) currentObject.get(SFSyncKeyField),currentObject);
        }

        if (String.isNotEmpty(this.objectItemType))
        {
            Set<String> objectIdSet = new Set<String>();
            List<SObject> coList = currentObjectMap.values();
            coTot = coList.size();
            for (Integer coCnt = 0 ; coCnt < coTot ; coCnt++)
            {
                SObject currentObject = coList[coCnt];
                objectIdSet.add(currentObject.Id);
            }
            List<SObject> currentObjectItemList = UTIL_SyncHelper.getCurrentObjects(
                this.objectItemType,
                this.objectItemMasterField,
                objectIdSet,
                new List<String>{this.objectItemMasterFieldReference + '.' + SFSyncKeyField});
            Integer coiTot = currentObjectItemList.size();
            if (coiTot > 0)
            {
                List<SObject> deleteObjectItemList = new List<SObject>();
                for (Integer coiCnt = 0 ; coiCnt < coiTot ; coiCnt++)
                {
                    SObject currentItemObject = currentObjectItemList[coiCnt];
                    SObject currentObject = currentItemObject.getSObject(ObjectItemMasterFieldReference);
                    String currentKey = (String) currentObject.get(SFSyncKeyField);
                    if (currentKey != null && currentKey != this.fromLastSync.currentSboKey)
                    {
                        deleteObjectItemList.add(currentItemObject);
                    }
                }
                UTIL_SyncHelper.deleteResults(this.objectItemType, errors, deleteObjectItemList, this.batchClassName, this.objectItemMasterFieldReference + '.' + SFSyncKeyField);
            }
        }

        Map<String, SObject> updateObjectMap = updateExistingObjects(
            searchResultMap,
            currentObjectMap,
            errors);

        Map<String, SObject> insertObjectMap = createNewObjects(
            searchResultMap,
            currentObjectMap,
            errors);

        Set<String> savedIdSet = new Set<String>();

        UTIL_SyncHelper.insertUpdateResults(this.objectType, 'Update', errors, savedIdSet, updateObjectMap.values(), this.batchClassName, SFSyncKeyField);
        UTIL_SyncHelper.insertUpdateResults(this.objectType, 'Insert', errors, savedIdSet, insertObjectMap.values(), this.batchClassName, SFSyncKeyField);

        if (String.isNotEmpty(this.objectItemType))
        {
            updateObjectMap.putAll(insertObjectMap);
            List<SObject> insertObjectItemList = createObjectItemsFromSearchResults(
                updateObjectMap,
                searchResults,
                errors);

            UTIL_SyncHelper.insertUpdateResults(this.objectItemType, 'Insert', errors, null, insertObjectItemList, this.batchClassName, this.objectItemMasterFieldReference + '.' + SFSyncKeyField);
        }
        UTIL_SyncHelper.insertUpdateResults('Error', 'Insert', errors, savedIdSet, errors, this.batchClassName, null);
    }

    // finishBatch()
    //
    // queues up another batch when isAnotherBatchNeeded is true
    public virtual void finishBatch(Database.BatchableContext context)
    {
        logCallouts(this.batchClassName + '.finish');
        System.debug(context.getJobId() + ' finished');
        UTIL_SyncHelper.printJobInfo(this.jobInfo);
        if (this.fromLastSync.retryCnt >= 0)
        {
            System.debug('Retry=' + this.fromLastSync.retryCnt + ' ' + System.Now());
        }

        UTIL_SyncHelper.launchAnotherBatchIfNeeded(
            this.fromLastSync.isAnotherBatchNeeded, this.scheduleClassName, this.fromLastSync);
    }

    // getSboResult()
    //
    // Get the SBO SearchResult
    private SBO_EnosixSalesDocSync_Search.SEARCHRESULT getSboResult(Object searchResult)
    {
        return (SBO_EnosixSalesDocSync_Search.SEARCHRESULT) searchResult;
    }

    // createObjectKeyMap()
    //
    // create map of objecy key / search result.
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

    private Map<String, SObject> updateExistingObjects(
        Map<String, Object> searchResultMap,
        Map<String, SObject> currentObjectMap,
        List<SObject> errors)
    {
        Map<String, SObject> updateObjectMap = new Map<String, SObject>();

        List<Object> srList = searchResultMap.values();
        Integer srTot = srList.size();
        for (Integer srCnt = 0 ; srCnt < srTot ; srCnt++)
        {
            Object searchResult = srList[srCnt];
            String currentSboKey = getSboKey(searchResult);
            if (currentObjectMap.containsKey(currentSboKey))
            {
                SObject currentObject = currentObjectMap.get(currentSboKey);

                // Updates fields and adds to objectList list for later commit
                syncObject(
                    currentObject,
                    searchResult,
                    updateObjectMap,
                    errors);
            }
        }

        System.debug('Existing Object Size: ' + updateObjectMap.size());

        return updateObjectMap;
    }

    private Map<String, SObject> createNewObjects(
        Map<String, Object> searchResultMap,
        Map<String, SObject> currentObjectMap,
        List<SObject> errors)
    {
        Map<String, SObject> insertObjectMap = new Map<String, SObject>();

        List<Object> srList = searchResultMap.values();
        Integer srTot = srList.size();
        for (Integer srCnt = 0 ; srCnt < srTot ; srCnt++)
        {
            Object searchResult = srList[srCnt];
            if (!currentObjectMap.containsKey(getSboKey(searchResult)))
            {
                syncObject(
                    null,
                    searchResult,
                    insertObjectMap,
                    errors);
            }
        }

        System.debug('New Object Size: ' + insertObjectMap.size());

        return insertObjectMap;
    }

    private void syncObject(
        SObject obj,
        Object searchResult,
        Map<String, SObject> objectMap,
        List<SObject> errors)
    {
        SBO_EnosixSalesDocSync_Search.SEARCHRESULT sboResult = getSboResult(searchResult);
        if (obj == null)
        {
            Schema.SObjectType sObjectType = Schema.getGlobalDescribe().get(this.objectType);
            obj = sObjectType.newSObject();
        }

        String key = getSboKey(searchResult);
        obj.put(SFSyncKeyField, key);      
        obj.put('FLD_SalesDocument__c', key);  
        obj.put('FLD_CustomerNumber__c', sboResult.CustomerNumber);
        obj.put('FLD_CustomerName__c', sboResult.CustomerName);
        obj.put('FLD_ShipToNumber__c', sboResult.ShipToParty);
        obj.put('FLD_ShipToName__c', sboResult.ShipToName);
        obj.put('FLD_RequestedDate__c', sboResult.RequestedDeliveryDate);
        obj.put('FLD_CreatedDate__c', sboResult.CreateDate);
        obj.put('FLD_CreatedBy__c', sboResult.CreatedBy);
        obj.put('FLD_PurchaseOrderNumber__c', sboResult.CustomerPurchaseOrderNumber);
        obj.put('FLD_PurchaseOrderDate__c', sboResult.CustomerPurchaseOrderDate);
        obj.put('FLD_NetOrderValue__c', sboResult.NetOrderValue);
        obj.put('FLD_TaxAmount__c', sboResult.TaxAmount);
        obj.put('FLD_SalesDocumentType__c', sboResult.SalesDocumentType);
        obj.put('FLD_SalesOrganization__c', sboResult.SalesOrganization);
        obj.put('FLD_DistributionChannel__c', sboResult.DistributionChannel);
        obj.put('FLD_Division__c', sboResult.Division);
        obj.put('FLD_TransactionGroup__c', sboResult.TransactionGroup);
        obj.put('FLD_DeliveryBlock__c', sboResult.DeliveryBlock);
        obj.put('FLD_BillingBlock__c', sboResult.BillingBlock);
        obj.put('FLD_TermsofPaymentKey__c', sboResult.TermsofPaymentKey);
        obj.put('FLD_Incoterms1__c', sboResult.IncotermsPart1);
        obj.put('FLD_Incoterms2__c', sboResult.IncotermsPart2);
        objectMap.put(key, obj);
    }

    private List<SObject> createObjectItemsFromSearchResults(
        Map<String, SObject> currentObjectMap,
        List<Object> searchResults,
        List<SObject> errors)
    {
        List<SObject> insertObjectItemList = new List<SObject>();

        Integer srTot = searchResults.size();
        for (Integer srCnt = 0 ; srCnt < srTot ; srCnt++)
        {
            Object searchResult = searchResults[srCnt];
            SBO_EnosixSalesDocSync_Search.SEARCHRESULT sboResult = getSboResult(searchResult);
            if (currentObjectMap.containsKey(getSboKey(sboResult)))
            {
                SObject currentObject = currentObjectMap.get(getSboKey(sboResult));

                Schema.SObjectType sObjectType = Schema.getGlobalDescribe().get(this.objectItemType);
                SObject objItem = sObjectType.newSObject();
                objItem.put(objectItemMasterField, currentObject.Id);
                // if (String.isEmpty(sboResult.ItemNumber)) continue;
                // objItem.put('Name', sboResult.ItemNumber);
                // objItem.put('FLD_ItemNumber__c', sboResult.ItemNumber);
                // objItem.put('FLD_Material__c', sboResult.Material);
                // objItem.put('FLD_Quantity__c', sboResult.QuantityRequested);
                // insertObjectItemList.add(objItem);
            }
        }

        System.debug('New Object Line Size: ' + insertObjectItemList.size());

        return insertObjectItemList;
    }

    private String getSboKey(Object searchResult)
    {
        SBO_EnosixSalesDocSync_Search.SEARCHRESULT sboResult = getSboResult(searchResult);
        return sboResult == null ? '' : sboResult.SalesDocument.replaceFirst('^0+(?!$)', '');
    }

    public static Integer getRecordCount(Boolean totalRecCount, String transactionGroup, String scheduleClassName, String batchClassName) 
    {
        new ensxsdk.Logger(null);
        UTIL_SyncHelper.LastSync fromLastSync = new UTIL_SyncHelper.LastSync();
        if (!totalRecCount)
        {
            fromLastSync = UTIL_SyncHelper.getLastSyncFromTable(scheduleClassName, fromLastSync);
        }
        fromLastSync.pageSize = 1;
        fromLastSync.pageNumber = 1;
        List<String> docTypes = (List<String>)UTIL_AppSettings.getList(batchClassName.subString(5), 'DocTypes', String.class, new List<String>{});

        SBO_EnosixSalesDocSync_Search.EnosixSalesDocSync_SC searchContext = buildSearchContext(fromLastSync, transactionGroup, docTypes);
        SBO_EnosixSalesDocSync_Search sbo = new SBO_EnosixSalesDocSync_Search();
        sbo.search(searchContext);
        System.debug(searchContext.result.isSuccess());
        System.debug(searchContext.pagingOptions.totalRecords);

        return searchContext.pagingOptions.totalRecords;
    }
}