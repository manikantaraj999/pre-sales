({
    valueChanged: function (comp, event, helper) {
        var eventSource = event.getSource();
        var label = eventSource.get('v.label')
        var charValue = eventSource.get('v.name');
        var inputId = comp.get('v.inputId');
        
        comp.set('v.val', charValue );
        var inputChanged = comp.getEvent('inputChanged')
        inputChanged.setParam("inputId", inputId);
        inputChanged.setParam("newVal", charValue);
        inputChanged.setParam("newValDesc", label)
        inputChanged.fire();
    },
    
})