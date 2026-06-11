table 73209593 "BLRChequeTable"
{
    DataClassification = CustomerContent;

    fields
    {
        field(73209575; "BLRChequeID"; Code[20])
        {
            DataClassification = AccountData;
            Caption = 'Cheque ID';
        }
        field(73209576; "BLRLeaseID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Lease ID';
        }
        field(73209577; "BLRChequeDate"; Date)
        {
            DataClassification = AccountData;
            Caption = 'Cheque Date';
        }
        field(73209578; "BLRChequeAmount"; Decimal)
        {
            DataClassification = AccountData;
            Caption = 'Cheque Amount';
        }
        field(73209579; "BLRChequeStatus"; Enum "BLRPDC Status Type Enum")
        {
            DataClassification = AccountData;
            Caption = 'Cheque Status';
        }
    }

    keys
    {
        key(PK; "BLRChequeID")
        {
            Clustered = true;
        }
    }

}
