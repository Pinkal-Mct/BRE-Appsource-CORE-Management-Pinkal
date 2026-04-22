table 73209679 "Revenue Recognition Subpage"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(73209575; "RR Id"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'RR Id';
        }
        field(73209576; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(73209577; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Tenancy Contract"."Contract ID";
            Editable = false;
        }
        field(73209578; "Tenant Id"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant Id';
            TableRelation = "Tenancy Contract"."Tenant ID";
            Editable = false;
        }
        field(73209579; "Month"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Month';
            Editable = false;
        }
        field(73209580; "No. of Days"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'No. of Days';
            Editable = false;
        }
        field(73209581; "RR - Method 1 (Day)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'RR - Method 1 (Day)';
            Editable = false;
        }
        field(73209582; "RR - Method 2 (Month)"; Decimal)
        {
            DataClassification = ToBeClassified;
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
