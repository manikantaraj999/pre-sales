({
    onInit: function(component, event, helper)
    {
        component.set('v.columns', [                
            {label: $A.get("$Label.c.LBL_CustomerSalesAreas_SalesOrg"), fieldName: 'SalesOrganizationDisplay', type: 'text', sortable: false},
            {label: $A.get("$Label.c.LBL_CustomerSalesAreas_DistributionChannel"), fieldName: 'DistributionChannelDisplay', type: 'text', sortable:false},
            {label: $A.get("$Label.c.LBL_CustomerSalesAreas_Division"), fieldName: 'DivisionDisplay', type: 'text', sortable:false}
        ]);

        var action = component.get('c.getInfo')
        action.setCallback(this, function (response) {
            helper.handleResponse(component, event, helper, 'getInfo', response, null, null, 
                function(data) {
                    data = JSON.parse(data);
                    component.set('v.soldToNumber', data.soldToNumber);
                    component.set('v.salesOrg', data.salesOrg);
                    component.set('v.salesDistChannel', data.salesDistChannel);
                    component.set('v.salesDivision', data.salesDivision);
                    helper.getSalesAreas(component, event, helper);
                }
            );
        });
        action.setParams({
            quoteId: component.get('v.quoteId')
        });
        $A.enqueueAction(action);    
    },

    handleRowSelection: function (component, event, helper) {

        if (component.get('v.allowButtons')) {
            var selectedRows = event.getParam('selectedRows');
            if(selectedRows.length>0)
            {
                component.set('v.salesOrg',selectedRows[0].SalesOrganization);
                component.set('v.salesDistChannel', selectedRows[0].DistributionChannel);
                component.set('v.salesDivision', selectedRows[0].Division);
                component.set('v.isSelected', true );
            }
        }
    },

    clearSalesAreaValues:  function(component, event, helper)
    {
        component.set('v.salesOrg', null);
        component.set('v.salesDistChannel', null);
        component.set('v.salesDivision', null);
        component.set('v.isSelected', false);
    },

    flowNavigate: function(component, event, helper)
    {   
        helper.flowNavigateHelper(component, event, helper);
    }
})