@isTest public with sharing class TSTU_Namespace
{
    /// @description Returns the namespace prefix (e.g. ENSX_Logging__) when there is a namespace (managed package)
    /// Returns empty string when there is no namespace (unmanaged package)
    @isTest
    static void test_namespacePrefix() {
        Test.startTest();
        String testString = UTIL_Namespace.namespacePrefix;
        Test.stopTest();
    }
}