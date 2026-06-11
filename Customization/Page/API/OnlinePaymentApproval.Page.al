namespace BREPropertyManagemenMeghatMaster.BREPropertyManagemenMeghatMaster;

page 73209597 BLROnlinePaymentApproval
{
    APIGroup = 'payment';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'onlinePaymentApproval';
    DelayedInsert = true;
    EntityName = 'onlinePaymentApproval';
    EntitySetName = 'onlinePaymentApprovals';
    PageType = API;
    SourceTable = "BLROnlinePaymentApproval";

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
                field(paymentSeries; Rec."BLRPayment Series")
                {
                    Caption = 'Payment Series';
                }
                field("paymenttransactionID"; Rec."BLRPayment transaction ID")
                {
                    Caption = 'Payment transaction ID';
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
                field("tenantName"; Rec."BLRTenant Name")
                {
                    Caption = 'Tenant Name';
                }
                field(totalAmount; Rec."BLRTotal Amount")
                {
                    Caption = 'Amount with vat';
                }
                field(status; Rec."BLRStatus")
                {
                    Caption = 'Status';
                }
            }
        }
    }
}
