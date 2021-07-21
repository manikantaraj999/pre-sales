({
    onInit: function(component, event, helper) {
        helper.buildColumns(component);
        component.set('v.searchParams.customerNumber', component.get('v.customerNumber'));

        if (component.get('v.autoSearch')) {
            component.set('v.displaySpinner', true);
            helper.search(component, component.get('v.pagingOptions'))
                .then($A.getCallback(function() {
                    component.set('v.displaySpinner', false);
                }))
        }
    },

    onPagerChanged: function(component, event, helper) {
        component.set('v.displaySpinner', true);
        helper.search(component, event.getParam('options'))
            .then($A.getCallback(function() {
                component.set('v.displaySpinner', false);
            }))
    },

    onClickSearch: function(component, event, helper) {
        component.set('v.displaySpinner', true);
            helper.search(component, component.get('v.pagingOptions'))
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

            let selectedCustomer = {  
                PartnerName: selectedRow.Name + (selectedRow.Name2 ? ' ' + selectedRow.Name2 : ''),
                PartnerFunctionName: component.get('v.partnerFunctionName'),
                PartnerFunction: component.get('v.partnerFunction'),
                Street: selectedRow.Street,
                City: selectedRow.City,
                PostalCode: selectedRow.PostalCode,
                Region: selectedRow.Region,
                Country: selectedRow.CountryKey
            }

            let searchType = component.get('v.searchType');

            if (searchType === 'Contact') {
                selectedCustomer.ContactPersonNumber = selectedRow.CustomerNumber;
            }
            else if (searchType === 'Personnel') {
                selectedCustomer.PersonnelNumber = selectedRow.CustomerNumber;
            }
            else if (searchType === 'Vendor') {
                selectedCustomer.Vendor = selectedRow.CustomerNumber;
            }
            else selectedCustomer.CustomerNumber = selectedRow.CustomerNumber;

            setTimeout(function() { 
                let evt = component.getEvent('selectedCustomerEvent');

                evt.setParams({ 
                    selectedCustomer: selectedCustomer
                });
                evt.fire();

                component.find('overlayLibPartner').notifyClose(); 
            }, 500);
        }
    }
})