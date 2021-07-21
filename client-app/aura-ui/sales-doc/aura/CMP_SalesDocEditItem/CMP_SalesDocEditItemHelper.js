({
    getItemCategories: function(component, helper) {
        return new Promise(function(resolve, reject) {
            let fieldSettings = component.get('v.fieldSettings');
            if (fieldSettings.ItemCategory.display) {
                console.log('get item categories');
                let action = component.get('c.getItemCategories');
                action.setParams({
                    salesDetail: component.get('v.salesDocDetail.SALES'),
                    material: component.get('v.item.Material')
                });
                action.setCallback(this, function(res) {
                    console.log('return item categories');
                    helper.handleResponse(component, action.getName(), res, resolve, reject,
                        function(data) {
                            if (data) {
                                let itemCategories = data.ET_VALUES_List.filter(item => item.VALUE);
                                component.set('v.itemCategories', itemCategories);
                            }
                        }
                    )
                })

                $A.enqueueAction(action);
            }
            else resolve(true);
        })
    },

    validateItem: function(item) {
        let isValid = true;
        let message = '';

        if (item.AlternativeItem && isNaN(item.AlternativeItem)) {
            message += $A.get('$Label.c.Enosix_SalesDoc_Message_InvalidAlternativeItem');
            isValid = false;
        } 

        if (!isValid) this.showToast(message);

        return isValid;
    },

    showToast: function(message) {
        var toastEvent = $A.get("e.force:showToast");
        
        toastEvent.setParams({
            message: message,
            type: 'error',
            mode: "dismissible"
        });
        toastEvent.fire();
    },

    simulateSalesDoc: function(component, salesDocDetailItem, itemNumber, helper) {
        return new Promise(function(resolve, reject) {
            console.log('simulate salesDoc in item');

            let action = component.get('c.simulateSalesDoc');
            action.setParams({
                salesDocDetail: salesDocDetailItem,
                appSettings: component.get('v.appSettings')
            })
            action.setCallback(this, function(res) {
                console.log('return simulate salesDoc in item');
                let response = res.getReturnValue();   

                if (response && response.data) {           
                    let salesDocItem = response.data.ITEMS.find(item => item.ItemNumber === itemNumber);
                    salesDocItem.showSimulateItemWarning = true;

                    // Copy the current item AlternativeItem
                    let currentItem = component.get('v.item');
                    salesDocItem.AlternativeItem = currentItem.AlternativeItem.padStart(6, '0');

                    component.set('v.item', salesDocItem);
                    component.set('v.messages', response.messages);
                    component.set('v.enableItemSimulate', false);
                }
                else {
                    component.set('v.messages', response.messages);
                }

                resolve(true);
            });

            $A.enqueueAction(action);
        })
    },

    itemChanged: function(component) {
        if (component.get('v.isEditItemInitialized')) {
            component.set('v.enableItemSimulate', true);
            component.set('v.item.isChanged', true);
        }        
    },

    prepareSimulate: function(component, event, helper) {
        let item = component.get('v.item');
        let salesDocDetail = component.get('v.salesDocDetail');
        let salesDocDetailItem = Object.assign({}, salesDocDetail);
        let copyItem = Object.assign({}, item);

        if (copyItem.AlternativeItem != '000000') copyItem.AlternativeItem = '';
        salesDocDetailItem.ITEMS = [copyItem];

        component.set('v.displaySpinner', true);
        helper.simulateSalesDoc(component, salesDocDetailItem, item.ItemNumber, helper)
            .then($A.getCallback(function() {
                component.set('v.displaySpinner', false);
            }));
    },

    onFieldChange: function(component, event, helper) {
        let inputName = event.getSource().get('v.name');
        let appSettings = component.get('v.appSettings');
        let fieldSettings = component.get('v.fieldSettings');
        let field = fieldSettings[inputName];

        if (appSettings.autoSimulate.afterFieldUpdate && (field && field.simulate)) {
            console.log('field changed, do simulate');
            helper.prepareSimulate(component, event, helper);
        }
    },

    handleResponse: function (component, method, response, resolve, reject, dataFunction)
    {
        let state = response.getState();
        if (state === "SUCCESS") {
            let returnValue = response.getReturnValue();
            if (returnValue) {
                let messages = returnValue.messages;
                if (messages && messages.length > 0) {
                    let vMessages = component.get('v.messages');
                    if (!vMessages) vMessages = [];
                    vMessages.push(...messages);
                    component.set('v.messages', vMessages);
                }
                if (dataFunction) dataFunction(returnValue.data);
            }
            if (resolve) resolve(true);
        } 
        else {
            let messages = [];
            messages.push({message: 'There was an error in CTRL_SalesDocCreateUpdate.' + method, messageType: "ERROR"});

            let errors = response.getError();
            if (errors) {
                for (let errCnt in errors) {
                    let fieldErrors = errors[errCnt].fieldErrors;
                    if (fieldErrors) {
                        messages.push({message: fieldErrors, messageType: "ERROR"});
                    }
                    let pageErrors = errors[errCnt].pageErrors;
                    if (pageErrors) {
                        for (let pageCnt in pageErrors) {
                            messages.push({message: pageErrors[pageCnt].message, messageType: "ERROR"});
                        }
                    }
                    let message = errors[errCnt].message;
                    if (message) {
                        messages.push({message: message, messageType: "ERROR"});
                    }
                }
            }
            let vMessages = component.get('v.messages');
            if (!vMessages) vMessages = [];
            vMessages.push(...messages);
            component.set('v.messages', vMessages);
            if (reject) reject('There was an error in CTRL_SalesDocCreateUpdate.' + method);
        }
    }
})