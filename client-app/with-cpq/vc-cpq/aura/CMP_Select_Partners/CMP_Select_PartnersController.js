({
    onInit: function(component,event,helper)
    {
        var isFinish = component.get('v.isFinish');
        
        if (isFinish) {
            component.set('v.lblFlowNavigate', $A.get("$Label.c.LBL_CPQ_Quote_SelectPartner_YesBtnFinish"));
        } else {
            component.set('v.lblFlowNavigate', $A.get("$Label.c.LBL_CPQ_Quote_SelectPartner_YesBtnNext"));
        }

        component.set('v.lblHeader', 'NA');

        component.set('v.columns', [
            {label: 'Default', fieldName: 'DefaultPartner', type: 'boolean', sortable: false},
            {label: 'Partner Name', fieldName: 'PartnerName', type: 'text', sortable: false},
            {label: 'Partner Number', fieldName: 'PartnerNumber', type: 'text', sortable: false},
            {label: 'Contact First Name', fieldName: 'ContactFirstName', type: 'text', sortable: false},
            {label: 'Contact Last Name', fieldName: 'ContactLastName', type: 'text', sortable: false},
            {label: 'House Number', fieldName: 'HouseNumber', type: 'text', sortable: false},
            {label: 'Street', fieldName: 'Street', type: 'text', sortable: false},
            {label: 'City', fieldName: 'City', type: 'text', sortable: false},
            {label: 'Region', fieldName: 'Region', type: 'text', sortable: false},     
            {label: 'Postal Code', fieldName: 'PostalCode', type: 'text', sortable: false},  
            {label: 'Country', fieldName: 'Country', type: 'text', sortable: false}
        ]);

        var action = component.get('c.getPartnerList');
        action.setCallback(this, function (response) {
            helper.handleResponse(component, event, helper, 'getPartnerList', response, null, null, 
                function(data) {
                    var partnerData;
                    var currentPartnerNumber;
                    if (data) 
                    {
                        data = JSON.parse(data);
                        partnerData = JSON.parse(data.results);
                        component.set('v.lblHeader', data.partnerLabel);
                        currentPartnerNumber = data.currentPartnerNumber;

                        if (partnerData != null)
                        {
                            component.set('v.partnerList', partnerData);
                            if (partnerData.length == 1 && component.get('v.autoPickSingle'))
                            {
                                component.set('v.allowButtons', false);
                                component.set('v.partnerListSelected', partnerData[0]);
                                component.set('v.isSelected', true);
                                var labelReference = $A.get("$Label.c.LBL_Auto_Selected_Single_Option");
                                var autoSelect = {message: labelReference, messageType: "INFO"};
                                component.set('v.messages', autoSelect);
                                window.setTimeout(
                                    $A.getCallback(function() {
                                        helper.flowNavigateHelper(component, event, helper);
                                    }), 3000
                                );
                            } else {
                                helper.setSelectedPartner(component, partnerData, currentPartnerNumber);
                            }
                        }            
                        else //nothing returned from Apex call`
                        {
                            var labelReference = $A.get("$Label.c.LBL_Error_NoResponse");
                            var noResponse = {message: labelReference, messageType: "ERROR"};
                            component.set('v.messages', noResponse);
                        }
                        component.superRerender();
                        component.set('v.displaySpinner', false);
                    }
                }
            );
        })
        action.setParams({
            quoteId: component.get('v.quoteId'), 
            partnerField: component.get('v.partnerField')
        });
        $A.enqueueAction(action);
    },

    handleRowSelection: function (component, event, helper) {

        if (component.get('v.allowButtons')) {
            var selectedRows = event.getParam('selectedRows');
            if(selectedRows.length>0)
            {
                component.set('v.partnerListSelected', selectedRows[0]);
                component.set('v.isSelected', true);
            }
        }
    },

    clearPartnerValues:  function(component, event, helper)
    {
        // PartnerNumber, PartnerName, ContactFirstName, ContactLastName, Country, Region, HouseNumber, Street, City, PostalCode (inside partnerListSelected) 
        component.set('v.partnerListSelected', null);
        component.set('v.isSelected', false);
    },

    flowNavigate: function(component, event, helper)
    {     
        helper.flowNavigateHelper(component, event, helper);
    }
})