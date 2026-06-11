page 73209633 "Revenue Allocation Card"
{
    PageType = Card;
    SourceTable = "BLRRevenueAllocationDetails";
    ApplicationArea = All;
    Caption = 'Revenue Allocation Details';
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Revenue Allocation Details';
                field("No."; Rec."BLRNo.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique identifier for the revenue allocation record.';
                    trigger OnValidate()
                    begin
                        if xRec."BLRNo." <> Rec."BLRNo." then
                            ClearSubgridData();
                    end;
                }
                field(Month; Rec."BLRMonth")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the month for which the revenue allocation is being processed.';
                }
                field("Financial Year"; Rec."BLRFinancial Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the financial year for the revenue allocation.';
                }
                field(Status; Rec."BLRStatus")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the current status of the revenue allocation record.';
                }
            }
            group("Revenue Allocation Report Details")
            {
                Caption = 'Revenue Allocation Report Details';
                part("Revenue Allocation Details"; "BLRRevenue Allocation SubGrid")
                {
                    SubPageLink = "BLRHeader No." = field("BLRNo.");
                }
            }
            group("Total Calculations")
            {
                Caption = 'Total Calculations(Rent)';
                field(TotalContractAmount; TotalContractAmount)
                {
                    Caption = 'Total Contract Amount';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total contract amount for the revenue allocation.';
                }
                field(TotalAnnualAmount; TotalAnnualAmount)
                {
                    Caption = 'Total Annual Amount';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total annual amount for the revenue allocation.';
                }
                field(TotalFinalAnnualAmount; TotalFinalAnnualAmount)
                {
                    Caption = 'Total Final Annual Amount';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total final annual amount for the revenue allocation.';
                }
                field(TotalValue; TotalValue)
                {
                    Caption = 'Total Value';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total value for the revenue allocation.';
                }
            }

            group("Revenue Recognition Item")
            {
                Caption = 'Revenue Item Details';
                part("Revenue Recognition Item Details"; "Revenue Recognition Item Sub")
                {
                    SubPageLink = "BLRRR_No." = field("BLRNo.");
                    UpdatePropagation = Both;

                }
            }

            group("Revenue Recognition Detail")
            {
                Caption = 'Revenue Recognition Details';
                part("Revenue Recognition Details"; "BLRRevenueRecognitionDetailSub")
                {
                    SubPageLink = "BLRRR_No." = field("BLRNo.");
                    UpdatePropagation = Both;

                }
            }
            group(" ")
            {
                Caption = 'Total Calculations(Other Charges)';
                field("Total Amount"; totalamounts)
                {
                    ApplicationArea = All;
                    Caption = 'Total Amount';
                    Editable = false;
                    ToolTip = 'Specifies the total amount for other charges in the revenue allocation.';
                }

                field("Total Annual Amount"; TotalAnnualAmounts)
                {
                    Caption = 'Total Annual Amount';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total annual amount for other charges in the revenue allocation.';
                }
                field("Total Final Annual Amount"; TotalFinalAnnualAmounts)
                {
                    Caption = 'Total Final Annual Amount';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total final annual amount for other charges in the revenue allocation.';
                }
                field("Total Contract Amount"; totalcontractAmounts)
                {
                    ApplicationArea = All;
                    Caption = 'Total Contract Amount';
                    Editable = false;
                    ToolTip = 'Specifies the total contract amount for other charges in the revenue allocation.';
                }
            }
            group("Final Amount")
            {
                Caption = 'Final Amount';

                field(TotalAnnualAmounts; totalcombinefinalamount)
                {
                    Caption = 'Total Annual Amount';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total annual amount for the final calculations in the revenue allocation.';
                }
                field(TotalFinalAnnualAmounts; totalcombinefinalannualamount)
                {
                    Caption = 'Total Final Annual Amount';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total final annual amount for the final calculations in the revenue allocation.';
                }
                field("Total Amounts"; totalcombineamounts)
                {
                    ApplicationArea = All;
                    Caption = 'Total Amount';
                    Editable = false;
                    ToolTip = 'Specifies the total amount for the final calculations in the revenue allocation.';
                }
                field("Total Contract Amounts"; totalcombinecontractAmounts)
                {
                    ApplicationArea = All;
                    Caption = 'Total Contract Amount';
                    Editable = false;
                    ToolTip = 'Specifies the total contract amount for the final calculations in the revenue allocation.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(FilterSubgrid)
            {
                ToolTip = 'Filter Subgrid';
                Caption = 'Revenue Allocation-Rent';
                Image = Filter;
                Enabled = Rec."BLRStatus" = Rec."BLRStatus"::Pending;
                trigger OnAction()
                var
                    companydata: Record "BLRCompanyData";
                begin
                    if companydata.FindFirst() then
                        if companydata."BLRRevenue Methods" <> companydata."BLRRevenue Methods"::" " then begin
                            FetchContracts(companydata."BLRRevenue Methods");
                            CalculateTotals();
                        end
                        else
                            Message('Revenue Method is not selected in Company Data Card');
                end;
            }
            action(RevenueAllocation)
            {
                ApplicationArea = All;
                Caption = 'Revenue Allocation Approval';
                Image = PostDocument;
                Enabled = Rec."BLRStatus" = Rec."BLRStatus"::Pending;
                ToolTip = 'Send Revenue Allocation Approval Request';

                trigger OnAction()
                var
                    Approvalrevenueallocation: Record "BLRRevenueAllocationApproval";
                begin
                    if Rec."BLRNo." = 0 then
                        Error('No must be specified');

                    Approvalrevenueallocation.SetRange("BLRID", Rec."BLRNo.");

                    if Approvalrevenueallocation.FindSet() then begin
                        // Modify existing approval record
                        Approvalrevenueallocation."BLRID" := Rec."BLRNo.";
                        Approvalrevenueallocation."BLRMonth" := Rec."BLRMonth";
                        Approvalrevenueallocation."BLRFinancial Year" := Rec."BLRFinancial Year";
                        Approvalrevenueallocation."BLRStatus" := Rec."BLRStatus";
                        Approvalrevenueallocation.Modify();
                        Message('Approval Request Modified successfully!');
                    end else begin
                        // Insert new approval record
                        Approvalrevenueallocation.Init();
                        Approvalrevenueallocation."BLRID" := Rec."BLRNo.";
                        Approvalrevenueallocation."BLRFinancial Year" := Rec."BLRFinancial Year";
                        Approvalrevenueallocation."BLRMonth" := Rec."BLRMonth";
                        Approvalrevenueallocation."BLRStatus" := Rec."BLRStatus";
                        Approvalrevenueallocation.Insert();
                        Message('Approval Request Sent successfully!');
                    end;
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        ClearSubgridData();
    end;

    trigger OnAfterGetRecord()
    begin
        CalculateTotals();
        CurrPage."Revenue Recognition Item Details".Page.SetRIID(Rec."BLRNo.");
        CurrPage."Revenue Recognition Details".Page.SetRIID(Rec."BLRNo.");
    end;

    var
        TotalContractAmount: Decimal;
        TotalAnnualAmount: Decimal;
        TotalFinalAnnualAmount: Decimal;
        TotalValue: Decimal;


    procedure CalculateTotals()
    var
        FilteredContractRec: Record "BLRRevenueAllocationSubGrid";
        SuspensionRec: Record "BLRSuspendReasonTable";
        SelectedMonthStart: Date;
        SelectedMonthEnd: Date;
    begin
        // Reset totals
        TotalContractAmount := 0;
        TotalAnnualAmount := 0;
        TotalFinalAnnualAmount := 0;
        TotalValue := 0;

        // Get first and last day of selected month
        SelectedMonthStart := DMY2Date(1, Rec."BLRMonth", Rec."BLRFinancial Year");
        SelectedMonthEnd := CALCDATE('<CM>', SelectedMonthStart);

        // Filter records for the current header
        FilteredContractRec.Reset();
        FilteredContractRec.SetRange("BLRHeader No.", Rec."BLRNo.");

        // Calculate totals
        if FilteredContractRec.FindSet() then
            repeat
                // Check if the contract is suspended during the selected month
                SuspensionRec.Reset();
                SuspensionRec.SetRange("BLRContract ID", FilteredContractRec."BLRContract Id");
                SuspensionRec.SetFilter("BLRDateEffective", '..%1', SelectedMonthEnd);
                SuspensionRec.SetFilter("BLRSuspensionEndDate", '%1..', SelectedMonthStart);

                // Only add to totals if the contract is NOT suspended during the selected month
                if not SuspensionRec.FindFirst() then begin
                    TotalContractAmount += FilteredContractRec."BLRContract Amount";
                    TotalAnnualAmount += FilteredContractRec."BLRAnnual Amount";
                    TotalFinalAnnualAmount += FilteredContractRec."BLRFinal Annual Amount";
                    TotalValue += FilteredContractRec."BLRTotal Value";
                end;
            until FilteredContractRec.Next() = 0;

        CurrPage.Update(false);
    end;

    procedure CalculateDaysInSelectedMonth(
        ContractStartDate: Date;
        ContractEndDate: Date;
        MultiYearStartDate: Date;
        MultiYearEndDate: Date;
        SelectedMonth: Integer;
        SelectedYear: Integer): Integer
    var
        MonthStartDate: Date;
        MonthEndDate: Date;
        EffectiveStartDate: Date;
        EffectiveEndDate: Date;
    begin
        // Get first day of selected month (without +1, assuming SelectedMonth is correct)
        MonthStartDate := DMY2Date(1, SelectedMonth, SelectedYear);
        // Get last day of selected month
        MonthEndDate := CALCDATE('<+1M-1D>', MonthStartDate);

        // Return 0 if multi-year period is completely outside selected month
        if (MultiYearStartDate > MonthEndDate) or (MultiYearEndDate < MonthStartDate) then
            exit(0);

        // Determine effective start date for the month
        // Use the latest of: MonthStart, MultiYearStart, ContractStart
        EffectiveStartDate := MonthStartDate;
        if MultiYearStartDate > EffectiveStartDate then
            EffectiveStartDate := MultiYearStartDate;
        if ContractStartDate > EffectiveStartDate then
            EffectiveStartDate := ContractStartDate;

        // Determine effective end date for the month  
        // Use the earliest of: MonthEnd, MultiYearEnd, ContractEnd
        EffectiveEndDate := MonthEndDate;
        if MultiYearEndDate < EffectiveEndDate then
            EffectiveEndDate := MultiYearEndDate;
        if ContractEndDate < EffectiveEndDate then
            EffectiveEndDate := ContractEndDate;

        // Ensure we don't have invalid date range
        if EffectiveStartDate > EffectiveEndDate then
            exit(0);

        // Calculate inclusive number of days
        exit(EffectiveEndDate - EffectiveStartDate + 1);
    end;

    //---------------Clear Subgrid Data--------------//
    procedure ClearSubgridData()
    var
        FilteredContractRec: Record "BLRRevenueAllocationSubGrid";
        revenueitem: Record "BLRRevenueRecognitionItem";
    begin
        FilteredContractRec.Reset();
        FilteredContractRec.SetRange("BLRHeader No.", Rec."BLRNo.");
        FilteredContractRec.DeleteAll();
        revenueitem.Reset();
        revenueitem.SetRange("BLRRR_No.", Rec."BLRNo.");
        revenueitem.DeleteAll();
    end;


    //---------------Get Next LineNo--------------//
    procedure GetNextLineNo(): Integer
    var
        FilteredContractRec: Record "BLRRevenueAllocationSubGrid";
        LastLineNo: Integer;
    begin
        FilteredContractRec.Reset();
        FilteredContractRec.SetRange("BLRHeader No.", Rec."BLRNo.");
        if FilteredContractRec.FindLast() then
            LastLineNo := FilteredContractRec."BLRLine No."
        else
            LastLineNo := 0;
        exit(LastLineNo + 1);
    end;


    //---------------Should Keep Entry--------------//
    procedure ShouldKeepEntry(StartDate: Date; EndDate: Date): Boolean
    var
        LastDayOfMonth: Date;
        FirstDayOfMonth: Date;
    begin
        // Get first day of selected month
        FirstDayOfMonth := DMY2Date(1, Rec."BLRMonth", Rec."BLRFinancial Year");

        // Get last day of selected month
        LastDayOfMonth := CALCDATE('<+1M-1D>', FirstDayOfMonth);

        // Check if selected month's date range overlaps with the given date range
        // A period overlaps if:
        if (StartDate <= LastDayOfMonth) and (EndDate >= FirstDayOfMonth) then
            exit(true);

        exit(false);
    end;

    procedure InsertAllocationLine(
     ContractRec: Record "BLRTenancyContract";
     MultiYearStartDate: Date;
     MultiYearEndDate: Date;
     NoOfDays: Integer;
     PerDayRent: Decimal;
     pTotalAnnualAmount: Decimal;
     OwnerShareAmount: Decimal;
     TerminationDate: Date;
     MonthNo: Integer;
     FinancialYear: Integer;
    RevenueMethod: Option "","Fixed Monthly Rent","Per Day Rent";
    Revenuestartdate: Date)

    var
        FilteredContractRec: Record "BLRRevenueAllocationSubGrid";
        SuspensionRec: Record "BLRSuspendReasonTable";
        CalculatedDays: Integer;
        NewLineNo: Integer;
        PerDayRentWithoutGracePeriod: Decimal;
        PerDayRentWithGracePeriod: Decimal;
        TotalContractDays: Integer;
        TotalContractDaysWithGrace: Integer;
        DifferencePerDayRent: Decimal;
        GracePeriodAdjustmentValue: Decimal;
        GridAnnualAmount: Decimal;
        GraceStartDate: Date;
        GraceEndDate: Date;
        SelectedMonthStart: Date;
        SelectedMonthEnd: Date;
        ShouldInsertGraceLine: Boolean;
        AdjustedStartDate: Date; // 🔹 new
        AdjustedEndDate: Date;   // 🔹 new        
        SuspensionStartDate: Date;
        SuspensionEndDate: Date;
    begin
        // Check if entry should be kept based on date range
        if not ShouldKeepEntry(MultiYearStartDate, MultiYearEndDate) then
            exit;

        // Calculate selected month date range
        SelectedMonthStart := DMY2Date(1, MonthNo, FinancialYear);
        SelectedMonthEnd := CALCDATE('<+1M-1D>', SelectedMonthStart);

        // Calculate grace period dates
        GraceStartDate := ContractRec."BLRGrace Start Date";
        GraceEndDate := ContractRec."BLRGrace End Date";

        ShouldInsertGraceLine := (ContractRec."BLRGrace Period" > 0) and
                                (GraceStartDate <> 0D) and (GraceEndDate <> 0D) and
                                (GraceStartDate <= SelectedMonthEnd) and
                                (GraceEndDate >= SelectedMonthStart);

        // Get new line number
        NewLineNo := GetNextLineNo();

        // 🔹 NEW: Calculate AdjustedStartDate & AdjustedEndDate
        AdjustedStartDate := MultiYearStartDate;
        if AdjustedStartDate < SelectedMonthStart then
            AdjustedStartDate := SelectedMonthStart;

        AdjustedEndDate := MultiYearEndDate;
        if AdjustedEndDate > SelectedMonthEnd then
            AdjustedEndDate := SelectedMonthEnd;

        if (TerminationDate <> 0D) and (AdjustedEndDate > TerminationDate) then
            AdjustedEndDate := TerminationDate;

        // 🔹 Adjust for Suspension Start
        SuspensionRec.Reset();
        SuspensionRec.SetRange("BLRContract ID", ContractRec."BLRContract ID");
        if SuspensionRec.FindFirst() then begin
            SuspensionStartDate := SuspensionRec."BLRDateEffective";
            SuspensionEndDate := SuspensionRec."BLRSuspensionEndDate";
            // If suspension start date is within selected month

            if (SuspensionStartDate <> 0D) and (SuspensionEndDate <> 0D) then
                // If suspension overlaps month
                if not ((SuspensionEndDate < SelectedMonthStart) or
                        (SuspensionStartDate > SelectedMonthEnd)) then begin

                    // Case: suspension starts inside month
                    if SuspensionStartDate > SelectedMonthStart then
                        AdjustedEndDate := SuspensionStartDate - 1;

                    // Case: suspension ends inside month
                    if SuspensionEndDate < SelectedMonthEnd then
                        AdjustedStartDate := SuspensionEndDate + 1;
                end;
        end;

        if (AdjustedStartDate <= AdjustedEndDate) then
            CalculatedDays := AdjustedEndDate - AdjustedStartDate + 1
        else
            CalculatedDays := 0;

        // Get the days in the specific grid record's date range
        TotalContractDays := MultiYearEndDate - MultiYearStartDate + 1;

        // Calculate Total Contract Days (with grace period)
        TotalContractDaysWithGrace := TotalContractDays + ContractRec."BLRGrace Period";

        // Use the annual amount from the grid record instead of the main contract
        GridAnnualAmount := pTotalAnnualAmount;

        // Calculate Per Day Rent without Grace Period (using grid's annual amount)
        PerDayRentWithoutGracePeriod := Round(GridAnnualAmount / TotalContractDays);

        // Calculate Per Day Rent with Grace Period (using grid's annual amount)
        PerDayRentWithGracePeriod := Round(GridAnnualAmount / TotalContractDaysWithGrace);

        // Calculate the difference per day
        DifferencePerDayRent := PerDayRentWithoutGracePeriod - PerDayRentWithGracePeriod;

        // Calculate total adjustment value for the month
        GracePeriodAdjustmentValue := DifferencePerDayRent * CalculatedDays;

        // -----------------------------------------------
        // Insert main allocation line (without grace period adjustment)
        // -----------------------------------------------
        FilteredContractRec.Init();
        FilteredContractRec."BLRLine No." := NewLineNo;
        FilteredContractRec."BLRHeader No." := Rec."BLRNo.";
        FilteredContractRec."BLRProperty Name" := ContractRec."BLRProperty Name";
        FilteredContractRec."BLRContract Id" := ContractRec."BLRContract ID";
        FilteredContractRec."BLRContract Tenure" := ContractRec."BLRContract Tenor";
        FilteredContractRec."BLRCustomer Name" := ContractRec."BLRCustomer Name";
        FilteredContractRec."BLRContract Start Date" := ContractRec."BLRContract Start Date";
        FilteredContractRec."BLRContract End Date" := ContractRec."BLRContract End Date";
        FilteredContractRec."BLRGrace Days" := ContractRec."BLRGrace Period";
        FilteredContractRec."BLRGrace Start Date" := ContractRec."BLRGrace Start Date";
        FilteredContractRec."BLRGrace End Date" := ContractRec."BLRGrace End Date";
        FilteredContractRec."BLRUnit Type" := ContractRec."BLRUsage Type";
        FilteredContractRec."BLRDescription" := 'Regular';

        case
            ContractRec."BLRPraposal Type Selected" of
            ContractRec."BLRPraposal Type Selected"::"Single Unit":
                FilteredContractRec."BLRSingle Unit Names" := ContractRec."BLRUnit Name";
            ContractRec."BLRPraposal Type Selected"::"Merge Unit":
                FilteredContractRec."BLRSingle Unit Names" := ContractRec."BLRSingle Unit Name";
            else
                FilteredContractRec."BLRSingle Unit Names" := '';
        end;

        // Add Termination Date
        if TerminationDate = 0D then
            FilteredContractRec."BLRTermination Date" := 0D
        else
            FilteredContractRec."BLRTermination Date" := TerminationDate;

        SuspensionRec.Reset();
        SuspensionRec.SetRange("BLRContract ID", ContractRec."BLRContract ID");
        if SuspensionRec.FindFirst() then begin
            FilteredContractRec."BLRSuspension Start Date" := SuspensionRec."BLRDateEffective";
            FilteredContractRec."BLRSuspension End Date" := SuspensionRec."BLRSuspensionEndDate";
        end;

        FilteredContractRec."BLRMulti Year Start Date" := MultiYearStartDate;
        FilteredContractRec."BLRMulti Year End Date" := MultiYearEndDate;
        FilteredContractRec."BLRNo Of Days" := CalculatedDays;
        FilteredContractRec."BLRContract Amount" := ContractRec."BLRAnnual Rent Amount"; // Use grid's annual amount
        FilteredContractRec."BLRAnnual Amount" := GridAnnualAmount;
        FilteredContractRec."BLRFinal Annual Amount" := pTotalAnnualAmount;
        FilteredContractRec."BLRPosting Month" := MonthNo;
        FilteredContractRec."BLRPosting Year" := FinancialYear;
        FilteredContractRec."BLRRevenue Start Date" := Revenuestartdate;


        if RevenueMethod = RevenueMethod::"Per Day Rent" then begin
            FilteredContractRec."BLRPer Day Rent" := Round(PerDayRentWithoutGracePeriod); // Use the per day rent passed from the grid
            FilteredContractRec."BLRTotal Value" := CalculatedDays * FilteredContractRec."BLRPer Day Rent";
            FilteredContractRec."BLROwner Share" := CalculatedDays * FilteredContractRec."BLRPer Day Rent";
        end
        else begin
            FilteredContractRec."BLRPer Month Rent" := CalculatePerMonthRent(FilteredContractRec."BLRFinal Annual Amount", CalculatedDays, MonthNo, FinancialYear, ContractRec, MultiYearStartDate, MultiYearEndDate); // Use the per day rent passed from the grid
            FilteredContractRec."BLRTotal Value" := FilteredContractRec."BLRPer Month Rent";
            FilteredContractRec."BLROwner Share" := FilteredContractRec."BLRPer Month Rent";
        end;


        FilteredContractRec."BLRPosting Period" := Format(FilteredContractRec."BLRPosting Month") +
            ' ' + Format(FilteredContractRec."BLRPosting Year") + ' ' + '-' + ' ' +
            Format(FilteredContractRec."BLRPosting Month") + ' ' + Format(FilteredContractRec."BLRPosting Year");
        FilteredContractRec."BLROwner Name" := ContractRec."BLROwner's Name";
        FilteredContractRec.Insert();

        if ShouldInsertGraceLine then begin
            NewLineNo := GetNextLineNo();

            FilteredContractRec.Init();
            FilteredContractRec."BLRLine No." := NewLineNo;
            FilteredContractRec."BLRHeader No." := Rec."BLRNo.";
            FilteredContractRec."BLRProperty Name" := ContractRec."BLRProperty Name";
            FilteredContractRec."BLRContract Id" := ContractRec."BLRContract ID";
            FilteredContractRec."BLRContract Tenure" := ContractRec."BLRContract Tenor";
            FilteredContractRec."BLRCustomer Name" := ContractRec."BLRCustomer Name";
            FilteredContractRec."BLRContract Start Date" := ContractRec."BLRContract Start Date";
            FilteredContractRec."BLRContract End Date" := ContractRec."BLRContract End Date";
            FilteredContractRec."BLRGrace Days" := ContractRec."BLRGrace Period";
            FilteredContractRec."BLRGrace Start Date" := ContractRec."BLRGrace Start Date";
            FilteredContractRec."BLRGrace End Date" := ContractRec."BLRGrace End Date";
            FilteredContractRec."BLRUnit Type" := ContractRec."BLRUsage Type";
            FilteredContractRec."BLRDescription" := 'Grace Period';

            case
                ContractRec."BLRPraposal Type Selected" of
                ContractRec."BLRPraposal Type Selected"::"Single Unit":
                    FilteredContractRec."BLRSingle Unit Names" := ContractRec."BLRUnit Name";
                ContractRec."BLRPraposal Type Selected"::"Merge Unit":
                    FilteredContractRec."BLRSingle Unit Names" := ContractRec."BLRSingle Unit Name";
                else
                    FilteredContractRec."BLRSingle Unit Names" := '';
            end;

            // Add Termination Date
            if TerminationDate = 0D then
                FilteredContractRec."BLRTermination Date" := 0D
            else
                FilteredContractRec."BLRTermination Date" := TerminationDate;

            if SuspensionRec.FindFirst() then begin
                FilteredContractRec."BLRSuspension Start Date" := SuspensionRec."BLRDateEffective";
                FilteredContractRec."BLRSuspension End Date" := SuspensionRec."BLRSuspensionEndDate";
            end;

            FilteredContractRec."BLRMulti Year Start Date" := MultiYearStartDate;
            FilteredContractRec."BLRMulti Year End Date" := MultiYearEndDate;
            FilteredContractRec."BLRNo Of Days" := CalculatedDays;

            if RevenueMethod = RevenueMethod::"Per Day Rent" then
                FilteredContractRec."BLRPer Day Rent" := -DifferencePerDayRent // Negative value
            else
                FilteredContractRec."BLRPer Month Rent" := -DifferencePerDayRent; // Negative value

            FilteredContractRec."BLRContract Amount" := ContractRec."BLRAnnual Rent Amount"; // Use grid's annual amount
            FilteredContractRec."BLRAnnual Amount" := GridAnnualAmount;
            FilteredContractRec."BLRTotal Value" := -GracePeriodAdjustmentValue; // Negative adjustment
            FilteredContractRec."BLROwner Share" := -GracePeriodAdjustmentValue; // Negative adjustment
            FilteredContractRec."BLRFinal Annual Amount" := pTotalAnnualAmount;
            FilteredContractRec."BLRPosting Month" := MonthNo;
            FilteredContractRec."BLRPosting Year" := FinancialYear;
            FilteredContractRec."BLRRevenue Start Date" := Revenuestartdate;
            FilteredContractRec."BLRPosting Period" := Format(FilteredContractRec."BLRPosting Month") +
                ' ' + Format(FilteredContractRec."BLRPosting Year") + ' ' + '-' + ' ' +
                Format(FilteredContractRec."BLRPosting Month") + ' ' + Format(FilteredContractRec."BLRPosting Year");
            FilteredContractRec."BLROwner Name" := ContractRec."BLROwner's Name";
            // Add a description to indicate this is a grace period adjustment
            // FilteredContractRec."BLRDescription" := 'Grace Period Adjustment';
            FilteredContractRec.Insert();
        end;
    end;


    // Add this new helper procedure to handle missed revenue allocations
    procedure HandleMissedAllocation(
     ContractRec: Record "BLRTenancyContract";
     MonthNo: Integer;
     FinancialYear: Integer;
     RevenueMethod: Option "","Fixed Monthly Rent","Per Day Rent")
    var
        SingleUnitRent: Record "BLRTCSingleUnitRentSubPage";
        MultiUnitRent: Record "BLRTCSingleLumAnnualAmntSP";
        MergedSingleRent: Record "BLRTCMergeSameSqureSubPage";
        MergedMultiRent: Record "BLRTCMergeDifferentSqSubPage";
        SpecialRent: Record "BLRTCMergeLumAnnualAmountSP";
        FinalCalculationRec: Record "BLRFinalCalculation";
        PreviousMonthNo: Integer;
        PreviousYearNo: Integer;
        PreviousMonthStart: Date;
        PreviousMonthEnd: Date;
        ContractStartDate: Date;
        TerminationDate: Date;
    begin
        // Calculate previous month and year
        if MonthNo = 1 then begin
            PreviousMonthNo := 12;
            PreviousYearNo := FinancialYear - 1;
        end else begin
            PreviousMonthNo := MonthNo - 1;
            PreviousYearNo := FinancialYear;
        end;

        // Calculate date ranges
        PreviousMonthStart := DMY2Date(1, PreviousMonthNo, PreviousYearNo);
        PreviousMonthEnd := CALCDATE('<CM>', PreviousMonthStart);
        ContractStartDate := ContractRec."BLRContract Start Date";

        // Check if contract started in previous month
        if (ContractStartDate >= PreviousMonthStart) and (ContractStartDate <= PreviousMonthEnd) then begin

            // Retrieve Termination Date from Final Calculation
            FinalCalculationRec.Reset();
            FinalCalculationRec.SetRange("BLRContract ID", ContractRec."BLRContract ID");
            if FinalCalculationRec.FindFirst() then
                TerminationDate := FinalCalculationRec."BLRTermination Date"
            else
                TerminationDate := 0D;

            // Process each rent type for missed allocation
            // Check Single Unit Rent grid
            SingleUnitRent.Reset();
            SingleUnitRent.SetRange("BLRContract Id", ContractRec."BLRContract ID");
            if SingleUnitRent.FindSet() then
                repeat
                    if (SingleUnitRent."BLRStart Date" <= PreviousMonthEnd) and (SingleUnitRent."BLREnd Date" >= ContractStartDate) and
              not HasPreviousMonthAllocationLine(ContractRec."BLRContract ID", PreviousMonthNo, PreviousYearNo,
                   SingleUnitRent."BLRStart Date", SingleUnitRent."BLREnd Date", SingleUnitRent."BLRFinal Annual Amount") then
                        InsertMissedAllocationLine(
                            ContractRec,
                            SingleUnitRent."BLRStart Date",
                            SingleUnitRent."BLREnd Date",
                            SingleUnitRent."BLRNumber of Days",
                            SingleUnitRent."BLRPer Day Rent",
                            SingleUnitRent."BLRFinal Annual Amount",
                            SingleUnitRent."BLRFinal Annual Amount",
                            TerminationDate,
                            PreviousMonthNo,
                            PreviousYearNo,
                            ContractStartDate,
                            PreviousMonthEnd,
                            RevenueMethod);

                until SingleUnitRent.Next() = 0;


            // Check Multi Unit Rent grid
            MultiUnitRent.Reset();
            MultiUnitRent.SetRange("BLRContract Id", ContractRec."BLRContract ID");
            if MultiUnitRent.FindSet() then
                repeat
                    if (MultiUnitRent."BLRSL_Start Date" <= PreviousMonthEnd) and (MultiUnitRent."BLRSL_End Date" >= ContractStartDate) and
       not HasPreviousMonthAllocationLine(ContractRec."BLRContract ID", PreviousMonthNo, PreviousYearNo,
            MultiUnitRent."BLRSL_Start Date", MultiUnitRent."BLRSL_End Date", MultiUnitRent."BLRSL_Final Annual Amount") then
                        InsertMissedAllocationLine(
                            ContractRec,
                            MultiUnitRent."BLRSL_Start Date",
                            MultiUnitRent."BLRSL_End Date",
                            MultiUnitRent."BLRSL_Number of Days",
                            MultiUnitRent."BLRSL_Per Day Rent",
                            MultiUnitRent."BLRSL_Final Annual Amount",
                            MultiUnitRent."BLRSL_Final Annual Amount",
                            TerminationDate,
                            PreviousMonthNo,
                            PreviousYearNo,
                            ContractStartDate,
                            PreviousMonthEnd,
                            RevenueMethod);

                until MultiUnitRent.Next() = 0;


            // Check Merged Single Rent grid
            MergedSingleRent.Reset();
            MergedSingleRent.SetRange("BLRContract Id", ContractRec."BLRContract ID");
            if MergedSingleRent.FindSet() then
                repeat
                    if (MergedSingleRent."BLRMS_Start Date" <= PreviousMonthEnd) and (MergedSingleRent."BLRMS_End Date" >= ContractStartDate) and
       not HasPreviousMonthAllocationLine(ContractRec."BLRContract ID", PreviousMonthNo, PreviousYearNo,
            MergedSingleRent."BLRMS_Start Date", MergedSingleRent."BLRMS_End Date", MergedSingleRent."BLRMS_Final Annual Amount") then
                        InsertMissedAllocationLine(
                            ContractRec,
                            MergedSingleRent."BLRMS_Start Date",
                            MergedSingleRent."BLRMS_End Date",
                            MergedSingleRent."BLRMS_Number of Days",
                            MergedSingleRent."BLRMS_Per Day Rent",
                            MergedSingleRent."BLRMS_Final Annual Amount",
                            MergedSingleRent."BLRMS_Final Annual Amount",
                            TerminationDate,
                            PreviousMonthNo,
                            PreviousYearNo,
                            ContractStartDate,
                            PreviousMonthEnd,
                            RevenueMethod);

                until MergedSingleRent.Next() = 0;


            // Check Merged Multi Rent grid
            MergedMultiRent.Reset();
            MergedMultiRent.SetRange("BLRContract Id", ContractRec."BLRContract ID");
            if MergedMultiRent.FindSet() then
                repeat
                    if (MergedMultiRent."BLRMD_Start Date" <= PreviousMonthEnd) and (MergedMultiRent."BLRMD_End Date" >= ContractStartDate) and
       not HasPreviousMonthAllocationLine(ContractRec."BLRContract ID", PreviousMonthNo, PreviousYearNo,
            MergedMultiRent."BLRMD_Start Date", MergedMultiRent."BLRMD_End Date", MergedMultiRent."BLRMD_Final Annual Amount") then
                        InsertMissedAllocationLine(
                            ContractRec,
                            MergedMultiRent."BLRMD_Start Date",
                            MergedMultiRent."BLRMD_End Date",
                            MergedMultiRent."BLRMD_Number of Days",
                            MergedMultiRent."BLRMD_Per Day Rent",
                            MergedMultiRent."BLRMD_Final Annual Amount",
                            MergedMultiRent."BLRMD_Final Annual Amount",
                            TerminationDate,
                            PreviousMonthNo,
                            PreviousYearNo,
                            ContractStartDate,
                            PreviousMonthEnd,
                            RevenueMethod);

                until MergedMultiRent.Next() = 0;


            // Check Special Rent grid
            SpecialRent.Reset();
            SpecialRent.SetRange("BLRContract Id", ContractRec."BLRContract ID");
            if SpecialRent.FindSet() then
                repeat
                    if (SpecialRent."BLRML_Start Date" <= PreviousMonthEnd) and (SpecialRent."BLRML_End Date" >= ContractStartDate) and
       not HasPreviousMonthAllocationLine(ContractRec."BLRContract ID", PreviousMonthNo, PreviousYearNo,
            SpecialRent."BLRML_Start Date", SpecialRent."BLRML_End Date", SpecialRent."BLRML_Final Annual Amount") then
                        InsertMissedAllocationLine(
                            ContractRec,
                            SpecialRent."BLRML_Start Date",
                            SpecialRent."BLRML_End Date",
                            SpecialRent."BLRML_Number of Days",
                            SpecialRent."BLRML_Per Day Rent",
                            SpecialRent."BLRML_Final Annual Amount",
                            SpecialRent."BLRML_Final Annual Amount",
                            TerminationDate,
                            PreviousMonthNo,
                            PreviousYearNo,
                            ContractStartDate,
                            PreviousMonthEnd,
                            RevenueMethod);

                until SpecialRent.Next() = 0;

        end;
    end;

    // Helper procedure to insert missed allocation lines
    // Helper procedure to insert missed allocation lines
    procedure InsertMissedAllocationLine(
     ContractRec: Record "BLRTenancyContract";
     MultiYearStartDate: Date;
     MultiYearEndDate: Date;
     NoOfDays: Integer;
     PerDayRent: Decimal;
     pTotalAnnualAmount: Decimal;
     OwnerShareAmount: Decimal;
     TerminationDate: Date;
     PreviousMonthNo: Integer;
     PreviousYearNo: Integer;
     ContractStartDate: Date;
     PreviousMonthEnd: Date;
        RevenueMethod: Option "","Fixed Monthly Rent","Per Day Rent")

    var
        FilteredContractRec: Record "BLRRevenueAllocationSubGrid";
        SuspensionRec: Record "BLRSuspendReasonTable";
        FetchMonth: Codeunit "BLRFetch Month";
        NewLineNo: Integer;
        PerDayRentWithoutGracePeriod: Decimal;
        PerDayRentWithGracePeriod: Decimal;
        TotalContractDays: Integer;
        TotalContractDaysWithGrace: Integer;
        DifferencePerDayRent: Decimal;
        GracePeriodAdjustmentValue: Decimal;
        GridAnnualAmount: Decimal;
        MissedDays: Integer;
        // New variables for grace period date check
        GraceStartDate: Date;
        GraceEndDate: Date;
        ShouldInsertGraceLine: Boolean;
    begin
        // Calculate missed days
        MissedDays := PreviousMonthEnd - ContractStartDate + 1;

        // Get new line number
        NewLineNo := GetNextLineNo();

        // Use the annual amount from the grid record instead of the main contract
        GridAnnualAmount := pTotalAnnualAmount;

        // Calculate Total Contract Days
        TotalContractDays := MultiYearEndDate - MultiYearStartDate + 1;

        // Calculate Total Contract Days (with grace period)
        TotalContractDaysWithGrace := TotalContractDays + ContractRec."BLRGrace Period";

        // Calculate Per Day Rent without Grace Period (using grid's annual amount)
        PerDayRentWithoutGracePeriod := Round(GridAnnualAmount / TotalContractDays);

        // Calculate Per Day Rent with Grace Period (using grid's annual amount)
        PerDayRentWithGracePeriod := Round(GridAnnualAmount / TotalContractDaysWithGrace);

        // Calculate the difference per day
        DifferencePerDayRent := PerDayRentWithoutGracePeriod - PerDayRentWithGracePeriod;

        // Calculate total adjustment value for the missed days
        GracePeriodAdjustmentValue := DifferencePerDayRent * MissedDays;

        // Calculate grace period dates
        GraceStartDate := ContractRec."BLRGrace Start Date";
        GraceEndDate := ContractRec."BLRGrace End Date";

        // Check if grace period falls within missed allocation period
        // Grace period should be inserted only if grace start date and grace end date 
        // overlap with the missed allocation period (contract start date to previous month end)
        ShouldInsertGraceLine := (ContractRec."BLRGrace Period" > 0) and
                                (GraceStartDate <> 0D) and (GraceEndDate <> 0D) and
                                (GraceStartDate <= PreviousMonthEnd) and
                                (GraceEndDate >= ContractStartDate);

        // -----------------------------------------------
        // Insert missed allocation line (without grace period adjustment)
        // -----------------------------------------------
        FilteredContractRec.Init();
        FilteredContractRec."BLRLine No." := NewLineNo;
        FilteredContractRec."BLRHeader No." := Rec."BLRNo.";
        FilteredContractRec."BLRProperty Name" := ContractRec."BLRProperty Name";
        FilteredContractRec."BLRContract Id" := ContractRec."BLRContract ID";
        FilteredContractRec."BLRContract Tenure" := ContractRec."BLRContract Tenor";
        FilteredContractRec."BLRCustomer Name" := ContractRec."BLRCustomer Name";
        FilteredContractRec."BLRContract Start Date" := ContractRec."BLRContract Start Date";
        FilteredContractRec."BLRContract End Date" := ContractRec."BLRContract End Date";
        FilteredContractRec."BLRGrace Days" := ContractRec."BLRGrace Period";
        FilteredContractRec."BLRGrace Start Date" := ContractRec."BLRGrace Start Date";
        FilteredContractRec."BLRGrace End Date" := ContractRec."BLRGrace End Date";
        FilteredContractRec."BLRUnit Type" := ContractRec."BLRUsage Type";
        FilteredContractRec."BLRDescription" := 'Missed Revenue';

        case
            ContractRec."BLRPraposal Type Selected" of
            ContractRec."BLRPraposal Type Selected"::"Single Unit":
                FilteredContractRec."BLRSingle Unit Names" := ContractRec."BLRUnit Name";
            ContractRec."BLRPraposal Type Selected"::"Merge Unit":
                FilteredContractRec."BLRSingle Unit Names" := ContractRec."BLRSingle Unit Name";
            else
                FilteredContractRec."BLRSingle Unit Names" := '';
        end;

        // Add Termination Date
        if TerminationDate = 0D then
            FilteredContractRec."BLRTermination Date" := 0D
        else
            FilteredContractRec."BLRTermination Date" := TerminationDate;

        SuspensionRec.Reset();
        SuspensionRec.SetRange("BLRContract ID", ContractRec."BLRContract ID");
        if SuspensionRec.FindFirst() then begin
            FilteredContractRec."BLRSuspension Start Date" := SuspensionRec."BLRDateEffective";
            FilteredContractRec."BLRSuspension End Date" := SuspensionRec."BLRSuspensionEndDate";
        end;

        FilteredContractRec."BLRMulti Year Start Date" := MultiYearStartDate;
        FilteredContractRec."BLRMulti Year End Date" := MultiYearEndDate;
        FilteredContractRec."BLRNo Of Days" := MissedDays;
        FilteredContractRec."BLRContract Amount" := ContractRec."BLRAnnual Rent Amount"; // Use grid's annual amount
        FilteredContractRec."BLRAnnual Amount" := GridAnnualAmount;
        FilteredContractRec."BLRFinal Annual Amount" := pTotalAnnualAmount;

        if RevenueMethod = RevenueMethod::"Per Day Rent" then begin
            FilteredContractRec."BLRPer Day Rent" := Round(PerDayRentWithoutGracePeriod);
            FilteredContractRec."BLRTotal Value" := MissedDays * FilteredContractRec."BLRPer Day Rent";
            FilteredContractRec."BLROwner Share" := MissedDays * FilteredContractRec."BLRPer Day Rent";
        end
        else begin
            FilteredContractRec."BLRPer Month Rent" := CalculatePerMonthRent(FilteredContractRec."BLRFinal Annual Amount", MissedDays, PreviousMonthNo, PreviousYearNo, ContractRec, MultiYearStartDate, MultiYearEndDate);
            FilteredContractRec."BLRTotal Value" := FilteredContractRec."BLRPer Month Rent";
            FilteredContractRec."BLROwner Share" := FilteredContractRec."BLRPer Month Rent";
        end;


        FilteredContractRec."BLRPosting Month" := PreviousMonthNo;
        FilteredContractRec."BLRPosting Year" := PreviousYearNo;
        FilteredContractRec."BLRRevenue Start Date" := DMY2Date(1, PreviousMonthNo, PreviousYearNo);

        FilteredContractRec."BLRPosting Period" := FetchMonth.GetMonthName(PreviousMonthNo) + ' ' +
            Format(PreviousYearNo) + ' ' + '-' + ' ' + FetchMonth.GetMonthName(PreviousMonthNo) + ' ' + Format(PreviousYearNo);
        FilteredContractRec."BLROwner Name" := ContractRec."BLROwner's Name";
        FilteredContractRec.Insert();

        // -----------------------------------------------
        // Insert grace period adjustment line (negative allocation) for missed days
        // Only if grace period dates overlap with the missed allocation period
        // -----------------------------------------------
        if ShouldInsertGraceLine then begin
            NewLineNo := GetNextLineNo();

            FilteredContractRec.Init();
            FilteredContractRec."BLRLine No." := NewLineNo;
            FilteredContractRec."BLRHeader No." := Rec."BLRNo.";
            FilteredContractRec."BLRProperty Name" := ContractRec."BLRProperty Name";
            FilteredContractRec."BLRContract Id" := ContractRec."BLRContract ID";
            FilteredContractRec."BLRContract Tenure" := ContractRec."BLRContract Tenor";
            FilteredContractRec."BLRCustomer Name" := ContractRec."BLRCustomer Name";
            FilteredContractRec."BLRContract Start Date" := ContractRec."BLRContract Start Date";
            FilteredContractRec."BLRContract End Date" := ContractRec."BLRContract End Date";
            FilteredContractRec."BLRGrace Days" := ContractRec."BLRGrace Period";
            FilteredContractRec."BLRGrace Start Date" := ContractRec."BLRGrace Start Date";
            FilteredContractRec."BLRGrace End Date" := ContractRec."BLRGrace End Date";
            FilteredContractRec."BLRUnit Type" := ContractRec."BLRUsage Type";
            FilteredContractRec."BLRDescription" := 'Grace Period';

            case
                ContractRec."BLRPraposal Type Selected" of
                ContractRec."BLRPraposal Type Selected"::"Single Unit":
                    FilteredContractRec."BLRSingle Unit Names" := ContractRec."BLRUnit Name";
                ContractRec."BLRPraposal Type Selected"::"Merge Unit":
                    FilteredContractRec."BLRSingle Unit Names" := ContractRec."BLRSingle Unit Name";
                else
                    FilteredContractRec."BLRSingle Unit Names" := '';
            end;

            // Add Termination Date
            if TerminationDate = 0D then
                FilteredContractRec."BLRTermination Date" := 0D
            else
                FilteredContractRec."BLRTermination Date" := TerminationDate;

            if SuspensionRec.FindFirst() then begin
                FilteredContractRec."BLRSuspension Start Date" := SuspensionRec."BLRDateEffective";
                FilteredContractRec."BLRSuspension End Date" := SuspensionRec."BLRSuspensionEndDate";
            end;

            FilteredContractRec."BLRMulti Year Start Date" := MultiYearStartDate;
            FilteredContractRec."BLRMulti Year End Date" := MultiYearEndDate;
            FilteredContractRec."BLRNo Of Days" := MissedDays;

            if RevenueMethod = RevenueMethod::"Per Day Rent" then
                FilteredContractRec."BLRPer Day Rent" := -DifferencePerDayRent
            else
                FilteredContractRec."BLRPer Month Rent" := -DifferencePerDayRent;

            FilteredContractRec."BLRContract Amount" := ContractRec."BLRAnnual Rent Amount";
            FilteredContractRec."BLRAnnual Amount" := GridAnnualAmount;
            FilteredContractRec."BLRTotal Value" := -GracePeriodAdjustmentValue;
            FilteredContractRec."BLROwner Share" := -GracePeriodAdjustmentValue;
            FilteredContractRec."BLRFinal Annual Amount" := pTotalAnnualAmount;
            FilteredContractRec."BLRPosting Month" := PreviousMonthNo;
            FilteredContractRec."BLRPosting Year" := PreviousYearNo;
            FilteredContractRec."BLRRevenue Start Date" := DMY2Date(1, PreviousMonthNo, PreviousYearNo);
            FilteredContractRec."BLRPosting Period" := FetchMonth.GetMonthName(PreviousMonthNo) + ' ' +
                Format(PreviousYearNo) + ' ' + '-' + ' ' + FetchMonth.GetMonthName(PreviousMonthNo) + ' ' + Format(PreviousYearNo);
            FilteredContractRec."BLROwner Name" := ContractRec."BLROwner's Name";
            FilteredContractRec.Insert();
        end;
    end;

    procedure HasPreviousMonthAllocationLine(
         ContractId: Integer;
         PreviousMonthNo: Integer;
         PreviousYearNo: Integer;
         MultiYearStartDate: Date;
         MultiYearEndDate: Date;
         FinalAnnualAmount: Decimal): Boolean
    var
        PrevAllocLine: Record "BLRRevenueAllocationSubGrid";
    begin
        PrevAllocLine.Reset();
        PrevAllocLine.SetRange("BLRContract Id", ContractId);
        PrevAllocLine.SetRange("BLRPosting Month", PreviousMonthNo);
        PrevAllocLine.SetRange("BLRPosting Year", PreviousYearNo);
        PrevAllocLine.SetRange("BLRMulti Year Start Date", MultiYearStartDate);
        PrevAllocLine.SetRange("BLRMulti Year End Date", MultiYearEndDate);
        PrevAllocLine.SetRange("BLRFinal Annual Amount", FinalAnnualAmount);
        if not PrevAllocLine.IsEmpty() then
            exit(true);
        exit(false);
    end;
    //---------------Fetch Contracts--------------//

    // Then modify the FetchContracts procedure to use this
    procedure FetchContracts(RevenueMethod: Option "","Fixed Monthly Rent","Per Day Rent")
    var
        ContractRec: Record "BLRTenancyContract";                     // Main contract record
        SuspensionRec: Record "BLRSuspendReasonTable";                   // Suspension information
        FinalCalculationRec: Record "BLRFinalCalculation";            // Final calculation data

        // Rent type record variables
        SingleUnitRent: Record "BLRTCSingleUnitRentSubPage";        // Single unit rent records
        MultiUnitRent: Record "BLRTCSingleLumAnnualAmntSP";         // Multi unit rent records
        MergedSingleRent: Record "BLRTCMergeSameSqureSubPage";      // Merged single rent records
        MergedMultiRent: Record "BLRTCMergeDifferentSqSubPage";     // Merged multi rent records
        SpecialRent: Record "BLRTCMergeLumAnnualAmountSP";          // Special rent records

        // Date and calculation variables
        SelectedMonthStart: Date;
        SelectedMonthEnd: Date;
        Revenuestartdate: Date;                                       // First day of selected month                                  // Last day of selected month
        MonthNo: Integer;                                           // Selected month number
        FinancialYear: Integer;                                     // Line number for allocations
        TerminationDate: Date;                                      // Contract termination date
        SuspensionDate: Date;
        ShouldProcessContract: Boolean;
    // Flag to determine if contract should be processed
    begin
        // Clear any existing allocation data before processing
        ClearSubgridData();

        // Get month and year from current record
        MonthNo := Rec."BLRMonth";
        FinancialYear := Rec."BLRFinancial Year";
        Revenuestartdate := DMY2Date(1, Rec."BLRMonth", Rec."BLRFinancial Year");


        // Calculate date range for the selected month
        SelectedMonthStart := DMY2Date(01, MonthNo, FinancialYear);
        SelectedMonthEnd := CALCDATE('<+1M-1D>', SelectedMonthStart);

        // Filter contracts to include both Active and Terminated contracts
        ContractRec.SetFilter(ContractRec."BLRTenant Contract Status", '%1|%2|%3',
            ContractRec."BLRTenant Contract Status"::Active,
            ContractRec."BLRTenant Contract Status"::Terminated,
            ContractRec."BLRTenant Contract Status"::Suspended);

        if ContractRec.FindSet() then
            repeat
                // Flag to determine if contract should be processed
                TerminationDate := 0D;
                SuspensionDate := 0D;
                ShouldProcessContract := false;

                // Get termination date from Final Calculation table first
                FinalCalculationRec.Reset();
                FinalCalculationRec.SetRange("BLRContract ID", ContractRec."BLRContract ID");
                if FinalCalculationRec.FindFirst() then
                    TerminationDate := FinalCalculationRec."BLRTermination Date"
                else
                    TerminationDate := 0D;

                // Get Suspension Start Date - FIXED: Better error handling
                SuspensionRec.Reset();
                SuspensionRec.SetRange("BLRContract ID", ContractRec."BLRContract ID");
                if SuspensionRec.FindFirst() then
                    SuspensionDate := SuspensionRec."BLRDateEffective"
                else
                    SuspensionDate := 0D;  // Explicitly set to 0D if not found

                // Check contract status and decide if it should be processed
                case ContractRec."BLRTenant Contract Status" of
                    ContractRec."BLRTenant Contract Status"::Active:
                        ShouldProcessContract := true;

                    ContractRec."BLRTenant Contract Status"::Terminated:
                        if (TerminationDate >= SelectedMonthStart) then
                            ShouldProcessContract := true;

                    ContractRec."BLRTenant Contract Status"::Suspended:
                        // FIXED: Added null date check and improved logic
                        if (SuspensionDate <> 0D) and
                           (SuspensionDate >= SelectedMonthStart) then
                            ShouldProcessContract := true;
                end;

                // Process contract only if it meets the criteria
                if ShouldProcessContract then
                    if ((ContractRec."BLRContract Start Date" <= SelectedMonthEnd) and
                        (ContractRec."BLRContract End Date" >= SelectedMonthStart)) then begin

                        // Handle missed allocation from previous month (if contract started mid-month)
                        HandleMissedAllocation(ContractRec, MonthNo, FinancialYear, RevenueMethod);

                        // Handle suspension recovery allocation (new functionality)
                        HandleSuspensionRecoveryAllocation(ContractRec, MonthNo, FinancialYear, RevenueMethod, Revenuestartdate);

                        // Process Single Unit Rent records
                        SingleUnitRent.Reset();
                        SingleUnitRent.SetRange("BLRContract Id", ContractRec."BLRContract ID");
                        if SingleUnitRent.FindSet() then
                            repeat
                                // Create allocation line for this Single Unit Rent record
                                InsertAllocationLine(
                                    ContractRec,
                                    SingleUnitRent."BLRStart Date",
                                    SingleUnitRent."BLREnd Date",
                                    SingleUnitRent."BLRNumber of Days",
                                    SingleUnitRent."BLRPer Day Rent",
                                    SingleUnitRent."BLRFinal Annual Amount",
                                    SingleUnitRent."BLRFinal Annual Amount",
                                    TerminationDate,
                                    // Use sequential number
                                    MonthNo,
                                    FinancialYear,
                                    RevenueMethod, Revenuestartdate);
                            // LineNo += 1;  // Increment by 1
                            until SingleUnitRent.Next() = 0;


                        // Check Multi Unit Rent grid
                        MultiUnitRent.Reset();
                        MultiUnitRent.SetRange("BLRContract Id", ContractRec."BLRContract ID");
                        if MultiUnitRent.FindSet() then
                            repeat
                                // Create allocation line for this Multi Unit Rent record
                                InsertAllocationLine(
                                    ContractRec,
                                    MultiUnitRent."BLRSL_Start Date",
                                    MultiUnitRent."BLRSL_End Date",
                                    MultiUnitRent."BLRSL_Number of Days",
                                    MultiUnitRent."BLRSL_Per Day Rent",
                                    MultiUnitRent."BLRSL_Final Annual Amount",
                                    MultiUnitRent."BLRSL_Final Annual Amount",
                                    TerminationDate,
                                    // Use sequential number
                                    MonthNo,
                                    FinancialYear,
                                    RevenueMethod, Revenuestartdate);
                            // LineNo += 1;  // Increment by 1
                            until MultiUnitRent.Next() = 0;


                        // Check Merged Single Rent grid
                        MergedSingleRent.Reset();
                        MergedSingleRent.SetRange("BLRContract Id", ContractRec."BLRContract ID");
                        if MergedSingleRent.FindSet() then
                            repeat
                                // Create allocation line for this Merged Single Rent record
                                InsertAllocationLine(
                                    ContractRec,
                                    MergedSingleRent."BLRMS_Start Date",
                                    MergedSingleRent."BLRMS_End Date",
                                    MergedSingleRent."BLRMS_Number of Days",
                                    MergedSingleRent."BLRMS_Per Day Rent",
                                    MergedSingleRent."BLRMS_Final Annual Amount",
                                    MergedSingleRent."BLRMS_Final Annual Amount",
                                    TerminationDate,
                                    // Use sequential number
                                    MonthNo,
                                    FinancialYear,
                                    RevenueMethod, Revenuestartdate);
                            // LineNo += 1;  // Increment by 1
                            until MergedSingleRent.Next() = 0;


                        // Check Merged Multi Rent grid
                        MergedMultiRent.Reset();
                        MergedMultiRent.SetRange("BLRContract Id", ContractRec."BLRContract ID");
                        if MergedMultiRent.FindSet() then
                            repeat
                                // Create allocation line for this Merged Multi Rent record
                                InsertAllocationLine(
                                    ContractRec,
                                    MergedMultiRent."BLRMD_Start Date",
                                    MergedMultiRent."BLRMD_End Date",
                                    MergedMultiRent."BLRMD_Number of Days",
                                    MergedMultiRent."BLRMD_Per Day Rent",
                                    MergedMultiRent."BLRMD_Final Annual Amount",
                                    MergedMultiRent."BLRMD_Final Annual Amount",
                                    TerminationDate,
                                    // Use sequential number
                                    MonthNo,
                                    FinancialYear,
                                    RevenueMethod, Revenuestartdate);
                            // LineNo += 1;  // Increment by 1
                            until MergedMultiRent.Next() = 0;


                        // Check Special Rent grid
                        SpecialRent.Reset();
                        SpecialRent.SetRange("BLRContract Id", ContractRec."BLRContract ID");
                        if SpecialRent.FindSet() then
                            repeat
                                // Create allocation line for this Special Rent record
                                InsertAllocationLine(
                                    ContractRec,
                                    SpecialRent."BLRML_Start Date",
                                    SpecialRent."BLRML_End Date",
                                    SpecialRent."BLRML_Number of Days",
                                    SpecialRent."BLRML_Per Day Rent",
                                    SpecialRent."BLRML_Final Annual Amount",
                                    SpecialRent."BLRML_Final Annual Amount",
                                    TerminationDate,
                                    // Use sequential number
                                    MonthNo,
                                    FinancialYear,
                                    RevenueMethod, Revenuestartdate);
                            // LineNo += 1;  // Increment by 1
                            until SpecialRent.Next() = 0;

                        ProcessCreditNoteEntries(SelectedMonthStart, SelectedMonthEnd, MonthNo, FinancialYear, RevenueMethod, Revenuestartdate, ContractRec);
                    end;

            until ContractRec.Next() = 0;



        CalculateTotals();
    end;


    // New procedure to process credit note entries with debugging
    procedure ProcessCreditNoteEntries(SelectedMonthStart: Date;
        SelectedMonthEnd: Date;
        MonthNo: Integer;
        FinancialYear: Integer;
        RevenueMethod: Option "","Fixed Monthly Rent","Per Day Rent"; Revenuestartdate: Date; ContractRec: Record "BLRTenancyContract")
    var
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        PaymentScheduleRec: Record "BLRPaymentSchedule2";
        FilteredContractRec: Record "BLRRevenueAllocationSubGrid";
        SuspensionRec: Record "BLRSuspendReasonTable";
        NewLineNo: Integer;
        CalculatedDays: Integer;
        MultiYearStartDate: Date;
        MultiYearEndDate: Date;
        TotalCreditNote: Decimal;
        PerDayRentWithoutGrace: Decimal;
        TotalContractDays: Integer;
        CalculatedDaysTemp: Integer;
        SelectedMonthStartTemp: Date;
        SelectedMonthEndTemp: Date;
        CurrentYear: Integer;
        CurrentMonth: Integer;
        StartMonth: Integer;
        StartYear: Integer;
        EndMonth: Integer;
        EndYear: Integer;
    begin
        // Debug: Check if credit note table has records
        SalesCrMemoHeader.Reset();
        SalesCrMemoHeader.SetRange("BLRContract ID", ContractRec."BLRContract ID");
        SalesCrMemoHeader.SetRange("Posting Date", 0D, SelectedMonthEnd);
        if SalesCrMemoHeader.FindSet() then
            repeat
                if SalesCrMemoHeader."Applies-to Doc. Type" = SalesCrMemoHeader."Applies-to Doc. Type"::Invoice then begin
                    SalesInvoiceHeader.Get(SalesCrMemoHeader."Applies-to Doc. No.");
                    // Find payment schedule
                    PaymentScheduleRec.Reset();
                    PaymentScheduleRec.SetRange("BLRContract ID", ContractRec."BLRContract ID");
                    PaymentScheduleRec.SetRange("BLRSecondary Item Type", 'Rent');
                    PaymentScheduleRec.SetRange("BLRInvoice ID", SalesInvoiceHeader."No.");
                    if PaymentScheduleRec.FindFirst() then begin
                        MultiYearStartDate := PaymentScheduleRec."BLRInstallment Start Date";
                        MultiYearEndDate := PaymentScheduleRec."BLRInstallment End Date";
                        // Check if allocation month is within installment
                        if (MultiYearStartDate <= SelectedMonthEnd) and (MultiYearEndDate >= SelectedMonthStart) then begin
                            // TotalCreditNote := SalesCrMemoHeader."Amount Including VAT";
                            TotalCreditNote := PaymentScheduleRec."BLRAmount";
                            TotalContractDays := MultiYearEndDate - MultiYearStartDate + 1;
                            PerDayRentWithoutGrace := Round(-TotalCreditNote / TotalContractDays);
                            // If credit note posted in current allocation month, add all months up to allocation month
                            if (SalesCrMemoHeader."Posting Date" >= SelectedMonthStart) and (SalesCrMemoHeader."Posting Date" <= SelectedMonthEnd) then begin
                                // Loop through each month of the installment, up to the allocation month
                                StartMonth := Date2DMY(MultiYearStartDate, 2);
                                StartYear := Date2DMY(MultiYearStartDate, 3);
                                EndMonth := Date2DMY(MultiYearEndDate, 2);
                                EndYear := Date2DMY(MultiYearEndDate, 3);
                                // Limit to allocation month
                                if (EndYear > FinancialYear) or ((EndYear = FinancialYear) and (EndMonth > MonthNo)) then begin
                                    EndYear := FinancialYear;
                                    EndMonth := MonthNo;
                                end;
                                CurrentYear := StartYear;
                                CurrentMonth := StartMonth;
                                while (CurrentYear < EndYear) or ((CurrentYear = EndYear) and (CurrentMonth <= EndMonth)) do begin
                                    SelectedMonthStartTemp := DMY2Date(1, CurrentMonth, CurrentYear);
                                    SelectedMonthEndTemp := CALCDATE('<CM>', SelectedMonthStartTemp);
                                    CalculatedDaysTemp := CalculateDaysInSelectedMonth(ContractRec."BLRContract Start Date", ContractRec."BLRContract End Date", MultiYearStartDate, MultiYearEndDate, CurrentMonth, CurrentYear);
                                    if CalculatedDaysTemp > 0 then begin
                                        NewLineNo := GetNextLineNo();
                                        FilteredContractRec.Init();
                                        FilteredContractRec."BLRLine No." := NewLineNo;
                                        FilteredContractRec."BLRHeader No." := Rec."BLRNo.";
                                        // Fill fields from ContractRec
                                        FilteredContractRec."BLRProperty Name" := ContractRec."BLRProperty Name";
                                        FilteredContractRec."BLRContract Id" := ContractRec."BLRContract ID";
                                        FilteredContractRec."BLRContract Tenure" := ContractRec."BLRContract Tenor";
                                        FilteredContractRec."BLRUnit Type" := ContractRec."BLRUsage Type";
                                        FilteredContractRec."BLRCustomer Name" := ContractRec."BLRCustomer Name";
                                        FilteredContractRec."BLRContract Start Date" := ContractRec."BLRContract Start Date";
                                        FilteredContractRec."BLRContract End Date" := ContractRec."BLRContract End Date";
                                        FilteredContractRec."BLRGrace Days" := ContractRec."BLRGrace Period";
                                        FilteredContractRec."BLRGrace Start Date" := ContractRec."BLRGrace Start Date";
                                        FilteredContractRec."BLRGrace End Date" := ContractRec."BLRGrace End Date";
                                        case ContractRec."BLRPraposal Type Selected" of
                                            ContractRec."BLRPraposal Type Selected"::"Single Unit":
                                                FilteredContractRec."BLRSingle Unit Names" := ContractRec."BLRUnit Name";
                                            ContractRec."BLRPraposal Type Selected"::"Merge Unit":
                                                FilteredContractRec."BLRSingle Unit Names" := ContractRec."BLRSingle Unit Name";
                                            else
                                                FilteredContractRec."BLRSingle Unit Names" := '';
                                        end;
                                        FilteredContractRec."BLRTermination Date" := 0D;
                                        SuspensionRec.Reset();
                                        SuspensionRec.SetRange("BLRContract ID", ContractRec."BLRContract ID");
                                        if SuspensionRec.FindFirst() then begin
                                            FilteredContractRec."BLRSuspension Start Date" := SuspensionRec."BLRDateEffective";
                                            FilteredContractRec."BLRSuspension End Date" := SuspensionRec."BLRSuspensionEndDate";
                                        end;
                                        FilteredContractRec."BLRMulti Year Start Date" := MultiYearStartDate;
                                        FilteredContractRec."BLRMulti Year End Date" := MultiYearEndDate;
                                        FilteredContractRec."BLRNo Of Days" := CalculatedDaysTemp;
                                        FilteredContractRec."BLRPosting Month" := CurrentMonth;
                                        FilteredContractRec."BLRPosting Year" := CurrentYear;
                                        FilteredContractRec."BLRPosting Period" := Format(FilteredContractRec."BLRPosting Month") +
                                            ' ' + Format(FilteredContractRec."BLRPosting Year") + ' ' + '-' + ' ' +
                                            Format(FilteredContractRec."BLRPosting Month") + ' ' + Format(FilteredContractRec."BLRPosting Year");
                                        FilteredContractRec."BLROwner Name" := ContractRec."BLROwner's Name";
                                        FilteredContractRec."BLRContract Amount" := ContractRec."BLRAnnual Rent Amount";
                                        FilteredContractRec."BLRAnnual Amount" := -TotalCreditNote;
                                        FilteredContractRec."BLRFinal Annual Amount" := -TotalCreditNote;
                                        FilteredContractRec."BLRRevenue Start Date" := Revenuestartdate;
                                        if RevenueMethod = RevenueMethod::"Per Day Rent" then begin
                                            FilteredContractRec."BLRPer Day Rent" := PerDayRentWithoutGrace;
                                            FilteredContractRec."BLRTotal Value" := FilteredContractRec."BLRPer Day Rent" * CalculatedDaysTemp;
                                            FilteredContractRec."BLROwner Share" := FilteredContractRec."BLRTotal Value";
                                        end
                                        else begin
                                            FilteredContractRec."BLRPer Month Rent" := CalculatePerMonthRent(FilteredContractRec."BLRFinal Annual Amount", CalculatedDaysTemp, CurrentMonth, CurrentYear, ContractRec, MultiYearStartDate, MultiYearEndDate); // Use the per day rent passed from the grid
                                            FilteredContractRec."BLRTotal Value" := FilteredContractRec."BLRPer Month Rent";
                                            FilteredContractRec."BLROwner Share" := FilteredContractRec."BLRPer Month Rent";
                                        end;
                                        FilteredContractRec."BLRDescription" := 'Credit Note';
                                        FilteredContractRec.Insert();
                                    end;
                                    // Move to next month
                                    if CurrentMonth = 12 then begin
                                        CurrentMonth := 1;
                                        CurrentYear += 1;
                                    end else
                                        CurrentMonth += 1;
                                end;
                            end else begin
                                // For credit notes posted before allocation month, add only the current allocation month
                                CalculatedDays := CalculateDaysInSelectedMonth(ContractRec."BLRContract Start Date", ContractRec."BLRContract End Date", MultiYearStartDate, MultiYearEndDate, MonthNo, FinancialYear);
                                if CalculatedDays > 0 then begin
                                    NewLineNo := GetNextLineNo();
                                    FilteredContractRec.Init();
                                    FilteredContractRec."BLRLine No." := NewLineNo;
                                    FilteredContractRec."BLRHeader No." := Rec."BLRNo.";
                                    // Fill fields from ContractRec
                                    FilteredContractRec."BLRProperty Name" := ContractRec."BLRProperty Name";
                                    FilteredContractRec."BLRContract Id" := ContractRec."BLRContract ID";
                                    FilteredContractRec."BLRContract Tenure" := ContractRec."BLRContract Tenor";
                                    FilteredContractRec."BLRUnit Type" := ContractRec."BLRUsage Type";
                                    FilteredContractRec."BLRCustomer Name" := ContractRec."BLRCustomer Name";
                                    FilteredContractRec."BLRContract Start Date" := ContractRec."BLRContract Start Date";
                                    FilteredContractRec."BLRContract End Date" := ContractRec."BLRContract End Date";
                                    FilteredContractRec."BLRGrace Days" := ContractRec."BLRGrace Period";
                                    FilteredContractRec."BLRGrace Start Date" := ContractRec."BLRGrace Start Date";
                                    FilteredContractRec."BLRGrace End Date" := ContractRec."BLRGrace End Date";
                                    case ContractRec."BLRPraposal Type Selected" of
                                        ContractRec."BLRPraposal Type Selected"::"Single Unit":
                                            FilteredContractRec."BLRSingle Unit Names" := ContractRec."BLRUnit Name";
                                        ContractRec."BLRPraposal Type Selected"::"Merge Unit":
                                            FilteredContractRec."BLRSingle Unit Names" := ContractRec."BLRSingle Unit Name";
                                        else
                                            FilteredContractRec."BLRSingle Unit Names" := '';
                                    end;
                                    FilteredContractRec."BLRTermination Date" := 0D;
                                    SuspensionRec.Reset();
                                    SuspensionRec.SetRange("BLRContract ID", ContractRec."BLRContract ID");
                                    if SuspensionRec.FindFirst() then begin
                                        FilteredContractRec."BLRSuspension Start Date" := SuspensionRec."BLRDateEffective";
                                        FilteredContractRec."BLRSuspension End Date" := SuspensionRec."BLRSuspensionEndDate";
                                    end;
                                    FilteredContractRec."BLRMulti Year Start Date" := MultiYearStartDate;
                                    FilteredContractRec."BLRMulti Year End Date" := MultiYearEndDate;
                                    FilteredContractRec."BLRNo Of Days" := CalculatedDays;
                                    FilteredContractRec."BLRPosting Month" := MonthNo;
                                    FilteredContractRec."BLRPosting Year" := FinancialYear;
                                    FilteredContractRec."BLRPosting Period" := Format(FilteredContractRec."BLRPosting Month") +
                                        ' ' + Format(FilteredContractRec."BLRPosting Year") + ' ' + '-' + ' ' +
                                        Format(FilteredContractRec."BLRPosting Month") + ' ' + Format(FilteredContractRec."BLRPosting Year");
                                    FilteredContractRec."BLROwner Name" := ContractRec."BLROwner's Name";
                                    FilteredContractRec."BLRContract Amount" := ContractRec."BLRAnnual Rent Amount";
                                    FilteredContractRec."BLRAnnual Amount" := -TotalCreditNote;
                                    FilteredContractRec."BLRFinal Annual Amount" := -TotalCreditNote;
                                    FilteredContractRec."BLRRevenue Start Date" := Revenuestartdate;
                                    if RevenueMethod = RevenueMethod::"Per Day Rent" then begin
                                        FilteredContractRec."BLRPer Day Rent" := PerDayRentWithoutGrace;
                                        FilteredContractRec."BLRTotal Value" := FilteredContractRec."BLRPer Day Rent" * CalculatedDays;
                                        FilteredContractRec."BLROwner Share" := FilteredContractRec."BLRTotal Value";
                                    end
                                    else begin
                                        FilteredContractRec."BLRPer Month Rent" := CalculatePerMonthRent(FilteredContractRec."BLRFinal Annual Amount", CalculatedDays, MonthNo, FinancialYear, ContractRec, MultiYearStartDate, MultiYearEndDate); // Use the per day rent passed from the grid
                                        FilteredContractRec."BLRTotal Value" := FilteredContractRec."BLRPer Month Rent";
                                        FilteredContractRec."BLROwner Share" := FilteredContractRec."BLRPer Month Rent";
                                    end;
                                    FilteredContractRec."BLRDescription" := 'Credit Note';
                                    FilteredContractRec.Insert();
                                end;
                            end;
                        end;
                    end;
                end;
            until SalesCrMemoHeader.Next() = 0;
    end;

    procedure HandleSuspensionRecoveryAllocation(
    ContractRec: Record "BLRTenancyContract";
    MonthNo: Integer;
    FinancialYear: Integer;
    RevenueMethod: Option "","Fixed Monthly Rent","Per Day Rent"; Revenuestartdate: Date)
    var
        SuspensionRec: Record "BLRSuspendReasonTable";
        SingleUnitRent: Record "BLRTCSingleUnitRentSubPage";
        MultiUnitRent: Record "BLRTCSingleLumAnnualAmntSP";
        MergedSingleRent: Record "BLRTCMergeSameSqureSubPage";
        MergedMultiRent: Record "BLRTCMergeDifferentSqSubPage";
        SpecialRent: Record "BLRTCMergeLumAnnualAmountSP";
        FinalCalculationRec: Record "BLRFinalCalculation";
        CurrentMonthStart: Date;
        CurrentMonthEnd: Date;
        SuspensionStartDate: Date;
        SuspensionEndDate: Date;
        RecoveryStartDate: Date;
        RecoveryEndDate: Date;
        TerminationDate: Date;
    begin
        CurrentMonthStart := DMY2Date(1, MonthNo, FinancialYear);
        CurrentMonthEnd := CALCDATE('<CM>', CurrentMonthStart);

        SuspensionRec.Reset();
        SuspensionRec.SetRange("BLRContract ID", ContractRec."BLRContract ID");

        if SuspensionRec.FindFirst() then begin
            SuspensionStartDate := SuspensionRec."BLRDateEffective";
            SuspensionEndDate := SuspensionRec."BLRSuspensionEndDate";

            if (SuspensionStartDate <> 0D) and (SuspensionEndDate <> 0D) and
              (((SuspensionEndDate >= CurrentMonthStart) and (SuspensionEndDate < CurrentMonthEnd)) OR
                (SuspensionEndDate = CurrentMonthStart - 1)) then begin

                RecoveryStartDate := SuspensionStartDate;
                RecoveryEndDate := SuspensionEndDate;

                FinalCalculationRec.Reset();
                FinalCalculationRec.SetRange("BLRContract ID", ContractRec."BLRContract ID");
                if FinalCalculationRec.FindFirst() then
                    TerminationDate := FinalCalculationRec."BLRTermination Date"
                else
                    TerminationDate := 0D;

                SingleUnitRent.Reset();
                SingleUnitRent.SetRange("BLRContract Id", ContractRec."BLRContract ID");
                if SingleUnitRent.FindSet() then
                    repeat
                        if (SingleUnitRent."BLRStart Date" <= RecoveryEndDate) and (SingleUnitRent."BLREnd Date" >= RecoveryStartDate) then
                            InsertSuspensionRecoveryLine(
                                ContractRec,
                                SingleUnitRent."BLRStart Date",
                                SingleUnitRent."BLREnd Date",
                                SingleUnitRent."BLRNumber of Days",
                                SingleUnitRent."BLRPer Day Rent",
                                SingleUnitRent."BLRFinal Annual Amount",
                                SingleUnitRent."BLRFinal Annual Amount",
                                TerminationDate,
                                MonthNo,
                                FinancialYear,
                                RecoveryStartDate,
                                RecoveryEndDate,
                                'Single Unit Rent Recovery',
                                RevenueMethod, Revenuestartdate);

                    until SingleUnitRent.Next() = 0;

                MultiUnitRent.Reset();
                MultiUnitRent.SetRange("BLRContract Id", ContractRec."BLRContract ID");
                if MultiUnitRent.FindSet() then
                    repeat
                        if (MultiUnitRent."BLRSL_Start Date" <= RecoveryEndDate) and (MultiUnitRent."BLRSL_End Date" >= RecoveryStartDate) then
                            InsertSuspensionRecoveryLine(
                                ContractRec,
                                MultiUnitRent."BLRSL_Start Date",
                                MultiUnitRent."BLRSL_End Date",
                                MultiUnitRent."BLRSL_Number of Days",
                                MultiUnitRent."BLRSL_Per Day Rent",
                                MultiUnitRent."BLRSL_Final Annual Amount",
                                MultiUnitRent."BLRSL_Final Annual Amount",
                                TerminationDate,
                                MonthNo,
                                FinancialYear,
                                RecoveryStartDate,
                                RecoveryEndDate,
                                'Multi Unit Rent Recovery',
                                RevenueMethod, Revenuestartdate);

                    until MultiUnitRent.Next() = 0;

                MergedSingleRent.Reset();
                MergedSingleRent.SetRange("BLRContract Id", ContractRec."BLRContract ID");
                if MergedSingleRent.FindSet() then
                    repeat
                        if (MergedSingleRent."BLRMS_Start Date" <= RecoveryEndDate) and (MergedSingleRent."BLRMS_End Date" >= RecoveryStartDate) then
                            InsertSuspensionRecoveryLine(
                                ContractRec,
                                MergedSingleRent."BLRMS_Start Date",
                                MergedSingleRent."BLRMS_End Date",
                                MergedSingleRent."BLRMS_Number of Days",
                                MergedSingleRent."BLRMS_Per Day Rent",
                                MergedSingleRent."BLRMS_Final Annual Amount",
                                MergedSingleRent."BLRMS_Final Annual Amount",
                                TerminationDate,
                                MonthNo,
                                FinancialYear,
                                RecoveryStartDate,
                                RecoveryEndDate,
                                'Merged Single Rent Recovery',
                                RevenueMethod, Revenuestartdate);

                    until MergedSingleRent.Next() = 0;

                MergedMultiRent.Reset();
                MergedMultiRent.SetRange("BLRContract Id", ContractRec."BLRContract ID");
                if MergedMultiRent.FindSet() then
                    repeat
                        if (MergedMultiRent."BLRMD_Start Date" <= RecoveryEndDate) and (MergedMultiRent."BLRMD_End Date" >= RecoveryStartDate) then
                            InsertSuspensionRecoveryLine(
                                ContractRec,
                                MergedMultiRent."BLRMD_Start Date",
                                MergedMultiRent."BLRMD_End Date",
                                MergedMultiRent."BLRMD_Number of Days",
                                MergedMultiRent."BLRMD_Per Day Rent",
                                MergedMultiRent."BLRMD_Final Annual Amount",
                                MergedMultiRent."BLRMD_Final Annual Amount",
                                TerminationDate,
                                MonthNo,
                                FinancialYear,
                                RecoveryStartDate,
                                RecoveryEndDate,
                                'Merged Multi Rent Recovery',
                                RevenueMethod, Revenuestartdate);

                    until MergedMultiRent.Next() = 0;

                SpecialRent.Reset();
                SpecialRent.SetRange("BLRContract Id", ContractRec."BLRContract ID");
                if SpecialRent.FindSet() then
                    repeat
                        if (SpecialRent."BLRML_Start Date" <= RecoveryEndDate) and (SpecialRent."BLRML_End Date" >= RecoveryStartDate) then
                            InsertSuspensionRecoveryLine(
                                ContractRec,
                                SpecialRent."BLRML_Start Date",
                                SpecialRent."BLRML_End Date",
                                SpecialRent."BLRML_Number of Days",
                                SpecialRent."BLRML_Per Day Rent",
                                SpecialRent."BLRML_Final Annual Amount",
                                SpecialRent."BLRML_Final Annual Amount",
                                TerminationDate,
                                MonthNo,
                                FinancialYear,
                                RecoveryStartDate,
                                RecoveryEndDate,
                                'Special Rent Recovery',
                                RevenueMethod, Revenuestartdate);

                    until SpecialRent.Next() = 0;
            end;
        end;
    end;

    procedure InsertSuspensionRecoveryLine(
    ContractRec: Record "BLRTenancyContract";
    MultiYearStartDate: Date;
    MultiYearEndDate: Date;
    NoOfDays: Integer;
    PerDayRent: Decimal;
    pTotalAnnualAmount: Decimal;
    OwnerShareAmount: Decimal;
    TerminationDate: Date;
    MonthNo: Integer;
    FinancialYear: Integer;
    RecoveryStartDate: Date;
    RecoveryEndDate: Date;
    RecoveryType: Text;
    RevenueMethod: Option "","Fixed Monthly Rent","Per Day Rent"; Revenuestartdate: Date)
    var
        FilteredContractRec: Record "BLRRevenueAllocationSubGrid";
        SuspensionRec: Record "BLRSuspendReasonTable";
        TotalContractDays: Integer;
        PerDayRentWithoutGracePeriod: Decimal;
        CalculatedRecoveryDays: Integer;
        NewLineNo: Integer;
        GridAnnualAmount: Decimal;
        RecoveryAmount: Decimal;
        EffectiveStartDate: Date;
        EffectiveEndDate: Date;
    begin
        NewLineNo := GetNextLineNo();
        GridAnnualAmount := pTotalAnnualAmount;

        EffectiveStartDate := RecoveryStartDate;
        if MultiYearStartDate > EffectiveStartDate then
            EffectiveStartDate := MultiYearStartDate;

        EffectiveEndDate := RecoveryEndDate;
        if MultiYearEndDate < EffectiveEndDate then
            EffectiveEndDate := MultiYearEndDate;

        if EffectiveStartDate <= EffectiveEndDate then
            CalculatedRecoveryDays := EffectiveEndDate - EffectiveStartDate + 1
        else
            CalculatedRecoveryDays := 0;

        TotalContractDays := MultiYearEndDate - MultiYearStartDate + 1;

        PerDayRentWithoutGracePeriod := (GridAnnualAmount / TotalContractDays);

        if CalculatedRecoveryDays > 0 then begin
            RecoveryAmount := CalculatedRecoveryDays * PerDayRent;

            FilteredContractRec.Init();
            FilteredContractRec."BLRLine No." := NewLineNo;
            FilteredContractRec."BLRHeader No." := Rec."BLRNo.";
            FilteredContractRec."BLRProperty Name" := ContractRec."BLRProperty Name";
            FilteredContractRec."BLRContract Id" := ContractRec."BLRContract ID";
            FilteredContractRec."BLRContract Tenure" := ContractRec."BLRContract Tenor";
            FilteredContractRec."BLRCustomer Name" := ContractRec."BLRCustomer Name";
            FilteredContractRec."BLRContract Start Date" := ContractRec."BLRContract Start Date";
            FilteredContractRec."BLRContract End Date" := ContractRec."BLRContract End Date";
            FilteredContractRec."BLRGrace Days" := ContractRec."BLRGrace Period";
            FilteredContractRec."BLRGrace Start Date" := ContractRec."BLRGrace Start Date";
            FilteredContractRec."BLRGrace End Date" := ContractRec."BLRGrace End Date";
            FilteredContractRec."BLRUnit Type" := ContractRec."BLRUsage Type";

            case
            ContractRec."BLRPraposal Type Selected" of
                ContractRec."BLRPraposal Type Selected"::"Single Unit":
                    FilteredContractRec."BLRSingle Unit Names" := ContractRec."BLRUnit Name";
                ContractRec."BLRPraposal Type Selected"::"Merge Unit":
                    FilteredContractRec."BLRSingle Unit Names" := ContractRec."BLRSingle Unit Name";
                else
                    FilteredContractRec."BLRSingle Unit Names" := '';
            end;

            if TerminationDate = 0D then
                FilteredContractRec."BLRTermination Date" := 0D
            else
                FilteredContractRec."BLRTermination Date" := TerminationDate;

            SuspensionRec.Reset();
            SuspensionRec.SetRange("BLRContract ID", ContractRec."BLRContract ID");
            if SuspensionRec.FindFirst() then begin
                FilteredContractRec."BLRSuspension Start Date" := SuspensionRec."BLRDateEffective";
                FilteredContractRec."BLRSuspension End Date" := SuspensionRec."BLRSuspensionEndDate";
            end;

            FilteredContractRec."BLRMulti Year Start Date" := MultiYearStartDate;
            FilteredContractRec."BLRMulti Year End Date" := MultiYearEndDate;
            FilteredContractRec."BLRNo Of Days" := CalculatedRecoveryDays;
            FilteredContractRec."BLRContract Amount" := ContractRec."BLRAnnual Rent Amount";
            FilteredContractRec."BLRAnnual Amount" := GridAnnualAmount;
            FilteredContractRec."BLRFinal Annual Amount" := pTotalAnnualAmount;

            if RevenueMethod = RevenueMethod::"Per Day Rent" then begin
                FilteredContractRec."BLRPer Day Rent" := Round(PerDayRentWithoutGracePeriod);
                FilteredContractRec."BLRTotal Value" := FilteredContractRec."BLRPer Day Rent" * CalculatedRecoveryDays;
                FilteredContractRec."BLROwner Share" := FilteredContractRec."BLRPer Day Rent" * CalculatedRecoveryDays;
            end
            else begin
                FilteredContractRec."BLRPer Month Rent" := CalculatePerMonthRent(FilteredContractRec."BLRFinal Annual Amount", CalculatedRecoveryDays, Date2DMY(EffectiveEndDate, 2), Date2DMY(EffectiveEndDate, 3), ContractRec, MultiYearStartDate, MultiYearEndDate);
                FilteredContractRec."BLRTotal Value" := FilteredContractRec."BLRPer Month Rent";
                FilteredContractRec."BLROwner Share" := FilteredContractRec."BLRPer Month Rent";
            end;


            FilteredContractRec."BLRPosting Month" := MonthNo;
            FilteredContractRec."BLRPosting Year" := FinancialYear;
            FilteredContractRec."BLRRevenue Start Date" := Revenuestartdate;
            FilteredContractRec."BLRDescription" := 'Suspension';
            FilteredContractRec."BLRPosting Period" := 'Suspension Recovery - ' + Format(Date2DMY(EffectiveEndDate, 2)) + ' ' + Format(Date2DMY(EffectiveEndDate, 3));
            FilteredContractRec."BLROwner Name" := ContractRec."BLROwner's Name";

            FilteredContractRec.Insert();
        end;
    end;

    procedure CalculateAndStoreTotalRevenue()
    var
        revenueItemLine: Record "BLRRevenueRecognitionDetails";
        revenueAllocLine: Record "BLRRevenueAllocationSubGrid";
    begin
        Clear(totalcontractAmounts);
        Clear(totalamounts);

        revenueItemLine.SetRange("BLRRR_No.", Rec."BLRNo.");
        if revenueItemLine.FindSet() then
            repeat
                totalcontractAmounts += revenueItemLine."BLRContract Amount";
                totalamounts += revenueItemLine."BLRTotal Value";
                TotalAnnualAmounts += revenueItemLine."BLRAnnual Amount";
                TotalFinalAnnualAmounts += revenueItemLine."BLRFinal Annual Amount";



            until revenueItemLine.Next() = 0;


        revenueAllocLine.SetRange("BLRHeader No.", Rec."BLRNo.");
        if revenueAllocLine.FindSet() then
            repeat
                totalcontractAmountsss += revenueAllocLine."BLRContract Amount";
                totalamountsss += revenueAllocLine."BLRTotal Value";
                totalannualamountsss += revenueAllocLine."BLRAnnual Amount";
                totalfinalannualamountsss += revenueAllocLine."BLRFinal Annual Amount";
            until revenueAllocLine.Next() = 0;


        totalcombinecontractAmounts := totalcontractAmountsss + totalcontractAmounts;
        totalcombineamounts := totalamountsss + totalamounts;
        totalcombinefinalamount := TotalAnnualAmounts + totalannualamountsss;
        totalcombinefinalannualamount := TotalFinalAnnualAmounts + totalfinalannualamountsss;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        CalculateAndStoreTotalRevenue();
    end;

    procedure CalculatePerMonthRent(annualAmount: Decimal; CalculatedDays: Integer; MonthNo: Integer; FinancialYear: Integer; ContractRec: Record "BLRTenancyContract"; MultiYearStartDate: Date; MultiYearEndDate: Date): Decimal
    var
        revenuerecognition: Record "BLRRevenueRecognition";
        FetchMonth: Codeunit "BLRFetch Month";
        MonthlyBase: Decimal;
        MonthlyRate: Decimal;
        DaysInMonth: Integer;
        NumofMonths: Integer;
    begin
        NumofMonths := FetchMonth.GetNoOfMonths(MultiYearStartDate, MultiYearEndDate);

        if NumofMonths = 0 then
            NumofMonths := 1;

        DaysInMonth := revenuerecognition.GetDaysInMonthss(DMY2Date(1, MonthNo, FinancialYear));

        MonthlyBase := annualAmount / NumofMonths;

        MonthlyRate := Round((MonthlyBase / DaysInMonth) * CalculatedDays);

        exit(MonthlyRate);
    end;



    var
        totalcontractAmountsss: Decimal;
        totalamountsss: Decimal;
        totalannualamountsss: Decimal;
        totalfinalannualamountsss: Decimal;
        totalcontractAmounts: Decimal;
        totalamounts: Decimal;
        totalcombinecontractAmounts: Decimal;
        totalcombineamounts: Decimal;
        totalcombinefinalamount: Decimal;
        totalcombinefinalannualamount: Decimal;
        TotalAnnualAmounts: Decimal;
        TotalFinalAnnualAmounts: Decimal;

    trigger OnModifyRecord(): Boolean
    begin
        CurrPage."Revenue Recognition Item Details".Page.SetRIID(Rec."BLRNo.");
        CurrPage."Revenue Recognition Details".Page.SetRIID(Rec."BLRNo.");
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        CurrPage."Revenue Recognition Item Details".Page.SetRIID(Rec."BLRNo.");
        CurrPage."Revenue Recognition Details".Page.SetRIID(Rec."BLRNo.");
        CalculateAndStoreTotalRevenue();
    end;
}
