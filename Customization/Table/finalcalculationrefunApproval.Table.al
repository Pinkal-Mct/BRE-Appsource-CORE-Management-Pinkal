table 73209619 "BLRFinalCalcRefundApproval"
{
    DataClassification = CustomerContent;
    DataCaptionFields = SystemId, "BLRID";

    fields
    {
        field(73209575; "BLRID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID';
            Editable = false;
            AutoIncrement = true;
        }
        field(73209576; "BLRStatus"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
        }
        field(73209577; "BLRTenant ID"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
        }
        field(73209578; "BLRTenant Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Tenant Name';
        }
        field(73209579; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }

        field(73209580; "BLRTotal Amount"; Text[300])
        {
            DataClassification = CustomerContent;
            Caption = 'Total Amount';
        }

        field(73209581; "BLRDue Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Due Date';
        }

        field(73209582; "BLRAccount Number"; Text[300])
        {
            DataClassification = CustomerContent;
            Caption = 'Account Number';
        }
        field(73209583; "BLRAccount Holder Name"; Text[300])
        {
            DataClassification = CustomerContent;
            Caption = 'Account Holder Name';
        }
        field(73209584; "BLRSwift Code"; Text[300])
        {
            DataClassification = AccountData;
            Caption = 'Swift Code';
        }

        field(73209585; "BLRIBAN number"; Text[300])
        {
            DataClassification = AccountData;
            Caption = 'IBAN number';
        }
        field(73209586; "BLRBank Name"; Text[300])
        {
            DataClassification = CustomerContent;
            Caption = 'Bank Name';
        }
        field(73209587; "BLRBranch Address"; Text[300])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Branch Name';
        }
        Field(73209588; "BLRDescription"; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';

        }
        Field(73209589; "BLRRequest Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Request Date';

        }
        Field(73209590; "BLRfcID"; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'fcID';

        }
    }

    keys
    {
        key(PrimaryKey;"BLRID")
        {
            Clustered = false;
        }
        key(PK;SystemId)
        {
            Clustered = true;
        }
    }



}

