table 73209639 "OnlinePaymentApproval"
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
        field(73209580; "Payment Series"; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Series';
        }
        field(73209581; "Total Amount"; Text[300])
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Amount';
        }
        field(73209582; "Payment transaction ID"; Text[300])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment transaction ID';
        }
        field(73209583; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Due Date';
        }
        field(73209584; "Payment Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Date';
        }
        field(73209585; "Payment Mode"; Text[300])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Mode';
        }
        Field(73209586; "Description"; Text[500])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
            Editable = true;
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

