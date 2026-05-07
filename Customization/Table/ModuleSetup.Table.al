table 73209637 "Module Setup"
{
    DataClassification = SystemMetadata;

    fields
    {

        field(73209575; "Module Name"; Code[50])
        {
            DataClassification = SystemMetadata;
        }
        field(73209576; "Is Active"; Boolean)
        {
            DataClassification = SystemMetadata;
        }

        field(73209577; "Extension Name"; Code[50])
        {
            DataClassification = SystemMetadata;
            Caption = 'Extension Name';
        }

        field(73209578; "Business Unit Code"; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Business Unit Code';
            TableRelation = "Business Unit".Code;
        }
    }

    keys
    {
        key(Key1; "Module Name")
        {
            Clustered = true;
        }
    }
}
