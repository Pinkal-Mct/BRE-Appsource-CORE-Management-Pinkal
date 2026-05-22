namespace PropertyManagement.PropertyManagement;

page 73209600 paymentdata
{
    APIGroup = 'payment';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'paymentdata';
    DelayedInsert = true;
    EntityName = 'paymentData';
    EntitySetName = 'paymentData';
    PageType = API;
    SourceTable = "BLRPaymentMode2";
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(amount; Rec."BLRAmount")
                {
                    Caption = 'Amount';
                }
                field(amountIncludingVAT; Format(Rec."BLRAmount Including VAT", 0, '<Integer><Decimals,3>'))
                {
                    Caption = 'Amount Including VAT';
                }
                field(chequeNumber; Rec."BLRCheque Number")
                {
                    Caption = 'Cheque Number';
                }
                field(depositBank; Rec."BLRDeposit Bank")
                {
                    Caption = 'Deposit Bank';
                }
                field(depositStatus; Rec."BLRDeposit Status")
                {
                    Caption = 'Deposit Status';
                }
                field(dueDate2; Rec."BLRDue Date")
                {
                    Caption = 'Due Date';
                }
                field(paymentMode; Rec."BLRPayment Mode")
                {
                    Caption = 'Payment Mode';
                }
                field(paymentSeries; Rec."BLRPayment Series")
                {
                    Caption = 'Payment Series';
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
                field(tenantId; Rec."BLRTenant Id")
                {
                    Caption = 'Tenant Id';
                }
                field(vatAmount; Rec."BLRVAT Amount")
                {
                    Caption = 'VAT Amount';
                }
                field("contractID"; Rec."BLRContract ID")
                {
                    Caption = 'Contract id';
                }
                field("paymentStatus"; Rec."BLRPayment Status")
                {
                    Caption = 'Payment Status';
                }
                field("chequeStatus"; Rec."BLRCheque Status")
                {
                    Caption = 'Cheque Status';
                }
                field("invoice"; Rec."BLRInvoice #")
                {
                    Caption = 'Invoice';
                }
                field("receipt"; Rec."BLRReceipt #")
                {
                    Caption = 'Receipt';
                }
                field("oldCheque"; Rec."BLROld Cheque #")
                {
                    Caption = 'Old Cheque';
                }
                field("uploadCheque"; Rec."BLRUpload Cheque")
                {
                    Caption = 'Upload Cheque';
                }
                field("download"; Rec."BLRDownload")
                {
                    Caption = 'Download';
                }
                field(view; Rec."BLRView")
                {
                    Caption = 'View';
                }
                field("viewRevenueDetails"; Rec."BLRView Revenue Details")
                {
                    Caption = 'View Revenue Details';
                }
                field("viewDocumentURL"; Rec."BLRView Document URL")
                {
                    Caption = 'View Document URL';
                }
                field("entryNo"; Rec."BLREntry No.")
                {
                    Caption = 'Entry No';
                }
                field("approveDeclineStatus"; Rec."BLRApprove/Decline Status")
                {
                    Caption = 'Approve/Decline Status';
                }
                field("tenantEmail"; Rec."BLRTenant Email")
                {
                    Caption = 'Tenant Email';
                }
                field("tenantName"; Rec."BLRTenant Name")
                {
                    Caption = 'Tenant Name';
                }
                field("viewInvoice"; Rec."BLRView Invoice")
                {
                    Caption = 'View Invoice';
                }
                field("viewRecieptdocumentURL"; Rec."BLRView Reciept document URL")
                {
                    Caption = 'View Reciept document URL';
                }
                field("paymentReceivedDate"; Rec."BLRPayment Received Date")
                {
                    Caption = 'Payment Received Date';
                }

                field("paymentReminder"; Rec."BLRPayment Reminder")
                {
                    Caption = 'Payment Reminder';
                }
                field("creditNoteNo"; Rec."BLRCredit Note No.")
                {
                    Caption = 'Credit Note No.';
                }
                field("creditNoteAmount"; Rec."BLRCredit Note Amount")
                {
                    Caption = 'Credit Note Amount';
                }
                field("finalRentAmount"; Rec."BLRFinal Rent Amount")
                {
                    Caption = 'Final Rent Amount';
                }
                field("portalSidePaymentProcessing"; Rec."BLRPortalSidePaymentProcessing")
                {
                    Caption = 'Portal Side Payment Processing';
                }

            }
        }
    }
}
