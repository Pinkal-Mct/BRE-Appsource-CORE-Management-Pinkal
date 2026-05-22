table 73209602 "BLRCountry"
{
    DataClassification = SystemMetadata;
    DataCaptionFields = "BLRID";
    fields
    {
        field(73209575; "BLRID"; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
            Editable = false;
            NotBlank = false;
        }
        field(73209576; "BLRSl No."; Integer)
        {
            DataClassification = SystemMetadata;
            Caption = 'Sl No.';
            Editable = false;
        }
        field(73209577; "BLRCountry Code"; Code[30])
        {
            DataClassification = SystemMetadata;
            Caption = 'Country Code';
        }
        field(73209578; "BLRCountry Name"; Text[100])
        {
            DataClassification = SystemMetadata;
            Caption = 'Country Name';
        }
    }
    keys
    {
        key(PK;"BLRID")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown;"BLRSl No.", "BLRID", "BLRCountry Name", "BLRCountry Code")
        {
        }
    }
    trigger OnDelete()
    var
        CountryRec: Record "BLRCountry";
    begin
        CountryRec.SetRange("BLRSl No.", "BLRSl No." + 1, 2147483647);
        if CountryRec.FindSet() then
            repeat
                CountryRec."BLRSl No." := CountryRec."BLRSl No." - 1;
                CountryRec.Modify();
            until CountryRec.Next() = 0;
    end;

    trigger OnInsert()
    var
        CountryRec: Record "BLRCountry";
    begin
        if "BLRSl No." = 0 then
            if CountryRec.FindLast() then
                "BLRSl No." := CountryRec."BLRSl No." + 1
            else
                "BLRSl No." := 1;
    end;
}
