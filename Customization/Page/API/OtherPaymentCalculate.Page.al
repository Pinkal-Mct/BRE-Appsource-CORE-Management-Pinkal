namespace BREPropertyManagemenMeghatMaster.BREPropertyManagemenMeghatMaster;

page 73209598 "Other Payment Calculate"
{
    APIGroup = 'finalcal';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'otherPaymentCalculate';
    DelayedInsert = true;
    EntityName = 'otherpaymentcalculate';
    EntitySetName = 'otherpaymentcalculates';
    PageType = API;
    SourceTable = "BLROtherPaymentCalculateSub";
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
                    Caption = 'Secondary Item Type';
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
                field(totalAmountIncludingVAT; Rec."BLRTotal Amount Including VAT")
                {
                    Caption = 'Total Amount Including VAT';
                }
                field(totalVATAmount; Rec."BLRTotal VAT Amount")
                {
                    Caption = 'Total VAT Amount';
                }
                field(vatAmount; Rec."BLRVAT Amount")
                {
                    Caption = 'VAT Amount';
                }
            }
        }
    }
}
