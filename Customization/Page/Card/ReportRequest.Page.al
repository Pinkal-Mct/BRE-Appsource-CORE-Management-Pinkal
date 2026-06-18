page 73209632 "BLRReport Request"
{
    PageType = Card;
    ApplicationArea = All;
    Caption = 'Report Request';
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(SelectReport)
            {
                Caption = 'Select Report';
                field("Report Type"; reportType)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of report to be generated.';
                    Caption = 'Report Type';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Navigate)
            {
                ApplicationArea = All;
                Caption = 'Navigate to Report';
                ToolTip = 'Navigate to the selected report based on the report type.';
                Image = Navigate;
                trigger OnAction()
                begin
                    case reportType of
                        Enum::"BLRReport Type"::"Security Deposit Report":
                            Report.Run(Report::"BLRSecurity Deposit");
                        Enum::"BLRReport Type"::"PDC Transaction Report":
                            Report.Run(Report::"BLRPDC Transaction Report");
                        Enum::"BLRReport Type"::"Contract Master Data Report":
                            Report.Run(Report::BLRContractMasterData);
                        Enum::"BLRReport Type"::"Revenue Allocation Report":
                            RedirectToRevenueAlloationReport();
                        Enum::"BLRReport Type"::"Unearned Revenue Report":
                            RedirectToUnearnedRevenueReport();
                        else
                            Error('Please select a valid report type.');
                    end;
                end;
            }
        }

        area(Promoted)
        {
            actionref(Navigate_Report; Navigate) { }
        }
    }

    var
        reportType: Enum "BLRReport Type";

    procedure RedirectToRevenueAlloationReport()
    var
        revenueAllocationList: Page "BLRRevenue Allocation List";
    begin
        revenueAllocationList.Run();
    end;

    procedure RedirectToUnearnedRevenueReport()
    var
        unearnedRevenueReportList: Page "BLRUnearnedRevenueReportList";
    begin
        unearnedRevenueReportList.Run();
    end;
}