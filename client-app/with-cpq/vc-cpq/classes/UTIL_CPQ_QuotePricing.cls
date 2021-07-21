public with sharing class UTIL_CPQ_QuotePricing 
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_CPQ_QuotePricing.class);

    // getSBOForENSX_Quote
    //
    // Performs the SAP pricing simulation
    public static SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing getSBOForENSX_Quote(
        ENSX_Quote quote, Map<Integer, ENSX_QuoteLineMapping> preCalculateState, Map<Id, Product2> productMap)
    {
        logger.enterAura('getSBOForENSX_Quote', new Map<String, Object> {
            'quote' => quote
        });
        SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing oppPricingDetail = new SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing();
        try
        {
            string soldToParty = String.isNotBlank(quote.soldToParty) ? quote.soldToParty : UTIL_VCPricing.defaultCustomerNumber;
            if (String.isBlank(soldToParty))
            {
                throw new ENSX_Exceptions.SimulationException(System.Label.LBL_Account_Sold_To_Blank);
            }
            oppPricingDetail.SoldToParty = soldToParty;

            oppPricingDetail.SALES.SalesDocumentType = String.isNotEmpty(quote.salesDocType) ? quote.salesDocType : UTIL_VCPricing.defaultSalesDocType;
            oppPricingDetail.SALES.SalesOrganization = String.isNotEmpty(quote.SalesOrg) ? quote.SalesOrg : UTIL_VCPricing.defaultSalesOrg;
            oppPricingDetail.SALES.DistributionChannel = String.isNotEmpty(quote.salesDistChannel) ? quote.salesDistChannel : UTIL_VCPricing.defaultDistributionChannel;
            oppPricingDetail.SALES.Division = String.isNotEmpty(quote.salesDivision) ? quote.salesDivision : UTIL_VCPricing.defaultDivision;

            SBO_EnosixOpportunityPricing_Detail.PARTNERS soldToPartner = new SBO_EnosixOpportunityPricing_Detail.PARTNERS();
            soldToPartner.PartnerFunction = UTIL_Customer.SOLD_TO_PARTNER_CODE;
            soldToPartner.CustomerNumber = soldToParty;

            oppPricingDetail.PARTNERS.add(soldToPartner);

            if (String.isNotBlank(quote.shipToParty))
            {
                SBO_EnosixOpportunityPricing_Detail.PARTNERS shipTo = new SBO_EnosixOpportunityPricing_Detail.PARTNERS();
                shipTo.PartnerFunction = UTIL_Customer.SHIP_TO_PARTNER_CODE;
                shipTo.CustomerNumber = quote.shipToParty;
                oppPricingDetail.PARTNERS.add(shipTo);
            }

            Integer qlTot = quote.LinkedQuoteLines.size();
            for (Integer qlCnt = 0 ; qlCnt < qlTot ; qlCnt++)
            {
                ENSX_QuoteLine line = quote.LinkedQuoteLines[qlCnt];
                Product2 lineProduct = productMap.get(line.Product);
                if (!line.IsProductFeature && UTIL_SFProduct.isProductLinkedToMaterial(lineProduct))
                {
                    SBO_EnosixOpportunityPricing_Detail.ITEMS itm = new SBO_EnosixOpportunityPricing_Detail.ITEMS();
                    itm.ItemNumber = String.valueOf(preCalculateState.get(line.LineItem).SAPLineItem);
                    itm.Material = UTIL_SFProduct.getMaterialNumberFromProduct(lineProduct);
                    itm.Plant = line.ItemConfiguration.plant;
                    itm.OrderQuantity = line.Quantity;
                    itm.Materialgroup1 = UTIL_VCPricing.defaultMaterialgroup1;
                    itm.Materialgroup2 = UTIL_VCPricing.defaultMaterialgroup2;
                    oppPricingDetail.Items.add(itm);
                    ENSX_CPQ_QuoteCalculationService.applyQuoteLineRequestMappingRules(line, itm, oppPricingDetail);

                    // Variant Configuration
                    if (null != line.ItemConfiguration && null != line.ItemConfiguration.selectedCharacteristics && !line.ItemConfiguration.selectedCharacteristics.isEmpty())
                    {
                        Integer scTot = line.ItemConfiguration.selectedCharacteristics.size();
                        for (Integer scCnt = 0 ; scCnt < scTot ; scCnt++)
                        {
                            ENSX_Characteristic c = line.ItemConfiguration.selectedCharacteristics[scCnt];
                            if (c.UserModified != null && c.UserModified && String.isNotEmpty(c.CharacteristicID))
                            {
                                SBO_EnosixOpportunityPricing_Detail.ITEMS_CONFIG cfg = new SBO_EnosixOpportunityPricing_Detail.ITEMS_CONFIG();
                                cfg.ItemNumber = itm.ItemNumber;
                                cfg.CharacteristicID = c.CharacteristicID;
                                cfg.CharacteristicName = c.CharacteristicName;
                                cfg.CharacteristicValue = c.CharacteristicValue;
                                oppPricingDetail.ITEMS_CONFIG.add(cfg);
                            }
                        }
                    }
                }
            }

            ENSX_CPQ_QuoteCalculationService.applyQuoteRequestMappingRules(quote, oppPricingDetail);

            oppPricingDetail = UTIL_VCPricing.simulatePricing(oppPricingDetail);
            
        } catch (Exception ex) {
            logger.log(LoggingLevel.ERROR, 'There was an exception thrown when attempting to getSBOForENSX_Quote ', ex);
            throw ex;
        } finally { 
            logger.exit();
        }

        return oppPricingDetail;
    }
}