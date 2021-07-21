({
    init : function (component) {
        var flow = component.find("cpqFlow");
        var flowVariables = [
            {name : 'quoteId', type:'String', value: component.get('v.quoteId')},
            {name : 'itemId', type:'String', value: component.get('v.itemId')},
            {name : 'itemJSON', type:'String', value: component.get('v.itemJSON')},
            {name : 'headerJSON', type:'String', value: component.get('v.headerJSON')},
            {name : 'addedItemsJSON', type:'String', value: component.get('v.addedItemsJSON')},
            {name : 'enterPlant', type:'Boolean', value: component.get('v.enterPlant')},
            {name : 'enterQuantity', type:'Boolean', value: component.get('v.enterQuantity')}
        ]

        // In that component, start your flow. Reference the flow's Unique Name.
        flow.startFlow("cpqVCFlow", flowVariables);
    },

    handleStatusChange: function(component, event)
    {
        var status = event.getParam('status');
        var outputVariables = event.getParam('outputVariables');

        if(status === 'FINISHED')
        {
            //loop through outputVariables to get values to set to component attributes
            var cpqMsg = component.get('v.cpqMsg');
            var headerJSON = component.get('v.headerJSON');
            var itemJSON = component.get('v.itemJSON');
            var addedItems = component.get('v.addedItemsJSON');
            for(var i = 0; i < outputVariables.length; i++) 
            {
                var outputVar = outputVariables[i];

                if(outputVar.name == 'itemJSON')
                {
                    component.set('v.itemJSON', outputVar);
                    itemJSON = outputVar.value;
                }
                if(outputVar.name == 'headerJSON')
                {
                    component.set('v.headerJSON', outputVar);
                    headerJSON = outputVar.value;
                }
                if(outputVar.name == 'cpqMsg')
                {
                    component.set('v.cpqMsg', outputVar);
                    cpqMsg = outputVar.value;
                }
                if(outputVar.name == 'addedItemsJSON')
                {
                    component.set('v.addedItemsJSON', outputVar);
                    addedItems = outputVar.value;
                }
            }

            ///write back to VFP, close flow window
            cpqMsg = JSON.parse(cpqMsg);
            headerJSON = JSON.parse(headerJSON);
            itemJSON = JSON.parse(itemJSON);
            if (addedItems && addedItems != '') addedItems = JSON.parse(addedItems);

            var newCpqMsg = cpqMsg;
            newCpqMsg.data.header = headerJSON;
            newCpqMsg.data.item = itemJSON;
            newCpqMsg.data = Object.assign({'addedItems': addedItems}, newCpqMsg.data);

            var msgString = JSON.stringify(newCpqMsg);
            component.set('v.cpgMsg', msgString);

            var finishEVT = $A.get("e.c:EVT_CPQ_Flow_Finished");
            finishEVT.setParam("quoteId", component.get('v.quoteId'));
            finishEVT.setParam('cpqMsg', msgString);
            finishEVT.fire();
            component.destroy();
        }        
    }
})