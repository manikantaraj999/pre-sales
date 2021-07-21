public with sharing class UTIL_ViewHelper
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_ViewHelper.class);

    public static integer SearchDefaultPageSize
    {
        get
        {
            return (Integer)UTIL_AppSettings.getValue('Search.DefaultPageSize', 10);
        }
    }

    public static void displayResultMessages(List<ensxsdk.EnosixFramework.Message> mList, ensxsdk.EnosixFramework.MessageType level) 
    {
        if (mList == null) return;    
        Integer mTot = mList.size();
        for (Integer mCnt = 0 ; mCnt < mTot ; mCnt++) {
            ensxsdk.EnosixFramework.Message m = mList[mCnt]; 
            displayMessage(level, m.Type, m.Text);
        }
    }

    @testVisible
    private static void displayMessage(
        ensxsdk.EnosixFramework.MessageType logLevel, 
        ensxsdk.EnosixFramework.MessageType mType, 
        String mText)
    {
            boolean showMessage = false;
            ApexPages.Severity severity = ApexPages.Severity.INFO;

            if (ensxsdk.EnosixFramework.MessageType.Error == mType) 
            {
                showMessage = true;
                severity = ApexPages.Severity.ERROR;
            } 
            else if (ensxsdk.EnosixFramework.MessageType.WARNING == mType && 
                (ensxsdk.EnosixFramework.MessageType.WARNING == logLevel || 
                    ensxsdk.EnosixFramework.MessageType.INFO == logLevel || 
                    ensxsdk.EnosixFramework.MessageType.SUCCESS == logLevel)) 
            {
                showMessage = true;
                severity = ApexPages.Severity.WARNING;
            } 
            else if (ensxsdk.EnosixFramework.MessageType.INFO == mType && 
                (ensxsdk.EnosixFramework.MessageType.WARNING == logLevel || 
                    ensxsdk.EnosixFramework.MessageType.INFO == logLevel || 
                    ensxsdk.EnosixFramework.MessageType.SUCCESS == logLevel)) 
            {
                showMessage = true;
                severity = ApexPages.Severity.INFO;
            } 
            else if (ensxsdk.EnosixFramework.MessageType.SUCCESS == mType && 
                ensxsdk.EnosixFramework.MessageType.SUCCESS == logLevel) 
            {
                showMessage = true;
                severity = ApexPages.Severity.INFO;
            }

            if (showMessage) ApexPages.addMessage(new Apexpages.Message( severity, mText));
    }

    public static void displayResultMessages(List<ensxsdk.EnosixFramework.Message> mList) 
    {
        displayResultMessages(mList, ensxsdk.EnosixFramework.MessageType.WARNING);
    }

    public static void sortOptionsByLabel(List<SelectOption> options)
    {
        Map<String, SelectOption> optionMapByLabel = new Map<String, SelectOption>();
        
        // Suffix to avoid issue with duplicate labels
        Integer suffix = 1;
        Integer optTot = options.size();
        for (Integer optCnt = 0 ; optCnt < optTot ; optCnt++)
        {
            SelectOption opt = options[optCnt];
            optionMapByLabel.put(opt.getLabel() + suffix++, opt);
        }

        List<String> sortKeys = new List<String>();
        sortKeys.addAll(optionMapByLabel.keySet());
        sortKeys.sort();

        // clear the original collection to rebuilt it
        options.clear();
        Integer sortTot = sortKeys.size();
        for (Integer sortCnt = 0 ; sortCnt < sortTot ; sortCnt++)
        {
            String key = sortKeys[sortCnt];
            options.add(optionMapByLabel.get(key));
        }
    }

    public static string pickFirst(List<SelectOption> options)
    {
        if(options.size() <= 0) return '';
        SelectOption firstOption = options.get(0);
        if (null != firstOption)
        {
        	return firstOption.getValue();
        }
        return '';
    }

    public static string getLabelForSelectOptionValue(List<SelectOption> selectOptions, String val)
    {
        Integer soTot = selectOptions.size();
        for (Integer soCnt = 0 ; soCnt < soTot ; soCnt++)
        {
            SelectOption so = selectOptions[soCnt];
            if (so.getValue() == val)
            {
                return so.getLabel();
            }
        }
        return '';
    }

    public static string getValueForSelectOptionLabel(List<SelectOption> selectOptions, String label)
    {
        Integer soTot = selectOptions.size();
        for (Integer soCnt = 0 ; soCnt < soTot ; soCnt++)
        {
            SelectOption so = selectOptions[soCnt];
            if (so.getLabel() == label)
            {
                return so.getValue();
            }
        }
        return '';
    }

    // getValueForSelectOptionByValueOrLabel()
    //
    // Find a matching select option. First search for a matching value,
    // then if not found, search for a matching label.
    //
    // Returns the value of the option no matter how the match is found.
    // Returns '' if no match is found
    public static string getValueForSelectOptionByValueOrLabel(
        List<SelectOption> selectOptions, String lookup)
    {
        Integer soTot = selectOptions.size();
        for (Integer soCnt = 0 ; soCnt < soTot ; soCnt++)
        {
            SelectOption so = selectOptions[soCnt];
            if (so.getValue() == lookup)
            {
                return so.getValue();
            }
        }
        for (Integer soCnt = 0 ; soCnt < soTot ; soCnt++)
        {
            SelectOption so = selectOptions[soCnt];
            if (so.getLabel() == lookup)
            {
                return so.getValue();
            }
        }
        return '';
    }

    public static boolean validateStringPropertyIsNotBlank(string property, string propertyName)
    {
        boolean isValid = true;
        if (string.isBlank(property))
        {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, propertyName + ' is required'));
            system.debug(string.format('Validation error on property: {0}, value was: {1}', new String[]{
                    propertyName, property
            }));
            isValid = false;
        }
        return isValid;
    }

    /* Adds a SelectOption to the list if the option value is no present */
    public static void addSelectOption(List<SelectOption> selectOptions, SelectOption selectOption)
    {
        if (null == selectOptions || null == selectOption) return;
        String selectValue = selectOption.getValue();
        Integer soTot = selectOptions.size();
        for (Integer soCnt = 0 ; soCnt < soTot ; soCnt++)
        {
            SelectOption so = selectOptions[soCnt];
            if (so.getValue() == selectValue)
            {
                return;
            }
        }
        selectOptions.add(selectOption);
    }

    //This method does nothing beyond connactenating a phone number with x and an extension if it exists.
    //This *does not* try and do any standard formatting or validation that the number is actually valid.
    public static string formatPhoneForDisplay(string phoneNumber, string extension)
    {
        string formattedPhone = '';
        if(null != phoneNumber)
        {
            formattedPhone += phoneNumber;
        }
        if(string.isNotBlank(extension))
        {
            formattedPhone += ' x' + extension;
        }
        return formattedPhone;
    }

    public static String readableStringFromDate(Date d)
    {
        if (null == d)
        {
            return '';
        }
        // We cannot control Date::format() output but can control DateTime::format(). Apex is weird.
        return DateTime.newInstance(d, Time.newInstance(0, 0, 0, 0)).format('MM/dd/yyyy');
    }

    public static Date dateFromReadableString(String s)
    {
        Date result = null;
        if (String.isNotBlank(s))
        {
            try
            {
                result = Date.newInstance(
                    Integer.valueOf(s.substring(6, 10)),
                    Integer.valueOf(s.substring(0, 2)),
                    Integer.valueOf(s.substring(3, 5))
                );
            }
            catch (Exception e)
            {
                // ignore conversion errors
            }
        }
        return result;
    }
}