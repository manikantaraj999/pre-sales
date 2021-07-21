({
    doInit: function(component, event, helper) {
        if(component.get("v.characteristicName"))
        {
            var characteristicAllowedValues = component.get("v.model").indexedAllowedValues[component.get("v.characteristicName")];

            if(component.get("v.model").indexedSelectedValues[component.get("v.characteristicName")].length>1)
            {
                component.set("v.isList",true);

                var characteristicValues = [];
                
                component.get("v.model").indexedSelectedValues[component.get("v.characteristicName")].forEach(element => {
                    if (characteristicAllowedValues)
                        characteristicValues.push(element.CharacteristicValueDescription);
                    else
                        characteristicValues.push(element.CharacteristicValue);
                });;

                component.set("v.characteristicValues", characteristicValues);
            }
            else
            {
                var selectedValue = component.get("v.model").indexedSelectedValues[component.get("v.characteristicName")][0];

                if(selectedValue)
                {
                    // If there is a series of allowed values for this characteristic, display the description of the value
                    // If there isn't that means this is free text entry and we'll only render the actual value
                    if (characteristicAllowedValues)
                        component.set("v.characteristicValue", selectedValue.CharacteristicValueDescription);
                    else
                        component.set("v.characteristicValue", selectedValue.CharacteristicValue);
                }
            }
        }
    }
})