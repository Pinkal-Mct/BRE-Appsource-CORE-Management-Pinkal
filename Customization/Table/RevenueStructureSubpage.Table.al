table 73209681 "BLRRevenueStructureSubpage"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "BLRYear"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Year';
            Editable = false;
        }
        field(73209576; "BLRPeriod Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
            Editable = false;
        }
        field(73209577; "BLRPeriod End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
            Editable = false;
        }
        field(73209578; "BLRNumber of Days"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Number of Days';
            Editable = false;
        }
        field(73209579; "BLRFinal Annual Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Final Annual Amount';
            Editable = true;
            DecimalPlaces = 2 : 2;

        }
        field(73209580; "BLRYearly No. of Installment"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Yearly No. of Instalment';
            Editable = true;

            trigger OnValidate()
            var
                calculateinstallmentstotal: Codeunit "Installment Calculation Engine";
            begin
                calculateinstallmentstotal.CalculateTotalInstallments(Rec);
            end;

        }
        field(73209581; "BLREntry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(73209582; "BLRRS ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'RS ID';
        }
        field(73209583; "BLRTenant Id"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
        }
        field(73209584; "BLRTotal Amount"; Decimal)
        {
            Caption = 'Total Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("BLRRevenueStructureSubpage"."BLRFinal Annual Amount" where("BLRContract ID" = field("BLRContract ID"), "BLRRS ID" = field("BLRRS ID")));
            DecimalPlaces = 2 : 2;

        }
        field(73209585; "BLRLink"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Update Data';
            InitValue = 'Update Data';
        }
        field(73209586; "BLRVAT Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Amount';
            DecimalPlaces = 2 : 2;

        }
        field(73209587; "BLRAmount Including VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount Including VAT';
            DecimalPlaces = 2 : 2;
        }
        field(73209588; "BLRSecondary Item Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Secondary Item Type';
        }
        field(73209589; "BLRVAT %"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "0","5";
            Caption = 'VAT %';
            Editable = false;
        }
        field(73209590; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }
        field(73209591; "BLRPayment Frequency"; Option)
        {
            OptionMembers = " ",Monthly,Quarterly,"Half-Yearly",Yearly;
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                fetchMonth: Codeunit "Fetch Month";
                installmentCalcEngine: Codeunit "Installment Calculation Engine";
                PeriodDuration: Text;
            begin
                if Rec."BLRPayment Frequency" <> Rec."BLRPayment Frequency"::" " then begin
                    PeriodDuration := fetchMonth.CalculateLeaseDuration(Rec."BLRPeriod Start Date", Rec."BLRPeriod End Date");
                    Rec.Validate("BLRYearly No. of Installment", installmentCalcEngine.CalculateInstallments(PeriodDuration, Format(Rec."BLRPayment Frequency")));
                end;
            end;
        }
    }
    keys
    {
        key(Key1;"BLREntry No.", "BLRRS ID")
        {
            Clustered = true;
        }
    }

    trigger OnDelete()
    var
        installmentCalcEngine: Codeunit "Installment Calculation Engine";
    begin
        installmentCalcEngine.BeforeDeleteCalculateInstallments(Rec);
    end;
}
