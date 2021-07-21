public with sharing class UTIL_OrderSyncBatch
    extends UTIL_SalesDocSyncBatch
    implements Database.Batchable<Object>,
    Database.AllowsCallouts,
    Database.Stateful,
    I_ParameterizedSync
{
    private Static String transactionGroup = '0';
    private Static String batchClassName = 'UTIL_OrderSyncBatch';
    private Static String scheduleClassName = 'UTIL_OrderSyncSchedule';

    public UTIL_OrderSyncBatch()
    {
        super(transactionGroup, 'OBJ_Order__c', 'OBJ_Order_Item__c', 'FLD_OBJ_Order__c', 'FLD_OBJ_Order__r', scheduleClassName, batchClassName);
    }

    /* Database.Batchable methods start(), execute(), and finish() */
    // start()
    public List<Object> start(Database.BatchableContext context)
    {
        return super.startBatch(context);
    }

    // execute()
    public void execute(
        Database.BatchableContext context,
        List<Object> searchResults)
    {
        super.executeBatch(context, searchResults);
    }

    // finish()
    public void finish(Database.BatchableContext context)
    {
        super.finishBatch(context);
    }

    public static Integer getTotalRecordCount () 
    {
        return UTIL_SalesDocSyncBatch.getRecordCount(true, transactionGroup, scheduleClassName, batchClassName);
    }

    public static Integer getNextIncrementalRecordCount () 
    {
        return UTIL_SalesDocSyncBatch.getRecordCount(false, transactionGroup, scheduleClassName, batchClassName);
    }
}