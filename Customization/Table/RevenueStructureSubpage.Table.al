table 73209681 "Revenue Structure Subpage"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(73209575; "Year"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Year';
            Editable = false;
        }
        field(73209576; "Period Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Start Date';
            Editable = false;
        }
        field(73209577; "Period End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'End Date';
            Editable = false;
        }
        field(73209578; "Number of Days"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Number of Days';
            Editable = false;
        }
        field(73209579; "Final Annual Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Final Annual Amount';
            Editable = true;
            DecimalPlaces = 2 : 2;

        }
        field(73209580; "Yearly No. of Installment"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Yearly No. of Instalment';
            Editable = true;

            trigger OnValidate()
            var
                calculateinstallmentstotal: Codeunit "Installment Calculation Engine";
            begin
                calculateinstallmentstotal.CalculateTotalInstallments(Rec);
            end;

        }
        field(73209581; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(73209582; "RS ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'RS ID';
        }
        field(73209583; "Tenant Id"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant ID';
        }
        field(73209584; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Revenue Structure Subpage"."Final Annual Amount" where("Contract ID" = field("Contract Id"), "RS ID" = field("RS ID")));
            DecimalPlaces = 2 : 2;

        }
        field(73209585; "Link"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Update Data';
            InitValue = 'Update Data';
        }
        field(73209586; "VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Amount';
            DecimalPlaces = 2 : 2;

        }
        field(73209587; "Amount Including VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount Including VAT';
            DecimalPlaces = 2 : 2;
        }
        field(73209588; "Secondary Item Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Secondary Item Type';
        }
        field(73209589; "VAT %"; Option)
        {
            OptionMembers = "0","5";
            Caption = 'VAT %';
            Editable = false;
        }
        field(73209590; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
        }
        field(73209591; "Payment Frequency"; Option)
        {
            OptionMembers = " ",Monthly,Quarterly,"Half-Yearly",Yearly;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                fetchMonth: Codeunit "Fetch Month";
                installmentCalcEngine: Codeunit "Installment Calculation Engine";
                PeriodDuration: Text;
            begin
                if Rec."Payment Frequency" <> Rec."Payment Frequency"::" " then begin
                    PeriodDuration := fetchMonth.CalculateLeaseDuration(Rec."Period Start Date", Rec."Period End Date");
                    Rec.Validate("Yearly No. of Installment", installmentCalcEngine.CalculateInstallments(PeriodDuration, Format(Rec."Payment Frequency")));
                end;
            end;
        }
    }
    keys
    {
        key(Key1; "Entry No.", "RS ID")
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
