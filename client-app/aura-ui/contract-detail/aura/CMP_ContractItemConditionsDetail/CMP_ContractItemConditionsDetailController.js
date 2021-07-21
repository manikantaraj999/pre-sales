({
    onInit : function(component, event, helper){
        component.set('v.ItemConditions', null);
        var data = component.get('v.data');
        if (data) {
            let parsedData = JSON.parse(data);
            component.set('v.ItemConditions', parsedData.conditions);
        }
    }
})