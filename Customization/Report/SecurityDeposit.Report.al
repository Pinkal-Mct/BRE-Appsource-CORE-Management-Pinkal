namespace PropertyManagement.PropertyManagement;
using Microsoft.Sales.History;
report 73209577 "Security Deposit"
{
    ApplicationArea = All;
    Caption = 'Security Deposit';
    UsageCategory = ReportsAndAnalysis;
    ExcelLayout = 'Security Deposit.xlsx';
    DefaultLayout = Excel;
    dataset
    {
        dataitem(TenancyContract; "BLRTenancyContract")
        {
            DataItemTableView = SORTING("BLRCustomer Name", "BLRContract ID");
            column(CustomDateRange; CustomDateRangeText)
            {
            }
            column(Contract_ID; "BLRContract ID")
            {
            }
            column(Customer_Name; "BLRCustomer Name")
            {
            }
            column(Property_Name; "BLRProperty Name")
            {
            }
            column(Unit_Name; "BLRUnit Name")
            {
            }
            column(Contract_Start_Date; "BLRContract Start Date")
            {
            }
            column(Contract_End_Date; "BLRContract End Date")
            {
            }
            column(Opening_Balance; OpeningBalance)
            {
            }
            column(Additions; Additions)
            {
            }
            column(CarriedForwardIn; CarriedForwardInAmount)
            {
            }
            column(CarriedForwardOut; CarriedForwardOutAmount)
            {
            }
            column(Adjustment; AdjustmentAmount)
            {
            }
            column(Refund; RefundAmount)
            {
            }
            column(Closing_Balance; ClosingBalance)
            {
            }
            trigger OnAfterGetRecord()
            var
                SecurityDepositTransfer: Record "BLRSecurityDeposit";
                adjustmentDeposit: Record "BLRAdjustmentDeposits";
                postedSalesInvoice: Record "Sales Invoice Header";
                postedSalesInvoiceLine: Record "Sales Invoice Line";
                tenancyContractSub: Record "BLRTenancyContractSubpage";
                IsContractInRange: Boolean;
                SecurityDepositAmount: Decimal;
            begin

                OpeningBalance := 0;
                Additions := 0;
                CarriedForwardInAmount := 0;
                CarriedForwardOutAmount := 0;
                ClosingBalance := 0;
                AdjustmentAmount := 0;
                RefundAmount := 0;

                CustomDateRangeText :=
                     Format(gCustomStartDate, 0, '<Day,2>/<Month,2>/') + Format(Date2DMY(gCustomStartDate, 3)) + ' - ' +
                     Format(gCustomEndDate, 0, '<Day,2>/<Month,2>/') + Format(Date2DMY(gCustomEndDate, 3));

                IsContractInRange := ("BLRContract Start Date" <= gCustomEndDate) and
                    ("BLRContract End Date" >= gCustomStartDate);

                if not IsContractInRange then
                    CurrReport.SKIP();

                SecurityDepositAmount := "BLRSecurity Deposit Amount";

                if "BLRContract Start Date" <= gCustomStartDate then
                    OpeningBalance := SecurityDepositAmount
                else
                    OpeningBalance := 0;

                if "BLRContract Start Date" > gCustomStartDate then begin
                    tenancyContractSub.SetRange("BLRContractID", TenancyContract."BLRContract ID");
                    tenancyContractSub.SetRange("BLRSecondary Item Type", 'Security Deposit');
                    if tenancyContractSub.FindFirst() then begin
                        postedSalesInvoice.SetRange("BLRContract ID", tenancyContractSub."BLRContractID");
                        if postedSalesInvoice.FindFirst() then begin
                            postedSalesInvoiceLine.SetRange("Document No.", postedSalesInvoice."No.");
                            postedSalesInvoiceLine.SetRange(Description, tenancyContractSub."BLRSecondary Item Type");
                            if not postedSalesInvoiceLine.IsEmpty() then
                                Additions := tenancyContractSub."BLRInvoiced";
                        end;

                    end;

                end
                else
                    Additions := 0;

                "OpeningBalance" := OpeningBalance;
                "Additions" := Additions;
                CarriedForwardInAmount := 0;
                CarriedForwardOutAmount := 0;

                SecurityDepositTransfer.Reset();
                SecurityDepositTransfer.SetRange("BLRContract ID", "BLRContract ID");
                if SecurityDepositTransfer.FindSet() then
                    repeat
                        CarriedForwardOutAmount += SecurityDepositTransfer."BLRCarry Forward Amount";
                    until SecurityDepositTransfer.Next() = 0;

                SecurityDepositTransfer.Reset();
                SecurityDepositTransfer.SetRange("BLRNew_Contract ID", "BLRContract ID");
                if SecurityDepositTransfer.FindSet() then
                    repeat
                        CarriedForwardInAmount += SecurityDepositTransfer."BLRCarry Forward Amount";
                    until SecurityDepositTransfer.Next() = 0;

                adjustmentDeposit.SetRange("BLRContract Id", "BLRContract ID");
                adjustmentDeposit.SetRange("BLRItem Description", adjustmentDeposit."BLRItem Description"::"Security Deposit");
                if adjustmentDeposit.FindSet() then begin
                    AdjustmentAmount := 0;
                    RefundAmount := 0;
                    repeat
                        if adjustmentDeposit."BLRTransaction Type" = adjustmentDeposit."BLRTransaction Type"::Adjustment then
                            AdjustmentAmount += adjustmentDeposit."BLRAmount"
                        else
                            if adjustmentDeposit."BLRTransaction Type" = adjustmentDeposit."BLRTransaction Type"::Refund then
                                RefundAmount += adjustmentDeposit."BLRAmount";
                    until adjustmentDeposit.Next() = 0;
                end else begin
                    AdjustmentAmount := 0;
                    RefundAmount := 0;
                end;

                ClosingBalance := (OpeningBalance + Additions + CarriedForwardInAmount) - (CarriedForwardOutAmount + AdjustmentAmount + RefundAmount);

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
        OpeningBalance: Decimal;
        Additions: Decimal;
        AdjustmentAmount: Decimal;
        ClosingBalance: Decimal;
        RefundAmount: Decimal;
        CarriedForwardOutAmount: Decimal;
        CarriedForwardInAmount: Decimal;
}
