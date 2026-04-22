table 73209685 "Security Deposite Ledger"
{
    DataClassification = ToBeClassified;
    Caption = 'Security Deposite Ledger';

    fields
    {
        field(73209575; "Ledger ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Ledger ID';
            Editable = false;
        }

        field(73209576; "Contract ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
            TableRelation = "Tenancy Contract"."Contract ID";
        }

        field(73209577; "Tenant ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant ID';
            TableRelation = Customer."No.";
        }

        field(73209578; "Property ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property ID';
            TableRelation = "Property Registration"."Property ID";
        }
        field(73209579; "Transaction Date"; DateTime)
        {
            DataClassification = ToBeClassified;
            Caption = 'Transaction Date';
            Editable = false;
        }

        field(73209580; "Transaction Type"; Option)
        {
            // DataClassification = ToBeClassified;
            OptionMembers = " ","Deposit","Deduction","Refund";
            Caption = 'Transaction Type';
        }
        field(73209581; "Initial Deposit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Initial Deposit Amount';
        }
        field(73209582; "Unpaid Rent Deduction"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Unpaid Rent Deduction';
        }
        field(73209583; "Damage Charges Deduction"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Damage Charges Deduction';
        }
        field(73209584; "Penalty Deduction"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Penalty Deduction';
        }
        field(73209585; "Service Charges Deduction"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Service Charges Deduction';
        }
        field(73209586; "Other Deductions"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Other Deductions';
        }
        field(73209587; "Total Deductions"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Deductions';
        }
        field(73209588; "Refundable Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Refundable Amount';
        }
        field(73209589; "Approval Status"; Enum "Approval Status Enum")
        {
            DataClassification = ToBeClassified;
            Caption = 'Approval Status';
        }
        field(73209590; "Processed By"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Processed By';
            // TableRelation = User;
        }
        field(73209591; "Final Settlement Date"; DateTime)
        {
            DataClassification = ToBeClassified;
            Caption = 'Final Settlement Date';
        }
    }

    keys
    {
        key(Key1; "Ledger ID")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit "No. Series";
    begin
        "Transaction Date" := CurrentDateTime;
        "Total Deductions" := "Unpaid Rent Deduction" + "Damage Charges Deduction" + "Penalty Deduction" + "Service Charges Deduction" + "Other Deductions";
        "Refundable Amount" := "Initial Deposit Amount" - "Total Deductions";
        if "Ledger ID" = '' then
            "Ledger ID" := NoSeriesMgt.GetNextNo('S-DEPOSITLEDGER', Today(), true);
    end;

    trigger OnModify()
    begin
        "Transaction Date" := CurrentDateTime;
        "Total Deductions" := "Unpaid Rent Deduction" + "Damage Charges Deduction" + "Penalty Deduction" + "Service Charges Deduction" + "Other Deductions";
        "Refundable Amount" := "Initial Deposit Amount" - "Total Deductions";
    end;
}