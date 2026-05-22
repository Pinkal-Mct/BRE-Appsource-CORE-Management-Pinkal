table 73209614 "BLREmirate"
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
            TableRelation = "BLRCountry";

            trigger OnValidate()
            var
                country: Record "BLRCountry";
            begin
                if country.Get("BLRCountry Code") then
                    "BLRCountry Code" := country."BLRCountry Code";
            end;
        }
        field(73209578; "BLREmirate Name"; Enum Emirates)
        {
            DataClassification = SystemMetadata;
            Caption = 'Emirate Name';
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
        fieldgroup(DropDown;"BLRSl No.", "BLRID", "BLREmirate Name", "BLRCountry Code")
        {
        }
    }
    trigger OnDelete()
    var
        EmirateRec: Record "BLREmirate";
    begin
        EmirateRec.SetRange("BLRSl No.", "BLRSl No." + 1, 2147483647);
        if EmirateRec.FindSet() then
            repeat
                EmirateRec."BLRSl No." := EmirateRec."BLRSl No." - 1;
                EmirateRec.Modify();
            until EmirateRec.Next() = 0;
    end;

    trigger OnInsert()
    var
        EmirateRec: Record "BLREmirate";
    begin
        if "BLRSl No." = 0 then
            if EmirateRec.FindLast() then
                "BLRSl No." := EmirateRec."BLRSl No." + 1
            else
                "BLRSl No." := 1;
    end;
}
