table 73209659 "BLRPrimaryItem"
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
        field(73209576; "BLRPrimary Item Type"; Text[100])
        {
            DataClassification = SystemMetadata;
            Caption = 'Primary Item Type';
        }
    }
    keys
    {
        key(PK;"BLRID", "BLRPrimary Item Type")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown;"BLRID", "BLRPrimary Item Type")
        {
        }
    }
}
