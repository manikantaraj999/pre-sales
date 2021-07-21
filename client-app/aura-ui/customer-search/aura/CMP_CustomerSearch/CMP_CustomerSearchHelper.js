({
    buildColumns: function(component) {
        let isContactSearch = false;
        let searchType = component.get('v.searchType');
        let customerNumberLabel = 'Customer Number';

        if (searchType === 'Contact') {
            customerNumberLabel = 'Contact Number';
            component.set('v.searchParams.contactSearch', 'X');
            isContactSearch = true;
        }
        else if (searchType === 'Personnel') {
            customerNumberLabel = 'Personnel Number';
            component.set('v.searchParams.personnelSearch', 'X');
            isContactSearch = true;
        }
        else if (searchType === 'Vendor') {
            customerNumberLabel = 'Vendor Number';
        }

        let columns = [
            {label: customerNumberLabel, fieldName: 'CustomerNumber', type: 'text'},
            {label: 'First Name', fieldName: 'Name', type: 'text'},
            {label: 'Last Name', fieldName: 'Name2', type: 'text'}];

        if (!isContactSearch) {
            columns.push({label: 'Street', fieldName: 'Street', type: 'text'});
            columns.push({label: 'City', fieldName: 'City', type: 'text'});
            columns.push({label: 'Region', fieldName: 'Region', type: 'text'});
            columns.push({label: 'Postal Code', fieldName: 'PostalCode', type: 'text'});
            columns.push({label: 'Country', fieldName: 'Country', type: 'text'});
        }

        component.set('v.columns', columns);
    },

    search: function(component, pagingOptions) {
        return new Promise(function(resolve, reject) {

            let searchType = component.get('v.searchType');
            let action = searchType === 'Vendor' ? component.get('c.searchVendors') : component.get('c.searchCustomers');

            let params = {
                pagingOptions: pagingOptions,
                searchParams : component.get('v.searchParams')
            }

            if (searchType === 'Contact' || searchType === 'Personnel') {
                params.isContactSearch = true
            }

            action.setParams(params);

            action.setCallback(this, function(res) {
                console.log('return search customer')
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
    }
})