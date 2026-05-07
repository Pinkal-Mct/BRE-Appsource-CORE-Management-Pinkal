table 73209625 "Invoice-Credit Note"
{
    DataClassification = CustomerContent;

    fields
    {
        field(73209575; "ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID';
            Editable = false;
        }
        field(73209576; "Contract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }
        field(73209577; "Tenant ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
        }

        field(73209578; "Invoice ID"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice ID';
        }
        field(73209579; "Item Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Item Name';
        }
        field(73209580; "Item Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Item Amount';
        }
        field(73209581; "Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            OptionMembers = " ","Complete","Partial";
        }
        field(73209582; "Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
        }
        field(73209583; "Remark"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Remark';
        }
        field(73209584; "Reference"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Reference';
        }
        field(73209585; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
            AutoIncrement = true;
            Editable = false;
        }


    }


    keys
    {
        key(PK; "Entry No.", "ID")
        {
            Clustered = true;
        }
    }
}
