/* begin standard exports */
export function onBeforeCalculate(quoteModel, quoteLineModels, conn) {
  return Promise.all([enosix_onBeforeCalculate(quoteModel, quoteLineModels, conn)]);
}
/* end standard exports */

/* begin enosix */
function enosix_onBeforeCalculate(quoteModel, quoteLineModels, conn) {
  // prettier-ignore
  const enosixConfig = {/*ENOSIXCONFIG*/};
  debug('enosixConfig', enosixConfig);
  quoteModel.record.FLD_SAP_Simulation_Error__c = null;

  if (enosixConfig.instanceUrl) {
    conn.instanceUrl = enosixConfig.instanceUrl;
  } else {
    quoteModel.record.FLD_SAP_Simulation_Error__c =
      'Unable to call SAP Simulation service please run "UTIL_CPQ_Setup.installCustomScript();" in Dev Console as Anonymous Apex';
    return Promise.resolve();
  }

  return new Promise((resolve, reject) => {
    let enableQuoteSimulation = quoteModel.record[enosixConfig.quoteSimulationEnabledField];
    let enableQuoteLineSimulation = quoteModel.record[enosixConfig.quoteLineSimulationEnabledField];

    if (quoteLineModels.length > 0 && enableQuoteSimulation) {
      let simulationRequest = {
        QuoteId: quoteModel.Id,
        record: {},
        LinkedQuoteLines: []
      };
      let requestQuoteRecordFields = enosixConfig.requestQuoteRecordFields || [];

      requestQuoteRecordFields.forEach(fieldName => {
        simulationRequest.record[fieldName] = quoteModel.record[fieldName];
      });

      simulationRequest.recordJSON = JSON.stringify(simulationRequest.record);
      delete simulationRequest.record;
      let requestQuoteFieldMapping = enosixConfig.requestQuoteFieldMapping || [];

      for (const key in requestQuoteFieldMapping) {
        if (requestQuoteFieldMapping.hasOwnProperty(key)) {
          simulationRequest[key] = quoteModel.record[requestQuoteFieldMapping[key]];
        }
      }
      if (enableQuoteLineSimulation) {
        let usedNumbers = [];
        let maxUsedNumber = 0;
        quoteLineModels.forEach(quoteLine => {
          if (usedNumbers.includes(quoteLine.record.SBQQ__Number__c)) {
            quoteLine.record.SBQQ__Number__c = 0;
          } else {
            usedNumbers.push(quoteLine.record.SBQQ__Number__c);
            if (quoteLine.record.SBQQ__Number__c > maxUsedNumber) {
              maxUsedNumber = quoteLine.record.SBQQ__Number__c;
            }
          }
        });
        quoteLineModels.forEach(quoteLine => {
          if (quoteLine.record.SBQQ__Number__c == 0) {
            quoteLine.record.SBQQ__Number__c = ++maxUsedNumber;
          }
        });

        quoteLineModels.sort(function (a, b) {
          return parseInt(a.record.SBQQ__Number__c) - parseInt(b.record.SBQQ__Number__c);
        });

        quoteLineModels.forEach(quoteLine => {
          let simulationRequestLine = { record: {} };
          let requestQuoteLineRecordFields = enosixConfig.requestQuoteLineRecordFields || [];

          requestQuoteLineRecordFields.forEach(fieldName => {
            simulationRequestLine.record[fieldName] = quoteLine.record[fieldName];
          });

          simulationRequestLine.recordJSON = JSON.stringify(simulationRequestLine.record);
          delete simulationRequestLine.record;
          let requestQuoteLineFieldMapping = Object.assign(
            {
              LineItem: 'SBQQ__Number__c',
              DiscountPercent: 'SBQQ__Discount__c',
              ListPrice: 'SBQQ__ListPrice__c',
              NetPrice: 'SBQQ__NetPrice__c',
              Quantity: 'SBQQ__Quantity__c',
              Product: 'SBQQ__Product__c',
              PricebookEntry: 'SBQQ__PricebookEntryId__c',
              itemJSON: 'SAP_Configuration__c'
            },
            enosixConfig.requestQuoteLineFieldMapping
          );

          for (const key in requestQuoteLineFieldMapping) {
            if (requestQuoteLineFieldMapping.hasOwnProperty(key)) {
              simulationRequestLine[key] = quoteLine.record[requestQuoteLineFieldMapping[key]];
            }
          }

          simulationRequestLine.IsProductFeature = Boolean(quoteLine.parentItem);
          if (simulationRequestLine.IsProductFeature) {
            simulationRequestLine.ParentLineItem = quoteLine.parentItem.Number__c;
          }

          simulationRequest.LinkedQuoteLines.push(simulationRequestLine);
        });
      }

      if (enableQuoteSimulation && simulationRequest.LinkedQuoteLines.length > 0) {
        debug('simulationRequest', simulationRequest);
        let serializedSimulationRequest = JSON.stringify(simulationRequest);

        conn.apex
          .post(enosixConfig.enosixSapSimulationApexService, {
            quote: serializedSimulationRequest
          })
          .then(results => {
            debug('Raw simulationResponse', results);
            //deserialize the object back into readable format
            let simulationResponse = JSON.parse(results);
            debug('simulationResponse', simulationResponse);
            if (simulationResponse && simulationResponse.Success) {
              // update the quote from the simulation response
              translateAndUpdateQuoteLines(
                resolve,
                reject,
                quoteModel,
                quoteLineModels,
                simulationResponse
              );
            } else {
              returnSimulationError(resolve, reject, quoteModel, simulationResponse.Message);
            }
          })
          .catch(err => {
            returnSimulationError(resolve, reject, quoteModel, err);
          });
      } else {
        resolve();
      }
    } else {
      resolve();
    }
  });

  function translateAndUpdateQuoteLines(
    resolve,
    reject,
    quoteModel,
    quoteLineModels,
    simulationResponse
  ) {
    try {
      Object.assign(quoteModel.record, simulationResponse.Quote.record);
      simulationResponse.Quote.LinkedQuoteLines.forEach(simulationResponseLine => {
        let matchedQuoteLine = quoteLineModels.find(quoteLine => {
          return quoteLine.record.SBQQ__Number__c == simulationResponseLine.LineItem;
        });

        debug(matchedQuoteLine);
        debug(simulationResponseLine);

        if (matchedQuoteLine) {
          Object.assign(matchedQuoteLine.record, simulationResponseLine.record);

          if (simulationResponseLine.RealProductId) {
            matchedQuoteLine.record.SBQQ__Product__c = simulationResponseLine.RealProductId;
            matchedQuoteLine.record.SBQQ__PricebookEntryId__c =
              simulationResponseLine.RealPricebookEntryId;

            if (matchedQuoteLine.record.SBQQ__DynamicOptionId__c) {
              matchedQuoteLine.record.SBQQ__DynamicOptionId__c =
                matchedQuoteLine.record.SBQQ__DynamicOptionId__c.split(':')[0] +
                ':' +
                simulationResponseLine.RealProductId;
            }

            if (Boolean(matchedQuoteLine.parentItem)) {
              matchedQuoteLine.record.SBQQ__BundledQuantity__c = simulationResponseLine.Quantity;
            } else {
              matchedQuoteLine.record.SBQQ__Quantity__c = simulationResponseLine.Quantity;
            }
          }
          matchedQuoteLine.ItemNumber = simulationResponseLine.ItemNumber;
        }
      });

      if (enosixConfig.resequenceQuoteLines) {
        var quoteLineNum = 1;

        quoteLineModels.sort(function (a, b) {
          var sapItemNumber = a.record.SBQQ__Number__c + '999999';
          if (a.parentItem && a.parentItem.ItemNumber) {
            if (a.ItemNumber) sapItemNumber = a.ItemNumber;
            sapItemNumber = a.parentItem.ItemNumber + '.' + sapItemNumber;
          } else if (a.ItemNumber) sapItemNumber = a.ItemNumber;

          a.SortItemNumber = sapItemNumber;
          sapItemNumber = b.record.SBQQ__Number__c + '999999';

          if (b.parentItem && b.parentItem.ItemNumber) {
            if (b.ItemNumber) sapItemNumber = b.ItemNumber;
            sapItemNumber = b.parentItem.ItemNumber + '.' + sapItemNumber;
          } else if (b.ItemNumber) sapItemNumber = b.ItemNumber;

          b.SortItemNumber = sapItemNumber;
          return parseFloat(a.SortItemNumber) - parseFloat(b.SortItemNumber);
        });

        quoteLineModels.forEach(quoteLine => {
          quoteLine.record.SBQQ__Number__c = quoteLineNum++;
        });
      }
      resolve();
    } catch (err) {
      returnSimulationError(resolve, reject, quoteModel, err);
    }
  }

  function returnSimulationError(resolve, reject, quoteModel, err) {
    console.error('enosix SAP Simulation Error', err);
    if (quoteModel) {
      quoteModel.record.FLD_SAP_Simulation_Error__c = err;
    }
    resolve();
    return;
    if (reject) {
      reject('Issue Simulating in SAP: ' + err);
    } else {
      throw err;
    }
  }

  /** Log to console if debug is enabled */
  function debug(...args) {
    if (enosixConfig.DEBUG) {
      console.log(...args);
    }
  }
}
/* end enosix */
