table 73209621 "BLRFinalRevenueCalculationGrid"
{
    DataClassification = CustomerContent;
    Caption = 'Final Revenue Calculation Grid';
    fields
    {
        field(73209575; "BLRContract ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract ID';
        }
        field(73209576; "BLRRevenue Description"; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Revenue Description';
        }
        field(73209577; "BLROriginal Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
            DecimalPlaces = 2 : 2;
        }
        field(73209578; "BLROriginal VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT';
            DecimalPlaces = 2 : 2;
        }
        field(73209579; "BLROriginal Amount Incl."; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount incl.';
            DecimalPlaces = 2 : 2;
        }
        field(73209580; "BLRRevised Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Revised Amount';
            DecimalPlaces = 2 : 2;
        }
        field(73209581; "BLRRevised VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Revised VAT';
            DecimalPlaces = 2 : 2;
        }
        field(73209582; "BLRRevised Amount Incl."; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Revised Amount Incl.';
            DecimalPlaces = 2 : 2;
        }
        field(73209583; "BLRDifference Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Difference Amount';
            DecimalPlaces = 2 : 2;
        }
        field(73209584; "BLRDifference VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Difference VAT';
            DecimalPlaces = 2 : 2;
        }
        field(73209585; "BLRDifference Amount Incl."; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Difference Amount Incl.';
            DecimalPlaces = 2 : 2;
        }
        field(73209586; "BLREntry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(73209587; "BLRActual Contract Tenure"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Actual Contract Tenure';
        }
        field(73209588; "BLRPer Day Rent"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Per Day Rent';
        }
        field(73209589; "BLRRevised VAT %"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Revised VAT %';
        }
        field(73209590; "BLRContYearTermDate"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Year On Termination Date';
        }
        field(73209591; "BLRAnnualRentAmtTermiYear"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Annual Rent Amount of Termination Year';
        }
        field(73209592; "BLRTotal No. Of Days"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Total No. Of Days(Termination Year)';
        }
        field(73209593; "BLRTotal Original Amount"; Decimal)
        {
            Caption = 'Total Original Amount';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("BLRFinalRevenueCalculationGrid"."BLROriginal Amount" where("BLRContract ID" = field("BLRContract ID")));
        }
        field(73209594; "BLRTotal Original VAT"; Decimal)
        {
            Caption = 'Total Original VAT';
            FieldClass = FlowField;
            CalcFormula = sum("BLRFinalRevenueCalculationGrid"."BLROriginal VAT" where("BLRContract ID" = field("BLRContract ID")));
        }
        field(73209595; "BLRTotalOrigAmtInclVAT"; Decimal)
        {
            Caption = 'Total Orgininal Amount Incl. VAT';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("BLRFinalRevenueCalculationGrid"."BLROriginal Amount Incl." where("BLRContract ID" = field("BLRContract ID")));
        }
        field(73209596; "BLRTotal Revised Amount"; Decimal)
        {
            Caption = 'Total Revised Amount';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("BLRFinalRevenueCalculationGrid"."BLRRevised Amount" where("BLRContract ID" = field("BLRContract ID")));
        }
        field(73209597; "BLRTotal Revised VAT"; Decimal)
        {
            Caption = 'Total Revised VAT';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("BLRFinalRevenueCalculationGrid"."BLRRevised VAT" where("BLRContract ID" = field("BLRContract ID")));
        }
        field(73209598; "BLRTotalRevAmtInclVAT"; Decimal)
        {
            Caption = 'Total "BLRRevised Amount Incl." VAT';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("BLRFinalRevenueCalculationGrid"."BLRRevised Amount Incl." where("BLRContract ID" = field("BLRContract ID")));
        }
        field(73209599; "BLRTotal Difference Amount"; Decimal)
        {
            Caption = 'Total Difference Amount';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("BLRFinalRevenueCalculationGrid"."BLRDifference Amount" where("BLRContract ID" = field("BLRContract ID")));
        }
        field(73209600; "BLRTotal Difference VAT"; Decimal)
        {
            Caption = 'Total Difference VAT';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("BLRFinalRevenueCalculationGrid"."BLRDifference VAT" where("BLRContract ID" = field("BLRContract ID")));
        }
        field(73209601; "BLRTotalDiffAmtInclVAT"; Decimal)
        {
            Caption = 'Total "BLRDifference Amount Incl." VAT"';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("BLRFinalRevenueCalculationGrid"."BLRDifference Amount Incl." where("BLRContract ID" = field("BLRContract ID")));
        }
        field(73209602; "BLRPayment Type"; Text[250])
        {
            Caption = 'Payment Type';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK;"BLRContract ID", "BLREntry No.")
        {
            Clustered = true;
        }
    }
}
