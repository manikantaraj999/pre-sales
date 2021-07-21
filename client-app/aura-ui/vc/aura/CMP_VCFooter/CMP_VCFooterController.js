({
    handleClear:function (component, event, helper) {
        var compEvents = component.getEvent("clearConfiguration");
        compEvents.fire();
    },
    handleCancel:function (component, event, helper) {
        var compEvents = component.getEvent("cancelConfiguration");
        compEvents.fire();
    },
    handleFinalize:function (component, event, helper) {
        var compEvents = component.getEvent("finalizeConfiguration");
        compEvents.fire();
    }

})