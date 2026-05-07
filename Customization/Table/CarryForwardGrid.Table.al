table 73209591 "Carry Forward Grid"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "Contract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
            Editable = false;
        }
        field(73209576; "Security Deposit"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Security Deposit';
            Editable = false;
        }
        field(73209577; "Total Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Amount';
            Editable = false;
        }
        field(73209578; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
            Editable = false;
        }
        field(73209579; "New Contract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
    keys
    {
        key(Key1; "Entry No.", "Contract ID")
        {
            Clustered = true;
        }
    }
}
