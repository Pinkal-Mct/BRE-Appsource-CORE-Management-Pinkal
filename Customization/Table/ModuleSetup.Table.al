table 73209637 "BLRModuleSetup"
{
    DataClassification = SystemMetadata;

    fields
    {

        field(73209575; "BLRModule Name"; Code[50])
        {
            DataClassification = SystemMetadata;
        }
        field(73209576; "BLRIs Active"; Boolean)
        {
            DataClassification = SystemMetadata;
        }

        field(73209577; "BLRExtension Name"; Code[50])
        {
            DataClassification = SystemMetadata;
            Caption = 'Extension Name';
        }

        field(73209578; "BLRBusiness Unit Code"; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Business Unit Code';
            TableRelation = "Business Unit".Code;
        }
    }

    keys
    {
        key(Key1;"BLRModule Name")
        {
            Clustered = true;
        }
    }
}
