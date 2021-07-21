({
    setSelectedPartner: function(component, partners, currentPartnerNumber) {
        let selectedPartner;
        if (currentPartnerNumber) {
            selectedPartner = partners.find(partner => partner.PartnerNumber === currentPartnerNumber);
        }
        else {
            selectedPartner = partners.find(partner => partner.DefaultPartner);
        }

        if (selectedPartner) {
            component.set('v.partnerListSelected', selectedPartner);
            component.set('v.isSelected', true);
        }
    },

    flowNavigateHelper: function(component, event, helper)
    {     
        let selectedPartner = component.get('v.partnerListSelected');

        let partnerJSON = {
            partnerNumber: selectedPartner.PartnerNumber,
            name: selectedPartner.PartnerName,
            street: selectedPartner.Street,
            city: selectedPartner.City,
            region: selectedPartner.Region,
            postalCode: selectedPartner.PostalCode,
            country: selectedPartner.Country
        }

        var params = {
            quoteId: component.get('v.quoteId'),
            partnerField: component.get('v.partnerField'),
            partnerJSON: JSON.stringify(partnerJSON)
            };
        var action = component.get('c.updatePartner')

        action.setCallback(this, function (response) {
            helper.handleResponse(component, event, helper, 'updatePartner', response, null, null, 
                function(data) {
                    if (data) {
                        var isFinish = component.get('v.isFinish');
                        var navigate = component.get("v.navigateFlow");
                        
                        if(isFinish)
                        {
                            navigate("FINISH");
                        }else
                        {
                            navigate("NEXT");
                        }
                    }
                }
            );
        });
        action.setParams({
            params: params
        });
        $A.enqueueAction(action);    
    },

    handleResponse: function (component, event, helper, method, response, resolve, reject, dataFunction)
    {
        var state = response.getState();
        if (state === "SUCCESS") {
            var returnValue = response.getReturnValue();
            if (returnValue != undefined) {
                var messages = returnValue.messages;
                if (messages && messages.length > 0) {
                    var vMessages = component.get('v.messages');
                    vMessages.push(...messages);
                    component.set('v.messages', vMessages);
                }
                if (dataFunction !== undefined && dataFunction !== null) dataFunction(returnValue.data);
            }
            if (resolve !== undefined && resolve !== null) resolve(true);
        } else {
            var messages = [];
            messages.push({message: 'There was an error in CTRL_CPQ_Sales.' + method, messageType: "ERROR"});

            var errors = response.getError();
            if (errors) {
                for (var errCnt = 0; errCnt < errors.length; errCnt++) {
                    var fieldErrors = errors[errCnt].fieldErrors;
                    if (fieldErrors !== undefined && message != null) {
                        messages.push({message: fieldErrors, messageType: "ERROR"});
                    }
                    var pageErrors = errors[errCnt].pageErrors;
                    if (pageErrors) {
                        for (var pageCnt = 0; pageCnt < pageErrors.length; pageCnt++) {
                            messages.push({message: pageErrors[pageCnt].message, messageType: "ERROR"});
                        }
                    }
                    var message = errors[errCnt].message;
                    if (message !== undefined && message != null) {
                        messages.push({message: message, messageType: "ERROR"});
                    }
                }
            }
            var vMessages = component.get('v.messages');
            vMessages.push(...messages);
            component.set('v.messages', vMessages);
            if (reject !== undefined && reject !== null) reject('There was an error in CTRL_QuoteFinalDetails.' + method);
        }
        component.set('v.displaySpinner', false);
    }
})