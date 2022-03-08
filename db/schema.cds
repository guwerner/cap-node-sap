namespace sap.ui.riskmanagement;
using { cuid,
  managed,
  Currency,
  sap } from '@sap/cds/common';
using {
  emobility.cpo.AbstractCurrentConsumption,
  emobility.cpo.Coordinate,
  emobility.cpo.AbstractConsumption,
  emobility.cpo.TString2,
  emobility.cpo.TString1,
  emobility.cpo.OICPRFIDIdentification,
  emobility.cpo.OICPChargeDetailRecord,
  emobility.cpo.OCPIBusinessDetail,
  emobility.cpo.OICPIdentification,
  emobility.cpo.Period,
  emobility.cpo.OICPEvseDataRecord,
  emobility.cpo.ConnectorStats,
  emobility.cpo.OpeningTime,
  emobility.cpo.OicpSetting,
  emobility.cpo.QRCodeIdentification,
  emobility.cpo.PlugAndChargeIdentification,
  emobility.cpo.RemoteIdentification,
  emobility.cpo.SettingCPO,
  emobility.cpo.SettingEMSP

} from './custom-types';

type PhasesUsed {
  csPhase1 : Boolean;
  csPhase2 : Boolean;
  csPhase3 : Boolean;
}

aspect TransactionData {
  timestamp : Timestamp;
  values    : Composition of many TransactionDataValues;
}

aspect TransactionDataValues {
  chargeBoxID   : String;
  connectorId   : Integer;
  transactionId : Integer;
  value         : String;
  context       : String;
  format        : String;
  measurand     : String;
  phase         : String;
  location      : String;
  unit          : String;
}


aspect LastConsumption {
  value     : Integer;
  timestamp : Timestamp;
};

aspect TransactionStop {
  timestamp               : Timestamp;
  meterStop               : Double;
  tagID                   : String;
  price                   : Double;
  roundedPrice            : Double;
  priceUnit               : String;
  pricingSource           : String;
  stateOfCharge           : Double;
  totalInactivitySecs     : Double;
  extraInactivitySecs     : Double;
  extraInactivityComputed : Boolean;
  totalConsumptionWh      : Double;
  totalDurationSecs       : Double;
  inactivityStatus        : TString1;
  signedData              : String;
  transactionData         : Composition of many TransactionData;

}

/**
 *  All Risks
 */
  entity Risks : managed {
    key ID      : UUID  @(Core.Computed : true);
    title       : String(100);
    prio        : String(5);
    descr       : String;
    miti        : Association to Mitigations;
    impact      : Integer;
    criticality : Integer;
    supplier    : Association to Suppliers;
  }

  entity Mitigations : managed {
    key ID       : UUID  @(Core.Computed : true);
    description  : String;
    owner        : String;
    timeline     : String;
    risks        : Association to many Risks on risks.miti = $self;
  }

using {  API_BUSINESS_PARTNER as bupa } from '../srv/external/API_BUSINESS_PARTNER';

    entity Suppliers as projection on bupa.A_BusinessPartner {
        key BusinessPartner as ID,
        BusinessPartnerFullName as fullName,
        BusinessPartnerIsBlocked as isBlocked,
}



entity Consumptions : cuid, managed, AbstractConsumption {
  startedAt                : Timestamp;
  endedAt                  : Timestamp;
  transaction              : Association to Transactions
                               on transaction.id = transactionId;
  transactionId            : String;
  asset                    : String; //Association to Assets;
  siteArea                 : String; //Association to SiteAreas;
  cumulatedConsumptionWh   : Double;
  cumulatedConsumptionAmps : Double;
  pricingSource            : String;
  amount                   : Double;
  roundedAmount            : Double;
  cumulatedAmount          : Double;
  currencyCode             : String;
  totalInactivitySecs      : Double;
  totalDurationSecs        : Double;
  stateOfCharge            : Double;
  toPrice                  : Boolean;
  limitAmps                : Double;
  limitWatts               : Double;
  limitSource              : TString2;
  limitSiteAreaAmps        : Double;
  limitSiteAreaWatts       : Double;
  limitSiteAreaSource      : TString2;
  smartChargingActive      : Boolean;
}

entity Transactions : AbstractCurrentConsumption {
  key id                         : Integer;
      phasesUsed                 : PhasesUsed;
      issuer                     : Boolean;
      siteID                     : String(36);
      siteArea                   : String; // Was Association
      siteAreaID                 : UUID;
      tagID                      : String;
      signedData                 : String;
      meterStart                 : Double;
      timestamp                  : Timestamp;
      price                      : Double;
      roundedPrice               : Double;
      priceUnit                  : String;
      pricingSource              : String;
      stateOfCharge              : Double;
      timezone                   : String;
      currentTimestamp           : Timestamp;
      currentTotalInactivitySecs : Double;
      currentInactivityStatus    : TString1;
      currentTotalDurationSecs   : Double;
      transactionEndReceived     : Boolean;
      currentSignedData          : String;
      status                     : String;
      numberOfMeterValues        : Double;
      uniqueId                   : String;
      migrationTag               : String;
      car                        : String; // Was Assosiation
      carID                      : String(36);
      carCatalog                 : String;// Was Assosiation
      carCatalogID               : String(36);
      connectorId                : Integer;
      chargeBox                  : String; // Was Assosiation
      chargeBoxID                : UUID;
      tag                        : String;
      lastConsumption            : Composition of LastConsumption;
      stop                       : Composition of TransactionStop;
      remotestop                 : Composition of {
                                     timestamp : Timestamp;
                                     createdBy : String;
                                   };
      values                     : Association to many Consumptions
                                     on values.transaction = $self;
      ocpiData                   : Composition of {
                                     session : LargeString;
                                     cdr : LargeString;
                                     sessionCheckedOn : Timestamp;
                                     cdrPostedOn : Timestamp;
                                     cdrCheckedOn : Timestamp;
                                   };
}