table 73209621 "Final Revenue Calculation Grid"
{
    DataClassification = CustomerContent;
    Caption = 'Final Revenue Calculation Grid';
    fields
    {
        field(73209575; "Contract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }
        field(73209576; "Revenue Description"; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Revenue Description';
        }
        field(73209577; "Original Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
            DecimalPlaces = 2 : 2;
        }
        field(73209578; "Original VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT';
            DecimalPlaces = 2 : 2;
        }
        field(73209579; "Original Amount Incl."; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount incl.';
            DecimalPlaces = 2 : 2;
        }
        field(73209580; "Revised Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Revised Amount';
            DecimalPlaces = 2 : 2;
        }
        field(73209581; "Revised VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Revised VAT';
            DecimalPlaces = 2 : 2;
        }
        field(73209582; "Revised Amount Incl."; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Revised Amount Incl.';
            DecimalPlaces = 2 : 2;
        }
        field(73209583; "Difference Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Difference Amount';
            DecimalPlaces = 2 : 2;
        }
        field(73209584; "Difference VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Difference VAT';
            DecimalPlaces = 2 : 2;
        }
        field(73209585; "Difference Amount Incl."; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Difference Amount Incl.';
            DecimalPlaces = 2 : 2;
        }
        field(73209586; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(73209587; "Actual Contract Tenure"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Actual Contract Tenure';
        }
        field(73209588; "Per Day Rent"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Per Day Rent';
        }
        field(73209589; "Revised VAT %"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Revised VAT %';
        }
        field(73209590; "ContractYear(Termination Date)"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Year On Termination Date';
        }
        field(73209591; "Annual Rent Amount TermiYear"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Annual Rent Amount of Termination Year';
        }
        field(73209592; "Total No. Of Days"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Total No. Of Days(Termination Year)';
        }
        field(73209593; "Total Original Amount"; Decimal)
        {
            Caption = 'Total Original Amount';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("Final Revenue Calculation Grid"."Original Amount" where("Contract ID" = field("Contract ID")));
        }
        field(73209594; "Total Original VAT"; Decimal)
        {
            Caption = 'Total Original VAT';
            FieldClass = FlowField;
            CalcFormula = sum("Final Revenue Calculation Grid"."Original VAT" where("Contract ID" = field("Contract ID")));
        }
        field(73209595; "Total Orgininal AmountIncl.VAT"; Decimal)
        {
            Caption = 'Total Orgininal Amount Incl. VAT';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("Final Revenue Calculation Grid"."Original Amount Incl." where("Contract ID" = field("Contract ID")));
        }
        field(73209596; "Total Revised Amount"; Decimal)
        {
            Caption = 'Total Revised Amount';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("Final Revenue Calculation Grid"."Revised Amount" where("Contract ID" = field("Contract ID")));
        }
        field(73209597; "Total Revised VAT"; Decimal)
        {
            Caption = 'Total Revised VAT';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("Final Revenue Calculation Grid"."Revised VAT" where("Contract ID" = field("Contract ID")));
        }
        field(73209598; "Total Revised AmountIncl.VAT"; Decimal)
        {
            Caption = 'Total Revised Amount Incl. VAT';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("Final Revenue Calculation Grid"."Revised Amount Incl." where("Contract ID" = field("Contract ID")));
        }
        field(73209599; "Total Difference Amount"; Decimal)
        {
            Caption = 'Total Difference Amount';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("Final Revenue Calculation Grid"."Difference Amount" where("Contract ID" = field("Contract ID")));
        }
        field(73209600; "Total Difference VAT"; Decimal)
        {
            Caption = 'Total Difference VAT';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("Final Revenue Calculation Grid"."Difference VAT" where("Contract ID" = field("Contract ID")));
        }
        field(73209601; "Total DifferenceAmountIncl.VAT"; Decimal)
        {
            Caption = 'Total Difference Amount Incl. VAT"';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("Final Revenue Calculation Grid"."Difference Amount Incl." where("Contract ID" = field("Contract ID")));
        }
        field(73209602; "Payment Type"; Text[250])
        {
            Caption = 'Payment Type';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Contract ID", "Entry No.")
        {
            Clustered = true;
        }
    }
}
