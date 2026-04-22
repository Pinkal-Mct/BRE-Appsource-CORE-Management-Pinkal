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
        dataitem(TenancyContract; "Tenancy Contract")
        {
            DataItemTableView = SORTING("Customer Name", "Contract ID");
            column(CustomDateRange; CustomDateRangeText)
            {
            }
            column(Contract_ID; "Contract ID")
            {
            }
            column(Customer_Name; "Customer Name")
            {
            }
            column(Property_Name; "Property Name")
            {
            }
            column(Unit_Name; "Unit Name")
            {
            }
            column(Contract_Start_Date; "Contract Start Date")
            {
            }
            column(Contract_End_Date; "Contract End Date")
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
                SecurityDepositTransfer: Record "Security Deposit";
                adjustmentDeposit: Record "Adjustment Deposits";
                postedSalesInvoice: Record "Sales Invoice Header";
                postedSalesInvoiceLine: Record "Sales Invoice Line";
                tenancyContractSub: Record "Tenancy Contract Subpage";
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

                IsContractInRange := ("Contract Start Date" <= gCustomEndDate) and
                    ("Contract End Date" >= gCustomStartDate);

                if not IsContractInRange then
                    CurrReport.SKIP();

                SecurityDepositAmount := "Security Deposit Amount";

                if "Contract Start Date" <= gCustomStartDate then
                    OpeningBalance := SecurityDepositAmount
                else
                    OpeningBalance := 0;

                if "Contract Start Date" > gCustomStartDate then begin
                    tenancyContractSub.SetRange(ContractID, TenancyContract."Contract ID");
                    tenancyContractSub.SetRange("Secondary Item Type", 'Security Deposit');
                    if tenancyContractSub.FindFirst() then begin
                        postedSalesInvoice.SetRange("Contract ID", tenancyContractSub.ContractID);
                        if postedSalesInvoice.FindFirst() then begin
                            postedSalesInvoiceLine.SetRange("Document No.", postedSalesInvoice."No.");
                            postedSalesInvoiceLine.SetRange(Description, tenancyContractSub."Secondary Item Type");
                            if not postedSalesInvoiceLine.IsEmpty() then
                                Additions := tenancyContractSub.Invoiced;
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
                SecurityDepositTransfer.SetRange("Contract ID", "Contract ID");
                if SecurityDepositTransfer.FindSet() then
                    repeat
                        CarriedForwardOutAmount += SecurityDepositTransfer."Carry Forward Amount";
                    until SecurityDepositTransfer.Next() = 0;

                SecurityDepositTransfer.Reset();
                SecurityDepositTransfer.SetRange("New_Contract ID", "Contract ID");
                if SecurityDepositTransfer.FindSet() then
                    repeat
                        CarriedForwardInAmount += SecurityDepositTransfer."Carry Forward Amount";
                    until SecurityDepositTransfer.Next() = 0;

                adjustmentDeposit.SetRange("Contract ID", "Contract ID");
                adjustmentDeposit.SetRange("Item Description", adjustmentDeposit."Item Description"::"Security Deposit");
                if adjustmentDeposit.FindSet() then begin
                    AdjustmentAmount := 0;
                    RefundAmount := 0;
                    repeat
                        if adjustmentDeposit."Transaction Type" = adjustmentDeposit."Transaction Type"::Adjustment then
                            AdjustmentAmount += adjustmentDeposit.Amount
                        else
                            if adjustmentDeposit."Transaction Type" = adjustmentDeposit."Transaction Type"::Refund then
                                RefundAmount += adjustmentDeposit.Amount;
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
