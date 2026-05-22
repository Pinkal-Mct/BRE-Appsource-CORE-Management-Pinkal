table 73209627 "BLRItemSubPageTable"
{
    DataClassification = CustomerContent;

    fields
    {
        field(73209575; "BLRId"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Item;
        }
        field(73209576; "BLRUnitName"; Text[20])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1;"BLRId")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

}
