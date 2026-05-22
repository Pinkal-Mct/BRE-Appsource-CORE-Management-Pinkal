table 73209620 "BLRfinalPaymentApproval"
{
    DataClassification = CustomerContent;
    DataCaptionFields = SystemId, "BLRID";

    fields
    {
        field(73209575; "BLRID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID';
            Editable = true;
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
        field(73209581; "BLRPayment transaction ID"; Text[300])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment transaction ID';
        }
        field(73209582; "BLRDue Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Due Date';
        }
        field(73209583; "BLRPayment Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Date';
        }
        field(73209584; "BLRPayment Mode"; Text[300])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Mode';
        }
        Field(73209585; "BLRDescription"; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
            Editable = true;
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

