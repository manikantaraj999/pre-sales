public with sharing class ENSX_VCCharacteristic
{
    //new
    @AuraEnabled
    public String CharacteristicID{ get; set; }

    @AuraEnabled
    public String CharacteristicName{ get; set; }

    @AuraEnabled
    public String CharacteristicDescription{ get; set; }

    @AuraEnabled
    public String Required{ get; set; }

    @AuraEnabled
    public String Inherited{ get; set; }

    @AuraEnabled
    public String CharacteristicValueDescription{ get; set; }

    @AuraEnabled
    public string ValuesAssigned {get;set;}

    @AuraEnabled
    public string DataType {get;set;}

    @AuraEnabled
    public Boolean SingleValue {get;set;}

    @AuraEnabled
    public string ValueRequired {get;set;}

    @AuraEnabled
    public string IntervalsAllowed {get;set;}

    @AuraEnabled
    public string AdditionalValues {get;set;}

    @AuraEnabled
    public string NotToBeDisplayed {get;set;}

    @AuraEnabled
    public string NoEntryAllowed {get;set;}

    @AuraEnabled
    public string DisplayTemplate {get;set;}

    @AuraEnabled
    public string GroupName {get;set;}

    @AuraEnabled
    public string GroupText {get;set;}

    @AuraEnabled
    public string SequenceNumber {get;set;}


    @AuraEnabled
    Public List<ENSX_VCCharacteristicValues> PossibleValues {get;set;}

    @AuraEnabled
    public String ControlInputType{ get;set; }

    @AuraEnabled
    public String SelectedValue{get;set;}

    @testVisible
    private static String getControlForCharacteristic(SBO_EnosixVC_Detail.CHARACTERISTICS sbochar, Integer numInputValues, Boolean preferRadioButton )
    {
        String inputType = 'ShortText';
        //todo discuss values for format- fetching metadata (is that done in apex or lightining?
        if(numInputValues>0)
        {
            if(preferRadioButton)
            { 
                inputType = 'RadioGroup';
            }
            else{
                inputType = 'InputPicklist';
            }
        } else if(sbochar.DataType != null && (sbochar.DataType.toUpperCase() =='INT' || sbochar.DataType.toUpperCase() == 'NUM'))
        {
            inputType = 'Number'; 
        } else if(sbochar.DataType != null && sbochar.DataType.toUpperCase() == 'DATE')
        {
            inputType = 'Date';
        }

        return inputType;

    }
    public static String getValueDescriptionForValueId(SBO_EnosixVC_Detail.EnosixVC sbo, String valId)
    {
        String selectedValueDescription = '';
        List<SBO_EnosixVC_Detail.ALLOWEDVALUES> avList = sbo.ALLOWEDVALUES.getAsList();
        Integer avTot = avList.size();
        for (Integer avCnt = 0 ; avCnt < avTot ; avCnt++)
        {
            SBO_EnosixVC_Detail.ALLOWEDVALUES val = avList[avCnt];
            if(val.CharacteristicValue == valId)
            {
                selectedValueDescription = val.CharacteristicValueDescription;
                break;
            }
        }
        return selectedValueDescription; 
    }
    public static String getCharacteristicDescriptionForValueId(SBO_EnosixVC_Detail.EnosixVC sbo, String valId)
    {
        String selectedCharacteristicDescription = '';
        List<SBO_EnosixVC_Detail.CHARACTERISTICS> charList = sbo.CHARACTERISTICS.getAsList();
        Integer charTot = charList.size();
        for (Integer charCnt = 0 ; charCnt < charTot ; charCnt++)
        {
            SBO_EnosixVC_Detail.CHARACTERISTICS cha = charList[charCnt];
            if(cha.CharacteristicId == valId)
            {
                selectedCharacteristicDescription = cha.CharacteristicDescription;
                break;
            }
        }
        return selectedCharacteristicDescription;
    }
    public static ENSX_VCCharacteristic getCharacteristicForSBOModel(SBO_EnosixVC_Detail.EnosixVC model, SBO_EnosixVC_Detail.CHARACTERISTICS sbochar)
    {
        ENSX_VCCharacteristic vcChar = new ENSX_VCCharacteristic();
        vcChar.PossibleValues = new List<ENSX_VCCharacteristicValues>();
        List<SBO_EnosixVC_Detail.ALLOWEDVALUES> valLst = model.ALLOWEDVALUES.getAsList();
        Integer avTot = valLst.size();
        for (Integer avCnt = 0 ; avCnt < avTot ; avCnt++)
        {
            SBO_EnosixVC_Detail.ALLOWEDVALUES val = valLst[avCnt];
            if(val.CharacteristicID == sbochar.CharacteristicID)
            {
                ENSX_VCCharacteristicValues charVal = new ENSX_VCCharacteristicValues();
                charVal.CharacteristicId = val.CharacteristicID;
                charVal.Value = val.CharacteristicValue;
                charVal.ValueDescription = val.CharacteristicValueDescription;
                charVal.CharacteristicDescription = sbochar.CharacteristicDescription;
                vcChar.PossibleValues.add(charVal);
            }
        }
        System.debug('possible values size for char:' + sbochar.CharacteristicID + ' is ' + vcChar.PossibleValues.size());
        String selectedValueId = '';
        List<SBO_EnosixVC_Detail.SELECTEDVALUES> svList = model.SELECTEDVALUES.getAsList();
        Integer svTot = svList.size();
        for (Integer svCnt = 0 ; svCnt < svTot ; svCnt++)
        {
            SBO_EnosixVC_Detail.SELECTEDVALUES va = svList[svCnt];
            if (va.CharacteristicID == sbochar.CharacteristicID)
            {
                selectedValueId = va.CharacteristicValue;
                break;
            }
        }
        vcChar.SelectedValue = selectedValueId;
        vcChar.CharacteristicValueDescription = selectedValueId != ''? ENSX_VCCharacteristic.getValueDescriptionForValueId(model, selectedValueId):'';
        //todo: this should be required by the SBO, but there is data that doesnt exist
        // System.debug('sequenceNumber(String):' + sbochar.SequenceNumber.trim());
        // Integer modifiedSeqNumber  =  Integer.valueOf(sbochar.SequenceNumber.trim()); 
        // System.debug('modifedSeqNumber:' + modifiedSeqNumber);
        Boolean showRadio = false;//  Math.mod(modifiedSeqNumber,2) == 0;
        vcChar.ControlInputType = ENSX_VCCharacteristic.getControlForCharacteristic(sbochar,vcChar.PossibleValues.size(),showRadio);  
        vcChar.CharacteristicID = sbochar.CharacteristicID;
        vcChar.CharacteristicName = sbochar.CharacteristicName;
        vcChar.CharacteristicDescription = sbochar.CharacteristicDescription;
        vcChar.Required = sbochar.Required;
        vcChar.Inherited = sbochar.Inherited;
        System.debug('assigning a value to the vcChar from the SBO... SBO.ValuesAssigned=' +  sbochar.ValuesAssigned);
        vcChar.ValuesAssigned = sbochar.ValuesAssigned ;
        vcChar.DataType = sbochar.DataType ;
        vcChar.SingleValue = sbochar.SingleValue ;
        vcChar.ValueRequired = sbochar.ValueRequired ;
        vcChar.IntervalsAllowed = sbochar.IntervalsAllowed ;
        vcChar.AdditionalValues = sbochar.AdditionalValues ;
        vcChar.NotToBeDisplayed = sbochar.NotToBeDisplayed ;
        vcChar.NoEntryAllowed = sbochar.NoEntryAllowed ;
        vcChar.DisplayTemplate = sbochar.DisplayTemplate ;
        vcChar.GroupName = sbochar.GroupName ;
        vcChar.GroupText = sbochar.GroupText ;
        vcChar.SequenceNumber = sbochar.SequenceNumber ;
        return vcChar;
    }
    public static SBO_EnosixVC_Detail.CHARACTERISTICS getSBOModelCharacteristicForCharacteristic(ENSX_VCCharacteristic charac)
    {
        SBO_EnosixVC_Detail.CHARACTERISTICS newChar = new SBO_EnosixVC_Detail.CHARACTERISTICS();
        newChar.NoEntryAllowed = charac.NoEntryAllowed;
        newChar.CharacteristicName = charac.CharacteristicName;
        newChar.CharacteristicID = charac.CharacteristicID;
        newChar.CharacteristicDescription = charac.CharacteristicDescription;
        newChar.Required = charac.Required;
        newChar.Inherited = charac.Inherited;
        newChar.ValuesAssigned = charac.ValuesAssigned ;
        newChar.DataType = charac.DataType ;
        newChar.SingleValue = charac.SingleValue ;
        newChar.ValueRequired = charac.ValueRequired ;
        newChar.IntervalsAllowed = charac.IntervalsAllowed ;
        newChar.AdditionalValues = charac.AdditionalValues ;
        newChar.NotToBeDisplayed = charac.NotToBeDisplayed ;
        newChar.NoEntryAllowed = charac.NoEntryAllowed ;
        newChar.DisplayTemplate = charac.DisplayTemplate ;
        newChar.GroupName = charac.GroupName ;
        newChar.GroupText = charac.GroupText ;
        newChar.SequenceNumber = charac.SequenceNumber ;
        return newChar;
    }
    public static List<SBO_EnosixVC_Detail.ALLOWEDVALUES> getSBOAllowedValuesFromPossibleValues(ENSX_VCCharacteristic charc)
    {
        // system.debug('ENSX_VCCharacteristic.getSBOAllowedValuesFromPossibleValues');
        List<SBO_EnosixVC_Detail.ALLOWEDVALUES> allowedvalues = new List<SBO_EnosixVC_Detail.ALLOWEDVALUES>();
        Integer pvTot = charc.PossibleValues.size();
        for (Integer pvCnt = 0 ; pvCnt < pvTot ; pvCnt++)
        {
            ENSX_VCCharacteristicValues cv = charc.PossibleValues[pvCnt];
            // System.debug(cv);
            allowedvalues.add(ENSX_VCCharacteristicValues.getSBOAllowedvaluesForModel(cv));
        }
        return allowedvalues;
    }

}