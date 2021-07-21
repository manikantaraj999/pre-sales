({
    onInit: function(component, event, helper) {
		debugger;
        let recordId = component.get('v.recordId');
        if (!recordId) {
            component.set('v.messages', {messageType: 'ERROR', message: $A.get('$Label.c.Enosix_SalesDoc_Message_RecordIdNotFound')});
            component.set('v.displaySpinner', false);
            return;
        }

        let isValid = true;

        helper.loadAppSettings(component)
            .then($A.getCallback(function(res) {
                return helper.initSFObject(component, recordId, helper);
            }))
            .then(
                $A.getCallback(
                    function() {
                        console.log('resolve initSFObject');
                        return helper.getCustomerDetail(component, helper);
                    }
                ),function() {
                    console.log('reject initSFObject');
                    isValid = false;
                    return Promise.reject();
                }
            )
            .then($A.getCallback(function() {
                let sapDocNumber = component.get('v.sapDocNumber');
                let isUpdate = component.get('v.isUpdate');
                let isClone = component.get('v.isClone');

                if (sapDocNumber) {
                    if (isUpdate) {
                        return helper.getSalesDocDetail(component, sapDocNumber, helper);
                    }
                    else if (isClone) {
                        return helper.getReferenceDocument(component, sapDocNumber, helper);
                    }
                }
                else {
                    helper.setInitSalesDocFromCustomer(component, helper);
                    return helper.setSalesDocFromSobject(component, helper);
                }
            }))
            .then($A.getCallback(function() {
                helper.getFieldSettings(component);
                helper.validateSalesAreaAfterLoad(component, helper)
            }))
            .then($A.getCallback(function(res) {
                // Call to RFCs here
                helper.getShipInfo(component, helper);
                helper.getPricingStat(component, helper);
                helper.getBillingPlans(component, helper);
                helper.getGroupOffice(component, helper);
                return helper.getRejectionReasons(component, helper);
            }))
            .then($A.getCallback(function() {
                return helper.simulateSalesDoc(component, helper);
            }))
            .then($A.getCallback(function() {
                console.log('return from resolve');
                helper.getConditions(component, true, helper);
                return helper.getConditions(component, false, helper);
            }),function() {
                console.log('return from reject');
                component.set('v.hasConditions', false);
            })
            .then($A.getCallback(function(){
                console.log('all finish');

                if (isValid && component.get('v.appSettings')) {
                    component.set('v.isSalesDocValid', true);
                    component.set('v.isSalesDocInitialized', true);

                    let fieldSettings = component.get('v.fieldSettings');
                    let sfObject = component.get('v.sfObject');
                    if (fieldSettings.autoInvoke && (sfObject.status === 'Create' || sfObject.status === 'Update')) {
                        // Automatically invoke SAP Create/Update if it's set to true
                        return helper.create(component, helper);
                    }
                }
                return Promise.resolve(); 
            }))
            .then($A.getCallback(function() {
                console.log('final resolve');
                component.set('v.displaySpinner', false);
            }))
    },

    // Adding material from the input textbox
    addMaterial: function(component, event, helper) {
        helper.addByMaterialNumber(component, event, helper);
    },

    addMaterials: function(component, event, helper) {
        $A.createComponent("c:CMP_MaterialSearch", {
                'salesOrganization': component.get('v.salesDocDetail.SALES.SalesOrganization'),
                'distributionChannel': component.get('v.salesDocDetail.SALES.DistributionChannel'),
                'isScheduleDateEnabled': false,
                'isMaterialTypesDisplayed': false,
                'isAutoSearchEnabled': false,
            },
            function (content, status) {
                content.addEventHandler('selectMaterialsEvent',
                    component.getReference('c.onReceiveMaterials'));
                if (status === "SUCCESS") {
                    component.find('overlayLib1')
                        .showCustomModal({
                            header: $A.get('$Label.c.Enosix_SalesDoc_Title_MaterialSearch'),
                            body: content,
                            showCloseButton: true,
                            cssClass: "slds-modal_large",
                            closeCallback: function () {

                            }
                        })
                }
            });
    },

    onReceiveMaterials: function(component, event, helper) {
        let selectedItems = event.getParam('selectedItems');
        let itemsJSON = JSON.parse(selectedItems);
        helper.addMaterials(component, helper, itemsJSON, null);
    },

    onFinalizeConfiguration: function(component, event, helper) {
        console.log('finalize configuration');
        let characteristics = event.getParam('finalizedConfig');
        let itemNumber = event.getParam('itemNumber');
        let isComplete = event.getParam('isComplete');
        let printedCharacteristics = event.getParam('printedCharacteristics');
        let items = component.get('v.salesDocDetail.ITEMS');
        for (let key in items) {
            if (items[key].ItemNumber === itemNumber) {
                items[key].ItemConfigurations = characteristics;
                items[key].isConfigurationFromVCComplete = isComplete;
                items[key].isNeedConfigure = false;
                if (printedCharacteristics && printedCharacteristics.length) {
                    items[key].PrintedCharacteristics = printedCharacteristics;
                }
                break;
            }
        }
        component.set('v.salesDocDetail.ITEMS', items);
        component.set('v.messages', []);
        let appSettings = component.get('v.appSettings');

        if (appSettings.autoSimulate.afterItemConfiguration) {
            component.set('v.displaySpinner', true);
            helper.simulateSalesDoc(component, helper)
                .then($A.getCallback(function() {
                    component.set('v.displaySpinner', false);
                }), function() {
                    component.set('v.displaySpinner', false);
                })
        }
    },

    onCancelClick: function(component, event, helper) {
        if(component.get('v.isConfigurationChanged')){
            component.set('v.exitWithoutSavingAlertModalWindowIsActive', true);
        } else {
            helper.navigateToDetail(component);
        }
    },

    updateItem: function(component, event, helper) {
        let isItemEdited = event.getParam('isItemEdited');
        let item = event.getParam('item');
        if (isItemEdited) {
            let lineItems = component.get('v.salesDocDetail.ITEMS');
            for (let key in lineItems) {
                let lineItem = lineItems[key];
                if (lineItem.ItemNumber === item.ItemNumber) {
                    lineItems[key] = item;
                    break;
                }
            }
            component.set('v.salesDocDetail.ITEMS', lineItems);
            component.set('v.messages', []);

            let appSettings = component.get('v.appSettings');

            if (appSettings.autoSimulate.afterItemEditSave) {
                component.set('v.displaySpinner', true);
                helper.simulateSalesDoc(component, helper)
                    .then($A.getCallback(function() {
                        console.log('simulate click resolve');
                        component.set('v.displaySpinner', false);
                    }), function() {
                        console.log('simulate click reject');
                        component.set('v.displaySpinner', false);
                    })
            }
        }
    },

    onSimulateClick: function(component, event, helper) {
        component.set('v.displaySpinner', true);
        component.set('v.messages', []);

        helper.simulateSalesDoc(component, helper)
            .then($A.getCallback(function() {
                console.log('simulate click resolve');
                component.set('v.displaySpinner', false);
            }), function() {
                console.log('simulate click reject');
                component.set('v.displaySpinner', false);
            })
    },

    onSalesAreaChange: function(component, event, helper) {
        helper.onSalesAreaChange(component, event, helper);
    },

    onSalesOfficeChange: function(component, event, helper) {
        let salesDocDetail = component.get('v.salesDocDetail');
        helper.onSalesOfficeChange(component, helper, salesDocDetail);
        component.set('v.salesDocDetail', salesDocDetail);
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
            let inputName = event.getSource().get('v.name');
            if ((inputName === 'salesOrg' || inputName === 'distChannel' || inputName === 'divison')) {
                helper.onSalesAreaChange(component, event, helper);
            }
            else {
                helper.onFieldChange(component, event, helper);
            }
        }
        component.set('v.onFocusInputValue', null);
    },

    onSelectedSerial: function(component, event, helper) {
        let selectedSerial = event.getParam('selectedSerial');
        if (selectedSerial && selectedSerial.material) {

            let materials = [{
                material: selectedSerial.material,
                quantity: 1
            }];

            helper.addMaterials(component, helper, materials, selectedSerial);
        }
    },

    onCreate: function(component, event, helper) {
        helper.create(component, helper);
    },

    onSave: function(component, event, helper) {
        component.set('v.displaySpinner', true);
        component.set('v.messages', []);

        helper.simulateSalesDoc(component, helper)
            .then($A.getCallback(function() {
                return helper.saveToSObject(component, helper);
            }))
            .then($A.getCallback(function() {
                console.log('success save');
                helper.navigateToDetail(component);
            }), function() {
                console.log('reject save');
                component.set('v.displaySpinner', false);
            });
    },

    onReceivePartner: function(component, event, helper) {
        let appSettings = component.get('v.appSettings');
        component.set('v.messages', []);

        if (appSettings.autoSimulate.afterPartnerSelection) {
            component.set('v.displaySpinner', true);
            helper.simulateSalesDoc(component, helper)
                .then($A.getCallback(function() {
                    console.log('simulate resolve');
                    component.set('v.displaySpinner', false);
                }), function() {
                    console.log('simulate reject');
                    component.set('v.displaySpinner', false);
                })
        }
    },

    onLineItemChange: function(component, event, helper) {
        helper.checkSalesDocDetailChanged(component);
    },

    onConditionValueChange: function(component, event, helper) {
        helper.checkSalesDocDetailChanged(component);
    },

    onChangeSalesDocDetail: function(component, event, helper) {
        helper.checkSalesDocDetailChanged(component);
    },

    onChangeHeaderCondition: function(component, event, helper) {
        helper.checkSalesDocDetailChanged(component);
    },

    onChangeHeaderText: function(component, event, helper) {
        helper.checkSalesDocDetailChanged(component);
    },

    onClickNoExitWithoutSavingAlertModalWindow: function(component, event, helper) {
        component.set('v.exitWithoutSavingAlertModalWindowIsActive', false);
    },

    onClickYesExitWithoutSavingAlertModalWindow: function(component, event, helper) {
        helper.navigateToDetail(component);
    },

    onKeyPressMaterialNumber: function(component, event, helper) {
        if (event.code == 'Enter' && component.get('v.isSalesDocValid')) {
            helper.addByMaterialNumber(component, event, helper);
        }
    },

    handleRowActionEvent: function(component, event, helper) {
        let item = event.getParam("item");
        let actionName = event.getParam("actionName");
        helper.onRowAction(component, helper, item, actionName);
    }
})