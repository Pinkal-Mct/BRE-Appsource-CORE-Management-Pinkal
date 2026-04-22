table 73209593 "Cheque Table"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(73209575; "ChequeID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cheque ID';
        }
        field(73209576; "LeaseID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Lease ID';
        }
        field(73209577; "ChequeDate"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Cheque Date';
        }
        field(73209578; "ChequeAmount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cheque Amount';
        }
        field(73209579; "ChequeStatus"; Enum "PDC Status Type Enum")
        {
            DataClassification = CustomerContent;
            Caption = 'Cheque Status';
        }
    }

    keys
    {
        key(PK; "ChequeID")
        {
            Clustered = true;
        }
    }

}