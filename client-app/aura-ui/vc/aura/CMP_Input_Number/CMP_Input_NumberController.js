({
  onInit: function(comp, event, helper) {
    var val = comp.get("v.val");
    if (val == null || "") val = 0;
    comp.set("v.val", val);
  },
  valueChanged: function(comp, event, helper) {
    console.log("value changed for input:" + comp.get("v.inputId"));
    var inputId = comp.get("v.inputId");
    var val = comp.get("v.val");
    var inputChanged = comp.getEvent("inputChanged");
    inputChanged.setParams({ inputId: inputId, newVal: val.toString() });
    inputChanged.fire();
  }
});