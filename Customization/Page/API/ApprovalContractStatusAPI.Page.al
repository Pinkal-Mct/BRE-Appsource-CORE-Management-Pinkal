page 73209577 "BLRApprovalContractStatusAPI"
{
    PageType = API;
    SourceTable = "BLRApprovalContractStatus";
    APIPublisher = 'realestate';
    APIGroup = 'approvalflow';
    APIVersion = 'v2.0';
    EntityName = 'approvalContractStatus';
    EntitySetName = 'approvalContractStatuses';
    Caption = 'Approval Contract Status API';
    ODataKeyFields = SystemId;
    DelayedInsert = true;
    DeleteAllowed = true;
    ModifyAllowed = true;

    layout
    {
        area(content)
        {
            field("systemId"; Rec.SystemId)
            {
                Caption = 'System Identifier';
            }

            field(iD; Rec."BLRID")
            {
            }

            field(status; Rec."BLRStatus")
            {
            }

            field("contractID"; Rec."BLRContract ID")
            {
            }

            field("leaseID"; Rec."BLRLease ID")
            {
            }

            field("tenancyContractStatus"; Rec."BLRTenancy Contract Status")
            {
            }

            field("renewalContractID"; Rec."BLRRenewal Contract ID")
            {
            }



        }
    }
}
