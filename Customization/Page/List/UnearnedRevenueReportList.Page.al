page 73209664 "BLRUnearnedRevenueReportList"
{
    PageType = List;
    SourceTable = "BLRUnearnedRevenueReport";
    ApplicationArea = All;
    Caption = 'Unearned Revenue Report List';
    UsageCategory = Lists;
    CardPageId = 73209636;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."BLRNo.")
                {
                    ApplicationArea = All;
                    Caption = 'ID';
                    ToolTip = 'Unique identifier for the unearned revenue report.';
                }
                field("Starting Date Year"; Rec."BLRStarting Date Year")
                {
                    ApplicationArea = All;
                    Caption = 'Starting Date Year';
                    ToolTip = 'The starting date of the year for the unearned revenue report.';
                }
                field("Ending Date Year"; Rec."BLREnding Date Year")
                {
                    ApplicationArea = All;
                    Caption = 'Ending Date Year';
                    ToolTip = 'The ending date of the year for the unearned revenue report.';
                }
            }
        }
    }
}