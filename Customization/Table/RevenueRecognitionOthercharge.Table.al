table 73209678 "BLRRevenueRecognitionOthChg"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "BLREntry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(73209576; "BLRRS Id"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'RS Id';
        }
        field(73209577; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            TableRelation = "BLRTenancyContract"."BLRContract ID";
            Editable = false;
        }
        field(73209578; "BLRTenant Id"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant Id';
            TableRelation = "BLRTenancyContract"."BLRTenant ID";
            Editable = false;
        }
        field(73209579; "BLRMonth"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Month';
            Editable = false;
        }
        field(73209580; "BLRNo. of Days"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. of Days';
            Editable = false;
        }
        field(73209581; "BLRRR - Method 1 (Day)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'RR - Method 1 (Day)';
            Editable = false;
        }
        field(73209582; "BLRRR - Method 2 (Month)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'RR - Method 2 (Month)';
            Editable = false;
        }
        field(73209583; "BLRTotal Amount(Day)"; Decimal)
        {
            Caption = 'Total Amount(Day)';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("BLRRevenueRecognitionOthChg"."BLRRR - Method 1 (Day)" where("BLRContract ID" = field("BLRContract ID")));
        }
        field(73209584; "BLRTotal Amount(Month)"; Decimal)
        {
            Caption = 'Total Amount(Month)';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("BLRRevenueRecognitionOthChg"."BLRRR - Method 2 (Month)" where("BLRContract ID" = field("BLRContract ID")));
        }
    }
    keys
    {
        key(PK;"BLREntry No.")
        {
            Clustered = true;
        }
    }
}
