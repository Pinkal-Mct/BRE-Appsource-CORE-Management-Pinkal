table 73209713 "BLRVendorProfileTemplate"
{
    Caption = 'Vendor Profile Template';
    TableType = Normal;
    DataClassification = SystemMetadata;
    fields
    {
        field(73209575; "BLRCode"; Code[50])
        {
            DataClassification = SystemMetadata;
        }
        field(73209576; "BLRDescription"; Text[100])
        {
            DataClassification = SystemMetadata;
        }
        field(73209577; "BLRModule"; Enum "Module Enum")
        {
            DataClassification = SystemMetadata;
        }
        field(73209578; "BLRNo. Series"; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(PK;"BLRCode")
        {
            Clustered = true;
        }
    }
}
