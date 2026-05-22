table 73209594 "BLRCOASetup"
{
    DataClassification = SystemMetadata;

    fields
    {
        field(73209575; "BLRPrimary Key"; Code[10])
        {
            DataClassification = SystemMetadata;
        }
        field(73209576; "BLRResidential Rent"; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Residential Rent';
            TableRelation = "G/L Account"."No.";
        }
        field(73209577; "BLRCommercial Rent"; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Commercial Rent';
            TableRelation = "G/L Account"."No.";
        }
        field(73209578; "BLRResidential Unearned Rent"; code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Residential-Unearned Rent';
            TableRelation = "G/L Account"."No.";
        }
        field(73209579; "BLRCommercial Unearned Rent"; code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Commercial-Unearned Rent';
            TableRelation = "G/L Account"."No.";
        }
        field(73209580; "BLRCash"; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Cash';
            TableRelation = "G/L Account"."No.";
        }
        field(73209581; "BLRPDC Received"; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'PDC Received';
            TableRelation = "G/L Account"."No.";
        }
        field(73209582; "BLRPDC Collection/Return"; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'PDC Collection/Return';
            TableRelation = "G/L Account"."No.";
        }
        field(73209583; "BLRPDC Issued"; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'PDC Issued';
            TableRelation = "G/L Account"."No.";
        }
        field(73209584; "BLRPDC Cleared/Returned"; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'PDC Cleared/Returned';
            TableRelation = "G/L Account"."No.";
        }
        field(73209585; "BLRTenantRecvsRes"; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Tenant Receivables-Residential';
            TableRelation = "G/L Account"."No.";
        }
        field(73209586; "BLRTenantRecvsComm"; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Tenant Receivables-Commercial';
            TableRelation = "G/L Account"."No.";
        }
        field(73209587; "BLRCarried Forward in SD"; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Carried forward In-Security Deposits';
            TableRelation = "G/L Account"."No.";
        }
        field(73209588; "BLRCarried Forward Out SD"; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Carried forward Out-Security Deposits';
            TableRelation = "G/L Account"."No.";
        }
        field(73209589; "BLRPDC Liabilities"; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'PDC Liabilities';
            TableRelation = "G/L Account"."No.";
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
