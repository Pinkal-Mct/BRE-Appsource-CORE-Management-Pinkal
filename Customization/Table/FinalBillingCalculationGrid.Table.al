table 73209616 "Final Billing Calculation Grid"
{
    DataClassification = CustomerContent;
    Caption = 'Final Billing Calculation Grid';
    fields
    {
        field(73209575; RevenueDescription; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Revenue Description';
        }
        field(73209576; InvoicedAmount; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoiced Amount';
        }
        field(73209577; InvoicedVAT; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoiced VAT';
        }
        field(73209578; InvoicedAmountInclVAT; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoiced Amount Incl. VAT';
        }
        field(73209579; RevisedAmount; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Revised Amount';
        }
        field(73209580; RevisedVAT; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Revised VAT';
        }
        field(73209581; RevisedAmountInclVAT; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Revised Amount Incl. VAT';
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
        field(73209587; "Total Invoiced Amount"; Decimal)
        {
            Caption = 'Total Invoiced Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Final Billing Calculation Grid"."InvoicedAmount" where("Contract ID" = field("Contract ID")));
        }
        field(73209588; "Total Invoiced VAT"; Decimal)
        {
            Caption = 'Total Invoiced VAT';
            FieldClass = FlowField;
            CalcFormula = sum("Final Billing Calculation Grid"."InvoicedVAT" where("Contract ID" = field("Contract ID")));
        }
        field(73209589; "Total Invoiced AmountIncl. VAT"; Decimal)
        {
            Caption = 'Total Invoiced AmountIncl. VAT';
            FieldClass = FlowField;
            CalcFormula = sum("Final Billing Calculation Grid"."InvoicedAmountInclVAT" where("Contract ID" = field("Contract ID")));
        }
        field(73209590; "Total Revised Amount"; Decimal)
        {
            Caption = 'Total Revised Amount';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("Final Billing Calculation Grid"."RevisedAmount" where("Contract ID" = field("Contract ID")));
        }
        field(73209591; "Total Revised VAT"; Decimal)
        {
            Caption = 'Total Revised VAT';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("Final Billing Calculation Grid"."RevisedVAT" where("Contract ID" = field("Contract ID")));
        }
        field(73209592; "Total Revised AmountIncl.VAT"; Decimal)
        {
            Caption = 'Total Revised AmountIncl. VAT';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("Final Billing Calculation Grid"."RevisedAmountInclVAT" where("Contract ID" = field("Contract ID")));
        }
        field(73209593; "Total Differnece Amount"; Decimal)
        {
            Caption = 'Total Difference Amount';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("Final Billing Calculation Grid"."DifferenceAmount" where("Contract ID" = field("Contract ID")));
        }
        field(73209594; "Total Difference VAT"; Decimal)
        {
            Caption = 'Total Invoiced Amount';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("Final Billing Calculation Grid"."DifferenceVAT" where("Contract ID" = field("Contract ID")));
        }
        field(73209595; "Total DifferenceAmountIncl.VAT"; Decimal)
        {
            Caption = 'Total Difference Amount Incl. VAT';
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum("Final Billing Calculation Grid"."DifferenceAmountInclVAT" where("Contract ID" = field("Contract ID")));
        }
        field(73209596; "Termination Date"; Date)
        {
            Caption = 'Termination Date';
            DataClassification = CustomerContent;
        }
        field(73209597; "Invoice To Be Raised"; Decimal)
        {
            Caption = 'Invoice To Be Raised';
            DataClassification = CustomerContent;
        }
        field(73209598; "Credit Note To Be Raised"; Decimal)
        {
            Caption = 'Credit To Be Raised';
            DataClassification = CustomerContent;
        }
        field(73209599; "Payment Type"; Text[250])
        {
            Caption = 'Payment Type';
            DataClassification = CustomerContent;
        }
        field(73209600; "Property Classification"; Text[20])
        {
            Caption = 'Property Classification';
            DataClassification = CustomerContent;
        }
        field(73209601; "Invoiced"; Boolean)
        {
            Caption = 'Invoiced';
            DataClassification = CustomerContent;
        }
        field(73209602; "Tenant ID"; Code[50])
        {
            Caption = 'Tenant ID';
            DataClassification = CustomerContent;
        }
        field(73209603; "Invoice ID"; Text[20])
        {
            Caption = 'Invoice ID';
            DataClassification = CustomerContent;
        }
        field(73209604; "Posted Invoice ID"; Code[20])
        {
            Caption = 'Posted Invoice ID';
            DataClassification = CustomerContent;
        }
        field(73209605; "Invoice Document"; Text[250])
        {
            Caption = 'Invoice Document';
            DataClassification = CustomerContent;
        }
        field(73209606; "Invoice Document URL"; Text[250])
        {
            Caption = 'Invoice Document URL';
            DataClassification = CustomerContent;
        }
        field(73209607; "VAT %"; Integer)
        {
            Caption = 'VAT %';
            DataClassification = CustomerContent;
        }
        field(73209608; "Creditnote"; Boolean)
        {
            Caption = 'Creditnote';
            DataClassification = CustomerContent;
        }
        field(73209609; "Credit Note Amount"; Decimal)
        {
            Caption = 'Credit Note Amount';
            DataClassification = CustomerContent;
        }
        field(73209610; "Invoice Amount"; Decimal)
        {
            Caption = 'Invoice Amount';
            DataClassification = CustomerContent;
        }
        field(73209611; "Credit Note ID"; Code[1000])
        {
            Caption = 'Credit Note ID';
            DataClassification = CustomerContent;
        }
        field(73209612; "Credit Note Document"; Text[250])
        {
            Caption = 'Credit Note Document';
            DataClassification = CustomerContent;
        }
        field(73209613; "Credit Note Document URL"; Text[250])
        {
            Caption = 'Credit Note Document URL';
            DataClassification = CustomerContent;
        }
        field(73209614; "Line"; Code[50])
        {
            Caption = 'Credit Note Posted ID';
            DataClassification = CustomerContent;
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
