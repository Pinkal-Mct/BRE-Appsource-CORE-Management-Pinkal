namespace PropertyManagement.PropertyManagement;

page 73209602 BLRpaymentSchedule2
{
    APIGroup = 'tenants';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'paymentSchedule2';
    DelayedInsert = true;
    EntityName = 'paymentSchedules';
    EntitySetName = 'paymentScheduless';
    PageType = API;
    SourceTable = "BLRPaymentSchedule2";
    ODataKeyFields = SystemId;
    DeleteAllowed = true;
    ModifyAllowed = true;

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
                field(amountIncludingVAT; Rec."BLRAmount Including VAT")
                {
                    Caption = 'Amount Including VAT';
                }
                field(dueDate; Rec."BLRDue Date")
                {
                    Caption = 'Due Date';
                }
                field(entryNo; Rec."BLREntry No.")
                {
                    Caption = 'Entry No.';
                }
                field(installmentEndDate; Rec."BLRInstallment End Date")
                {
                    Caption = 'Installment End Date';
                }
                field(installmentNo; Rec."BLRInstallment No.")
                {
                    Caption = 'Installment No.';
                }
                field(installmentStartDate; Rec."BLRInstallment Start Date")
                {
                    Caption = 'Installment Start Date';
                }
                field(secondaryItemType; Rec."BLRSecondary Item Type")
                {
                    Caption = 'Secondary Item Type';
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
                field(vatAmount; Rec."BLRVAT Amount")
                {
                    Caption = 'VAT Amount';
                }
                field("contractID"; Rec."BLRContract ID")
                {
                    Caption = 'Contract ID';
                }
                field("paymentStatus"; Rec."BLRPayment Status")
                {
                    Caption = 'Payment Status';
                }
                field("contractStatus"; Rec."BLRContract Status")
                {
                    Caption = 'Contract Status';
                }
                field("invoiceID"; Rec."BLRInvoice ID")
                {
                    Caption = 'Invoice ID';
                }
                field("overdueInvoice"; Rec."BLROverdue Invoice")
                {
                    Caption = 'Overdue Invoice';
                }
                field("paymentRecievedDate"; Rec."BLRPayment Recieved Date")
                {
                    Caption = 'Payment Recieved Date';
                }
                field("paymentMode"; Rec."BLRPayment Mode")
                {
                    Caption = 'Payment Mode';
                }
                field("chequeNumber"; Rec."BLRCheque Number")
                {
                    Caption = 'Cheque Number';
                }
                field("contractstartdate"; Rec."BLRContract start date")
                {
                    Caption = 'Contract start date';
                }
                field("propertyID"; Rec."BLRProperty ID")
                {
                    Caption = 'Property ID';
                }
                field("noofDays"; Rec."BLRNo of Days")
                {
                    Caption = 'No of Days';
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
                field("Payment_Series"; Rec."BLRPayment Series")
                {
                    Caption = 'Payment Series';
                }

            }
        }
    }
}
