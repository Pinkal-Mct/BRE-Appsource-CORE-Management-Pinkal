page 73209636 "Unearned Revenue Report Card"
{
    PageType = Card;
    SourceTable = "BLRUnearnedRevenueReport";
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
                field("No."; Rec."BLRNo.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unique identifier for the unearned revenue report.';
                }
                field("Starting Date Year"; Rec."BLRStarting Date Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'The starting date for the report, typically set to the first day of the year.';
                }
                field("Ending Date Year"; Rec."BLREnding Date Year")
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
                    SubPageLink = "BLRHeader No." = field("BLRNo.");
                }
            }

            group("Total For Rent Charges")
            {
                Caption = 'Total For Rent Charges';
                field("Total Contract Value"; Rec."BLRR_Total Contract Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total contract value for the unearned revenue report.';
                    Editable = false;
                }
                field("Total Opening Balance"; Rec."BLRR_Total Opening Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total opening balance for the unearned revenue report.';
                    Editable = false;
                }
                field("Total Invoice Raised During Year"; Rec."BLRRTInvRaisedDurYear")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total invoice raised during the year for the unearned revenue report.';
                    Editable = false;
                }
                field("Total Revenue Allocated During Year"; Rec."BLRRTRevAllocDurY")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total revenue allocated during the year for the unearned revenue report.';
                    Editable = false;
                }
                field("Total Unearned Revenue Balance"; Rec."BLRRTUnearnedRevBalance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total unearned revenue balance for the unearned revenue report.';
                    Editable = false;
                }
                field("Total Calculated Unearned Rev Balance"; Rec."BLRR_T_Cal Unearned RevBalance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total calculated unearned revenue balance for the unearned revenue report.';
                    Editable = false;
                }
                field("Total Shortfall Excess"; Rec."BLRR_Total Shortfall Excess")
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
                    SubPageLink = "BLRNo." = field("BLRNo.");
                }
            }
            group("Unearned Other Charges Revenue Report Report Details")
            {
                Caption = 'Unearned Other Charges Revenue Report Details';
                part("Unearned Other Charges Revenue Report Details"; "Sub Unearned Charges")
                {
                    SubPageLink = "BLRHeader No." = field("BLRNo.");
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
        unearnedRevenueBuffer: Record "BLRSubUnearnedRevenueReport";
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
        unearnedRevenueBuffer.SetRange("BLRHeader No.", Rec."BLRNo.");

        if unearnedRevenueBuffer.FindSet() then
            repeat
                TotalContractValue += unearnedRevenueBuffer."BLRContract Value";
                lTotalOpeningBalance += unearnedRevenueBuffer."BLROpening Balance";
                TotalInvoiceRaised += unearnedRevenueBuffer."BLRInvRaisedDurtheYear";
                TotalRevenueAllocated += unearnedRevenueBuffer."BLRRevAllocDurtheYear";
                TotalUnearnedRevBalance += unearnedRevenueBuffer."BLRUnearned Revenue Balance";
                TotalCalculatedUnearnedRevBalance += unearnedRevenueBuffer."BLRCalculatedUnearnedRevB19C1";
                TotalShortfallExcess += unearnedRevenueBuffer."BLRShortfall/Excess";
            until unearnedRevenueBuffer.Next() = 0;

        // Update header record with totals
        Rec."BLRR_Total Contract Value" := TotalContractValue;
        Rec."BLRR_Total Opening Balance" := lTotalOpeningBalance;
        Rec."BLRRTInvRaisedDurYear" := TotalInvoiceRaised;
        Rec."BLRRTRevAllocDurY" := TotalRevenueAllocated;
        Rec."BLRRTUnearnedRevBalance" := TotalUnearnedRevBalance;
        Rec."BLRR_T_Cal Unearned RevBalance" := TotalCalculatedUnearnedRevBalance;
        Rec."BLRR_Total Shortfall Excess" := TotalShortfallExcess;

        Rec.Modify();
        CurrPage.Update();
    end;

    procedure UnearnedRevenueRent()
    var
        tenancyContract: Record "BLRTenancyContract";
        unearnedRevenueBuffer: Record "BLRSubUnearnedRevenueReport"; // your buffer table
        SuspendedReasonRec: Record "BLRSuspendReasonTable"; // Replace with actual table name
        FinalCalculationRec: Record "BLRFinalCalculation"; // Replace with actual table name
        paymentSchedule: Record "BLRPaymentSchedule2";
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

        StartDate := Rec."BLRStarting Date Year";
        EndDate := Rec."BLREnding Date Year";

        tenancyContract.Reset();
        tenancyContract.SetFilter("BLRTenant Contract Status", '%1|%2|%3|%4',
            tenancyContract."BLRTenant Contract Status"::Active,
            tenancyContract."BLRTenant Contract Status"::Terminated,
            tenancyContract."BLRTenant Contract Status"::Suspended,
            tenancyContract."BLRTenant Contract Status"::"Active-Contract Renewed",
            tenancyContract."BLRTenant Contract Status"::"Contract Renewed");

        // ✅ Filter contracts that fall within OR span the date range
        // tenancyContract.SetFilter("BLRContract Start Date", '..%1', EndDate); // starts on or before end date
        // tenancyContract.SetFilter("BLRContract End Date", '%1..', StartDate); // ends on or after start date
        tenancyContract.SetFilter("BLRContract Start Date", '<=%1', EndDate); // starts on or before end date

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
                if (tenancyContract."BLRContract Start Date" >= StartDate) and (tenancyContract."BLRContract Start Date" <= EndDate) then
                    PeriodDuringYear := true
                else begin

                    //////////////////////////////// Totatl Invoiced Amount //////////////////////////////
                    PostedSalesInvoiceHeader.Reset();
                    PostedSalesInvoiceHeader.SetRange("BLRContract ID", tenancyContract."BLRContract ID");
                    PostedSalesInvoiceHeader.SetFilter("Posting Date", '<=%1', StartDate);
                    if PostedSalesInvoiceHeader.FindSet() then
                        repeat
                            paymentSchedule.Reset();
                            paymentSchedule.SetRange("BLRInvoice ID", PostedSalesInvoiceHeader."No.");
                            paymentSchedule.SetRange("BLRContract ID", PostedSalesInvoiceHeader."BLRContract ID");
                            paymentSchedule.SetRange("BLRSecondary Item Type", 'Rent');
                            paymentSchedule.SetRange("BLRInvoiced", true);
                            paymentSchedule.SetLoadFields("BLRInvoice ID", "BLRContract ID", "BLRSecondary Item Type", "BLRAmount");
                            if paymentSchedule.FindSet() then
                                repeat
                                    TotalInvoiceRentAmount += paymentSchedule."BLRAmount";
                                until paymentSchedule.Next() = 0;

                        until PostedSalesInvoiceHeader.Next() = 0;
                    //////////////////////////////// END Total Invoiced Amount ///////////////////////////////////

                    ///////////////////////////  TOTAL CREDITNOTE AMOUNT /////////////////////////
                    SalesCrMemoHeader.Reset();
                    SalesCrMemoHeader.SetRange("BLRContract ID", tenancyContract."BLRContract ID");
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
                PostedSalesInvoiceHeader.SetRange("BLRContract ID", tenancyContract."BLRContract ID");
                PostedSalesInvoiceHeader.SetRange("Posting Date", StartDate, EndDate);
                if PostedSalesInvoiceHeader.FindSet() then
                    repeat
                        paymentSchedule.Reset();
                        paymentSchedule.SetRange("BLRInvoice ID", PostedSalesInvoiceHeader."No.");
                        paymentSchedule.SetRange("BLRContract ID", PostedSalesInvoiceHeader."BLRContract ID");
                        paymentSchedule.SetRange("BLRSecondary Item Type", 'Rent');
                        paymentSchedule.SetRange("BLRInvoiced", true);
                        paymentSchedule.SetLoadFields("BLRInvoice ID", "BLRContract ID", "BLRSecondary Item Type", "BLRAmount");
                        if paymentSchedule.FindSet() then
                            repeat
                                TotalInvoicedAmount += paymentSchedule."BLRAmount";
                            until paymentSchedule.Next() = 0;

                    until PostedSalesInvoiceHeader.Next() = 0;

                /////////////////////////// END TOTAL INVOICED AMOUNT /////////////////////////


                ///////////////////////////  TOTAL Credit AMOUNT issued /////////////////////////
                SalesCrMemoHeader.Reset();
                SalesCrMemoHeader.SetRange("BLRContract ID", tenancyContract."BLRContract ID");
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
                if tenancyContract."BLRTenant Contract Status" = tenancyContract."BLRTenant Contract Status"::Suspended then begin
                    SuspendedReasonRec.Reset();
                    SuspendedReasonRec.SetRange("BLRContract ID", tenancyContract."BLRContract ID");
                    if SuspendedReasonRec.FindLast() then
                        SuspendedDate := SuspendedReasonRec."BLRDateEffective";
                end;

                TerminationDate := 0D;
                TerminatedDuringYear := false;
                if tenancyContract."BLRTenant Contract Status" = tenancyContract."BLRTenant Contract Status"::Terminated then begin
                    FinalCalculationRec.Reset();
                    FinalCalculationRec.SetRange("BLRContract ID", tenancyContract."BLRContract ID"); // Assuming this link exists
                    if FinalCalculationRec.FindLast() then begin // Get latest calculation
                        TerminationDate := FinalCalculationRec."BLRTermination Date";
                        If (TerminationDate >= StartDate) and (TerminationDate <= EndDate) then
                            TerminatedDuringYear := true;
                    end;
                end;
                unearnedRevenueBuffer.Init();
                unearnedRevenueBuffer."BLRHeader No." := Rec."BLRNo.";
                unearnedRevenueBuffer."BLRLine No." := NewLineNo;
                unearnedRevenueBuffer."BLRContract ID" := tenancyContract."BLRContract ID";
                unearnedRevenueBuffer."BLRStart Date" := tenancyContract."BLRContract Start Date";
                unearnedRevenueBuffer."BLREnd Date" := tenancyContract."BLRContract End Date";
                unearnedRevenueBuffer."BLRCustomer Name" := tenancyContract."BLRCustomer Name";
                unearnedRevenueBuffer."BLRProperty" := tenancyContract."BLRProperty Name";
                unearnedRevenueBuffer."BLROwner Name" := tenancyContract."BLROwner's Name";
                unearnedRevenueBuffer."BLRContract Value" := tenancyContract."BLRAnnual Rent Amount";
                unearnedRevenueBuffer."BLRContract Status" := Format(tenancyContract."BLRTenant Contract Status");
                if PeriodDuringYear then
                    unearnedRevenueBuffer."BLROpening Balance" := 0
                else
                    if TerminatedDuringYear then
                        unearnedRevenueBuffer."BLROpening Balance" := 0
                    else begin

                        TotalEarnedAmount := CalculateRevenueAllocation(tenancyContract, Rec."BLRStarting Date Year", Rec."BLREnding Date Year");
                        unearnedRevenueBuffer."BLROpening Balance" := (TotalInvoiceRentAmount + TotalCreditNote) - TotalEarnedAmount;
                    end;

                unearnedRevenueBuffer."BLRInvRaisedDurtheYear" := TotalInvoicedAmount + TotalCreditAmountIssued;
                unearnedRevenueBuffer."BLRSuspension Date" := SuspendedDate;
                unearnedRevenueBuffer."BLRTermination Date" := TerminationDate;


                TotalNoofDays := unearnedRevenueBuffer."BLREnd Date" - unearnedRevenueBuffer."BLRStart Date" + 1;
                PerDayrent := unearnedRevenueBuffer."BLRContract Value" / TotalNoofDays;
                UnearnedNoofday := unearnedRevenueBuffer."BLREnd Date" - EndDate;
                unearnedRevenueBuffer."BLRCalculatedUnearnedRevB19C1" := PerDayrent * UnearnedNoofday;


                case tenancyContract."BLRPraposal Type Selected" of
                    tenancyContract."BLRPraposal Type Selected"::"Single Unit":
                        unearnedRevenueBuffer."BLRUnit Name" := COPYSTR(tenancyContract."BLRUnit Name", 1, MAXSTRLEN(unearnedRevenueBuffer."BLRUnit Name"));
                    tenancyContract."BLRPraposal Type Selected"::"Merge Unit":
                        unearnedRevenueBuffer."BLRUnit Name" := COPYSTR(tenancyContract."BLRSingle Unit Name", 1, MAXSTRLEN(unearnedRevenueBuffer."BLRUnit Name"));
                    else
                        unearnedRevenueBuffer."BLRUnit Name" := '';
                end;

                unearnedRevenueBuffer."BLRRevAllocDurtheYear" := CalculateRevenueAllocationdurngyear(tenancyContract."BLRContract ID", Rec."BLRStarting Date Year", Rec."BLREnding Date Year");

                unearnedRevenueBuffer."BLRUnearned Revenue Balance" := unearnedRevenueBuffer."BLROpening Balance" + unearnedRevenueBuffer."BLRInvRaisedDurtheYear" - unearnedRevenueBuffer."BLRRevAllocDurtheYear";

                unearnedRevenueBuffer."BLRShortfall/Excess" := unearnedRevenueBuffer."BLRUnearned Revenue Balance" - unearnedRevenueBuffer."BLRCalculatedUnearnedRevB19C1";
                unearnedRevenueBuffer."BLRReport Period" := Format(Rec."BLRStarting Date Year") + ' - ' + Format(Rec."BLREnding Date Year");

                unearnedRevenueBuffer.Insert();
            until tenancyContract.Next() = 0;
    end;

    local procedure CalculateRevenueAllocation(tenancyContract: Record "BLRTenancyContract"; StartDate: Date; EndDate: Date): Decimal
    var
        RevenueAllocationRec: Record "BLRRevenueAllocationSubGrid";
        RevenueallocationHeader: Record "BLRRevenueAllocationDetails"; // Replace with your actual table name
        TotalRevenueAllocated: Decimal;
    begin
        if (tenancyContract."BLRContract Start Date" >= StartDate) and (tenancyContract."BLRContract Start Date" <= EndDate) then begin
            TotalRevenueAllocated := 0;
            RevenueallocationHeader.Reset();
            RevenueallocationHeader.SetRange("BLRStatus", RevenueallocationHeader."BLRStatus"::Approve);
            if RevenueallocationHeader.FindSet() then
                repeat
                    RevenueAllocationRec.Reset();
                    RevenueAllocationRec.SetRange("BLRHeader No.", RevenueallocationHeader."BLRNo.");
                    RevenueAllocationRec.SetRange("BLRContract Id", tenancyContract."BLRContract ID"); // Assuming this field exists
                    RevenueAllocationRec.SetRange("BLRRevenue Start Date", StartDate, EndDate);
                    RevenueAllocationRec.SetFilter("BLRDescription", '<>%1', 'Credit Note');
                    RevenueAllocationRec.SetLoadFields("BLRHeader No.", "BLRContract Id", "BLRRevenue Start Date", "BLRTotal Value");
                    RevenueAllocationRec.CalcSums("BLRTotal Value");
                    TotalRevenueAllocated += RevenueAllocationRec."BLRTotal Value";
                until RevenueallocationHeader.Next() = 0;
            // Method 1: If Revenue Allocation table has Contract ID field
            exit(TotalRevenueAllocated);
        end else begin

            TotalRevenueAllocated := 0;
            RevenueallocationHeader.Reset();
            RevenueallocationHeader.SetRange("BLRStatus", RevenueallocationHeader."BLRStatus"::Approve);
            if RevenueallocationHeader.FindSet() then
                repeat
                    RevenueAllocationRec.Reset();
                    RevenueAllocationRec.SetRange("BLRHeader No.", RevenueallocationHeader."BLRNo.");
                    RevenueAllocationRec.SetRange("BLRContract Id", tenancyContract."BLRContract ID"); // Assuming this field exists
                    RevenueAllocationRec.SetFilter("BLRRevenue Start Date", '<=%1', StartDate);
                    RevenueAllocationRec.SetFilter("BLRDescription", '<>%1', 'Credit Note');
                    RevenueAllocationRec.SetLoadFields("BLRHeader No.", "BLRContract Id", "BLRRevenue Start Date", "BLRTotal Value");
                    RevenueAllocationRec.CalcSums("BLRTotal Value");
                    TotalRevenueAllocated += RevenueAllocationRec."BLRTotal Value";
                until RevenueallocationHeader.Next() = 0;
            // Method 1: If Revenue Allocation table has Contract ID field
            exit(TotalRevenueAllocated);
        end;
    end;

    local procedure CalculateRevenueAllocationdurngyear(ContractID: Integer; StartDate: Date; EndDate: Date): Decimal
    var
        RevenueAllocationRec: Record "BLRRevenueAllocationSubGrid";
        RevenueallocationHeader: Record "BLRRevenueAllocationDetails"; // Replace with your actual table name
        TotalRevenueAllocatedDuringYear: Decimal;

    begin
        TotalRevenueAllocatedDuringYear := 0;
        RevenueallocationHeader.Reset();
        RevenueallocationHeader.SetRange("BLRStatus", RevenueallocationHeader."BLRStatus"::Approve);
        if RevenueallocationHeader.FindSet() then
            repeat
                RevenueAllocationRec.Reset();
                RevenueAllocationRec.SetRange("BLRHeader No.", RevenueallocationHeader."BLRNo.");
                RevenueAllocationRec.SetRange("BLRContract Id", ContractID);
                RevenueAllocationRec.SetFilter("BLRDescription", '<>%1', 'Credit Note');
                RevenueAllocationRec.SetFilter("BLRRevenue Start Date", '%1..%2', StartDate, EndDate);
                RevenueAllocationRec.SetLoadFields("BLRHeader No.", "BLRContract Id", "BLRRevenue Start Date", "BLRTotal Value");
                RevenueAllocationRec.CalcSums("BLRTotal Value");
                TotalRevenueAllocatedDuringYear += RevenueAllocationRec."BLRTotal Value";
            until RevenueallocationHeader.Next() = 0;
        // Method 1: If Revenue Allocation table has Contract ID field
        exit(TotalRevenueAllocatedDuringYear);
    end;

    procedure GetNextLineNo(): Integer
    var
        unearnedRevenueBuffer: Record "BLRSubUnearnedRevenueReport";
        LastLineNo: Integer;
    begin
        unearnedRevenueBuffer.Reset();
        unearnedRevenueBuffer.SetRange("BLRHeader No.", Rec."BLRNo."); // ✅ filter by Header No.
        if unearnedRevenueBuffer.FindLast() then
            LastLineNo := unearnedRevenueBuffer."BLRLine No."
        else
            LastLineNo := 0;

        exit(LastLineNo + 1);
    end;

    procedure ClearSubgridData()
    var
        RevenueItemDetail: Record "BLRSubUnearnedRevenueReport";
    begin
        RevenueItemDetail.SetRange("BLRHeader No.", Rec."BLRNo."); // ✅ Clear only for this header
        RevenueItemDetail.DeleteAll(true);
    end;


    procedure UnearnedRevenueOtherCharges()
    var
        tenancyContract: Record "BLRTenancyContract";
        unearnedRevenueBuffer: Record "BLRSubUnearnedCharges";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesCreditMemoLines: Record "Sales Cr.Memo Line";// your buffer table
        PostedSalesInvoiceHeader: Record "Sales Invoice Header";
        SuspendedReasonRec: Record "BLRSuspendReasonTable";
        FinalCalculationRec: Record "BLRFinalCalculation";
        paymentSchedule: Record "BLRPaymentSchedule2";
        revenueStructure: Record "BLRRevenueStructure";
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

        StartDate := Rec."BLRStarting Date Year";
        EndDate := Rec."BLREnding Date Year";

        GetSelectedItemTypes(ItemTypes);

        if ItemTypes.Count() = 0 then
            Error('Please select at least one Item Type before running the report.');

        ItemTypeFilter := GetItemTypeFilter(ItemTypes);

        tenancyContract.Reset();
        tenancyContract.SetFilter("BLRTenant Contract Status", '%1|%2|%3|%4|%5',
            tenancyContract."BLRTenant Contract Status"::Active,
            tenancyContract."BLRTenant Contract Status"::Terminated,
            tenancyContract."BLRTenant Contract Status"::Suspended,
            tenancyContract."BLRTenant Contract Status"::"Active-Contract Renewed",
            tenancyContract."BLRTenant Contract Status"::"Contract Renewed");

        // tenancyContract.SetFilter("BLRContract Start Date", '..%1', EndDate);
        // tenancyContract.SetFilter("BLRContract End Date", '%1..', StartDate);
        tenancyContract.SetFilter("BLRContract Start Date", '<=%1', EndDate);

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
                    revenueStructure.SetRange("BLRContract ID", tenancyContract."BLRContract ID");
                    revenueStructure.SetFilter("BLRSecondary Item Type", ItemTypeFilter);
                    if revenueStructure.FindFirst() then
                        HasMatchingData := true;
                end;

                // 🔹 Skip contract if no match found
                if not HasMatchingData then
                    continue;

                // 🔹 Sum Revenue Structure
                if (tenancyContract."BLRContract Start Date" >= StartDate) and (tenancyContract."BLRContract Start Date" <= EndDate) then
                    ChargesDuringTheYear := true
                else begin

                    //////////////////////////////// Totatl Invoiced Amount //////////////////////////////
                    PostedSalesInvoiceHeader.Reset();
                    PostedSalesInvoiceHeader.SetRange("BLRContract ID", tenancyContract."BLRContract ID");
                    PostedSalesInvoiceHeader.SetFilter("Posting Date", '<=%1', StartDate);
                    if PostedSalesInvoiceHeader.FindSet() then
                        repeat
                            paymentSchedule.Reset();
                            paymentSchedule.SetRange("BLRInvoice ID", PostedSalesInvoiceHeader."No.");
                            paymentSchedule.SetRange("BLRContract ID", PostedSalesInvoiceHeader."BLRContract ID");
                            paymentSchedule.SetRange("BLRSecondary Item Type", ItemTypeFilter);
                            paymentSchedule.SetRange("BLRInvoiced", true);
                            paymentSchedule.SetLoadFields("BLRInvoice ID", "BLRContract ID", "BLRSecondary Item Type", "BLRAmount");
                            if paymentSchedule.FindSet() then
                                repeat
                                    TotalInvoicedAmountCharges += paymentSchedule."BLRAmount";
                                until paymentSchedule.Next() = 0;

                        until PostedSalesInvoiceHeader.Next() = 0;
                    //////////////////////////////// END Total Invoiced Amount ///////////////////////////////////



                    ///////////////////////////  TOTAL CREDITNOTE AMOUNT /////////////////////////
                    SalesCrMemoHeader.Reset();
                    SalesCrMemoHeader.SetRange("BLRContract ID", tenancyContract."BLRContract ID");
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
                PostedSalesInvoiceHeader.SetRange("BLRContract ID", tenancyContract."BLRContract ID");
                PostedSalesInvoiceHeader.SetRange("Posting Date", StartDate, EndDate);
                if PostedSalesInvoiceHeader.FindSet() then
                    repeat
                        paymentSchedule.Reset();
                        paymentSchedule.SetRange("BLRInvoice ID", PostedSalesInvoiceHeader."No.");
                        paymentSchedule.SetRange("BLRContract ID", PostedSalesInvoiceHeader."BLRContract ID");
                        paymentSchedule.SetRange("BLRSecondary Item Type", ItemTypeFilter);
                        paymentSchedule.SetRange("BLRInvoiced", true);
                        paymentSchedule.SetLoadFields("BLRInvoice ID", "BLRContract ID", "BLRSecondary Item Type", "BLRAmount");
                        if paymentSchedule.FindSet() then
                            repeat
                                TotalInvoicedAmount += paymentSchedule."BLRAmount";
                            until paymentSchedule.Next() = 0;

                    until PostedSalesInvoiceHeader.Next() = 0;

                /////////////////////////// END TOTAL INVOICED AMOUNT /////////////////////////


                ///////////////////////////  TOTAL Credit AMOUNT issued /////////////////////////
                SalesCrMemoHeader.Reset();
                SalesCrMemoHeader.SetRange("BLRContract ID", tenancyContract."BLRContract ID");
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
                if tenancyContract."BLRTenant Contract Status" = tenancyContract."BLRTenant Contract Status"::Suspended then begin
                    SuspendedReasonRec.Reset();
                    SuspendedReasonRec.SetRange("BLRContract ID", tenancyContract."BLRContract ID");
                    if SuspendedReasonRec.FindLast() then
                        SuspendedDate := SuspendedReasonRec."BLRDateEffective";
                end;

                TerminatedDuringYear := false;
                if tenancyContract."BLRTenant Contract Status" = tenancyContract."BLRTenant Contract Status"::Terminated then begin
                    FinalCalculationRec.Reset();
                    FinalCalculationRec.SetRange("BLRContract ID", tenancyContract."BLRContract ID");
                    if FinalCalculationRec.FindLast() then begin

                        TerminationDate := FinalCalculationRec."BLRTermination Date";
                        if (TerminationDate >= StartDate) and (TerminationDate <= EndDate) then
                            TerminatedDuringYear := true;
                    end;

                end;

                // 🔹 Insert into Buffer
                NewLineNo := GetNextLineNum();
                unearnedRevenueBuffer.Init();
                unearnedRevenueBuffer."BLRHeader No." := Rec."BLRNo.";
                unearnedRevenueBuffer."BLRLine No." := NewLineNo;
                unearnedRevenueBuffer."BLRContract ID" := tenancyContract."BLRContract ID";
                unearnedRevenueBuffer."BLRStart Date" := tenancyContract."BLRContract Start Date";
                unearnedRevenueBuffer."BLREnd Date" := tenancyContract."BLRContract End Date";
                unearnedRevenueBuffer."BLRCustomer Name" := tenancyContract."BLRCustomer Name";
                unearnedRevenueBuffer."BLRProperty" := tenancyContract."BLRProperty Name";
                unearnedRevenueBuffer."BLROwner Name" := tenancyContract."BLROwner's Name";
                unearnedRevenueBuffer."BLROther Charges Value" := otherchargesvalue;
                unearnedRevenueBuffer."BLRContract Status" := Format(tenancyContract."BLRTenant Contract Status");

                if ChargesDuringTheYear then
                    unearnedRevenueBuffer."BLROpening Balance" := 0
                else
                    if TerminatedDuringYear then
                        unearnedRevenueBuffer."BLROpening Balance" := 0
                    else begin
                        TotalEarnedAmount := CalculateRevenueAllocationothercharges(tenancyContract, Rec."BLRStarting Date Year", Rec."BLREnding Date Year");
                        unearnedRevenueBuffer."BLROpening Balance" := (TotalInvoicedAmountCharges + TotalCreditNote) - TotalEarnedAmount;
                    end;

                unearnedRevenueBuffer."BLRInvRaisedDurtheYear" := TotalInvoicedAmount + TotalCreditAmountIssued;
                unearnedRevenueBuffer."BLRSuspension Date" := SuspendedDate;
                unearnedRevenueBuffer."BLRTermination Date" := TerminationDate;

                case tenancyContract."BLRPraposal Type Selected" of
                    tenancyContract."BLRPraposal Type Selected"::"Single Unit":
                        unearnedRevenueBuffer."BLRUnit Name" := COPYSTR(tenancyContract."BLRUnit Name", 1, MAXSTRLEN(unearnedRevenueBuffer."BLRUnit Name"));
                    tenancyContract."BLRPraposal Type Selected"::"Merge Unit":
                        unearnedRevenueBuffer."BLRUnit Name" := COPYSTR(tenancyContract."BLRSingle Unit Name", 1, MAXSTRLEN(unearnedRevenueBuffer."BLRUnit Name"));
                    else
                        unearnedRevenueBuffer."BLRUnit Name" := '';
                end;

                unearnedRevenueBuffer."BLRRevAllocDurtheYear" := CalculateRevenueAllocationdurngyearothercharges(tenancyContract."BLRContract ID", Rec."BLRStarting Date Year", Rec."BLREnding Date Year");


                unearnedRevenueBuffer."BLRUnearned Revenue Balance" := (unearnedRevenueBuffer."BLROpening Balance" + unearnedRevenueBuffer."BLRInvRaisedDurtheYear") - unearnedRevenueBuffer."BLRRevAllocDurtheYear";




                TotalNoofDays := unearnedRevenueBuffer."BLREnd Date" - unearnedRevenueBuffer."BLRStart Date" + 1;
                PerDayrent := unearnedRevenueBuffer."BLROther Charges Value" / TotalNoofDays;
                UnearnedNoofday := unearnedRevenueBuffer."BLREnd Date" - EndDate;
                unearnedRevenueBuffer."BLRCalculatedUnearnedRevB19C1" := PerDayrent * UnearnedNoofday;



                unearnedRevenueBuffer."BLRShortfall/Excess" := unearnedRevenueBuffer."BLRUnearned Revenue Balance" - unearnedRevenueBuffer."BLRCalculatedUnearnedRevB19C1";
                unearnedRevenueBuffer."BLRReport Period" := Format(Rec."BLRStarting Date Year") + ' - ' + Format(Rec."BLREnding Date Year");

                unearnedRevenueBuffer.Insert();
            until tenancyContract.Next() = 0;
    end;

    local procedure CalculateRevenueAllocationothercharges(tenancyContract: Record "BLRTenancyContract"; StartDate: Date; EndDate: Date): Decimal
    var
        RevenueAllocationchargesRec: Record "BLRRevenueRecognitionDetails";
        RevenueallocationHeader: Record "BLRRevenueAllocationDetails"; // Replace with your actual table name
        TotalRevenueAllocated: Decimal;
    begin
        if (tenancyContract."BLRContract Start Date" >= StartDate) and (tenancyContract."BLRContract Start Date" <= EndDate) then begin
            TotalRevenueAllocated := 0;
            RevenueallocationHeader.Reset();
            RevenueallocationHeader.SetRange("BLRStatus", RevenueallocationHeader."BLRStatus"::Approve);
            if RevenueallocationHeader.FindSet() then
                repeat
                    RevenueAllocationchargesRec.Reset();
                    RevenueAllocationchargesRec.SetRange("BLRRR_No.", RevenueallocationHeader."BLRNo.");
                    RevenueAllocationchargesRec.SetRange("BLRContract Id", tenancyContract."BLRContract ID"); // Assuming this field exists
                    RevenueAllocationchargesRec.SetRange("BLRRevenue Start Date", StartDate, EndDate);
                    RevenueAllocationchargesRec.SetFilter("BLRDescription", '<>%1', 'Credit Note');
                    RevenueAllocationchargesRec.SetLoadFields("BLRRR_No.", "BLRContract Id", "BLRRevenue Start Date", "BLRTotal Value");
                    RevenueAllocationchargesRec.CalcSums("BLRTotal Value");
                    TotalRevenueAllocated += RevenueAllocationchargesRec."BLRTotal Value";
                until RevenueallocationHeader.Next() = 0;
            // Method 1: If Revenue Allocation table has Contract ID field
            exit(TotalRevenueAllocated);
        end else begin

            TotalRevenueAllocated := 0;
            RevenueallocationHeader.Reset();
            RevenueallocationHeader.SetRange("BLRStatus", RevenueallocationHeader."BLRStatus"::Approve);
            if RevenueallocationHeader.FindSet() then
                repeat
                    RevenueAllocationchargesRec.Reset();
                    RevenueAllocationchargesRec.SetRange("BLRRR_No.", RevenueallocationHeader."BLRNo.");
                    RevenueAllocationchargesRec.SetRange("BLRContract Id", tenancyContract."BLRContract ID"); // Assuming this field exists
                    RevenueAllocationchargesRec.SetFilter("BLRRevenue Start Date", '<=%1', StartDate);
                    RevenueAllocationchargesRec.SetFilter("BLRDescription", '<>%1', 'Credit Note');
                    RevenueAllocationchargesRec.SetLoadFields("BLRRR_No.", "BLRContract Id", "BLRRevenue Start Date", "BLRTotal Value");
                    RevenueAllocationchargesRec.CalcSums("BLRTotal Value");
                    TotalRevenueAllocated += RevenueAllocationchargesRec."BLRTotal Value";
                until RevenueallocationHeader.Next() = 0;
            // Method 1: If Revenue Allocation table has Contract ID field
            exit(TotalRevenueAllocated);
        end;
    end;



    local procedure CalculateRevenueAllocationdurngyearothercharges(ContractID: Integer; StartDate: Date; EndDate: Date): Decimal
    var
        RevenueAllocationchargesRec: Record "BLRRevenueRecognitionDetails";
        RevenueallocationHeader: Record "BLRRevenueAllocationDetails"; // Replace with your actual table name
        TotalRevenueAllocatedDuringYear: Decimal;
    begin
        TotalRevenueAllocatedDuringYear := 0;
        RevenueallocationHeader.Reset();
        RevenueallocationHeader.SetRange("BLRStatus", RevenueallocationHeader."BLRStatus"::Approve);
        if RevenueallocationHeader.FindSet() then
            repeat
                RevenueAllocationchargesRec.Reset();
                RevenueAllocationchargesRec.SetRange("BLRRR_No.", RevenueallocationHeader."BLRNo.");
                RevenueAllocationchargesRec.SetRange("BLRContract Id", ContractID); // Assuming this field exists
                RevenueAllocationchargesRec.SetFilter("BLRDescription", '<>%1', 'Credit Note');
                RevenueAllocationchargesRec.SetFilter("BLRRevenue Start Date", '%1..%2', StartDate, EndDate);
                RevenueAllocationchargesRec.SetLoadFields("BLRRR_No.", "BLRContract Id", "BLRRevenue Start Date", "BLRTotal Value");
                RevenueAllocationchargesRec.CalcSums("BLRTotal Value");
                TotalRevenueAllocatedDuringYear += RevenueAllocationchargesRec."BLRTotal Value";
            until RevenueallocationHeader.Next() = 0;
        // Method 1: If Revenue Allocation table has Contract ID field
        exit(TotalRevenueAllocatedDuringYear);
    end;

    local procedure GetSelectedItemTypes(var pItemTypes: List of [Text])
    var
        UnearnedRevenueItem: Record "BLROtherChargesUnearnedRevenue";
    begin
        UnearnedRevenueItem.SetRange("BLRNo.", Rec."BLRNo.");
        if UnearnedRevenueItem.FindSet() then
            repeat
                if UnearnedRevenueItem."BLRItem Type" <> '' then
                    if not pItemTypes.Contains(UnearnedRevenueItem."BLRItem Type") then
                        pItemTypes.Add(UnearnedRevenueItem."BLRItem Type");
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
        unearnedRevenueBuffer: Record "BLRSubUnearnedCharges";
        LastLineNo: Integer;
    begin
        unearnedRevenueBuffer.Reset();
        unearnedRevenueBuffer.SetRange("BLRHeader No.", Rec."BLRNo.");
        if unearnedRevenueBuffer.FindLast() then
            LastLineNo := unearnedRevenueBuffer."BLRLine No."
        else
            LastLineNo := 0;

        exit(LastLineNo + 1);
    end;

    procedure ClearSubgridDataParking()
    var
        RevenueItemDetail: Record "BLRSubUnearnedCharges";
    begin
        RevenueItemDetail.SetRange("BLRHeader No.", Rec."BLRNo."); // ✅ Clear only for this header
        RevenueItemDetail.DeleteAll(true);
    end;

    procedure CalculateAndStoreTotalRevenue()
    var
        SubUnearnedParkingReport: Record "BLRSubUnearnedCharges";
    begin
        Clear(TotalOtherCharges);
        Clear(TotalOpeningBalance);
        Clear(TotalInvoiceraisedduringtheyear);
        Clear(Totalrevenueallocatedduringtheyear);
        Clear(Totalunearnedrevenuebalance);
        Clear(Totalcalculatedunearnedrevenuebalance);
        Clear(Totalshortfall);

        SubUnearnedParkingReport.SetRange("BLRHeader No.", Rec."BLRNo.");
        if SubUnearnedParkingReport.FindSet() then
            repeat
                TotalOtherCharges += SubUnearnedParkingReport."BLROther Charges Value";
                TotalOpeningBalance += SubUnearnedParkingReport."BLROpening Balance";
                TotalInvoiceraisedduringtheyear += SubUnearnedParkingReport."BLRInvRaisedDurtheYear";
                Totalrevenueallocatedduringtheyear += SubUnearnedParkingReport."BLRRevAllocDurtheYear";
                Totalunearnedrevenuebalance += SubUnearnedParkingReport."BLRUnearned Revenue Balance";
                Totalcalculatedunearnedrevenuebalance += SubUnearnedParkingReport."BLRCalculatedUnearnedRevB19C1";
                Totalshortfall += SubUnearnedParkingReport."BLRShortfall/Excess";
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
        CurrPage."Other Charges Unearned Revenue".Page.SetNo(Rec."BLRNo.");
        CalculateAndStoreTotalRevenue();
    end;


    trigger OnModifyRecord(): Boolean
    begin
        CurrPage."Other Charges Unearned Revenue".Page.SetNo(Rec."BLRNo.");
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        CurrPage."Other Charges Unearned Revenue".Page.SetNo(Rec."BLRNo.");
    end;
}