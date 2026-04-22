table 73209627 ItemSubPageTable
{
    DataClassification = ToBeClassified;

    fields
    {
        field(73209575; Id; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item;
        }
        field(73209576; UnitName; Text[20])
        {
            DataClassification = ToBeClassified;
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