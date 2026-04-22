table 73209657 "Per Day Rent for Revenue"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(73209575; "Id"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(73209576; "Proposal Id"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(73209577; "Merge Unit Id"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(73209578; "Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(73209579; "Unit ID"; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(73209580; "Sq.Ft"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(73209581; "Per Day Rent Per Unit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(73209582; "Get Data"; Code[100])
        {
            DataClassification = ToBeClassified;
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
