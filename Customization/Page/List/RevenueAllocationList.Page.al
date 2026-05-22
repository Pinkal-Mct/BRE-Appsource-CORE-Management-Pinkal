page 73209657 "Revenue Allocation List"
{
    PageType = List;
    SourceTable = "BLRRevenueAllocationDetails";
    ApplicationArea = All;
    Caption = 'Revenue Allocation List';
    UsageCategory = Lists;
    CardPageId = 73209633;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."BLRNo.")
                {
                    ApplicationArea = All;
                    Caption = 'ID';
                    ToolTip = 'The unique identifier for the revenue allocation entry.';
                }
                field(Month; Rec."BLRMonth")
                {
                    ApplicationArea = All;
                    Caption = 'Month';
                    ToolTip = 'The month for which the revenue allocation is applicable.';
                }
                field("Financial Year"; Rec."BLRFinancial Year")
                {
                    ApplicationArea = All;
                    Caption = 'Financial Year';
                    ToolTip = 'The financial year associated with the revenue allocation.';
                }
                field(Status; Rec."BLRStatus")
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                    ToolTip = 'The status of the revenue allocation entry.';
                }
            }
        }
    }
}
