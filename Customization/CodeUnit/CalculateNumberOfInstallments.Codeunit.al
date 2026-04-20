codeunit 50105 "Installment Calculation Engine"
{
    procedure CalculateTotalInstallments(var prevenuestructuresubpage: Record "Revenue Structure Subpage")
    var
        revenuestructure: Record "Revenue Structure";
        revenuestructuresubpage: Record "Revenue Structure Subpage";
        getinstallments: Integer;
        Totalinstallments: Integer;
    begin
        Totalinstallments := 0;
        revenuestructure.SetRange("RS ID", prevenuestructuresubpage."RS ID");
        revenuestructure.SetRange("Contract ID", prevenuestructuresubpage."Contract Id");
        if revenuestructure.FindSet() then begin
            getinstallments := prevenuestructuresubpage."Yearly No. of Installment";
            Totalinstallments += getinstallments;
            revenuestructuresubpage.SetRange("RS ID", revenuestructure."RS ID");
            if revenuestructuresubpage.FindSet() then
                repeat
                    if revenuestructuresubpage."Entry No." <> prevenuestructuresubpage."Entry No." then begin
                        getinstallments := revenuestructuresubpage."Yearly No. of Installment";
                        Totalinstallments += getinstallments;
                    end;
                until revenuestructuresubpage.Next() = 0;
            revenuestructure."Number of Installments" := Totalinstallments;
            revenuestructure.Modify();
        end;
    end;

    procedure BeforeDeleteCalculateInstallments(var prevenuestructuresubpage: Record "Revenue Structure Subpage")
    var
        revenuestructure: Record "Revenue Structure";
        revenuestructuresubpage: Record "Revenue Structure Subpage";
        getinstallments: Integer;
        Totalinstallments: Integer;
    begin
        Totalinstallments := 0;
        revenuestructure.SetRange("RS ID", prevenuestructuresubpage."RS ID");
        revenuestructure.SetRange("Contract ID", prevenuestructuresubpage."Contract Id");
        if revenuestructure.FindSet() then begin
            revenuestructuresubpage.SetRange("RS ID", revenuestructure."RS ID");
            if revenuestructuresubpage.FindSet() then
                repeat
                    if revenuestructuresubpage."Entry No." <> prevenuestructuresubpage."Entry No." then begin
                        getinstallments := revenuestructuresubpage."Yearly No. of Installment";
                        Totalinstallments += getinstallments;
                    end;
                until revenuestructuresubpage.Next() = 0;
            revenuestructure."Number of Installments" := Totalinstallments;
            revenuestructure.Modify();
        end;
    end;


    procedure CalculateInstallments(DurationText: Text; Frequency: Text) NoofInstallmets: Integer
    var
        fetchMonth: Codeunit "Fetch Month";
        Years, Months, Days : Integer;
        TotalMonths, MonthsPerInstallment, Installments : Integer;
    begin
        fetchMonth.ParseDuration(DurationText, Years, Months, Days);

        TotalMonths := (Years * 12) + Months;

        MonthsPerInstallment := fetchMonth.GetNoofMonthsFromFrequency(Frequency);

        Installments := TotalMonths DIV MonthsPerInstallment;
        if (TotalMonths MOD MonthsPerInstallment > 0) or (Days > 0) then
            Installments += 1;

        exit(Installments);
    end;
}
