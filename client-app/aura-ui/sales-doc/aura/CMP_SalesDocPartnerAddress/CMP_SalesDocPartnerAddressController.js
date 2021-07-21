({
    onInit: function(component, event, helper) {
        helper.getCountries(component)
            .then($A.getCallback(function() {
                console.log('final resolve');
                helper.setCountryAndRegion(component);
                component.set('v.displaySpinner', false);
            }))
    },

    onCountryChange: function(component, event, helper) {
        helper.setCountryAndRegion(component);
    },

    onSave: function(component, event, helper) {
        let partner = component.get('v.partner');
        let evt = component.getEvent('partnerAddressSaveEvent');
        partner.isChanged = true;

        evt.setParams({
            partner: partner
        });
        evt.fire();
        helper.closeComponent(component);
    },

    onCancel: function(component, event, helper) {
        helper.closeComponent(component);
    }
})