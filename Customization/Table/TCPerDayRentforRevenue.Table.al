table 73209699 "BLRTCPerDayRentforRevenue"
{
    DataClassification = CustomerContent;
    fields
    {
        field(73209575; "BLRId"; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(73209576; "BLRContract Renewal Id"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209577; "BLRProposal Id"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209578; "BLRMerge Unit Id"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(73209579; "BLRYear"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209580; "BLRUnit ID"; Code[200])
        {
            DataClassification = CustomerContent;
        }
        field(73209581; "BLRSq.Ft"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209582; "BLRPer Day Rent Per Unit"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209583; "BLRLine No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209584; "BLRGet Data"; Code[100])
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
