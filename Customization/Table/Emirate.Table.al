table 73209614 "Emirate"
{
    DataClassification = SystemMetadata;
    DataCaptionFields = ID;
    fields
    {
        field(73209575; "ID"; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
            Editable = false;
        }
        field(73209576; "Sl No."; Integer)
        {
            DataClassification = SystemMetadata;
            Caption = 'Sl No.';
            Editable = false;
        }
        field(73209577; "Country Code"; Code[30])
        {
            DataClassification = SystemMetadata;
            Caption = 'Country Code';
            TableRelation = Country;

            trigger OnValidate()
            var
                country: Record Country;
            begin
                if country.Get("Country Code") then
                    "Country Code" := country."Country Code";
            end;
        }
        field(73209578; "Emirate Name"; Enum Emirates)
        {
            DataClassification = SystemMetadata;
            Caption = 'Emirate Name';
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
        fieldgroup(DropDown; "Sl No.", ID, "Emirate Name", "Country Code")
        {
        }
    }
    trigger OnDelete()
    var
        EmirateRec: Record "Emirate";
    begin
        EmirateRec.SetRange("Sl No.", "Sl No." + 1, 2147483647);
        if EmirateRec.FindSet() then
            repeat
                EmirateRec."Sl No." := EmirateRec."Sl No." - 1;
                EmirateRec.Modify();
            until EmirateRec.Next() = 0;
    end;

    trigger OnInsert()
    var
        EmirateRec: Record "Emirate";
    begin
        if "Sl No." = 0 then
            if EmirateRec.FindLast() then
                "Sl No." := EmirateRec."Sl No." + 1
            else
                "Sl No." := 1;
    end;
}
