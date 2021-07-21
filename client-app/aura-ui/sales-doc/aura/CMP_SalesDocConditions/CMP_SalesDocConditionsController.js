({
    onInit: function(component, event, helper) {
        let addedConditions = component.get('v.addedConditions');
        let allConditions = component.get('v.allConditions');

        if (addedConditions && addedConditions) {    
            let currentConditionsSet = new Set();
            addedConditions.forEach(cond => {
                currentConditionsSet.add(cond.ConditionType);
            });

            let newConditions = allConditions.filter(
                cond => !currentConditionsSet.has(cond.ConditionType));
            component.set('v.conditionsList', newConditions);
            
        }
        else component.set('v.conditionsList', allConditions);    
    },

    addCondition: function(component, event, helper) {
        let selectedCondition = component.get('v.selectedCondition');
        
        if (selectedCondition) {
            let addedConditions = component.get('v.addedConditions');
            let conditionsList = component.get('v.conditionsList');

            let selectedConditionObject = conditionsList.find(item => item.ConditionType === selectedCondition);
            let newConditionsList = conditionsList.filter(item => item.ConditionType !== selectedCondition);
            let newCondition = {
                ConditionType: selectedConditionObject.ConditionType,
                ConditionTypeName: selectedConditionObject.KSCHL_TEXT,
                CalculationType: selectedConditionObject.KRECH
            }

            if (!addedConditions) addedConditions = [];
            addedConditions.push(newCondition);

            component.set('v.addedConditions', addedConditions);
            component.set('v.selectedCondition', '');
            component.set('v.conditionsList', newConditionsList);      
        }
    },

    removeCondition: function(component, event, helper) {
        let param = event.getSource().get('v.name');
        
        if (param) {            
            let addedConditions = component.get('v.addedConditions')          

            let newAddedConditions = addedConditions.filter(cond => cond.ConditionType !== param);
            component.set('v.addedConditions', newAddedConditions);

            let allConditions = component.get('v.allConditions');
            let conditionsList = component.get('v.conditionsList');

            let removedCondition = allConditions.find(item => item.ConditionType === param);            
            conditionsList.push(removedCondition);
            conditionsList.sort((a,b) => (a.ConditionType > b.ConditionType) ? 1 : -1);

            component.set('v.conditionsList', conditionsList);
        }
    },

    onValueChange: function(component, event, helper) {
        var evt = component.getEvent('conditionValueChange');
        evt.fire();
    }
})