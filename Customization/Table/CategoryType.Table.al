table 73209592 "Category Type"
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
            Caption = 'Primary Item';
            TableRelation = "Primary Item"."Primary Item Type";
        }
        field(73209577; "Category Types"; Text[100])
        {
            DataClassification = SystemMetadata;
            Caption = 'Category';
        }
    }

    keys
    {
        key(PK; "ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; ID, "Primary Item Type", "Category Types")
        {

        }
    }
}
