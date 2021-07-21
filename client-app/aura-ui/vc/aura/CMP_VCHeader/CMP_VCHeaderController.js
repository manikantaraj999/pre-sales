({
    variantSet: function (component, event) {
        var variants = component.get('v.variants');
        var selected = event.getParam('value');
        if (selected == undefined || selected == '') return;
        var selectedVariant = variants[selected - 1];
        var variantSet = component.getEvent("variantSet");
        variantSet.setParams({
            "Variant": selectedVariant
        });
        variantSet.fire();
    },
    clearConfig: function (component, event) {
        component.set('v.selectedVariant','');
    },
    
})