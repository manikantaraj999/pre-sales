({
    init: function (component, event, helper) {
        var recordId = component.get('v.recordId');
        if (recordId) {
            component.set("v.displaySpinner", true);
            var action = component.get("c.init");
            action.setCallback(this, function (response) {
                helper.handleResponse(component, event, helper, 'init', response, 
                    function (data) {
                        if (data) {
                            helper.sapOrder(component, event, helper);
                        }
                        component.set('v.displaySpinner', false);
                    }
                );
            });
            action.setParams({
                recordId: recordId,
                sapType: 'Order'
            })
            $A.enqueueAction(action);
        }
    },

    sapOrder: function(component, event, helper)
    {
        var navService = component.find("navService");
        var pageReference = {
            type: 'standard__webPage',
            attributes: {
                url: '/apex/VFP_Router?c__ENSX_Page=VFP_OrderCreateUpdate&' + 
                    'c__SAP_Mode=SAP_ModeOrder&' + 
                    'c__SF_CPQQuoteId=' + component.get('v.recordId')
            }
        };
        navService.navigate(pageReference);
    },

    handleResponse: function (component, event, helper, method, response, dataFunction) {
        var state = response.getState();
        component.set('v.displaySAPButton', false);
        component.set('v.displaySpinner', false);
        if (state === "SUCCESS") {
            var returnValue = response.getReturnValue();
            if (returnValue) {
                var messages = returnValue.messages;
                if (messages && messages.length > 0) {
                    var vMessages = component.get('v.messages');
                    vMessages.push(...messages);
                    component.set('v.messages', vMessages);
                }
                if (dataFunction) dataFunction(returnValue.data);
                component.set('v.displaySAPButton', true);
            }
        } else {
            var messages = [];
            messages.push({message: 'There was an error in CTRL_SAP_Doc_Validate.' + method, messageType: "ERROR"});

            var errors = response.getError();
            if (errors) {
                for (var errCnt = 0; errCnt < errors.length; errCnt++) {
                    var fieldErrors = errors[errCnt].fieldErrors;
                    if (fieldErrors && message) {
                        messages.push({message: fieldErrors, messageType: "ERROR"});
                    }
                    var pageErrors = errors[errCnt].pageErrors;
                    if (pageErrors) {
                        for (var pageCnt = 0; pageCnt < pageErrors.length; pageCnt++) {
                            messages.push({message: pageErrors[pageCnt].message, messageType: "ERROR"});
                        }
                    }
                    var message = errors[errCnt].message;
                    if (message) {
                        messages.push({message: message, messageType: "ERROR"});
                    }
                }
            }
            var vMessages = component.get('v.messages');
            vMessages.push(...messages);
            component.set('v.messages', vMessages);
        }
    }
});