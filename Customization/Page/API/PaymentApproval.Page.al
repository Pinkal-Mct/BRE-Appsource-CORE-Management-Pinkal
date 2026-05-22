namespace PropertyManagement.PropertyManagement;

page 73209599 PaymentApproval
{
    APIGroup = 'payment';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'paymentApproval';
    DelayedInsert = true;
    EntityName = 'paymentApproval';
    EntitySetName = 'paymentApprovals';
    PageType = API;
    ODataKeyFields = SystemId;
    SourceTable = "BLRApprovalPaymentRequest";

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
                field(id; Rec."BLRID")
                {
                    Caption = 'ID';
                }
                field(manualautoStatus; Rec."BLRManual/Auto Status")
                {
                    Caption = 'Manual/Auto Status';
                }
                field(proposalID; Rec."BLRProposal ID")
                {
                    Caption = 'Proposal ID';
                }
                field(requestType; Rec."BLRRequest Type")
                {
                    Caption = 'Request Type';
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
                field("changeAmount"; Rec."BLRChange Amount")
                {
                    Caption = 'Change Amount';
                }
                field(description; Rec."BLRDescription")
                {
                    Caption = 'Description';
                }
                field("paymentSeries"; Rec."BLRPayment Series")
                {
                    Caption = 'Payment Series';
                }
                field("changePaymentseries"; Rec."BLRchange Payment series")
                {
                    Caption = 'change Payment series';
                }
                field("paymentmode"; Rec."BLRPayment mode")
                {
                    Caption = 'Payment mode';
                }
                field(amount; Rec."BLRAmount")
                {
                    Caption = 'Amount';
                }
                field("vatAmount"; Rec."BLRVat Amount")
                {
                    Caption = 'Vat Amount';
                }

                field("dueDate"; Rec."BLRDue Date")
                {
                    Caption = 'Due Date';
                }
                field(items; Rec."BLRItems")
                {
                    Caption = 'Items';
                }
                field(paymentModeId; Rec."BLRPayment mode ID")
                {
                    Caption = 'Payment mode ID';
                }

            }
        }
    }
}
