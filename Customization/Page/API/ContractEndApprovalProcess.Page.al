namespace BREPropertyManagemenMeghatMaster.BREPropertyManagemenMeghatMaster;

page 73209582 ContractEndApprovalProcess
{
    APIGroup = 'payment';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'contractEndApprovalProcess';
    DelayedInsert = true;
    EntityName = 'contractendapproval';
    EntitySetName = 'contractendapprovals';
    PageType = API;
    ODataKeyFields = SystemId;
    SourceTable = "BLRContractEndProcessApproval";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(contractId; Rec."BLRContract Id")
                {
                    Caption = 'Contract Id';
                }
                field(propertyMStatus; Rec."BLRProperty_M Status")
                {
                    Caption = 'Property Manager Status';
                }
                field(endDate; Rec."BLREnd Date")
                {
                    Caption = 'Contract End Date';
                }
                field(id; Rec."BLRID")
                {
                    Caption = 'ID';
                }
                field(tenantEmail; Rec."BLRTenant Email")
                {
                    Caption = 'Requested Date';
                }
                field(startDate; Rec."BLRStart Date")
                {
                    Caption = 'Contract Start Date';
                }
                field(leaseMStatus; Rec."BLRLease_M Status")
                {
                    Caption = 'Lease Manager Status';
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
                field(tenantId; Rec."BLRTenant Id")
                {
                    Caption = 'Tenant Id';
                }
                field(tenantName; Rec."BLRTenant Name")
                {
                    Caption = 'Tenant Name';
                }
                field("leaseManagerRemark"; Rec."BLRLease Manager Remark")
                {
                    Caption = 'Lease Manager Remark';
                }
                field("propertyManagerRemark"; Rec."BLRProperty Manager Remark")
                {
                    Caption = 'Property Manager Remark';
                }
                field("value"; Rec."BLRValue")
                {
                    Caption = 'Value';
                }

                field("renewalNotificationtoTenant"; Rec."BLRRenewalNotiftoTenant")
                {
                    Caption = 'Renewal Notification to Tenant';
                }
            }
        }
    }
}
