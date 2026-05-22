table 73209626 "BLRInvoiceCreditNoteSummary"
{
    DataClassification = CustomerContent;
    fields
    {

        field(73209575; "BLREntry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(73209576; "BLRContract No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209577; "BLRDescription"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209578; "BLRInvoice"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 2;
        }
        field(73209579; "BLRCredit Note"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 2;
        }
        field(73209580; "BLRTotal Invoice"; Decimal)
        {
            FieldClass = FlowField;
            DecimalPlaces = 0 : 2;
            CalcFormula = sum("BLRInvoiceCreditNoteSummary"."BLRInvoice" where("BLRContract No." = field("BLRContract No.")));

        }
        field(73209581; "BLRTotal Credit Note"; Decimal)
        {
            FieldClass = FlowField;
            DecimalPlaces = 0 : 2;
            CalcFormula = sum("BLRInvoiceCreditNoteSummary"."BLRCredit Note" where("BLRContract No." = field("BLRContract No.")));
        }
        field(73209582; "BLRInvoiced"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(73209583; "BLRCredit Noted"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(73209584; "BLRInvoice ID"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(73209585; "BLRCredit Note ID"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(73209586; "BLRRevenue Description"; Text[100])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1;"BLREntry No.", "BLRContract No.")
        {
            Clustered = true;
        }
    }

    procedure CalculateInvoiceCreditNoteSummary(var pFinancialAdjustContractReduction: Record "BLRFinAdjContractReduction")
    var
        InvoiceCreditNoteSummaryRec1: Record "BLRInvoiceCreditNoteSummary";
    begin
        InvoiceCreditNoteSummaryRec1.SetRange("BLRContract No.", pFinancialAdjustContractReduction."BLRContract No.");
        InvoiceCreditNoteSummaryRec1.SetRange("BLRDescription", 'Finanacial Adjustments / Contract Reductions');
        InvoiceCreditNoteSummaryRec1.SetRange("BLRRevenue Description", pFinancialAdjustContractReduction."BLRRevenue Description");
        if InvoiceCreditNoteSummaryRec1.FindFirst() then begin
            InvoiceCreditNoteSummaryRec1."BLRCredit Note" := pFinancialAdjustContractReduction."BLRAmount Incl. VAT";
            InvoiceCreditNoteSummaryRec1.Modify(true);
        end
        else begin
            Clear(InvoiceCreditNoteSummaryRec1);
            InvoiceCreditNoteSummaryRec1.Init();
            InvoiceCreditNoteSummaryRec1."BLRContract No." := pFinancialAdjustContractReduction."BLRContract No.";
            InvoiceCreditNoteSummaryRec1."BLRDescription" := 'Finanacial Adjustments / Contract Reductions';
            InvoiceCreditNoteSummaryRec1."BLRRevenue Description" := pFinancialAdjustContractReduction."BLRRevenue Description";
            InvoiceCreditNoteSummaryRec1."BLRCredit Note" := pFinancialAdjustContractReduction."BLRAmount Incl. VAT";
            InvoiceCreditNoteSummaryRec1.Insert(true)
        end;
    end;

    procedure CalculateTotalInvoiceAmount(var pTerminationAdditionalCharges: Record "BLRAdditionalChargesSub")
    var
        InvoiceCreditNoteSummaryRec: Record "BLRInvoiceCreditNoteSummary";
    begin
        InvoiceCreditNoteSummaryRec.SetRange("BLRContract No.", pTerminationAdditionalCharges."BLRContract ID");
        InvoiceCreditNoteSummaryRec.SetRange("BLRDescription", 'Termination Additional Charges');
        InvoiceCreditNoteSummaryRec.SetRange("BLRRevenue Description", pTerminationAdditionalCharges."BLRSecondary Item Type");
        if InvoiceCreditNoteSummaryRec.FindFirst() then begin
            InvoiceCreditNoteSummaryRec."BLRInvoice" := pTerminationAdditionalCharges."BLRAmount Including VAT";
            InvoiceCreditNoteSummaryRec.Modify(true);
        end
        else begin
            Clear(InvoiceCreditNoteSummaryRec);
            InvoiceCreditNoteSummaryRec.Init();
            InvoiceCreditNoteSummaryRec."BLRContract No." := pTerminationAdditionalCharges."BLRContract ID";
            InvoiceCreditNoteSummaryRec."BLRDescription" := 'Termination Additional Charges';
            InvoiceCreditNoteSummaryRec."BLRRevenue Description" := pTerminationAdditionalCharges."BLRSecondary Item Type";
            InvoiceCreditNoteSummaryRec."BLRInvoice" := pTerminationAdditionalCharges."BLRAmount Including VAT";
            InvoiceCreditNoteSummaryRec.Insert(true)
        end;
    end;

}
