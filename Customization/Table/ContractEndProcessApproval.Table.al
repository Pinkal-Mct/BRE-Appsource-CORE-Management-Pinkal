table 73209599 "ContractEndProcessApproval"
{
    DataClassification = CustomerContent;
    DataCaptionFields = SystemId, "ID";
    fields
    {
        field(73209575; "ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID';
            AutoIncrement = true;
        }
        field(73209576; "Property_M Status"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Manager Approval Status';
        }
        field(73209577; "Lease_M Status"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Lease Manager Approval Status';
        }
        field(73209578; "Contract Id"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Id';
        }
        field(73209579; "Tenant Id"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant Id';
        }
        field(73209580; "Tenant Name"; Text[200])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Tenant Name';
        }
        field(73209581; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Start Date';
        }
        field(73209582; "End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract End Date';
        }
        field(73209583; "Tenant Email"; Text[200])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Tenant Email';
        }
        field(73209584; "Lease Manager Remark"; Text[400])
        {
            DataClassification = CustomerContent;
            Caption = 'Lease Manager Remark';
        }
        field(73209585; "Property Manager Remark"; Text[400])
        {
            DataClassification = CustomerContent;
            Caption = 'Property Manager Remark';
        }
        field(73209586; "Value"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Value';
        }
        field(73209587; "Renewal Notification to Tenant"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Renewal Notification to Tenant';
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
