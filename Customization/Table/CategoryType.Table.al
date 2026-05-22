table 73209592 "BLRCategoryType"
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
            Caption = 'Primary Item';
            TableRelation = "BLRPrimaryItem"."BLRPrimary Item Type";
        }
        field(73209577; "BLRCategory Types"; Text[100])
        {
            DataClassification = SystemMetadata;
            Caption = 'Category';
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
        fieldgroup(DropDown;"BLRID", "BLRPrimary Item Type", "BLRCategory Types")
        {

        }
    }
}
