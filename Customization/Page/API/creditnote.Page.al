namespace BREPropertyManagemenMeghatMaster.BREPropertyManagemenMeghatMaster;

page 73209584 BLRcreditnote
{
    APIGroup = 'finalcal';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'creditnote';
    DelayedInsert = true;
    EntityName = 'creditNote';
    EntitySetName = 'creditNotes';
    PageType = API;
    SourceTable = "BLRCreditNote";
    DeleteAllowed = true;
    ModifyAllowed = true;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field(contractAmount; Rec."BLRContract Amount")
                {
                    Caption = 'Contract Amount';
                }
                field(contractEndDate; Rec."BLRContract End Date")
                {
                    Caption = 'Contract End Date';
                }
                field(contractID; Rec."BLRContract ID")
                {
                    Caption = 'Contract ID';
                }
                field(contractStartDate; Rec."BLRContract Start Date")
                {
                    Caption = 'Contract Start Date';
                }
                field(creditNoteType; Rec."BLRCredit Note Type")
                {
                    Caption = 'Credit Note Type';
                }
                field(id; Rec."BLRID")
                {
                    Caption = 'ID';
                }
                field(status; Rec."BLRStatus")
                {
                    Caption = 'Status';
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
                field(tenantEmail; Rec."BLRTenant Email")
                {
                    Caption = 'Tenant Email';
                }
                field(tenantID; Rec."BLRTenant ID")
                {
                    Caption = 'Tenant ID';
                }
                field(tenantName; Rec."BLRTenant Name")
                {
                    Caption = 'Tenant Name';
                }
                field(unitType; Rec."BLRUnit Type")
                {
                    Caption = 'Unit Type';
                }
                field("creditNoteDocument"; Rec."BLRCredit Note Document")
                {
                    Caption = 'Credit Note Document';
                }
                field("creditNoteURL"; Rec."BLRCredit Note URL")
                {
                    Caption = 'Credit Note URL';
                }
                field("fcID"; Rec."BLRFC ID")
                {
                    Caption = 'FC ID';
                }
                field("creditNoteNo"; Rec."BLRCredit Note No.")
                {
                    Caption = 'Credit Note No.';
                }
                field("reasonforRejection"; Rec."BLRReason for Rejection")
                {
                    Caption = 'Reason for Rejection';
                }
            }
        }
    }
}
