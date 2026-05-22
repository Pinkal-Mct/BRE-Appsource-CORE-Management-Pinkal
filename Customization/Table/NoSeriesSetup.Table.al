table 73209638 "BLRNoSeriesSetup"
{
    DataClassification = SystemMetadata;
    Caption = 'No. Series Setup';
    fields
    {
        field(73209575; "BLRPrimary Key"; Code[10])
        {
            DataClassification = SystemMetadata;
            AllowInCustomizations = Never;
            Caption = 'Primary Key';
        }
        field(73209576; "BLRVendor Assignment Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Vendor Assignment Nos.';
            TableRelation = "No. Series".Code;
        }
        field(73209577; "BLRConstruction Project Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Construction Project Nos.';
            TableRelation = "No. Series".Code;
        }
        field(73209578; "BLRMilestone Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Milestone Nos.';
            TableRelation = "No. Series".Code;
        }
        field(73209579; "BLRMilestone Task Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Milestone Task Nos.';
            TableRelation = "No. Series".Code;
        }
        field(73209580; "BLRMilestone Sub Task Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Milestone Sub Task Nos.';
            TableRelation = "No. Series".Code;
        }
        field(73209581; "BLRVendor Profile Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Vendor Profile Nos.';
            TableRelation = "No. Series".Code;
        }
        field(73209582; "BLRVendor Proposal Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Vendor Proposal Nos.';
            TableRelation = "No. Series".Code;
        }
        field(73209583; "BLRVendor Contract Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Vendor Contract Nos.';
            TableRelation = "No. Series".Code;
        }
        field(73209584; "BLROEM ID Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'OEM ID';
            TableRelation = "No. Series".Code;
        }
        field(73209585; "BLREquipment ID Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Equipment ID';
            TableRelation = "No. Series".Code;
        }
        field(73209586; "BLRPart ID Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Part ID';
            TableRelation = "No. Series".Code;
        }
        field(73209587; "BLRSub-Equipment ID Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Sub-Equipment ID';
            TableRelation = "No. Series".Code;
        }
        field(73209588; "BLRService Request ID Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Service Request ID';
            TableRelation = "No. Series".Code;
        }
        field(73209589; "BLRService Type ID Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Service Type ID';
            TableRelation = "No. Series".Code;
        }
        field(73209590; "BLRService Sub-Type ID Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Service Sub-Type ID';
            TableRelation = "No. Series".Code;
        }
        field(73209591; "BLROpportunity ID Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Opportunity ID';
            TableRelation = "No. Series".Code;
        }
        field(73209592; "BLRLead ID Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series".Code;
        }
        field(73209593; "BLRProject Budget ID Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series".Code;
        }
        field(73209594; "BLRClient Info ID Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series".Code;
        }
        field(73209595; "BLRSales Proposal ID Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series".Code;
        }
        field(73209596; "BLRCustEligIDNos"; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series".Code;
        }
        field(73209597; "BLRPayment Receipt ID Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series".Code;
        }
        field(73209598; "BLRManagement Fee Master"; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series".Code;
        }
    }
    keys
    {
        key(PK;"BLRPrimary Key")
        {
            Clustered = true;
        }
    }
}
