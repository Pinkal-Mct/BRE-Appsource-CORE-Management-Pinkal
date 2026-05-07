table 73209665 "Rent Calculation Subpage"
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
        }
        field(73209580; "Yearly No. of Installment"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Yearly No. of Instalment';
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
        field(73209584; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Rent Calculation Subpage"."Final Annual Amount" where("Contract ID" = field("Contract Id"), "RC ID" = field("RC ID")));
        }
        field(73209585; "Link"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Update Data';
            InitValue = 'Update Data';
        }
        field(73209586; "VAT Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209587; "Amount Including VAT"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209588; "Secondary Item Type"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209589; "VAT %"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "0","5";
            Caption = 'VAT %';
            Editable = false;
        }
        field(73209590; "Contract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }
        field(73209591; "Per Day Rent"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Per Day Rent';
        }
        field(73209592; "Propety Classification"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Proeprty Classifcation';
        }
        field(73209593; "Unit ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit ID';
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
