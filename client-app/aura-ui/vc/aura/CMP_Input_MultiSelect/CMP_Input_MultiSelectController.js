({
  onInit: function(comp, event, helper) {
    var checkboxes = comp.find("checkboxes");
    for (var c in checkboxes) {
      var component = checkboxes[c];
    }
    var selectedValues = comp.get("v.selected");
    comp.set("v.val", selectedValues.map(value => value.CharacteristicValue));

    var opts = comp.get("v.possibleValues").map(item => helper.morphItem(item))
    comp.set("v.options", opts);
  },
  valueChanged: function(comp, event, helper) {
    comp.set("v.confirmOptions", true);
    if(comp.get('v.vcSettings.DisplayManualRunVCButton'))
    {
      helper.confirmOptions(comp, event, helper);
    }
  },
  confirmOptions: function(comp, event, helper) {
    helper.confirmOptions(comp, event, helper);
  }
});