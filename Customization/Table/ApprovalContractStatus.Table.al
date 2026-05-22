table 73209578 "BLRApprovalContractStatus"
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
        field(73209576; "BLRStatus"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
        }
        field(73209577; "BLRLease ID"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Lease Manager';
        }
        field(73209578; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }
        field(73209579; "BLRRenewal Contract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Renewal Contract ID';
        }
        field(73209580; "BLRTenancy Contract Status"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenancy Contract Status';
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

