table 50972 "Additional Terms"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50972; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }

        field(50973; "Document No."; Integer)
        {
        }

        field(50974; "Point No."; Integer)
        {
        }

        field(50975; Description; Text[250])
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
        AdditionalTerms: Record "Additional Terms";
    begin
        AdditionalTerms.Reset();
        AdditionalTerms.SetRange("Document No.", "Document No.");

        if AdditionalTerms.Count >= 5 then
            Error('You can only enter maximum 5 Additional Terms.');
    end;
}