({
    getMaterialTypes: function(component) {
        return new Promise(function(resolve, reject) {
            if (component.get('v.isMaterialTypesDisplayed')) {
                var action = component.get('c.loadMaterialTypes');
                action.setParams({
                    defaultMaterialTypes: component.get('v.defaultMaterialTypes')
                });        
                action.setCallback(this, function (data) {
                    if (data.getReturnValue()) {
                        var response = data.getReturnValue();
                        if (response.data.length > 0) {
                            var data = response.data;
                            component.set('v.materialTypeSelectOptions', data);
    
                            var materialTypeValues = [];
                            for (var dataCnt = 0; dataCnt < data.length; dataCnt++) {
                                materialTypeValues[dataCnt] = data[dataCnt].value;
                            }
                            component.set('v.searchParams.MaterialTypeValues', materialTypeValues);
                        }
                        else component.set('v.isMaterialTypesDisplayed', false);
                    }
                    resolve(true);
                });
    
                $A.enqueueAction(action);
            }
            else resolve(true);
        });          
    },

    getProductHierarchies: function(component) {
        return new Promise(function(resolve, reject) {
            if (component.get('v.isProductHierarchyDisplayed')) {    
                var action = component.get('c.loadProductHierarchies');       
                action.setCallback(this, function (data) {
                    if (data.getReturnValue()) {
                        var response = data.getReturnValue();
                        if (response.data.length > 0) {
                            var data = response.data;
                            component.set('v.productHierarchies', data);
                        }
                    }
                    resolve(true);
                });
                $A.enqueueAction(action);
            }
            else resolve(true);
        });
    },

    searchMaterials: function(component, pagingOptions, helper) {
        return new Promise(function(resolve, reject) {
            var action = helper.setSearchAction(component);
            action.setParams({
                searchParams: component.get('v.searchParams'), 
                pagingOptions: pagingOptions
            });

            action.setCallback(this, function (data) {
                if (data.getReturnValue()) {
                    var response = data.getReturnValue();
                    response.data.forEach(row => 
                        row.productHierarchyField = row.productHierarchy + ' - ' + row.productHierarchyDescription);

                    component.set('v.searchResults', response.data);
                    component.set('v.messages', response.messages);

                    if(response.data.length == 0) {
                        var errorMessage = {
                            message: $A.get('$Label.c.Enosix_SalesDoc_Message_SearchNoResult'), 
                            messageType: "INFO"
                        };
                        component.set('v.messages', errorMessage);
                        component.set('v.displayResults', []);
                    }
                    else {
                        helper.displayInitialResults(component);
                    }
                }
                resolve(true);            
            });
            $A.enqueueAction(action);
        });
    },

    setSearchAction : function(component) {
        var action = component.get('c.searchMaterials');
        component.set('v.searchParams.SalesOrganization', component.get('v.salesOrganization'));
        component.set('v.searchParams.DistributionChannel', component.get('v.distributionChannel'));
        return action;
    },

    displayInitialResults: function(component) {
        var searchResults = component.get('v.searchResults');
        var filterRows;
        var initialRow = 20;
        if(searchResults.length > initialRow) {
            filterRows = searchResults.slice(0, initialRow);
            component.set('v.enableInfiniteLoading', true);
            component.set('v.loadCount', initialRow);
        } else {
            filterRows = searchResults;
            component.set('v.enableInfiniteLoading', false);
        }
        component.set('v.displayResults', filterRows);
    },

    saveToItems: function(component, event)
    {
        this.updateSelectedDraftValues(component, event);
        var isInFlow = component.get('v.isSeparateFlowComponent');
        //convert Map to JSON
        var itemJSONList = JSON.stringify(component.get('v.selectedItemsList'));

        //if added directly to a flow, set as variable, navigate to next
        if(isInFlow)
        {
            component.set('v.selectedItemsJSON', itemJSONList);
            //TODO:navigate next
        }
        else //if called from a flow component: set event value, fire event, close    
        {
            var evt = component.getEvent('selectMaterialsEvent');
            evt.setParams({selectedItems:itemJSONList});
            evt.fire();
            component.find('overlayLib').notifyClose();
        }
    },

    updateSelectedDraftValues: function(component, event) {

        var selectedItems = component.get('v.selectedItemsList');
        var draftValues = component.get('v.draftValuesList');

        //roll through selected materials, and apply draftValues
        selectedItems.forEach(function(thisItem, i) {
            var material = thisItem.material;
            var filteredDraft = draftValues.filter(mDraft => mDraft.material == material);

            if(filteredDraft.length>0)
            {
                filteredDraft.forEach(function(thisDraft)
                {
                    if(thisDraft.quantity!= undefined)
                    {
                        thisItem.quantity = thisDraft.quantity;
                    }
                    if(thisDraft.scheduleDate != undefined)
                    {
                        thisItem.scheduleDate = thisDraft.scheduleDate;
                    }
                });
            }
            selectedItems.splice(i,1,thisItem);
        });

        //update selectedItemsList
        component.set('v.selectedItemsList', selectedItems);
    },

    search: function(component, event, helper) {
        var pagingOptions = {pageNumber: 1, pageSize: component.get('v.maxNumberOfRows')};
        component.set('v.displaySpinner', true);
        helper.searchMaterials(component, pagingOptions, helper)
            .then($A.getCallback(function() {
                component.set('v.displaySpinner', false);
            }))
    },
})