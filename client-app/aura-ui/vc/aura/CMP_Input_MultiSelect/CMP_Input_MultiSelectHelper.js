({
  morphItem: function(item) {
    // This function is takes a characteristic and strips out everything except the description and the value
    // This then gets converted to a Value, Label pair. This format is required for the
    // checkbox list to work correctly.
    var w = (({ CharacteristicValue, CharacteristicValueDescription }) => ({ CharacteristicValue, CharacteristicValueDescription }))(item);
    const { CharacteristicValue: value, CharacteristicValueDescription: label} = w
    return Object.assign(
    {},
    {
        value,
        label,
    }
    );
  },
  confirmOptions: function(comp, event, helper) {
    var inputChanged = comp.getEvent("inputChanged");
    var inputId = comp.get('v.inputId');
    var characteristicID = comp.get('v.characteristicID');
    var val = comp.get('v.val');

    inputChanged.setParam("inputId", inputId);
    inputChanged.setParam("characteristicID", characteristicID);
    inputChanged.setParam("newVal", val);
    //inputChanged.setParam("newValDesc", label);
    inputChanged.fire();
    comp.set("v.confirmOptions", false);
  }    
});