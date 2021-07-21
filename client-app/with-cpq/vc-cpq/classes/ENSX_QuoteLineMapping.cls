/// This tracks a mapping between the SAP Quote Line items
/// and the CPQ Line Items.
/// Since you can re-arrange CPQ quote lines to your hearts content we needed a way to make sure
/// that produces added as part of "BoM Explosion" get correctly mapped back to their coresponding
/// CPQ Line Items.
global with sharing class ENSX_QuoteLineMapping
{
    public String MaterialNumber { get; set; }
    public Integer CPQParentLineItem { get; set; }
    public Integer CPQLineItem { get; set; }
    
    // SAP Line Items will always be 6 digit strings, padded left with 0's
    public Integer SAPLineItem { get; set; }
    public Boolean IsProductFeature{get;set;}

    public ENSX_QuoteLineMapping(ENSX_QuoteLine quoteLine, Integer itemNumber)
    {
        this.MaterialNumber = quoteLine.SAPMaterialNumber;
        this.CPQParentLineItem = quoteLine.ParentLineItem;
        this.CPQLineItem = quoteLine.LineItem;
        this.SAPLineItem = itemNumber;
        this.IsProductFeature = (null != quoteLine.ParentLineItem);
    }
}