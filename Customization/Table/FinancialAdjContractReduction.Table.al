table 73209624 "FinancialAdjContractReduction"
{
    DataClassification = CustomerContent;
    fields
    {

        field(73209575; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(73209576; "Contract No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(73209577; "Revenue Description"; Text[100])
        {
            DataClassification = CustomerContent;
            TableRelation = Item WHERE("Item type template" = const("Item Type Template Enum"::"Secondary Item"));
            trigger OnValidate()
            var
                SecondaryItemRec: Record "Item";
            begin
                // Check if a record with the selected Secondary Item Type exists
                SecondaryItemRec.SetRange("No.", Rec."Revenue Description");
                if SecondaryItemRec.FindFirst() then begin
                    "Revenue Description" := SecondaryItemRec.Description;
                    // Retrieve the VAT % from the Secondary Item record
                    "VAT %" := SecondaryItemRec."VAT %";
                end else
                    // Clear the VAT % field if no matching record is found
                    "VAT %" := 0;
            end;

        }
        field(73209578; Amount; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 2;
            trigger OnValidate()
            begin
                CalcVATAndTotal();
            end;
        }
        field(73209579; "VAT %"; Option)
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
        field(73209580; "Amount Incl. VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 2;
        }
        field(73209581; "Description"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(73209582; Total; Decimal)
        {
            FieldClass = FlowField;
            DecimalPlaces = 0 : 2;
            CalcFormula = sum(FinancialAdjContractReduction."Amount" where("Contract No." = field("Contract No.")));
        }
        field(73209583; "Total VAT"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum(FinancialAdjContractReduction."VAT Amount" where("Contract No." = field("Contract No.")));
        }
        field(73209584; "Total Amount Incl.VAT"; Decimal)
        {
            FieldClass = FlowField;
            DecimalPlaces = 0 : 2;
            CalcFormula = sum(FinancialAdjContractReduction."Amount Incl. VAT" where("Contract No." = field("Contract No.")));
        }
        field(73209585; "VAT Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Amount';
            Editable = false;

            trigger OnValidate()
            var
                vatPer: Integer;
            begin
                if "VAT %" = "VAT %"::"5%" then
                    vatPer := 5
                else
                    vatPer := 0;

                "VAT Amount" := Amount * (vatPer / 100);
            end;
        }
        field(73209586; "Credit Note ID"; Code[50])
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Entry No.", "Contract No.")
        {
            Clustered = true;
        }
    }
    local procedure CalcVATAndTotal()
    var
        InvoiceCreditNoteSummaryRec: Record "InvoiceCreditNoteSummary";
        finalCalculation: Record "Final Calculation";
        vatPer: Integer;
    begin
        if "VAT %" = "VAT %"::"5%" then
            vatPer := 5
        else
            vatPer := 0;

        "VAT Amount" := Amount * (vatPer / 100);
        "Amount Incl. VAT" := Amount + "VAT Amount";
        Rec.Modify();

        InvoiceCreditNoteSummaryRec.CalculateInvoiceCreditNoteSummary(Rec);

        finalCalculation.SetRange("Contract ID", Rec."Contract No.");
        if finalCalculation.FindFirst() then
            finalCalculation.CalculateFinalSummary(finalCalculation);
    end;

    trigger OnDelete()
    var
        finalcalculationRec: Record "Final Calculation";
        InvoiceCreditNoteSummaryRec: Record "InvoiceCreditNoteSummary";
    begin
        finalcalculationRec.SetRange("Contract ID", Rec."Contract No.");
        if finalcalculationRec.FindFirst() then begin
            finalcalculationRec."Total Claim" -= Rec."Amount Incl. VAT";
            finalcalculationRec."Summery Net Balance" := finalcalculationRec."Total Claim" - finalcalculationRec."Total Refund";

            finalcalculationRec."Amount Refundable" := 0;
            finalcalculationRec."Net Receivable From The Tenant" := 0;
            if finalcalculationRec."Summery Net Balance" < 0 then begin
                finalcalculationRec."Amount Refundable" := Abs(finalcalculationRec."Summery Net Balance");
                finalcalculationRec."Net Receivable From The Tenant" := 0;
            end
            else
                finalcalculationRec."Net Receivable From The Tenant" := finalcalculationRec."Summery Net Balance";

            finalcalculationRec.Modify();

        end;

        InvoiceCreditNoteSummaryRec.SetRange("Contract No.", Rec."Contract No.");
        InvoiceCreditNoteSummaryRec.SetRange("Description", 'Finanacial Adjustments / Contract Reductions');
        InvoiceCreditNoteSummaryRec.SetRange("Revenue Description", Rec."Revenue Description");
        if InvoiceCreditNoteSummaryRec.FindFirst() then
            InvoiceCreditNoteSummaryRec.Delete();
    end;
}
