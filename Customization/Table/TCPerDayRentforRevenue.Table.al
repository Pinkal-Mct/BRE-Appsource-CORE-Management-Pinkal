table 73209699 "TC Per Day Rent for Revenue"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "Id"; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(73209576; "Contract Renewal Id"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209577; "Proposal Id"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209578; "Merge Unit Id"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(73209579; "Year"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209580; "Unit ID"; Code[200])
        {
            DataClassification = CustomerContent;
        }
        field(73209581; "Sq.Ft"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209582; "Per Day Rent Per Unit"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209583; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209584; "Get Data"; Code[100])
        {
            DataClassification = CustomerContent;
            InitValue = 'Click Here For Get Data.';
            Caption = 'Click Here For Get Data.';
        }
    }
    keys
    {
        key(PK; "Id")
        {
            Clustered = true;
        }
    }
}
