table 73209597 "Community"
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
        field(73209577; "Emirate Name"; Text[50])
        {
            DataClassification = SystemMetadata;
            Caption = '"Emirate Name"';
            TableRelation = Emirate.ID;

            trigger OnValidate()
            var
                emirate: Record "Emirate";
                emirateID: Integer;
            begin
                Evaluate(emirateID, "Emirate Name");
                emirate.SetRange(ID, emirateID);
                if emirate.FindFirst() then
                    "Emirate Name" := Format(emirate."Emirate Name")
                else
                    Error('Invalid Emirate Name: %1', "Emirate Name");
            end;
        }
        field(73209578; "Community Code"; Code[30])
        {
            DataClassification = SystemMetadata;
            Caption = 'Community Code';
        }
        field(73209579; "Community Name"; Text[100])
        {
            DataClassification = SystemMetadata;
            Caption = 'Community Name';
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
        fieldgroup(DropDown; "Sl No.", ID, "Community Name", "Emirate Name", "Community Code")
        {
        }
    }
    trigger OnDelete()
    var
        CommunityRec: Record "Community";
    begin
        CommunityRec.SetRange("Sl No.", "Sl No." + 1, 2147483647);
        if CommunityRec.FindSet() then
            repeat
                CommunityRec."Sl No." := CommunityRec."Sl No." - 1;
                CommunityRec.Modify();
            until CommunityRec.Next() = 0;
    end;

    trigger OnInsert()
    var
        CommunityRec: Record "Community";
    begin
        if "Sl No." = 0 then
            if CommunityRec.FindLast() then
                "Sl No." := CommunityRec."Sl No." + 1
            else
                "Sl No." := 1;
    end;
}
