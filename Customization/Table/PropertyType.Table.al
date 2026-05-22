table 73209662 "BLRPropertyType"
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
            Caption = 'Primary Classification';
            TableRelation = "BLRPrimaryClassification"."BLRClassification Name";
        }
        field(73209577; "BLRProperty Type"; Text[100])
        {
            DataClassification = SystemMetadata;
            Caption = 'Property Type';
        }
    }

    keys
    {
        key(PK;"BLRID", "BLRProperty Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"BLRID", "BLRClassification Name", "BLRProperty Type")
        {
        }
    }
}
