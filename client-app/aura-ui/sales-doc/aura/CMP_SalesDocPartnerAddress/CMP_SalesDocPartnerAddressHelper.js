({
    getCountries: function(component) {
        return new Promise(function(resolve, reject) {
            console.log('get Countries');
            let action = component.get('c.getCountries');
            action.setCallback(this, function(res) {
                let response = res.getReturnValue();       
                if (response && response.data) {
                    let countries = response.data.ET_OUTPUT_List.filter(item => item.LAND1);
                    let allRegions = response.data.ET_REGIONS_List;
                    component.set('v.countries', countries);
                    component.set('v.allRegions', allRegions);
                }
                else {
                    component.set('v.messages', response.messages);
                }
                resolve(true);
            })

            $A.enqueueAction(action);
        })
    },

    setCountryAndRegion: function(component) {
        let partner = component.get('v.partner');
        let regions = [];

        if (partner.Country) {
            component.set('v.displaySpinner', true);
            let allRegions = component.get('v.allRegions');
            regions = allRegions.filter(region => region.LAND1 === partner.Country);
            component.set('v.regions', regions);

            setTimeout(function() {
                // This needs to wait inside a timeout because regions need to finish rendering
                if (partner.Region) {
                    let region = regions.find(reg => reg.REGIO === partner.Region);

                    if (region) {
                        partner.Region = region.REGIO;
                    }
                    else partner.Region = '';
                    component.set('v.partner', partner);
                }
                component.set('v.displaySpinner', false);
            }, 50)
        }
    },

    closeComponent: function(component) {
        component.find("overlayLibPartnerAddress").notifyClose();
    }
})