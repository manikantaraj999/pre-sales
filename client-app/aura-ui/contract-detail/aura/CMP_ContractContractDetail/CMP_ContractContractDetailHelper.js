({    
    refresh: function (component, event, helper) {
        let docNum = window.getUrlParameter('c__sapDocNum');
        if (docNum) {
            component.set('v.sapDocumentId', docNum);
        } else {
            docNum = component.get('v.sapDocumentId');
        }
        if (!docNum) {
            component.set('v.displaySpinner', false);
            return;
        }

        let recordId = window.getUrlParameter('c__recordId');
        if (recordId) {
            component.set('v.recordId', recordId);
        } else {
            recordId = component.get('v.recordId');
        }

        component.set('v.displaySpinner', true);
        component.find("dataSource").getContractDetail(docNum, function (result) {
            let data = result.data;
            component.set('v.contractDetail', data);
            component.set('v.messages', result.messages);
            component.set('v.displaySpinner', false)
        });
    }
})