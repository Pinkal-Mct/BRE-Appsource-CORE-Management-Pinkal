table 73209578 "Approval Contract Status"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = SystemId, "ID";

    fields
    {
        field(73209575; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'ID';
            Editable = false;
            AutoIncrement = true;
        }
        field(73209576; "Status"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Status';
        }
        field(73209577; "Lease ID"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Lease Manager';
        }
        field(73209578; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
        }
        field(73209579; "Renewal Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Renewal Contract ID';
        }
        field(73209580; "Tenancy Contract Status"; Text[50])
        {
            DataClassification = ToBeClassified;
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

