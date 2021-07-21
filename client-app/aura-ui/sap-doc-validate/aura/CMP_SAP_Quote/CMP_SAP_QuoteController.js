({
    doInit: function (component, event, helper) {
        helper.init(component, event, helper);
    },

    sapQuote: function(component, event, helper)
    {
        helper.sapQuote(component, event, helper);
    },

    closeWindow: function(component, event, helper)
    {
        $A.get("e.force:closeQuickAction").fire()
        $A.get('e.force:refreshView').fire();
    }
});