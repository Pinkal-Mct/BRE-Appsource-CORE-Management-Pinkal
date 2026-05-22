table 73209657 "BLRPerDayRentforRevenue"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "BLRId"; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(73209576; "BLRProposal Id"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(73209577; "BLRMerge Unit Id"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(73209578; "BLRYear"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(73209579; "BLRUnit ID"; Code[200])
        {
            DataClassification = CustomerContent;
        }
        field(73209580; "BLRSq.Ft"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209581; "BLRPer Day Rent Per Unit"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209582; "BLRGet Data"; Code[100])
        {
            DataClassification = CustomerContent;
            InitValue = 'Click Here For "BLRGet Data".';
            Caption = 'Click Here For "BLRGet Data".';
        }
    }
    keys
    {
        key(PK;"BLRId")
        {
            Clustered = true;
        }
    }
}
