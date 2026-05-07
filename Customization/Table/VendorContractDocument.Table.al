table 73209710 "Vendor Contract Document"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "Vendor ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor ID';
            Editable = false;
        }
        field(73209576; "Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
        }
        field(73209577; "Payment Status"; Enum "Payment Status")
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Status';
        }
        field(73209578; "Invoice ID"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice ID';
        }
        field(73209579; "Invoice Document Upload"; Text[2000])
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice Document Upload';
            InitValue = 'Invoice Upload';
        }
        field(73209580; "Receipt Document Upload"; Text[2000])
        {
            DataClassification = CustomerContent;
            Caption = 'Receipt Document Upload';
            InitValue = 'Receipt Upload';
        }
        field(73209581; "Receipt ID"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Receipt ID';
        }
        field(73209582; "Invoice Document View"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice Document View';
            InitValue = 'Invoice View';
        }
        field(73209583; "Receipt Document View"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Receipt Document View';
            InitValue = 'Receipt View';
        }
        field(73209584; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
            Editable = false;
            AutoIncrement = true;
        }
        field(73209585; "Invoice Document URL"; Text[2000])
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice Document URL';
        }
        field(73209586; "Receipt Document URL"; Text[2000])
        {
            DataClassification = CustomerContent;
            Caption = 'Receipt Document URL';
        }
    }
    keys
    {
        key(PK; "Entry No.", "Vendor ID")
        {
            Clustered = true;
        }
    }
}
