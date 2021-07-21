({
    onSelectRowAction: function(component, event, helper) {
        let rowActionEvent = component.getEvent('rowActionEvent');
        rowActionEvent.setParams({
            'item': component.get('v.lineItem'),
            'actionName': event.getParam("value")
        });
        rowActionEvent.fire();
    },

    onLineItemChange: function(component, event, helper) {
        component.set('v.lineItem.isChanged', true);
        if (!component.get('v.needToSimulate')) {
            let action = component.getEvent('lineItemChangeEvent');
            action.fire();
        }        
    }
})