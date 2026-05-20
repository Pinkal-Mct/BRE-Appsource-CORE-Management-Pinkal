table 50974 "Renewal Additional Terms"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50980; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }

        field(50981; "Document No."; Integer)
        {
        }

        field(50982; "Point No."; Integer)
        {
        }

        field(50983; Description; Text[250])
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
        AdditionalTerms: Record "Renewal Additional Terms";
    begin
        AdditionalTerms.Reset();
        AdditionalTerms.SetRange("Document No.", "Document No.");

        if AdditionalTerms.Count >= 5 then
            Error('You can only enter maximum 5 Additional Terms.');
    end;
}