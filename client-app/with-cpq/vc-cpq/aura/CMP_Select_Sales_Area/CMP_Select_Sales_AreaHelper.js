({
    getSalesAreas: function(component, event, helper)
    {
        var action = component.get('c.getSalesAreaList')
        action.setCallback(this, function (response) {
            helper.handleResponse(component, event, helper, 'getSalesAreaList', response, null, null, 
                function(data) {
                    if (data) {
                        var salesOrg = component.get('v.salesOrg');
                        var salesDistribution = component.get('v.salesDistChannel');
                        var salesDivision = component.get('v.salesDivision');

                        component.set('v.Customer', data);
                        var validSA = false;
                        var salesAreaList = data.SALES_DATA.asList;
                        var salesTot = salesAreaList.length;
                        for (var salesCnt = 0 ; salesCnt < salesTot; salesCnt++)
                        {
                            var sa = salesAreaList[salesCnt];
                            sa.keyField = sa.SalesOrganization + '|' + sa.DistributionChannel + '|' + sa.Division;
                            sa.SalesOrganizationDisplay = sa.SalesOrganization + ' - ' + sa.SalesOrganizationName;
                            sa.DistributionChannelDisplay = sa.DistributionChannel + ' - ' + sa.DistributionChannelName;
                            sa.DivisionDisplay = sa.Division + ' - ' + sa.DivisionName;
                            if (sa.SalesOrganization == salesOrg && sa.DistributionChannel == salesDistribution &&
                                sa.Division == salesDivision) 
                            {
                                validSA = true;
                            }
                        }
                        component.set('v.salesAreaList', salesAreaList);

                        if (salesAreaList.length == 1 && component.get('v.autoPickSingle')) {
                            component.set('v.allowButtons', false);
                            component.set('v.salesOrg',salesAreaList[0].SalesOrganization);
                            component.set('v.salesDistChannel', salesAreaList[0].DistributionChannel);
                            component.set('v.salesDivision', salesAreaList[0].Division);
                            component.set('v.isSelected', true );
                            var labelReference = $A.get("$Label.c.LBL_Auto_Selected_Single_Option");
                            var autoSelect = {message: labelReference, messageType: "INFO"};
                            component.set('v.messages', autoSelect);
                            window.setTimeout(
                                $A.getCallback(function() {
                                    helper.flowNavigateHelper(component, event, helper);
                                }), 3000
                            );
                        } else {
                            if (validSA) {
                                component.set('v.isSelected', true);
                            } else {
                                salesOrg = null;
                                salesDistribution = null;
                                salesDivision = null;
                            }

                            component.set('v.salesOrg', salesOrg);
                            component.set('v.salesDistChannel', salesDistribution);
                            component.set('v.salesDivision', salesDivision);
                        }
                        component.superRerender();
                        component.set('v.displaySpinner', false);
                    }
                }
            );
        });
        action.setParams({
            soldToNumber: component.get('v.soldToNumber')
        });
        $A.enqueueAction(action);
    },

    flowNavigateHelper: function(component, event, helper)
    {     
        var params = {
            quoteId: component.get('v.quoteId'),
            salesOrg: component.get('v.salesOrg'),
            salesDistChannel: component.get('v.salesDistChannel'),
            salesDivision: component.get('v.salesDivision')
            };
        var action = component.get('c.updateInfo')

        action.setCallback(this, function (response) {
            helper.handleResponse(component, event, helper, 'updateInfo', response, null, null, 
                function(data) {
                    if (data) {
                        var isFinish = component.get('v.isFinish');
                        var navigate = component.get("v.navigateFlow");
                        
                        if(isFinish)
                        {
                            navigate("FINISH");
                        }else
                        {
                            navigate("NEXT");
                        }
                    }
                }
            );
        });
        action.setParams({
            params: params
        });
        $A.enqueueAction(action);    
    },

    handleResponse: function (component, event, helper, method, response, resolve, reject, dataFunction)
    {
        var state = response.getState();
        if (state === "SUCCESS") {
            var returnValue = response.getReturnValue();
            if (returnValue != undefined) {
                var messages = returnValue.messages;
                if (messages && messages.length > 0) {
                    var vMessages = component.get('v.messages');
                    vMessages.push(...messages);
                    component.set('v.messages', vMessages);
                }
                if (dataFunction !== undefined && dataFunction !== null) dataFunction(returnValue.data);
            }
            if (resolve !== undefined && resolve !== null) resolve(true);
        } else {
            var messages = [];
            messages.push({message: 'There was an error in CTRL_CPQ_Sales.' + method, messageType: "ERROR"});

            var errors = response.getError();
            if (errors) {
                for (var errCnt = 0; errCnt < errors.length; errCnt++) {
                    var fieldErrors = errors[errCnt].fieldErrors;
                    if (fieldErrors !== undefined && message != null) {
                        messages.push({message: fieldErrors, messageType: "ERROR"});
                    }
                    var pageErrors = errors[errCnt].pageErrors;
                    if (pageErrors) {
                        for (var pageCnt = 0; pageCnt < pageErrors.length; pageCnt++) {
                            messages.push({message: pageErrors[pageCnt].message, messageType: "ERROR"});
                        }
                    }
                    var message = errors[errCnt].message;
                    if (message !== undefined && message != null) {
                        messages.push({message: message, messageType: "ERROR"});
                    }
                }
            }
            var vMessages = component.get('v.messages');
            vMessages.push(...messages);
            component.set('v.messages', vMessages);
            if (reject !== undefined && reject !== null) reject('There was an error in CTRL_QuoteFinalDetails.' + method);
        }
        component.set('v.displaySpinner', false);
    }
})