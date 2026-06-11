page 73209662 "BLRSubUnearnedCharges"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "BLRSubUnearnedCharges";
    Caption = 'Unearned Other Charges Revenue Report';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Header No."; Rec."BLRHeader No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Unique identifier for the header of the unearned charges report.';
                }
                field("Line No."; Rec."BLRLine No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Unique identifier for the line in the unearned charges report.';
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
                    Editable = false;
                    ToolTip = 'Identifier for the contract associated with the unearned charges.';
                }
                field("Customer Name"; Rec."BLRCustomer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Name of the customer associated with the unearned charges.';
                }
                field("Unit Name"; Rec."BLRUnit Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Name of the unit associated with the unearned charges.';
                }
                field(Property; Rec."BLRProperty")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Property associated with the unearned charges.';
                }
                field("Owner Name"; Rec."BLROwner Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Name of the owner associated with the unearned charges.';
                }
                field("Start Date"; Rec."BLRStart Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Start date of the contract for the unearned charges.';
                }
                field("End Date"; Rec."BLREnd Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'End date of the contract for the unearned charges.';
                }
                field("Termination Date"; Rec."BLRTermination Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Date when the contract was terminated for the unearned charges.';
                }
                field("Suspension Date"; Rec."BLRSuspension Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Date when the contract was suspended for the unearned charges.';
                }
                field("Other Charges Value"; Rec."BLROther Charges Value")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Value of the other charges associated with the unearned charges.';
                }
                field("Contract Status"; Rec."BLRContract Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Status of the contract associated with the unearned charges.';
                }
                field("Opening Balance"; Rec."BLROpening Balance")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Opening balance for the unearned charges.';
                }
                field("Invoice Raised During the Year"; Rec."BLRInvRaisedDurtheYear")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Total amount of invoices raised during the year for the unearned charges.';
                }
                field("RevenueAllocated DuringtheYear"; Rec."BLRRevAllocDurtheYear")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Total amount of revenue allocated during the year for the unearned charges.';
                }
                field("Unearned Revenue Balance"; Rec."BLRUnearned Revenue Balance")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Current balance of unearned revenue for the charges.';
                }
                field(CalculatedUnearnedRevBalance; Rec."BLRCalculatedUnearnedRevB19C1")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Calculated balance of unearned revenue for the charges.';
                }
                field("Shortfall/Excess"; Rec."BLRShortfall/Excess")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Difference between the calculated unearned revenue balance and the actual balance.';
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