namespace BREPropertyManagemenMeghatMaster.BREPropertyManagemenMeghatMaster;
page 73209585 "Credit Note Approval"
{
    APIGroup = 'finalcal';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'creditNoteApproval';
    DelayedInsert = true;
    EntityName = 'creditNoteApproval';
    EntitySetName = 'creditNoteApprovals';
    PageType = API;
    SourceTable = "BLRCreditNoteApproval";
    DeleteAllowed = true;
    ModifyAllowed = true;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(creditnoteamount; Rec."BLRCredit Note Amount")
                {
                    Caption = 'Credit Note Amount';
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
                field(fcID; Rec."BLRFC ID")
                {
                    Caption = 'FC ID';
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
                field(tenantID; Rec."BLRTenant ID")
                {
                    Caption = 'Tenant ID';
                }
                field(tenantName; Rec."BLRTenant Name")
                {
                    Caption = 'Tenant Name';
                }
            }
        }
    }
}
