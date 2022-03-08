using { sap.ui.riskmanagement as my } from '../db/schema';
 
@path: 'service/risk'
service RiskService {
  entity Risks @(restrict : [
            {
                grant : [ 'READ' ],
                to : [ 'RiskViewer' ]
            },
            {
                grant : [ '*' ],
                to : [ 'RiskManager' ]
            }
        ]) as projection on my.Risks;
      annotate Risks with @odata.draft.enabled;
   entity Mitigations @(restrict : [
            {
                grant : [ 'READ' ],
                to : [ 'RiskViewer' ]
            },
            {
                grant : [ '*' ],
                to : [ 'RiskManager' ]
            }
        ]) as projection on my.Mitigations;
    annotate Mitigations with @odata.draft.enabled;

    // @readonly
    // entity Suppliers @(restrict : [{
    //     grant : ['READ'],
    //     to    : [
    //         'RiskViewer',
    //         'RiskManager'
    //     ]
    // }]) as projection on my.Suppliers;

    // annotate RiskService.Suppliers with {
    //     isBlocked @title : 'Supplier Blocked';
    // }

  entity Transactions as select from my.Transactions {
    //any fields not clerar
    id, currentTimestamp, status, chargeBox, chargeBoxID ,connectorId, tagID, currentTotalInactivitySecs, lastConsumption.value as lastConsumption,  values.cumulatedAmount as cumulatedAmount , values.cumulatedConsumptionWh as currentTotalConsumptionWh, stateOfCharge, roundedPrice, priceUnit, siteID, siteAreaID
  };


}