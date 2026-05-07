table 73209578 "Approval Contract Status"
{
    DataClassification = CustomerContent;
    DataCaptionFields = SystemId, "ID";

    fields
    {
        field(73209575; "ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID';
            Editable = false;
            AutoIncrement = true;
        }
        field(73209576; "Status"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
        }
        field(73209577; "Lease ID"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Lease Manager';
        }
        field(73209578; "Contract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }
        field(73209579; "Renewal Contract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Renewal Contract ID';
        }
        field(73209580; "Tenancy Contract Status"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenancy Contract Status';
        }
    }
    keys
    {
        key(PrimaryKey; "ID")
        {
            Clustered = false;
        }
        key(PK; SystemId)
        {
            Clustered = true;
        }
    }
}

