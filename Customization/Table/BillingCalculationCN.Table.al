table 73209586 "Billing Calculation CN"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "Contract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }
        field(73209576; "Tenant ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
        }
        field(73209577; "Item"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Item';
        }
        field(73209578; "Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
        }
        field(73209579; "VAT Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Amount';
        }
        field(73209580; "Amount Including VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount Including VAT';
        }
        field(73209581; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
            AutoIncrement = true;
            Editable = false;
        }
        field(73209582; "VAT %"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT %';
        }
        field(73209583; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Billing Calculation CN"."Amount Including VAT" where("Contract ID" = field("Contract ID"), "Tenant ID" = field("Tenant ID")));
        }
        field(73209584; "Credit Note ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Note ID';
        }
    }
    keys
    {
        key(PK; "Entry No.", "Contract ID")
        {
            Clustered = true;
        }
    }
}
