using RiskService from './risk-service';

// annotate RiskService.Risks with {
//     title    @title : 'Title';
//     prio     @title : 'Priority';
//     descr    @title : 'Description';
//     miti     @title : 'Mitigation';
//     impact   @title : 'Impact';
//     supplier @(
//         title                  : 'Supplier',
//         Common.Text            : supplier.fullName,
//         Common.TextArrangement : #TextOnly
//     )
// }

annotate RiskService.Risks with {
    title    @title : 'Title';
    prio     @title : 'Priority';
    descr    @title : 'Description';
    miti     @title : 'Mitigation';
    impact   @title : 'Impact';
}



annotate RiskService.Mitigations with {
    ID          @(
        UI.Hidden,
        Common : {Text : description}
    );
    description @title : 'Description';
    owner       @title : 'Owner';
    timeline    @title : 'Timeline';
    risks       @title : 'Risks';
}

annotate RiskService.Risks with @(UI : {
    HeaderInfo            : {
        TypeName       : 'All Risk',
        TypeNamePlural : 'Risks',
        Title          : {
            $Type : 'UI.DataField',
            Value : title
        },
        Description    : {
            $Type : 'UI.DataField',
            Value : descr
        }
    },
    SelectionFields       : [
        prio,
        impact
    ],
    LineItem              : [
        {Value : title},
        {
            Value                 : miti_ID,
            ![@HTML5.CssDefaults] : {width : '100%'}
        },

        {
            Value       : prio,
            Criticality : criticality
        },
        {
            Value       : impact,
            Criticality : criticality
        }
        // {Value : supplier_ID},
        // {Value : supplier.isBlocked}

    ],
    Facets                : [{
        $Type  : 'UI.ReferenceFacet',
        Label  : 'Main Risks',
        Target : '@UI.FieldGroup#MainRisks'
    }],
    FieldGroup #MainRisks : {Data : [
        {Value : miti_ID},
        {
            Value       : prio,
            Criticality : criticality
        },
        {
            Value       : impact,
            Criticality : criticality
        }
    ]}
}, ) {

};

annotate RiskService.Risks with {
    miti @(Common : {
        //show text, not id for mitigation in the context of risks
        Text            : miti.description,
        TextArrangement : #TextOnly,
        ValueList       : {
            Label          : 'Mitigations',
            CollectionPath : 'Mitigations',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : miti_ID,
                    ValueListProperty : 'ID'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description'
                }
            ]
        }
    });
}
// Annotations for value help

// annotate RiskService.Risks with {
//     supplier @(Common.ValueList : {
//         Label          : 'Suppliers',
//         CollectionPath : 'Suppliers',
//         Parameters     : [
//             {
//                 $Type             : 'Common.ValueListParameterInOut',
//                 LocalDataProperty : supplier_ID,
//                 ValueListProperty : 'ID'
//             },
//             {
//                 $Type             : 'Common.ValueListParameterDisplayOnly',
//                 ValueListProperty : 'fullName'
//             }
//         ]
//     });
// }

// annotate RiskService.Suppliers with {
//     ID        @(
//         title       : 'ID',
//         Common.Text : fullName
//     );
//     fullName  @title : 'Name';
//     isBlocked @title : 'Supplier Blocked';
// }

// annotate RiskService.Suppliers with @Capabilities.SearchRestrictions.Searchable : false;
