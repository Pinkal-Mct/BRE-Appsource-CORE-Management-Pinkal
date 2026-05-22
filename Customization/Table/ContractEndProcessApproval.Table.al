table 73209599 "BLRContractEndProcessApproval"
{
    DataClassification = CustomerContent;
    DataCaptionFields = SystemId, "BLRID";
    fields
    {
        field(73209575; "BLRID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID';
            AutoIncrement = true;
        }
        field(73209576; "BLRProperty_M Status"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Manager Approval Status';
        }
        field(73209577; "BLRLease_M Status"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Lease Manager Approval Status';
        }
        field(73209578; "BLRContract Id"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Id';
        }
        field(73209579; "BLRTenant Id"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant Id';
        }
        field(73209580; "BLRTenant Name"; Text[200])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Tenant Name';
        }
        field(73209581; "BLRStart Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Start Date';
        }
        field(73209582; "BLREnd Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract End Date';
        }
        field(73209583; "BLRTenant Email"; Text[200])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Tenant Email';
        }
        field(73209584; "BLRLease Manager Remark"; Text[400])
        {
            DataClassification = CustomerContent;
            Caption = 'Lease Manager Remark';
        }
        field(73209585; "BLRProperty Manager Remark"; Text[400])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Manager Remark';
        }
        field(73209586; "BLRValue"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Value';
        }
        field(73209587; "BLRRenewalNotiftoTenant"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Renewal Notification to Tenant';
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
