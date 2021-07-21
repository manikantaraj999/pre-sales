({
    onInit: function(component, event, helper) {
        component.set('v.displaySpinner', true)
        var docNum = helper.getUrlParameter('c__sapDocNum')

        if (!docNum) {
            docNum = component.get('v.docNumber')
        } 
        else component.set('v.docNumber', docNum);
        
        if (!docNum) {
            component.set('v.displaySpinner', false)
            return
        }
        
        var messageType = '';
        var action = component.get('c.getDocumentsList')
        action.setCallback(this, function (response) {
            component.set('v.documentResults', response.getReturnValue().data)
            component.set('v.messages', response.getReturnValue().messages)
            component.set('v.displaySpinner', false)
        })
        action.setParams({
            docNum: docNum,
            messageType: messageType
        })
        $A.enqueueAction(action)
    },

    downloadPDF: function(component, event, helper) {
        component.set('v.displaySpinner', true);
        
        var docNum = component.get('v.docNumber');
        var messageType = event.currentTarget.dataset.messageType;

        if (!messageType) {
            component.set('v.displaySpinner', false);
            return;
        }
        var action = component.get('c.getDocumentsList');
        action.setParams({
            docNum: docNum,
            messageType: messageType 
        });

        action.setCallback(this, function (response) {
            if (response.getReturnValue()) {
                var state = response.getState();
                if (state === 'SUCCESS')
                {
                    var result = response.getReturnValue().data[0]; 
                    if (result.PDFB64String) {
                        // Create a Blob from Base64
                        var byteCharacters = atob(result.PDFB64String);
                        var byteNumbers = new Array(byteCharacters.length);
                        for (var i = 0; i < byteCharacters.length; i++) {
                            byteNumbers[i] = byteCharacters.charCodeAt(i);
                        }
                        var byteArray = new Uint8Array(byteNumbers);
                        var fileName = 'Document_' + docNum + '.pdf';
                        var link = document.createElement('a');
                        var blob = new Blob([byteArray], {
                            type: 'application/octetstream'
                        });
                        link.href = URL.createObjectURL(blob);
                        link.download = fileName;
                        link.target = '_blank';
                        document.body.appendChild(link);
                        link.click();
                    }
                    else {
                        component.set('v.messages', response.getReturnValue().messages);
                    }
                }
            }
            
            component.set('v.displaySpinner', false);
        })
        $A.enqueueAction(action);
    }
})