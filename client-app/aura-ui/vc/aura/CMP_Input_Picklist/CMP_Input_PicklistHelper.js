({
    valueChanged:function(comp,event,helper)
    {
        var inputId = comp.get('v.inputId');
        var val = comp.get('v.val')
        var inputChanged = comp.getEvent('inputChanged')
        inputChanged.setParam("inputId",inputId);
        inputChanged.setParam("newVal",val);
        var newValDesc = '';
        var possibleVals = comp.get('v.possibleValues');
        possibleVals.forEach((c)=>{
            if(c.CharacteristicValue == val){
                newValDesc = c.CharacteristicValueDescription;
            }
        })
        inputChanged.setParam("newValDesc",newValDesc)
        inputChanged.fire();
    }
})