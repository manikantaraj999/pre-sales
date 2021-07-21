({
    addSelectedPartner: function (component, selectedPartner)
    {
        if (!selectedPartner.CustomerNumber && 
            !selectedPartner.Vendor && 
            !selectedPartner.PersonnelNumber && 
            !selectedPartner.ContactPersonNumber)
        {
            let customerNumber = component.get('v.soldToParty');
            let allPartners = component.get('v.allPartners');
            for (let key in allPartners) {
                let partner = allPartners[key];
                if (selectedPartner.PartnerFunction === partner.PartnerFunction && partner.CustomerNumber) {
                    customerNumber = partner.CustomerNumber;
                }
            }
            selectedPartner.CustomerNumber = customerNumber;
        }

        let partners = component.get('v.partners');
        let isFound = false;
        for (let key in partners) {
            let partner = partners[key];
            if (selectedPartner.PartnerFunction === partner.PartnerFunction) {
                partners[key] = selectedPartner;
                partners[key].ComponentType = partner.ComponentType;
                partners[key].SearchType = partner.SearchType;
                partners[key].autoSearch = partner.autoSearch;
                partners[key].allowSearch = partner.allowSearch;
                partners[key].allowAddressOverride = partner.allowAddressOverride;
                isFound = true;
                break;
            }
        }
        if (!isFound) {
            partners.push(selectedPartner);
        }
        component.set('v.partners', partners);
    }
})