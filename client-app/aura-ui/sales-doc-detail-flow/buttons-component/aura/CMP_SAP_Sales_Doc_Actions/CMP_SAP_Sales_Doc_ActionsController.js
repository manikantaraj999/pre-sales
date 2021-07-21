({
    doInit: function (component, event, helper) {
        component.set("v.displaySpinner", true);
        helper.getDetail(component, helper)
            .then($A.getCallback(function() {
                return helper.getButtons(component, helper);
            }))
            .then($A.getCallback(function() {
                component.set('v.displaySpinner', false);
            }))
    },

    handleClickForButton: function(component, event, helper) {
        let navService = component.find("navigationService");
        let value = event.getSource().get("v.name");
        let selectedButton = component.get('v.buttonList').find(button => button.Value == value);

        if (selectedButton.SAPDocType) {
            // Go To SalesDoc flow
            let flowName = '';

            switch(selectedButton.SAPDocType) {
                case 'Order':
                    flowName = 'enosiX_Sales_Document_Create_Order';
                    break;
                case 'Quote':
                    flowName = 'enosiX_Sales_Document_Create_Quote';
                    break;
                case 'Contract':
                    flowName = 'enosiX_Sales_Document_Create_Contract';
                    break;
                case 'Inquiry':
                    flowName = 'enosix_Sales_Document_Create_Inquiry';
                    break;
                case 'Credit Memo':
                    flowName = 'enosix_Sales_Document_Create_CreditMemo';
                    break;
                case 'Debit Memo':
                    flowName = 'enosix_Sales_Document_Create_DebitMemo';
                    break;
                case 'Return Order':
                    flowName = 'enosix_Sales_Document_Create_ReturnOrder';
                    break;
                default:
                    break;
            }

            let flowInputParams = [
                {name: 'recordId', type: 'String', value: component.get('v.SFRecordId')},
                {name: 'sapDocNumber', type: 'String', value: component.get('v.SAPDocNum')}];

            if (selectedButton.Value === 'Clone') {
                flowInputParams.push({name: 'isClone', type: 'Boolean', value: true});
            }
            else if (selectedButton.Value === 'Update') {
                flowInputParams.push({name: 'isUpdate', type: 'Boolean', value: true});
            }
            
            $A.createComponent("lightning:flow", {},
                function (content, status) {
                    if (status === "SUCCESS") {
                        component.find('overlayLib').showCustomModal({
                            showCloseButton: true,
                            body: content
                        }).then((overlay) => {
                            component.find('overlayLib').notifyClose();
                            content.startFlow(flowName, flowInputParams)
                        })                        
                    }

                })
        }
        else {
            // Go To Record Page
            navService.navigate(JSON.parse(selectedButton.PageReference));
        }        
    }
})