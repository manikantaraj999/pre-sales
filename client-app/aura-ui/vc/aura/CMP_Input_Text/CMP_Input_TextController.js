({
    valueMightHaveChanged:function(component,event,helper)
    {
        var inputId = component.get('v.inputId');
        var val = component.get('v.val');
        var newVal = event.getSource().get("v.value");
        if (newVal != val) {
          console.log('CMP_Input_Text ' + component.get('v.inputId') + ': val:' + val + '; newVal:' + newVal)
          component.getEvent('inputChanged').setParams({"inputId": inputId, "newVal": newVal}).fire();
        }
    }
})