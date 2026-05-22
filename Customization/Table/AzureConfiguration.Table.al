table 73209582 "BLRAzureConfiguration"
{
    DataClassification = SystemMetadata;
    fields
    {
        field(73209575; "BLRId"; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(73209576; "BLRSAS URL"; Text[250])
        {
            DataClassification = SystemMetadata;
            Caption = 'SAS URL';
            Editable = true;
        }
        field(73209577; "BLRStorage Account Name"; Text[50])
        {
            DataClassification = SystemMetadata;
            Caption = 'Storage Account Name';
            Editable = true;
        }
        field(73209578; "BLRClient ID"; Text[50])
        {
            DataClassification = SystemMetadata;
            Caption = 'Client ID (Application ID)';
            Editable = true;
        }
        field(73209579; "BLRClient Secret"; Text[100])
        {
            DataClassification = SystemMetadata;
            Caption = 'Client Secret';
            Editable = true;
        }
        field(73209580; "BLRTenant ID"; Text[50])
        {
            DataClassification = SystemMetadata;
            Caption = 'Tenant ID';
            Editable = true;
        }
        field(73209581; "BLRDefault Container"; Text[50])
        {
            DataClassification = SystemMetadata;
            Caption = 'Default Container';
            Editable = true;
        }
    }
    keys
    {
        key(Key1;"BLRId")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        AzureConfig: Record "BLRAzureConfiguration";
    begin
        if not AzureConfig.IsEmpty() then
            Error('Only one record is allowed in this table.');
    end;
}
