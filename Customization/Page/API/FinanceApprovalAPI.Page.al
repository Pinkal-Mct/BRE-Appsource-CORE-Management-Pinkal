page 73209595 "FinanceApprovalAPI"
{
    APIGroup = 'finance';
    APIPublisher = 'realestate';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'PDC Approval API';
    DelayedInsert = true;
    EntityName = 'pdcApproval';
    EntitySetName = 'pdcApprovals';
    PageType = API;
    ODataKeyFields = SystemId; // Ensure the SystemId is exposed in the API
    SourceTable = "BLRPDCApproval";


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(id; Rec."BLRId") { }
                field(systemId; Rec.SystemId) { }
                field(status; Rec."BLRStatus") { }
                field("pdcId"; Rec."BLRPDC Id") { }
                field(tenantId; Rec."BLRTenant_Id") { }
                field(contractId; Rec."BLRContract_Id") { }
                field(checkNo; Rec."BLRCheck_No") { }
                field(depositeBank; Rec."BLRDeposite_Bank") { }
                field(totalAmount; Rec."BLRTotal_Amount") { }
                field(dueDate; Rec."BLRDue_Date") { }
                field(view; Rec."BLRView") { }

            }
        }
    }

}