table 73209586 "BLRBillingCalculationCN"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }
        field(73209576; "BLRTenant ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
        }
        field(73209577; "BLRItem"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Item';
        }
        field(73209578; "BLRAmount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
        }
        field(73209579; "BLRVAT Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Amount';
        }
        field(73209580; "BLRAmount Including VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount Including VAT';
        }
        field(73209581; "BLREntry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
            AutoIncrement = true;
            Editable = false;
        }
        field(73209582; "BLRVAT %"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT %';
        }
        field(73209583; "BLRTotal Amount"; Decimal)
        {
            Caption = 'Total Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("BLRBillingCalculationCN"."BLRAmount Including VAT" where("BLRContract ID" = field("BLRContract ID"), "BLRTenant ID" = field("BLRTenant ID")));
        }
        field(73209584; "BLRCredit Note ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Note ID';
        }
    }
    keys
    {
        key(PK;"BLREntry No.", "BLRContract ID")
        {
            Clustered = true;
        }
    }
}
