public with sharing class UTIL_Date
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_Date.class);

    // formatSAPDateStringToReadableFormat()
    //
    // Convert the given SAP date in string YYYYMMdd
    // To a readable date format MM/dd/YYYY    
    public static String formatSAPDateStringToReadableFormat(String sapDate)
    {
        String returnDateString = '';
        if (!String.isEmpty(sapDate) && sapDate.length() == 8)
        {
            String month = sapDate.subString(4, 6);
            String day = sapDate.subString(6, 8);
            String year = sapDate.subString(0, 4);
            returnDateString = month + '/' + day + '/' + year;
        }
        return returnDateString;
    }

    // formatReadableDateToSAPString()
    //
    // Convert the given readable date format MM/dd/YYYY
    // To SAP date string YYYYMMdd
    public static string formatReadableDateToSAPString(string readableDate)
    {
        String returnDateString = '';

        if (!String.isEmpty(readableDate) && readableDate.length() == 10)
        {
            String month = readableDate.subString(0, 2);
            String day = readableDate.subString(3, 5);
            String year = readableDate.subString(6);
            returnDateString = year + month + day;
        }

        return returnDateString;
    }
}