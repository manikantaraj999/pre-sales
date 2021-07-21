({
    doInit: function (component, event, helper) {
        helper.init(component, event, helper);
    },

    sapOrder: function(component, event, helper)
    {
        helper.sapOrder(component, event, helper);
    },

    closeWindow: function(component, event, helper)
    {
        $A.get("e.force:closeQuickAction").fire()
        $A.get('e.force:refreshView').fire();
    }
});