table 73209666 "Rent Calculation Subpage2"
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
        field(73209576; "Installment No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Installment No.';
            Editable = false;
        }
        field(73209577; "Installment Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Installment Start Date';
            Editable = false;
        }
        field(73209578; "Installment End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Installment End Date';
            Editable = false;
        }
        field(73209579; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Due Date';
            Editable = false;
        }
        field(73209580; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Caption = 'Amount';
            Editable = false;
        }
        field(73209581; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(73209582; "RC ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'RC ID';
        }
        field(73209583; "VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Amount';
            Editable = false;
        }
        field(73209584; "VAT %"; Integer)
        {
            Caption = 'VAT %';
            Editable = false;
        }
        field(73209585; "Amount Including VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Caption = 'Amount Including VAT';
            Editable = false;
        }
        field(73209586; "Secondary Item Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Secondary Item Type';
            Editable = false;
        }
        field(73209587; "Tenant ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant ID';
        }
        field(73209588; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
        }
        field(73209589; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Rent Calculation Subpage2".Amount where("RC ID" = field("RC ID")));
            DecimalPlaces = 0 : 2;
        }
        field(73209590; "Primary Classification"; Text[100])
        {
            Caption = 'Primary Classification';
            DataClassification = ToBeClassified;
        }
        field(73209591; "Revenue Str. Subpage Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Entry No.", "RC ID")
        {
            Clustered = true;
        }
    }
}
