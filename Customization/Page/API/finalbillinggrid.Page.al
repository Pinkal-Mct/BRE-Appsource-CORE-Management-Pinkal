namespace BREPropertyManagemenMeghatMaster.BREPropertyManagemenMeghatMaster;

page 73209587 finalbillinggrid
{
    APIGroup = 'finalcal';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'finalbillinggrid';
    DelayedInsert = true;
    EntityName = 'finalbillinggrid';
    EntitySetName = 'finalbillinggrids';
    PageType = API;
    SourceTable = "BLRFinalBillingCalculationGrid";
    ODataKeyFields = SystemId;
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
                field(differenceAmount; Rec."BLRDifferenceAmount")
                {
                    Caption = 'Difference Amount';
                }
                field(differenceAmountInclVAT; Rec."BLRDifferenceAmountInclVAT")
                {
                    Caption = 'Difference Amount Incl. VAT';
                }
                field(differenceVAT; Rec."BLRDifferenceVAT")
                {
                    Caption = 'Difference VAT';
                }
                field(entryNo; Rec."BLREntry No")
                {
                    Caption = 'Entry No';
                }
                field(invoicedAmount; Rec."BLRInvoicedAmount")
                {
                    Caption = 'Invoiced Amount';
                }
                field(invoicedAmountInclVAT; Rec."BLRInvoicedAmountInclVAT")
                {
                    Caption = 'Invoiced Amount Incl. VAT';
                }
                field(invoicedVAT; Rec."BLRInvoicedVAT")
                {
                    Caption = 'Invoiced VAT';
                }
                field(revenueDescription; Rec."BLRRevenueDescription")
                {
                    Caption = 'Revenue Description';
                }
                field(revisedAmount; Rec."BLRRevisedAmount")
                {
                    Caption = 'Revised Amount';
                }
                field(revisedAmountInclVAT; Rec."BLRRevisedAmountInclVAT")
                {
                    Caption = 'Revised Amount Incl. VAT';
                }
                field(revisedVAT; Rec."BLRRevisedVAT")
                {
                    Caption = 'Revised VAT';
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
                field(terminationDate; Rec."BLRTermination Date")
                {
                    Caption = 'Termination Date';
                }
                field(totalDifferenceVAT; Rec."BLRTotal Difference VAT")
                {
                    Caption = 'Total Invoiced Amount';
                }
                field(totalDifferenceAmountInclVAT; Rec."BLRTotalDiffAmtInclVAT")
                {
                    Caption = 'Total Difference Amount Incl. VAT';
                }
                field(totalDifferneceAmount; Rec."BLRTotal Differnece Amount")
                {
                    Caption = 'Total Difference Amount';
                }
                field(totalInvoicedAmount; Rec."BLRTotal Invoiced Amount")
                {
                    Caption = 'Total Invoiced Amount';
                }
                field(totalInvoicedAmountInclVAT; Rec."BLRTotalInvdAmtInclVAT")
                {
                    Caption = 'Total Invoiced Amount';
                }
                field(totalInvoicedVAT; Rec."BLRTotal Invoiced VAT")
                {
                    Caption = 'Total Invoiced VAT';
                }
                field(totalRevisedAmount; Rec."BLRTotal Revised Amount")
                {
                    Caption = 'Total Revised Amount';
                }
                field(totalRevisedAmountInclVAT; Rec."BLRTotalRevAmtInclVAT")
                {
                    Caption = 'Total Revised Amount Incl. VAT';
                }
                field(totalRevisedVAT; Rec."BLRTotal Revised VAT")
                {
                    Caption = 'Total Invoiced Amount';
                }
                field("invoiceToBeRaised"; Rec."BLRInvoice To Be Raised")
                {
                    Caption = 'Invoice To Be Raised';
                }
                field("creditNoteToBeRaised"; Rec."BLRCredit Note To Be Raised")
                {
                    Caption = 'CreditNoteToBeRaised';
                }
                field("paymentType"; Rec."BLRPayment Type")
                {
                    Caption = 'Payment Type';
                }
                field("propertyClassification"; Rec."BLRProperty Classification")
                {
                    Caption = 'Property Classification';
                }
                field(invoiced; Rec."BLRInvoiced")
                {
                    Caption = 'Invoiced';
                }
                field("tenantID"; Rec."BLRTenant ID")
                {
                    Caption = 'Tenant ID';
                }
                field("invoiceID"; Rec."BLRInvoice ID")
                {
                    Caption = 'Invoice ID';
                }
                field("postedInvoiceID"; Rec."BLRPosted Invoice ID")
                {
                    Caption = 'Posted Invoice ID';
                }
                field("invoiceDocument"; Rec."BLRInvoice Document")
                {
                    Caption = 'Invoice Document';
                }
                field("invoiceDocumentURL"; Rec."BLRInvoice Document URL")
                {
                    Caption = 'Invoice Document URL';
                }
                field("creditNoteAmount"; Rec."BLRCredit Note Amount")
                {
                    Caption = 'Credit Note Amount';
                }
                field("creditNoteDocument"; Rec."BLRCredit Note Document")
                {
                    Caption = 'Credit Note Document';
                }
                field("creditNoteURL"; Rec."BLRCredit Note Document URL")
                {
                    Caption = 'Credit Note Document URL';
                }

            }
        }
    }
}
