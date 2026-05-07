table 73209655 "PDR Revenue Allocation Details"
{
    DataClassification = CustomerContent;

    fields
    {
        field(73209575; "Year"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(73209576; "Unit ID"; Text[2048])
        {
            DataClassification = CustomerContent;
        }
        field(73209577; "Sq. Ft."; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209578; "Per Day Rent Per Unit"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209579; "Total Revenue"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73209580; "Praposal ID"; Decimal)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Year", "Unit ID") { Clustered = true; }
    }
}
