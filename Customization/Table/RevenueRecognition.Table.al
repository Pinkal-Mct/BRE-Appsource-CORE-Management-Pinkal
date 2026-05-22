table 73209675 "BLRRevenueRecognition"
{
    DataClassification = CustomerContent;

    fields
    {

        field(73209575; "BLRRR Id"; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
            Caption = 'RR Id';
        }

        field(73209576; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            TableRelation = "BLRTenancyContract"."BLRContract ID";
            Caption = 'Contract ID';

            trigger OnValidate()
            var
                tenancyrec: Record "BLRTenancyContract";
            begin
                tenancyrec.SetRange("BLRContract ID", Rec."BLRContract ID");
                if tenancyrec.FindFirst() then begin
                    "BLRTenant Id" := tenancyrec."BLRTenant Id";
                    "BLRStart Date" := tenancyrec."BLRContract Start Date";
                    "BLREnd Date" := tenancyrec."BLRContract End Date";
                    "BLRContract Amount" := tenancyrec."BLRAnnual Rent Amount";

                end else begin
                    // Clear the field if no record is found
                    "BLRTenant Id" := '';
                    "BLRStart Date" := 0D;
                    "BLREnd Date" := 0D;
                    "BLRContract Amount" := 0;
                end;

                CalculateMonthlyRevenue();

            end;
        }

        field(73209577; "BLRTenant Id"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant Id';
            TableRelation = "BLRLeaseProposalDetails"."BLRTenant ID";
            Editable = false; // Make it read-only for the user

        }
        field(73209578; "BLRStart Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
        }
        field(73209579; "BLREnd Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
        }

        field(73209580; "BLRContract Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Amount';
        }

    }

    keys
    {
        key(PK;"BLRRR Id")
        {
            Clustered = true;
        }
    }

    local procedure CalculateMonthlyRevenue()
    var
        SubpageRec: Record "BLRRevenueRecognitionSubpage";

    begin
        SubpageRec.DeleteAll();

        // Detect which rent grid contains records
        if ProcessSingleUnit(Rec."BLRContract ID") then
            exit;

        if ProcessMultiUnit(Rec."BLRContract ID") then
            exit;

        if ProcessMergedSingleRent(Rec."BLRContract ID") then
            exit;

        if ProcessMergedMultiRent(Rec."BLRContract ID") then
            exit;

        ProcessSpecialRent(Rec."BLRContract ID");
    end;

    local procedure ProcessSingleUnit(ContractID: Integer): Boolean
    var
        SingleUnitRent: Record "BLRTCSingleUnitRentSubPage";
    begin
        SingleUnitRent.SetRange("BLRContract ID", ContractID);

        if not SingleUnitRent.FindSet() then
            exit(false);

        repeat
            ProcessRentLine(
                SingleUnitRent."BLRStart Date",
                SingleUnitRent."BLREnd Date",
                SingleUnitRent."BLRFinal Annual Amount");
        until SingleUnitRent.Next() = 0;

        exit(true);
    end;

    local procedure ProcessMultiUnit(ContractID: Integer): Boolean
    var
        MultiUnitRent: Record "BLRTCSingleLumAnnualAmntSP";
    begin
        MultiUnitRent.SetRange("BLRContract ID", ContractID);

        if not MultiUnitRent.FindSet() then
            exit(false);

        repeat
            ProcessRentLine(
                MultiUnitRent."BLRSL_Start Date",
                MultiUnitRent."BLRSL_End Date",
                MultiUnitRent."BLRSL_Final Annual Amount");
        until MultiUnitRent.Next() = 0;

        exit(true);
    end;

    local procedure ProcessMergedSingleRent(ContractID: Integer): Boolean
    var
        MergedSingleRent: Record "BLRTCMergeSameSqureSubPage";
    begin
        MergedSingleRent.SetRange("BLRContract ID", ContractID);

        if not MergedSingleRent.FindSet() then
            exit(false);

        repeat
            ProcessRentLine(
                MergedSingleRent."BLRMS_Start Date",
                MergedSingleRent."BLRMS_End Date",
                MergedSingleRent."BLRMS_Final Annual Amount");
        until MergedSingleRent.Next() = 0;

        exit(true);
    end;

    local procedure ProcessMergedMultiRent(ContractID: Integer): Boolean
    var
        MergedMultiRent: Record "BLRTCMergeDifferentSqSubPage";
    begin
        MergedMultiRent.SetRange("BLRContract ID", ContractID);

        if not MergedMultiRent.FindSet() then
            exit(false);

        repeat
            ProcessRentLine(
                MergedMultiRent."BLRMD_Start Date",
                MergedMultiRent."BLRMD_End Date",
                MergedMultiRent."BLRMD_Final Annual Amount");
        until MergedMultiRent.Next() = 0;

        exit(true);
    end;

    local procedure ProcessSpecialRent(ContractID: Integer): Boolean
    var
        SpecialRent: Record "BLRTCMergeLumAnnualAmountSP";
    begin
        SpecialRent.SetRange("BLRContract ID", ContractID);

        if not SpecialRent.FindSet() then
            exit(false);

        repeat
            ProcessRentLine(
                SpecialRent."BLRML_Start Date",
                SpecialRent."BLRML_End Date",
                SpecialRent."BLRML_Final Annual Amount");
        until SpecialRent.Next() = 0;

        exit(true);
    end;

    local procedure ProcessRentLine(StartDate: Date; EndDate: Date; FinalAnnualAmount: Decimal)
    var
        SubpageRec: Record "BLRRevenueRecognitionSubpage";
        ExistingSubpageRec: Record "BLRRevenueRecognitionSubpage";
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

            ExistingSubpageRec.SetRange("BLRRR Id");
            ExistingSubpageRec.SetRange("BLRMonth", MonthText);
            if ExistingSubpageRec.FindFirst() then begin
                ExistingSubpageRec."BLRNo. of Days" += MonthDays;
                ExistingSubpageRec."BLRRR - Method 1 (Day)" += (MonthDays * DailyRate);
                ExistingSubpageRec."BLRRR - Method 2 (Month)" += MonthlyRate;
                ExistingSubpageRec.Modify();
            end
            else begin
                SubpageRec.Init();
                SubpageRec."BLRRR Id" := Rec."BLRRR Id";
                SubpageRec."BLRContract ID" := Rec."BLRContract ID";
                SubpageRec."BLRTenant Id" := Rec."BLRTenant Id";
                SubpageRec."BLRMonth" := MonthText;
                SubpageRec."BLRNo. of Days" := MonthDays;
                SubpageRec."BLRRR - Method 1 (Day)" := (MonthDays * DailyRate);
                SubpageRec."BLRRR - Method 2 (Month)" := MonthlyRate;
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
