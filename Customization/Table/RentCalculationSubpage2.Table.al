table 73209666 "BLRRentCalculationSubpage2"
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
        field(73209576; "BLRInstallment No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Installment No.';
            Editable = false;
        }
        field(73209577; "BLRInstallment Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Installment Start Date';
            Editable = false;
        }
        field(73209578; "BLRInstallment End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Installment End Date';
            Editable = false;
        }
        field(73209579; "BLRDue Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Due Date';
            Editable = false;
        }
        field(73209580; "BLRAmount"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
            Caption = 'Amount';
            Editable = false;
        }
        field(73209581; "BLREntry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(73209582; "BLRRC ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'RC ID';
        }
        field(73209583; "BLRVAT Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Amount';
            Editable = false;
        }
        field(73209584; "BLRVAT %"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT %';
            Editable = false;
        }
        field(73209585; "BLRAmount Including VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
            Caption = 'Amount Including VAT';
            Editable = false;
        }
        field(73209586; "BLRSecondary Item Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Secondary Item Type';
            Editable = false;
        }
        field(73209587; "BLRTenant ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
        }
        field(73209588; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }
        field(73209589; "BLRTotal Amount"; Decimal)
        {
            Caption = 'Total Amount';
            FieldClass = FlowField;
            CalcFormula = sum("BLRRentCalculationSubpage2"."BLRAmount" where("BLRRC ID" = field("BLRRC ID")));
            DecimalPlaces = 0 : 2;
        }
        field(73209590; "BLRPrimary Classification"; Text[100])
        {
            Caption = 'Primary Classification';
            DataClassification = CustomerContent;
        }
        field(73209591; "BLRRevStrSubpageEntryNo"; Integer)
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1;"BLREntry No.", "BLRRC ID")
        {
            Clustered = true;
        }
    }
}
