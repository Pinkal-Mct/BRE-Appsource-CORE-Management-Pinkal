namespace BREPropertyManagemenMeghatMaster.BREPropertyManagemenMeghatMaster;

page 73209610 "Revenue Calculate Sub Api"
{
    APIGroup = 'finalcal';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'revenueCalculateSubApi';
    DelayedInsert = true;
    EntityName = 'revenuecalculatesub';
    EntitySetName = 'revenuecalculatesubs';
    PageType = API;
    SourceTable = "BLRRevenueCalculateSub";
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
                field(installmentEndDate; Rec."BLRInstallment End Date")
                {
                    Caption = 'Installment End Date';
                }
                field(installmentStartDate; Rec."BLRInstallment Start Date")
                {
                    Caption = 'Installment Start Date';
                }
                field(rsID; Rec."BLRRS ID")
                {
                    Caption = 'RS ID';
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
