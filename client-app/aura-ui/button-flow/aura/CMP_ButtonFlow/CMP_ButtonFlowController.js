({
    onSelectButtonFlow: function(component, event, helper) {
        let flowName = component.get('v.buttonFlow');
        
        let flowInputParams = [
            {name: 'recordId', type: 'String', value: component.get('v.recordId')}
        ];
        
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
})