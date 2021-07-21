public class UTIL_Document_Detail
{
    // removeAllConditions
    //
    // Removing all the conditions that is in the SBO
    // Primarily use for update transaction
    public static ensxsdk.EnosixFramework.DetailObject removeAllConditions(
        ensxsdk.EnosixFramework.DetailObject sboObject, String sboDetailType)
    {
        Object detailInstance = getDetailInstace(sboDetailType);
        ensxsdk.EnosixFramework.DetailObject detailObject;

        if (detailInstance instanceof I_Document_Detail) {
            detailObject = ((I_Document_Detail) detailInstance).removeAllConditions(sboObject);
        }
        return detailObject;
    }

    // updateTextFields()
    //
    // Update the Text fields, (Header and Item)
    // Primarily use for update transaction
    public static ensxsdk.EnosixFramework.DetailObject updateTextFields(
        ensxsdk.EnosixFramework.DetailObject sboObject, DS_Document_Detail docObj, String sboDetailType)
    {
        Object detailInstance = getDetailInstace(sboDetailType);
        ensxsdk.EnosixFramework.DetailObject detailObject;

        if (detailInstance instanceof I_Document_Detail) {
            detailObject = ((I_Document_Detail) detailInstance).updateTextFields(sboObject, docObj);
        }
        return detailObject;
    }

    // buildSBOForReference()
    //
    // Returns the SBO detail object
    // Use before calling the the command to clone document
    public static ensxsdk.EnosixFramework.DetailObject buildSBOForReference(
        String salesDocNumber, String salesDocType, String sboDetailType)
    {
        Object detailInstance = getDetailInstace(sboDetailType);
        ensxsdk.EnosixFramework.DetailObject detailObject;

        if (detailInstance instanceof I_Document_Detail) {
            detailObject = ((I_Document_Detail) detailInstance).buildSBOForReference(salesDocNumber, salesDocType);
        }
        return detailObject;
    }

    // convertToSBO
    //
    // Convert DS Object to SBO Detail object
    // Use to build SBO Object for simulation and creation
    public static ensxsdk.EnosixFramework.DetailObject convertToSBO(ensxsdk.EnosixFramework.DetailObject sboObject,
        DS_Document_Detail docObj, Boolean isUpdate, DS_SalesDocAppSettings appSettings)
    {
        Object detailInstance = getDetailInstace(appSettings.SBODetailType);
        ensxsdk.EnosixFramework.DetailObject detailObject;

        if (detailInstance instanceof I_Document_Detail) {
            detailObject = ((I_Document_Detail) detailInstance).convertToSBO(sboObject, docObj, isUpdate, appSettings);
        }
        return detailObject;
    }

    // convertToObject()
    //
    // Convert SBO Detail object to DS Object
    public static void convertToObject(ensxsdk.EnosixFramework.DetailObject sboObject,
        DS_Document_Detail docObj, Boolean isFromGetDetail, DS_SalesDocAppSettings appSettings)
    {
        Object detailInstance = getDetailInstace(appSettings.SBODetailType);

        if (detailInstance instanceof I_Document_Detail) {
            ((I_Document_Detail) detailInstance).convertToObject(sboObject, docObj, isFromGetDetail, appSettings);
        }
    }

    // getSimulateCommand()
    //
    // Returns the simulate command of the Detail SBO
    public static String getSimulateCommand(String sboDetailType)
    {
        Object detailInstance = getDetailInstace(sboDetailType);
        String simulateCommand = '';

        if (detailInstance instanceof I_Document_Detail) {
            simulateCommand = ((I_Document_Detail) detailInstance).getSimulateCommand();
        }
        return simulateCommand;
    }

    // getReferenceDocumentCommand()
    //
    // Returns the reference document command of the detail SBO
    // The command is use for cloning a document
    public static String getReferenceDocumentCommand(String sboDetailType)
    {
        Object detailInstance = getDetailInstace(sboDetailType);
        String referenceDocumentCommand = '';

        if (detailInstance instanceof I_Document_Detail) {
            referenceDocumentCommand = ((I_Document_Detail) detailInstance).getReferenceDocumentCommand();
        }
        return referenceDocumentCommand;
    }

    // getDetailInstace()
    //
    // Returns the instance of the detail adapter
    private static Object getDetailInstace(String sboDetailType)
    {
        String className = 'UTIL_' + sboDetailType + '_Detail';
        System.Type detailType = Type.forName(className);
        return detailType.newInstance();
    }
    
    public static DS_Document_Detail.PARTNERS getPartnerFromDocumentDetail(List<DS_Document_Detail.PARTNERS> partnerList, string partnerFunction, boolean create)
    {
        DS_Document_Detail.PARTNERS result = null;
        if (partnerList != null)
        {
            Integer partnerTot = partnerList.size();
            for (Integer partnerCnt = 0 ; partnerCnt < partnerTot ; partnerCnt++)
            {
                DS_Document_Detail.PARTNERS partner = partnerList[partnerCnt];
                if (partnerFunction == partner.PartnerFunction)
                {
                    result = partner;
                    break;
                }
            }
        }

        if (null == result && create)
        {
            result = new DS_Document_Detail.PARTNERS();
            result.PartnerFunction = partnerFunction;
            if (partnerList != null) partnerList.add(result);
        }

        return result;
    }
}