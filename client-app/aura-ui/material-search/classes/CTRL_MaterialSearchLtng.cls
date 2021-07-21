public class CTRL_MaterialSearchLtng
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(CTRL_MaterialSearchLtng.class);

    @AuraEnabled
    public static UTIL_Aura.Response loadMaterialTypes (List<String> defaultMaterialTypes)
    {
        logger.enterAura('loadMaterialTypes', new Map<String, Object> {
            'defaultMaterialTypes' => defaultMaterialTypes
        });

        if (defaultMaterialTypes == null || defaultMaterialTypes.size() == 0)
        {
            defaultMaterialTypes = (List<String>)UTIL_AppSettings.getList(UTIL_AppSettings.EnterpriseApp,
                'DefaultMaterialTypes', String.class, new String[] { 'FERT' });
        }
        Set<String> defMaterialTypesSet = new Set<String>(defaultMaterialTypes);

        List<MaterialTypeResult> responseData = new List<MaterialTypeResult>();
        List<RFC_MM_GET_PROD_HIERARCHY.ET_MATERIAL_TYPE> matList = rfcSearchOptions.ET_MATERIAL_TYPE_List;
        Integer matTot = matList.size();
        for (Integer matCnt = 0 ; matCnt < matTot ; matCnt++)
        {
            RFC_MM_GET_PROD_HIERARCHY.ET_MATERIAL_TYPE materialType = matList[matCnt];
            if (defMaterialTypesSet.contains(materialType.MTART))
            {
                responseData.add(new MaterialTypeResult(materialType.MTART, materialType.MTBEZ));
            }
        }

        return UTIL_Aura.createResponse(responseData);      
    }

    @AuraEnabled
    public static UTIL_Aura.Response loadProductHierarchies()
    {
        logger.enterAura('loadProductHierarchies', null);

        return UTIL_Aura.createResponse(rfcSearchOptions.ET_PROD_HIERARCHY_List);
    }

    public class MaterialTypeResult
    {
        @AuraEnabled
        public String value { get; set; }
        @AuraEnabled
        public String label { get; set; }

        public MaterialTypeResult (String value, String label)
        {
            this.value = value;
            this.label = label;
        }
    }

    private static RFC_MM_GET_PROD_HIERARCHY.RESULT cache_rfcSearchOptions;
    private static RFC_MM_GET_PROD_HIERARCHY.RESULT rfcSearchOptions
    {
        get
        {
            if (null == cache_rfcSearchOptions)
            {
                RFC_MM_GET_PROD_HIERARCHY rfc = new RFC_MM_GET_PROD_HIERARCHY();
                // Only get 3 levels of product hierarchy
                rfc.Params.IV_LEVEL_NUMBER = '3';
                cache_rfcSearchOptions = rfc.execute();

                if (!cache_rfcSearchOptions.isSuccess())
                {
                    UTIL_PageMessages.addFrameworkMessages(cache_rfcSearchOptions.getMessages());
                }
            }
            return cache_rfcSearchOptions;
        }
    }

    @AuraEnabled
    public static UTIL_Aura.Response searchMaterials(Map<String, Object> searchParams, Map<String, Object> pagingOptions)
    {
        logger.enterAura('searchMaterials', new Map<String, Object> {
            'searchParams' => searchParams,
            'pagingOptions' => pagingOptions
        });

        List<MaterialSearchResult> responseData = new List<MaterialSearchResult>();
        Object responsePagingOptions = null;

        try
        {
            SBO_EnosixMaterial_Search sbo = new SBO_EnosixMaterial_Search();
            SBO_EnosixMaterial_Search.EnosixMaterial_SC context = new SBO_EnosixMaterial_Search.EnosixMaterial_SC();

            String materialDescription = (String) searchParams.get('MaterialDescription');
            if (null == materialDescription) materialDescription = '';
            if (!materialDescription.startsWith('*')) materialDescription = '*' + materialDescription;
            if (!materialDescription.endsWith('*')) materialDescription += '*';

            context.SEARCHPARAMS.MaterialDescription = materialDescription;
            String materialNumber = (String) searchParams.get('MaterialNumber');
            if (String.isNotEmpty(materialNumber)) context.SEARCHPARAMS.MaterialNumberFrom = materialNumber.toUpperCase();
            context.SEARCHPARAMS.SalesOrganization = (String) searchParams.get('SalesOrganization');
            context.SEARCHPARAMS.DistributionChannel = (String) searchParams.get('DistributionChannel');
            context.SEARCHPARAMS.ProductHierarchy = (String) searchParams.get('ProductHierarchy');

            Object materialTypeValuesObject = searchParams.get('MaterialTypeValues');
            if (materialTypeValuesObject != null && materialTypeValuesObject instanceof List<Object>)
            {
                List<Object> materialTypeValues = (List<Object>) materialTypeValuesObject;
                Integer matTot = materialTypeValues.size();
                if (matTot > 0)
                {
                    for (Integer matCnt = 0 ; matCnt < matTot ; matCnt++)
                    {
                        Object materialTypeValue = MaterialTypeValues[matCnt];
                        SBO_EnosixMaterial_Search.MATERIAL_TYPE type =
                                new SBO_EnosixMaterial_Search.MATERIAL_TYPE();
                        type.MaterialType = (String) materialTypeValue;
                        context.MATERIAL_TYPE.add(type);
                    }
                }
            }

            UTIL_Aura.setSearchContextPagingOptions(context, pagingOptions);
            sbo.search(context);

            List<SBO_EnosixMaterial_Search.SEARCHRESULT> resultList = context.result.getResults();
            Integer resultTot = resultList.size();
            for (Integer resultCnt = 0 ; resultCnt < resultTot ; resultCnt++) 
            {
                SBO_EnosixMaterial_Search.SEARCHRESULT result = resultList[resultCnt];
                MaterialSearchResult material = new MaterialSearchResult();
                material.material = result.Material;
                material.materialType = result.MaterialType;
                material.materialDescription = result.MaterialDescription;
                material.productHierarchy = result.ProductHierarchy;
                material.productHierarchyDescription = result.ProductHierarchyDescription;
                material.quantity = 1;
                //material.unitOfMeasure = result.SalesUnit;
                // if (String.isEmpty(result.SalesUnit))
                // {
                //     material.unitOfMeasure = result.BaseUnitOfMeasure;
                // }
                material.unitOfMeasure = result.BaseUnitOfMeasure;
                material.scheduleDate = null;
                material.isSelected = false;
                material.isConfigurableMaterial = result.ConfigurableMaterial;
                responseData.add(material);
            }   
            responsePagingOptions = context.pagingOptions;
        }
        catch (Exception ex)
        {
            UTIL_PageMessages.addExceptionMessage(ex);
        }

        return UTIL_Aura.createResponse(responseData, responsePagingOptions);      
    }

    public class MaterialSearchResult
    {
        @AuraEnabled public String material { get; set; }
        @AuraEnabled public String materialType { get; set; }
        @AuraEnabled public String materialDescription { get; set; }
        @AuraEnabled public String productHierarchy { get; set; }
        @AuraEnabled public String productHierarchyDescription { get; set; }
        @AuraEnabled public Decimal quantity { get; set; }
        @AuraEnabled public String unitOfMeasure { get; set; }
        @AuraEnabled public Date scheduleDate { get; set; }
        @AuraEnabled public Boolean isSelected { get; set; }
        @AuraEnabled public Boolean isConfigurableMaterial { get; set; }
    }
}