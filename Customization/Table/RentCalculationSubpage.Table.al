table 73209665 "BLRRentCalculationSubpage"
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
        }
        field(73209580; "BLRYearly No. of Installment"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Yearly No. of Instalment';
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
            CalcFormula = sum("BLRRentCalculationSubpage"."BLRFinal Annual Amount" where("BLRContract ID" = field("BLRContract ID"), "BLRRC ID" = field("BLRRC ID")));
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
        }
        field(73209587; "BLRAmount Including VAT"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209588; "BLRSecondary Item Type"; Text[100])
        {
            DataClassification = CustomerContent;
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
        field(73209591; "BLRPer Day Rent"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Per Day Rent';
        }
        field(73209592; "BLRPropety Classification"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Proeprty Classifcation';
        }
        field(73209593; "BLRUnit ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit ID';
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
