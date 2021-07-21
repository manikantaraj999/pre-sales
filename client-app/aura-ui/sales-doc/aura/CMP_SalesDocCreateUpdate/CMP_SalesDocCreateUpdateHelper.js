({
    loadAppSettings: function(component) {
        return new Promise(function(resolve, reject) {
            console.log('init app settings');

            let appSettingsName = component.get('v.appSettingsName');
            let appSettingsNamespace = component.get('v.appSettingsNamespace');
            let appSettingsKey = component.get('v.appSettingsKey');
            let appSettingsTypeName = component.get('v.appSettingsTypeName');

            let staticResourceName = appSettingsNamespace ? appSettingsNamespace + '__' + appSettingsName : appSettingsName

            let staticResource = $A.get('$Resource.' + staticResourceName); 
            let req = new XMLHttpRequest();

            req.open("GET", staticResource);
            req.addEventListener("load", $A.getCallback(function() {
                console.log('loaded app settings');
                let response = JSON.parse(req.response);
                let appSettings = response[appSettingsKey] ? response[appSettingsKey][appSettingsTypeName] : null;
                if (!appSettings) {
                    let messages = [{
                        messageType: 'ERROR', 
                        message: 'App Settings is not found on ' + staticResourceName + '. Please Configure the App Settings first.'
                    }];
                    component.set('v.messages', messages);
                }
                else {
                    component.set('v.appSettings', appSettings);    
                }
                resolve();  
            }));
            req.send(null);
        })
    },

    initSFObject: function(component, recordId, helper) {
        debugger;
        return new Promise(function(resolve, reject) {
            console.log('init SalesDoc');
            let action = component.get('c.initSFObject');
            let sapDocNumber = component.get('v.sapDocNumber');
			
            console.log('sapdoctype',component.get('v.appSettings.SAPDocType'));
            action.setParams({
                recordId: recordId,
                sapDocType: component.get('v.appSettings.SAPDocType')
            })
            action.setCallback(this, function(res) {
                console.log('hakunama',res.state ,res.getReturnValue());
                helper.handleResponse(component, action.getName(), res, resolve, reject,
                    function(data) {
                        
                        if (data) {
                            if (!sapDocNumber && data.sapDocNumber) {
                                sapDocNumber = data.sapDocNumber;
                                component.set('v.sapDocNumber', sapDocNumber);
                            }

                            if (sapDocNumber && !component.get('v.isClone')) {
                                component.set('v.isUpdate', true);
                            }

                            component.set('v.sfObject', data);
                        }
                    }
                );
            })

            $A.enqueueAction(action);
        })
    },

    getCustomerDetail: function(component, helper) {
        return new Promise(function(resolve, reject) {
            console.log('getCustomer');
            let sfObject = component.get('v.sfObject');
            let action = component.get('c.getCustomerDetail');
            
            action.setParams({
                customerNumber: sfObject.customerNumber
            });

            action.setCallback(this, function(res) {
                console.log('return customer');
                helper.handleResponse(component, action.getName(), res, resolve, reject,
                    function(data) {
                        if (data) {         
                            let salesDatas = data.SALES_DATA.asList;
                            helper.setSalesData(component, salesDatas);
                            component.set('v.customerDetail', data);
                            component.set('v.salesDatas', salesDatas);
                        }
                    }
                );
            });

            $A.enqueueAction(action);
        })
    },

    setSalesData: function(component, salesDatas) {
        if (salesDatas.length) {
            let salesOrganizations = this.setSalesOrgs(component, salesDatas);
            let salesOrg = salesOrganizations.length > 0 ? salesOrganizations[0].SalesOrganization : '';

            let distributionChannels = this.setDistributionChannels(component, salesDatas, salesOrg);
            let distChan = distributionChannels.length > 0 ? distributionChannels[0].DistributionChannel : '';
            this.setDivisions(component, salesDatas, salesOrg, distChan);
        }              
    },

    setSalesOrgs: function(component, salesDatas) {
        let salesOrganizationsSet = new Set();
        let salesOrganizations = [];

        salesDatas.forEach(obj => {
            if (!salesOrganizationsSet.has(obj.SalesOrganization)) {
                salesOrganizationsSet.add(obj.SalesOrganization);
                let newObj = {};
                newObj.SalesOrganization = obj.SalesOrganization;
                newObj.SalesOrganizationName = obj.SalesOrganizationName;
                salesOrganizations.push(newObj);
            }            
        })
        component.set('v.salesOrganizations', salesOrganizations);
        
        return salesOrganizations;
    },

    setDistributionChannels: function(component, salesDatas, salesOrg) {
        let distributionChannelsSet = new Set();
        let distributionChannels = [];

        salesDatas.forEach(obj => {
            if (obj.SalesOrganization === salesOrg && !distributionChannelsSet.has(obj.DistributionChannel)) {
                distributionChannelsSet.add(obj.DistributionChannel);
                let newObj = {};
                newObj.DistributionChannel = obj.DistributionChannel;
                newObj.DistributionChannelName = obj.DistributionChannelName;
                distributionChannels.push(newObj);
            }            
        })
        component.set('v.distributionChannels', distributionChannels);

        return distributionChannels;
    },

    setDivisions: function(component, salesDatas, salesOrg, distChannel) {
        let divisions = [];

        salesDatas.forEach(obj => {
            if (obj.SalesOrganization === salesOrg && obj.DistributionChannel === distChannel) {
                let newObj = {};
                newObj.Division = obj.Division;
                newObj.DivisionName = obj.DivisionName;
                divisions.push(newObj);
            }            
        })
        component.set('v.divisions', divisions);

        return divisions;
    },

    getSalesDocDetail: function(component, sapDocNumber, helper) {
        return new Promise(function(resolve, reject) {
            console.log('get sales doc detail');

            let action = component.get('c.getSalesDocDetail');
            action.setParams({
                salesDocNumber: sapDocNumber,
                appSettings: component.get('v.appSettings'),
                sfObject: component.get('v.sfObject')
            })

            action.setCallback(this, function(res) {
                console.log('return get sales doc detail');
                helper.handleResponse(component, action.getName(), res, resolve, reject,
                    function(data) {
                        if (data) {
                            component.set('v.salesDocDetail', data);
                            component.set('v.needToSimulate', false);
                        }
                    }
                );
            });

            $A.enqueueAction(action);
        })
    },

    getReferenceDocument: function(component, sapDocNumber, helper) {
        return new Promise(function(resolve, reject) {
            console.log('get reference document for clone');

            let action = component.get('c.getReferenceDocument');
            let appSettings = component.get('v.appSettings')
            action.setParams({
                salesDocNumber: sapDocNumber,
                appSettings: appSettings
            })

            action.setCallback(this, function(res) {
                console.log('return get sales doc detail');
                helper.handleResponse(component, action.getName(), res, resolve, reject,
                    function(data) {
                        if (data) {
                            if (!data.SALES.SalesDocumentType) {
                                data.SALES.SalesDocumentType = appSettings.DefaultDocType;
                            }
                            component.set('v.salesDocDetail', data);
                            component.set('v.needToSimulate', false);
                        }
                    }
                );
            });

            $A.enqueueAction(action);
        })
    },

    setInitSalesDocFromCustomer: function(component, helper) {
        console.log('init sales doc');
        let customerDetail = component.get('v.customerDetail');
        let appSettings = component.get('v.appSettings');
        let salesData = component.get('v.salesDatas')[0];

        let salesDocDetail = {
            SoldToParty : customerDetail.CustomerNumber,
            SoldToPartyText : customerDetail.Name,
            SalesDocumentCurrency : salesData ? salesData.CurrencyKey : '',
            ShippingConditions : salesData ? salesData.ShippingConditions : '',
            CustomerLanguage : customerDetail.Language,
            SALES : {
                SalesDocumentType : appSettings.DefaultDocType,
                SalesOrganization : salesData ? salesData.SalesOrganization : '',
                DistributionChannel : salesData ? salesData.DistributionChannel : '',
                Division : salesData ? salesData.Division : '',
                TermsofPaymentKey : salesData ? salesData.TermsofPaymentKey : '',
                IncotermsPart1 : salesData ? salesData.IncotermsPart1 : '',
                IncotermsPart2 : salesData ? salesData.IncotermsPart2 : '',
            },
            CONDITIONS : [],
            PARTNERS: appSettings.Header.PartnerPickers,
            TEXTS : helper.addDefaultTexts(appSettings.Header.Texts, customerDetail.Language),
            ITEMS : [],
        }

        console.log('finish init sales doc');
        component.set('v.needToSimulate', true);
        component.set('v.salesDocDetail', salesDocDetail);
    },

    setSalesDocFromSobject: function(component, helper) {
        debugger;
        return new Promise(function(resolve, reject) {
            console.log('set sales doc from Sobject');
            let sfObject = component.get('v.sfObject');

            if (!sfObject.initFromSObject) {
                return resolve();
            }
            let salesDocDetail = component.get('v.salesDocDetail');
            let appSettings = component.get('v.appSettings');
            let action = component.get('c.initSalesDocDetailFromSFObject');

            action.setParams({
                salesDocDetail: salesDocDetail,
                sfObject: sfObject,
                appSettings: appSettings
            })

            action.setCallback(this, function(res) {
                console.log('return set Sales doc from sobject');
                helper.handleResponse(component, action.getName(), res, resolve, reject,
                    function(data) {
                        component.set('v.salesDocDetail', data);
                        component.set('v.needToSimulate', data.NeedToSimulate);
                    }
                );
            });

            $A.enqueueAction(action);
        })
    },

    validateSalesAreaAfterLoad: function(component, helper) {
        console.log('hakunama',component.get('v.sfObject'));
        let status = component.get('v.sfObject.status');
        if (status === 'Update') return;

        let salesDocDetail = component.get('v.salesDocDetail');
        let salesDatas = component.get('v.salesDatas');
        let fieldSettings = component.get('v.fieldSettings');

        if (!fieldSettings.Header.SalesOrganization.type || fieldSettings.Header.SalesOrganization.type != 'text') {
            let salesOrganizations = helper.setSalesOrgs(component, salesDatas);
            let valid = false;
            salesOrganizations.forEach(obj => {
                if (obj.SalesOrganization == salesDocDetail.SALES.SalesOrganization) valid = true;
            })

            if (!valid) {
                let salesOrg = salesOrganizations.length > 0 ? salesOrganizations[0].SalesOrganization : '';
                salesDocDetail.SALES.SalesOrganization = salesOrg;
            }
        }

        if (!fieldSettings.Header.DistributionChannel.type || fieldSettings.Header.DistributionChannel.type != 'text') {
            let distributionChannels = helper.setDistributionChannels(component, salesDatas, salesDocDetail.SALES.SalesOrganization);
            let valid = false;
            distributionChannels.forEach(obj => {
                if (obj.DistributionChannel == salesDocDetail.SALES.DistributionChannel) valid = true;
            })

            if (!valid) {
                let distChan = distributionChannels.length > 0 ? distributionChannels[0].DistributionChannel : '';
                salesDocDetail.SALES.DistributionChannel = distChan;
            }
        }

        if (!fieldSettings.Header.Division.type || fieldSettings.Header.Division.type != 'text') {
            let divisions = helper.setDivisions(component, salesDatas, salesDocDetail.SALES.SalesOrganization, salesDocDetail.SALES.DistributionChannel);
            let valid = false;
            divisions.forEach(obj => {
                if (obj.Division == salesDocDetail.SALES.Division) valid = true;
            })

            if (!valid) {
                let division = divisions.length > 0 ? divisions[0].Division : '';
                salesDocDetail.SALES.Division = division;
            }
        }

        component.set('v.salesDocDetail', salesDocDetail);
    },

    addDefaultTexts: function(defaultTexts, language) {
        let texts = [];

        if (defaultTexts) {
            for (let [key, value] of Object.entries(defaultTexts)) {
                texts.push({
                    TextID: key,
                    TextIDDescription: value,
                    TextLanguage: language
                });
            }
        }

        return texts;
    },

    addMaterials: function(component, helper, materials, selectedSerial) {
        let salesDocDetail = component.get('v.salesDocDetail');
        let customerDetail = component.get('v.customerDetail');
        let sfObject = component.get('v.sfObject');
        let increment = component.get('v.appSettings.itemNumberIncrement');

        // Get the current highest item number
        let itemNumber = helper.getNextItemNumber(salesDocDetail, increment, component.get('v.isUpdate'));

        let materialNumbers = materials.map(item => item.material);  
        component.set('v.messages', []);      
        component.set('v.displaySpinner', true);        

        helper.validateProducts(component, materialNumbers, sfObject)
            .then($A.getCallback(function(result) {
                let messages = result.messages;
                let data = result.data;
                component.set('v.messages', messages);
                if (data && data.length) {
                    let validDataSets = new Set(data)
                    materials = materials.filter(mat => validDataSets.has(mat.material));
                    return helper.getMaterialsDetail(component, data, helper)
                }
                else {
                    component.set('v.displaySpinner', false);                 
                    return Promise.reject('invalid Products');
                }
            }))
            .then($A.getCallback(function(result) {
                console.log('return from materials detail');
                
                let currentMaterialsDetail = component.get('v.materialsDetail');
                let appSettings = component.get('v.appSettings');                                      
                
                // Add the valid Materials
                materials.forEach(item => {
                    let matDetail = currentMaterialsDetail[item.material];

                    //let defaultPlant = helper.getDefaultPlant(component, matDetail.Plants)
                    let configurableMaterial = matDetail ? matDetail.ConfigurableMaterial : '';
                    let newItem = {
                        ItemNumber: itemNumber.toString().padStart(6, '0'),
                        AlternativeItem: '000000',
                        HigherLevelItemNumber: '000000',
                        Material: item.material,
                        ItemDescription: item.materialDescription ? item.materialDescription : (matDetail ? matDetail.MaterialDescription : ''),                            
                        OrderQuantity: item.quantity,
                        SalesUnit: item.unitOfMeasure,
                        ConfigurableMaterial: configurableMaterial,
                        isNeedConfigure: configurableMaterial ? true : false,
                        ScheduleLineDate: salesDocDetail.SALES.RequestedDeliveryDate,
                        ItemTexts: helper.addDefaultTexts(appSettings.Item.Texts, customerDetail.Language),
                        PARTNERS: appSettings.Item.PartnerPickers,
                        isAdded: true,
                        BillingPlan: {
                            BillingPlanStartDate: salesDocDetail.StartDate,
                            BillingPlanEndDate: salesDocDetail.EndDate
                        },
                        ItemConditions: [],
                        SBOItemConditions: []
                    }                        
                    
                    itemNumber += increment;
                    salesDocDetail.ITEMS.push(newItem);
                });

                component.set('v.salesDocDetail', salesDocDetail);

                if (appSettings.autoSimulate.afterItemAdd) {
                    return helper.simulateSalesDoc(component, helper);
                }
                else return Promise.resolve();
            }))
            .then($A.getCallback(function() {
                console.log('resolve simulate');
                component.set('v.displaySpinner', false);
            }), function(res) {
                console.log('reject simulate');
                component.set('v.displaySpinner', false);
            })
    },

    getDefaultPlant: function(component, plants) {
        let salesOrganization = component.get('v.salesDocDetail.SALES.SalesOrganization');
        let distributionChannel = component.get('v.salesDocDetail.SALES.DistributionChannel');
        let plant = plants.find(item => 
            item.SalesOrganization === salesOrganization && 
            item.DistributionChannel === distributionChannel 
        )
        return plant;
    },

    validateProducts: function(component, materials, sfObject) {
        return new Promise(function(resolve, reject) {
            let pricebookId = sfObject.pricebookId;
            let updateLineItems = component.get('v.appSettings.updateLineItems');
            if (!pricebookId || !updateLineItems) {
                return resolve({data: materials});
            }

            let action = component.get('c.validateProductsInSalesforce')
            action.setParams({
                materials: materials,
                pricebookId: pricebookId
            })
            action.setCallback(this, function(res) {
                let response = res.getReturnValue();
                if (response) resolve(response);
            })
            $A.enqueueAction(action);
        })
    },

    getMaterialsDetail: function(component, materials, helper) {
        return new Promise(function(resolve, reject) {
            console.log('get materials detail');
            
            let currentMaterialsDetail = component.get('v.materialsDetail');
            let materialsNeedDetail = materials.filter(material => !currentMaterialsDetail[material]);

            if (!materialsNeedDetail.length) {
                resolve(null);
                return;
            }

            let action = component.get('c.getMaterialsDetail');            
            
            action.setParams({
                materials: materialsNeedDetail,
                salesOrg: component.get('v.salesDocDetail.SALES.SalesOrganization'),
                distChannel: component.get('v.salesDocDetail.SALES.DistributionChannel')
            })
            action.setCallback(this, function(res) {
                console.log('return materials detail');
                helper.handleResponse(component, action.getName(), res, resolve, reject,
                    function(data) {
                        if (data) {
                            for (let material in data) {
                                let materialDetail = data[material];
                                currentMaterialsDetail[material] = materialDetail;
                            }
                            component.set('v.materialsDetail', currentMaterialsDetail);
                        }
                    }
                )            
            })
            $A.enqueueAction(action);
        })
    },

    simulateSalesDoc: function(component, helper) {
        return new Promise(function(resolve, reject) {
            console.log('simulate sales doc');
            let salesDocDetail = component.get('v.salesDocDetail');
            if (!component.get('v.needToSimulate')) {
                console.log('skip simulate');
                resolve(true);
                return;
            }

            let action = component.get('c.simulateSalesDoc');
            action.setParams({
                salesDocDetail: salesDocDetail,
                appSettings: component.get('v.appSettings')
            })
            action.setCallback(this, function(res) {
                console.log('return simulate sales doc');
                helper.handleResponse(component, action.getName(), res, resolve, reject,
                    function(data) {
                        if (data) {
                            component.set('v.salesDocDetail', data);

                            if (!component.get('v.hasConditions')) {
                                component.set('v.hasConditions', true);
                                helper.getConditions(component, true, helper);
                                helper.getConditions(component, false, helper);
                            }

                            component.set('v.needToSimulate', false);
                            let messages = component.get('v.messages');

                            let isError = false;
                            for (let index in messages) {
                                if (messages[index].messageType === 'ERROR') {
                                    isError = true;
                                }
                            }
                            if (isError) {
                                component.set('v.needToSimulate', true);
                                return reject(false);
                            }
                        }
                    }
                );
            });

            $A.enqueueAction(action);
        })
    },

    setEditableItemCondition: function(allItemConditions, salesDocItem, conditionType, newValue) {
        let itemConditions = salesDocItem.ItemConditions;
        let itemConditionFound = false;
        itemConditions.forEach(cond => {
            if (cond.ConditionType === conditionType) {
                cond.Rate = newValue;
                itemConditionFound = true;
            }
        });
        if (!itemConditionFound) {
            let condition = allItemConditions.find(cond => cond.ConditionType === conditionType);
            if (condition) {
                let newPriceCondition = {
                    ConditionType: condition.ConditionType,
                    ConditionTypeName: condition.KSCHL_TEXT,
                    Rate: newValue,
                    CalculationType: condition.KRECH
                }
                salesDocItem.ItemConditions.push(newPriceCondition);
            }                    
        }
    },

    saveToSObject: function(component, helper) {
        return new Promise(function(resolve, reject) {
            console.log('save To SObject');
            let action = component.get('c.saveToSObject');

            action.setParams({
                sfObject: component.get('v.sfObject'),
                salesDocDetail: component.get('v.salesDocDetail'),
                updateLineItems: component.get('v.appSettings.updateLineItems')
            })

            action.setCallback(this, function(res) {
                console.log('finish save to sobject');
                helper.handleResponse(component, action.getName(), res, resolve, reject,
                    function(data) {
                        if (data) return resolve();
                        else return reject();
                    }
                )
            })

            $A.enqueueAction(action);
        });
    },

    create: function(component, helper) {
        return new Promise(function(resolve, reject) {
            console.log('create sap document');
            component.set('v.messages', []);
            let isValid = helper.validateRequiredFields(component); 

            if (isValid) {
                component.set('v.displaySpinner', true);
                let created = component.get('v.isUpdate') ? 'Updated' : 'Created';

                helper.createSAPDocument(component, helper)
                    .then(function(res) {
                        console.log('create success');
                        helper.showToast(
                            $A.get("$Label.c.Enosix_SalesDoc_Message_SuccessTitle"),
                            'SAP ' + component.get('v.appSettings.SAPDocType') + ' Successfully ' + created + ': ' + res, 'success');
                        helper.navigateToDetail(component);
                    })
                    .catch(function() {
                        console.log('fail create here');
                        component.set('v.displaySpinner', false);
                    })
            }
            else return resolve();
        });
    },

    createSAPDocument: function(component, helper) {
        return new Promise(function(resolve, reject) {
            console.log('create SAP Document');
            let sfObject = component.get('v.sfObject');
            let salesDocDetail = component.get('v.salesDocDetail');
            let action = component.get('c.createSAPDocument');

            if (salesDocDetail.SalesDocument) action = component.get('c.updateSAPDocument');

            action.setParams({
                sfObject: sfObject,
                salesDocDetail: salesDocDetail,
                appSettings: component.get('v.appSettings')
            })

            action.setCallback(this, function(res) {
                console.log('finish create SAP Document');
                helper.handleResponse(component, action.getName(), res, resolve, reject,
                    function(data) {
                        if (data) {
                            let salesDocDetail = data;
                            let messages = component.get('v.messages');
                            let isError = false;
                            for (let index in messages) {
                                if (messages[index].messageType === 'ERROR') {
                                    isError = true;
                                    break;
                                }
                            }
                            if (isError) {
                                return reject(false);
                            }
                            else if (salesDocDetail.IsSuccess) {
                                component.set('v.sapDocNumber', salesDocDetail.SalesDocument);
                                return resolve(salesDocDetail.SalesDocument);
                            }
                        }
                    }
                )
            })

            $A.enqueueAction(action);
        })
    },

    groupItems: function(component) {
        let salesDocDetail = component.get('v.salesDocDetail');
        let items = salesDocDetail.ITEMS;
        let itemsWithAlternative = items.filter(
            item => item.AlternativeItem && !isNaN(parseInt(item.AlternativeItem)) && (parseInt(item.AlternativeItem) != 0));

        if (itemsWithAlternative.length) {
            // Create a Map of Alternative Item Number => Items
            let alternativeItemsMap = new Map();
            itemsWithAlternative.forEach(item => {
                let alternativeItemNum = parseInt(item.AlternativeItem);
                let values = alternativeItemsMap.get(alternativeItemNum);
                if (!values) {
                    alternativeItemsMap.set(alternativeItemNum, [item]);
                } else {
                    values.push(item);
                    alternativeItemsMap.set(alternativeItemNum, values);
                }
            });

            let newItemsList = [];

            items.forEach(item => {
                if (!item.AlternativeItem || parseInt(item.AlternativeItem) == 0) {
                    newItemsList.push(item);
                    if (alternativeItemsMap.has(parseInt(item.ItemNumber))) {
                        let arrayValues = alternativeItemsMap.get(parseInt(item.ItemNumber));
                        newItemsList.push.apply(newItemsList, arrayValues);
                    }
                }
            });

            component.set('v.salesDocDetail.ITEMS', newItemsList);
        }
    },

    removeItems: function(component, row) {
        let removedItems = component.get('v.salesDocDetail.removedItems');
        let items = component.get('v.salesDocDetail.ITEMS');
        let newItems = [];
        let previousItemNumber;
        let isUpdate = component.get('v.isUpdate');
        
        if (!removedItems) removedItems = [];
        removedItems.push(row.ItemNumber);

        if (isUpdate) {
            newItems = items.filter(item =>
                item.ItemNumber !== row.ItemNumber && item.HigherLevelItemNumber !== row.ItemNumber);
        }
        else {
            // Order the Item in sequence
            items.forEach(function(item) {
                if (item.ItemNumber < row.ItemNumber) {
                    newItems.push(item);
                } 
                else {
                    if (item.ItemNumber === row.ItemNumber) {
                        previousItemNumber = item.ItemNumber;
                    } 
                    else if (item.HigherLevelItemNumber === '000000') {
                        let previousItemNumberTemp = item.ItemNumber;
                        item.ItemNumber = previousItemNumber;
                        previousItemNumber = previousItemNumberTemp;
                        newItems.push(item);
                    }
                }
            });
        }

        component.set('v.salesDocDetail.ITEMS', newItems);
        component.set('v.salesDocDetail.removedItems', removedItems);
    },

    editItem: function(component, row, helper, isReadOnly) {
        component.set('v.displaySpinner', true);
        let rejectionReasons = component.get('v.rejectionReasons');
        let allItemConditions = component.get('v.allItemConditions');
        let salesDocDetail = component.get('v.salesDocDetail');
        let salesOrganization = salesDocDetail.SALES.SalesOrganization;
        let distributionChannel = salesDocDetail.SALES.DistributionChannel;
        let priceLists = component.get('v.priceLists');

        // If the detail of Material is not found, need to do a callout
        // This is primarily when user have save line items to CPQ LineItems
        // And get back to Sales Doc Create it doesn't have the material detail from SAP yet
        this.getMaterialsDetail(component, [row.Material], helper)
            .then($A.getCallback(function(result) {
                console.log('return from materials detail');
                
                let currentMaterialsDetail = component.get('v.materialsDetail');

                let plants = [];
                let materialDetail = currentMaterialsDetail[row.Material];
                plants = materialDetail.Plants.filter(plant =>
                    plant.SalesOrganization === salesOrganization &&
                    plant.DistributionChannel === distributionChannel    
                )  

                helper.openEditItemComponent(component, salesDocDetail, row, plants, rejectionReasons, allItemConditions, priceLists, isReadOnly);        
            }))
    },

    openEditItemComponent: function(component, salesDocDetail, row, plants, rejectionReasons, allItemConditions, priceLists, isReadOnly) {
        $A.createComponent('c:CMP_SalesDocEditItem', {
            'salesDocDetail': salesDocDetail,
            'item': row,
            'plants': plants,
            'rejectionReasons': rejectionReasons,
            'allItemConditions': allItemConditions,
            'priceLists': priceLists,
            'isReadOnly': isReadOnly,
            'billingPlans': component.get('v.billingPlans'),
            'appSettings': component.get('v.appSettings'),
            'fieldSettings': component.get('v.fieldSettings.ItemEdit')
        },
        function (content, status, errorMessage) {
            if (status === 'SUCCESS') {
                content.addEventHandler('editItemEvent', 
                    component.getReference('c.updateItem'));
                component.set('v.displaySpinner', false);
                component.find('overlayLib1')
                    .showCustomModal({
                        header: isReadOnly ? $A.get('$Label.c.Enosix_SalesDoc_Title_ViewItem') : $A.get('$Label.c.Enosix_SalesDoc_Title_EditItem'),
                        body: content,
                        showCloseButton: true,
                        closeCallback: function () {}
                    })
            }
        })
    },

    configureItem: function(component, row) {
        debugger;
        component.set('v.displaySpinner', true);
        let salesDocDetail = component.get('v.salesDocDetail');
        let headerJson = {
            salesDocType: salesDocDetail.SALES.SalesDocumentType,
            salesOrg: salesDocDetail.SALES.SalesOrganization,
            salesDistChannel: salesDocDetail.SALES.DistributionChannel,
            salesDivision: salesDocDetail.SALES.Division,
            soldToParty: salesDocDetail.SoldToParty,            
            priceList: salesDocDetail.SALES.PriceListType
        }

        let itemJson = {
            plant: row.Plant,
            orderQuantity: row.OrderQuantity,
            selectedCharacteristics: row.ItemConfigurations,
            ReferenceSalesOrderNumber: row.ReferenceSalesOrderNumber,
            ReferenceSalesOrderItemNumber: row.ReferenceSalesOrderItemNumber,
            requestedDeliveryDate: row.ScheduleLineDate,
        };

        $A.createComponent('c:CMP_VCMaterialConfiguration', {        
            'isLightningFlow': false,
            'itemNumber': row.ItemNumber,
            'materialId': row.Material,
            'isDisplayRequiredOnly': true,
            'headerJSON': JSON.stringify(headerJson),
            'itemJSON': JSON.stringify(itemJson),
            'isReferenceFromSalesOrder': row.isReferenceFromSalesOrder
        },
        function(content, status, errorMessage) {
            if (status === "SUCCESS") {
                content.addEventHandler('confirmfinalized',
                    component.getReference('c.onFinalizeConfiguration'));
                component.set('v.displaySpinner', false);
                component.find('overlayLib1')
                    .showCustomModal({
                        body: content,
                        showCloseButton: true,
                        closeCallback: function () {}
                    })
            }
            else if (status === 'ERROR' && !content) {
                component.set('v.displaySpinner', false);
                let messages = [{
                    messageType: 'ERROR', 
                    message: $A.get('$Label.c.Enosix_SalesDoc_Message_VCUnavailable')
                }]
                component.set('v.messages', messages);
            }
        })
    },

    getShipInfo: function(component, helper) {
        return new Promise(function(resolve, reject) {
            let fieldSettings = component.get('v.fieldSettings');
            if (fieldSettings.Header.PaymentTerms.display ||
                fieldSettings.Header.FreightTerms.display ||
                fieldSettings.Header.ShippingConditions.display)
            {
                console.log('getShipInfo');
                let action = component.get('c.getShipInfo');
                action.setCallback(this, function(res) {
                    console.log('return shipInfo');
                    helper.handleResponse(component, action.getName(), res, resolve, reject,
                        function(data) {
                            if (data) {
                                let paymentTerms = data.ET_PAY_TERMS_List.filter(item => item.ZTERM);
                                let freightTerms = data.ET_FREIGHT_TERMS_List.filter(item => item.INCO1);
                                let shippingConditions = data.ET_SHIP_COND_List.filter(item => item.ShippingConditions);
                                component.set('v.paymentTerms', paymentTerms);
                                component.set('v.incoTerms', freightTerms);
                                component.set('v.shippingConditions', shippingConditions);
                            }
                        }
                    );
                })

                $A.enqueueAction(action);
            }
            else resolve(true);
        })
    },

    getPricingStat: function(component, helper) {
        return new Promise(function(resolve, reject) {
            let fieldSettings = component.get('v.fieldSettings');
            if (fieldSettings.ItemEdit.PriceList.display) {
                console.log('getPricingStat');
                let action = component.get('c.getPricingStat');
                action.setCallback(this, function(res) {
                    console.log('return pricing stat');
                    helper.handleResponse(component, action.getName(), res, resolve, reject,
                        function(data) {
                            if (data) {
                                let priceGroups = data.ET_CUST_PRICE_GRP_List.filter(item => item.KONDA);
                                let priceLists = data.ET_CUST_PRICE_LIST_List.filter(item => item.PLTYP);
                                component.set('v.priceGroups', priceGroups);
                                component.set('v.priceLists', priceLists);
                            }
                        }
                    )
                })

                $A.enqueueAction(action);
            }
            else resolve(true);
        })
    },

    getGroupOffice: function(component, helper) {
        return new Promise(function(resolve, reject) {
            let fieldSettings = component.get('v.fieldSettings');
            if (fieldSettings.Header.SalesOffice.display ||
                fieldSettings.Header.SalesGroup.display ||
                fieldSettings.Header.SalesDistrict.display)
            {
                console.log('get group office');
                let action = component.get('c.getGroupOffice');
                action.setCallback(this, function(res) {
                    console.log('return group office');
                    helper.handleResponse(component, action.getName(), res, resolve, reject,
                        function(data) {
                            if (data) {
                                let salesDocDetail = component.get('v.salesDocDetail');
                                let salesDistricts = data.ET_SALES_DISTRICT_List.filter(item => item.BZIRK);
                                let salesOffices = data.ET_SALES_OFFICE_List.filter(item => item.VKBUR);
                                let salesGroups = data.ET_SALES_GROUP_List.filter(item => item.SalesGroup);
                                component.set('v.salesDistricts', salesDistricts);
                                component.set('v.salesOffices', salesOffices);
                                component.set('v.salesGroups', salesGroups);
                                helper.filterSalesOffice(component, helper, salesDocDetail);
                                component.set('v.salesDocDetail', salesDocDetail);
                            }
                        }
                    )
                })

                $A.enqueueAction(action);
            }
            else resolve(true);
        })
    },

    getConditions: function(component, isHeader, helper) {
        return new Promise(function(resolve, reject) {
            let fieldSettings = component.get('v.fieldSettings');
            if ((isHeader && fieldSettings.Header.ConditionsTab.display) ||
                (!isHeader && fieldSettings.ItemEdit.ConditionsTab.display))
            {
                console.log('get conditions');
                let action = component.get('c.getConditionTypes');
                let salesDocDetail = component.get('v.salesDocDetail');

                // return if salesDocDetail is null
                if (!salesDocDetail) resolve(false);
                
                action.setParams({
                    isHeader: isHeader,
                    pricingProcedure: salesDocDetail.SALES.PricingProcedureInPricing
                });
                action.setCallback(this, function(res) {
                    console.log('return conditions');
                    helper.handleResponse(component, action.getName(), res, resolve, reject,
                        function(data) {
                            if (data) {
                                if (isHeader) {
                                    console.log('header condition');                                
                                    component.set('v.allHeaderConditions', data.ET_CONDITIONS_List);
                                }
                                else {
                                    console.log('item condition');
                                    component.set('v.allItemConditions', data.ET_CONDITIONS_List);
                                }
                            }
                        }
                    )
                })

                $A.enqueueAction(action);
            }
            else resolve(true);
        })
    },

    getRejectionReasons: function(component, helper) {
        return new Promise(function(resolve, reject) {
            let fieldSettings = component.get('v.fieldSettings');
            if (fieldSettings.ItemEdit.RejectionReason.display) {
                console.log('get rejection reason');
                let action = component.get('c.getRejectionReasons');
                action.setCallback(this, function(res) {
                    console.log('return rejection reason');
                    helper.handleResponse(component, action.getName(), res, resolve, reject,
                        function(data) {
                            if (data) {
                                let rejectionReasons = data.ET_VALUES_List.filter(item => item.VALUE);
                                component.set('v.rejectionReasons', rejectionReasons);
                            }
                        }
                    )
                })

                $A.enqueueAction(action);
            }
            else resolve(true);
        })
    },

    getBillingPlans: function(component, helper) {
        return new Promise(function(resolve, reject) {
            let fieldSettings = component.get('v.fieldSettings');
            if (fieldSettings.ItemEdit.BillingPlanTab.display) {
                console.log('get billing plans');
                let action = component.get('c.getBillingPlans');
                action.setCallback(this, function(res) {
                    console.log('return billing plans');
                    helper.handleResponse(component, action.getName(), res, resolve, reject,
                        function(data) {
                            if (data) {
                                let billingPlans = data.OUTPUT_List.filter(item => item.PERIO);
                                component.set('v.billingPlans', billingPlans);
                            }
                        }
                    )
                })

                $A.enqueueAction(action);
            }
            else resolve(true);
        })
    },

    expandSection: function(component, expandId, iconId) {
        let isExpand = component.get(expandId);
        if (isExpand) {
            component.set(expandId, false);
            component.set(iconId, 'utility:chevronright'); 
        }
        else {
            component.set(expandId, true);
            component.set(iconId, 'utility:chevrondown');    
        }
    },

    showToast: function(title, message, type) {
        let toastEvent = $A.get("e.force:showToast");
        
        toastEvent.setParams({
            title: title,
            message: message,
            type: type,
            mode: "dismissible"
        });
        toastEvent.fire();
    },

    navigateToFinish: function(component) {
        let navigate = component.get("v.navigateFlow");
        navigate("FINISH");
    },

    navigateToDetail: function(component) {
        let navigate = component.get("v.navigateFlow");
        navigate("NEXT");
    },

    isNumeric: function(num) {
        return !isNaN(num);
    },

    checkSalesDocDetailChanged: function(component) {
        if(component.get('v.isSalesDocInitialized')) {
            console.log('sales doc detail changed.');
            component.set('v.isConfigurationChanged', true);
            component.set('v.needToSimulate', true);
        }
    },

    addByMaterialNumber: function(component, event, helper) {
        let material = component.get('v.inputMaterial');
        let quantity = component.get('v.inputMaterialQuantity');
        if (material) {
            let materialInput = material.trim().toUpperCase();
            let materials = [{
                material: materialInput,
                quantity: quantity
            }];

            helper.addMaterials(component, helper, materials, null);
            component.set('v.inputMaterial', '');
            component.set('v.inputMaterialQuantity', 1);
        }
    },

    onRowAction: function(component, helper, row, actionName) {
        let needToSimulate = false;
        let appSettings = component.get('v.appSettings');

        switch(actionName) {
            case 'edit_item':
                helper.editItem(component, row, helper, false);
                break;
            case 'view_item':
                helper.editItem(component, row, helper, true);
                break;
            case 'delete_item':
                helper.removeItems(component, row);
                if (appSettings.autoSimulate.afterItemDelete) {
                    needToSimulate = true;
                }
                break;
            case 'configure_item':
                // explicitely set to false
                row.isReferenceFromSalesOrder = false;
                helper.configureItem(component, row);                
                break;
            case 'clone_line':
                helper.cloneLineItem(component, helper, row);
                if (appSettings.autoSimulate.afterItemClone) {
                    needToSimulate = true;
                }
                break;
        }
        
        if (needToSimulate) {   
            component.set('v.displaySpinner', true);
            component.set('v.messages', []);     
            helper.simulateSalesDoc(component, helper)
                .then($A.getCallback(function() {
                    console.log('simulate resolve');
                    component.set('v.displaySpinner', false);
                }), function() {
                    console.log('simulate reject');
                    component.set('v.displaySpinner', false);
                })
        }
    },

    getNextItemNumber: function(salesDocDetail, increment, isUpdate) {
        let itemNumber;
        let removedItems = salesDocDetail.removedItems ? [...salesDocDetail.removedItems] : [];

        if (salesDocDetail.ITEMS.length < 1) {
            if (isUpdate && removedItems.length) {
                removedItems.sort();
                itemNumber = parseInt(removedItems[removedItems.length - 1]) + increment;
            }
            else {
                itemNumber = increment;
            }
        }
        else {
            let itemSize = salesDocDetail.ITEMS.length;
            let lastItem = salesDocDetail.ITEMS[itemSize - 1];
            let lastItemNumber = parseInt(lastItem.ItemNumber);
            lastItemNumber = (lastItemNumber % increment) === 0 ? lastItemNumber : (lastItemNumber - (lastItemNumber % increment));

            if (isUpdate && removedItems.length) {
                removedItems.push(lastItemNumber.toString().padStart(6, '0'));
                removedItems.sort();
                itemNumber = parseInt(removedItems[removedItems.length - 1]) + increment;
            }
            else {
                itemNumber = lastItemNumber + increment;
            }
        }

        return itemNumber;
    },

    cloneLineItem: function(component, helper, row) {
        let salesDocDetail = component.get('v.salesDocDetail');
        let increment = component.get('v.appSettings.itemNumberIncrement');
        let itemNumber = helper.getNextItemNumber(salesDocDetail, increment, component.get('v.isUpdate'));

        let cloneItem = Object.assign({}, row);
        cloneItem.ItemNumber = itemNumber.toString().padStart(6, '0');
        cloneItem.AlternativeItem = '000000';
        cloneItem.isAdded = true;
        cloneItem.SFId = null;
        salesDocDetail.ITEMS.push(cloneItem);

        component.set('v.salesDocDetail', salesDocDetail);
    },

    validateRequiredFields: function(component) {
        let salesDocDetail = component.get('v.salesDocDetail');
        let fieldSettings = component.get('v.fieldSettings');
        let headerFieldSettings = fieldSettings.Header;
        let itemFieldSettings = fieldSettings.ItemEdit;
        let isValid = true;
        let messages = [];

        if (!salesDocDetail.SALES.SalesDocumentType && headerFieldSettings.SalesDocumentType.edit && headerFieldSettings.SalesDocumentType.required) {
            messages.push(this.requiredMessage(null, $A.get('$Label.c.Enosix_SalesDoc_Field_DocumentType')));
            isValid = false;
        }
        if (!salesDocDetail.SoldToParty && headerFieldSettings.SoldTo.edit && headerFieldSettings.SoldTo.required) {
            messages.push(this.requiredMessage(null, $A.get('$Label.c.Enosix_SalesDoc_Field_SoldTo')));
            isValid = false;
        }
        if (!salesDocDetail.SALES.SalesOrganization && headerFieldSettings.SalesOrganization.edit && headerFieldSettings.SalesOrganization.required) {
            messages.push(this.requiredMessage(null, $A.get('$Label.c.Enosix_SalesDoc_Field_SalesOrganization')));
            isValid = false;
        }
        if (!salesDocDetail.SALES.DistributionChannel && headerFieldSettings.DistributionChannel.edit && headerFieldSettings.DistributionChannel.required) {
            messages.push(this.requiredMessage(null, $A.get('$Label.c.Enosix_SalesDoc_Field_DistributionChannel')));
            isValid = false;
        }
        if (!salesDocDetail.SALES.Division && headerFieldSettings.Division.edit && headerFieldSettings.Division.required) {
            messages.push(this.requiredMessage(null, $A.get('$Label.c.Enosix_SalesDoc_Field_Division')));
            isValid = false;
        }
        if (!salesDocDetail.CustomerPurchaseOrderDate && headerFieldSettings.PurchaseOrderDate.edit && headerFieldSettings.PurchaseOrderDate.required) {
            messages.push(this.requiredMessage(null, $A.get('$Label.c.Enosix_SalesDoc_Field_PODate')));
            isValid = false;
        }
        if (!salesDocDetail.SALES.ValidFrom && headerFieldSettings.DateFrom.edit && headerFieldSettings.DateFrom.required) {
            messages.push(this.requiredMessage(null, $A.get('$Label.c.Enosix_SalesDoc_Field_ValidFrom')));
            isValid = false;
        }
        if (!salesDocDetail.SALES.ValidTo && headerFieldSettings.DateTo.edit && headerFieldSettings.DateTo.required) {
            messages.push(this.requiredMessage(null, $A.get('$Label.c.Enosix_SalesDoc_Field_ValidTo')));
            isValid = false;
        }
        if (!salesDocDetail.StartDate && headerFieldSettings.StartDate.edit && headerFieldSettings.StartDate.required) {
            messages.push(this.requiredMessage(null, $A.get('$Label.c.Enosix_SalesDoc_Field_StartDate')));
            isValid = false;
        }
        if (!salesDocDetail.EndDate && headerFieldSettings.EndDate.edit && headerFieldSettings.EndDate.required) {
            messages.push(this.requiredMessage(null, $A.get('$Label.c.Enosix_SalesDoc_Field_EndDate')));
            isValid = false;
        }
        if (!salesDocDetail.SALES.RequestedDeliveryDate && headerFieldSettings.RequestedDate.edit && headerFieldSettings.RequestedDate.required) {
            messages.push(this.requiredMessage(null, $A.get('$Label.c.Enosix_SalesDoc_Field_RequestedDate')));
            isValid = false;
        }
        if (!salesDocDetail.CustomerPurchaseOrderNumber && headerFieldSettings.PurchaseOrderNumber.edit && headerFieldSettings.PurchaseOrderNumber.required) {
            messages.push(this.requiredMessage(null, $A.get('$Label.c.Enosix_SalesDoc_Field_PO')));
            isValid = false;
        }
        if (!salesDocDetail.SALES.TermsofPaymentKey && headerFieldSettings.PaymentTerms.edit && headerFieldSettings.PaymentTerms.required) {
            messages.push(this.requiredMessage(null, $A.get('$Label.c.Enosix_SalesDoc_Field_PaymentTerms')));
            isValid = false;
        }
        if (!salesDocDetail.SALES.IncotermsPart1 && headerFieldSettings.FreightTerms.edit && headerFieldSettings.FreightTerms.required) {
            messages.push(this.requiredMessage(null, $A.get('$Label.c.Enosix_SalesDoc_Field_FreightTerms')));
            isValid = false;
        }
        if (!salesDocDetail.SALES.IncotermsPart2 && headerFieldSettings.TermsText.edit && headerFieldSettings.TermsText.required) {
            messages.push(this.requiredMessage(null, $A.get('$Label.c.Enosix_SalesDoc_Field_TermsText')));
            isValid = false;
        }
        if (!salesDocDetail.ShippingConditions && headerFieldSettings.ShippingConditions.edit && headerFieldSettings.ShippingConditions.required) {
            messages.push(this.requiredMessage(null, $A.get('$Label.c.Enosix_SalesDoc_Field_ShippingConditions')));
            isValid = false;
        }
        if (!salesDocDetail.SALES.DateforPricingExchangeRate && headerFieldSettings.PricingDate.edit && headerFieldSettings.PricingDate.required) {
            messages.push(this.requiredMessage(null, $A.get('$Label.c.Enosix_SalesDoc_Field_PricingDate')));
            isValid = false;
        }
        if (!salesDocDetail.SalesDocumentCurrency && headerFieldSettings.Currency.edit && headerFieldSettings.Currency.required) {
            messages.push(this.requiredMessage(null, $A.get('$Label.c.Enosix_SalesDoc_Field_Currency')));
            isValid = false;
        }

        if (headerFieldSettings.Texts.edit && headerFieldSettings.Texts.required) {
            for (let index in salesDocDetail.TEXTS) {
                let text = salesDocDetail.TEXTS[index];
                if (!text.Text) {
                    messages.push(this.requiredMessage(null, text.TextIDDescription));
                    isValid = false;
                }
            }
        }

        for (let index in salesDocDetail.ITEMS) {
            let item = salesDocDetail.ITEMS[index];
            if (!item.AlternativeItem && itemFieldSettings.AlternativeItem.edit && itemFieldSettings.AlternativeItem.required) {
                messages.push(this.requiredMessage(item.ItemNumber, $A.get('$Label.c.Enosix_SalesDoc_Field_AlternativeItem')));
                isValid = false;
            }
            if (!item.ItemDescription && itemFieldSettings.ItemDescription.edit && itemFieldSettings.ItemDescription.required) {
                messages.push(this.requiredMessage(item.ItemNumber, $A.get('$Label.c.Enosix_SalesDoc_Field_ItemDescription')));
                isValid = false;
            }
            if (!item.OrderQuantity && itemFieldSettings.Quantity.edit && itemFieldSettings.Quantity.required) {
                messages.push(this.requiredMessage(item.ItemNumber, $A.get('$Label.c.Enosix_SalesDoc_Field_Quantity')));
                isValid = false;
            }
            if (!item.ScheduleLineDate && itemFieldSettings.RequestedDate.edit && itemFieldSettings.RequestedDate.required) {
                messages.push(this.requiredMessage(item.ItemNumber, $A.get('$Label.c.Enosix_SalesDoc_Field_RequestedDate')));
                isValid = false;
            }
            if (!item.Plant && itemFieldSettings.Plant.edit && itemFieldSettings.Plant.required) {
                messages.push(this.requiredMessage(item.ItemNumber, $A.get('$Label.c.Enosix_SalesDoc_Field_Plant')));
                isValid = false;
            }
            if (!item.RejectionReason && itemFieldSettings.RejectionReason.edit && itemFieldSettings.RejectionReason.required) {
                messages.push(this.requiredMessage(item.ItemNumber, $A.get('$Label.c.Enosix_SalesDoc_Field_RejectionReason')));
                isValid = false;
            }
            if (!item.PriceListType && itemFieldSettings.PriceList.edit && itemFieldSettings.PriceList.required) {
                messages.push(this.requiredMessage(item.ItemNumber, $A.get('$Label.c.Enosix_SalesDoc_Field_PriceList')));
                isValid = false;
            }
            if (!item.ItemCategory && itemFieldSettings.ItemCategory.edit && itemFieldSettings.ItemCategory.required) {
                messages.push(this.requiredMessage(item.ItemNumber, $A.get('$Label.c.Enosix_SalesDoc_Field_ItemCategory')));
                isValid = false;
            }

            if (itemFieldSettings.Texts.edit && itemFieldSettings.Texts.required) {
                for (let indexText in item.ItemTexts) {
                    let itemText = item.ItemTexts[indexText];
                    if (!itemText.Text) {
                        messages.push(this.requiredMessage(item.ItemNumber, itemText.TextIDDescription));
                        isValid = false;
                    }
                }
            }
        }

        component.set('v.messages', messages);
        return isValid;
    },

    requiredMessage: function(itemNumber, fieldLabel) {
        let prefixLabel = itemNumber ? ('Item ' + itemNumber + ', ' + fieldLabel) : fieldLabel;
        let message = {
            messageType: 'ERROR',
            message: prefixLabel + ' is Required'
        }

        return message;
    },

    getFieldSettings: function(component) {
        let appSettings = component.get('v.appSettings');
        let status = component.get('v.sfObject.status');
        if (component.get('v.salesDocDetail.SalesDocument')) {
            status = 'Update';
            component.set('v.sfObject.status', status);
        }

        let fieldSettings = appSettings[status];
        component.set('v.fieldSettings', fieldSettings);
    },

    onSalesAreaChange: function(component, event, helper) {
        // change on Sales Area
        let salesDocDetail = component.get('v.salesDocDetail');
        let salesDatas = component.get('v.salesDatas');
        let appSettings = component.get('v.appSettings');
        let fieldSettings = component.get('v.fieldSettings');

        let inputName = event.getSource().get('v.name');
        if (inputName === 'salesOrg' && (!fieldSettings.Header.DistributionChannel.type ||
            fieldSettings.Header.DistributionChannel.type != 'text')) {
            let distributionChannels = helper.setDistributionChannels(component, salesDatas, salesDocDetail.SALES.SalesOrganization);
            let distChan = distributionChannels.length > 0 ? distributionChannels[0].DistributionChannel : '';
            salesDocDetail.SALES.DistributionChannel = distChan;
        }

        if ((inputName === 'salesOrg' || inputName === 'distChannel') && (!fieldSettings.Header.Division.type || fieldSettings.Header.Division.type != 'text')) {
            let divisions = helper.setDivisions(component, salesDatas, salesDocDetail.SALES.SalesOrganization, salesDocDetail.SALES.DistributionChannel);
            let division = divisions.length > 0 ? divisions[0].Division : '';
            salesDocDetail.SALES.Division = division;
        }

        let salesData = salesDatas.find(sd =>
            sd.SalesOrganization === salesDocDetail.SALES.SalesOrganization &&
            sd.DistributionChannel === salesDocDetail.SALES.DistributionChannel &&
            sd.Division === salesDocDetail.SALES.Division);

        if (salesData) {
            // Redetermined some Sales fields
            salesDocDetail.SALES.TermsofPaymentKey = salesData.TermsofPaymentKey;
            salesDocDetail.SALES.IncotermsPart1 = salesData.IncotermsPart1;
            salesDocDetail.SALES.IncotermsPart2 = salesData.IncotermsPart2;
            salesDocDetail.SALES.SalesOffice = salesData.SalesOffice;
            salesDocDetail.SALES.PriceListType = salesData.PriceListType;
            salesDocDetail.ShippingConditions = salesData.ShippingConditions;
            salesDocDetail.SalesDocumentCurrency = salesData.CurrencyKey;
        }

        helper.filterSalesOffice(component, helper, salesDocDetail);

        component.set('v.salesDocDetail', salesDocDetail);

        if (appSettings.autoSimulate.afterFieldUpdate && 
            (fieldSettings.Header.SalesOrganization.simulate ||
            fieldSettings.Header.DistributionChannel.simulate ||
            fieldSettings.Header.Division.simulate)) 
        {
            component.set('v.displaySpinner', true);
            component.set('v.messages', []);

            helper.simulateSalesDoc(component, helper)
                .then($A.getCallback(function() {
                    console.log('success simulate');
                    component.set('v.displaySpinner', false);
                }), function() {
                    console.log('reject simulate');
                    component.set('v.displaySpinner', false);
                });
        }
    },

    filterSalesOffice: function(component, helper, salesDocDetail) {
        let salesOffices = component.get('v.salesOffices');
        let filteredSalesOffices = [];
        if (salesOffices && salesOffices.length > 0) {
            filteredSalesOffices = salesOffices.filter(item => 
                item.SalesOrganization === salesDocDetail.SALES.SalesOrganization &&
                item.DistributionChannel === salesDocDetail.SALES.DistributionChannel &&
                item.Division === salesDocDetail.SALES.Division);
            let currentSalesOffice = filteredSalesOffices.find(item => item.VKBUR === salesDocDetail.SALES.SalesOffice );
            if (!currentSalesOffice) salesDocDetail.SALES.SalesOffice = '';
            helper.onSalesOfficeChange(component, helper, salesDocDetail);
        }
        component.set('v.filteredSalesOffices', filteredSalesOffices);
    },

    onSalesOfficeChange: function(component, helper, salesDocDetail) {
        // change on Sales Office
        let salesGroups = component.get('v.salesGroups');
        let filteredSalesGroups = [];
        if (salesGroups && salesGroups.length > 0) {
            filteredSalesGroups = salesGroups.filter(item => 
                item.VKBUR == salesDocDetail.SALES.SalesOffice);
            let currentSalesGroup = filteredSalesGroups.find(item => item.SalesGroup === salesDocDetail.SALES.SalesGroup );
            if (!currentSalesGroup) salesDocDetail.SALES.SalesGroup = '';
        }
        component.set('v.filteredSalesGroups', filteredSalesGroups);
    },

    onFieldChange: function(component, event, helper) {
        let inputName = event.getSource().get('v.name');
        let appSettings = component.get('v.appSettings');
        let fieldSettings = component.get('v.fieldSettings');
        let field = fieldSettings.Header[inputName];

        if (appSettings.autoSimulate.afterFieldUpdate && (field && field.simulate)) {
            console.log('field changed, do simulate');
            component.set('v.displaySpinner', true);
            component.set('v.messages', []);

            helper.simulateSalesDoc(component, helper)
                .then($A.getCallback(function() {
                    console.log('success simulate');
                    component.set('v.displaySpinner', false);
                }), function() {
                    console.log('reject simulate');
                    component.set('v.displaySpinner', false);
                });
        }
    },

    handleResponse: function (component, method, response, resolve, reject, dataFunction)
    {
        let state = response.getState();
        if (state === "SUCCESS") {
            let returnValue = response.getReturnValue();
            if (returnValue) {
                let messages = returnValue.messages;
                if (messages && messages.length > 0) {
                    let vMessages = component.get('v.messages');
                    if (!vMessages) vMessages = [];
                    vMessages.push(...messages);
                    component.set('v.messages', vMessages);
                }
                if (dataFunction) dataFunction(returnValue.data);
            }
            if (resolve) resolve(true);
        } 
        else {
            let messages = [];
            messages.push({message: 'There was an error in CTRL_SalesDocCreateUpdate.' + method, messageType: "ERROR"});

            let errors = response.getError();
            if (errors) {
                for (let errCnt in errors) {
                    let fieldErrors = errors[errCnt].fieldErrors;
                    if (fieldErrors) {
                        messages.push({message: fieldErrors, messageType: "ERROR"});
                    }
                    let pageErrors = errors[errCnt].pageErrors;
                    if (pageErrors) {
                        for (let pageCnt in pageErrors) {
                            messages.push({message: pageErrors[pageCnt].message, messageType: "ERROR"});
                        }
                    }
                    let message = errors[errCnt].message;
                    if (message) {
                        messages.push({message: message, messageType: "ERROR"});
                    }
                }
            }
            let vMessages = component.get('v.messages');
            if (!vMessages) vMessages = [];
            vMessages.push(...messages);
            component.set('v.messages', vMessages);
            if (reject) reject('There was an error in CTRL_SalesDocCreateUpdate.' + method);
        }
    }
})