table 73209619 "finalcalculation_refunApproval"
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
        field(73209576; "Status"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
        }
        field(73209577; "Tenant ID"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
        }
        field(73209578; "Tenant Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Tenant Name';
        }
        field(73209579; "Contract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }

        field(73209580; "Total Amount"; Text[300])
        {
            DataClassification = CustomerContent;
            Caption = 'Total Amount';
        }

        field(73209581; "Due Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Due Date';
        }

        field(73209582; "Account Number"; Text[300])
        {
            DataClassification = CustomerContent;
            Caption = 'Account Number';
        }
        field(73209583; "Account Holder Name"; Text[300])
        {
            DataClassification = CustomerContent;
            Caption = 'Account Holder Name';
        }
        field(73209584; "Swift Code"; Text[300])
        {
            DataClassification = AccountData;
            Caption = 'Swift Code';
        }

        field(73209585; "IBAN number"; Text[300])
        {
            DataClassification = AccountData;
            Caption = 'IBAN number';
        }
        field(73209586; "Bank Name"; Text[300])
        {
            DataClassification = CustomerContent;
            Caption = 'Bank Name';
        }
        field(73209587; "Branch Address"; Text[300])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Branch Name';
        }
        Field(73209588; "Description"; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';

        }
        Field(73209589; "Request Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Request Date';

        }
        Field(73209590; "fcID"; Text[500])
        {
            DataClassification = CustomerContent;
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

