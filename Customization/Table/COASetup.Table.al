table 73209594 "COA Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(73209575; "Primary Key"; Code[10])
        {
            DataClassification = SystemMetadata;
        }
        field(73209576; "Residential Rent"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Residential Rent';
            TableRelation = "G/L Account"."No.";
        }
        field(73209577; "Commercial Rent"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Commercial Rent';
            TableRelation = "G/L Account"."No.";
        }
        field(73209578; "Residential Unearned Rent"; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Residential-Unearned Rent';
            TableRelation = "G/L Account"."No.";
        }
        field(73209579; "Commercial Unearned Rent"; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Commercial-Unearned Rent';
            TableRelation = "G/L Account"."No.";
        }
        field(73209580; "Cash"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Cash';
            TableRelation = "G/L Account"."No.";
        }
        field(73209581; "PDC Received"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'PDC Received';
            TableRelation = "G/L Account"."No.";
        }
        field(73209582; "PDC Collection/Return"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'PDC Collection/Return';
            TableRelation = "G/L Account"."No.";
        }
        field(73209583; "PDC Issued"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'PDC Issued';
            TableRelation = "G/L Account"."No.";
        }
        field(73209584; "PDC Cleared/Returned"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'PDC Cleared/Returned';
            TableRelation = "G/L Account"."No.";
        }
        field(73209585; "Tenant Receivables-Residential"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant Receivables-Residential';
            TableRelation = "G/L Account"."No.";
        }
        field(73209586; "Tenant Receivables-Commercial"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant Receivables-Commercial';
            TableRelation = "G/L Account"."No.";
        }
        field(73209587; "Carried Forward in SD"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Carried forward In-Security Deposits';
            TableRelation = "G/L Account"."No.";
        }
        field(73209588; "Carried Forward Out SD"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Carried forward Out-Security Deposits';
            TableRelation = "G/L Account"."No.";
        }
        field(73209589; "PDC Liabilities"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'PDC Liabilities';
            TableRelation = "G/L Account"."No.";
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