public with sharing class CTRL_MaterialPlantPicker {
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_MaterialPlantPicker.class);

    @AuraEnabled
    public static UTIL_Aura.Response getMaterial(String materialNumber) {
        SBO_EnosixMaterial_Detail.EnosixMaterial material = null;
        logger.enterAura('getMaterial', new Map<String, Object> {
            'materialNumber' => materialNumber
        });
        try {
            material = new SBO_EnosixMaterial_Detail().getDetail(materialNumber);
            UTIL_PageMessages.addFrameworkMessages(material.getMessages());
        } catch (Exception ex) {
            UTIL_PageMessages.addExceptionMessage(ex);
        } finally {
            logger.exit();
        }
        return UTIL_Aura.createResponse(material);
    }
}