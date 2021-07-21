({
    onInit : function(component, event, helper){
        component.set('v.itemDetail', null);
        var data = component.get('v.data');
        if (data) {
            let parsedData = JSON.parse(data);
            component.set('v.itemDetail', parsedData.itemDetail);
        }
    }
})