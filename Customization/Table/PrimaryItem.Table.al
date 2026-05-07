table 73209659 "Primary Item"
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
        field(73209576; "Primary Item Type"; Text[100])
        {
            DataClassification = SystemMetadata;
            Caption = 'Primary Item Type';
        }
    }
    keys
    {
        key(PK; "ID", "Primary Item Type")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; ID, "Primary Item Type")
        {
        }
    }
}
