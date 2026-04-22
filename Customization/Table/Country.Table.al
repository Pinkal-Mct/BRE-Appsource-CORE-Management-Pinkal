table 73209602 "Country"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = ID;
    fields
    {
        field(73209575; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Editable = false;
            NotBlank = false;
        }
        field(73209576; "Sl No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Sl No.';
            Editable = false;
        }
        field(73209577; "Country Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Country Code';
        }
        field(73209578; "Country Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Country Name';
        }
    }
    keys
    {
        key(PK; "ID")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Sl No.", ID, "Country Name", "Country Code")
        {
        }
    }
    trigger OnDelete()
    var
        CountryRec: Record "Country";
    begin
        CountryRec.SetRange("Sl No.", "Sl No." + 1, 2147483647);
        if CountryRec.FindSet() then
            repeat
                CountryRec."Sl No." := CountryRec."Sl No." - 1;
                CountryRec.Modify();
            until CountryRec.Next() = 0;
    end;

    trigger OnInsert()
    var
        CountryRec: Record "Country";
    begin
        if "Sl No." = 0 then
            if CountryRec.FindLast() then
                "Sl No." := CountryRec."Sl No." + 1
            else
                "Sl No." := 1;
    end;
}
