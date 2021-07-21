({
    onSelectPartnerPicker: function(component, event, helper) {
        let selectedPartner = event.getSource().get('v.name');
        let soldToParty = component.get('v.soldToParty');
        let salesArea = component.get('v.salesArea');

        let title = selectedPartner.PartnerFunctionName + ' Search';
        let attributes = {
            customerNumber : soldToParty,
            salesArea : salesArea,
            partnerFunction : selectedPartner.PartnerFunction,
            partnerFunctionName : selectedPartner.PartnerFunctionName,
            searchType : selectedPartner.SearchType,
            autoSearch : selectedPartner.autoSearch
        };

        let partnerComponent = 'c:CMP_PartnerSearch';
        let selectEventHandler ='selectedPartnerEvent';
        let onReceiveFunction = 'c.onReceivePartner';
        if (selectedPartner.ComponentType === 'CustomerSearch')
        {
            partnerComponent = 'c:CMP_CustomerSearch';
            selectEventHandler ='selectedCustomerEvent';
            onReceiveFunction = 'c.onReceiveCustomerSearch';
        }

        $A.createComponent(partnerComponent, attributes,
            function(content, status) {
                if (status === "SUCCESS") {
                    content.addEventHandler(selectEventHandler,     
                        component.getReference(onReceiveFunction));
                    component.find('overlayPartners')
                        .showCustomModal({
                            header: title,
                            body: content,
                            showCloseButton: true,
                            closeCallback: function () {}
                        })
                }
            })
    },

    onSelectPartnerAddress: function(component, event, helper) {
        let partner = event.getSource().get('v.name');
        let attributes = {
            partner : partner
        }
        let title = partner.PartnerFunctionName + ' Address';

        $A.createComponent('c:CMP_SalesDocPartnerAddress', attributes,
            function(content, status) {
                if (status === "SUCCESS") {
                    content.addEventHandler('partnerAddressSaveEvent',
                        component.getReference('c.onReceivePartnerAddress'));
                    component.find('overlayPartners')
                        .showCustomModal({
                            header: title,
                            body: content,
                            showCloseButton: true,
                            closeCallback: function () {}
                        })
                }
            })
    },

    onReceivePartnerAddress: function(component, event, helper) {
        console.log('from address override');
        let partner = event.getParam('partner');
        helper.addSelectedPartner(component, partner);
        let action = component.getEvent('receivePartnerEvent');
        action.fire();
    },

    onReceivePartner : function(component, event, helper) {
        console.log('receive partner');        
        let selectedPartner = event.getParam('selectedPartner');
        helper.addSelectedPartner(component, selectedPartner);   
        let action = component.getEvent('receivePartnerEvent');
        action.fire();
    },

    onReceiveCustomerSearch: function(component, event, helper) {
        console.log('receive contact partner');
        let selectedPartner = event.getParam('selectedCustomer');
        helper.addSelectedPartner(component, selectedPartner);
        let action = component.getEvent('receivePartnerEvent');
        action.fire();
    }
})