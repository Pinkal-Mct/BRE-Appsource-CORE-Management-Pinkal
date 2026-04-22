table 73209658 "Primary Classification"
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
        }
        field(73209576; "Classification Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Primary Classification Name';
        }
    }
    keys
    {
        key(PK; "ID", "Classification Name")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; ID, "Classification Name")
        {
        }
    }
}
