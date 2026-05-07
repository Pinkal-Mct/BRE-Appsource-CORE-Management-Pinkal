table 73209662 "Property Type"
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
        field(73209576; "Classification Name"; Text[100])
        {
            DataClassification = SystemMetadata;
            Caption = 'Primary Classification';
            TableRelation = "Primary Classification"."Classification Name";
        }
        field(73209577; "Property Type"; Text[100])
        {
            DataClassification = SystemMetadata;
            Caption = 'Property Type';
        }
    }

    keys
    {
        key(PK; "ID", "Property Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; ID, "Classification Name", "Property Type")
        {
        }
    }
}
