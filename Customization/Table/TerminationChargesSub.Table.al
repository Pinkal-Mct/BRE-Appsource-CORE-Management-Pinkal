table 73209705 "Termination Charges Sub"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "Contract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
            Editable = false;
        }
        field(73209576; "Secondary Item Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Secondary Item';
            Editable = false;
        }
        field(73209577; "Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
            Editable = false;
        }
        field(73209578; "VAT %"; Option)
        {
            OptionMembers = "0%","5%";
            Caption = 'VAT %';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73209579; "VAT Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Amount';
            Editable = false;
        }
        field(73209580; "Amount Including VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount Including VAT';
            Editable = false;
        }
        field(73209581; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
            Editable = false;
        }
        field(73209582; "End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
            Editable = false;
        }
        field(73209583; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
            Editable = false;
        }
        field(73209584; "Tenant ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
            Editable = false;
        }
        field(73209585; "Posted Invoice ID"; Code[50])
        {
            Caption = 'Invoice ID';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Entry No.", "Contract ID")
        {
            Clustered = true;
        }
    }
}
