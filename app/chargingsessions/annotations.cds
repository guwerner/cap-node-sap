namespace emobility.cpo;

using RiskService as service from '../../srv/risk-service';

/**
 * annotate service.Transactions with { id @title:
 * '{@i18n>id}'; currentTimestamp @title:
 * '{@i18n>currentTimestamp}'; }
 */


annotate service.Transactions with {
    id               @title : 'ID';
    currentTimestamp @title : 'Started On';
    chargeBox        @title : 'Charging Station';
    siteID           @title : 'Side';
    siteAreaID       @title : 'Side Area';
    tagID            @title : 'Badge ID';
}


annotate service.Transactions with @(UI : 
    {
        SelectionFields : [
        currentTimestamp,
        chargeBox,
        siteID,
        siteAreaID,
        tagID
]});

// annotate service.Transactions with {
//   status @UI.Hidden;
// }


annotate service.Transactions with @sap.display.format {
    currentTimestamp
};

annotate service.Transactions with {
    source @(Common : {ValueList : {
        DistinctValuesSupported : true,
        CollectionPath          : 'ChargingStations',
        Parameters              : [
            {
                $Type             : 'Common.ValueListParameterOut',
                LocalDataProperty : source,
                ValueListProperty : 'name'
            },
            {
                $Type             : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'chargePointVendor'
            },
            {
                $Type             : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'chargePointModel'
            }
        ]
    }});
};


/**
 * Low noch anpassen \*
 */
annotate service.Transactions with @(
    UI.SelectionVariant #DoneFilter  : {
        Text          : 'Done',
        SelectOptions : [{
            $Type        : 'UI.SelectOptionType',
            PropertyName : status,
            Ranges       : [{
                $Type  : 'UI.SelectionRangeType',
                Sign   : #I,
                Option : #EQ,
                Low    : 'done'
            }]
        }]
    },
    UI.SelectionVariant #InProcessFilter : {
        Text          : 'In Process',
        SelectOptions : [{
            $Type        : 'UI.SelectOptionType',
            PropertyName : status,
            Ranges       : [{
                Sign   : #I,
                Option : #EQ,
                Low    : 'in_progress'
            }]
        }]
    },

    UI.SelectionVariant #InErrorFilter   : {
        Text          : 'In Error',
        SelectOptions : [{
            $Type        : 'UI.SelectOptionType',
            PropertyName : status,
            Ranges       : [{
                Sign   : #I,
                Option : #EQ,
                Low    : 'error'
            }]
        }]
    }
);



annotate service.Transactions with @(UI.LineItem : [
    {
        $Type : 'UI.DataField',
        Label : 'ID',
        Value : id
    },
    {
        $Type : 'UI.DataField',
        Label : 'Started on',
        Value : currentTimestamp
    },
    {
        $Type : 'UI.DataField',
        Label : 'Status',
        Value : status,
        ![@HTML5.CssDefaults] : {width : '6.813rem'}
    },
    {
        $Type : 'UI.DataField',
        Label : 'Charging Station',
        Value : chargeBox
    },
    {
        $Type : 'UI.DataField',
        Label : 'Connector',
        Value : connectorId,
        ![@HTML5.CssDefaults] : {width : '5.813rem'}
    },
    {
        $Type : 'UI.DataField',
        Label : 'Badge-ID',
        Value : tagID,
        ![@HTML5.CssDefaults] : {width : '4.813rem'}
    },
    {
        $Type : 'UI.DataField',
        Label : 'Inactivity',
        Value : currentTotalInactivitySecs,
        ![@HTML5.CssDefaults] : {width : '4.813rem'}
    },
    {
        $Type : 'UI.DataField',
        Label : 'Output',
        Value : lastConsumption
    },
    {
        $Type : 'UI.DataField',
        Label : 'Power Consuption',
        Value : currentTotalConsumptionWh,
        ![@HTML5.CssDefaults] : {width : '4.813rem'}
    },
    {
        $Type : 'UI.DataField',
        Label : 'State of Charge',
        Value : stateOfCharge
    },
    {
        $Type : 'UI.DataField',
        Label : 'Costs',
        Value : roundedPrice
    },
    {
        $Type : 'UI.DataField',
        Label : 'Unit',
        Value : priceUnit
    }
]);

annotate service.Transactions with @(UI: {
     HeaderInfo  : {
        TypeName : 'Charge Session Detail',
        TypeNamePlural : 'Charge Session Details',
        Title: {
            $Type : 'UI.DataField',
            Value : chargeBox
        },
        Description : {
         $Type : 'UI.DataField',
         Value : chargeBoxID
        }
    },
     Facets                      : [{
        $Type  : 'UI.ReferenceFacet',
        ID     : 'GeneratedFacet1',
        Label  : 'General Information',
        Target : '@UI.FieldGroup#GeneratedGroup1',
    }],
    FieldGroup #GeneratedGroup1 : {
        Data  : [
            {
                Label: 'ID',
                Value : id
            },
            {
                Label: 'Started On',
                Value : currentTimestamp
            },
            {
                Value : status
            },
            {
               Value : chargeBox
            },
            {
                Value : connectorId
            }
    ]}
   
});

