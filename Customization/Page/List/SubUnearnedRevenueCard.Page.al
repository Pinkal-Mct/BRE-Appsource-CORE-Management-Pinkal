page 73209663 "BLRSub Unearned Revenue Card"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "BLRSubUnearnedRevenueReport";
    Caption = 'Unearned Rent Revenue Report';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Header No."; Rec."BLRHeader No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unique identifier for the unearned revenue report header.';
                    Visible = false;
                }
                field("Line No."; Rec."BLRLine No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unique identifier for the line in the unearned revenue report.';
                    Editable = false;
                }
                field("Report Period"; Rec."BLRReport Period")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Reporting period for the unearned charges data.';
                }
                field("Contract ID"; Rec."BLRContract ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unique identifier for the contract associated with the unearned revenue.';
                    Editable = false;
                }
                field("Customer Name"; Rec."BLRCustomer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Name of the customer associated with the unearned revenue.';
                    Editable = false;
                }
                field("Unit Name"; Rec."BLRUnit Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Name of the unit associated with the unearned revenue.';
                    Editable = false;
                }
                field(Property; Rec."BLRProperty")
                {
                    ApplicationArea = All;
                    ToolTip = 'Property associated with the unearned revenue.';
                    Editable = false;
                }
                field("Owner Name"; Rec."BLROwner Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Name of the owner associated with the unearned revenue.';
                    Editable = false;
                }
                field("Start Date"; Rec."BLRStart Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Start date of the contract for the unearned revenue.';
                    Editable = false;
                }
                field("End Date"; Rec."BLREnd Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'End date of the contract for the unearned revenue.';
                    Editable = false;
                }
                field("Termination Date"; Rec."BLRTermination Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Termination date of the contract for the unearned revenue.';
                    Editable = false;
                }
                field("Suspension Date"; Rec."BLRSuspension Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Suspension date of the contract for the unearned revenue.';
                    Editable = false;
                }
                field("Contract Value"; Rec."BLRContract Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total value of the contract associated with the unearned revenue.';
                    Editable = false;
                }
                field("Contract Status"; Rec."BLRContract Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Status of the contract associated with the unearned revenue.';
                    Editable = false;
                }
                field("Opening Balance"; Rec."BLROpening Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Opening balance of the unearned revenue for the contract.';
                    Editable = false;
                }
                field("Invoice Raised During the Year"; Rec."BLRInvRaisedDurtheYear")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total invoice amount raised during the year for the unearned revenue.';
                    Editable = false;
                }
                field("RevenueAllocated DuringtheYear"; Rec."BLRRevAllocDurtheYear")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total revenue allocated during the year for the unearned revenue.';
                    Editable = false;
                }
                field("Unearned Revenue Balance"; Rec."BLRUnearned Revenue Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Current balance of the unearned revenue for the contract.';
                    Editable = false;
                }
                field(CalculatedUnearnedRevBalance; Rec."BLRCalculatedUnearnedRevB19C1")
                {
                    ApplicationArea = All;
                    ToolTip = 'Calculated unearned revenue balance based on the report data.';
                    Editable = false;
                }
                field("Shortfall/Excess"; Rec."BLRShortfall/Excess")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shortfall or excess amount in the unearned revenue report.';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(GenerateExcel)
            {
                Caption = 'Generate Excel';
                ApplicationArea = All;
                Image = ExportToExcel;
                ToolTip = 'Generate an Excel report for the unearned other charges revenue.';

                trigger OnAction()
                var
                    createExcelReport: Codeunit "BLRCreate Excel Report";
                begin
                    createExcelReport.GenerateExcelReportForAnyTable(73209694, 73209576, Rec."BLRHeader No.");
                end;
            }
        }
    }
}