table 73209619 "finalcalculation_refunApproval"
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
        field(73209576; "Status"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Status';
        }
        field(73209577; "Tenant ID"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant ID';
        }
        field(73209578; "Tenant Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant Name';
        }
        field(73209579; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
        }

        field(73209580; "Total Amount"; Text[300])
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Amount';
        }

        field(73209581; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Due Date';
        }

        field(73209582; "Account Number"; Text[300])
        {
            DataClassification = ToBeClassified;
            Caption = 'Account Number';
        }
        field(73209583; "Account Holder Name"; Text[300])
        {
            DataClassification = ToBeClassified;
            Caption = 'Account Holder Name';
        }
        field(73209584; "Swift Code"; Text[300])
        {
            DataClassification = ToBeClassified;
            Caption = 'Swift Code';
        }

        field(73209585; "IBAN number"; Text[300])
        {
            DataClassification = ToBeClassified;
            Caption = 'IBAN number';
        }
        field(73209586; "Bank Name"; Text[300])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bank Name';
        }
        field(73209587; "Branch Address"; Text[300])
        {
            DataClassification = ToBeClassified;
            Caption = 'Branch Name';
        }
        Field(73209588; "Description"; Text[500])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';

        }
        Field(73209589; "Request Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Request Date';

        }
        Field(73209590; "fcID"; Text[500])
        {
            DataClassification = ToBeClassified;
            Caption = 'fcID';

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

