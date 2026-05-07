table 73209679 "Revenue Recognition Subpage"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "RR Id"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'RR Id';
        }
        field(73209576; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(73209577; "Contract ID"; Integer)
        {
            DataClassification = CustomerContent;
            TableRelation = "Tenancy Contract"."Contract ID";
            Editable = false;
        }
        field(73209578; "Tenant Id"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant Id';
            TableRelation = "Tenancy Contract"."Tenant ID";
            Editable = false;
        }
        field(73209579; "Month"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Month';
            Editable = false;
        }
        field(73209580; "No. of Days"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. of Days';
            Editable = false;
        }
        field(73209581; "RR - Method 1 (Day)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'RR - Method 1 (Day)';
            Editable = false;
        }
        field(73209582; "RR - Method 2 (Month)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'RR - Method 2 (Month)';
            Editable = false;
        }
        field(73209583; "Total Amount(Day)"; Decimal)
        {
            Caption = 'Total Amount(Day)';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Revenue Recognition Subpage"."RR - Method 1 (Day)" where("Contract ID" = field("Contract ID")));
        }
        field(73209584; "Total Amount(Month)"; Decimal)
        {
            Caption = 'Total Amount(Month)';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Revenue Recognition Subpage"."RR - Method 2 (Month)" where("Contract ID" = field("Contract ID")));
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
