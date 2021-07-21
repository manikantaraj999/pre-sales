({
    setExpandIconBasedOnExpanded:function(component){
        component.set('v.expandIcon',  component.get('v.isExpanded')?'utility:chevrondown':'utility:chevronup');
    }
})