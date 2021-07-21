public with sharing class UTIL_EnsxObject
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_EnsxObject.class);

    public static void trimValueObject(ensxsdk.EnosixFramework.ValueObject valueObject, 
        ensxsdk.EnosixFramework.ValueObject simValueObject)
    {
        Object value;
        List<String> fieldTechnicalNameList = getFieldTechnicalNameList(valueObject.getFields());
        Integer keyTot = fieldTechnicalNameList.size();
        for (Integer keyCnt = 0 ; keyCnt < keyTot ; keyCnt++)
        {
            String key = fieldTechnicalNameList[keyCnt];
            value = valueObject.Get(key);
            if (value != null) simValueObject.Set(value, key);
        }
    }

    public static void trimValueObjectList(ensxsdk.EnosixFramework.FrameworkCollection collection,
        ensxsdk.EnosixFramework.FrameworkCollection simCollection,
        String itemNumberField,
        Set <String> deleteActionMap)
    {
        List<ensxsdk.EnosixFramework.ValueObject> valueObjectList = collection.buildList(List<ensxsdk.EnosixFramework.ValueObject>.class);
        Integer voTot = valueObjectList.size();
        for (Integer voCnt = 0 ; voCnt < voTot ; voCnt++)
        {
            ensxsdk.EnosixFramework.ValueObject valueObject = valueObjectList[voCnt];
            String itemNumber = (String) valueObject.get(itemNumberField);
            if (itemNumber == null || !deleteActionMap.contains(itemNumber.replaceFirst('^0+(?!$)', '')))
            {
                simCollection.add(valueObject);
            }
        }
    }    

    public static void setValueObject(ensxsdk.EnosixFramework.ValueObject valueObject, 
        ensxsdk.EnosixFramework.ValueObject simValueObject)
    {
        Object value;
        Object currentValue;
        List<String> fieldTechnicalNameList = getFieldTechnicalNameList(valueObject.getFields());
        Integer keyTot = fieldTechnicalNameList.size();
        for (Integer keyCnt = 0 ; keyCnt < keyTot ; keyCnt++)
        {
            String key = fieldTechnicalNameList[keyCnt];
            value = simValueObject.Get(key);
            currentValue = valueObject.Get(key);
            if (value != null || currentValue != null) valueObject.Set(value, key);
        }
    }

    public static void setValueObjectList(ensxsdk.EnosixFramework.FrameworkCollection collection,
        ensxsdk.EnosixFramework.FrameworkCollection simCollection,
        String itemNumberField,
        String subItemNumberField,
        Set <String> deleteActionMap)
    {
        Map <String, ensxsdk.EnosixFramework.ValueObject> simValueObjectMap = new Map <String, ensxsdk.EnosixFramework.ValueObject>();
        List<ensxsdk.EnosixFramework.ValueObject> simValueObjectList = simCollection.buildList(List<ensxsdk.EnosixFramework.ValueObject>.class);
        Integer svoTot = simValueObjectList.size();
        for (Integer svoCnt = 0 ; svoCnt < svoTot ; svoCnt++)
        {
            ensxsdk.EnosixFramework.ValueObject simValueObject = simValueObjectList[svoCnt];
            String itemNumber = (String) simValueObject.get(itemNumberField);
            itemNumber = String.isEmpty(itemNumber) ? '' : itemNumber.replaceFirst('^0+(?!$)', '');
            String subItemNumber = (String.isEmpty(subItemNumberField)) ? '' : (String) simValueObject.get(subItemNumberField);
            if (String.isEmpty(subItemNumberField)) subItemNumberField = '';
            String valueObjectKey = itemNumber + '/' + subItemNumber;
            simValueObjectMap.put(valueObjectKey, simValueObject);
        }

        List<ensxsdk.EnosixFramework.ValueObject> valueObjectList = collection.buildList(List<ensxsdk.EnosixFramework.ValueObject>.class);
        Integer voTot = valueObjectList.size();
        for (Integer index = 0 ; index < voTot ; index++)
        {
            ensxsdk.EnosixFramework.ValueObject valueObject = valueObjectList[index];
            String itemNumber = (String) valueObject.get(itemNumberField);
            itemNumber = String.isEmpty(itemNumber) ? '' : itemNumber.replaceFirst('^0+(?!$)', '');
            String subItemNumber = (String.isEmpty(subItemNumberField)) ? '' : (String) valueObject.get(subItemNumberField);
            if (String.isEmpty(subItemNumberField)) subItemNumberField = '';
            String valueObjectKey = itemNumber + '/' + subItemNumber;
            if (String.isEmpty(itemNumber) || deleteActionMap == null || !deleteActionMap.contains(itemNumber))
            {
                if (simValueObjectMap.containsKey(valueObjectKey))
                {
                    ensxsdk.EnosixFramework.ValueObject simValueObject = simValueObjectMap.get(valueObjectKey);
                    setValueObject(valueObject, simValueObject);
                    simValueObjectMap.remove(valueObjectKey);
                }
                else 
                {
                    simValueObjectMap.remove(valueObjectKey);
                    collection.remove(valueObject);
                }
            }
            else 
            {
                simValueObjectMap.remove(valueObjectKey);
                collection.remove(valueObject);
            }
        }
        if (simValueObjectMap.size() > 0) collection.addAll(simValueObjectMap.values());
    }    

    public static void deleteItemValueObjectList(ensxsdk.EnosixFramework.FrameworkCollection collection,
        String itemNumberField,
        Set <String> deleteActionMap)
    {
        List<ensxsdk.EnosixFramework.ValueObject> valueObjectList = collection.buildList(List<ensxsdk.EnosixFramework.ValueObject>.class);
        Integer voTot = valueObjectList.size();
        for (Integer voCnt = 0 ; voCnt < voTot ; voCnt++)
        {
            ensxsdk.EnosixFramework.ValueObject valueObject = valueObjectList[voCnt];
            String itemNumber = (String) valueObject.get(itemNumberField);
            if (itemNumber != null)
            {
                if (deleteActionMap.contains(itemNumber.replaceFirst('^0+(?!$)', '')))
                {
                    collection.remove(valueObject);
                }
            }
        }
    }    

    private static List<String> getFieldTechnicalNameList(Map<String,ensxsdk.EnosixFramework.FieldInfo> fieldMap)
    {
        List<String> fieldTechnicalNameList = new List<String>();
        if (fieldMap != null)
        {
            List<ensxsdk.EnosixFramework.FieldInfo> fieldList = fieldMap.values();
            Integer fieldTot = fieldList.size();
            for (Integer fieldCnt = 0 ; fieldCnt < fieldTot ; fieldCnt++)
            {
                ensxsdk.EnosixFramework.FieldInfo field = fieldList[fieldCnt];
                fieldTechnicalNameList.add(field.getTechnicalName());
            }
        }

        return fieldTechnicalNameList;
    }

    public static void moveValueObjectList(ensxsdk.EnosixFramework.FrameworkCollection collection, String itemNumberField, Map<Integer, Integer> changeItemNumberMap)
    {
        List<ensxsdk.EnosixFramework.ValueObject> valueObjectList = collection.buildList(List<ensxsdk.EnosixFramework.ValueObject>.class);
        Integer voTot = valueObjectList.size();
        for (Integer voCnt = 0 ; voCnt < voTot ; voCnt++)
        {
            ensxsdk.EnosixFramework.ValueObject valueObject = valueObjectList[voCnt];
            String itemNumber = (String) valueObject.get(itemNumberField);
            if (itemNumber != null)
            {
                Integer oldItemNumber = integer.valueOf(itemNumber);
                if (changeItemNumberMap.containsKey(oldItemNumber))
                {
                    Integer newItemNumber = changeItemNumberMap.get(oldItemNumber);
                    valueObject.set(string.ValueOf(newItemNumber).leftPad(6,'0'), itemNumberField);
                }
            }
        }
    }    
}