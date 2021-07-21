({
    doInit: function(component, event, helper) {
      component.set("v.busy", true);
      helper.getSettings(component, helper);
      helper.getConfiguration(component, helper);
      //helper.variantSearch(component);
    },
    configUpdated: function(component, event, helper) {
        component.set("v.busy", true);
        console.log("configUpdated, calling helper");
        helper.updateConfiguration(component, helper);
        component.set("v.busy", false);
    },
    clearConfig: function(component, event, helper) {
        component.set("v.busy", true);
        component.set("v.isReconfigure", false);
        //component.set("v.reconfiguredValues", null);
        let itemJSON = JSON.parse(component.get("v.itemJSON"));
        itemJSON.selectedCharacteristics = [];
        component.set('v.itemJSON', JSON.stringify(itemJSON));

        helper.getSettings(component, helper);
        helper.getConfiguration(component, helper);
        //helper.variantSearch(component);

        component.set("v.busy", false);
    },
	setBOMItems:function(component,event,helper){ 
        helper.setCharacteristicValuesFromBOM(component, helper);
    },
    // Variants aren't currently supported
    // variantSet: function(component, event, helper) {
    //     var variant = event.getParam("Variant");
    //     helper.variantSet(component, variant);
    // },
    
    inputChanged: function(component, event, helper) {
        component.set("v.configComplete", false);
        var inputId = event.getParam("inputId");
        var characteristicID = event.getParam("characteristicID");
        var val = event.getParam("newVal");
        var model = component.get("v.model");

        if (!model.indexedSelectedValues) return;

        // notification (remove, only for debugging)
        // var notify = component.getEvent("displayNotification");
        // notify.setParams({
        //     message:
        //     "VCinputChanged, characteristic " + inputId + " changed to:" + val,
        //     severity: "info"
        // });
        // notify.fire();
        // This checks whether or not the characteristic has an existing selected value/s
        if(model.indexedSelectedValues[inputId][0])
        {
            // If the inputId already exists, for a single value we just update it.
            // If multiple values already exist however, we need to flush the whole thing and then
            // replace it with the newest list.
            if(Array.isArray(val))
            {
                // Flush the existing array
                model.indexedSelectedValues[inputId].length = 0;
                
                val.forEach(function(item){
                    var arraySelectedValue = {
                        CharacteristicName: inputId
                        , CharacteristicID: characteristicID
                        , CharacteristicValue: item
                        , UserModified: true
                    };
                    model.indexedSelectedValues[inputId].push(arraySelectedValue);
                })
            }
            else
            {
                var item = model.indexedSelectedValues[inputId][0];

                item.CharacteristicValue = val;
                item.CharacteristicName = inputId;
                item.UserModified = true;
            }

        }
        else
        {
            // We need to check whether the item is a list or an individual value. If it's a clean value we stuff it into a single cell
            // otherwise we need to push in a series of elements.
            if(Array.isArray(val))
            {
                val.forEach(function(item){
                    var arraySelectedValue = {
                        CharacteristicName: inputId
                        , CharacteristicValue: item
                        , UserModified: true
                    };
                    model.indexedSelectedValues[inputId].push(arraySelectedValue);
                })
            }
            else
            {
                var newSelectedValue = {
                    CharacteristicName: inputId
                    , CharacteristicValue: val
                    , UserModified: true
                };
                model.indexedSelectedValues[inputId].push(newSelectedValue);
            }
        }

        var characteristicChangeCount = component.get('v.characteristicChangeCount');
        characteristicChangeCount = characteristicChangeCount + 1;
        component.set('v.characteristicChangeCount',characteristicChangeCount);
        var vcSettings = component.get('v.vcSettings');
        console.log('characteristic change count = ' + characteristicChangeCount);
        console.log('fetch Config Frequency = ' + vcSettings.FetchConfigurationFrequency);
        console.log('conditional= ' + vcSettings.FetchConfigurationFrequency == '0'|| characteristicChangeCount % vcSettings.FetchConfigurationFrequency == 0); 
        
        if(!component.get('v.vcSettings.DisplayManualRunVCButton') && (vcSettings.FetchConfigurationFrequency == '0'|| characteristicChangeCount % vcSettings.FetchConfigurationFrequency == 0))
        {
            if (helper.shouldProcess(model.characteristics, inputId))
            {
                component.getEvent("configUpdated").fire();
            }
        }
    },
    handleExpandCollapseAll: function(component, event, helper) {
        var expanded = component.get("v.allExpanded");
        var collapsables = component.find("collapsableCharacteristic");

        // Returns list when 2 or more, but we also need a list when only one is found
        if (collapsables && !collapsables.forEach) collapsables = [collapsables];

        collapsables.forEach(
            function(comp){
                if (expanded) {
                    comp.collapse();
                } else {
                    comp.expand();
                }
            }
        )

        component.set("v.allExpanded", !component.get("v.allExpanded"));
        component.set(
            "v.expandTitle",
            component.get("v.allExpanded")
            ? "Collapse All Sections"
            : "Expand All Sections"
        );
        component.set(
            "v.expandIcon",
            component.get("v.allExpanded") ? "utility:arrowup" : "utility:arrowdown"
        );
    },
    showBusyIndicator: function(component, event) {
        component.set("v.busy", true);
    },
    hideBusyIndicator: function(component, event) {
        component.set("v.busy", false);
    },
    displayNotification: function(component, event) {
        var message = event.getParam("message");
        var severity = event.getParam("severity");
        var toastEvent = $A.get("e.force:showToast");
        
        toastEvent.setParams({
            message: message,
            type: severity,
            mode: "dismissible"
        });
        toastEvent.fire();
    },
    finalizeConfiguration: function(component, event, helper) {
        component.set("v.allowFinalize", false);
        component.set("v.allowCancel", false);
        var finalizeEventMessage = component.getEvent("displayNotification");
        finalizeEventMessage.setParams({
            message: "Finalizing Configuration",
            severity: "info"
        });
        finalizeEventMessage.fire();


        var config = component.get("v.model");
        var selectedValues = Array.prototype.concat.apply([],Object.values(config.indexedSelectedValues));
        component.set("v.allowFinalize", true);
        
        var itemJSON = JSON.parse(component.get("v.itemJSON"));
        // Stuffs the selected values into the same array of input items
        // This way when the flow continues, it can process the newly updated configuration.
        itemJSON.selectedCharacteristics = selectedValues.map(
                selectedValue => {
                    return (
                        ({ CharacteristicID, CharacteristicName, CharacteristicValue, CharacteristicValueDescription, UserModified}) => 
                        ({ CharacteristicID, CharacteristicName, CharacteristicValue, CharacteristicValueDescription, UserModified}))(selectedValue)
                });
            
        component.set("v.itemJSON", JSON.stringify(itemJSON));
        component.set("v.allowCancel", true);

        component.set("v.configComplete", true);

        if(component.get("v.disposeOnClose"))
            component.destroy();

        helper.finishConfig(component, helper);
    },
    cancelConfiguration: function(component, event, helper) {
        component.set("v.allowFinalize", false);
        component.set("v.allowCancel", false);
        var finalizeEventMessage = component.getEvent("displayNotification");
        finalizeEventMessage.setParams({
            message: "Canceling Configuration",
            severity: "info"
        });
        finalizeEventMessage.fire();

        //todo: ensure the user actually wants to cancel- all changes will be lost..
        component.set("v.allowFinalize", true);
        component.set("v.allowCancel", true);

        if(component.get("v.disposeOnClose"))
            component.destroy();

        var cancelEvent = $A.get("e.c:EVT_VCConfigurationCancelledConfirmed");
        cancelEvent.fire();

        component.set("v.itemJSON", JSON.stringify({
            action: {
                cancel: true
            }
        }));
        let isLightningFlow = component.get('v.isLightningFlow');
        if (isLightningFlow) helper.flowNavigate(component, helper);
        else component.find('overlayLibConfiguration').notifyClose();
    },
    displayVCSettings: function(component, event) {
        component.set("v.showSettings", true);
    },
    hideVCSettings: function(component, event) {
        component.set("v.showSettings", false);
    },
    updateVCSettings: function(component, event, helper) {
        var settings = event.getParam("settings");
        component.set("v.vcSettings", settings);
        helper.updateSettings(component, helper);
    }
})