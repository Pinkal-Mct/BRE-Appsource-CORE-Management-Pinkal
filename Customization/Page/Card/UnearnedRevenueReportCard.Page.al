page 73209636 "Unearned Revenue Report Card"
{
    PageType = Card;
    SourceTable = "Unearned Revenue Report";
    ApplicationArea = All;
    UsageCategory = None;
    Caption = 'Unearned Revenue Report';

    layout
    {
        area(Content)
        {
            group("Unearned Revenue Report")
            {
                Caption = 'Unearned Revenue Report';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unique identifier for the unearned revenue report.';
                }
                field("Starting Date Year"; Rec."Starting Date Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'The starting date for the report, typically set to the first day of the year.';
                }
                field("Ending Date Year"; Rec."Ending Date Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'The ending date for the report, typically set to the last day of the year.';
                }
            }
            group("Unearned Rent Revenue Report Report Details")
            {
                Caption = 'Unearned Rent Revenue Report Details';
                part("Unearned Rent Revenue Report Details"; "Sub Unearned Revenue Card")
                {
                    SubPageLink = "Header No." = field("No.");
                }
            }

            group("Total For Rent Charges")
            {
                Caption = 'Total For Rent Charges';
                field("Total Contract Value"; Rec."R_Total Contract Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total contract value for the unearned revenue report.';
                    Editable = false;
                }
                field("Total Opening Balance"; Rec."R_Total Opening Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total opening balance for the unearned revenue report.';
                    Editable = false;
                }
                field("Total Invoice Raised During Year"; Rec."R_T_Invoice Raised During Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total invoice raised during the year for the unearned revenue report.';
                    Editable = false;
                }
                field("Total Revenue Allocated During Year"; Rec."R_T_Revenue Allocated During Y")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total revenue allocated during the year for the unearned revenue report.';
                    Editable = false;
                }
                field("Total Unearned Revenue Balance"; Rec."R_T_Unearned Revenue Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total unearned revenue balance for the unearned revenue report.';
                    Editable = false;
                }
                field("Total Calculated Unearned Rev Balance"; Rec."R_T_Cal Unearned RevBalance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total calculated unearned revenue balance for the unearned revenue report.';
                    Editable = false;
                }
                field("Total Shortfall Excess"; Rec."R_Total Shortfall Excess")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total shortfall or excess for the unearned revenue report.';
                    Editable = false;
                }
            }

            group("Other Charges Details")
            {
                Caption = 'Other Charges Details';
                part("Other Charges Unearned Revenue"; "OtherCharges-UnearnedRevenue")
                {
                    SubPageLink = "No." = field("No.");
                }
            }
            group("Unearned Other Charges Revenue Report Report Details")
            {
                Caption = 'Unearned Other Charges Revenue Report Details';
                part("Unearned Other Charges Revenue Report Details"; "Sub Unearned Charges")
                {
                    SubPageLink = "Header No." = field("No.");
                }
            }

            group("Total For Other Charges")
            {
                Caption = 'Total For Other Charges';

                field(TotalOtherCharges; TotalOtherCharges)
                {
                    Caption = 'Total Other Charges';
                    Editable = false;
                    ToolTip = 'Total other charges for the unearned revenue report.';
                    ApplicationArea = All;
                }
                field(TotalOpeningBalance; TotalOpeningBalance)
                {
                    Caption = 'Total Opening Balance';
                    Editable = false;
                    ToolTip = 'Total opening balance for other charges in the unearned revenue report.';
                    ApplicationArea = All;
                }
                field(TotalInvoiceraisedduringtheyear; TotalInvoiceraisedduringtheyear)
                {
                    ApplicationArea = All;
                    Caption = 'Total Invoice Raised During the Year';
                    ToolTip = 'Total invoice raised during the year for other charges in the unearned revenue report.';
                    Editable = false;
                }
                field(Totalrevenueallocatedduringtheyear; Totalrevenueallocatedduringtheyear)
                {
                    ApplicationArea = All;
                    Caption = 'Total Revenue Allocation During the Year';
                    ToolTip = 'Total revenue allocated during the year for other charges in the unearned revenue report.';
                    Editable = false;
                }
                field(Totalunearnedrevenuebalance; Totalunearnedrevenuebalance)
                {
                    Caption = 'Total Unearned Revenue Balance';
                    Editable = false;
                    ToolTip = 'Total unearned revenue balance for other charges in the unearned revenue report.';
                    ApplicationArea = All;
                }
                field(Totalcalculatedunearnedrevenuebalance; Totalcalculatedunearnedrevenuebalance)
                {
                    Caption = 'Total Calculated Unearned Revenue Balance';
                    Editable = false;
                    ToolTip = 'Total calculated unearned revenue balance for other charges in the unearned revenue report.';
                    ApplicationArea = All;
                }
                field(Totalshortfall; Totalshortfall)
                {
                    ApplicationArea = All;
                    Caption = 'Total Shortfall/Excess';
                    ToolTip = 'Total shortfall or excess for other charges in the unearned revenue report.';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Unearned Rent Revenue Report")
            {
                ApplicationArea = All;
                Caption = 'Unearned Rent Revenue Report';
                Image = Revenue;
                ToolTip = 'Fetch unearned rent revenue data for the selected period.';

                trigger OnAction()
                begin
                    UnearnedRevenueRent();
                    CalculateAndUpdateTotals();
                    Message('All data for Unearned Rent Revenue has been fetched.');
                end;
            }

            action("Unearned Other Charges Revenue Report")
            {
                ApplicationArea = All;
                Caption = 'Unearned Other Charges Revenue Report';
                Image = Revenue;
                ToolTip = 'Fetch unearned other charges revenue data for the selected period.';

                trigger OnAction()
                begin
                    UnearnedRevenueOtherCharges();
                    Message('All data for Other Charges Revenue has been fetched.');
                end;
            }
        }

        area(Promoted)
        {
            actionref("UnearnedRentRevenueReport"; "Unearned Rent Revenue Report") { }
            actionref("UnearnedOtherChargesRevenueReport"; "Unearned Other Charges Revenue Report") { }
        }
    }

    procedure CalculateAndUpdateTotals()
    var
        unearnedRevenueBuffer: Record "Sub Unearned Revenue Report";
        TotalContractValue: Decimal;
        lTotalOpeningBalance: Decimal;
        TotalInvoiceRaised: Decimal;
        TotalRevenueAllocated: Decimal;
        TotalUnearnedRevBalance: Decimal;
        TotalCalculatedUnearnedRevBalance: Decimal;
        TotalShortfallExcess: Decimal;
    begin
        // Initialize totals
        TotalContractValue := 0;
        lTotalOpeningBalance := 0;
        TotalInvoiceRaised := 0;
        TotalRevenueAllocated := 0;
        TotalUnearnedRevBalance := 0;
        TotalCalculatedUnearnedRevBalance := 0;
        TotalShortfallExcess := 0;

        // Calculate totals from buffer table
        unearnedRevenueBuffer.Reset();
        unearnedRevenueBuffer.SetRange("Header No.", Rec."No.");

        if unearnedRevenueBuffer.FindSet() then
            repeat
                TotalContractValue += unearnedRevenueBuffer."Contract Value";
                lTotalOpeningBalance += unearnedRevenueBuffer."Opening Balance";
                TotalInvoiceRaised += unearnedRevenueBuffer."Invoice Raised During the Year";
                TotalRevenueAllocated += unearnedRevenueBuffer."RevenueAllocated DuringtheYear";
                TotalUnearnedRevBalance += unearnedRevenueBuffer."Unearned Revenue Balance";
                TotalCalculatedUnearnedRevBalance += unearnedRevenueBuffer.CalculatedUnearnedRevBalance;
                TotalShortfallExcess += unearnedRevenueBuffer."Shortfall/Excess";
            until unearnedRevenueBuffer.Next() = 0;

        // Update header record with totals
        Rec."R_Total Contract Value" := TotalContractValue;
        Rec."R_Total Opening Balance" := lTotalOpeningBalance;
        Rec."R_T_Invoice Raised During Year" := TotalInvoiceRaised;
        Rec."R_T_Revenue Allocated During Y" := TotalRevenueAllocated;
        Rec."R_T_Unearned Revenue Balance" := TotalUnearnedRevBalance;
        Rec."R_T_Cal Unearned RevBalance" := TotalCalculatedUnearnedRevBalance;
        Rec."R_Total Shortfall Excess" := TotalShortfallExcess;

        Rec.Modify();
        CurrPage.Update();
    end;

    procedure UnearnedRevenueRent()
    var
        tenancyContract: Record "Tenancy Contract";
        unearnedRevenueBuffer: Record "Sub Unearned Revenue Report"; // your buffer table
        SuspendedReasonRec: Record SuspendReasonTable; // Replace with actual table name
        FinalCalculationRec: Record "Final Calculation"; // Replace with actual table name
        paymentSchedule: Record "Payment Schedule2";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesCreditMemoLines: Record "Sales Cr.Memo Line";
        PostedSalesInvoiceHeader: Record "Sales Invoice Header";
        NewLineNo: Integer;
        StartDate, EndDate : Date;
        SuspendedDate: Date;
        TerminationDate: Date;
        TotalInvoiceRentAmount: Decimal;
        TotalInvoicedAmount: Decimal;
        TotalNoofDays: Integer;
        UnearnedNoofday: Integer;
        PerDayrent: Decimal;
        TotalMonthlyRevenue: Decimal;
        RevenueAllocatedDuringYear: Decimal;
        TotalEarnedAmount: Decimal;
        TotalCreditNote: Decimal;
        TotalCreditAmountIssued: Decimal;
        TerminatedDuringYear: Boolean;
        PeriodDuringYear: Boolean;
    begin
        ClearSubgridData(); // Always clear before inserting

        StartDate := Rec."Starting Date Year";
        EndDate := Rec."Ending Date Year";

        tenancyContract.Reset();
        tenancyContract.SetFilter("Tenant Contract Status", '%1|%2|%3|%4',
            tenancyContract."Tenant Contract Status"::Active,
            tenancyContract."Tenant Contract Status"::Terminated,
            tenancyContract."Tenant Contract Status"::Suspended,
            tenancyContract."Tenant Contract Status"::"Active-Contract Renewed",
            tenancyContract."Tenant Contract Status"::"Contract Renewed");

        // ✅ Filter contracts that fall within OR span the date range
        // tenancyContract.SetFilter("Contract Start Date", '..%1', EndDate); // starts on or before end date
        // tenancyContract.SetFilter("Contract End Date", '%1..', StartDate); // ends on or after start date
        tenancyContract.SetFilter("Contract Start Date", '<=%1', EndDate); // starts on or before end date

        if tenancyContract.FindSet() then
            repeat
                Clear(unearnedRevenueBuffer);
                Clear(SuspendedReasonRec);
                Clear(FinalCalculationRec);
                TotalInvoiceRentAmount := 0;
                TotalInvoicedAmount := 0;
                TotalMonthlyRevenue := 0;
                RevenueAllocatedDuringYear := 0;
                TotalEarnedAmount := 0;
                TotalCreditNote := 0;
                TotalCreditAmountIssued := 0;
                TotalNoofDays := 0;
                PerDayrent := 0;
                UnearnedNoofday := 0;
                PeriodDuringYear := false;
                //////////////////////////////// Totatl Invoiced Amount //////////////////////////////
                if (tenancyContract."Contract Start Date" >= StartDate) and (tenancyContract."Contract Start Date" <= EndDate) then
                    PeriodDuringYear := true
                else begin

                    //////////////////////////////// Totatl Invoiced Amount //////////////////////////////
                    PostedSalesInvoiceHeader.Reset();
                    PostedSalesInvoiceHeader.SetRange("Contract ID", tenancyContract."Contract ID");
                    PostedSalesInvoiceHeader.SetFilter("Posting Date", '<=%1', StartDate);
                    if PostedSalesInvoiceHeader.FindSet() then
                        repeat
                            paymentSchedule.Reset();
                            paymentSchedule.SetRange("Invoice ID", PostedSalesInvoiceHeader."No.");
                            paymentSchedule.SetRange("Contract ID", PostedSalesInvoiceHeader."Contract ID");
                            paymentSchedule.SetRange("Secondary Item Type", 'Rent');
                            paymentSchedule.SetRange(Invoiced, true);
                            paymentSchedule.SetLoadFields("Invoice ID", "Contract ID", "Secondary Item Type", Amount);
                            if paymentSchedule.FindSet() then
                                repeat
                                    TotalInvoiceRentAmount += paymentSchedule.Amount;
                                until paymentSchedule.Next() = 0;

                        until PostedSalesInvoiceHeader.Next() = 0;
                    //////////////////////////////// END Total Invoiced Amount ///////////////////////////////////

                    ///////////////////////////  TOTAL CREDITNOTE AMOUNT /////////////////////////
                    SalesCrMemoHeader.Reset();
                    SalesCrMemoHeader.SetRange("Contract ID", tenancyContract."Contract ID");
                    SalesCrMemoHeader.SetFilter("Posting Date", '<=%1', StartDate);
                    if SalesCrMemoHeader.FindSet() then
                        repeat
                            SalesCreditMemoLines.Reset();
                            SalesCreditMemoLines.SetRange("Document No.", SalesCrMemoHeader."No.");
                            SalesCreditMemoLines.SetRange(Description, 'Rent');
                            SalesCreditMemoLines.SetLoadFields("Document No.", Description, "Unit Price");
                            if SalesCreditMemoLines.FindSet() then
                                repeat
                                    TotalCreditNote += SalesCreditMemoLines."Unit Price";
                                until SalesCreditMemoLines.Next() = 0;
                        // TotalCreditAmountIssued += SalesCrMemoHeader.Amount;
                        until SalesCrMemoHeader.Next() = 0;
                end;

                /////////////////////////// END  TOTAL CREDITNOTE AMOUNT /////////////////////////

                ///////////////////////////  TOTAL INVOICED AMOUNT /////////////////////////


                PostedSalesInvoiceHeader.Reset();
                PostedSalesInvoiceHeader.SetRange("Contract ID", tenancyContract."Contract ID");
                PostedSalesInvoiceHeader.SetRange("Posting Date", StartDate, EndDate);
                if PostedSalesInvoiceHeader.FindSet() then
                    repeat
                        paymentSchedule.Reset();
                        paymentSchedule.SetRange("Invoice ID", PostedSalesInvoiceHeader."No.");
                        paymentSchedule.SetRange("Contract ID", PostedSalesInvoiceHeader."Contract ID");
                        paymentSchedule.SetRange("Secondary Item Type", 'Rent');
                        paymentSchedule.SetRange(Invoiced, true);
                        paymentSchedule.SetLoadFields("Invoice ID", "Contract ID", "Secondary Item Type", Amount);
                        if paymentSchedule.FindSet() then
                            repeat
                                TotalInvoicedAmount += paymentSchedule.Amount;
                            until paymentSchedule.Next() = 0;

                    until PostedSalesInvoiceHeader.Next() = 0;

                /////////////////////////// END TOTAL INVOICED AMOUNT /////////////////////////


                ///////////////////////////  TOTAL Credit AMOUNT issued /////////////////////////
                SalesCrMemoHeader.Reset();
                SalesCrMemoHeader.SetRange("Contract ID", tenancyContract."Contract ID");
                SalesCrMemoHeader.SetRange("Posting Date", StartDate, EndDate);
                if SalesCrMemoHeader.FindSet() then
                    repeat
                        SalesCreditMemoLines.Reset();
                        SalesCreditMemoLines.SetRange("Document No.", SalesCrMemoHeader."No.");
                        SalesCreditMemoLines.SetRange(Description, 'Rent');
                        SalesCreditMemoLines.SetLoadFields("Document No.", Description, "Unit Price");
                        if SalesCreditMemoLines.FindSet() then
                            repeat
                                TotalCreditAmountIssued += SalesCreditMemoLines."Unit Price";
                            until SalesCreditMemoLines.Next() = 0;
                    // TotalCreditAmountIssued += SalesCrMemoHeader.Amount;
                    until SalesCrMemoHeader.Next() = 0;



                NewLineNo := GetNextLineNo();

                SuspendedDate := 0D;
                if tenancyContract."Tenant Contract Status" = tenancyContract."Tenant Contract Status"::Suspended then begin
                    SuspendedReasonRec.Reset();
                    SuspendedReasonRec.SetRange("Contract ID", tenancyContract."Contract ID");
                    if SuspendedReasonRec.FindLast() then
                        SuspendedDate := SuspendedReasonRec.DateEffective;
                end;

                TerminationDate := 0D;
                TerminatedDuringYear := false;
                if tenancyContract."Tenant Contract Status" = tenancyContract."Tenant Contract Status"::Terminated then begin
                    FinalCalculationRec.Reset();
                    FinalCalculationRec.SetRange("Contract ID", tenancyContract."Contract ID"); // Assuming this link exists
                    if FinalCalculationRec.FindLast() then begin // Get latest calculation
                        TerminationDate := FinalCalculationRec."Termination Date";
                        If (TerminationDate >= StartDate) and (TerminationDate <= EndDate) then
                            TerminatedDuringYear := true;
                    end;
                end;
                unearnedRevenueBuffer.Init();
                unearnedRevenueBuffer."Header No." := Rec."No.";
                unearnedRevenueBuffer."Line No." := NewLineNo;
                unearnedRevenueBuffer."Contract ID" := tenancyContract."Contract ID";
                unearnedRevenueBuffer."Start Date" := tenancyContract."Contract Start Date";
                unearnedRevenueBuffer."End Date" := tenancyContract."Contract End Date";
                unearnedRevenueBuffer."Customer Name" := tenancyContract."Customer Name";
                unearnedRevenueBuffer.Property := tenancyContract."Property Name";
                unearnedRevenueBuffer."Owner Name" := tenancyContract."Owner's Name";
                unearnedRevenueBuffer."Contract Value" := tenancyContract."Annual Rent Amount";
                unearnedRevenueBuffer."Contract Status" := Format(tenancyContract."Tenant Contract Status");
                if PeriodDuringYear then
                    unearnedRevenueBuffer."Opening Balance" := 0
                else
                    if TerminatedDuringYear then
                        unearnedRevenueBuffer."Opening Balance" := 0
                    else begin

                        TotalEarnedAmount := CalculateRevenueAllocation(tenancyContract, Rec."Starting Date Year", Rec."Ending Date Year");
                        unearnedRevenueBuffer."Opening Balance" := (TotalInvoiceRentAmount + TotalCreditNote) - TotalEarnedAmount;
                    end;

                unearnedRevenueBuffer."Invoice Raised During the Year" := TotalInvoicedAmount + TotalCreditAmountIssued;
                unearnedRevenueBuffer."Suspension Date" := SuspendedDate;
                unearnedRevenueBuffer."Termination Date" := TerminationDate;


                TotalNoofDays := unearnedRevenueBuffer."End Date" - unearnedRevenueBuffer."Start Date" + 1;
                PerDayrent := unearnedRevenueBuffer."Contract Value" / TotalNoofDays;
                UnearnedNoofday := unearnedRevenueBuffer."End Date" - EndDate;
                unearnedRevenueBuffer.CalculatedUnearnedRevBalance := PerDayrent * UnearnedNoofday;


                case tenancyContract."Praposal Type Selected" of
                    tenancyContract."Praposal Type Selected"::"Single Unit":
                        unearnedRevenueBuffer."Unit Name" := COPYSTR(tenancyContract."Unit Name", 1, MAXSTRLEN(unearnedRevenueBuffer."Unit Name"));
                    tenancyContract."Praposal Type Selected"::"Merge Unit":
                        unearnedRevenueBuffer."Unit Name" := COPYSTR(tenancyContract."Single Unit Name", 1, MAXSTRLEN(unearnedRevenueBuffer."Unit Name"));
                    else
                        unearnedRevenueBuffer."Unit Name" := '';
                end;

                unearnedRevenueBuffer."RevenueAllocated DuringtheYear" := CalculateRevenueAllocationdurngyear(tenancyContract."Contract ID", Rec."Starting Date Year", Rec."Ending Date Year");

                unearnedRevenueBuffer."Unearned Revenue Balance" := unearnedRevenueBuffer."Opening Balance" + unearnedRevenueBuffer."Invoice Raised During the Year" - unearnedRevenueBuffer."RevenueAllocated DuringtheYear";

                unearnedRevenueBuffer."Shortfall/Excess" := unearnedRevenueBuffer."Unearned Revenue Balance" - unearnedRevenueBuffer.CalculatedUnearnedRevBalance;
                unearnedRevenueBuffer."Report Period" := Format(Rec."Starting Date Year") + ' - ' + Format(Rec."Ending Date Year");

                unearnedRevenueBuffer.Insert();
            until tenancyContract.Next() = 0;
    end;

    local procedure CalculateRevenueAllocation(tenancyContract: Record "Tenancy Contract"; StartDate: Date; EndDate: Date): Decimal
    var
        RevenueAllocationRec: Record "Revenue Allocation SubGrid";
        RevenueallocationHeader: Record "Revenue Allocation Details"; // Replace with your actual table name
        TotalRevenueAllocated: Decimal;
    begin
        if (tenancyContract."Contract Start Date" >= StartDate) and (tenancyContract."Contract Start Date" <= EndDate) then begin
            TotalRevenueAllocated := 0;
            RevenueallocationHeader.Reset();
            RevenueallocationHeader.SetRange(Status, RevenueallocationHeader.Status::Approve);
            if RevenueallocationHeader.FindSet() then
                repeat
                    RevenueAllocationRec.Reset();
                    RevenueAllocationRec.SetRange("Header No.", RevenueallocationHeader."No.");
                    RevenueAllocationRec.SetRange("Contract ID", tenancyContract."Contract ID"); // Assuming this field exists
                    RevenueAllocationRec.SetRange("Revenue Start Date", StartDate, EndDate);
                    RevenueAllocationRec.SetFilter(Description, '<>%1', 'Credit Note');
                    RevenueAllocationRec.SetLoadFields("Header No.", "Contract Id", "Revenue Start Date", "Total Value");
                    RevenueAllocationRec.CalcSums("Total Value");
                    TotalRevenueAllocated += RevenueAllocationRec."Total Value";
                until RevenueallocationHeader.Next() = 0;
            // Method 1: If Revenue Allocation table has Contract ID field
            exit(TotalRevenueAllocated);
        end else begin

            TotalRevenueAllocated := 0;
            RevenueallocationHeader.Reset();
            RevenueallocationHeader.SetRange(Status, RevenueallocationHeader.Status::Approve);
            if RevenueallocationHeader.FindSet() then
                repeat
                    RevenueAllocationRec.Reset();
                    RevenueAllocationRec.SetRange("Header No.", RevenueallocationHeader."No.");
                    RevenueAllocationRec.SetRange("Contract ID", tenancyContract."Contract ID"); // Assuming this field exists
                    RevenueAllocationRec.SetFilter("Revenue Start Date", '<=%1', StartDate);
                    RevenueAllocationRec.SetFilter(Description, '<>%1', 'Credit Note');
                    RevenueAllocationRec.SetLoadFields("Header No.", "Contract Id", "Revenue Start Date", "Total Value");
                    RevenueAllocationRec.CalcSums("Total Value");
                    TotalRevenueAllocated += RevenueAllocationRec."Total Value";
                until RevenueallocationHeader.Next() = 0;
            // Method 1: If Revenue Allocation table has Contract ID field
            exit(TotalRevenueAllocated);
        end;
    end;

    local procedure CalculateRevenueAllocationdurngyear(ContractID: Integer; StartDate: Date; EndDate: Date): Decimal
    var
        RevenueAllocationRec: Record "Revenue Allocation SubGrid";
        RevenueallocationHeader: Record "Revenue Allocation Details"; // Replace with your actual table name
        TotalRevenueAllocatedDuringYear: Decimal;

    begin
        TotalRevenueAllocatedDuringYear := 0;
        RevenueallocationHeader.Reset();
        RevenueallocationHeader.SetRange(Status, RevenueallocationHeader.Status::Approve);
        if RevenueallocationHeader.FindSet() then
            repeat
                RevenueAllocationRec.Reset();
                RevenueAllocationRec.SetRange("Header No.", RevenueallocationHeader."No.");
                RevenueAllocationRec.SetRange("Contract ID", ContractID);
                RevenueAllocationRec.SetFilter(Description, '<>%1', 'Credit Note');
                RevenueAllocationRec.SetFilter("Revenue Start Date", '%1..%2', StartDate, EndDate);
                RevenueAllocationRec.SetLoadFields("Header No.", "Contract Id", "Revenue Start Date", "Total Value");
                RevenueAllocationRec.CalcSums("Total Value");
                TotalRevenueAllocatedDuringYear += RevenueAllocationRec."Total Value";
            until RevenueallocationHeader.Next() = 0;
        // Method 1: If Revenue Allocation table has Contract ID field
        exit(TotalRevenueAllocatedDuringYear);
    end;

    procedure GetNextLineNo(): Integer
    var
        unearnedRevenueBuffer: Record "Sub Unearned Revenue Report";
        LastLineNo: Integer;
    begin
        unearnedRevenueBuffer.Reset();
        unearnedRevenueBuffer.SetRange("Header No.", Rec."No."); // ✅ filter by Header No.
        if unearnedRevenueBuffer.FindLast() then
            LastLineNo := unearnedRevenueBuffer."Line No."
        else
            LastLineNo := 0;

        exit(LastLineNo + 1);
    end;

    procedure ClearSubgridData()
    var
        RevenueItemDetail: Record "Sub Unearned Revenue Report";
    begin
        RevenueItemDetail.SetRange("Header No.", Rec."No."); // ✅ Clear only for this header
        RevenueItemDetail.DeleteAll(true);
    end;


    procedure UnearnedRevenueOtherCharges()
    var
        tenancyContract: Record "Tenancy Contract";
        unearnedRevenueBuffer: Record "Sub Unearned Charges";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesCreditMemoLines: Record "Sales Cr.Memo Line";// your buffer table
        PostedSalesInvoiceHeader: Record "Sales Invoice Header";
        SuspendedReasonRec: Record SuspendReasonTable;
        FinalCalculationRec: Record "Final Calculation";
        paymentSchedule: Record "Payment Schedule2";
        revenueStructure: Record "Revenue Structure";
        NewLineNo: Integer;
        StartDate, EndDate : Date;
        SuspendedDate, TerminationDate : Date;
        TotalPaidAmount, TotalInvoicedAmount, otherchargesvalue : Decimal;
        ItemTypes: List of [Text];
        ItemTypeFilter: Text;
        HasMatchingData: Boolean;
        TotalNoofDays: Integer;
        UnearnedNoofday: Integer;
        PerDayrent: Decimal;
        TotalMonthlyRevenue: Decimal;
        RevenueAllocatedDuringYear: Decimal;
        TotalEarnedAmount: Decimal;
        TotalCreditNote: Decimal;
        TotalCreditAmountIssued: Decimal;
        TotalInvoicedAmountCharges: Decimal;
        TerminatedDuringYear: Boolean;
        ChargesDuringTheYear: Boolean;
    begin
        ClearSubgridDataParking();

        StartDate := Rec."Starting Date Year";
        EndDate := Rec."Ending Date Year";

        GetSelectedItemTypes(ItemTypes);

        if ItemTypes.Count() = 0 then
            Error('Please select at least one Item Type before running the report.');

        ItemTypeFilter := GetItemTypeFilter(ItemTypes);

        tenancyContract.Reset();
        tenancyContract.SetFilter("Tenant Contract Status", '%1|%2|%3|%4|%5',
            tenancyContract."Tenant Contract Status"::Active,
            tenancyContract."Tenant Contract Status"::Terminated,
            tenancyContract."Tenant Contract Status"::Suspended,
            tenancyContract."Tenant Contract Status"::"Active-Contract Renewed",
            tenancyContract."Tenant Contract Status"::"Contract Renewed");

        // tenancyContract.SetFilter("Contract Start Date", '..%1', EndDate);
        // tenancyContract.SetFilter("Contract End Date", '%1..', StartDate);
        tenancyContract.SetFilter("Contract Start Date", '<=%1', EndDate);

        if tenancyContract.FindSet() then
            repeat
                Clear(unearnedRevenueBuffer);
                Clear(SuspendedReasonRec);
                Clear(FinalCalculationRec);
                TotalPaidAmount := 0;
                TotalInvoicedAmount := 0;
                TotalMonthlyRevenue := 0;
                RevenueAllocatedDuringYear := 0;
                otherchargesvalue := 0;
                HasMatchingData := false;
                UnearnedNoofday := 0;
                TotalInvoicedAmountCharges := 0;
                TotalCreditAmountIssued := 0;
                TotalCreditNote := 0;
                TotalNoofDays := 0;
                PerDayrent := 0;
                ChargesDuringTheYear := false;

                // 🔹 If not found in payment schedule, check Revenue Structure
                if not HasMatchingData then begin
                    revenueStructure.Reset();
                    revenueStructure.SetRange("Contract ID", tenancyContract."Contract ID");
                    revenueStructure.SetFilter("Secondary Item Type", ItemTypeFilter);
                    if revenueStructure.FindFirst() then
                        HasMatchingData := true;
                end;

                // 🔹 Skip contract if no match found
                if not HasMatchingData then
                    continue;

                // 🔹 Sum Revenue Structure
                if (tenancyContract."Contract Start Date" >= StartDate) and (tenancyContract."Contract Start Date" <= EndDate) then
                    ChargesDuringTheYear := true
                else begin

                    //////////////////////////////// Totatl Invoiced Amount //////////////////////////////
                    PostedSalesInvoiceHeader.Reset();
                    PostedSalesInvoiceHeader.SetRange("Contract ID", tenancyContract."Contract ID");
                    PostedSalesInvoiceHeader.SetFilter("Posting Date", '<=%1', StartDate);
                    if PostedSalesInvoiceHeader.FindSet() then
                        repeat
                            paymentSchedule.Reset();
                            paymentSchedule.SetRange("Invoice ID", PostedSalesInvoiceHeader."No.");
                            paymentSchedule.SetRange("Contract ID", PostedSalesInvoiceHeader."Contract ID");
                            paymentSchedule.SetRange("Secondary Item Type", ItemTypeFilter);
                            paymentSchedule.SetRange(Invoiced, true);
                            paymentSchedule.SetLoadFields("Invoice ID", "Contract ID", "Secondary Item Type", Amount);
                            if paymentSchedule.FindSet() then
                                repeat
                                    TotalInvoicedAmountCharges += paymentSchedule.Amount;
                                until paymentSchedule.Next() = 0;

                        until PostedSalesInvoiceHeader.Next() = 0;
                    //////////////////////////////// END Total Invoiced Amount ///////////////////////////////////



                    ///////////////////////////  TOTAL CREDITNOTE AMOUNT /////////////////////////
                    SalesCrMemoHeader.Reset();
                    SalesCrMemoHeader.SetRange("Contract ID", tenancyContract."Contract ID");
                    SalesCrMemoHeader.SetFilter("Posting Date", '<=%1', StartDate);
                    if SalesCrMemoHeader.FindSet() then
                        repeat
                            SalesCreditMemoLines.Reset();
                            SalesCreditMemoLines.SetRange("Document No.", SalesCrMemoHeader."No.");
                            SalesCreditMemoLines.SetRange(Description, ItemTypeFilter);
                            SalesCreditMemoLines.SetLoadFields("Document No.", Description, "Unit Price");
                            if SalesCreditMemoLines.FindSet() then
                                repeat
                                    TotalCreditNote += SalesCreditMemoLines."Unit Price";
                                until SalesCreditMemoLines.Next() = 0;
                        // TotalCreditAmountIssued += SalesCrMemoHeader.Amount;
                        until SalesCrMemoHeader.Next() = 0;

                    /////////////////////////// END  TOTAL CREDITNOTE AMOUNT /////////////////////////
                end;

                /////////////////////////// END  TOTAL CREDITNOTE AMOUNT /////////////////////////

                ///////////////////////////  TOTAL INVOICED AMOUNT /////////////////////////


                PostedSalesInvoiceHeader.Reset();
                PostedSalesInvoiceHeader.SetRange("Contract ID", tenancyContract."Contract ID");
                PostedSalesInvoiceHeader.SetRange("Posting Date", StartDate, EndDate);
                if PostedSalesInvoiceHeader.FindSet() then
                    repeat
                        paymentSchedule.Reset();
                        paymentSchedule.SetRange("Invoice ID", PostedSalesInvoiceHeader."No.");
                        paymentSchedule.SetRange("Contract ID", PostedSalesInvoiceHeader."Contract ID");
                        paymentSchedule.SetRange("Secondary Item Type", ItemTypeFilter);
                        paymentSchedule.SetRange(Invoiced, true);
                        paymentSchedule.SetLoadFields("Invoice ID", "Contract ID", "Secondary Item Type", Amount);
                        if paymentSchedule.FindSet() then
                            repeat
                                TotalInvoicedAmount += paymentSchedule.Amount;
                            until paymentSchedule.Next() = 0;

                    until PostedSalesInvoiceHeader.Next() = 0;

                /////////////////////////// END TOTAL INVOICED AMOUNT /////////////////////////


                ///////////////////////////  TOTAL Credit AMOUNT issued /////////////////////////
                SalesCrMemoHeader.Reset();
                SalesCrMemoHeader.SetRange("Contract ID", tenancyContract."Contract ID");
                SalesCrMemoHeader.SetRange("Posting Date", StartDate, EndDate);
                if SalesCrMemoHeader.FindSet() then
                    repeat
                        SalesCreditMemoLines.Reset();
                        SalesCreditMemoLines.SetRange("Document No.", SalesCrMemoHeader."No.");
                        SalesCreditMemoLines.SetRange(Description, ItemTypeFilter);
                        SalesCreditMemoLines.SetLoadFields("Document No.", Description, "Unit Price");
                        if SalesCreditMemoLines.FindSet() then
                            repeat
                                TotalCreditAmountIssued += SalesCreditMemoLines."Unit Price";
                            until SalesCreditMemoLines.Next() = 0;
                    // TotalCreditAmountIssued += SalesCrMemoHeader.Amount;
                    until SalesCrMemoHeader.Next() = 0;


                // 🔹 Suspension and Termination Logic
                SuspendedDate := 0D;
                TerminationDate := 0D;
                if tenancyContract."Tenant Contract Status" = tenancyContract."Tenant Contract Status"::Suspended then begin
                    SuspendedReasonRec.Reset();
                    SuspendedReasonRec.SetRange("Contract ID", tenancyContract."Contract ID");
                    if SuspendedReasonRec.FindLast() then
                        SuspendedDate := SuspendedReasonRec.DateEffective;
                end;

                TerminatedDuringYear := false;
                if tenancyContract."Tenant Contract Status" = tenancyContract."Tenant Contract Status"::Terminated then begin
                    FinalCalculationRec.Reset();
                    FinalCalculationRec.SetRange("Contract ID", tenancyContract."Contract ID");
                    if FinalCalculationRec.FindLast() then begin

                        TerminationDate := FinalCalculationRec."Termination Date";
                        if (TerminationDate >= StartDate) and (TerminationDate <= EndDate) then
                            TerminatedDuringYear := true;
                    end;

                end;

                // 🔹 Insert into Buffer
                NewLineNo := GetNextLineNum();
                unearnedRevenueBuffer.Init();
                unearnedRevenueBuffer."Header No." := Rec."No.";
                unearnedRevenueBuffer."Line No." := NewLineNo;
                unearnedRevenueBuffer."Contract ID" := tenancyContract."Contract ID";
                unearnedRevenueBuffer."Start Date" := tenancyContract."Contract Start Date";
                unearnedRevenueBuffer."End Date" := tenancyContract."Contract End Date";
                unearnedRevenueBuffer."Customer Name" := tenancyContract."Customer Name";
                unearnedRevenueBuffer.Property := tenancyContract."Property Name";
                unearnedRevenueBuffer."Owner Name" := tenancyContract."Owner's Name";
                unearnedRevenueBuffer."Other Charges Value" := otherchargesvalue;
                unearnedRevenueBuffer."Contract Status" := Format(tenancyContract."Tenant Contract Status");

                if ChargesDuringTheYear then
                    unearnedRevenueBuffer."Opening Balance" := 0
                else
                    if TerminatedDuringYear then
                        unearnedRevenueBuffer."Opening Balance" := 0
                    else begin
                        TotalEarnedAmount := CalculateRevenueAllocationothercharges(tenancyContract, Rec."Starting Date Year", Rec."Ending Date Year");
                        unearnedRevenueBuffer."Opening Balance" := (TotalInvoicedAmountCharges + TotalCreditNote) - TotalEarnedAmount;
                    end;

                unearnedRevenueBuffer."Invoice Raised During the Year" := TotalInvoicedAmount + TotalCreditAmountIssued;
                unearnedRevenueBuffer."Suspension Date" := SuspendedDate;
                unearnedRevenueBuffer."Termination Date" := TerminationDate;

                case tenancyContract."Praposal Type Selected" of
                    tenancyContract."Praposal Type Selected"::"Single Unit":
                        unearnedRevenueBuffer."Unit Name" := COPYSTR(tenancyContract."Unit Name", 1, MAXSTRLEN(unearnedRevenueBuffer."Unit Name"));
                    tenancyContract."Praposal Type Selected"::"Merge Unit":
                        unearnedRevenueBuffer."Unit Name" := COPYSTR(tenancyContract."Single Unit Name", 1, MAXSTRLEN(unearnedRevenueBuffer."Unit Name"));
                    else
                        unearnedRevenueBuffer."Unit Name" := '';
                end;

                unearnedRevenueBuffer."RevenueAllocated DuringtheYear" := CalculateRevenueAllocationdurngyearothercharges(tenancyContract."Contract ID", Rec."Starting Date Year", Rec."Ending Date Year");


                unearnedRevenueBuffer."Unearned Revenue Balance" := (unearnedRevenueBuffer."Opening Balance" + unearnedRevenueBuffer."Invoice Raised During the Year") - unearnedRevenueBuffer."RevenueAllocated DuringtheYear";




                TotalNoofDays := unearnedRevenueBuffer."End Date" - unearnedRevenueBuffer."Start Date" + 1;
                PerDayrent := unearnedRevenueBuffer."Other Charges Value" / TotalNoofDays;
                UnearnedNoofday := unearnedRevenueBuffer."End Date" - EndDate;
                unearnedRevenueBuffer.CalculatedUnearnedRevBalance := PerDayrent * UnearnedNoofday;



                unearnedRevenueBuffer."Shortfall/Excess" := unearnedRevenueBuffer."Unearned Revenue Balance" - unearnedRevenueBuffer.CalculatedUnearnedRevBalance;
                unearnedRevenueBuffer."Report Period" := Format(Rec."Starting Date Year") + ' - ' + Format(Rec."Ending Date Year");

                unearnedRevenueBuffer.Insert();
            until tenancyContract.Next() = 0;
    end;

    local procedure CalculateRevenueAllocationothercharges(tenancyContract: Record "Tenancy Contract"; StartDate: Date; EndDate: Date): Decimal
    var
        RevenueAllocationchargesRec: Record "Revenue Recognition Details";
        RevenueallocationHeader: Record "Revenue Allocation Details"; // Replace with your actual table name
        TotalRevenueAllocated: Decimal;
    begin
        if (tenancyContract."Contract Start Date" >= StartDate) and (tenancyContract."Contract Start Date" <= EndDate) then begin
            TotalRevenueAllocated := 0;
            RevenueallocationHeader.Reset();
            RevenueallocationHeader.SetRange(Status, RevenueallocationHeader.Status::Approve);
            if RevenueallocationHeader.FindSet() then
                repeat
                    RevenueAllocationchargesRec.Reset();
                    RevenueAllocationchargesRec.SetRange("RR_No.", RevenueallocationHeader."No.");
                    RevenueAllocationchargesRec.SetRange("Contract ID", tenancyContract."Contract ID"); // Assuming this field exists
                    RevenueAllocationchargesRec.SetRange("Revenue Start Date", StartDate, EndDate);
                    RevenueAllocationchargesRec.SetFilter(Description, '<>%1', 'Credit Note');
                    RevenueAllocationchargesRec.SetLoadFields("RR_No.", "Contract Id", "Revenue Start Date", "Total Value");
                    RevenueAllocationchargesRec.CalcSums("Total Value");
                    TotalRevenueAllocated += RevenueAllocationchargesRec."Total Value";
                until RevenueallocationHeader.Next() = 0;
            // Method 1: If Revenue Allocation table has Contract ID field
            exit(TotalRevenueAllocated);
        end else begin

            TotalRevenueAllocated := 0;
            RevenueallocationHeader.Reset();
            RevenueallocationHeader.SetRange(Status, RevenueallocationHeader.Status::Approve);
            if RevenueallocationHeader.FindSet() then
                repeat
                    RevenueAllocationchargesRec.Reset();
                    RevenueAllocationchargesRec.SetRange("RR_No.", RevenueallocationHeader."No.");
                    RevenueAllocationchargesRec.SetRange("Contract ID", tenancyContract."Contract ID"); // Assuming this field exists
                    RevenueAllocationchargesRec.SetFilter("Revenue Start Date", '<=%1', StartDate);
                    RevenueAllocationchargesRec.SetFilter(Description, '<>%1', 'Credit Note');
                    RevenueAllocationchargesRec.SetLoadFields("RR_No.", "Contract Id", "Revenue Start Date", "Total Value");
                    RevenueAllocationchargesRec.CalcSums("Total Value");
                    TotalRevenueAllocated += RevenueAllocationchargesRec."Total Value";
                until RevenueallocationHeader.Next() = 0;
            // Method 1: If Revenue Allocation table has Contract ID field
            exit(TotalRevenueAllocated);
        end;
    end;



    local procedure CalculateRevenueAllocationdurngyearothercharges(ContractID: Integer; StartDate: Date; EndDate: Date): Decimal
    var
        RevenueAllocationchargesRec: Record "Revenue Recognition Details";
        RevenueallocationHeader: Record "Revenue Allocation Details"; // Replace with your actual table name
        TotalRevenueAllocatedDuringYear: Decimal;
    begin
        TotalRevenueAllocatedDuringYear := 0;
        RevenueallocationHeader.Reset();
        RevenueallocationHeader.SetRange(Status, RevenueallocationHeader.Status::Approve);
        if RevenueallocationHeader.FindSet() then
            repeat
                RevenueAllocationchargesRec.Reset();
                RevenueAllocationchargesRec.SetRange("RR_No.", RevenueallocationHeader."No.");
                RevenueAllocationchargesRec.SetRange("Contract ID", ContractID); // Assuming this field exists
                RevenueAllocationchargesRec.SetFilter(Description, '<>%1', 'Credit Note');
                RevenueAllocationchargesRec.SetFilter("Revenue Start Date", '%1..%2', StartDate, EndDate);
                RevenueAllocationchargesRec.SetLoadFields("RR_No.", "Contract Id", "Revenue Start Date", "Total Value");
                RevenueAllocationchargesRec.CalcSums("Total Value");
                TotalRevenueAllocatedDuringYear += RevenueAllocationchargesRec."Total Value";
            until RevenueallocationHeader.Next() = 0;
        // Method 1: If Revenue Allocation table has Contract ID field
        exit(TotalRevenueAllocatedDuringYear);
    end;

    local procedure GetSelectedItemTypes(var pItemTypes: List of [Text])
    var
        UnearnedRevenueItem: Record "Other Charges UnearnedRevenue";
    begin
        UnearnedRevenueItem.SetRange("No.", Rec."No.");
        if UnearnedRevenueItem.FindSet() then
            repeat
                if UnearnedRevenueItem."Item Type" <> '' then
                    if not pItemTypes.Contains(UnearnedRevenueItem."Item Type") then
                        pItemTypes.Add(UnearnedRevenueItem."Item Type");
            until UnearnedRevenueItem.Next() = 0;
    end;

    local procedure GetItemTypeFilter(pItemTypes: List of [Text]): Text
    var
        FilterText: Text;
        ItemType: Text;
    begin
        foreach ItemType in pItemTypes do
            if FilterText = '' then
                FilterText := ItemType
            else
                FilterText += '|' + ItemType;

        exit(FilterText);
    end;


    procedure GetNextLineNum(): Integer
    var
        unearnedRevenueBuffer: Record "Sub Unearned Charges";
        LastLineNo: Integer;
    begin
        unearnedRevenueBuffer.Reset();
        unearnedRevenueBuffer.SetRange("Header No.", Rec."No.");
        if unearnedRevenueBuffer.FindLast() then
            LastLineNo := unearnedRevenueBuffer."Line No."
        else
            LastLineNo := 0;

        exit(LastLineNo + 1);
    end;

    procedure ClearSubgridDataParking()
    var
        RevenueItemDetail: Record "Sub Unearned Charges";
    begin
        RevenueItemDetail.SetRange("Header No.", Rec."No."); // ✅ Clear only for this header
        RevenueItemDetail.DeleteAll(true);
    end;

    procedure CalculateAndStoreTotalRevenue()
    var
        SubUnearnedParkingReport: Record "Sub Unearned Charges";
    begin
        Clear(TotalOtherCharges);
        Clear(TotalOpeningBalance);
        Clear(TotalInvoiceraisedduringtheyear);
        Clear(Totalrevenueallocatedduringtheyear);
        Clear(Totalunearnedrevenuebalance);
        Clear(Totalcalculatedunearnedrevenuebalance);
        Clear(Totalshortfall);

        SubUnearnedParkingReport.SetRange("Header No.", Rec."No.");
        if SubUnearnedParkingReport.FindSet() then
            repeat
                TotalOtherCharges += SubUnearnedParkingReport."Other Charges Value";
                TotalOpeningBalance += SubUnearnedParkingReport."Opening Balance";
                TotalInvoiceraisedduringtheyear += SubUnearnedParkingReport."Invoice Raised During the Year";
                Totalrevenueallocatedduringtheyear += SubUnearnedParkingReport."RevenueAllocated DuringtheYear";
                Totalunearnedrevenuebalance += SubUnearnedParkingReport."Unearned Revenue Balance";
                Totalcalculatedunearnedrevenuebalance += SubUnearnedParkingReport.CalculatedUnearnedRevBalance;
                Totalshortfall += SubUnearnedParkingReport."Shortfall/Excess";
            until SubUnearnedParkingReport.Next() = 0;
    end;

    var
        TotalOpeningBalance: Decimal;
        TotalOtherCharges: Decimal;
        TotalInvoiceraisedduringtheyear: Decimal;
        Totalrevenueallocatedduringtheyear: Decimal;
        Totalunearnedrevenuebalance: Decimal;
        Totalcalculatedunearnedrevenuebalance: Decimal;
        Totalshortfall: Decimal;


    trigger OnAfterGetRecord()
    begin
        CurrPage."Other Charges Unearned Revenue".Page.SetNo(Rec."No.");
        CalculateAndStoreTotalRevenue();
    end;


    trigger OnModifyRecord(): Boolean
    begin
        CurrPage."Other Charges Unearned Revenue".Page.SetNo(Rec."No.");
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        CurrPage."Other Charges Unearned Revenue".Page.SetNo(Rec."No.");
    end;
}