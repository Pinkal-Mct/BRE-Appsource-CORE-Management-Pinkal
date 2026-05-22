namespace BREPropertyManagemenMeghatMaster.BREPropertyManagemenMeghatMaster;

page 73209594 finalSettlementRefund
{
    APIGroup = 'finalcal';
    APIPublisher = 'realestste';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'finalSettlementRefund';
    DelayedInsert = true;
    EntityName = 'finalSettlementRefund';
    EntitySetName = 'finalSettlementRefunds';
    PageType = API;
    SourceTable = "BLRFinalSettlementRefund";
    DeleteAllowed = true;
    ModifyAllowed = true;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(balanceRefundable; Rec."BLRBalance Refundable")
                {
                    Caption = 'Balance Refundable';
                }
                field(contractID; Rec."BLRContract ID")
                {
                    Caption = 'Refund Contract ID';
                }
                field(fcID; Rec."BLRFC ID")
                {
                    Caption = 'Refund FC ID';
                }
                field(netRefundToTheTenant; Rec."BLRNet Refund to the Tenant")
                {
                    Caption = 'Net Refund to the Tenant';
                }
                field(payReceiptProofDocumentURL; Rec."BLRPayRcptProofDocURL")
                {
                    Caption = 'Payment Receipt/Proof document URL';
                }
                field(paymentReceiptProof; Rec."BLRPayment Receipt/Proof")
                {
                    Caption = 'Payment Receipt/Proof';
                }
                field(refundChequeNo; Rec."BLRRefund Cheque No.")
                {
                    Caption = 'Cheque No.';
                }
                field(refundDueDate; Rec."BLRRefund Due Date")
                {
                    Caption = 'Due Date';
                }
                field(refundPaymentStatus; Rec."BLRRefund Payment Status")
                {
                    Caption = 'Payment Status';
                }
                field(refundPaymentMode; Rec."BLRRefund Payment mode")
                {
                    Caption = 'Payment mode';
                }
                field(refundProcessed; Rec."BLRRefund Processed")
                {
                    Caption = 'Refund Processed';
                }
                field(refundStatus; Rec."BLRRefund Status")
                {
                    Caption = 'Refund Status';
                }
                field(refundTotalAmount; Rec."BLRRefund Total Amount")
                {
                    Caption = 'Total Amount';
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
                    Caption = 'Refund Tenant ID';
                }
            }
        }
    }
}
