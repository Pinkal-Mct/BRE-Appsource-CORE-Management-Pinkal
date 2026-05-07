table 73209656 "Pending Receviable Grid"
{
    DataClassification = CustomerContent;
    Caption = 'Pending Receviable Grid';
    fields
    {
        field(73209575; RevenueDescription; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Revenue Description';
        }
        field(73209576; RevisedAmount; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Revised Amount';
        }
        field(73209577; RevisedVAT; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Revised VAT';
        }
        field(73209578; RevisedAmountInclVAT; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Revised Amount Incl. VAT';
        }
        field(73209579; ReceiptsAmount; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Receipts Amount';
        }
        field(73209580; ReceiptsVAT; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Receipts VAT';
        }
        field(73209581; ReceiptsAmountInclVAT; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Receipts Amount Incl. VAT';
        }
        field(73209582; DifferenceAmount; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Difference Amount';
        }
        field(73209583; DifferenceVAT; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Difference VAT';
        }
        field(73209584; DifferenceAmountInclVAT; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Difference Amount Incl. VAT';
        }
        field(73209585; "Contract ID"; Integer)
        {
            Caption = 'Contract ID';
            DataClassification = CustomerContent;
        }
        field(73209586; "Entry No"; Integer)
        {
            Caption = 'Entry No';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(73209587; "Termination Date"; Date)
        {
            Caption = 'Termination Date';
            DataClassification = CustomerContent;
        }
        field(73209588; "Total Refundable"; Decimal)
        {
            Caption = 'Total Refundable';
            DataClassification = CustomerContent;
        }
        field(73209589; "Total Receivable"; Decimal)
        {
            Caption = 'Total Receivable';
            DataClassification = CustomerContent;
        }
        field(73209590; "Total Revised Amount"; Decimal)
        {
            Caption = 'Total Revised Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Pending Receviable Grid".RevisedAmount where("Contract ID" = field("Contract ID")));
        }
        field(73209591; "Total Revised VAT"; Decimal)
        {
            Caption = 'Total Revised VAT';
            FieldClass = FlowField;
            CalcFormula = sum("Pending Receviable Grid".RevisedVAT where("Contract ID" = field("Contract ID")));
        }
        field(73209592; "Total Revised AmountIncl. VAT"; Decimal)
        {
            Caption = 'Total Revised AmountIncl. VAT';
            FieldClass = FlowField;
            CalcFormula = sum("Pending Receviable Grid".RevisedAmountInclVAT where("Contract ID" = field("Contract ID")));
        }
        field(73209593; "Total Receipts Amount"; Decimal)
        {
            Caption = 'Total Receipts Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Pending Receviable Grid".ReceiptsAmount where("Contract ID" = field("Contract ID")));
        }
        field(73209594; "Total Receipts VAT"; Decimal)
        {
            Caption = 'Total Receipts VAT';
            FieldClass = FlowField;
            CalcFormula = sum("Pending Receviable Grid".ReceiptsVAT where("Contract ID" = field("Contract ID")));
        }
        field(73209595; "Total Receipts AmountIncl. VAT"; Decimal)
        {
            Caption = 'Total Receipts AmountIncl. VAT';
            FieldClass = FlowField;
            CalcFormula = sum("Pending Receviable Grid".ReceiptsAmountInclVAT where("Contract ID" = field("Contract ID")));
        }
        field(73209596; "Payment Type"; Text[250])
        {
            Caption = 'Payment Type';
            DataClassification = CustomerContent;
        }
        field(73209597; "Tenant ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
        }
        field(73209598; "Unit Type"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Type';
        }
        field(73209599; "GeneratedCRMemoSD"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Generated CR Memo Security Deposit';
            InitValue = false;
        }
        field(73209600; "CrditNoteID Security Deposit"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Note ID Security Deposit';
        }
    }
    keys
    {
        key(PK; "Contract ID", "Entry No")
        {
            Clustered = true;
        }
    }
}
