({
    onInit: function(component, event, helper) {
        helper.getItemCategories(component, helper)
            .then($A.getCallback(function() {
                component.set('v.isEditItemInitialized', true);
            }))
    },

    onSimulateClick: function(component, event, helper) {
        helper.prepareSimulate(component, event, helper);
    },

    onFieldSelectChange: function(component, event, helper) {
        helper.onFieldChange(component, event, helper);
    },

    onInputDateChange: function(component, event, helper) {
        helper.onFieldChange(component, event, helper);
    },

    onInputFocus: function(component, event, helper) {
        // This is to store the value when input is focus
        // For input type text and number
        let currentValue = event.getSource().get('v.value');
        component.set('v.onFocusInputValue', currentValue);
    },

    onInputBlur: function(component, event, helper) {
        let oldValue = component.get('v.onFocusInputValue');
        let newValue = event.getSource().get('v.value');

        if (oldValue != newValue) {
            helper.onFieldChange(component, event, helper);
        }
        component.set('v.onFocusInputValue', null);
    },

    onChangeItem: function(component, event, helper) {
        helper.itemChanged(component);
    },

    onConditionValueChange: function(component, event, helper) {
        helper.itemChanged(component);
    },

    onReceivePartner: function(component, event, helper) {
        let appSettings = component.get('v.appSettings');

        if (appSettings.autoSimulate.afterPartnerSelection) {
            helper.prepareSimulate(component, event, helper);
        }
    },

    onCancelClick: function(component, event) {
        component.find('overlayLibEdit').notifyClose();
    },

    onSaveClick: function(component, event, helper) {
        var evt = component.getEvent('editItemEvent');
        let item = component.get('v.item');

        let isValid = helper.validateItem(item);
        if (!isValid) return;

        component.set('v.enableItemSimulate', false);

        evt.setParams({
            'isItemEdited': true,
            'item': component.get('v.item')
        }),
        evt.fire();
        component.find('overlayLibEdit').notifyClose();
    },
})