table 73209582 "AzureConfiguration"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(73209575; Id; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(73209576; "SAS URL"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'SAS URL';
            Editable = true;
        }
        field(73209577; "Storage Account Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Storage Account Name';
            Editable = true;
        }
        field(73209578; "Client ID"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Client ID (Application ID)';
            Editable = true;
        }
        field(73209579; "Client Secret"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Client Secret';
            Editable = true;
        }
        field(73209580; "Tenant ID"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
            Editable = true;
        }
        field(73209581; "Default Container"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Default Container';
            Editable = true;
        }
    }
    keys
    {
        key(Key1; Id)
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        AzureConfig: Record AzureConfiguration;
    begin
        if not AzureConfig.IsEmpty() then
            Error('Only one record is allowed in this table.');
    end;
}