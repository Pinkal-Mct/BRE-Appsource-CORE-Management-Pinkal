table 73209655 "PDR Revenue Allocation Details"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(73209575; "Year"; Text[30]) { }
        field(73209576; "Unit ID"; Text[2048]) { }
        field(73209577; "Sq. Ft."; Decimal) { }
        field(73209578; "Per Day Rent Per Unit"; Decimal) { }
        field(73209579; "Total Revenue"; Decimal) { }
        field(73209580; "Praposal ID"; Decimal) { }
    }

    keys
    {
        key(PK; "Year", "Unit ID") { Clustered = true; }
    }
}
