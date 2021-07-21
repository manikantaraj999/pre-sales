public class UTIL_Material
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_Material.class);
 
    // searchForMaterialsBySalesArea()
    //
    // Searches for materials by sales area information  
    // Return the result from the search    
    public static SBO_SFCIMaterial_Search.SFCIMaterial_SR searchForMaterialsBySalesArea (
        string salesOrginization, string distributionChannel)
    {
        SBO_SFCIMaterial_Search.SFCIMaterial_SC searchContext = new SBO_SFCIMaterial_Search.SFCIMaterial_SC();
        SBO_SFCIMaterial_Search sbo = new SBO_SFCIMaterial_Search();    
        searchContext.SEARCHPARAMS.SalesOrganization = salesOrginization;
        searchContext.SEARCHPARAMS.DistributionChannel = distributionChannel;
        sbo.search(searchContext);
        SBO_SFCIMaterial_Search.SFCIMaterial_SR result = searchContext.result;

        if (!result.isSuccess())
        {
            UTIL_ViewHelper.displayResultMessages(result.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
        }

        return result;
    }

    // getMaterialFromMaterialNumber()
    //
    // Returns a material detail SBO from SAP 
    public static SBO_EnosixMaterial_Detail.EnosixMaterial getMaterialFromMaterialNumber(string materialNumber)
    {
        SBO_EnosixMaterial_Detail sbo = new SBO_EnosixMaterial_Detail();
        SBO_EnosixMaterial_Detail.EnosixMaterial result = sbo.getDetail(materialNumber);

        if (!result.isSuccess())
        {
            UTIL_ViewHelper.displayResultMessages(result.getMessages(), ensxsdk.EnosixFramework.MessageType.INFO);
        }

        return result;
    }
 
    // addMaterialsFromSearchResultsToSelectOptions()
    //
    // Add the materials from the search results
    // to the list of selectoptions    
    public static void addMaterialsFromSearchResultsToSelectOptions(SBO_SFCIMaterial_Search.SFCIMaterial_SR searchResult,
        List<SelectOption> result)
    {
        if (null == searchResult || null == result) return;

        List<SBO_SFCIMaterial_Search.SEARCHRESULT> searchResults = searchResult.getResults();
        Set<string> values = new Set<string>();

        Integer srTot = searchResults.size();
        for (Integer srCnt = 0 ; srCnt < srTot ; srCnt++)
        {
            SBO_SFCIMaterial_Search.SEARCHRESULT sr = searchResults[srCnt];
            string value = sr.Material;

            if (!values.contains(value) && string.isNotBlank(value))
            {
                result.add(new SelectOption(value, sr.MaterialDescription));
                values.add(value);
            }
        }
    }

    static boolean plantMatchesSalesArea(SBO_EnosixMaterial_Detail.PLANT_DATA plant,
        string salesOrganization, string distributionChannel)
    {
        return salesOrganization == plant.SalesOrganization && distributionChannel == plant.DistributionChannel;
    }

     
    // getPlantsMatchingSalesAreaFromMaterialDetail()
    //
    // Returns a list of plant data
    // from material detail with matching sales area    
    public static List<SBO_EnosixMaterial_Detail.PLANT_DATA> getPlantsMatchingSalesAreaFromMaterialDetail (
        SBO_EnosixMaterial_Detail.EnosixMaterial material, string salesOrganization, string distributionChannel)
    {
        List<SBO_EnosixMaterial_Detail.PLANT_DATA> result = new List<SBO_EnosixMaterial_Detail.PLANT_DATA>();
        List<SBO_EnosixMaterial_Detail.PLANT_DATA> plants = new List<SBO_EnosixMaterial_Detail.PLANT_DATA>();

        if (null != material) material.PLANT_DATA.copyTo(plants);

        Integer plantTot = plants.size();
        for (Integer plantCnt = 0 ; plantCnt < plantTot ; plantCnt++)
        {
            SBO_EnosixMaterial_Detail.PLANT_DATA plant = plants[plantCnt];
            if ( plantMatchesSalesArea(plant, salesOrganization, distributionChannel) )
            {
                result.add(plant);
            }
        }

        return result;
    }

    // addPlantsToSelectOptions()
    //
    // Add the list of plants to the List of SelectOption
    public static void addPlantsToSelectOptions(List<SBO_EnosixMaterial_Detail.PLANT_DATA> plants, List<SelectOption> result)
    {
        if ( null == plants ||  null == result ) return;

        Set<string> values = new Set<string>();

        Integer plantTot = plants.size();
        for (Integer plantCnt = 0 ; plantCnt < plantTot ; plantCnt++)
        {
            SBO_EnosixMaterial_Detail.PLANT_DATA plant = plants[plantCnt];
            string value = plant.Plant;
            string description = plant.Name;
            if (!values.contains(value) && string.isNotBlank(value) && string.isNotBlank(description) )
            {
                result.add(new SelectOption(value, description));
                values.add(value);
            }
        }
    }
}