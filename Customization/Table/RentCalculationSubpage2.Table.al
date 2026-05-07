table 73209666 "Rent Calculation Subpage2"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "Year"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Year';
            Editable = false;
        }
        field(73209576; "Installment No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Installment No.';
            Editable = false;
        }
        field(73209577; "Installment Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Installment Start Date';
            Editable = false;
        }
        field(73209578; "Installment End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Installment End Date';
            Editable = false;
        }
        field(73209579; "Due Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Due Date';
            Editable = false;
        }
        field(73209580; "Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
            Caption = 'Amount';
            Editable = false;
        }
        field(73209581; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(73209582; "RC ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'RC ID';
        }
        field(73209583; "VAT Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Amount';
            Editable = false;
        }
        field(73209584; "VAT %"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT %';
            Editable = false;
        }
        field(73209585; "Amount Including VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
            Caption = 'Amount Including VAT';
            Editable = false;
        }
        field(73209586; "Secondary Item Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Secondary Item Type';
            Editable = false;
        }
        field(73209587; "Tenant ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
        }
        field(73209588; "Contract ID"; Integer)
        {
            DataClassification = CustomerContent;
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
            DataClassification = CustomerContent;
        }
        field(73209591; "Revenue Str. Subpage Entry No."; Integer)
        {
            DataClassification = CustomerContent;
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
