@isTest
public class TSTU_AllSyncSchedule
{
    @isTest
    public static void test_insertSchedule()
    {
        List<String> syncSchedulables = new List<String> {
            'UTIL_CustomerSyncSchedule',
            'UTIL_MaterialSyncSchedule',
            'UTIL_ContactSyncSchedule',
            'UTIL_InvoiceSyncSchedule',
            'UTIL_OrderSyncSchedule',
            'UTIL_QuoteSyncSchedule'
        };

        Test.startTest();
        Integer syncTot = syncSchedulables.size();
        for (Integer syncCnt = 0 ; syncCnt < syncTot ; syncCnt++)
        {
            String schedulableName = syncSchedulables[syncCnt];
            Type schedulableType = Type.forName(schedulableName);
            if (schedulableType != null) {
                Schedulable syncInstance = (Schedulable) schedulableType.newInstance();

                Datetime dt = Datetime.now().addMinutes(1);
                String timeForScheduler = dt.format('s m H d M \'?\' yyyy ');
                String schedId = System.Schedule(
                    String.valueOf(syncInstance).split(':')[0] + 'RetryAfter' + timeForScheduler.trim(),
                    timeForScheduler,
                    syncInstance
                );
                // ID in API is 15 digits
                System.assertEquals(15, schedId.length());
            }
        }

        Test.stopTest();
    }
}
