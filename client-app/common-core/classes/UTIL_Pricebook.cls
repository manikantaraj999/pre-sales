//THIS UTIL CLASS IS A CLONE FROM PDE WITH AN ADDED METHOD

public class UTIL_Pricebook
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_Pricebook.class);

	// getStandardPricebookId()
	// 
	// Return the Id of the standard pricebook
    static Id standardPriceBookId = null;
	public static Id getStandardPriceBookId()
	{
        if (standardPriceBookId == null)
        {
            try
            {
                standardPriceBookId = Test.isRunningTest() ? Test.getStandardPriceBookId() : [SELECT Id FROM Pricebook2 WHERE IsStandard = true LIMIT 1].Id;
            }
            catch (Exception e)
            {
                System.debug(e);
                ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.WARNING, 'There was an issue retrieving the standard pricebook. ' + e.getMessage()));
            }
        }
		return standardPriceBookId;
	}

    public static Map<Id, PricebookEntry> getEntriesForPricebookById(Id pricebookId, Set<String> materialNumbers)
    {
        logger.enterAura('getEntriesForPricebookById', new Map<String, Object> {
            'pricebookId' => pricebookId,
            'materialNumbers' => materialNumbers
        });

        Map<Id, PricebookEntry> result = new Map<Id, PricebookEntry>();
        try
        {
            if (null != pricebookId)
            {
                String query = 'SELECT Product2Id, Id, Product2.' + UTIL_SFProduct.MaterialFieldName + ', Product2.Description, UnitPrice, IsActive, Pricebook2Id ' +
                    'FROM PricebookEntry ' +
                    'WHERE Pricebook2Id =: pricebookId ' +
                    'and IsActive = true ' +
                    'AND Product2.' + UTIL_SFProduct.MaterialFieldName + ' IN :materialNumbers';

                loadResult(Database.Query(query), result);
            }
        } catch (Exception ex) {
            logger.log(LoggingLevel.ERROR, 'There was an exception thrown when attempting to get price book entries by material numbers', ex);
        } finally { 
            logger.exit();
        }

        return result;
    }

    @testVisible
    private static void loadResult(List<PricebookEntry> items, Map<Id, PricebookEntry> result)
    {
        Integer itemTot = items.size();
        for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
        {
            PricebookEntry item = items[itemCnt];
            result.put(item.Product2Id, item);
        }
    }
}