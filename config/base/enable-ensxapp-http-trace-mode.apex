ensxapp__LogSetting__c logSetting = ensxapp__LogSetting__c.getInstance();
logSetting.ensxapp__Log_Sink__c = 'UTIL_EnsxAppHttpTrace';
logSetting.ensxapp__HTTP_Trace__c = true;
upsert logSetting;