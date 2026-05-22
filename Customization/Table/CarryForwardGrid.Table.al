table 73209591 "BLRCarryForwardGrid"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
            Editable = false;
        }
        field(73209576; "BLRSecurity Deposit"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Security Deposit';
            Editable = false;
        }
        field(73209577; "BLRTotal Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Amount';
            Editable = false;
        }
        field(73209578; "BLREntry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
            Editable = false;
        }
        field(73209579; "BLRNew Contract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
    keys
    {
        key(Key1;"BLREntry No.", "BLRContract ID")
        {
            Clustered = true;
        }
    }
}
