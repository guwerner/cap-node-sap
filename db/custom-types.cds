namespace emobility.cpo;

using {Currency} from '@sap/cds/common';

type OICPAddressIso19773 {
  Country         : String;
  City            : String; // Field Length = 11-50
  Street          : String; // Field Length = 2-100
  PostalCode      : String; // Field Length = 10
  HouseNum        : String; // Field Length = 10
  Floor           : String; // Field Length = 5
  Region          : String; // Field Length = 50
  ParkingFacility : Boolean;
  ParkingSpot     : String; // Field Length = 5
  Timezone        : String;
}

type TString1 : String(1);
type TString2 : String(2);

type Coordinate {
  longitude : Double;
  latitude  : Double;
}

type ConsumptionStamp {
  value                   : Double;
  timestamp               : Timestamp;
}

type AbstractCurrentConsumption {
  currentConsumptionWh      : Double;
  currentTotalConsumptionWh : Double;
  currentCumulatedPrice     : Double;
  lastConsumption           : ConsumptionStamp;
  currentInstantWatts       : Double;
  currentInstantWattsL1     : Double;
  currentInstantWattsL2     : Double;
  currentInstantWattsL3     : Double;
  currentInstantWattsDC     : Double;
  currentInstantVolts       : Double;
  currentInstantVoltsL1     : Double;
  currentInstantVoltsL2     : Double;
  currentInstantVoltsL3     : Double;
  currentInstantVoltsDC     : Double;
  currentInstantAmps        : Double;
  currentInstantAmpsL1      : Double;
  currentInstantAmpsL2      : Double;
  currentInstantAmpsL3      : Double;
  currentInstantAmpsDC      : Double;
  currentStateOfCharge      : Double;
}

type AbstractConsumption {
  instantWatts    : Double;
  instantWattsL1  : Double;
  instantWattsL2  : Double;
  instantWattsL3  : Double;
  instantWattsDC  : Double;
  instantAmps     : Double;
  instantAmpsL1   : Double;
  instantAmpsL2   : Double;
  instantAmpsL3   : Double;
  instantAmpsDC   : Double;
  instantVolts    : Double;
  instantVoltsL1  : Double;
  instantVoltsL2  : Double;
  instantVoltsL3  : Double;
  instantVoltsDC  : Double;
  consumptionWh   : Double;
  consumptionAmps : Double;
}

type Period {
  begin : String; // The opening time. Pattern: [0-9]{2}:[0-9]{2}
  end   : String; // The closing time. Pattern: [0-9]{2}:[0-9]{2}
}

type RFIDMifareFamilyIdentification  {
    UID                          : String(50);
  }; // Authentication data details. The data structure differs depending on the authentication technology

  type QRCodeIdentification            {
    EvcoID                       : String; // Contract identifier. Hubject will automatically convert all characters from lower case to upper case. A String that MUST be valid with respect to the following regular expression: ISO | DIN ^(([A-Za-z]{2}\-?[A-Za-z0-9]{3}\-?C[A-Za-z0-9]{8}\-?[\d|A-Za-z])|([A-Za-z]{2}[\*|\-]?[A-Za-z0-9]{3}[\*|\-]?[A-Za-z0-9]{6}[\*|\-]?[\d|X]))$ Examples ISO: “DE-8EO-CAet5e4XY-3”, “DE8EOCAet5e43X1” Examples DIN: “DE*8EO*Aet5e4*3”, “DE-8EO-Aet5e4-3”, “DE8EOAet5e43”
    PIN                          : String(20); // According to different processes, the PIN is transferred as encrypted hash or in clear text. Field Length = 20
    HashedPIN                    : String;
  }; // Authentication data details. The data structure differs depending on the authentication technology
  type PlugAndChargeIdentification     {
    EvcoID                       : String;
  }; // Authentication required for Plug&Charge (EMAID/EVCOID)
  type RemoteIdentification            {
    EvcoID                       : String;
  };

aspect OICPIdentification {
  RFIDMifareFamilyIdentification : RFIDMifareFamilyIdentification; // Authentication data details. The data structure differs depending on the authentication technology
  RFIDIdentification             : OICPRFIDIdentification; // Authentication data details. The data structure differs depending on the authentication technology
  QRCodeIdentification           : QRCodeIdentification; // Authentication data details. The data structure differs depending on the authentication technology
  PlugAndChargeIdentification    : PlugAndChargeIdentification; // Authentication required for Plug&Charge (EMAID/EVCOID)
  RemoteIdentification           : RemoteIdentification; // Authentication data details. The data structure differs depending on the authentication technology
}

type EnvironmentalImpact              {
    CO2Emission                    :      Double;
    NuclearWaste                   :      Double;
  }
type OICPEvseDataRecord {
  deltaType                        :      String; // In case that the operation “PullEvseData” is performed with the parameter “LastCall”, Hubject assigns this attribute to every response EVSE record in order to return the changes compared to the last call.
  lastUpdate                       :      Timestamp; // The attribute indicates the date and time of the last update of the record. Hubject assigns this attribute to every response EVSE record.
  EvseID                           :      String; // The ID that identifies the charging spot.
  ChargingPoolID                   :      String; // The ID that identifies the charging station.
  ChargingStationID                :      String; // The ID that identifies the charging station. Field Length = 50
  ChargingStationNames             : many OICPInfoText; // Name of the charging station in different Languages
  HardwareManufacturer             :      String; // Name of the charging point manufacturer. Field Length = 50
  ChargingStationImage             :      String; // URL that redirect to an online image of the related EVSEID. Field Length = 200
  SubOperatorName                  :      String; // Name of the Sub Operator owning the Charging Station. Field Length = 100
  Address                          :      OICPAddressIso19773; // Address of the charging station.
  GeoCoordinates                   :      OICPGeoCoordinate; // Geolocation of the charging station. Field Length = 100
  Plugs                            : many String; // List of plugs that are supported.
  DynamicPowerLevel                :      Boolean; // Informs is able to deliver different power outputs.
  ChargingFacilities               : many OICPChargingFacility; // List of facilities that are supported.
  RenewableEnergy                  :      Boolean; // If the Charging Station provides only renewable energy then the value must be” true”, if it use grey energy then value must be “false”.
  EnergySource                     : many OICPEnergySource; // List of energy source that the charging station uses to supply electric energy.
  EnvironmentalImpact              : EnvironmentalImpact;
  CalibrationLawDataAvailability   :      String; // This field gives the information how the charging station provides metering law data.
  AuthenticationModes              : many String; // List of authentication modes that are supported.
  MaxCapacity                      :      Integer; // Integer. Maximum capacity in kWh
  PaymentOptions                   : many String; // List of payment options that are supported.
  ValueAddedServices               : many String; // List of value added services that are supported.
  Accessibility                    :      String; // Specifies how the charging station can be accessed.
  AccessibilityLocation            : many String; // Inform the EV driver where the ChargingPoint could be accessed.
  HotlinePhoneNumber               :      String; // Phone number of a hotline of the charging station operator.
  AdditionalInfo                   : many OICPInfoText; // Optional information. Field Length = 200
  ChargingStationLocationReference : many OICPInfoText; // Last meters information regarding the location of the Charging Station
  GeoChargingPointEntrance         :      OICPGeoCoordinate; // In case that the charging spot is part of a bigger facility (e.g. parking place), this attribute specifies the facilities entrance coordinates.
  IsOpen24Hours                    :      Boolean; // Set in case the charging spot is open 24 hours.
  OpeningTimes                     :      OICPOpeningTime; // Opening time in case that the charging station cannot be accessed around the clock.
  ClearinghouseID                  :      String; // Identification of the corresponding clearing house in the event that roaming between different clearing houses must be processed in the future. Field Length = 20
  IsHubjectCompatible              :      Boolean; // Is eRoaming via intercharge at this charging station possible? If set to "false" the charge spot will not be started/stopped remotely via Hubject.
  DynamicInfoAvailable             :      String // Values; true / false / auto This attribute indicates whether a CPO provides (dynamic) EVSE Status info in addition to the (static) EVSE Data for this EVSERecord. Value auto is set to true by Hubject if the operator offers Hubject EVSEStatus data.
}

type OICPInfoText {
  lang  : String; // The language in which the additional info text is provided.
  value : String; // The Additional Info text. Field Length = 150
}

type OICPGeoCoordinate { // Important: One of the following three options MUST be provided
  Google              : OICPGeoCoordinatesGoogle; // Geocoordinates using Google Structure
  DecimalDegree       : Coordinate; // Geocoordinates using DecimalDegree Structure
  DegreeMinuteSeconds : Coordinate; // Geocoordinates using DegreeMinutesSeconds Structure
}

type OICPGeoCoordinatesGoogle {
  Coordinates : String; // Based on WGS84
}

type OICPChargingFacility {
  PowerType     :      String; // Charging Facility power type (e.g. AC or DC)
  Voltage       :      Integer; // Voltage of the Charging Facility. Field Length = 3
  Amperage      :      Double; // Amperage of the Charging Facility. Field Length = 2
  Power         :      Double; // Charging Facility power in kW. Field Length = 3
  ChargingModes : many String; // List of charging modes that are supported.
}

type OICPEnergySource {
  Energy     : many String;
  Percentage :      Double; // Percentage of EnergyType being used by the charging stations. Field Length = 2
}

type OICPOpeningTime {
  Periods : many Period; // The starting and end time for pricing product applicability in the specified period
  OnDay   :      String; // was "On" // Day values to be used in specifying periods on which the product is available. Workdays = Monday – Friday, Weekend = Saturday – Sunday
}

type RegularHour {
  begin   : String;
  end     : String;
  weekday : Integer;
}

type OpeningTime {
  twentyFourBySeven   :      Boolean;
  regularHours        : many RegularHour;
  exceptionalOpenings : many Period;
  exceptionalClosings : many Period;
}

type MeterValueInBetween                        {
    meterValues                                 : many Double;
  }
type SignedMeteringValue                         {
    SignedMeteringValue                         :      String;
    MeteringStatus                              :      String;
  };
type CalibrationLawVerificationInfo{
    CalibrationLawCertificateID                 :      String;
    PublicKey                                   :      String;
    MeteringSignatureUrl                        :      String;
    MeteringSignatureEncodingFormat             :      String;
    SignedMeteringValuesVerificationInstruction :      String;
  }
aspect OICPChargeDetailRecord {
  sessionID                                     :      String;
  CPOPartnerSessionID                           :      String; // Optional field containing the session id assigned by the CPO to the related operation. Partner systems can use this field to link their own session handling to HBS processes. Field Length = 250
  EMPPartnerSessionID                           :      String; // Optional field containing the session id assigned by an EMP to the related operation. Partner systems can use this field to link their own session handling to HBS processes. Field Length = 250
  PartnerProductID                              :      String; // A pricing product name (for identifying a tariff) that must be unique
  EvseID                                        :      String; // The ID that identifies the charging spot.
  identification                                :      Composition of OICPIdentification; // Authentication data used to authorize the user or car.
  chargingStart                                 :      Timestamp; // The date and time at which the charging process started.
  chargingEnd                                   :      Date; // The date and time at which the charging process stopped.
  sessionStart                                  :      Date; // The date and time at which the session started, e.g. swipe of RFID or cable connected.
  sessionEnd                                    :      Date; // The date and time at which the session ended, e.g. swipe of RFID or cable disconnected.
  MeterValueStart                               :      Double; // Decimal (,3). The starting meter value in kWh.
  MeterValueEnd                                 :      Double; // Decimal (,3). The ending meter value in kWh.
  MeterValueInBetween                           : MeterValueInBetween; // List (MeterValue (Decimal (,3))). List of meter values that may have been taken in between (kWh).
  ConsumedEnergy                                :      Double; // Decimal (,3). The difference between MeterValueEnd and MeterValueStart in kWh.
  SignedMeteringValues                          : many SignedMeteringValue; // Metering Signature basically contains all metering signature values (these values should be in Transparency software format) for different status of charging session for eg start, end or progress. In total you can provide maximum 10 metering signature values
  CalibrationLawVerificationInfo                : CalibrationLawVerificationInfo; // This field provides additional information which could help directly or indirectly to verify the signed metering value by using respective Transparency Software
  HubOperatorID                                 :      String; // Hub operator
  HubProviderID                                 :      String; // Hub provider
}

type OICPRFIDIdentification {
  UID           : String; // The UID from the RFID-Card. It should be read from left to right using big-endian format. Hubject will automatically convert all characters from lower case to upper case.
  EvcoID        : String; // Contract identifier. Hubject will automatically convert all characters from lower case to upper case. A String that MUST be valid with respect to the following regular expression: ISO | DIN ^(([A-Za-z]{2}\-?[A-Za-z0-9]{3}\-?C[A-Za-z0-9]{8}\-?[\d|A-Za-z])|([A-Za-z]{2}[\*|\-]?[A-Za-z0-9]{3}[\*|\-]?[A-Za-z0-9]{6}[\*|\-]?[\d|X]))$ Examples ISO: “DE-8EO-CAet5e4XY-3”, “DE8EOCAet5e43X1” Examples DIN: “DE*8EO*Aet5e4*3”, “DE-8EO-Aet5e4-3”, “DE8EOAet5e43”
  RFID          : String; // The Type of the used RFID card like mifareclassic, desfire.
  PrintedNumber : String(150); // A number printed on a customer’s card for manual authorization (e.q. via a call center) Field Length = 150
  ExpiryDate    : Date; // Until when this card is valid. Should not be set if card does not have an expiration
}

type ConnectorStats {
  totalCharger         : Double;
  availableCharger     : Double;
  totalConnector       : Double;
  unavailableConnector : Double;
  chargingConnector    : Double;
  suspendedConnector   : Double;
  availableConnector   : Double;
  faultedConnector     : Double;
  preparingConnector   : Double;
  finishingConnector   : Double;
}

type Logo{
    url       : String;
    thumbnail : String;
    category  : String;
    type      : String;
    width     : String;
    height    : String;
  }
type OCPIBusinessDetail {
  name        : String;
  website     : String;
  logo        : Logo;
}

type SettingCPO {
    countryCode        : String;
    partyID            : String;
  }
type SettingEMSP{
    countryCode        : String;
    partyID            : String;
    ocpipIdentifierkey : String;
    cert               : String;
  }

type OicpSetting {
  cpo                 : SettingCPO;

  emsp                : SettingEMSP;
  currency            : Currency;
  businessDetails     : OCPIBusinessDetail;
}
