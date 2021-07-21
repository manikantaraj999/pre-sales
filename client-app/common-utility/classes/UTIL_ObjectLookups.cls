public  class UTIL_ObjectLookups
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_ObjectLookups.class);

	public static Case getCaseById(string id)
	{
		Case cse = new Case();
		try
		{
			cse = [
				SELECT Id, IsDeleted, CaseNumber, Contact.Email, ContactId,
					AccountId, AssetId, ParentId, SuppliedName,	SuppliedEmail, 
					SuppliedPhone, SuppliedCompany, Type, Status, Reason, Origin, 
					Subject, Priority, Description, IsClosed, ClosedDate, IsEscalated, 
					OwnerId, FLD_SAP_Return_Order_Number__c 
				FROM Case 
				WHERE Id = :id];
		}
		catch (Exception e)
		{
            system.debug(e);
            ApexPages.addMessage(new Apexpages.Message(
				ApexPages.Severity.WARNING, 
				'There was an issue retrieving a Case record for the provided Id'));
        }
        return cse;
    }

	// getCustomerForCase()
	//
	// Get the SAP customer from the Case
    public static SBO_EnosixCustomer_Detail.EnosixCustomer getCustomerForCase(Case cse)
	{
        SBO_EnosixCustomer_Detail.EnosixCustomer cust = new SBO_EnosixCustomer_Detail.EnosixCustomer();
        if (cse != null)
		{
            Account acct = UTIL_SFAccount.getAccountById(cse.AccountId);
            if (acct != null)
			{
                String customerId = UTIL_SFAccount.getCustomerNumberFromAccount(acct);
                if (string.isBlank(customerId))
				{
                    ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR,
                            'This account is not configured with an SAP customer'));
                }
				else
				{
                    cust = UTIL_Customer.getCustomerByNumber(customerId);
                    if (null == cust)
					{
                        ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.WARNING,
                                'This Account/SAP customer is not configured for order creation'));
                    }
                }
            }
        }
        return cust;
    }

	// getContactById()
	//
	// Get the Contact by its given Id
	public static Contact getContactById(string id)
	{
		Contact contact = new Contact();
		try
		{
            contact = Database.query(
				'SELECT Id, IsDeleted, Name, FirstName, LastName, ' +
				'Phone, Email, MailingAddress, AccountId, ' + UTIL_SFContact.ContactFieldName + 
				' FROM Contact WHERE Id = :id LIMIT 1');
		}
		catch (Exception e)
		{
            system.debug(e);
            ApexPages.addMessage(new Apexpages.Message(
				ApexPages.Severity.WARNING, 
				'There was an issue retrieving a Contact record for the provided Id'));
        }
        return contact;
    }
}