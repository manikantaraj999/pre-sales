({
    refresh: function (component, event, helper) {
        let docNum = window.getUrlParameter('c__sapDocNum');
        if (docNum) {
            component.set('v.sapDocumentId', docNum);
        } else {
            docNum = component.get('v.sapDocumentId');
        }
        if (!docNum) {
            component.set('v.displaySpinner', false);
            return;
        }

        let recordId = window.getUrlParameter('c__recordId');
        if (recordId) {
            component.set('v.recordId', recordId);
        } else {
            recordId = component.get('v.recordId');
        }

        component.set('v.displaySpinner', true);
        component.find("dataSource").getContractDetail(docNum, function (result) {
            let data = result.data;
            component.set('v.contractDetail', data);
            component.set('v.messages', result.messages);
            // let customFieldPicklistPreset = component.get('v.customFieldPicklistPreset');
            // if (data.USER_DEFINED && data.USER_DEFINED.asList && data.USER_DEFINED.asList.length > 0 && customFieldPicklistPreset) {
            //     component.find("customFields").getCustomFieldsPresets(customFieldPicklistPreset, function (fieldResult) {
            //         if (fieldResult.data.customFieldPresetParameters && fieldResult.data.customFieldPresetParameters.length > 0) {
            //             helper.displayCustomFields(component, data.USER_DEFINED.asList, fieldResult.data.customFieldPresetParameters, fieldResult.data.namespace);
            //         }
            //     })
            // }
            component.set('v.displaySpinner', false)
        });
    },

    // displayCustomFields: function (component, customFields, customPresets, namespace) {
    //     let fieldCounter = 1;
    //     for (let customField in customFields) {
    //         for (let customPreset in customPresets) {
    //             if (customPresets[customPreset][namespace + 'SAP_Field__c'] == customFields[customField].FIELD) {
    //                 let label = customPresets[customPreset][namespace + 'Label__c'];
    //                 if (!$A.util.isEmpty(customPresets[customPreset][namespace + 'Custom_Label__c'])) {
    //                     let labelReference = $A.getReference("$Label.c." + customPresets[customPreset][namespace + 'Custom_Label__c']);
    //                     label = labelReference;
    //                 }
    //                 $A.createComponent(
    //                     'c:CMP_Card_Custom_Field', {
    //                         'label': label,
    //                         'value': customFields[customField].VALUE
    //                     },
    //                     function (newField) {
    //                         let col = 'col1';
    //                         if (fieldCounter % 2 == 0) {
    //                             col = 'col2';
    //                         }
    //                         let column = component.find(col);
    //                         let body = column.get('v.body');
    //                         body.push(newField);
    //                         column.set('v.body', body);
    //                         ++fieldCounter;
    //                     });
    //             }
    //         }
    //     }
    // }
})