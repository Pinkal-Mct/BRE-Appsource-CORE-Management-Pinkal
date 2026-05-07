table 73209627 ItemSubPageTable
{
    DataClassification = CustomerContent;

    fields
    {
        field(73209575; Id; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Item;
        }
        field(73209576; UnitName; Text[20])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Id)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

}
