({
    onInit: function (component, event, helper) {
        helper.refresh(component, event, helper);
    },
    
    onLocationChange: function (component, event, helper) {
        let sapDocNumUrlParam = window.getUrlParameter('c__sapDocNum');
        if (sapDocNumUrlParam && sapDocNumUrlParam !== component.get('v.sapDocumentId')) {
            helper.refresh(component, event, helper);
        }
    },

    getItemDetail: function (component, event, helper) {
        let itemNum = event.currentTarget.dataset.itemId
        if (!itemNum) return

        component.set('v.selectedItemNumber', itemNum);
        let details = component.get('v.contractDetail');

        let itemDetail = (details.ITEMS.asList.filter(item => {
            return itemNum == item.ItemNumber
        }))[0]
          
        let conditions = details.CONDITIONS.asList.filter(item => {
            return itemNum == item.ConditionItemNumber
        })

        let data = {};
        data.sapDocumentId = component.get('v.sapDocumentId');
        data.recordId = component.get('v.recordId');
        data.itemNum = itemNum;
        data.itemDetail = itemDetail;
        data.conditions = conditions;
        component.set('v.selectedItemDetailData', JSON.stringify(data));
        
        let navigate = component.get("v.navigateFlow");
        navigate("NEXT");        
    }
})