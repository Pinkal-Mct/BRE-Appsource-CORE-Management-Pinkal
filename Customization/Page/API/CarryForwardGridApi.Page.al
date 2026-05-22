namespace BREPropertyManagemenMeghatMaster.BREPropertyManagemenMeghatMaster;

page 73209579 "Carry Forward Grid Api"
{
    APIGroup = 'finalcal';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'carryForwardGridApi';
    DelayedInsert = true;
    EntityName = 'carryforwardgrid';
    EntitySetName = 'carryforwardgrids';
    PageType = API;
    SourceTable = "BLRCarryForwardGrid";
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
                field(entryNo; Rec."BLREntry No.")
                {
                    Caption = 'Entry No.';
                }
                field(newContractID; Rec."BLRNew Contract ID")
                {
                    Caption = 'New Contract ID';
                }
                field(securityDeposit; Rec."BLRSecurity Deposit")
                {
                    Caption = 'Security Deposit';
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
                field(totalAmount; Rec."BLRTotal Amount")
                {
                    Caption = 'Total Amount';
                }
            }
        }
    }
}
