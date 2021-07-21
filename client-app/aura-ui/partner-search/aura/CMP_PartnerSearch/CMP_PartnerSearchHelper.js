({
    buildColumns: function(component) {
        let columns = [];
        let searchType = component.get('v.searchType');

        switch (searchType) {
            case 'Partner':
                columns.push(
                    {label: 'Partner Number', fieldName: 'PartnerNumber', type: 'text'},
                    {label: 'Partner Name', fieldName: 'PartnerName', type: 'text'});
                break;
            case 'Vendor':
                columns.push(
                    {label: 'Vendor Number', fieldName: 'VendorNumber', type: 'text'},
                    {label: 'Vendor Name', fieldName: 'VendorName', type: 'text'});
                break;
            case 'Contact':
                columns.push(
                    {label: 'Contact Number', fieldName: 'ContactNumber', type: 'text'},
                    {label: 'Contact First Name', fieldName: 'ContactFirstName', type: 'text'},
                    {label: 'Contact Last Name', fieldName: 'ContactLastName', type: 'text'});
                break;
            case 'Personnel':
                columns.push(
                    {label: 'Personnel Number', fieldName: 'PersonnelNumber', type: 'text'},
                    {label: 'Personnel First Name', fieldName: 'PersonnelFirstName', type: 'text'},
                    {label: 'Personnel Last Name', fieldName: 'PersonnelLastName', type: 'text'});
                break;
            default:
                break;
        }

        columns.push(
            {label: 'House Number', fieldName: 'HouseNumber', type: 'text'},
            {label: 'Street', fieldName: 'Street', type: 'text'},
            {label: 'City', fieldName: 'City', type: 'text'},
            {label: 'Region', fieldName: 'Region', type: 'text'},
            {label: 'Postal Code', fieldName: 'PostalCode', type: 'text'},
            {label: 'Country', fieldName: 'Country', type: 'text'});

        component.set('v.columns', columns);
    },

    searchPartners: function(component, pagingOptions) {
        return new Promise(function(resolve, reject) {            
            let action = component.get('c.searchPartners');
            let salesArea = component.get('v.salesArea');

            action.setParams({
                customerNumber: component.get('v.customerNumber'),
                partnerFunction: component.get('v.partnerFunction'),
                salesOrg: salesArea.SalesOrganization,
                distChannel : salesArea.DistributionChannel,
                division : salesArea.Division,
                pagingOptions: pagingOptions
            });

            action.setCallback(this, function(res) {
                console.log('return search partners')
                if (res.getReturnValue()) {
                    let response = res.getReturnValue()
                    let data = response.data;
                    component.set('v.pagingOptions', response.pagingOptions);

                    if (data) {
                        let parsedData = JSON.parse(data);
                        component.set('v.displayResults', parsedData);
                    }
                    else component.set('v.displayResults', []);

                    if (response.messages) {
                        component.set('v.messages', response.messages);
                    }
                }
                resolve(true);                
            })

            $A.enqueueAction(action);
        });
    },

    buildSelectedPartner: function(component, selectedRow) {
        let selectedPartner = {
            PartnerFunction: component.get('v.partnerFunction'),
            PartnerFunctionName: component.get('v.partnerFunctionName'),
            HouseNumber: selectedRow.HouseNumber,
            Street: selectedRow.Street,
            City: selectedRow.City,
            PostalCode: selectedRow.PostalCode,
            Region: selectedRow.Region,
            Country: selectedRow.Country
        }

        if (selectedRow.PartnerNumber) {
            selectedPartner.CustomerNumber = selectedRow.PartnerNumber;
            selectedPartner.PartnerName = selectedRow.PartnerName;
        }
        else if (selectedRow.VendorNumber) {
            selectedPartner.Vendor = selectedRow.VendorNumber;
            selectedPartner.PartnerName = selectedRow.VendorName;
        }
        else if (selectedRow.ContactPersonNumber) {
            selectedPartner.ContactPersonNumber = selectedRow.ContactPersonNumber;
            selectedPartner.PartnerName = selectedRow.ContactFirstName + ' ' + selectedRow.ContactLastName;
        }
        else if (selectedRow.PersonnelNumber) {
            selectedPartner.PersonnelNumber = selectedRow.PersonnelNumber;
            selectedPartner.PartnerName = selectedRow.PersonnelFirstName + ' ' + selectedRow.PersonnelLastName;
        }

        return selectedPartner;
    }
})