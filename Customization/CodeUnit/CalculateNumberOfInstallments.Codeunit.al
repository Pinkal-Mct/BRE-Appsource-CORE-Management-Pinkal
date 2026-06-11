codeunit 73209579 "BLRInstallmentCalculationEng"
{
    procedure CalculateTotalInstallments(var prevenuestructuresubpage: Record "BLRRevenueStructureSubpage")
    var
        revenuestructure: Record "BLRRevenueStructure";
        revenuestructuresubpage: Record "BLRRevenueStructureSubpage";
        getinstallments: Integer;
        Totalinstallments: Integer;
    begin
        Totalinstallments := 0;
        revenuestructure.SetRange("BLRRS ID", prevenuestructuresubpage."BLRRS ID");
        revenuestructure.SetRange("BLRContract ID", prevenuestructuresubpage."BLRContract ID");
        if revenuestructure.FindSet() then begin
            getinstallments := prevenuestructuresubpage."BLRYearly No. of Installment";
            Totalinstallments += getinstallments;
            revenuestructuresubpage.SetRange("BLRRS ID", revenuestructure."BLRRS ID");
            if revenuestructuresubpage.FindSet() then
                repeat
                    if revenuestructuresubpage."BLREntry No." <> prevenuestructuresubpage."BLREntry No." then begin
                        getinstallments := revenuestructuresubpage."BLRYearly No. of Installment";
                        Totalinstallments += getinstallments;
                    end;
                until revenuestructuresubpage.Next() = 0;
            revenuestructure."BLRNumber of Installments" := Totalinstallments;
            revenuestructure.Modify();
        end;
    end;

    procedure BeforeDeleteCalculateInstallments(var prevenuestructuresubpage: Record "BLRRevenueStructureSubpage")
    var
        revenuestructure: Record "BLRRevenueStructure";
        revenuestructuresubpage: Record "BLRRevenueStructureSubpage";
        getinstallments: Integer;
        Totalinstallments: Integer;
    begin
        Totalinstallments := 0;
        revenuestructure.SetRange("BLRRS ID", prevenuestructuresubpage."BLRRS ID");
        revenuestructure.SetRange("BLRContract ID", prevenuestructuresubpage."BLRContract ID");
        if revenuestructure.FindSet() then begin
            revenuestructuresubpage.SetRange("BLRRS ID", revenuestructure."BLRRS ID");
            if revenuestructuresubpage.FindSet() then
                repeat
                    if revenuestructuresubpage."BLREntry No." <> prevenuestructuresubpage."BLREntry No." then begin
                        getinstallments := revenuestructuresubpage."BLRYearly No. of Installment";
                        Totalinstallments += getinstallments;
                    end;
                until revenuestructuresubpage.Next() = 0;
            revenuestructure."BLRNumber of Installments" := Totalinstallments;
            revenuestructure.Modify();
        end;
    end;


    procedure CalculateInstallments(DurationText: Text; Frequency: Text) NoofInstallmets: Integer
    var
        fetchMonth: Codeunit "BLRFetch Month";
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
