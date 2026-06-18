table 73209717 "BLRTCAdditionalTerms"
{
    DataClassification = CustomerContent;

    fields
    {
        field(73209575; "BLREntry No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = CustomerContent;
        }

        field(73209576; "BLRDocument No."; Integer)
        {
            DataClassification = CustomerContent;

        }

        field(73209577; "BLRPoint No."; Integer)
        {
            DataClassification = CustomerContent;

        }

        field(73209578; "BLRDescription"; Text[250])
        {
            DataClassification = CustomerContent;

        }
    }

    keys
    {
        key(PK; "BLREntry No.", "BLRDocument No.")
        {
            Clustered = true;
        }

    }
    trigger OnInsert()
    var
        AdditionalTerms: Record "BLRTCAdditionalTerms";
    begin
        AdditionalTerms.Reset();
        AdditionalTerms.SetRange("BLRDocument No.", "BLRDocument No.");

        if AdditionalTerms.Count >= 5 then
            Error('You can only enter maximum 5 Additional Terms.');
    end;
}