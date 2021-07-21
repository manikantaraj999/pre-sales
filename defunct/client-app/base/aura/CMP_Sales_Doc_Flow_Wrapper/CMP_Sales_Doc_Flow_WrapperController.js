({
    init: function(component, event, helper) {
        let pageState = component.get('v.pageReference').state;

        $A.createComponent('lightning:flow', null, function(content, status) {
            if (status === 'SUCCESS') {
                component.find('overlayLib').showCustomModal({
                    body: content,
                    showCloseButton: true,
                    closeCallback: function() {
                        let navService = component.find('navService');
                        let pageReference = {
                            type: 'standard__recordPage',
                            attributes: {
                                recordId: pageState.c__SF_Record_Id,
                                actionName: 'view'
                            }
                        };
                        navService.navigate(pageReference);
                    }
                })

                let flowVariables = [];
                if (pageState.c__SF_Record_Id) flowVariables.push({name: 'recordId', type: 'String', value: pageState.c__SF_Record_Id});
                if (pageState.c__SAP_DocNum) flowVariables.push({name: 'initialSAPDocumentId', type: 'String', value: pageState.c__SAP_DocNum});
                if (pageState.c__SAP_DocType) flowVariables.push({name: 'selectedDocFlowType', type: 'String', value: pageState.c__SAP_DocType});
                if (pageState.c__SF_DocDetailFlowName) {
                    content.startFlow(pageState.c__SF_DocDetailFlowName, flowVariables);
                } else {
                    content.startFlow('ensxapp__SAP_Sales_Document_Details', flowVariables);
                }
            }
        })
    }
})