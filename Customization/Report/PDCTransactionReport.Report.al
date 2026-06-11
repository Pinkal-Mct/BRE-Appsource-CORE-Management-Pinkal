namespace BREPropertyManagementMargi.BREPropertyManagementMargi;
report 73209576 "BLRPDC Transaction Report"
{
    ApplicationArea = All;
    Caption = 'PDC Transaction Report';
    UsageCategory = ReportsAndAnalysis;
    ExcelLayout = 'PDC Transaction Report.xlsx';
    DefaultLayout = Excel;
    dataset
    {
        dataitem(PDCTransaction; "BLRPaymentMode2")
        {
            DataItemTableView = where("BLRPayment Mode" = const('Cheque'));
            column(Report_Period; CustomDateRangeText)
            {
            }
            column(payment_Series; "BLRPayment Series")
            {
            }
            column(Contract_ID; "BLRContract ID")
            {
            }
            column(Tenant_Id; "BLRTenant Id")
            {
            }
            column(Tenant_Name; "BLRTenant Name")
            {
            }
            column(Cheque_Number; "BLRCheque Number")
            {
            }
            column(Cheque_Date; "BLRDue Date")
            {
            }
            column(Amount; "BLRAmount")
            {
            }
            column(Old_Cheque_; "BLROld Cheque #")
            {
            }
            column(Cheque_Status; "BLRCheque Status")
            {
            }
            column(Approval_Status; "BLRApproval Status")
            {
            }
            column(Payment_Status; "BLRPayment Status")
            {
            }
            trigger OnAfterGetRecord()
            var
                StartDateIsInRange: Boolean;
                EndDateIsInRange: Boolean;
            begin
                CustomDateRangeText :=
                    Format(gCustomStartDate, 0, '<Day,2>/<Month,2>/<Year4>') + ' - ' +
                    Format(gCustomEndDate, 0, '<Day,2>/<Month,2>/<Year4>');
                StartDateIsInRange := ("BLRDue Date" >= gCustomStartDate) and ("BLRDue Date" <= gCustomEndDate);
                EndDateIsInRange := ("BLRDue Date" >= gCustomStartDate) and ("BLRDue Date" <= gCustomEndDate);
                if not (StartDateIsInRange or EndDateIsInRange) then
                    CurrReport.SKIP();
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(DateFilter)
                {
                    field(CustomStartDate; gCustomStartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Custom Start Date';
                        ToolTip = 'Custom Start Date';
                    }
                    field(CustomEndDate; gCustomEndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Custom End Date';
                        ToolTip = 'Custom End Date';
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        gCustomStartDate: Date;
        gCustomEndDate: Date;
        CustomDateRangeText: Text;
}
