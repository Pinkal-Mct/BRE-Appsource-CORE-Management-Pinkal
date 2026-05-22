namespace PropertyManagement.PropertyManagement;

page 73209605 "Payment Type"
{
    APIGroup = 'payment';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'paymentType';
    DelayedInsert = true;
    EntityName = 'paymentType';
    EntitySetName = 'paymentTypes';
    PageType = API;
    SourceTable = "BLRPaymentType";
    ODataKeyFields = SystemId;
    ModifyAllowed = true;
    DeleteAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(paymentID; Rec."BLRPayment ID")
                {
                    Caption = 'Payment ID';
                }
                field(paymentMethod; Rec."BLRPayment Method")
                {
                    Caption = 'Payment Method';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
            }
        }
    }
}
