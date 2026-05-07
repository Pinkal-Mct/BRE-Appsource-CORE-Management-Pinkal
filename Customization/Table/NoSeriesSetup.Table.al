table 73209638 "No. Series Setup"
{
    DataClassification = SystemMetadata;
    Caption = 'No. Series Setup';
    fields
    {
        field(73209575; "Primary Key"; Code[10])
        {
            DataClassification = SystemMetadata;
            AllowInCustomizations = Never;
            Caption = 'Primary Key';
        }
        field(73209576; "Vendor Assignment Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Vendor Assignment Nos.';
            TableRelation = "No. Series".Code;
        }
        field(73209577; "Construction Project Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Construction Project Nos.';
            TableRelation = "No. Series".Code;
        }
        field(73209578; "Milestone Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Milestone Nos.';
            TableRelation = "No. Series".Code;
        }
        field(73209579; "Milestone Task Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Milestone Task Nos.';
            TableRelation = "No. Series".Code;
        }
        field(73209580; "Milestone Sub Task Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Milestone Sub Task Nos.';
            TableRelation = "No. Series".Code;
        }
        field(73209581; "Vendor Profile Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Vendor Profile Nos.';
            TableRelation = "No. Series".Code;
        }
        field(73209582; "Vendor Proposal Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Vendor Proposal Nos.';
            TableRelation = "No. Series".Code;
        }
        field(73209583; "Vendor Contract Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Vendor Contract Nos.';
            TableRelation = "No. Series".Code;
        }
        field(73209584; "OEM ID Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'OEM ID';
            TableRelation = "No. Series".Code;
        }
        field(73209585; "Equipment ID Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Equipment ID';
            TableRelation = "No. Series".Code;
        }
        field(73209586; "Part ID Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Part ID';
            TableRelation = "No. Series".Code;
        }
        field(73209587; "Sub-Equipment ID Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Sub-Equipment ID';
            TableRelation = "No. Series".Code;
        }
        field(73209588; "Service Request ID Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Service Request ID';
            TableRelation = "No. Series".Code;
        }
        field(73209589; "Service Type ID Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Service Type ID';
            TableRelation = "No. Series".Code;
        }
        field(73209590; "Service Sub-Type ID Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Service Sub-Type ID';
            TableRelation = "No. Series".Code;
        }
        field(73209591; "Opportunity ID Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Opportunity ID';
            TableRelation = "No. Series".Code;
        }
        field(73209592; "Lead ID Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series".Code;
        }
        field(73209593; "Project Budget ID Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series".Code;
        }
        field(73209594; "Client Info ID Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series".Code;
        }
        field(73209595; "Sales Proposal ID Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series".Code;
        }
        field(73209596; "Customer Eligibility ID Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series".Code;
        }
        field(73209597; "Payment Receipt ID Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series".Code;
        }
        field(73209598; "Management Fee Master"; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series".Code;
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
