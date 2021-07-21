// sfdx force:data:record:create -s ensxapp__LogSetting__c -v "ensxapp__Log_Sink__c=UTIL_EnsxAppHttpTrace"
global with sharing class UTIL_EnsxAppHttpTrace implements ensxapp.Invokable {
    // void log(ensxapp__Log__c logEntry)
    public Object invoke(Object logEntry) {
        // Only show HTTP Trace in the Salesforce Dev Console Log
        if (null == logEntry ||
            !(logEntry instanceof ensxapp__Log__c) ||
            'HTTP_TRACE' != ((ensxapp__Log__c)logEntry).ensxapp__LogLevel__c)
        {
            return null;
        }

        // Adding extra debug line since the first debug message is not always being displayed.
        System.debug(System.LoggingLevel.ERROR, 'UTIL_EnsxAppHttpTrace.invoke');
        // Logging at the highest level (ERROR) makes it less likely for the entries to be culled
        // when the log approaches the 2mb maximum size.
        System.debug(System.LoggingLevel.ERROR, logEntry);
        return null;
    }
}