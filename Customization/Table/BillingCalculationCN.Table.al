table 73209586 "Billing Calculation CN"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(73209575; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
        }
        field(73209576; "Tenant ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant ID';
        }
        field(73209577; "Item"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Item';
        }
        field(73209578; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';
        }
        field(73209579; "VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Amount';
        }
        field(73209580; "Amount Including VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount Including VAT';
        }
        field(73209581; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Entry No.';
            AutoIncrement = true;
            Editable = false;
        }
        field(73209582; "VAT %"; Integer)
        {
            DataClassification = ToBeClassified;
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
            DataClassification = ToBeClassified;
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
