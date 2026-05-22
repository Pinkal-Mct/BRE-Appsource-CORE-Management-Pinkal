table 73209581 "BLRAvailabilityStatus"
{
    DataClassification = SystemMetadata;
    DataCaptionFields = "BLRID";

    fields
    {
        field(73209575; "BLRID"; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true; // Automatically increment the ID
            Editable = false; // Make it read-only for the user
        }
        field(73209576; "BLRStatus"; Text[100])
        {
            DataClassification = SystemMetadata;
            Caption = 'Status Name';

        }
    }

    keys
    {
        key(PK;"BLRID", "BLRStatus")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown;"BLRID", "BLRStatus")
        {

        }
    }



}
