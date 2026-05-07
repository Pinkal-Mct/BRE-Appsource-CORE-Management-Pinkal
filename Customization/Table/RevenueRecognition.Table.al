table 73209675 "Revenue Recognition"
{
    DataClassification = CustomerContent;

    fields
    {

        field(73209575; "RR Id"; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
            Caption = 'RR Id';
        }

        field(73209576; "Contract ID"; Integer)
        {
            DataClassification = CustomerContent;
            TableRelation = "Tenancy Contract"."Contract ID";
            Caption = 'Contract ID';

            trigger OnValidate()
            var
                tenancyrec: Record "Tenancy Contract";
            begin
                tenancyrec.SetRange("Contract ID", Rec."Contract ID");
                if tenancyrec.FindFirst() then begin
                    "Tenant Id" := tenancyrec."Tenant Id";
                    "Start Date" := tenancyrec."Contract Start Date";
                    "End Date" := tenancyrec."Contract End Date";
                    "Contract Amount" := tenancyrec."Annual Rent Amount";

                end else begin
                    // Clear the field if no record is found
                    "Tenant Id" := '';
                    "Start Date" := 0D;
                    "End Date" := 0D;
                    "Contract Amount" := 0;
                end;

                CalculateMonthlyRevenue();

            end;
        }

        field(73209577; "Tenant Id"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant Id';
            TableRelation = "Lease Proposal Details"."Tenant ID";
            Editable = false; // Make it read-only for the user

        }
        field(73209578; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
        }
        field(73209579; "End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
        }

        field(73209580; "Contract Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Amount';
        }

    }

    keys
    {
        key(PK; "RR ID")
        {
            Clustered = true;
        }
    }

    local procedure CalculateMonthlyRevenue()
    var
        SubpageRec: Record "Revenue Recognition Subpage";

    begin
        SubpageRec.DeleteAll();

        // Detect which rent grid contains records
        if ProcessSingleUnit(Rec."Contract ID") then
            exit;

        if ProcessMultiUnit(Rec."Contract ID") then
            exit;

        if ProcessMergedSingleRent(Rec."Contract ID") then
            exit;

        if ProcessMergedMultiRent(Rec."Contract ID") then
            exit;

        ProcessSpecialRent(Rec."Contract ID");
    end;

    local procedure ProcessSingleUnit(ContractID: Integer): Boolean
    var
        SingleUnitRent: Record "TC Single Unit Rent SubPage";
    begin
        SingleUnitRent.SetRange("Contract ID", ContractID);

        if not SingleUnitRent.FindSet() then
            exit(false);

        repeat
            ProcessRentLine(
                SingleUnitRent."Start Date",
                SingleUnitRent."End Date",
                SingleUnitRent."Final Annual Amount");
        until SingleUnitRent.Next() = 0;

        exit(true);
    end;

    local procedure ProcessMultiUnit(ContractID: Integer): Boolean
    var
        MultiUnitRent: Record "TC Single LumAnnualAmnt SP";
    begin
        MultiUnitRent.SetRange("Contract ID", ContractID);

        if not MultiUnitRent.FindSet() then
            exit(false);

        repeat
            ProcessRentLine(
                MultiUnitRent."SL_Start Date",
                MultiUnitRent."SL_End Date",
                MultiUnitRent."SL_Final Annual Amount");
        until MultiUnitRent.Next() = 0;

        exit(true);
    end;

    local procedure ProcessMergedSingleRent(ContractID: Integer): Boolean
    var
        MergedSingleRent: Record "TC Merge SameSqure SubPage";
    begin
        MergedSingleRent.SetRange("Contract ID", ContractID);

        if not MergedSingleRent.FindSet() then
            exit(false);

        repeat
            ProcessRentLine(
                MergedSingleRent."MS_Start Date",
                MergedSingleRent."MS_End Date",
                MergedSingleRent."MS_Final Annual Amount");
        until MergedSingleRent.Next() = 0;

        exit(true);
    end;

    local procedure ProcessMergedMultiRent(ContractID: Integer): Boolean
    var
        MergedMultiRent: Record "TC Merge DifferentSq SubPage";
    begin
        MergedMultiRent.SetRange("Contract ID", ContractID);

        if not MergedMultiRent.FindSet() then
            exit(false);

        repeat
            ProcessRentLine(
                MergedMultiRent."MD_Start Date",
                MergedMultiRent."MD_End Date",
                MergedMultiRent."MD_Final Annual Amount");
        until MergedMultiRent.Next() = 0;

        exit(true);
    end;

    local procedure ProcessSpecialRent(ContractID: Integer): Boolean
    var
        SpecialRent: Record "TC Merge LumAnnualAmount SP";
    begin
        SpecialRent.SetRange("Contract ID", ContractID);

        if not SpecialRent.FindSet() then
            exit(false);

        repeat
            ProcessRentLine(
                SpecialRent."ML_Start Date",
                SpecialRent."ML_End Date",
                SpecialRent."ML_Final Annual Amount");
        until SpecialRent.Next() = 0;

        exit(true);
    end;

    local procedure ProcessRentLine(StartDate: Date; EndDate: Date; FinalAnnualAmount: Decimal)
    var
        SubpageRec: Record "Revenue Recognition Subpage";
        ExistingSubpageRec: Record "Revenue Recognition Subpage";
        TotalDays: Integer;
        DailyRate: Decimal;
        MonthDays: Integer;
        CurrentDate: Date;
        MonthlyRate: Decimal;
        FirstDayNextMonth: Date;
        LastDayOfMonth: Date;
        MonthlyRate2: Decimal;
        TotalMonths: Integer;
        ActualDaysInMonth: Integer;
        MonthText: Text[50];
    begin
        TotalDays := EndDate - StartDate + 1;
        if TotalDays <= 0 then
            exit;

        DailyRate := FinalAnnualAmount / TotalDays;

        TotalMonths := CalculateTotalMonths(StartDate, EndDate);

        MonthlyRate2 := FinalAnnualAmount / TotalMonths;

        CurrentDate := StartDate;

        while CurrentDate <= EndDate do begin

            if DATE2DMY(CurrentDate, 2) = 12 then
                FirstDayNextMonth := DMY2DATE(1, 1, DATE2DMY(CurrentDate, 3) + 1)
            else
                FirstDayNextMonth := DMY2DATE(1, DATE2DMY(CurrentDate, 2) + 1, DATE2DMY(CurrentDate, 3));
            LastDayOfMonth := FirstDayNextMonth - 1;

            if EndDate < LastDayOfMonth then
                MonthDays := EndDate - CurrentDate + 1
            else
                MonthDays := LastDayOfMonth - CurrentDate + 1;

            if CurrentDate = StartDate then
                if MonthDays > (EndDate - CurrentDate + 1) then
                    MonthDays := (EndDate - CurrentDate + 1);

            ActualDaysInMonth := GetDaysInMonth(CurrentDate, StartDate, EndDate);

            if MonthDays < ActualDaysInMonth then
                MonthlyRate := Round(MonthlyRate2 / ActualDaysInMonth * MonthDays)
            else
                MonthlyRate := MonthlyRate2;

            MonthText := FORMAT(CurrentDate, 0, '<Month Text>') + '-' + FORMAT(CurrentDate, 0, '<Year>');

            ExistingSubpageRec.SetRange("RR Id");
            ExistingSubpageRec.SetRange(Month, MonthText);
            if ExistingSubpageRec.FindFirst() then begin
                ExistingSubpageRec."No. of Days" += MonthDays;
                ExistingSubpageRec."RR - Method 1 (Day)" += (MonthDays * DailyRate);
                ExistingSubpageRec."RR - Method 2 (Month)" += MonthlyRate;
                ExistingSubpageRec.Modify();
            end
            else begin
                SubpageRec.Init();
                SubpageRec."RR Id" := Rec."RR Id";
                SubpageRec."Contract ID" := Rec."Contract ID";
                SubpageRec."Tenant Id" := Rec."Tenant Id";
                SubpageRec."Month" := MonthText;
                SubpageRec."No. of Days" := MonthDays;
                SubpageRec."RR - Method 1 (Day)" := (MonthDays * DailyRate);
                SubpageRec."RR - Method 2 (Month)" := MonthlyRate;
                SubpageRec.Insert();
                Clear(SubpageRec);
            end;
            CurrentDate := FirstDayNextMonth;
        end;
    end;



    local procedure IsLeapYear(Year: Integer): Boolean
    begin
        if (Year mod 4 = 0) and ((Year mod 100 <> 0) or (Year mod 400 = 0)) then
            exit(true);
        exit(false);
    end;

    local procedure CalculateTotalMonths(StartDate: Date; EndDate: Date) Result: Integer
    var
        StartYear, StartMonth : Integer;
        EndYear, EndMonth, EndDay : Integer;
        DaysInEndMonth: Integer;
        FirstDayOfNextMonth: Date;
    begin
        // Extract the year, month, and day from the start and end dates
        StartYear := DATE2DMY(StartDate, 3); // Year
        StartMonth := DATE2DMY(StartDate, 2); // Month
                                              // StartDay := DATE2DMY(StartDate, 1); // Day

        EndYear := DATE2DMY(EndDate, 3); // Year
        EndMonth := DATE2DMY(EndDate, 2); // Month
        EndDay := DATE2DMY(EndDate, 1); // Day

        // Calculate the difference in months
        Result := ((EndYear - StartYear) * 12) + (EndMonth - StartMonth);

        // Calculate the number of days in the end month
        if EndMonth = 12 then
            FirstDayOfNextMonth := DMY2DATE(1, 1, EndYear + 1) // January of the next year
        else
            FirstDayOfNextMonth := DMY2DATE(1, EndMonth + 1, EndYear); // First day of the next month

        DaysInEndMonth := FirstDayOfNextMonth - DMY2DATE(1, EndMonth, EndYear);

        // Check if EndDate includes the full final month
        // DaysInEndMonth := CALCDATE('<CM+1>', DMY2DATE(1, EndMonth, EndYear)) - DMY2DATE(1, EndMonth, EndYear);
        if EndDay = DaysInEndMonth then
            Result := Result + 1;
    end;

    procedure GetDaysInMonthss(CurrentDate: Date): Integer
    var
        Year: Integer;
        Month: Integer;
        IsLeap: Boolean;
    begin
        Year := DATE2DMY(CurrentDate, 3); // Extract Year from CurrentDate
        Month := DATE2DMY(CurrentDate, 2); // Extract Month from CurrentDate
        IsLeap := IsLeapYear(Year);

        // IsLeap := ContractHasLeapDay(ContractStartDate, ContractEndDate);

        case Month of
            1, 3, 5, 7, 8, 10, 12: // 31-day months
                exit(31);
            4, 6, 9, 11: // 30-day months
                exit(30);
            2: // February
                if IsLeap then
                    exit(29) // Leap year February has 29 days
                else
                    exit(28); // Non-leap year February has 28 days
        end;
    end;

    procedure GetDaysInMonth(CurrentDate: Date; ContractStartDate: Date; ContractEndDate: Date): Integer
    var
        Year: Integer;
        Month: Integer;
        IsLeap: Boolean;
    begin
        Year := DATE2DMY(CurrentDate, 3); // Extract Year from CurrentDate
        Month := DATE2DMY(CurrentDate, 2); // Extract Month from CurrentDate
                                           // IsLeap := IsLeapYear(Year);
        if Month = 2 then
            IsLeap := ContractHasLeapDay(ContractStartDate, ContractEndDate);

        case Month of
            1, 3, 5, 7, 8, 10, 12: // 31-day months
                exit(31);
            4, 6, 9, 11: // 30-day months
                exit(30);
            2: // February
                if IsLeap then
                    exit(29) // Leap year February has 29 days
                else
                    exit(28); // Non-leap year February has 28 days
        end;
    end;

    //-----------------Calculate Total Days in Months's-----------------//

    local procedure ContractHasLeapDay(StartDate: Date; EndDate: Date): Boolean
    var
        LeapDate: Date;
        Year: Integer;
    begin
        for Year := DATE2DMY(StartDate, 3) to DATE2DMY(EndDate, 3) do
            if IsLeapYear(Year) then begin
                LeapDate := DMY2DATE(29, 2, Year);
                if (LeapDate >= StartDate) and (LeapDate <= EndDate) then
                    exit(true);
            end;
        exit(false);
    end;

    //-----------------Calculate Total Days in Months's-----------------//


}
