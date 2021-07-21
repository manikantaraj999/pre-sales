({
    onInit : function(component, event, helper) {
        helper.getMaterial(component);

        component.set('v.columns', [                
            
            {label: 'Plant Name', fieldName: 'label', type: 'text', sortable: false},
            {label: 'Plant Number', fieldName: 'value', type: 'text', sortable:false}
        ]);



    },

    handleRowSelection: function (component, event, helper) {

        var selectedRows = event.getParam('selectedRows');
        if(selectedRows.length>0)
        {
            var selectedPlant = selectedRows[0].value;
            component.set('v.plantNumber', selectedPlant);
            component.set('v.plantName', selectedRows[0].label);
        

            component.set('v.isPlantSelected', true);
        }
    },

    plantReset: function(component,event,helper)
    {
        component.set('v.plantNumber', null);
        component.set('v.plantName', null);
    
        component.set('v.isPlantSelected', false);

    },

    flowNavigate: function(component)
    {   
        //set the value
        var itemJSONString = component.get('v.itemJSON');
        var item;
        if (itemJSONString) {
            item = JSON.parse(itemJSONString);
            item.plant = component.get("v.plantNumber");
            item.materialNumber = component.get('v.itemId');
        } else
        {
            item = {
                materialNumber:component.get('v.itemId'),
                plant: component.get('v.plantNumber'),
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
        }else
        {
            navigate("NEXT");
        }
    },

    navigatePrevious: function(component)
    {
        component.set('v.resetSalesArea', false);
        var navigate = component.get("v.navigateFlow");
        navigate("BACK");
    }

})