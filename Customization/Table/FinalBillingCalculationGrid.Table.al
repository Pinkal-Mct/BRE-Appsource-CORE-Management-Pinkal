table 73209616 "BLRFinalBillingCalculationGrid"
{
    DataClassification = CustomerContent;
    Caption = 'Final Billing Calculation Grid';
    fields
    {
        field(73209575; "BLRRevenueDescription"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Revenue Description';
        }
        field(73209576; "BLRInvoicedAmount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoiced Amount';
        }
        field(73209577; "BLRInvoicedVAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoiced VAT';
        }
        field(73209578; "BLRInvoicedAmountInclVAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoiced Amount Incl. VAT';
        }
        field(73209579; "BLRRevisedAmount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Revised Amount';
        }
        field(73209580; "BLRRevisedVAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Revised VAT';
        }
        field(73209581; "BLRRevisedAmountInclVAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Revised Amount Incl. VAT';
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
        field(73209587; "BLRTotal Invoiced Amount"; Decimal)
        {
            Caption = 'Total Invoiced Amount';
            FieldClass = FlowField;
            CalcFormula = sum("BLRFinalBillingCalculationGrid"."BLRInvoicedAmount" where("BLRContract ID" = field("BLRContract ID")));
        }
        field(73209588; "BLRTotal Invoiced VAT"; Decimal)
        {
            Caption = 'Total Invoiced VAT';
            FieldClass = FlowField;
            CalcFormula = sum("BLRFinalBillingCalculationGrid"."BLRInvoicedVAT" where("BLRContract ID" = field("BLRContract ID")));
        }
        field(73209589; "BLRTotalInvdAmtInclVAT"; Decimal)
        {
            Caption = 'Total Invoiced AmountIncl. VAT';
            FieldClass = FlowField;
            CalcFormula = sum("BLRFinalBillingCalculationGrid"."BLRInvoicedAmountInclVAT" where("BLRContract ID" = field("BLRContract ID")));
        }
        field(73209590; "BLRTotal Revised Amount"; Decimal)
        {
            Caption = 'Total Revised Amount';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("BLRFinalBillingCalculationGrid"."BLRRevisedAmount" where("BLRContract ID" = field("BLRContract ID")));
        }
        field(73209591; "BLRTotal Revised VAT"; Decimal)
        {
            Caption = 'Total Revised VAT';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("BLRFinalBillingCalculationGrid"."BLRRevisedVAT" where("BLRContract ID" = field("BLRContract ID")));
        }
        field(73209592; "BLRTotalRevAmtInclVAT"; Decimal)
        {
            Caption = 'Total Revised AmountIncl. VAT';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("BLRFinalBillingCalculationGrid"."BLRRevisedAmountInclVAT" where("BLRContract ID" = field("BLRContract ID")));
        }
        field(73209593; "BLRTotal Differnece Amount"; Decimal)
        {
            Caption = 'Total Difference Amount';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("BLRFinalBillingCalculationGrid"."BLRDifferenceAmount" where("BLRContract ID" = field("BLRContract ID")));
        }
        field(73209594; "BLRTotal Difference VAT"; Decimal)
        {
            Caption = 'Total Invoiced Amount';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("BLRFinalBillingCalculationGrid"."BLRDifferenceVAT" where("BLRContract ID" = field("BLRContract ID")));
        }
        field(73209595; "BLRTotalDiffAmtInclVAT"; Decimal)
        {
            Caption = 'Total Difference Amount Incl. VAT';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("BLRFinalBillingCalculationGrid"."BLRDifferenceAmountInclVAT" where("BLRContract ID" = field("BLRContract ID")));
        }
        field(73209596; "BLRTermination Date"; Date)
        {
            Caption = 'Termination Date';
            DataClassification = CustomerContent;
        }
        field(73209597; "BLRInvoice To Be Raised"; Decimal)
        {
            Caption = 'Invoice To Be Raised';
            DataClassification = CustomerContent;
        }
        field(73209598; "BLRCredit Note To Be Raised"; Decimal)
        {
            Caption = 'Credit To Be Raised';
            DataClassification = CustomerContent;
        }
        field(73209599; "BLRPayment Type"; Text[250])
        {
            Caption = 'Payment Type';
            DataClassification = CustomerContent;
        }
        field(73209600; "BLRProperty Classification"; Text[20])
        {
            Caption = 'Property Classification';
            DataClassification = CustomerContent;
        }
        field(73209601; "BLRInvoiced"; Boolean)
        {
            Caption = 'Invoiced';
            DataClassification = CustomerContent;
        }
        field(73209602; "BLRTenant ID"; Code[50])
        {
            Caption = 'Tenant ID';
            DataClassification = CustomerContent;
        }
        field(73209603; "BLRInvoice ID"; Text[20])
        {
            Caption = 'Invoice ID';
            DataClassification = CustomerContent;
        }
        field(73209604; "BLRPosted Invoice ID"; Code[20])
        {
            Caption = 'Posted Invoice ID';
            DataClassification = CustomerContent;
        }
        field(73209605; "BLRInvoice Document"; Text[250])
        {
            Caption = 'Invoice Document';
            DataClassification = CustomerContent;
        }
        field(73209606; "BLRInvoice Document URL"; Text[250])
        {
            Caption = 'Invoice Document URL';
            DataClassification = CustomerContent;
        }
        field(73209607; "BLRVAT %"; Integer)
        {
            Caption = 'VAT %';
            DataClassification = CustomerContent;
        }
        field(73209608; "BLRCreditnote"; Boolean)
        {
            Caption = 'Creditnote';
            DataClassification = CustomerContent;
        }
        field(73209609; "BLRCredit Note Amount"; Decimal)
        {
            Caption = 'Credit Note Amount';
            DataClassification = CustomerContent;
        }
        field(73209610; "BLRInvoice Amount"; Decimal)
        {
            Caption = 'Invoice Amount';
            DataClassification = CustomerContent;
        }
        field(73209611; "BLRCredit Note ID"; Code[1000])
        {
            Caption = 'Credit Note ID';
            DataClassification = CustomerContent;
        }
        field(73209612; "BLRCredit Note Document"; Text[250])
        {
            Caption = 'Credit Note Document';
            DataClassification = CustomerContent;
        }
        field(73209613; "BLRCredit Note Document URL"; Text[250])
        {
            Caption = 'Credit Note Document URL';
            DataClassification = CustomerContent;
        }
        field(73209614; "BLRLine"; Code[50])
        {
            Caption = 'Credit Note Posted ID';
            DataClassification = CustomerContent;
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
