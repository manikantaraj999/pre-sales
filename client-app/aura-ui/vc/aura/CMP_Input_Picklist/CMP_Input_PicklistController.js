({
    onFocus: function(comp, event, helper) {
        comp.set('v.textInput', comp.get('v.val'));
        $A.util.removeClass(comp.find('searchBlock'), 'showSearchWrapper');
        $A.util.addClass(comp.find('searchBlock'), 'showSearchWrapper');
        comp.find('pickMainInputBox').getElement().disabled = true;
        setTimeout(function() {
            var pickInputBox = comp.find('pickInputBox');
            if (pickInputBox) {
                pickInputBox.getElement().focus();
                pickInputBox.getElement().select();
            }
        }, 500);
    },

    onBlur: function(comp, event, helper) {
        comp.set('v.onBlurTriggered', true);
        comp.find('pickMainInputBox').getElement().disabled = false;
        let value = event.target.value;
        let stringValue = value.toString();
        setTimeout(function() {
            if (comp.get('v.onBlurTriggered')) {
                comp.set('v.val', stringValue);
                $A.util.removeClass(comp.find('searchBlock'), 'showSearchWrapper');
                helper.valueChanged(comp,event,helper);
            }
        }, 500);
    },

    onValueClick: function(comp, event, helper) {
        comp.set('v.onBlurTriggered', false);
        comp.find('pickMainInputBox').getElement().disabled = false;
        let value = event.target.innerText;
        let stringValue = value.toString();
        comp.set('v.val', stringValue);
        $A.util.removeClass(comp.find('searchBlock'), 'showSearchWrapper');
        helper.valueChanged(comp,event,helper);
    },

    valueChanged:function(comp,event,helper)
    {
        helper.valueChanged(comp,event,helper);
    }
})