table 73209658 "BLRPrimaryClassification"
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
        field(73209576; "BLRClassification Name"; Text[100])
        {
            DataClassification = SystemMetadata;
            Caption = 'Primary Classification Name';
        }
    }
    keys
    {
        key(PK;"BLRID", "BLRClassification Name")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown;"BLRID", "BLRClassification Name")
        {
        }
    }
}
