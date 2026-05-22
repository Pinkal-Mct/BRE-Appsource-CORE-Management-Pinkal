table 73209685 "BLRSecurityDepositeLedger"
{
    DataClassification = CustomerContent;
    Caption = 'Security Deposite Ledger';

    fields
    {
        field(73209575; "BLRLedger ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Ledger ID';
            Editable = false;
        }

        field(73209576; "BLRContract ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
            TableRelation = "BLRTenancyContract"."BLRContract ID";
        }

        field(73209577; "BLRTenant ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
            TableRelation = Customer."No.";
        }

        field(73209578; "BLRProperty ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Property ID';
            TableRelation = "BLRPropertyRegistration"."BLRProperty ID";
        }
        field(73209579; "BLRTransaction Date"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Transaction Date';
            Editable = false;
        }

        field(73209580; "BLRTransaction Type"; Option)
        {
            DataClassification = CustomerContent;
            // DataClassification = ToBeClassified;
            OptionMembers = " ","Deposit","Deduction","Refund";
            Caption = 'Transaction Type';
        }
        field(73209581; "BLRInitial Deposit Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Initial Deposit Amount';
        }
        field(73209582; "BLRUnpaid Rent Deduction"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Unpaid Rent Deduction';
        }
        field(73209583; "BLRDamage Charges Deduction"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Damage Charges Deduction';
        }
        field(73209584; "BLRPenalty Deduction"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Penalty Deduction';
        }
        field(73209585; "BLRService Charges Deduction"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Service Charges Deduction';
        }
        field(73209586; "BLROther Deductions"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Other Deductions';
        }
        field(73209587; "BLRTotal Deductions"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Deductions';
        }
        field(73209588; "BLRRefundable Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Refundable Amount';
        }
        field(73209589; "BLRApproval Status"; Enum "Approval Status Enum")
        {
            DataClassification = CustomerContent;
            Caption = 'Approval Status';
        }
        field(73209590; "BLRProcessed By"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Processed By';
            // TableRelation = User;
        }
        field(73209591; "BLRFinal Settlement Date"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Final Settlement Date';
        }
    }

    keys
    {
        key(Key1;"BLRLedger ID")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit "No. Series";
    begin
        "BLRTransaction Date" := CurrentDateTime;
        "BLRTotal Deductions" := "BLRUnpaid Rent Deduction" + "BLRDamage Charges Deduction" + "BLRPenalty Deduction" + "BLRService Charges Deduction" + "BLROther Deductions";
        "BLRRefundable Amount" := "BLRInitial Deposit Amount" - "BLRTotal Deductions";
        if "BLRLedger ID" = '' then
            "BLRLedger ID" := NoSeriesMgt.GetNextNo('S-DEPOSITLEDGER', Today(), true);
    end;

    trigger OnModify()
    begin
        "BLRTransaction Date" := CurrentDateTime;
        "BLRTotal Deductions" := "BLRUnpaid Rent Deduction" + "BLRDamage Charges Deduction" + "BLRPenalty Deduction" + "BLRService Charges Deduction" + "BLROther Deductions";
        "BLRRefundable Amount" := "BLRInitial Deposit Amount" - "BLRTotal Deductions";
    end;
}
