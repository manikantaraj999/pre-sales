({
    onInit: function(component, event, helper) {
        helper.buildColumns(component);
        helper.searchPartners(component, component.get('v.pagingOptions'))
            .then($A.getCallback(function() {
                component.set('v.displaySpinner', false);
            }))
    },

    onPagerChanged: function(component, event, helper) {
        component.set('v.displaySpinner', true);
        helper.searchPartners(component, event.getParam('options'))
            .then($A.getCallback(function() {
                component.set('v.displaySpinner', false);
            }))
    },

    onClickCancel: function(component, event, helper) {
        component.find("overlayLibPartner").notifyClose();
    },

    onRowSelection: function(component, event, helper) {
        let selectedRows = event.getParam('selectedRows');
        if (selectedRows.length > 0) {
            // Set a timeout so it doesn't quickly close the modal            
            let selectedRow = selectedRows[0];
            component.set('v.displaySpinner', true);

            setTimeout(function() { 
                let evt = component.getEvent('selectedPartnerEvent');
                let selectedPartner = helper.buildSelectedPartner(component, selectedRow);

                evt.setParams({ 
                    selectedPartner: selectedPartner
                });
                evt.fire();

                component.find('overlayLibPartner').notifyClose(); 
            }, 500);
        }
    }
})