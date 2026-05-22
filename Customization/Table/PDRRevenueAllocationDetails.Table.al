table 73209655 "BLRPDRRevenueAllocationDetails"
{
    DataClassification = CustomerContent;

    fields
    {
        field(73209575; "BLRYear"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(73209576; "BLRUnit ID"; Text[2048])
        {
            DataClassification = CustomerContent;
        }
        field(73209577; "BLRSq. Ft."; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209578; "BLRPer Day Rent Per Unit"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209579; "BLRTotal Revenue"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209580; "BLRPraposal ID"; Decimal)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK;"BLRYear", "BLRUnit ID") { Clustered = true; }
    }
}
