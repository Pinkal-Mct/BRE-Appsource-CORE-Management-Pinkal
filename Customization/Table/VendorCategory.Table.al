table 73209709 "BLRVendorCategory"
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
        field(73209576; "BLRVendor Category Type"; Text[100])
        {
            DataClassification = SystemMetadata;
            Caption = 'Vendor Category Type';
        }
    }
    keys
    {
        key(PK;"BLRID", "BLRVendor Category Type")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown;"BLRID", "BLRVendor Category Type")
        {
        }
    }
}
