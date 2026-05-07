table 73209663 "Rent Calculate Sub"
{
    DataClassification = CustomerContent;

    fields
    {
        field(73209575; "Year"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Year';
            Editable = false;
        }

        field(73209576; "Period Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
            Editable = false;
        }
        field(73209577; "Period End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
            Editable = false;
        }

        field(73209578; "Number of Days"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Number of Days';
            Editable = false;
        }
        field(73209579; "Final Annual Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Final Annual Amount';
            Editable = true;
        }

        field(73209580; "Per Day Rent"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Per Day Rent';
            Editable = false;
        }

        field(73209581; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }

        field(73209582; "RC ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'RC ID';

        }

        field(73209583; "Tenant Id"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';

        }

        field(73209584; "Contract ID"; Integer)
        {
            DataClassification = CustomerContent;
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





