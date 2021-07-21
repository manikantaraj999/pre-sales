({
    onInit: function (component, event, helper) {
        helper.refresh(component, event, helper);
    },
    
    onLocationChange: function (component, event, helper) {
        let sapDocNumUrlParam = window.getUrlParameter('c__sapDocNum');
        if (sapDocNumUrlParam && sapDocNumUrlParam !== component.get('v.sapDocumentId')) {
            helper.refresh(component, event, helper);
        }
    }
})