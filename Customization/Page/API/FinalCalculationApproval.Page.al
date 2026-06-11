page 73209589 BLRFinalCalculationApproval
{
    APIGroup = 'finance';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'FinalCalculationApprovalProcess';
    DelayedInsert = true;
    EntityName = 'finalcalculationapproval';
    EntitySetName = 'finalcalculationapprovals';
    PageType = API;
    ODataKeyFields = SystemId;
    SourceTable = "BLRApprovalFinalCalculation";
    DeleteAllowed = true;
    ModifyAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(contractId; Rec."BLRContract ID")
                {
                    Caption = 'Contract Id';
                }
                field(id; Rec."BLRID")
                {
                    Caption = 'ID';
                }
                field(startDate; Rec."BLRContract Start Date")
                {
                    Caption = 'Contract Start Date';
                }

                field(endDate; Rec."BLRContract End Date")
                {
                    Caption = 'Contract End Date';
                }

                field(terminationDate; Rec."BLRTermination Date")
                {
                    Caption = 'Termination Date';
                }

                field(contractAmount; Rec."BLRContract Amount")
                {
                    Caption = 'Contract Amount';
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
                field(tenantId; Rec."BLRTenant ID")
                {
                    Caption = 'Tenant Id';
                }
            }
        }
    }
}
