table 73209597 "BLRCommunity"
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
        field(73209577; "BLREmirate Name"; Text[50])
        {
            DataClassification = SystemMetadata;
            Caption = '"BLREmirate Name"';
            TableRelation = "BLREmirate"."BLRID";

            trigger OnValidate()
            var
                emirate: Record "BLREmirate";
                emirateID: Integer;
            begin
                Evaluate(emirateID, "BLREmirate Name");
                emirate.SetRange("BLRID", emirateID);
                if emirate.FindFirst() then
                    "BLREmirate Name" := Format(emirate."BLREmirate Name")
                else
                    Error('Invalid "BLREmirate Name": %1', "BLREmirate Name");
            end;
        }
        field(73209578; "BLRCommunity Code"; Code[30])
        {
            DataClassification = SystemMetadata;
            Caption = 'Community Code';
        }
        field(73209579; "BLRCommunity Name"; Text[100])
        {
            DataClassification = SystemMetadata;
            Caption = 'Community Name';
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
        fieldgroup(DropDown;"BLRSl No.", "BLRID", "BLRCommunity Name", "BLREmirate Name", "BLRCommunity Code")
        {
        }
    }
    trigger OnDelete()
    var
        CommunityRec: Record "BLRCommunity";
    begin
        CommunityRec.SetRange("BLRSl No.", "BLRSl No." + 1, 2147483647);
        if CommunityRec.FindSet() then
            repeat
                CommunityRec."BLRSl No." := CommunityRec."BLRSl No." - 1;
                CommunityRec.Modify();
            until CommunityRec.Next() = 0;
    end;

    trigger OnInsert()
    var
        CommunityRec: Record "BLRCommunity";
    begin
        if "BLRSl No." = 0 then
            if CommunityRec.FindLast() then
                "BLRSl No." := CommunityRec."BLRSl No." + 1
            else
                "BLRSl No." := 1;
    end;
}
