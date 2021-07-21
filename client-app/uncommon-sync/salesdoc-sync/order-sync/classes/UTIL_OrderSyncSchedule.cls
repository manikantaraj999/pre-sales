public with sharing class UTIL_OrderSyncSchedule implements Schedulable, I_ParameterizedSync
{
    private Object batchParam = null;

    public UTIL_OrderSyncSchedule() {
        this(null);
    }

    public UTIL_OrderSyncSchedule(Object param)
    {
        this.setBatchParam(param);
    }

    public void setBatchParam(Object value)
    {
        this.batchParam = value;
    }

    public void execute(SchedulableContext sc)
    {
        /* Enable this block of code in the Developer Console to short-circuit a
        //   runaway batch that keeps scheduling itself.
        System.debug('pretending to schedule another instance');
        return;
        //*/

        List<sObject> result = Database.query('Select id, Status, ApexClass.Name from AsyncApexJob where Status != \'Aborted\' and Status != \'Completed\' and Status != \'Failed\' and ApexClass.Name = \'UTIL_OrderSyncBatch\'');
        if (result.size() == 0)
        {
            UTIL_SyncHelper.executeBatch('UTIL_OrderSyncBatch',
                'UTIL_OrderSyncSchedule', 
                batchParam, 
                (Integer) UTIL_AppSettings.getValue(UTIL_AppSettings.OrderSyncBatch, 'SFBatchSize', 2000));
        }
    }
}
