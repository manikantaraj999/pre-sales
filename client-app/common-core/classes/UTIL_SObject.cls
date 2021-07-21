public with sharing class UTIL_SObject
{
    public static Boolean doesSObjectHaveCustomerMapping(Id recordId)
    {
        return (UTIL_CustomerMapping.getMapping(recordId) != null);
    }

    public static String getSObjectNameFromId(Id recordId)
    {
        String sObjectName = null;
        if(recordId == null)
        {
            return sObjectName;
        }
        
        Schema.SObjectType sobjectType = recordId.getSObjectType();
        sObjectName = sobjectType.getDescribe().getName();

        return sObjectName;
    }

    public static SObject getSObjectById(Id recordId, List<String> fields)
    {
        return getSObjectByField(recordId, 'Id', recordId, fields);
    }

    public static Boolean isSObjectLinkedToCustomer(Id recordId)
    {
        if (recordId == null) return false;
        if(!doesSObjectHaveCustomerMapping(recordId)) return false;

        return getCustomerNumberValueFromSObject(recordId) != null;
    }

    public static Boolean canUserAccessSObjectCustomerNumber(Id recordId)
    {
        if (recordId == null) return false;
        String customerNumberField = getCustomerNumberFieldfromSObject(recordId);
        return canUserAccessSObjectField(recordId,customerNumberField);
    }

    public static Boolean canUserSetSObjectCustomerNumber(Id recordId)
    {
        if (recordId == null) return false;
        String customerNumberField = getCustomerNumberFieldfromSObject(recordId);
        return canUserSetSObjectField(recordId,customerNumberField);
    }

    public static Boolean canUserAccessSObjectField(Id recordId, String fieldName)
    {
        if(recordId == null || fieldName == null) return false;
        Map<String, Schema.SObjectField> fields = getSObjectFieldsMap(recordId);
        return fields.get(fieldName).getDescribe().isAccessible();
    }


    public static Boolean canUserSetSObjectField(Id recordId, String fieldName)
    {
        if(recordId == null || fieldName == null) return false;
        Map<String, Schema.SObjectField> fields = getSObjectFieldsMap(recordId);
        return fields.get(fieldName).getDescribe().isUpdateable();
    }

    public static String getCustomerNumberFieldfromSObject(Id recordId)
    {
        UTIL_CustomerMapping.CustomerInformationMapping mapping = UTIL_CustomerMapping.getMapping(recordId);
        return mapping.customerNumber.sObjectField;
    }

    public static string getCustomerNumberFieldfromSObject(SObject sObj)
    {
        UTIL_CustomerMapping.CustomerInformationMapping mapping = UTIL_CustomerMapping.getMapping(sObj);
        return mapping.customerNumber.sObjectField;
    }

    public static String getCustomerNumberValuefromSObject(Id recordId)
    {
        String fieldName = getCustomerNumberFieldfromSObject(recordId);
        List<String> fields = new List<String>();
        fields.add(fieldName);
        SObject sObj = getSObjectById(recordId,fields);

        return getValueFromSObjectField(sObj,fieldName, System.Label.LBL_Error_MissingFieldPermission);
    }

    public static void setCustomerNumberOnSObject(Id recordId, String customerNumber)
    {
        if(canUserSetSObjectCustomerNumber(recordId))
        {
            SObject setObject = getSObjectById(recordId, null);
            String setField = getCustomerNumberFieldfromSObject(recordId);
            setObject.put(setField, customerNumber);
        }

    }

    private static SObject getSObjectByField(Id recordId, String selectField, String fieldValue, List<String> fields)
    {
        SObject result = null;
        String sObjectName = getSObjectNameFromId(recordId);

        // These need to be lowercase so we can merge with `fields` var without duplicates
        // Duplicates cause SOQL exception
        Set<String> selectFields = new Set<String> {

            UTIL_SObject.getCustomerNumberFieldfromSObject(recordId).toLowerCase()
        };

        if (fields != null)
        {
            Integer fieldTot = fields.size();
            for (Integer fieldCnt = 0 ; fieldCnt < fieldTot ; fieldCnt++)
            {
                String field = fields[fieldCnt];
                if (String.isNotBlank(field))
                {
                    selectFields.add(field.toLowerCase());
                }
            }
        }

        Map<String, Schema.SObjectField> fieldDefs = getSObjectFieldsMap(recordId);
        Set<String> accessibleFields = new Set<String>();
        List<String> selectFieldsList = new List<String>(selectFields);
        Integer fieldTot = selectFieldsList.size();
        for (Integer fieldCnt = 0 ; fieldCnt < fieldTot ; fieldCnt++)
        {
            String field = selectFieldsList[fieldCnt];
             if (fieldDefs.get(field).getDescribe().isAccessible())
            {
                accessibleFields.add(field);
            }
        }
        if (null != fieldValue)
        {
            String query = 'SELECT ID,' +
                String.escapeSingleQuotes(String.join(new List<String>(accessibleFields), ', ')) +
                ' FROM ' + sObjectName + ' WHERE ' +
                String.escapeSingleQuotes(selectField.toLowerCase()) +
                ' = :fieldValue LIMIT 1';

            result = Database.query(query);
        }
        return result;
    }

    public static String getValueFromSObjectField(SObject sObj, string field, String warningMessageFormat)
    {
        String result = null;

        if (null == sObj || String.isBlank(field))
        {
            return result;
        }

        Map<String, Schema.SObjectField> fields = getSObjectFieldsMap(sObj.Id);
        DescribeFieldResult fieldDef = fields.get(field) == null ? null : fields.get(field).getDescribe();
        if (fieldDef == null || !fieldDef.isAccessible())
        {
            String fieldLable = fieldDef == null ? 'Invalid Field' : fieldDef.getLabel();
            UTIL_PageMessages.addMessage(
                UTIL_PageMessages.WARNING,
                String.format(warningMessageFormat, new String[]{ fieldLable })
            );
            return result;
        }

        String sObjField = field.toLowerCase();
        Object fieldValue = sObj.get(sObjField);

        if (null != fieldValue)
        {
            return String.valueOf(fieldValue);
        }

        return result;
    }

    public static Map<String, Schema.SObjectField> getSObjectFieldsMap(Id recordId)
    {
        String sobjectName = getSObjectNameFromId(recordId);
        Schema.SObjectType targetType = Schema.getGlobalDescribe().get(sobjectName);
        Map<String, Schema.SObjectField> fields = targetType.getDescribe().fields.getMap();
        return fields;
    }
}