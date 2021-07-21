({
    sendSAPSessionDataToContainer: function(result) {
        // Send sessionData for VFP External Configurator Plugin's lastResortCloseSession
        if (result && result.SessionData) {
            var detail = {};
            detail.SessionData = result.SessionData;
            detail.HttpCloseReqquest = result.HttpCloseReqquest;
            window.dispatchEvent(new CustomEvent("updateSessionData", 
                {
                    "bubbles": true, 
                    "cancelable": false, 
                    "detail":detail
                }));
        }
    },
    getConfiguration: function(component, helper) {
        //var pricingCFG = component.get("v.pricingConfig");
        var bypassPricing = component.get("v.bypassPricing");

        var headerJSON = JSON.parse(component.get("v.headerJSON"));
        var itemJSON = JSON.parse(component.get("v.itemJSON"));

        var materialId = component.get('v.materialId');

        var pricingCFG = 
        {
            "SalesDocumentType" : headerJSON.salesDocType,
            "SalesOrganization" : headerJSON.salesOrg,
            "DistributionChannel" : headerJSON.salesDistChannel,
            "Division" : headerJSON.salesDivision,
            "SoldToParty" : headerJSON.soldToParty,
            "ShipToParty" : headerJSON.shipToParty,
            "OrderQuantity" : itemJSON.OrderQuantity,
            "Plant" : itemJSON.plant
        };
        
        if (itemJSON && itemJSON.SalesDocumentCurrency && itemJSON.SalesDocumentCurrency.length > 0)
        {
            pricingCFG.SalesDocumentCurrency = itemJSON.SalesDocumentCurrency;
        }
        
        if (!materialId && (pricingCFG != null || bypassPricing)) return;
        var serializedpricingCFG = JSON.stringify(pricingCFG);

        component.set("v.busy", true);
        
        // This checkes whether or not there is a bill of materials on the object. Verifies that
        // A). itemJSON exists, B). The selected characteristics Exists C). There are elements in the selected characteristics
        var isreconfig = itemJSON && itemJSON.selectedCharacteristics && itemJSON.selectedCharacteristics.length;
        var action = isreconfig ? component.get("c.initializeConfigurationWithBOM") : component.get("c.initializeCustomConfiguration");

        action.setParam("material", materialId); 
        action.setParam("serializedPricingConfig",serializedpricingCFG);

        if(isreconfig){
            action.setParam("serializedBOM", JSON.stringify(itemJSON.selectedCharacteristics));
        }

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue().data;
                helper.sendSAPSessionDataToContainer(result);
                component.set("v.messages", response.getReturnValue().messages)
                result.characteristics.sort(function(a, b) {
                    return a.SequenceNumber - b.SequenceNumber;
                });
                component.set("v.model", result);
                helper.preprocessCharacteristics(component, helper);
                component.set("v.busy", false);
                component.set("v.showClear", isreconfig);
                component.set("v.configValid", result.ConfigurationIsValid);
                component.set("v.allowFinalize", result.ConfigurationIsValid);
                
                // Retrieve Allowed Values if there were none from the initial response
                if (result && result.indexedAllowedValues && !Array.prototype.concat.apply([],Object.values(result.indexedAllowedValues)).length)
                {
                    helper.updateConfiguration(component, helper);
                }
            } else {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        
        $A.enqueueAction(action);
    },
    // This was planned for a future version
    // variantSearch: function(component) {
    //     component.set("v.selectedVariant", "");
    //     var header = component.find("vcHead");
    //     header.clearConfig();
    //     var materialId = component.get("v.materialId");
    //     if (!materialId) return;
    //     component.set("v.busy", true);
    //     var action = component.get("c.getMaterialVariants");
    //     // action.setParams({ material : materialId });
    //     action.setCallback(this, function(response) {
    //         var state = response.getState();
    //         if (state === "SUCCESS") {
    //             var result = response.getReturnValue();
    //             //console.log(result);
    //             component.set("v.variants", result);
    //             component.set("v.busy", false);
                
    //         } else {
    //             var errors = response.getError();
    //             if (errors) {
    //                 if (errors[0] && errors[0].message) {
    //                     console.log("Error message: " + errors[0].message);
    //                 }
    //             } else {
    //                 console.log("Unknown error");
    //             }
    //         }
    //     });
        
    //     $A.enqueueAction(action);
    // },
    // variantSet: function(component, variant) {
    //     var materialId = component.get("v.materialId");
    //     if (!materialId) return;
    //     component.set("v.busy", true);
    //     var action = component.get("c.initializeConfiguration");
    //     action.setParams({
    //         material: materialId
    //     });
    //     action.setCallback(this, function(response) {
    //         var state = response.getState();
    //         if (state === "SUCCESS") {
    //             var result = response.getReturnValue();
    //             //console.log(result);
    //             result.Characteristics.sort(function(a, b) {
    //                 return a.SequenceNumber - b.SequenceNumber;
    //             });
    //             result.SelectedValues = [];
    //             if (
    //                 variant == null ||
    //                 variant == undefined ||
    //                 variant.CharacteristicValues.length == 0
    //             )
    //                 return;
    //             for (var charValue in variant.CharacteristicValues) {
    //                 var selValue = variant.CharacteristicValues[charValue];
    //                 var newSelectedValue = {
    //                     CharacteristicId: selValue.CharacteristicId,
    //                     Value: selValue.Value,
    //                     ValueDescription: selValue.ValueDescription
    //                 };
    //                 result.SelectedValues.push(newSelectedValue);
    //             }
    //             component.set("v.model", result);
    //             component.set("v.busy", false);
    //             component.set("v.showClear", true);
    //             var cmpconfigUpdated = component.getEvent("configUpdated");
    //             cmpconfigUpdated.fire();
    //         } else {
    //             var errors = response.getError();
    //             if (errors) {
    //                 if (errors[0] && errors[0].message) {
    //                     console.log("Error message: " + errors[0].message);
    //                 }
    //             } else {
    //                 console.log("Unknown error");
    //             }
    //         }
    //     });
        
    //     $A.enqueueAction(action);
    // },
    // applyModel : function(model){
    //     var result = response.getReturnValue();
    //     result.Characteristics.sort(function(a, b) {
    //         return a.SequenceNumber - b.SequenceNumber;
    //     });
    //     component.set("v.model", result);
    //     component.set("v.busy", false);
    //     component.set("v.configValid", result.ConfigurationIsValid);
    //     component.set("v.allowFinalize", result.ConfigurationIsValid);
    //     component.set("v.showClear", true);
    // },
    updateConfiguration: function(component, helper) {
        var config = component.get("v.model");
                        
        if (!config.indexedSelectedValues) return;

        var mushedMap = Array.prototype.concat.apply([],Object.values(config.indexedSelectedValues));

        var serializedValues = JSON.stringify(mushedMap);
        var serializedCharacteristics = JSON.stringify(config.characteristics.filter(function(c){return!(c.NoEntryAllowed||c.NotToBeDisplayed)}).map(function(c){return c.CharacteristicName}));

        delete config.indexedSelectedValues;
        delete config.indexedAllowedValues;
        delete config.characteristics;

        var serializedConfig = JSON.stringify(config);
        
        var action = component.get("c.processConfiguration");
        action.setParam("cfg", serializedConfig);
        action.setParam("vals", serializedValues);
        action.setParam("chrs", serializedCharacteristics);
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {

                var result = response.getReturnValue().data;
                helper.sendSAPSessionDataToContainer(result);
                component.set("v.messages", response.getReturnValue().messages)
                if(result !== null)
                {
                    result.characteristics.sort(function(a, b) {
                        return a.SequenceNumber - b.SequenceNumber;
                    });
                    component.set("v.model", result);
                    helper.preprocessCharacteristics(component, helper);
                    component.set("v.configValid", result.ConfigurationIsValid);
                    component.set("v.allowFinalize", result.ConfigurationIsValid && result.isSuccess);
                }
                component.set("v.busy", false);
                component.set("v.showClear", true);
            } else {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        
        $A.enqueueAction(action);
    },
    updateSettings: function(component, helper) {
        var settings = component.get("v.vcSettings");
        var rules = component.get('v.vcSettings.Rules');
        settings.Rules = null;
        var serializedSettings = JSON.stringify(settings);
        var action = component.get("c.updateSettings");
        action.setParam("settings", serializedSettings);
        component.set("v.busy", true);
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue().data;
                helper.sendSAPSessionDataToContainer(result);
                component.set("v.messages", response.getReturnValue().messages)
                //console.log(JSON.stringify(result, null, 2));
                
                result.Rules = rules;
                component.set("v.vcSettings", result);
                component.set("v.busy", false);
                component.set("v.showSettings", false);
            } else {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        
        $A.enqueueAction(action);
    },
    getSettings: function(component, helper) {
        component.set("v.busy", true);
        var action = component.get("c.fetchInitialSettings");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue().data;
                helper.sendSAPSessionDataToContainer(result);
                component.set("v.messages", response.getReturnValue().messages)
                //console.log(result);
                component.set("v.vcSettings", result);
                component.set("v.simulateAddedItems", result.SimulateAddedItems);
                component.set("v.isDisplayRequiredOnly", result.RequiredOnlyDefaultToggle);
                component.set("v.canChangeSettings", result.CanChangeSettings);
                component.set("v.textAllowedValuesLabelRegex", result.textAllowedValuesLabelRegex);
                component.set("v.numberAllowedValuesLabelRegex", result.numberAllowedValuesLabelRegex);
                component.set("v.dateAllowedValuesLabelRegex", result.dateAllowedValuesLabelRegex);
                
                // This is a stub for if we need to select a default frequency setting. For now it is a
                // hardcode. In the long run this this should be updated to actually pull a frequency from a saved
                // Metadata or cookie.
                // component.set("v.vcSettings.FetchConfigurationFrequency", 10);

                component.set("v.busy", false);
                
            } else {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        
        $A.enqueueAction(action);
    },
    setCharacteristicValuesFromBOM: function(component, helper) {
        component.set("v.busy", true);
        var bomItems = component.get('v.reconfiguredValues');
        //bomItems.forEach(itm=>console.log(itm));
        var cfg = component.get('v.model')
        var action = component.get("c.setBOMandProcessConfiguration");
        action.setParam("serializedCfg", JSON.stringify(cfg));
        action.setParam("serializedBOM", JSON.stringify(bomItems));
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue().data;
                helper.sendSAPSessionDataToContainer(result);
                component.set("v.messages", response.getReturnValue().messages)
                //console.log(JSON.stringify(result, null, 2));
                result.Characteristics.sort(function(a, b) {
                    return a.SequenceNumber - b.SequenceNumber;
                });
                component.set("v.model", result);
                component.set("v.busy", false);
                component.set("v.configValid", result.ConfigurationIsValid);
                component.set("v.allowFinalize", result.ConfigurationIsValid);
                component.set("v.showClear", true);
                
            } else {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        
        $A.enqueueAction(action);
    },

    flowNavigate: function(component, helper)
    {           
        var isFinish = component.get('v.isFinish');
        var navigate = component.get("v.navigateFlow");
        
        if(isFinish) navigate("FINISH");
        else navigate("NEXT");
    },

    finishConfig: function(component, helper) {
        var headerJSON = JSON.parse(component.get("v.headerJSON"));
        var itemJSON = JSON.parse(component.get("v.itemJSON"));
        var isLightningFlow = component.get('v.isLightningFlow');
        var itemNumber = component.get('v.itemNumber');

        function sendFinalizeEventAndFlowNavigate() {
            // We need to use the $A syntax if we want to be able to hook into this from outside
            // lighting components. (e.g. from a VFP)
            var finalizeEVT = $A.get("e.c:EVT_VCConfigurationFinalizedConfirmed");
            finalizeEVT.setParam("finalizedConfig", itemJSON.selectedCharacteristics);
            finalizeEVT.setParam("isComplete", true);
            finalizeEVT.setParam('itemNumber', itemNumber);
            finalizeEVT.fire();

            if (isLightningFlow) helper.flowNavigate(component);
            else component.find('overlayLibConfiguration').notifyClose();
        }

        // Skip BOM explosion when simulateAddedItems is false
        if (!component.get("v.simulateAddedItems")) {
            sendFinalizeEventAndFlowNavigate();
            return;
        }

        var materialId = component.get('v.materialId');

        var pricingCFG = 
        {
            "SalesDocumentType" : headerJSON.salesDocType,
            "SalesOrganization" : headerJSON.salesOrg,
            "DistributionChannel" : headerJSON.salesDistChannel,
            "Division" : headerJSON.salesDivision,
            "SoldToParty" : headerJSON.soldToParty,
            "ShipToParty" : headerJSON.shipToParty,
            "OrderQuantity" : itemJSON.OrderQuantity,
            "Plant" : itemJSON.plant
        };

        if (itemJSON && itemJSON.SalesDocumentCurrency && itemJSON.SalesDocumentCurrency.length > 0)
        {
            pricingCFG.SalesDocumentCurrency = itemJSON.SalesDocumentCurrency;
        }

        var serializedpricingCFG = JSON.stringify(pricingCFG);

        component.set("v.busy", true);
        
        // This checkes whether or not there is a bill of materials on the object. Verifies taht
        // A). itemJSON exists, B). The selected characteristics Exists C). There are elements in the selected characteristics
        var action = component.get("c.simulateItem");

        action.setParam("material", materialId); 
        action.setParam("serializedPricingConfig",serializedpricingCFG);
        action.setParam("serializedBOM", JSON.stringify(itemJSON.selectedCharacteristics));
        action.setParam("quoteId", component.get('v.quoteId'));

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue().data;
                helper.sendSAPSessionDataToContainer(result);
                component.set("v.messages", response.getReturnValue().messages)
                component.set("v.addedItemsJSON", JSON.stringify(result));

                sendFinalizeEventAndFlowNavigate();
            } else {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        component.set("v.messages", {"message":errors[0].message, "messageType": 'ERROR'});
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
            component.set("v.busy", false);
        });
        
        $A.enqueueAction(action);
    },

    shouldProcess: function(characteristics, characteristicName) {
        if (characteristics && characteristics.length && characteristics.filter) {
            var match = characteristics.filter(function (c) {
                return characteristicName == c.CharacteristicName
            });
            return match && match[0] && match[0].WillProcess;
        }
        return true;
    },

    preprocessCharacteristics: function(component, helper) {
        var characteristics = component.get("v.model.characteristics");
        var indexedAllowedValues = component.get("v.model.indexedAllowedValues");
        var indexedSelectedValues = component.get("v.model.indexedSelectedValues");
        var rules = component.get('v.vcSettings.Rules') || {};
        // Only visible and editable fields can initiate processing by changing the value
        if (characteristics && characteristics.length) {
            var textAllowedValuesLabelRegex = component.get("v.textAllowedValuesLabelRegex");
            var numberAllowedValuesLabelRegex = component.get("v.numberAllowedValuesLabelRegex");
            var dateAllowedValuesLabelRegex = component.get("v.dateAllowedValuesLabelRegex");
            if (textAllowedValuesLabelRegex) textAllowedValuesLabelRegex = new RegExp(component.get("v.textAllowedValuesLabelRegex"));
            if (numberAllowedValuesLabelRegex) numberAllowedValuesLabelRegex = new RegExp(component.get("v.numberAllowedValuesLabelRegex"));
            if (dateAllowedValuesLabelRegex) dateAllowedValuesLabelRegex = new RegExp(component.get("v.dateAllowedValuesLabelRegex"));
            characteristics.forEach(c => {
                // Before: Apply characteristic field overrides from applicable rule
                Object.assign(c,rules[c.CharacteristicName])
                // Make SequenceNumber numeric for sorting
                c.SequenceNumber=isNaN(Number(c.SequenceNumber)) ? -1 : Number(c.SequenceNumber);

                // Determine input control type
                c.allowed = indexedAllowedValues[c.CharacteristicName];
                c.selected = indexedSelectedValues[c.CharacteristicName];
                c.inputType = 'ShortText';
                if (c.SingleValue) {
                    var dataType = c.DataType.toUpperCase();
                    if (dataType == 'INT' || dataType == 'NUM') {
                        c.inputType = 'Number';
                    } else if (dataType == 'DATE') {
                        c.inputType = 'Date';
                    }
                    if (c.allowed && c.allowed.length > 0) {
                        var isLabel = false;
                        if (c.inputType == 'ShortText' && textAllowedValuesLabelRegex) {
                            c.allowed.forEach(function (v) {
                                if (textAllowedValuesLabelRegex.test(v.CharacteristicValue)) {
                                    isLabel = true;
                                }
                            });
                        } else if (c.inputType == 'Number' && numberAllowedValuesLabelRegex) {
                            c.allowed.forEach(function (v) {
                                if (numberAllowedValuesLabelRegex.test(v.CharacteristicValue)) {
                                    isLabel = true;
                                }
                            });
                        } else if (c.inputType == 'Date' && dateAllowedValuesLabelRegex) {
                            c.allowed.forEach(function (v) {
                                if (dateAllowedValuesLabelRegex.test(v.CharacteristicValue)) {
                                    isLabel = true;
                                }
                            });
                        }
                        if (!isLabel) {
                            c.inputType = 'InputPicklist';
                        }
                    }
                } else {
                    c.inputType = 'InputMultiple';
                }
            });
            // Sort by SequenceNumber
            //characteristics = characteristics.sort((a, b) => a.SequenceNumber - b.SequenceNumber);
            characteristics = characteristics.sort((a, b) => {
                if (a.GroupName > b.GroupName) return 1;
                if (a.GroupName < b.GroupName) return -1;
                if (a.SequenceNumber > b.SequenceNumber) return 1;
                if (a.SequenceNumber < b.SequenceNumber) return -1;
            });

            var displayManualRunVCButton = !!component.get('v.vcSettings.DisplayManualRunVCButton');
            // Find first true MustProcess on a visible and editable characteristic
            var defaultWillProcess = true;
            if (!displayManualRunVCButton) {
                for (var i = 0; i < characteristics.length; i++) {
                    var c = characteristics[i];
                    // Only visible and editable fields can initiate processing by changing the value
                    if ('X' != c.NotToBeDisplayed && 'X' != c.NoEntryAllowed && 'X' == c.Process) {
                        defaultWillProcess = false;
                        break;
                    }
                }
            }

            // Set flags for each characteristic
            for (var i = 0; i < characteristics.length; i++) {
                var c = characteristics[i];

                // Only apply the following flags to visible characteristics
                if ('X' != c.NotToBeDisplayed) {
                    var editable = 'X' != c.NoEntryAllowed;
                    var readonly = !editable;

                    // WillProcess should only apply to editable fields
                    if (editable && !displayManualRunVCButton) {
                        c.WillProcess = defaultWillProcess || 'X' == c.Process;
                    }

                    // Left hand size is the Editor view
                    c.DisplayInEditorView = true;
                    if (rules.EditorView && rules.EditorView.HideReadOnly && readonly) {
                        c.DisplayInEditorView = false
                    }

                    // Right hand side is the Summary view
                    c.DisplayInSummaryView = true;
                    if (rules.SummaryView && rules.SummaryView.HideEditable && editable) {
                        c.DisplayInSummaryView = false;
                    }
                }

                // After: Apply characteristic field overrides from applicable rule
                Object.assign(c,rules[c.CharacteristicName]);
            }
        }
        component.set("v.model.characteristics", characteristics);
        helper.createGroupings(component, helper);
    },

    createGroupings: function (component, helper) {
        var rootGroups = component.get("v.rootGroups") || [];
        helper.clearCharacteristics(rootGroups, helper);

        var groupsMap = {};
        rootGroups.forEach(function (g){
            groupsMap[g.name] = g;
        });

        var characteristicsForEditor = component.get("v.model.characteristics").filter(c => c.DisplayInEditorView);
        for (var i = 0; i < characteristicsForEditor.length; i++) {
            var curChar = characteristicsForEditor[i];
            var g = groupsMap[curChar.GroupText];
            if (!g) {
                g = {
                    name: curChar.GroupText,
                    HasRequiredCharacteristics: false,
                    characteristics: [],
                };
                rootGroups.push(g);
                groupsMap[curChar.GroupText] = g;
            }
            g.characteristics.push(curChar);
            if (!g.HasRequiredCharacteristics && curChar.Required === "X") {
                g.HasRequiredCharacteristics = true;
            }
        }
        component.set("v.rootGroups", rootGroups);
    },

    clearCharacteristics: function (groupList, helper) {
        if (groupList && groupList.length) {
            for (var i = 0; i < groupList.length; i++) {
                groupList[i].characteristics = [];
                groupList[i].HasRequiredCharacteristics = false;
            }
        }
    }

});