codeunit 53751 "Fetch Month"
{
    procedure GetMonthName(MonthNo: Integer): Text
    begin
        case MonthNo of
            1:
                exit('January');
            2:
                exit('February');
            3:
                exit('March');
            4:
                exit('April');
            5:
                exit('May');
            6:
                exit('June');
            7:
                exit('July');
            8:
                exit('August');
            9:
                exit('September');
            10:
                exit('October');
            11:
                exit('November');
            12:
                exit('December');
            else
                exit(Format(MonthNo));
        end;
    end;

    procedure GetMonthNo(Month: Text): Integer
    begin
        case Month of
            'January':
                exit(1);
            'February':
                exit(2);
            'March':
                exit(3);
            'April':
                exit(4);
            'May':
                exit(5);
            'June':
                exit(6);
            'July':
                exit(7);
            'August':
                exit(8);
            'September':
                exit(9);
            'October':
                exit(10);
            'November':
                exit(11);
            'December':
                exit(12);
            else
                exit(0);
        end;
    end;

    procedure GetNoofDaysInMonth(MonthNo: Integer; Year: Integer): Integer
    var
        DaysInMonth: array[12] of Integer;
    begin
        DaysInMonth[1] := 31;
        DaysInMonth[2] := 28;
        DaysInMonth[3] := 31;
        DaysInMonth[4] := 30;
        DaysInMonth[5] := 31;
        DaysInMonth[6] := 30;
        DaysInMonth[7] := 31;
        DaysInMonth[8] := 31;
        DaysInMonth[9] := 30;
        DaysInMonth[10] := 31;
        DaysInMonth[11] := 30;
        DaysInMonth[12] := 31;
        if (Year mod 4 = 0) and ((Year mod 100 <> 0) or (Year mod 400 = 0)) then
            DaysInMonth[2] := 29;
        exit(DaysInMonth[MonthNo]);
    end;

    procedure GetNoofMonthsFromFrequency(Frequency: Text): Integer
    begin
        case Frequency of
            'Monthly':
                exit(1);
            'Quarterly':
                exit(3);
            'Half-Yearly':
                exit(6);
            'Yearly':
                exit(12);
            else
                exit(0);
        end;
    end;

    procedure GetNoofMonthsFromNoofInstallment(YearlyNoofInstallment: Integer): Integer
    begin
        case YearlyNoofInstallment of
            1:
                exit(12);
            2:
                exit(6);
            4:
                exit(3);
            12:
                exit(1);
        end;
    end;


    // procedure GetNoOfMonths(FromDate: Date; ToDate: Date): Integer
    // var
    //     CurrDate: Date;
    //     MonthCount: Integer;
    // begin
    //     if (FromDate = 0D) or (ToDate = 0D) then
    //         exit(0);

    //     if FromDate > ToDate then
    //         exit(0);

    //     CurrDate := DMY2Date(1, Date2DMY(FromDate, 2), Date2DMY(FromDate, 3));

    //     MonthCount := 0;

    //     repeat
    //         MonthCount += 1;
    //         CurrDate := CalcDate('<+1M>', CurrDate);
    //     until CurrDate > ToDate;

    //     exit(MonthCount);
    // end;

    procedure GetNoOfMonths(StartDate: Date; EndDate: Date): Integer
    var
        StartYear: Integer;
        StartMonth: Integer;
        StartDay: Integer;
        EndYear: Integer;
        EndMonth: Integer;
        EndDay: Integer;
        Result: Integer;
    begin
        if (StartDate = 0D) or (EndDate = 0D) then
            exit(0);

        if StartDate > EndDate then
            exit(0);

        StartYear := DATE2DMY(StartDate, 3);
        StartMonth := DATE2DMY(StartDate, 2);
        StartDay := DATE2DMY(StartDate, 1);

        EndYear := DATE2DMY(EndDate, 3);
        EndMonth := DATE2DMY(EndDate, 2);
        EndDay := DATE2DMY(EndDate, 1);

        Result := (EndYear - StartYear) * 12 + (EndMonth - StartMonth);

        if EndDay >= StartDay then
            Result += 1;

        exit(Result);
    end;

    procedure GetNoOfMonths(ValidFrom: Date; ValidTo: Date; PeriodFrom: Date; PeriodTo: Date): Integer
    var
        FromDate: Date;
        ToDate: Date;
        CurrDate: Date;
        MonthCount: Integer;
    begin
        if ValidTo = 0D then
            ValidTo := PeriodTo;

        FromDate := ValidFrom;
        if PeriodFrom > FromDate then
            FromDate := PeriodFrom;

        ToDate := ValidTo;
        if PeriodTo < ToDate then
            ToDate := PeriodTo;

        if FromDate > ToDate then
            exit(0);

        CurrDate := DMY2Date(1, Date2DMY(FromDate, 2), Date2DMY(FromDate, 3));
        MonthCount := 0;

        repeat
            MonthCount += 1;
            CurrDate := CalcDate('<+1M>', CurrDate);
        until CurrDate > ToDate;

        exit(MonthCount);
    end;

    procedure ParseDuration(durationString: Text; var Years: Integer; var Months: Integer; var Days: Integer)
    var
        tempArray: List of [Text];
        token: Text;
        valueText: Text;
        isFound: Boolean;
        i: Integer;
    begin
        Years := 0;
        Months := 0;
        Days := 0;

        tempArray := durationString.Split(' ');

        for i := 1 to tempArray.Count do begin
            token := tempArray.Get(i);
            isFound := false;

            if token.Contains('year') then begin
                if i > 1 then begin
                    valueText := tempArray.Get(i - 1);
                    if Evaluate(Years, valueText) then;
                end;
                isFound := true;
            end;

            if token.Contains('month') and not isFound then begin
                if i > 1 then begin
                    valueText := tempArray.Get(i - 1);
                    if Evaluate(Months, valueText) then;
                end;
                isFound := true;
            end;

            if token.Contains('day') and not isFound then
                if i > 1 then begin
                    valueText := tempArray.Get(i - 1);
                    if Evaluate(Days, valueText) then;
                end;
        end;
    end;
}