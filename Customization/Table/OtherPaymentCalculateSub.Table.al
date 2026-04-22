table 73209641 "Other Payment Calculate Sub"
{
    DataClassification = ToBeClassified;
    fields
    {

        field(73209575; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
        }

        field(73209576; "Secondary Item Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Secondary Item Type';
            Editable = false;
        }

        field(73209577; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';
            Editable = false;
        }

        field(73209578; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Start Date';
            Editable = false;
        }

        field(73209579; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'End Date';
            Editable = false;
        }

        field(73209580; "VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Amount';
            Editable = false;
        }

        field(73209581; "Amount Including VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount Including VAT';
            Editable = false;
        }

        field(73209582; "Tenant ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant ID';
            Editable = false;
        }

        field(73209583; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Entry No.';
            Editable = false;
            AutoIncrement = true;
        }

        field(73209584; "Total Amount"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Other Payment Calculate Sub"."Amount" where("Contract ID" = field("Contract ID"), "Tenant ID" = field("Tenant ID")));
        }

        field(73209585; "Total VAT Amount"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Other Payment Calculate Sub"."VAT Amount" where("Contract ID" = field("Contract ID"), "Tenant ID" = field("Tenant ID")));
        }

        field(73209586; "Total Amount Including VAT"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Other Payment Calculate Sub"."Amount Including VAT" where("Contract ID" = field("Contract ID"), "Tenant ID" = field("Tenant ID")));
        }
    }

    keys
    {
        key(PK; "Contract ID", "Entry No.")
        {
            Clustered = true;
        }
    }


}





