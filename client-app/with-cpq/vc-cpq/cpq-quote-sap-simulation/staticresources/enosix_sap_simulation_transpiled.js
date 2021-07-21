'use strict';
System.register('QCPlugin____UIDFiller____', [], function (_export, _context) {
  'use strict';
  /* begin standard exports */ function onBeforeCalculate(quoteModel, quoteLineModels, conn) {
    return Promise.all([enosix_onBeforeCalculate(quoteModel, quoteLineModels, conn)]);
  }
  /* end standard exports */ /* begin enosix */ _export('onBeforeCalculate', onBeforeCalculate);
  function enosix_onBeforeCalculate(quoteModel, quoteLineModels, conn) {
    // prettier-ignore
    var enosixConfig={/*ENOSIXCONFIG*/};
    debug('enosixConfig', enosixConfig);
    quoteModel.record.FLD_SAP_Simulation_Error__c = null;
    if (enosixConfig.instanceUrl) {
      conn.instanceUrl = enosixConfig.instanceUrl;
    } else {
      quoteModel.record.FLD_SAP_Simulation_Error__c =
        'Unable to call SAP Simulation service please run "UTIL_CPQ_Setup.installCustomScript();" in Dev Console as Anonymous Apex';
      return Promise.resolve();
    }
    return new Promise(function (resolve, reject) {
      var enableQuoteSimulation = quoteModel.record[enosixConfig.quoteSimulationEnabledField];
      var enableQuoteLineSimulation =
        quoteModel.record[enosixConfig.quoteLineSimulationEnabledField];
      if (quoteLineModels.length > 0 && enableQuoteSimulation) {
        var simulationRequest = { QuoteId: quoteModel.Id, record: {}, LinkedQuoteLines: [] };
        var requestQuoteRecordFields = enosixConfig.requestQuoteRecordFields || [];
        requestQuoteRecordFields.forEach(function (fieldName) {
          simulationRequest.record[fieldName] = quoteModel.record[fieldName];
        });
        simulationRequest.recordJSON = JSON.stringify(simulationRequest.record);
        delete simulationRequest.record;
        var requestQuoteFieldMapping = enosixConfig.requestQuoteFieldMapping || [];
        for (var key in requestQuoteFieldMapping) {
          if (requestQuoteFieldMapping.hasOwnProperty(key)) {
            simulationRequest[key] = quoteModel.record[requestQuoteFieldMapping[key]];
          }
        }
        if (enableQuoteLineSimulation) {
          var usedNumbers = [];
          var maxUsedNumber = 0;
          quoteLineModels.forEach(function (quoteLine) {
            if (usedNumbers.includes(quoteLine.record.SBQQ__Number__c)) {
              quoteLine.record.SBQQ__Number__c = 0;
            } else {
              usedNumbers.push(quoteLine.record.SBQQ__Number__c);
              if (quoteLine.record.SBQQ__Number__c > maxUsedNumber) {
                maxUsedNumber = quoteLine.record.SBQQ__Number__c;
              }
            }
          });
          quoteLineModels.forEach(function (quoteLine) {
            if (quoteLine.record.SBQQ__Number__c == 0) {
              quoteLine.record.SBQQ__Number__c = ++maxUsedNumber;
            }
          });
          quoteLineModels.sort(function (a, b) {
            return parseInt(a.record.SBQQ__Number__c) - parseInt(b.record.SBQQ__Number__c);
          });
          quoteLineModels.forEach(function (quoteLine) {
            var simulationRequestLine = { record: {} };
            var requestQuoteLineRecordFields = enosixConfig.requestQuoteLineRecordFields || [];
            requestQuoteLineRecordFields.forEach(function (fieldName) {
              simulationRequestLine.record[fieldName] = quoteLine.record[fieldName];
            });
            simulationRequestLine.recordJSON = JSON.stringify(simulationRequestLine.record);
            delete simulationRequestLine.record;
            var requestQuoteLineFieldMapping = Object.assign(
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
            for (var _key in requestQuoteLineFieldMapping) {
              if (requestQuoteLineFieldMapping.hasOwnProperty(_key)) {
                simulationRequestLine[_key] = quoteLine.record[requestQuoteLineFieldMapping[_key]];
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
          var serializedSimulationRequest = JSON.stringify(simulationRequest);
          conn.apex
            .post(enosixConfig.enosixSapSimulationApexService, {
              quote: serializedSimulationRequest
            })
            .then(function (results) {
              debug('Raw simulationResponse', results); //deserialize the object back into readable format
              var simulationResponse = JSON.parse(results);
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
            .catch(function (err) {
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
        simulationResponse.Quote.LinkedQuoteLines.forEach(function (simulationResponseLine) {
          var matchedQuoteLine = quoteLineModels.find(function (quoteLine) {
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
          quoteLineModels.forEach(function (quoteLine) {
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
    /** Log to console if debug is enabled */ function debug() {
      if (enosixConfig.DEBUG) {
        var _console;
        (_console = console).log.apply(_console, arguments);
      }
    }
  }
  /* end enosix */ return { setters: [], execute: function () {} };
});
