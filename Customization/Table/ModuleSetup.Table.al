table 73209637 "Module Setup"
{
    DataClassification = ToBeClassified;

    fields
    {

        field(73209575; "Module Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(73209576; "Is Active"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(73209577; "Extension Name"; Code[50])
        {
            Caption = 'Extension Name';
        }

        field(73209578; "Business Unit Code"; Code[20])
        {
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