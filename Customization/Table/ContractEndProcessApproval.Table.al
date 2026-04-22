table 73209599 "ContractEndProcessApproval"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = SystemId, "ID";
    fields
    {
        field(73209575; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'ID';
            AutoIncrement = true;
        }
        field(73209576; "Property_M Status"; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Manager Approval Status';
        }
        field(73209577; "Lease_M Status"; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'Lease Manager Approval Status';
        }
        field(73209578; "Contract Id"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Id';
        }
        field(73209579; "Tenant Id"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant Id';
        }
        field(73209580; "Tenant Name"; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant Name';
        }
        field(73209581; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Start Date';
        }
        field(73209582; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract End Date';
        }
        field(73209583; "Tenant Email"; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant Email';
        }
        field(73209584; "Lease Manager Remark"; Text[400])
        {
            DataClassification = ToBeClassified;
            Caption = 'Lease Manager Remark';
        }
        field(73209585; "Property Manager Remark"; Text[400])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Manager Remark';
        }
        field(73209586; "Value"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Value';
        }
        field(73209587; "Renewal Notification to Tenant"; Integer)
        {
            DataClassification = ToBeClassified;
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