({
    // Retrieve material detail from SAP using v.itemJSON.materialNumber
    //   Display plants that match v.headerJSON.salesOrg and v.headerJSON.distChannel
    getMaterial: function(component) {

        var materialNumber = component.get('v.itemId');
        if (!materialNumber) {
            return;
        }

        var headerJSONString = component.get('v.headerJSON');
        if(headerJSONString)
        {
            var header = JSON.parse(headerJSONString);
            var salesOrg = header && header.salesOrg;
            var distChannel = header && header.distChannel;
        }

        var itemJSONString = component.get('v.itemJSON');
        if(itemJSONString)
        {
            var item = JSON.parse(itemJSONString);

            var plantNumber = item && item.plant;
        }

        var action = component.get("c.getMaterial");
        action.setParam("materialNumber", materialNumber);
        action.setCallback(this, function(response) {
            component.set("v.busy", false);
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                component.set("v.messages", result && result.messages);
                component.set("v.material", result && result.data);
                component.set("v.title", result && result.data && (result.data.Material + ': ' + result.data.MaterialDescription))
                var plantOptions = [];
                if (result && result.data && result.data.PLANT_DATA && result.data.PLANT_DATA.asList) {
                        result.data.PLANT_DATA.asList.forEach(function (plant) {
                            if (plant && plant.Plant && salesOrg === plant.SalesOrganization && distChannel === plant.DistributionChannel) {
                                plantOptions.push({"label": plant.Name + " (" + plant.Plant + ")", "value": plant.Plant});
                                if (plantNumber && plantNumber === plant.Plant) {
                                    component.set("v.plantNumber", plantNumber);
                                    component.set('v.isPlantSelected', true);
                                }
                            }
                        })
                }

                if(plantOptions.length == 0)
                {
                    component.set('v.resetSalesArea', true);
                }

                component.set("v.plantOptions", plantOptions);
            } else {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        component.set('v.busy', true);
        $A.enqueueAction(action);
    }
})