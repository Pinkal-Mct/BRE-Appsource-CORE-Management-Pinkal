table 73209663 "Rent Calculate Sub"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(73209575; "Year"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Year';
            Editable = false;
        }

        field(73209576; "Period Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Start Date';
            Editable = false;
        }
        field(73209577; "Period End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'End Date';
            Editable = false;
        }

        field(73209578; "Number of Days"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Number of Days';
            Editable = false;
        }
        field(73209579; "Final Annual Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Final Annual Amount';
            Editable = true;
        }

        field(73209580; "Per Day Rent"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Per Day Rent';
            Editable = false;
        }

        field(73209581; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(73209582; "RC ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'RC ID';

        }

        field(73209583; "Tenant Id"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant ID';

        }

        field(73209584; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';

        }

        field(73209585; "Total Number of Days"; Integer)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Rent Calculate Sub"."Number of Days" where("Contract ID" = field("Contract ID"), "Tenant ID" = field("Tenant ID")));
        }


        field(73209586; "Total Final Annual Amount"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Rent Calculate Sub"."Final Annual Amount" where("Contract ID" = field("Contract ID"), "Tenant ID" = field("Tenant ID")));
        }
    }

    keys
    {
        key(Key1; "Entry No.", "RC ID")
        {
            Clustered = true;
        }
    }

}





