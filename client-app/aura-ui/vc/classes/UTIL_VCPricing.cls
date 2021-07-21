public class UTIL_VCPricing
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_VCPricing.class);
    
    public static String defaultSalesDocType = (String)UTIL_AppSettings.getValue(UTIL_AppSettings.VC, 'DefaultSalesDocType', '');    
    public static String defaultSalesOrg = (String)UTIL_AppSettings.getValue(UTIL_AppSettings.VC, 'DefaultSalesOrg', '');    
    public static String defaultDistributionChannel = (String)UTIL_AppSettings.getValue(UTIL_AppSettings.VC, 'DefaultDistributionChannel', '');    
    public static String defaultDivision =  (String)UTIL_AppSettings.getValue(UTIL_AppSettings.VC, 'DefaultDivision', '');    
    public static String defaultCustomerNumber = (String)UTIL_AppSettings.getValue(UTIL_AppSettings.VC, 'DefaultCustomerNumber', '');    
    public static String defaultMaterialgroup1 = (String)UTIL_AppSettings.getValue(UTIL_AppSettings.VC, 'DefaultMaterialgroup1', '');    
    public static String defaultMaterialgroup2 = (String)UTIL_AppSettings.getValue(UTIL_AppSettings.VC, 'DefaultMaterialgroup2', '');

    @testVisible
    public static Integer QuoteLineIncrement {
        public get
        {
            if (null == QuoteLineIncrement)
            {
                QuoteLineIncrement = (Integer)UTIL_AppSettings.getValue(UTIL_AppSettings.VC, 'DefaultQuoteLineIncrement', 10);
            }
            if (null == QuoteLineIncrement || QuoteLineIncrement < 1)
            {
                QuoteLineIncrement = getItemIncrement(defaultSalesDocType);
            }
            return QuoteLineIncrement;
        }
        private set;
    }

    // Runs a pricing simulate for a specific material number (with or without variant config)
    // This is primarily used to pull back whether any additional items get added to the BoM when pricing a single material.
    public static SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing getSBOForVC_Config(
        string materialNumber,
        ENSX_VCPricingConfiguration pricingConfig, 
        List<DS_VCCharacteristicValues> vcConfig)
    {
        logger.enterAura('getSBOForVC_Config', new Map<String, Object> {
            'materialNumber' => materialNumber
            , 'pricingConfig' => pricingConfig
            , 'vcConfig' => vcConfig
        });

        SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing oppPricingDetail = new SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing();

        try
        {
            if (String.isBlank(materialNumber))
            {
                throw new ENSX_Exceptions.SimulationException('A Material Number must be passed in for pricing simulation to occur.');
            }
            
            oppPricingDetail.SoldToParty = pricingConfig.soldToParty;

            oppPricingDetail.SALES.SalesDocumentType = String.isNotEmpty(pricingConfig.SalesDocumentType) ? pricingConfig.SalesDocumentType : defaultSalesDocType;
            oppPricingDetail.SALES.SalesOrganization = String.isNotEmpty(pricingConfig.SalesOrganization) ? pricingConfig.SalesOrganization : defaultSalesOrg;
            oppPricingDetail.SALES.DistributionChannel = String.isNotEmpty(pricingConfig.DistributionChannel) ? pricingConfig.DistributionChannel : defaultDistributionChannel;
            oppPricingDetail.SALES.Division = String.isNotEmpty(pricingConfig.Division) ? pricingConfig.Division : defaultDivision;

            SBO_EnosixOpportunityPricing_Detail.PARTNERS soldToPartner = new SBO_EnosixOpportunityPricing_Detail.PARTNERS();
            soldToPartner.PartnerFunction = UTIL_Customer.SOLD_TO_PARTNER_CODE;
            soldToPartner.CustomerNumber =  String.isNotEmpty(pricingConfig.soldToParty) ? pricingConfig.soldToParty : defaultCustomerNumber;

            oppPricingDetail.PARTNERS.add(soldToPartner);

            if (String.isNotBlank(pricingConfig.ShipToParty))
            {
                SBO_EnosixOpportunityPricing_Detail.PARTNERS shipTo = new SBO_EnosixOpportunityPricing_Detail.PARTNERS();
                shipTo.PartnerFunction = UTIL_Customer.SHIP_TO_PARTNER_CODE;
                shipTo.CustomerNumber = pricingConfig.ShipToParty;
                oppPricingDetail.PARTNERS.add(shipTo);
            }

            if (String.isNotBlank(materialNumber))
            {
                SBO_EnosixOpportunityPricing_Detail.ITEMS itm = new SBO_EnosixOpportunityPricing_Detail.ITEMS();
                itm.ItemNumber = '10';
                itm.Material = materialNumber;
                itm.Plant = pricingConfig.Plant;
                itm.OrderQuantity = 1;

                itm.Materialgroup1 = defaultMaterialgroup1;
                itm.Materialgroup2 = defaultMaterialgroup2;

                oppPricingDetail.Items.add(itm);

                // Variant Configuration
                Integer configTot = vcConfig.size();
                if (configTot > 0)
                {
                    for (Integer configCnt = 0 ; configCnt < configTot ; configCnt++)
                    {
                        DS_VCCharacteristicValues characteristic = vcConfig[configCnt];
                        if (characteristic.UserModified != null && characteristic.UserModified && String.isNotEmpty(characteristic.CharacteristicID))
                        {
                            SBO_EnosixOpportunityPricing_Detail.ITEMS_CONFIG cfg = new SBO_EnosixOpportunityPricing_Detail.ITEMS_CONFIG();
                            cfg.ItemNumber = String.valueOf(QuoteLineIncrement);
                            cfg.CharacteristicID = characteristic.CharacteristicID;
                            cfg.CharacteristicName = characteristic.CharacteristicName;
                            cfg.CharacteristicValue = characteristic.CharacteristicValue;
                            oppPricingDetail.ITEMS_CONFIG.add(cfg);
                        }
                    }
                }
            }

            oppPricingDetail = simulatePricing(oppPricingDetail);
            
        } catch (Exception ex) {
            logger.log(LoggingLevel.ERROR, 'There was an exception thrown when attempting to getSBOForVC_Config ', ex);
            throw ex;
        } finally { 
            logger.exit();
        }

        return oppPricingDetail;
    }

    /// Actually executes a pricing simulation for a a configured SBO.
    public static SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing simulatePricing(SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing oppPricingDetail)
    {
        logger.enter('simulatePricing', new Map<String, Object> {
            'oppPricingDetail' => oppPricingDetail
        });

        SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing result = new SBO_EnosixOpportunityPricing_Detail.EnosixOpportunityPricing();

        try
        {            
            SBO_EnosixOpportunityPricing_Detail sbo = new SBO_EnosixOpportunityPricing_Detail();
            System.debug('about to run command against SAP');
            System.debug('Initial item counts:' + oppPricingDetail.ITEMS.size());
            result = sbo.command('CMD_SIMULATE_PRICING', oppPricingDetail);

            if (result.isSuccess() && !hasErrorMessages(result.getMessages()))
            {
                System.debug('simulation was a success');
                System.debug(result.getMessages());
                System.debug('fetched ' + result.ITEMS.size() +' items from SAP');
            }
            else
            {
                handleSimulateFailure(result.getMessages());
            }
        } catch (Exception ex) {
            logger.log(LoggingLevel.ERROR, 'There was an exception thrown when attempting to simulatePricing.', ex);
            throw ex;
        } finally { 
            logger.exit();
        }

        return result;
    }

    @testVisible
    private static Boolean hasErrorMessages(List<ensxsdk.EnosixFramework.Message> messages) {
        Integer messageSize = messages == null ? 0 : messages.size();
        if (messageSize > 0) {
            for (Integer i = 0 ; i < messageSize ; i++) {
                switch on messages[i].Type {
                    when ERROR, ABNORMALEND, SAPEXIT {
                        return true;
                    }
                }
            }
        }
        return false;
    }

    @testVisible
    private static void handleSimulateFailure(List<ensxsdk.EnosixFramework.Message> messages)
    {
        System.debug('simulation failure');
        System.debug(messages);
        string exceptionMessage = '';
        integer messageSize = messages == null ? 0 : messages.size();
        if (messageSize == 0 )
        {
            exceptionMessage = 'Quote Calculation Failed';
        }
        else
        {
            for (integer i = 0 ; i < messageSize ; i++) {
                exceptionMessage += messages[i].Text;
                if (i != messageSize - 1) exceptionMessage += '; ';
            }
        }
        throw new ENSX_Exceptions.SimulationException(exceptionMessage);
    }

    @testVisible
    private static RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT getOrderMasterData(string orderTypeKey)
    {
        List<RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT> otList = UTIL_RFC.getDocTypeMaster().ET_OUTPUT_List;
        Integer otTot = otList.size();
        for (Integer otCnt = 0 ; otCnt < otTot ; otCnt++)
        {
            RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT orderType = otList[otCnt];
            if (orderType.DocumentType == orderTypeKey) return orderType;
        }
        system.Debug('Was unable to locate Master Data matching key: ' + orderTypeKey);
        return null;
    }

    /// Gets the increment multiplier for each line item on opportunity pricing based upon the doc type
    /// This is all configured inside of SAP so needs to be pulled from there.
    private static Integer getItemIncrement(string docType)
    {
        //Default increment if nothing has been configured.
        Integer increment = 10;

        RFC_SD_GET_DOC_TYPE_VALUES.ET_OUTPUT orderMasterData = getOrderMasterData(docType);

        if (null != orderMasterData && string.isNotBlank(orderMasterData.INCPO))
        {
            Integer docIncrement = Integer.valueOf(orderMasterData.INCPO);
            if (docIncrement > 0)
            {
                increment = docIncrement;
            }
        }
        return increment;
    }
}