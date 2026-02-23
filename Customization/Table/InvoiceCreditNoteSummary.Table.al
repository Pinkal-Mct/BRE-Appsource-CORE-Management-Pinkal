table 53766 "InvoiceCreditNoteSummary"
{
    DataClassification = ToBeClassified;
    fields
    {

        field(53700; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(53701; "Contract No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(53702; "Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(53703; Invoice; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(53704; "Credit Note"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(53705; "Total Invoice"; Decimal)
        {
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum(InvoiceCreditNoteSummary."Invoice" where("Contract No." = field("Contract No.")));

        }
        field(53708; "Total Credit Note"; Decimal)
        {
            FieldClass = FlowField;
            DecimalPlaces = 2 : 2;
            CalcFormula = sum(InvoiceCreditNoteSummary."Credit Note" where("Contract No." = field("Contract No.")));
        }
        field(53706; Invoiced; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53707; "Credit Noted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53709; "Invoice ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(53710; "Credit Note ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(53711; "Revenue Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.", "Contract No.")
        {
            Clustered = true;
        }
    }

    procedure CalculateInvoiceCreditNoteSummary(var pFinancialAdjustContractReduction: Record FinancialAdjContractReduction)
    var
        InvoiceCreditNoteSummaryRec1: Record "InvoiceCreditNoteSummary";
    begin
        InvoiceCreditNoteSummaryRec1.SetRange("Contract No.", pFinancialAdjustContractReduction."Contract No.");
        InvoiceCreditNoteSummaryRec1.SetRange("Description", 'Finanacial Adjustments / Contract Reductions');
        InvoiceCreditNoteSummaryRec1.SetRange("Revenue Description", pFinancialAdjustContractReduction."Revenue Description");
        if InvoiceCreditNoteSummaryRec1.FindFirst() then begin
            InvoiceCreditNoteSummaryRec1."Credit Note" := pFinancialAdjustContractReduction."Amount Incl. VAT";
            InvoiceCreditNoteSummaryRec1.Modify(true);
        end
        else begin
            Clear(InvoiceCreditNoteSummaryRec1);
            InvoiceCreditNoteSummaryRec1.Init();
            InvoiceCreditNoteSummaryRec1."Contract No." := pFinancialAdjustContractReduction."Contract No.";
            InvoiceCreditNoteSummaryRec1.Description := 'Finanacial Adjustments / Contract Reductions';
            InvoiceCreditNoteSummaryRec1."Revenue Description" := pFinancialAdjustContractReduction."Revenue Description";
            InvoiceCreditNoteSummaryRec1."Credit Note" := pFinancialAdjustContractReduction."Amount Incl. VAT";
            InvoiceCreditNoteSummaryRec1.Insert(true)
        end;
    end;

    procedure CalculateTotalInvoiceAmount(var pTerminationAdditionalCharges: Record "Additional Charges Sub")
    var
        InvoiceCreditNoteSummaryRec: Record "InvoiceCreditNoteSummary";
    begin
        InvoiceCreditNoteSummaryRec.SetRange("Contract No.", pTerminationAdditionalCharges."Contract ID");
        InvoiceCreditNoteSummaryRec.SetRange("Description", 'Termination Additional Charges');
        InvoiceCreditNoteSummaryRec.SetRange("Revenue Description", pTerminationAdditionalCharges."Secondary Item Type");
        if InvoiceCreditNoteSummaryRec.FindFirst() then begin
            InvoiceCreditNoteSummaryRec.Invoice := pTerminationAdditionalCharges."Amount Including VAT";
            InvoiceCreditNoteSummaryRec.Modify(true);
        end
        else begin
            Clear(InvoiceCreditNoteSummaryRec);
            InvoiceCreditNoteSummaryRec.Init();
            InvoiceCreditNoteSummaryRec."Contract No." := pTerminationAdditionalCharges."Contract ID";
            InvoiceCreditNoteSummaryRec.Description := 'Termination Additional Charges';
            InvoiceCreditNoteSummaryRec."Revenue Description" := pTerminationAdditionalCharges."Secondary Item Type";
            InvoiceCreditNoteSummaryRec.Invoice := pTerminationAdditionalCharges."Amount Including VAT";
            InvoiceCreditNoteSummaryRec.Insert(true)
        end;
    end;

}