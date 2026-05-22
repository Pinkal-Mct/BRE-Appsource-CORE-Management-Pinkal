namespace BREPropertyManagemenMeghatMaster.BREPropertyManagemenMeghatMaster;

page 73209591 finalpaymentapproval
{
    APIGroup = 'finalcal';
    APIPublisher = 'realestste';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'finalpaymentapproval';
    DelayedInsert = true;
    EntityName = 'finalPaymentApproval';
    EntitySetName = 'finalPaymentApprovals';
    PageType = API;
    SourceTable = "BLRfinalPaymentApproval";
    DeleteAllowed = true;
    ModifyAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(contractID; Rec."BLRContract ID")
                {
                    Caption = 'Contract ID';
                }
                field(description; Rec."BLRDescription")
                {
                    Caption = 'Description';
                }
                field(dueDate; Rec."BLRDue Date")
                {
                    Caption = 'Due Date';
                }
                field(id; Rec."BLRID")
                {
                    Caption = 'ID';
                }
                field(paymentDate; Rec."BLRPayment Date")
                {
                    Caption = 'Payment Date';
                }
                field(paymentMode; Rec."BLRPayment Mode")
                {
                    Caption = 'Payment Mode';
                }
                field(paymentTransactionID; Rec."BLRPayment transaction ID")
                {
                    Caption = 'Payment transaction ID';
                }
                field(status; Rec."BLRStatus")
                {
                    Caption = 'Status';
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
                field(tenantID; Rec."BLRTenant ID")
                {
                    Caption = 'Tenant ID';
                }
                field(tenantName; Rec."BLRTenant Name")
                {
                    Caption = 'Tenant Name';
                }
                field(totalAmount; Rec."BLRTotal Amount")
                {
                    Caption = 'Total Amount';
                }
            }
        }
    }
}
