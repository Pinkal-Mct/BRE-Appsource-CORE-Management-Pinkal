table 73209618 "FinalCalculationApproval"
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
        field(73209576; Status; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(73209577; "Tenant ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant ID';
        }
        field(73209578; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
        }
        field(73209579; "Contract Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Start Date';
        }
        field(73209580; "Contract End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract End Date';
        }
        field(73209581; "Termination Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Termination Date';
        }
        field(73209582; "Contract Amount"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Amount';
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