namespace BREPropertyManagemenMeghatMaster.BREPropertyManagemenMeghatMaster;

page 73209575 "BLRAdditional Charges Sub Api"
{
    APIGroup = 'finalcal';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'additionalChargesSubApi';
    DelayedInsert = true;
    EntityName = 'additionalchargessub';
    EntitySetName = 'additionalchargessubs';
    PageType = API;
    SourceTable = "BLRAdditionalChargesSub";
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
                field(contractID; Rec."BLRContract ID")
                {
                    Caption = 'Contract ID';
                }
                field(endDate; Rec."BLREnd Date")
                {
                    Caption = 'End Date';
                }
                field(entryNo; Rec."BLREntry No.")
                {
                    Caption = 'Entry No.';
                }
                field(secondaryItemType; Rec."BLRSecondary Item Type")
                {
                    Caption = 'Secondary Item';
                }
                field(startDate; Rec."BLRStart Date")
                {
                    Caption = 'Start Date';
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
                field(totalAmount; Rec."BLRTotal Amount")
                {
                    Caption = 'Total Amount';
                }
                field(vat; Rec."BLRVAT %")
                {
                    Caption = 'VAT %';
                }
                field(vatAmount; Rec."BLRVAT Amount")
                {
                    Caption = 'VAT Amount';
                }
                field(invoiced; Rec."BLRInvoiced")
                {
                    Caption = 'VAT Amount';
                }
                field("invoicedID"; Rec."BLRInvoiced ID")
                {
                    Caption = 'Invoiced ID';
                }
                field("unitType"; Rec."BLRUnit Type")
                {
                    Caption = 'Unit Type';
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
            }
        }
    }
}
