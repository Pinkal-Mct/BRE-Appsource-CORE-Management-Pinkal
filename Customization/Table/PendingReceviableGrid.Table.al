table 73209656 "BLRPendingReceviableGrid"
{
    DataClassification = CustomerContent;
    Caption = 'Pending Receviable Grid';
    fields
    {
        field(73209575; "BLRRevenueDescription"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Revenue Description';
        }
        field(73209576; "BLRRevisedAmount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Revised Amount';
        }
        field(73209577; "BLRRevisedVAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Revised VAT';
        }
        field(73209578; "BLRRevisedAmountInclVAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Revised Amount Incl. VAT';
        }
        field(73209579; "BLRReceiptsAmount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Receipts Amount';
        }
        field(73209580; "BLRReceiptsVAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Receipts VAT';
        }
        field(73209581; "BLRReceiptsAmountInclVAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Receipts Amount Incl. VAT';
        }
        field(73209582; "BLRDifferenceAmount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Difference Amount';
        }
        field(73209583; "BLRDifferenceVAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Difference VAT';
        }
        field(73209584; "BLRDifferenceAmountInclVAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Difference Amount Incl. VAT';
        }
        field(73209585; "BLRContract ID"; Integer)
        {
            Caption = 'Contract ID';
            DataClassification = CustomerContent;
        }
        field(73209586; "BLREntry No"; Integer)
        {
            Caption = 'Entry No';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(73209587; "BLRTermination Date"; Date)
        {
            Caption = 'Termination Date';
            DataClassification = CustomerContent;
        }
        field(73209588; "BLRTotal Refundable"; Decimal)
        {
            Caption = 'Total Refundable';
            DataClassification = CustomerContent;
        }
        field(73209589; "BLRTotal Receivable"; Decimal)
        {
            Caption = 'Total Receivable';
            DataClassification = CustomerContent;
        }
        field(73209590; "BLRTotal Revised Amount"; Decimal)
        {
            Caption = 'Total Revised Amount';
            FieldClass = FlowField;
            CalcFormula = sum("BLRPendingReceviableGrid"."BLRRevisedAmount" where("BLRContract ID" = field("BLRContract ID")));
        }
        field(73209591; "BLRTotal Revised VAT"; Decimal)
        {
            Caption = 'Total Revised VAT';
            FieldClass = FlowField;
            CalcFormula = sum("BLRPendingReceviableGrid"."BLRRevisedVAT" where("BLRContract ID" = field("BLRContract ID")));
        }
        field(73209592; "BLRTotalRevAmtInclVAT"; Decimal)
        {
            Caption = 'Total Revised AmountIncl. VAT';
            FieldClass = FlowField;
            CalcFormula = sum("BLRPendingReceviableGrid"."BLRRevisedAmountInclVAT" where("BLRContract ID" = field("BLRContract ID")));
        }
        field(73209593; "BLRTotal Receipts Amount"; Decimal)
        {
            Caption = 'Total Receipts Amount';
            FieldClass = FlowField;
            CalcFormula = sum("BLRPendingReceviableGrid"."BLRReceiptsAmount" where("BLRContract ID" = field("BLRContract ID")));
        }
        field(73209594; "BLRTotal Receipts VAT"; Decimal)
        {
            Caption = 'Total Receipts VAT';
            FieldClass = FlowField;
            CalcFormula = sum("BLRPendingReceviableGrid"."BLRReceiptsVAT" where("BLRContract ID" = field("BLRContract ID")));
        }
        field(73209595; "BLRTotalRcptsAmtInclVAT"; Decimal)
        {
            Caption = 'Total Receipts AmountIncl. VAT';
            FieldClass = FlowField;
            CalcFormula = sum("BLRPendingReceviableGrid"."BLRReceiptsAmountInclVAT" where("BLRContract ID" = field("BLRContract ID")));
        }
        field(73209596; "BLRPayment Type"; Text[250])
        {
            Caption = 'Payment Type';
            DataClassification = CustomerContent;
        }
        field(73209597; "BLRTenant ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenant ID';
        }
        field(73209598; "BLRUnit Type"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Type';
        }
        field(73209599; "BLRGeneratedCRMemoSD"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Generated CR Memo Security Deposit';
            InitValue = false;
        }
        field(73209600; "BLRCrditNoteIDSecDep"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Note ID Security Deposit';
        }
    }
    keys
    {
        key(PK;"BLRContract ID", "BLREntry No")
        {
            Clustered = true;
        }
    }
}
