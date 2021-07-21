({
    handleCancel:function(component){
        var hideSettings = component.getEvent("hideSettings");
        hideSettings.fire();
    },
    handleSave:function(component){
        var settings = component.get('v.settings');
        var updateSet = component.getEvent("updateSettings");
        updateSet.setParam("settings",settings);
        updateSet.fire();
    },
})