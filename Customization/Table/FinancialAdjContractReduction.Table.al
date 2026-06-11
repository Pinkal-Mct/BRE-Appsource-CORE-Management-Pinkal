table 73209624 "BLRFinAdjContractReduction"
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
        field(73209577; "BLRRevenue Description"; Text[100])
        {
            DataClassification = CustomerContent;
            TableRelation = Item WHERE("BLRItem type template" = const("BLRItem Type Template Enum"::"Secondary Item"));
            trigger OnValidate()
            var
                SecondaryItemRec: Record "Item";
            begin
                // Check if a record with the selected Secondary Item Type exists
                SecondaryItemRec.SetRange("No.", Rec."BLRRevenue Description");
                if SecondaryItemRec.FindFirst() then begin
                    "BLRRevenue Description" := SecondaryItemRec.Description;
                    // Retrieve the "BLRVAT %" from the Secondary Item record
                    "BLRVAT %" := SecondaryItemRec."BLRVAT %";
                end else
                    // Clear the "BLRVAT %" field if no matching record is found
                    "BLRVAT %" := 0;
            end;

        }
        field(73209578; "BLRAmount"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 2;
            trigger OnValidate()
            begin
                CalcVATAndTotal();
            end;
        }
        field(73209579; "BLRVAT %"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "0%","5%";
            Caption = 'VAT';
            Editable = false;
            trigger OnValidate()
            begin
                CalcVATAndTotal();
            end;
        }
        field(73209580; "BLRAmount Incl. VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 2;
        }
        field(73209581; "BLRDescription"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209582; "BLRTotal"; Decimal)
        {
            FieldClass = FlowField;
            DecimalPlaces = 0 : 2;
            CalcFormula = sum("BLRFinAdjContractReduction"."BLRAmount" where("BLRContract No." = field("BLRContract No.")));
        }
        field(73209583; "BLRTotal VAT"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("BLRFinAdjContractReduction"."BLRVAT Amount" where("BLRContract No." = field("BLRContract No.")));
        }
        field(73209584; "BLRTotal Amount Incl.VAT"; Decimal)
        {
            FieldClass = FlowField;
            DecimalPlaces = 0 : 2;
            CalcFormula = sum("BLRFinAdjContractReduction"."BLRAmount Incl. VAT" where("BLRContract No." = field("BLRContract No.")));
        }
        field(73209585; "BLRVAT Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Amount';
            Editable = false;

            trigger OnValidate()
            var
                vatPer: Integer;
            begin
                if "BLRVAT %" = "BLRVAT %"::"5%" then
                    vatPer := 5
                else
                    vatPer := 0;

                "BLRVAT Amount" := "BLRAmount" * (vatPer / 100);
            end;
        }
        field(73209586; "BLRCredit Note ID"; Code[50])
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "BLREntry No.", "BLRContract No.")
        {
            Clustered = true;
        }
    }
    local procedure CalcVATAndTotal()
    var
        InvoiceCreditNoteSummaryRec: Record "BLRInvoiceCreditNoteSummary";
        finalCalculation: Record "BLRFinalCalculation";
        vatPer: Integer;
    begin
        if "BLRVAT %" = "BLRVAT %"::"5%" then
            vatPer := 5
        else
            vatPer := 0;

        "BLRVAT Amount" := "BLRAmount" * (vatPer / 100);
        "BLRAmount Incl. VAT" := "BLRAmount" + "BLRVAT Amount";
        Rec.Modify();

        InvoiceCreditNoteSummaryRec.CalculateInvoiceCreditNoteSummary(Rec);

        finalCalculation.SetRange("BLRContract ID", Rec."BLRContract No.");
        if finalCalculation.FindFirst() then
            finalCalculation.CalculateFinalSummary(finalCalculation);
    end;

    trigger OnDelete()
    var
        finalcalculationRec: Record "BLRFinalCalculation";
        InvoiceCreditNoteSummaryRec: Record "BLRInvoiceCreditNoteSummary";
    begin
        finalcalculationRec.SetRange("BLRContract ID", Rec."BLRContract No.");
        if finalcalculationRec.FindFirst() then begin
            finalcalculationRec."BLRTotal Claim" -= Rec."BLRAmount Incl. VAT";
            finalcalculationRec."BLRSummery Net Balance" := finalcalculationRec."BLRTotal Claim" - finalcalculationRec."BLRTotal Refund";

            finalcalculationRec."BLRAmount Refundable" := 0;
            finalcalculationRec."BLRNetRecvFromTheTenant" := 0;
            if finalcalculationRec."BLRSummery Net Balance" < 0 then begin
                finalcalculationRec."BLRAmount Refundable" := Abs(finalcalculationRec."BLRSummery Net Balance");
                finalcalculationRec."BLRNetRecvFromTheTenant" := 0;
            end
            else
                finalcalculationRec."BLRNetRecvFromTheTenant" := finalcalculationRec."BLRSummery Net Balance";

            finalcalculationRec.Modify();

        end;

        InvoiceCreditNoteSummaryRec.SetRange("BLRContract No.", Rec."BLRContract No.");
        InvoiceCreditNoteSummaryRec.SetRange("BLRDescription", 'Finanacial Adjustments / Contract Reductions');
        InvoiceCreditNoteSummaryRec.SetRange("BLRRevenue Description", Rec."BLRRevenue Description");
        if InvoiceCreditNoteSummaryRec.FindFirst() then
            InvoiceCreditNoteSummaryRec.Delete();
    end;
}
