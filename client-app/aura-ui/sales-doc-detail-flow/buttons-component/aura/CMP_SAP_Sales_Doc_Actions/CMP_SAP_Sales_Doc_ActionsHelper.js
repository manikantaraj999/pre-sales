({
    getDetail: function(component, helper) {
        return new Promise(function(resolve, reject) {

            let docNum = component.get('v.SAPDocNum');
            let action = component.get('c.getDetail');
            action.setParams({
                docNum: docNum
            })
            action.setCallback(this, function(res) {
                let result = res.getReturnValue();
                if (result && result.data) {
                    switch(result.data.TransactionGroup){
                        case '0':
                            component.set('v.SAPDocType', helper.orderDocumentCategory(result.data.DocumentCategory));
                            break;
                        case '1':
                            component.set('v.SAPDocType', 'Inquiry');
                            break;
                        case '2':
                            component.set('v.SAPDocType', 'Quote');
                            break;
                        case '4':
                            component.set('v.SAPDocType', 'Contract');
                            break;
                        default:
                            break;
                    }
                }
                resolve(true);
            })

            $A.enqueueAction(action);
        })
    },

    orderDocumentCategory: function(documentCategory) {
        let sapDocType;

        switch(documentCategory){
            case 'H':
                sapDocType = 'Return Order';
                break;
            case 'K':
                sapDocType = 'Credit Memo';
                break;
            case 'L':
                sapDocType = 'Debit Memo';
                break;
            default:
                sapDocType = 'Order';
                break;
        }

        return sapDocType;
    },

    getButtons: function(component, helper) {
        return new Promise(function(resolve, reject) {
            var action = component.get("c.getButtons");
            action.setCallback(this, function (response) {
                helper.handleResponse(component, event, helper, 'getButtons', response, 
                    function (data) {
                        if (data) {
                            component.set('v.buttonList', data);
                        }
                        resolve(true);
                    }
                );
            });
            action.setParams({
                SFRecordId: component.get('v.SFRecordId'),
                SAPDocNum: component.get('v.SAPDocNum'),
                SAPDocType: component.get('v.SAPDocType'),
                allowBackToLinkedObject: component.get('v.allowBackToLinkedObject'),
                allowBackToAccount: component.get('v.allowBackToAccount'),
                allowBackToOpportunity: component.get('v.allowBackToOpportunity'),
                allowClone: component.get('v.allowClone'),
                allowUpdate: component.get('v.allowUpdate'),
            })

            $A.enqueueAction(action);
        })
    },

    handleResponse: function (component, event, helper, method, response, dataFunction) {
        var state = response.getState();
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
            }
        } else {
            var messages = [];
            messages.push({message: 'There was an error in CTRL_SAP_Order.' + method, messageType: "ERROR"});

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
    }});