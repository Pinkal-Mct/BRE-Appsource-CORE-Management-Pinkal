namespace BREPropertyManagemenMeghatMaster.BREPropertyManagemenMeghatMaster;

page 73209593 finalSettelement
{
    APIGroup = 'finalcal';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'finalSettelement';
    DelayedInsert = true;
    EntityName = 'finalSettlement';
    EntitySetName = 'finalSettlements';
    PageType = API;
    SourceTable = "BLRFinalSettlement";
    ODataKeyFields = SystemId;
    DeleteAllowed = true;
    ModifyAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(contractId; Rec."BLRContract ID")
                {
                    Caption = 'Contract ID';
                }
                field(receivablecontractId; Rec."BLRContract ID")
                {
                    Caption = 'Receivable Contract ID';
                }
                field(depositBank; Rec."BLRDeposit Bank")
                {
                    Caption = 'Deposit Bank';
                }
                field(depositStatus; Rec."BLRDeposit Status")
                {
                    Caption = 'Deposit Status';
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
                field(receivabletenantID; Rec."BLRTenant ID")
                {
                    Caption = 'Receivable Tenant ID';
                }

                field("receivableTotalAmount"; Rec."BLRReceivable Total Amount")
                {
                    Caption = 'Receivable Total Amount';
                }
                field("receivableDueDate"; Rec."BLRReceivable Due Date")
                {
                    Caption = 'Receivable Due Date';
                }
                field("receivablePaymentmode"; Rec."BLRReceivable Payment mode")
                {
                    Caption = 'Receivable Payment mode';
                }
                field("receivablePaymentStatus"; Rec."BLRReceivable Payment Status")
                {
                    Caption = 'Receivable Payment Status';
                }
                field("receivableChequeNo"; Rec."BLRReceivable Cheque No.")
                {
                    Caption = 'Receivable Cheque No.';
                }
                field("receivablefromtheTenant"; Rec."BLRReceivable from the Tenant")
                {
                    Caption = 'Receivable from the Tenant';
                }
                field("paymentProcessed"; Rec."BLRPayment Processed")
                {
                    Caption = 'Payment Processed';
                }
                field("balanceReceivable"; Rec."BLRBalance Receivable")
                {
                    Caption = 'Balance Receivable';
                }
                field(paymentStatusmode; Rec."BLRPaymentStatus")
                {
                    Caption = 'Payment Status mode';
                }
                field("paymentreceipt"; Rec."BLRPayment Receipt")
                {
                    Caption = 'Payment Receipt';
                }
                field("paymentreceiptdocumentuRL"; Rec."BLRPmtRcptDocURL")
                {
                    Caption = 'Payment Receipt document URL';
                }
                field(receivablePaymentStatuss; Rec."BLRreceivablePaymentStatuss")
                {
                    Caption = 'receivable Payment Status';
                }
            }
        }
    }
}
