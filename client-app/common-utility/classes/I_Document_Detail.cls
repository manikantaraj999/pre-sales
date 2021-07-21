public interface I_Document_Detail
{
    String getSimulateCommand();
    String getReferenceDocumentCommand();

    ensxsdk.EnosixFramework.DetailObject removeAllConditions(
        ensxsdk.EnosixFramework.DetailObject detailObj);

    ensxsdk.EnosixFramework.DetailObject updateTextFields(
        ensxsdk.EnosixFramework.DetailObject detailObj, 
        DS_Document_Detail docObj);

    ensxsdk.EnosixFramework.DetailObject buildSBOForReference(
        String salesDocNumber, String salesDocType);

    ensxsdk.EnosixFramework.DetailObject convertToSBO(
        ensxsdk.EnosixFramework.DetailObject sboObject, 
        DS_Document_Detail docObj,
        Boolean isUpdate,
        DS_SalesDocAppSettings appSettings);

    void convertToObject(
        ensxsdk.EnosixFramework.DetailObject sboObject, 
        DS_Document_Detail docObj,
        Boolean isFromGetDetail,
        DS_SalesDocAppSettings appSettings);
}