public with sharing class UTIL_SFAccount
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_SFAccount.class);

    public class CustomerFieldNameAccessException extends Exception 
    { 
        public override String getMessage()
        {
            return String.format(System.Label.LBL_CustomerNumberAccessException_Error, new String[]{CustomerFieldName});
        }
    }

    // Returns the field name which stores the SAP Customer number
    // The default is from the EDM package or from the AppSettings
    // If 360 is installed it will be the fieldname setup from the metadata
    private static String CustomerFieldNameSave = null;

    public static String CustomerFieldName
    {
        get
        {
            if (CustomerFieldNameSave == null) {
                CustomerFieldNameSave = '';
                try
                {
                    UTIL_CustomerMapping.CustomerInformationMapping mapping = UTIL_CustomerMapping.getMapping();
                    CustomerFieldNameSave = mapping.customerNumber.sObjectField;
                }
                catch(Exception ex) 
                { 
                    System.debug('Customer Field Name not found'); 
                }
                
                CustomerFieldNameSave = String.isNotEmpty(CustomerFieldNameSave) ? CustomerFieldNameSave : (String)UTIL_AppSettings.getValue(UTIL_AppSettings.EnterpriseApp, 'Account.CustomerFieldName', 'AccountNumber');
            }
            
            return CustomerFieldNameSave;
        }
    }

    public static Account getAccountById(String value, List<String> fields)
    {
        return UTIL_SFAccount.getAccountByField('Id', value, fields);
    }

    public static Account getAccountById(String value)
    {
        return UTIL_SFAccount.getAccountById(value, null);
    }

    public static Account getAccountByCustomerNumber(String value, List<String> fields)
    {
        return UTIL_SFAccount.getAccountByField(UTIL_SFAccount.CustomerFieldName, value, fields);
    }

    public static Account getAccountByCustomerNumber(String value)
    {
        return UTIL_SFAccount.getAccountByCustomerNumber(value, null);
    }

    private static Account getAccountByField(String selectField, String value, List<String> fields)
    {
        Account result = null;

        // These need to be lowercase so we can merge with `fields` var without duplicates
        // Duplicates cause SOQL exception
        Set<String> selectFields = new Set<String> {
            'name',
            'phone',
            'billingstreet',
            'billingcity',
            'billingstate',
            'billingpostalcode',
            'billingcountry',
            'createddate',
            'parentid',
            'accountnumber',
            UTIL_SFAccount.CustomerFieldName.toLowerCase()
        };
            // 'billingstatecode',
            // 'billingcountrycode',

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

        Map<String, Schema.SObjectField> fieldDefs = Schema.SObjectType.Account.fields.getMap();
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
        try
        {
            if (null != value)
            {
                String query = 'SELECT ' +
                    String.escapeSingleQuotes(String.join(new List<String>(accessibleFields), ', ')) +
                    ' FROM Account WHERE ' +
                    String.escapeSingleQuotes(selectField.toLowerCase()) +
                    ' = :value LIMIT 1';
                result = Database.query(query);
            }
        }
		catch (Exception e)
		{
            System.debug(e);
            ApexPages.addMessage(new Apexpages.Message(
				ApexPages.Severity.WARNING, 
				'There was an issue retrieving an Account record for the provided Id'));
        }
        return result;
    }

    public static Boolean canUserSetCustomerNumber()
    {
        Map<String, Schema.SObjectField> fields = Schema.SObjectType.Account.fields.getMap();
        return fields.get(UTIL_SFAccount.CustomerFieldName).getDescribe().isUpdateable();
    }

    public static Boolean canUserAccessCustomerNumber()
    {
        Map<String, Schema.SObjectField> fields = Schema.SObjectType.Account.fields.getMap();
        return fields.get(UTIL_SFAccount.CustomerFieldName).getDescribe().isAccessible();
    }

    public static String getCustomerNumberFromAccount(Account account)
    {
        String custFieldName = UTIL_SFAccount.CustomerFieldName;

        if (!canUserAccessCustomerNumber()) throw new CustomerFieldNameAccessException();

        return (String) account.get(custFieldName);
    }

    public static void setAccountCustomerNumber(Account account, String customerNumber)
    {
        if (canUserSetCustomerNumber())
        {
            String customerField = UTIL_SFAccount.CustomerFieldName;
            account.put(customerField, customerNumber);
        }
    }

    public static Boolean isAccountLinkedToCustomer(Account account)
    {
        if (account == null) return false;

        return getCustomerNumberFromAccount(account) != null;
    }

    public static Boolean isAccountLinkedToCustomer(String accountId)
    {
        return isAccountLinkedToCustomer(getAccountById(accountId));
    }

    public static String getValueFromAccountField(Account a, string field, String warningMessageFormat)
    {
        String result = null;

        if (null == a || String.isBlank(field))
        {
            return result;
        }

        Map<String, Schema.SObjectField> fields = Schema.SObjectType.Account.fields.getMap();
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

        String accountField = field.toLowerCase();
        Object value = a.get(accountField);

        if (null != value)
        {
            return String.valueOf(value);
        }

        return result;
    }
}