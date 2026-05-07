table 73209673 "Revenue Calculate Sub"
{
    DataClassification = CustomerContent;

    fields
    {

        field(73209575; "Contract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }

        field(73209576; "RS ID"; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
            Editable = false;
        }

        field(73209577; "Secondary Item Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Secondary Item Type';
            Editable = false;
        }

        field(73209578; "Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
            Editable = false;
        }

        field(73209579; "Installment Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Installment Start Date';
            Editable = false;
        }

        field(73209580; "Installment End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Installment End Date';
            Editable = false;
        }

        field(73209581; "VAT Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Amount';
            Editable = false;
        }

        field(73209582; "Amount Including VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount Including VAT';
            Editable = false;
        }

        field(73209583; "Tenant ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
            Editable = false;
        }


        field(73209584; "Total Amount"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Revenue Calculate Sub"."Amount" where("Contract ID" = field("Contract ID"), "Tenant ID" = field("Tenant ID")));
        }

        field(73209585; "Total VAT Amount"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Revenue Calculate Sub"."VAT Amount" where("Contract ID" = field("Contract ID"), "Tenant ID" = field("Tenant ID")));
        }

        field(73209586; "Total Amount Including VAT"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Revenue Calculate Sub"."Amount Including VAT" where("Contract ID" = field("Contract ID"), "Tenant ID" = field("Tenant ID")));
        }

    }
    keys
    {
        key(PK; "RS ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Contract ID")
        {

        }
    }

}





