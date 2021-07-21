public with sharing class UTIL_ContactSyncSchedule implements Schedulable, I_ParameterizedSync
{
    private Object batchParam = null;

    public UTIL_ContactSyncSchedule() {
        this(null);
    }

    public UTIL_ContactSyncSchedule(Object param)
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

        List<sObject> result = Database.query('Select id, Status, ApexClass.Name from AsyncApexJob where Status != \'Aborted\' and Status != \'Completed\' and Status != \'Failed\' and ApexClass.Name = \'UTIL_ContactSyncBatch\'');
        if (result.size() == 0)
        {
            UTIL_SyncHelper.executeBatch('UTIL_ContactSyncBatch',
                'UTIL_ContactSyncSchedule', 
                batchParam, 
                (Integer) UTIL_AppSettings.getValue(UTIL_AppSettings.ContactSyncBatch, 'SFBatchSize', 2000));
        }
    }
}
