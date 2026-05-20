table 50973 "TC Additional Terms"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50976; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }

        field(50977; "Document No."; Integer)
        {
        }

        field(50978; "Point No."; Integer)
        {
        }

        field(50979; Description; Text[250])
        {
        }
    }

    keys
    {
        key(PK; "Entry No.", "Document No.")
        {
            Clustered = true;
        }

    }
    trigger OnInsert()
    var
        AdditionalTerms: Record "TC Additional Terms";
    begin
        AdditionalTerms.Reset();
        AdditionalTerms.SetRange("Document No.", "Document No.");

        if AdditionalTerms.Count >= 5 then
            Error('You can only enter maximum 5 Additional Terms.');
    end;
}