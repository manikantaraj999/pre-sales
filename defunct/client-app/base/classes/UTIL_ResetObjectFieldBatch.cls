public class UTIL_ResetObjectFieldBatch
implements Database.Batchable<SObject>, Database.Stateful
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_ResetObjectFieldBatch.class);

    // jobInfo contains debug information persisted across contexts since start(),
    //   execute(), and finish() all run in separate contexts with separate debug logs
    private List<String> jobInfo = new List<String>();

    private String query;
    private String fieldName;
    private String fieldType;
    private Object newValue;

    public UTIL_ResetObjectFieldBatch(String query, String fieldName, String fieldType, Object newValue)
    {
        this.query = query;
        this.fieldName = fieldName;
        this.fieldType = fieldType;
        this.newValue = newValue;
    }

    //start()
    //
    //Start querying the records
    public Database.QueryLocator start(Database.BatchableContext context)
    {
        System.debug(context.getJobId() + ' starts');
        System.debug('Start UTIL_ResetObjectFieldBatch for: Query=' + this.query + ' FieldName=' +
            this.fieldName + ' FieldType=' + this.fieldType + ' NewValue=' + this.newValue);
        this.jobInfo.add('Start UTIL_ResetObjectFieldBatch for: Query=' + this.query + ' FieldName=' +
            this.fieldName + ' FieldType=' + this.fieldType + ' NewValue=' + this.newValue);
        return Database.getQueryLocator(this.query);
    }

    //execute()
    //
    //Execute the cleanup process
    public void execute(Database.BatchableContext context, List<SObject> resultList)
    {
        System.debug(context.getJobId() + ' executing');
        System.debug('Execute UTIL_ResetObjectFieldBatch for: Query=' + this.query + ' FieldName=' +
            this.fieldName + ' FieldType=' + this.fieldType + ' NewValue=' + this.newValue);
        this.jobInfo.add('Execute UTIL_ResetObjectFieldBatch for: Query=' + this.query + ' FieldName=' +
            this.fieldName + ' FieldType=' + this.fieldType + ' NewValue=' + this.newValue);
        this.jobInfo.add('resultList Size: ' + resultList.size());
        UTIL_SyncHelper.printJobInfo(this.jobInfo);

        List<SObject> updateRecords = new List<SObject>();
        List<SObject> deleteRecords = new List<SObject>();

        if (this.fieldType.equalsIgnoreCase('Delete'))
        {
            deleteRecords.addAll(resultList);
        }
        else 
        {
            Integer resultTot = resultList.size();
            for (Integer resultCnt = 0 ; resultCnt < resultTot ; resultCnt++)
            {
                SObject result = resultList[resultCnt];
                if (this.fieldType.equalsIgnoreCase('String'))
                {
                    result.put(this.fieldName,(String) this.newValue);
                }
                else if (this.fieldType.equalsIgnoreCase('Boolean'))
                {
                    result.put(this.fieldName,(Boolean) this.newValue);
                }
                else if (this.fieldType.equalsIgnoreCase('Integer'))
                {
                    result.put(this.fieldName,(Integer) this.newValue);
                }
                else if (this.fieldType.equalsIgnoreCase('Decimal'))
                {
                    result.put(this.fieldName,(Decimal) this.newValue);
                }
                else if (this.fieldType.equalsIgnoreCase('Long'))
                {
                    result.put(this.fieldName,(Long) this.newValue);
                }
                else if (this.fieldType.equalsIgnoreCase('Double'))
                {
                    result.put(this.fieldName,(Double) this.newValue);
                }
                else if (this.fieldType.equalsIgnoreCase('Datetime'))
                {
                    result.put(this.fieldName,(Datetime) this.newValue);
                }
                else if (this.fieldType.equalsIgnoreCase('Date'))
                {
                    result.put(this.fieldName,(Date) this.newValue);
                }
                else if (this.fieldType.equalsIgnoreCase('Time'))
                {
                    result.put(this.fieldName,(Time) this.newValue);
                }
                else
                {
                    continue;
                }

                updateRecords.add(result);
            }
        }

        try
        {
            if (updateRecords.size() > 0)
            {
                // Set 2nd param to false to be able to partial update in the collection
                // If there's any record failed to update
                Database.SaveResult[] srList = Database.update(updateRecords, false);

                Integer srTot = srList.size();
                for (Integer srCnt = 0 ; srCnt < srTot ; srCnt++)
                {
                    Database.SaveResult sr = srList[srCnt];
                    if (sr.isSuccess())
                    {
                        System.debug('Successfully updated SObject: ' + sr.getId());
                    }
                    else
                    {
                        System.debug('The following error occurred during updating');
                        List<Database.Error> erList = sr.getErrors();
                        Integer erTot = erList.size();
                        for (Integer erCnt = 0 ; erCnt < erTot ; erCnt++)
                        {
                            Database.Error err = erList[erCnt];
                            System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        }
                    }
                }
            }
        }
        catch (DmlException ex) { throw new ResetBatchRecordException('Error updating batch records.', ex); }
        try
        {
            if (deleteRecords.size() > 0)
            {
                // Set 2nd param to false to be able to partial update in the collection
                // If there's any record failed to update
                Database.DeleteResult[] srList = Database.delete(deleteRecords, false);

                Integer srTot = srList.size();
                for (Integer srCnt = 0 ; srCnt < srTot ; srCnt++)
                {
                    Database.DeleteResult sr = srList[srCnt];
                    if (sr.isSuccess())
                    {
                        System.debug('Successfully deleted SObject: ' + sr.getId());
                    }
                    else
                    {
                        System.debug('The following error occurred during deleting');
                        List<Database.Error> erList = sr.getErrors();
                        Integer erTot = erList.size();
                        for (Integer erCnt = 0 ; erCnt < erTot ; erCnt++)
                        {
                            Database.Error err = erList[erCnt];
                            System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        }
                    }
                }
            }
        }
        catch (DmlException ex) { throw new ResetBatchRecordException('Error deleting batch records.', ex); }
    }

    //finish()
    //
    //Finish processing the cleanup
    public void finish(Database.BatchableContext context)
    {
        System.debug(context.getJobId() + ' finished');
        System.debug('Finish UTIL_ResetObjectFieldBatch for: Query=' + this.query + ' FieldName=' +
            this.fieldName + ' FieldType=' + this.fieldType + ' NewValue=' + this.newValue);
        this.jobInfo.add('Finish UTIL_ResetObjectFieldBatch for: Query=' + this.query + ' FieldName=' +
            this.fieldName + ' FieldType=' + this.fieldType + ' NewValue=' + this.newValue);
        UTIL_SyncHelper.printJobInfo(this.jobInfo);
    }

    //Custom Exception for batch updating process
    public class ResetBatchRecordException extends Exception
    {}
}