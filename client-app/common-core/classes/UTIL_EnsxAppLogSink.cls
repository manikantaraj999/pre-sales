// sfdx force:data:record:create -s ensxapp__LogSetting__c -v "ensxapp__Log_Sink__c=UTIL_EnsxAppLogSink"
global with sharing class UTIL_EnsxAppLogSink implements ensxapp.Invokable {
    // void log(ensxapp__Log__c logEntry)
    public Object invoke(Object logEntry) {
        // Adding extra debug line since the first debug message is not always being displayed.
        System.debug(System.LoggingLevel.ERROR, 'UTIL_EnsxAppLogSink.invoke');
        // Logging at the highest level (ERROR) makes it less likely for the entries to be culled
        // when the log approaches the 2mb maximum size.
        System.debug(System.LoggingLevel.ERROR, logEntry);
        return null;
    }
}