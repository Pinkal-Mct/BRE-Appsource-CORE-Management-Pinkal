table 73209709 "Vendor Category"
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
        field(73209576; "Vendor Category Type"; Text[100])
        {
            DataClassification = SystemMetadata;
            Caption = 'Vendor Category Type';
        }
    }
    keys
    {
        key(PK; "ID", "Vendor Category Type")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; ID, "Vendor Category Type")
        {
        }
    }
}
