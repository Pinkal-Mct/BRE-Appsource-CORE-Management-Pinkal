namespace BREPropertyManagemenMeghatMaster.BREPropertyManagemenMeghatMaster;

page 73209607 BLRpendingreceivablegrid
{
    APIGroup = 'finalcal';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'pendingreceivablegrid';
    DelayedInsert = true;
    EntityName = 'pendingreceviablegrid';
    EntitySetName = 'pendingreceviablegrids';
    PageType = API;
    SourceTable = "BLRPendingReceviableGrid";
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
                field(receiptsAmount; Rec."BLRReceiptsAmount")
                {
                    Caption = 'Receipts Amount';
                }
                field(receiptsAmountInclVAT; Rec."BLRReceiptsAmountInclVAT")
                {
                    Caption = 'Receipts Amount Incl. VAT';
                }
                field(receiptsVAT; Rec."BLRReceiptsVAT")
                {
                    Caption = 'Receipts VAT';
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
            }
        }
    }
}
