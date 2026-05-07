table 73209682 "Revenue Structure Subpage1"
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
            Caption = 'Amount';
            Editable = false;
            DecimalPlaces = 2 : 2;

        }
        field(73209581; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(73209582; "RS ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'RS ID';
        }
        field(73209583; "VAT Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Amount';
            Editable = false;
            DecimalPlaces = 2 : 2;

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
            Caption = 'Amount Including VAT';
            Editable = false;
            DecimalPlaces = 2 : 2;

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
            CalcFormula = sum("Revenue Structure Subpage1".Amount where("RS ID" = field("RS ID")));
            DecimalPlaces = 2 : 2;

        }
    }
    keys
    {
        key(Key1; "Entry No.", "RS ID")
        {
            Clustered = true;
        }
    }
}
