({
    onInit : function(component, event, helper) {
        var itemJSONString = component.get('v.itemJSON');
        var item;
        if (itemJSONString) {
            item = JSON.parse(itemJSONString);
            component.set("v.orderQuantity", item.OrderQuantity);
        } else
        {
            component.set("v.orderQuantity", 1);
        }
    },

    flowNavigate: function(component)
    {   
        //set the value
        var itemJSONString = component.get('v.itemJSON');
        var item;
        if (itemJSONString) {
            item = JSON.parse(itemJSONString);
            item.OrderQuantity = parseFloat(component.get("v.orderQuantity"));
        } else
        {
            item = {
                materialNumber:component.get('v.itemId'),
                OrderQuantity: parseFloat(component.get('v.orderQuantity')),
                selectedCharacteristics : []
            }
        }

        component.set('v.itemJSON', JSON.stringify(item));

        //nav to the next step
        var isFinish = component.get('v.isFinish');
        var navigate = component.get("v.navigateFlow");
        
        if(isFinish)
        {
            navigate("FINISH");
        } else
        {
            navigate("NEXT");
        }
    }
})