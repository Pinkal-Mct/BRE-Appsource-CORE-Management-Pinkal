table 73209713 "Vendor Profile Template"
{
    Caption = 'Vendor Profile Template';
    TableType = Normal;
    DataClassification = SystemMetadata;
    fields
    {
        field(73209575; Code; Code[50])
        {
            DataClassification = SystemMetadata;
        }
        field(73209576; Description; Text[100])
        {
            DataClassification = SystemMetadata;
        }
        field(73209577; Module; Enum "Module Enum")
        {
            DataClassification = SystemMetadata;
        }
        field(73209578; "No. Series"; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
}
