({
    getDetail : function(component, event, helper) {
        let params = event.getParam('arguments')
        let callback
        let docNum
        if (params) {
            callback = params.callback
            docNum = params.docNum
        }
        let action = component.get("c.getContractDetail")
        action.setCallback(this, function(response) {
            if(response.getReturnValue())
            {
                if (callback) 
                {
                    callback(response.getReturnValue())
                }
            }
            else //nothing returned from Apex call
            {
                let labelReference = $A.get("$Label.c.LBL_Error_NoResponse");
                let noResponse = {message: labelReference, messageType: "ERROR"};
                component.set('v.messages', noResponse);
            }

        })
        action.setParams({"docNum" : params.docNum})
        $A.enqueueAction(action)
    }
})