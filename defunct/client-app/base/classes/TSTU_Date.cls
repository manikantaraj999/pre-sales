@isTest
public with sharing class TSTU_Date
{
    @isTest
    static void test_formatSAPDateStringToReadableFormat()
    {
        Test.startTest();
        String formattedSAPDateString = '20991231';
        System.assert(UTIL_Date.formatSAPDateStringToReadableFormat(formattedSAPDateString) == '12/31/2099');
        System.assert(UTIL_Date.formatSAPDateStringToReadableFormat('') == '');
        //too many digits, the format wont be able to parse this, should be blank string
        System.assert(UTIL_Date.formatSAPDateStringToReadableFormat('209912121') == '');
        Test.stopTest();
    }

    @isTest
    static void test_formatReadableDateToSAPString()
    {
        Test.startTest();
        String formattedSAPDateString = '20991231';
        UTIL_Date.formatReadableDateToSAPString('12/31/2099');
        UTIL_Date.formatReadableDateToSAPString('Bad Date');
        Test.stopTest();
    }
}
