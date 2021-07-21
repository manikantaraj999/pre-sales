@isTest
public with sharing class TSTU_ViewHelper
{
    @isTest
    public static void testdisplayResultMessages()
    {
        SBO_EnosixSalesDocument_Detail.EnosixSalesDocument result = new SBO_EnosixSalesDocument_Detail.EnosixSalesDocument();
        result.setSuccess(true);
        Test.startTest();
        List<ensxsdk.EnosixFramework.Message> mList = new List<ensxsdk.EnosixFramework.Message>();
        mList.add(new ensxsdk.EnosixFramework.Message(ensxsdk.EnosixFramework.MessageType.WARNING, 'm2'));
        UTIL_ViewHelper.displayResultMessages(mList);
        Test.stopTest();
    }

    @isTest
    public static void testdisplayMessage()
    {
        Test.startTest();
        UTIL_ViewHelper.displayMessage(ensxsdk.EnosixFramework.MessageType.Error, ensxsdk.EnosixFramework.MessageType.Error, '');
        UTIL_ViewHelper.displayMessage(ensxsdk.EnosixFramework.MessageType.SUCCESS, ensxsdk.EnosixFramework.MessageType.WARNING, '');
        UTIL_ViewHelper.displayMessage(ensxsdk.EnosixFramework.MessageType.SUCCESS, ensxsdk.EnosixFramework.MessageType.INFO, '');
        UTIL_ViewHelper.displayMessage(ensxsdk.EnosixFramework.MessageType.SUCCESS, ensxsdk.EnosixFramework.MessageType.SUCCESS, '');
        Test.stopTest();
    }
}