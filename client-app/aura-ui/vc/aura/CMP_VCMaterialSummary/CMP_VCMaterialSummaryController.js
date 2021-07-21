({
    runSimulate:function(component,event){
        var updatedEvent = component.getEvent("configUpdated");
        updatedEvent.fire();
    }
})