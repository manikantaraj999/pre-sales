({
    doInit: function (component, event, helper) {

        component.set('v.searchParams.MaterialNumber', 
            component.get('v.defaultMaterial'));
        component.set('v.searchParams.MaterialDescription', 
            component.get('v.defaultSearchDescription'));
         
        var columns = [];
        var colCnt = 0;
        columns[colCnt++] = {label: $A.get('$Label.c.Enosix_SalesDoc_Table_Material'), fieldName: 'material', type: 'text'};
        columns[colCnt++] = {label: $A.get('$Label.c.Enosix_SalesDoc_Table_MaterialType'), fieldName: 'materialType', type: 'text'};
        columns[colCnt++] = {label: $A.get('$Label.c.Enosix_SalesDoc_Table_ItemDescription'), fieldName: 'materialDescription', type: 'text'};
        columns[colCnt++] = {label: $A.get('$Label.c.Enosix_SalesDoc_Table_Category'), fieldName: 'productHierarchyField', type: 'text'};
        if (component.get('v.isQuantityEnabled')) {            
            columns[colCnt++] = {label: $A.get('$Label.c.Enosix_SalesDoc_Table_Quantity'), fieldName: 'quantity', type: 'number', editable: true, typeAttributes: { maximumFractionDigits: '3' }};
            columns[colCnt++] = {label: $A.get('$Label.c.Enosix_SalesDoc_Table_UnitOfMeasure'), fieldName: 'unitOfMeasure', type: 'text'};
        }
        if (component.get('v.isScheduleDateEnabled')) {            
            columns[colCnt++] = {label: $A.get('$Label.c.Enosix_SalesDoc_Table_RequestedDate'), fieldName: 'scheduleDate', type: 'date-local', editable: true};
        }

        component.set('v.columns', columns);

        var pagingOptions = {pageNumber: 1, pageSize: component.get('v.maxNumberOfRows')};

        component.set('v.displaySpinner', true);
        return helper.getProductHierarchies(component)
            .then($A.getCallback(function() {
                return helper.getMaterialTypes(component);
            }))
            .then($A.getCallback(function() {
                if (component.get('v.isAutoSearchEnabled')) {
                    return helper.searchMaterials(component, pagingOptions, helper);
                }                
            }))
            .then($A.getCallback(function() {
                component.set('v.displaySpinner', false);
                component.set('v.initComplete', true);
            }))
    },

    onSearch: function (component, event, helper) {
        helper.search(component, event, helper); 
    },

    onSelectRow: function(component, event, helper) {
        var isMultiSelectEnabled = component.get('v.isMultiSelectEnabled');
        var selectedRows = event.getParam('selectedRows');

        if(isMultiSelectEnabled) {
            component.set('v.selectedItemsList', selectedRows);
        }
        else {
            component.set('v.selectedItemList', selectedRows[0]);
            helper.saveToItems(component, event);
        }
    },

    onCellChange: function (component, event, helper) {
        var draftValues = event.getParam('draftValues');
        var draftValuesList = component.get('v.draftValuesList');

        draftValues.forEach(function(thisDraftValue)
        {
            var material = thisDraftValue.material;
            var hasQuantity =  (thisDraftValue.quantity != undefined);
            var hasScheduleDate = (thisDraftValue.scheduleDate != undefined);
    
            //check to see if previous draft value exists
            if(hasQuantity) {
                var qIndex = draftValuesList.findIndex(qValue => qValue.material == material && qValue.quantity != undefined);
                if(qIndex > -1) {
                    draftValuesList.splice(qIndex);
                }
            }
            if(hasScheduleDate) {
                var sIndex = draftValuesList.findIndex(sValue => sValue.material == material && sValue.scheduleDate != undefined);
                if(sIndex > -1) {
                    draftValuesList.splice(sIndex);
                }
            }
            draftValuesList.push(thisDraftValue);
        });

        component.set('v.draftValuesList', draftValuesList);
    },

    loadMoreData: function(component, event, helper) {
        let endRange;
        var loadCount = component.get('v.loadCount');
        component.set('v.displaySpinner', true);

        endRange = loadCount + 20;
        var filterResults = component.get('v.searchResults');

        var newRows = filterResults.slice(loadCount, endRange);
        var currentRows = component.get('v.displayResults');
        var newResults = currentRows.concat(newRows);
        component.set('v.displayResults', newResults);
        component.set('v.loadCount', endRange);
        
        if (newResults.length >= component.get('v.maxNumberOfRows')) {
            component.set('v.enableInfiniteLoading', false);
            component.set('v.showMessage', true);
        }

        component.set('v.displaySpinner', false);
    },

    addMaterials: function(component, event, helper) {
        helper.saveToItems(component, event);
    },

    handleSelectedSearchValue: function(component, event, helper) {
        let value = event.getParam('selectedValue');
        component.set('v.searchParams.ProductHierarchy', value);
        helper.search(component, event, helper); // CT
    },

    onKeyPressMaterialNumber: function(component, event, helper) {
        if (event.code == 'Enter'){
            helper.search(component, event, helper);
        }
    },

    onKeyPressMaterialDescription: function(component, event, helper) {
        if (event.code == 'Enter'){
            helper.search(component, event, helper);
        }
    },

    onClickCancel: function(component, event, helper) {
        component.find("overlayLib").notifyClose();
    },
})