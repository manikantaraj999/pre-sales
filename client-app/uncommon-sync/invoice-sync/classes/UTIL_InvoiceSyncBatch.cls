public with sharing class UTIL_InvoiceSyncBatch
    implements Database.Batchable<Object>,
    Database.AllowsCallouts,
    Database.Stateful,
    I_ParameterizedSync
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_InvoiceSyncBatch.class);
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
    private static String ObjectType = 'OBJ_Invoice__c';
    private static String ObjectItemType = 'OBJ_Invoice_Item__c';
    private static String ObjectItemMasterField = 'FLD_OBJ_Invoice__c';
    private static String ObjectItemMasterFieldReference = 'FLD_OBJ_Invoice__r';

    @TestVisible
    private static String SFSyncKeyField = 'Name';
    @TestVisible
    private static String BatchClassName = 'UTIL_InvoiceSyncBatch';
    private static String ScheduleClassName = 'UTIL_InvoiceSyncSchedule';

    /* I_ParameterizedSync methods - setBatchParam() */
    public void setBatchParam(Object value)
    {
        this.fromLastSync = (UTIL_SyncHelper.LastSync) value;
    }
    /* end I_ParameterizedSync methods */

    /* Database.Batchable methods start(), execute(), and finish() */
    // start()
    //
    // Calls SBO and returns search results of update customers
    public List<Object> start(Database.BatchableContext context)
    {
        logCallouts(BatchClassName + '.start');
        System.debug(context.getJobId() + ' started');

        SBO_EnosixInvoiceSync_Search sbo = new SBO_EnosixInvoiceSync_Search();

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

        SBO_EnosixInvoiceSync_Search.EnosixInvoiceSync_SC searchContext = buildSearchContext(this.fromLastSync);

        this.jobInfo.add('fromLastSync:' + this.fromLastSync.toString());
        System.debug('fromLastSync:' + this.fromLastSync.toString());

        // Execute the search
        SBO_EnosixInvoiceSync_Search.EnosixInvoiceSync_SR result;
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

    private static SBO_EnosixInvoiceSync_Search.EnosixInvoiceSync_SC buildSearchContext (UTIL_SyncHelper.LastSync fromLastSync)
    {
        SBO_EnosixInvoiceSync_Search.EnosixInvoiceSync_SC searchContext = new SBO_EnosixInvoiceSync_Search.EnosixInvoiceSync_SC();

        if (fromLastSync.lastSyncDate != null)
        {
            searchContext.SEARCHPARAMS.DateFrom = fromLastSync.lastSyncDate;
        }
        else searchContext.SEARCHPARAMS.X_INITIALLOAD = true;

        searchContext.pagingOptions.pageSize = fromLastSync.pageSize;
        searchContext.pagingOptions.pageNumber = fromLastSync.pageNumber;

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

        List<SObject> errors = new List<SObject>();
        Map<String, Object> searchResultMap = createObjectKeyMap(searchResults);

        // First, update matching existing objects
        List<SObject> currentObjectList = UTIL_SyncHelper.getCurrentObjects(
            ObjectType,
            SFSyncKeyField,
            searchResultMap.keySet());
        Map<String, SObject> currentObjectMap = new Map<String, SObject>();
        Integer coTot = currentObjectList.size();
        for (Integer coCnt = 0 ; coCnt < coTot ; coCnt++)
        {
            SObject currentObject = currentObjectList[coCnt];
            currentObjectMap.put((String) currentObject.get(SFSyncKeyField),currentObject);
        }

        if (String.isNotEmpty(ObjectItemType))
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
                ObjectItemType,
                ObjectItemMasterField,
                objectIdSet,
                new List<String>{ObjectItemMasterFieldReference + '.' + SFSyncKeyField});
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
                UTIL_SyncHelper.deleteResults(ObjectItemType, errors, deleteObjectItemList, BatchClassName, ObjectItemMasterFieldReference + '.' + SFSyncKeyField);
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

        UTIL_SyncHelper.insertUpdateResults(ObjectType, 'Update', errors, savedIdSet, updateObjectMap.values(), BatchClassName, SFSyncKeyField);
        UTIL_SyncHelper.insertUpdateResults(ObjectType, 'Insert', errors, savedIdSet, insertObjectMap.values(), BatchClassName, SFSyncKeyField);

        if (String.isNotEmpty(ObjectItemType))
        {
            updateObjectMap.putAll(insertObjectMap);
            List<SObject> insertObjectItemList = createObjectItemsFromSearchResults(
                updateObjectMap,
                searchResults,
                errors);

            UTIL_SyncHelper.insertUpdateResults(ObjectItemType, 'Insert', errors, null, insertObjectItemList, BatchClassName, ObjectItemMasterFieldReference + '.' + SFSyncKeyField);
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

    // getSboResult()
    //
    // Get the SBO SearchResult
    private SBO_EnosixInvoiceSync_Search.SEARCHRESULT getSboResult(Object searchResult)
    {
        return (SBO_EnosixInvoiceSync_Search.SEARCHRESULT) searchResult;
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
        SObject currentObject,
        Object searchResult,
        Map<String, SObject> objectMap,
        List<SObject> errors)
    {
        SBO_EnosixInvoiceSync_Search.SEARCHRESULT sboResult = getSboResult(searchResult);
        if (currentObject == null)
        {
            currentObject = new OBJ_Invoice__c();
        }
        OBJ_Invoice__c obj = (OBJ_Invoice__c) currentObject;
        String key = getSboKey(searchResult);
        obj.put(SFSyncKeyField, key);        
        obj.FLD_BillingDocument__c = key;
        obj.FLD_BillingType__c = sboResult.BillingType;
        obj.FLD_BillingCategory__c = sboResult.BillingCategory;
        obj.FLD_CompanyCode__c = sboResult.CompanyCode;
        obj.FLD_SalesOrganization__c = sboResult.SalesOrganization;
        obj.FLD_DistributionChannel__c = sboResult.DistributionChannel;
        obj.FLD_Division__c = sboResult.Division;
        obj.FLD_AccountingDocumentNumber__c = sboResult.AccountingDocumentNumber;
        obj.FLD_BillingDate__c = sboResult.BillingDate;
        obj.FLD_Payer__c = sboResult.Payer;
        obj.FLD_PayerName__c = sboResult.PayerName;
        obj.FLD_SoldToParty__c = sboResult.SoldToParty;
        obj.FLD_SoldToName__c = sboResult.SoldToName;
        obj.FLD_NetOrderValue__c = sboResult.NetOrderValue;
        obj.FLD_TaxAmount__c = sboResult.TaxAmount;
        obj.FLD_SalesDocumentCurrency__c = sboResult.SalesDocumentCurrency;
        obj.FLD_CreatedBy__c = sboResult.CreatedBy;
        obj.FLD_CreateDate__c = sboResult.CreateDate;
        obj.FLD_BillingStatus__c = sboResult.BillingStatus;
        obj.FLD_ReferenceDocumentNumber__c = sboResult.ReferenceDocumentNumber;
        obj.FLD_ShippingConditions__c = sboResult.ShippingConditions;
        obj.FLD_Country__c = sboResult.Country;
        obj.FLD_Region__c = sboResult.Region;
        obj.FLD_FiscalYear__c = sboResult.FiscalYear;
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
            SBO_EnosixInvoiceSync_Search.SEARCHRESULT sboResult = getSboResult(searchResult);
            if (currentObjectMap.containsKey(getSboKey(sboResult)))
            {
                SObject currentObject = currentObjectMap.get(getSboKey(sboResult));

                Schema.SObjectType sObjectType = Schema.getGlobalDescribe().get(ObjectItemType);
                SObject objItem = sObjectType.newSObject();
                objItem.put(ObjectItemMasterField, currentObject.Id);
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
        SBO_EnosixInvoiceSync_Search.SEARCHRESULT sboResult = getSboResult(searchResult);
        return sboResult == null ? '' : sboResult.BillingDocument;
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

        SBO_EnosixInvoiceSync_Search.EnosixInvoiceSync_SC searchContext = buildSearchContext(fromLastSync);
        SBO_EnosixInvoiceSync_Search sbo = new SBO_EnosixInvoiceSync_Search();
        sbo.search(searchContext);
        System.debug(searchContext.result.isSuccess());
        System.debug(searchContext.pagingOptions.totalRecords);

        return searchContext.pagingOptions.totalRecords;
    }
}